from flask import Blueprint, render_template, redirect, url_for, request, flash
from connect import create_connection

routes = Blueprint('routes', __name__)

def fetch_table_data(table_name, page=1, per_page=10):
    offset = (page - 1) * per_page
    conn = create_connection()

    if conn:
        cursor = conn.cursor()

        try:
            valid_tables = ['Mobil', 'Pelanggan', 'Karyawan', 'Pemesanan', 'Pembayaran']
            if table_name not in valid_tables:
                flash('Invalid table name', 'danger')
                return None, 0

            cursor.execute(f'''
                SELECT * FROM {table_name}
                ORDER BY (SELECT NULL)
                OFFSET ? ROWS
                FETCH NEXT ? ROWS ONLY
            ''', (offset, per_page))

            table_data = cursor.fetchall()
            cursor.execute(f'SELECT COUNT(*) FROM {table_name}')
            total_count = cursor.fetchone()[0]
            total_pages = (total_count + per_page - 1) // per_page

            return table_data, total_pages

        except Exception as e:
            flash(f'Error fetching table data: {str(e)}', 'danger')
            return None, 0

        finally:
            cursor.close()
            conn.close()

    return None, 0

def get_primary_key_column(table_name):
    pk_columns = {
        'Mobil': 'plat_nomor',
        'Pelanggan': 'id_pelanggan',
        'Karyawan': 'id_karyawan',
        'Pemesanan': 'id_pemesanan',
        'Pembayaran': 'id_pembayaran'
    }
    return pk_columns.get(table_name, 'id')

@routes.route('/')
def index():
    tables = ['Mobil', 'Pelanggan', 'Karyawan', 'Pemesanan', 'Pembayaran']
    return render_template('home.html', tables=tables)

@routes.route('/table/<table_name>')
def view_table(table_name):
    page = request.args.get('page', 1, type=int)
    table, total_pages = fetch_table_data(table_name, page)

    if table:
        conn = create_connection()
        cursor = conn.cursor()
        cursor.execute(f"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '{table_name}'")
        columns = [column[0] for column in cursor.fetchall()]
        conn.close()

        return render_template('table_view.html', 
                               table=table, 
                               columns=columns,
                               total_pages=total_pages, 
                               current_page=page, 
                               table_name=table_name)

    return redirect(url_for('routes.index'))

@routes.route('/table/<table_name>/create', methods=['GET', 'POST'])
def create_table_entry(table_name):
    valid_tables = ['Mobil', 'Pelanggan', 'Karyawan', 'Pemesanan', 'Pembayaran']
    if table_name not in valid_tables:
        flash('Invalid table name', 'danger')
        return redirect(url_for('routes.index'))

    conn = create_connection()
    cursor = conn.cursor()

    pelanggan_list, mobil_list, supir_list, pemesanan_list, kasir_list = [], [], [], [], []
    try:
        if table_name == 'Pemesanan':
            cursor.execute('SELECT id_pelanggan, nama FROM Pelanggan')
            pelanggan_list = cursor.fetchall()
            cursor.execute('SELECT id_mobil, merk, model FROM Mobil WHERE status_rental = "Tersedia"')
            mobil_list = cursor.fetchall()
            cursor.execute('SELECT id_karyawan, nama FROM Karyawan WHERE jabatan = "Supir"')
            supir_list = cursor.fetchall()
        elif table_name == 'Pembayaran':
            cursor.execute('SELECT id_pemesanan FROM Pemesanan')
            pemesanan_list = cursor.fetchall()
            cursor.execute('SELECT id_karyawan, nama FROM Karyawan WHERE jabatan = "Kasir"')
            kasir_list = cursor.fetchall()

    except Exception as e:
        flash(f'Error preparing dropdown lists: {str(e)}', 'danger')

    if request.method == 'POST':
        try:
            form_data = request.form.to_dict()

            if 'id_supir' in form_data and not form_data['id_supir']:
                del form_data['id_supir']
            if 'harga_supir_perhari' in form_data and not form_data['harga_supir_perhari']:
                del form_data['harga_supir_perhari']

            columns = list(form_data.keys())
            placeholders = ', '.join(['?' for _ in columns])
            column_names = ', '.join(columns)
            values = tuple(form_data.values())

            cursor.execute(f'INSERT INTO {table_name} ({column_names}) VALUES ({placeholders})', values)
            conn.commit()
            flash(f'{table_name} entry added successfully!', 'success')
            return redirect(url_for('routes.view_table', table_name=table_name))

        except Exception as e:
            conn.rollback()
            flash(f'Error adding entry: {str(e)}', 'danger')

        finally:
            conn.close()

    return render_template('create_table_entry.html', 
                           table_name=table_name, 
                           pelanggan_list=pelanggan_list,
                           mobil_list=mobil_list,
                           supir_list=supir_list,
                           pemesanan_list=pemesanan_list,
                           kasir_list=kasir_list)

