import requests
from flask import Flask
from flask import jsonify
from flask import request, render_template
from flask_cors import CORS
import psycopg2
from psycopg2.extras import RealDictCursor

from flask_jwt_extended import create_access_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_jwt_extended import JWTManager

app = Flask(__name__)
CORS(app)
app.config["SECRET_KEY"] = "super-secret"  # Change this!
jwt = JWTManager(app)

def get_db_connection():
    conn = psycopg2.connect(host='localhost',
                            database='query1',
                            user='postgres',
                            password='dina')
    return conn

@app.route('/')
def homeLogin():
    return render_template('form.html')

@app.route('/login_form')
def loginForm():
    return render_template('form.html')

@app.route("/login_json", methods=["POST"])
def login():
	username = request.json.get('username')
	password = request.json.get('password')
	print('username: ', username)
	print('password: ', password)
	
	conn = get_db_connection()
	cur = conn.cursor()
	strQuery = "SELECT * FROM users.peran_user t1 where t1.nama_user='%s' and t1.password='%s';" % (username, password)
	print('strQuery: ',strQuery)
	cur.execute(strQuery)
	user = cur.fetchall()
	
	count = len(user)
	print('count: ', count)
	
	if count > 0:
		access_token = create_access_token(identity=username)
		print('access_token: ', access_token)
		# ~ return jsonify(access_token=access_token)
		return jsonify({"msg": access_token, 'berhasil':1}), 200
		
		
	print('Failed...')
	return jsonify({"msg": "Bad username or password", 'success':0})

# Protect a route with jwt_required, which will kick out requests
# without a valid JWT present.
@app.route("/protected/", methods=["POST"])
@jwt_required()
def protected():
    # Access the identity of the current user with get_jwt_identity
    current_user = get_jwt_identity()
    return jsonify(logged_in_as=current_user), 200

@app.route("/data_user/", methods=["POST"])
@jwt_required()
def data_user():
	conn = get_db_connection()
	cur = conn.cursor()
	strQuery = "select t1.* from users.peran_user t1"
	print('strQuery: ',strQuery)
	cur = conn.cursor(cursor_factory=RealDictCursor)
	cur.execute(strQuery)
	users = cur.fetchall()
	
	print('users: ', users)
	count = len(users)
	print('count: ', count)
	cur.close()
	conn.close()
	
	data = {'data_users': users, 'success':1}
	print('data: ', data)
	return jsonify(data), 200

@app.route("/data_produk/", methods=["POST"])
@jwt_required()
def data_produk():
	conn = get_db_connection()
	cur = conn.cursor()
	strQuery = "select * from users.produk"
	print('strQuery: ',strQuery)
	cur = conn.cursor(cursor_factory=RealDictCursor)
	cur.execute(strQuery)
	produk = cur.fetchall()
	
	print('produk: ', produk)
	count = len(produk)
	print('count: ', count)
	cur.close()
	conn.close()
	
	data = {'data_produk': produk, 'success':1}
	print('data: ', data)
	return jsonify(data), 200

@app.route('/add_produk/', methods=['POST'])
@jwt_required()
def add_produk():
	
    conn = get_db_connection()
    cur = conn.cursor()

    # Get the data from the request
    nama_barang = request.json.get('nama_barang')
    deskripsi = request.json.get('deskripsi')
    harga = request.json.get('harga')
    stok = request.json.get('stok')
    url_gambar = request.json.get('url_gambar')

    # Insert the new product into the database
    strQuery = "INSERT INTO users.produk (nama_barang, deskripsi, harga, stok, url_gambar) VALUES (%s, %s, %s, %s, %s)"
    print('strQuery: ',strQuery)
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute(strQuery, (nama_barang, deskripsi, harga, stok, url_gambar))
    conn.commit()

    cur.close()
    conn.close()

    return jsonify({"message": "Product added successfully", "success": 1})


@app.route('/delete_produk/<int:id>', methods=['DELETE'])
@jwt_required()
def delete_produk(id):
    conn = get_db_connection()
    cur = conn.cursor()
    strQuery = "DELETE FROM users.produk WHERE id=%s"
    cur.execute(strQuery, (id,))
    conn.commit()
    cur.close()
    conn.close()
    return jsonify({'message': 'Product deleted successfully.'}), 200

@app.route('/get_produk/<int:id>/', methods=['GET'])
@jwt_required()
def get_produk(id):
    conn = get_db_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)

    # Query the database for the product with the specified ID
    strQuery = "SELECT * FROM users.produk WHERE id = %s"
    cur.execute(strQuery, (id,))

    # Get the product data
    data = cur.fetchone()

    cur.close()
    conn.close()

    # Return the product data as JSON
    return jsonify({"data": data})


@app.route('/update_produk/<int:id>', methods=['PUT'])
@jwt_required()
def update_produk(id):
    nama_barang = request.json['nama_barang']
    deskripsi = request.json['deskripsi']
    harga = request.json['harga']
    stok = request.json['stok']
    url_gambar = request.json['url_gambar']
    conn = get_db_connection()
    cur = conn.cursor()
    strQuery = "UPDATE users.produk SET nama_barang=%s, deskripsi=%s, harga=%s, stok=%s, url_gambar=%s WHERE id=%s"
    cur.execute(strQuery, (nama_barang, deskripsi, harga, stok, url_gambar, id))
    conn.commit()
    cur.close()
    conn.close()
    data = {'message': 'Produk updated successfully', 'success': 1}
    return jsonify(data), 200

if __name__ == "__main__":
    app.run(host='0.0.0.0')