@routes.route('/table/<table_name>/edit/<string:id>', methods=['GET', 'POST'])
def edit_table_entry(table_name, id):
    valid_tables = ['Mobil', 'Pelanggan', 'Karyawan', 'Pemesanan', 'Pembayaran']
    if table_name not in valid_tables:
        flash('Invalid table name', 'danger')
        return redirect(url_for('routes.index'))

    conn = create_connection()
    cursor = conn.cursor()

    try:
        pk_column = get_primary_key_column(table_name)

        cursor.execute(f"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '{table_name}'")
        columns = [column[0] for column in cursor.fetchall()]

        cursor.execute(f'SELECT * FROM {table_name} WHERE {pk_column} = ?', (id,))
        data = cursor.fetchone()

        if not data:
            flash('Entry not found', 'danger')
            return redirect(url_for('routes.view_table', table_name=table_name))

        pelanggan_list, mobil_list, supir_list, pemesanan_list, kasir_list = [], [], [], [], []
        try:
            if table_name == 'Pemesanan':
                cursor.execute('SELECT id_pelanggan, nama FROM Pelanggan')
                pelanggan_list = cursor.fetchall()
                cursor.execute('SELECT id_mobil, merk, model FROM Mobil WHERE status_rental = "Tersedia"')
                mobil_list = cursor.fetchall()
                cursor.execute('SELECT id_karyawan, nama FROM Karyawan WHERE jabatan = "Supir"')
                supir_list = cursor.fetchall()
            elif table_name == 'Pembayaran':
                cursor.execute('SELECT id_pemesanan FROM Pemesanan')
                pemesanan_list = cursor.fetchall()
                cursor.execute('SELECT id_karyawan, nama FROM Karyawan WHERE jabatan = "Kasir"')
                kasir_list = cursor.fetchall()
        except Exception as e:
            flash(f'Error preparing dropdown lists: {str(e)}', 'danger')

        if request.method == 'POST':
            form_data = request.form.to_dict()

            form_data = {k: v for k, v in form_data.items() if v}

            set_clauses = ', '.join([f"{key} = ?" for key in form_data.keys()])
            values = tuple(list(form_data.values()) + [id])

            cursor.execute(f'UPDATE {table_name} SET {set_clauses} WHERE id = ?', values)
            conn.commit()

            flash(f'{table_name} entry updated successfully!', 'success')
            return redirect(url_for('routes.view_table', table_name=table_name))

        data_dict = dict(zip(columns, data))

        return render_template('edit_table_entry.html', 
                               table_name=table_name, 
                               data=data_dict,
                               columns=columns,
                               pelanggan_list=pelanggan_list,
                               mobil_list=mobil_list,
                               supir_list=supir_list,
                               pemesanan_list=pemesanan_list,
                               kasir_list=kasir_list)

    except Exception as e:
        flash(f'Error processing edit: {str(e)}', 'danger')
        return redirect(url_for('routes.view_table', table_name=table_name))

@routes.route('/table/<table_name>/delete/<string:id>', methods=['POST'])
def delete_table_entry(table_name, id):
    valid_tables = ['Mobil', 'Pelanggan', 'Karyawan', 'Pemesanan', 'Pembayaran']
    if table_name not in valid_tables:
        flash('Invalid table name', 'danger')
        return redirect(url_for('routes.index'))

    conn = create_connection()
    cursor = conn.cursor()

    try:
        pk_column = get_primary_key_column(table_name)

        cursor.execute(f'DELETE FROM {table_name} WHERE {pk_column} = ?', (id,))
        conn.commit()

        flash(f'{table_name} entry deleted successfully!', 'success')
        return redirect(url_for('routes.view_table', table_name=table_name))

    except Exception as e:
        conn.rollback()
        flash(f'Error deleting entry: {str(e)}', 'danger')
        return redirect(url_for('routes.view_table', table_name=table_name))

    finally:
        conn.close()
