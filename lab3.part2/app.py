from flask import Flask, request, jsonify
import psycopg2                        # to connect with database 
from config import db_params           # parameters to connect to database
# from price import Price

app = Flask(__name__)                  # instantiating a Flask class

connection = psycopg2.connect(**db_params)   # establishing connection to database
cursor = connection.cursor()                    # creating a cursor


# GET ALL PRICES
@app.route('/api/price', methods=['GET'])
def get_all_prices():
    with connection:                        
        with connection.cursor() as cursor:          # represents a database cursor
            cursor.execute("SELECT * FROM price;")   # used to execute SQL queries on a PostgreSQL database
            prices = cursor.fetchall()                    # retrieves all the rows of the most recently executed query
            if prices:
                result = []                               # creating a list
                for price in prices:                      # for loop
                    result.append({"id": price[0],        # appends price to the end of result list
                                "supplier_id": price[1], 
                                "supplier_price": price[2], 
                                "sup_date": price[3], 
                                "woodtype_id": price[4]})
                return jsonify(result)                    # converts the result list into a JSON
            else:
                return jsonify({"Error while executing get_all_prices": f"Prices were not found. "}), 404


# GET PRICE BY ID
@app.route('/api/price/<int:pr_id>', methods=['GET'])    # decorator, path, type of http request
def get_price_by_id(pr_id):                                                    
    with connection:
        with connection.cursor() as cursor:                       # represents a database cursor
            cursor.execute("SELECT * FROM price WHERE id = %s", (pr_id,))   # used to execute SQL queries on a PostgreSQL database
            price = cursor.fetchone()
            if price: 
                return jsonify({"id": price[0],                   # converts the prices variable (list or dictionary) into a JSON
                                "supplier_id": price[1], 
                                "supplier_price": price[2], 
                                "sup_date": price[3], 
                                "woodtype_id": price[4]})
            else:
                return jsonify({"Error while executing get_price_by_id": f"Price with ID {pr_id} not found. "}), 404


# UPDATE PRICE BY ID
@app.route('/api/price/<int:pr_id>', methods=['PUT'])
def update_price_by_id(pr_id):
    data = request.get_json()                # get JSON data from current request using flask
    supplier_id = data["supplier_id"]        # extracting value that is asociated wirh the key "supplier_id"
    supplier_price = data["supplier_price"]
    sup_date = data["sup_date"]
    woodtype_id = data["woodtype_id"]
    with connection:
        with connection.cursor() as cursor:                # represents a database cursor
            cursor.execute("CALL UPDATE_PRICE_BY_ID(%s, %s, %s, %s, %s);",    # calls procedure
                           (pr_id, supplier_id, supplier_price, sup_date, woodtype_id))   # arguments for this procedure
            if cursor.rowcount == 0:                                                      # if table is empty -> you can't update any roe
                return jsonify({"Error while executing update_price_by_id": f"Price with ID {pr_id} not found."}), 404
    return jsonify({"id": pr_id,                            # converts the prices variable (list or dictionary) into a JSON
                    "supplier_id": supplier_id,
                    "supplier_price": supplier_price, 
                    "sup_date": sup_date, 
                    "woodtype_id": woodtype_id,
                    "Message (not included in database)": f"Price with ID {pr_id} was successfully updated."})


# ADD(POST) NEW PRICE
INSERT_PRICE_RETURN_ID = "INSERT INTO price (supplier_id, supplier_price, sup_date, woodtype_id) VALUES (%s, %s, %s, %s) RETURNING id;"
@app.route('/api/price', methods=['POST'])
def add_new_price():
    data = request.get_json()                # get JSON data from current request using flask
    supplier_id = data["supplier_id"]        # extracting value that is asociated wirh the key "supplier_id"
    supplier_price = data["supplier_price"]
    sup_date = data["sup_date"]
    woodtype_id = data["woodtype_id"]
    with connection:
        with connection.cursor() as cursor:         # represents a database cursor
            cursor.execute(INSERT_PRICE_RETURN_ID, (supplier_id, supplier_price, sup_date, woodtype_id))
            pr_id = cursor.fetchone()[0]            # retrieve the first row of a query result set returned by the most recent SELECT statement executed using the cursor
    return {"id": pr_id,                            # return an array, JSON
                    "supplier_id": supplier_id,
                    "supplier_price": supplier_price, 
                    "sup_date": sup_date, 
                    "woodtype_id": woodtype_id,
                    "Message (not included in database)": f"Price with ID {pr_id} was successfully created."}, 201


# DELETE PRICE BY ID
@app.route('/api/price/<int:pr_id>', methods=['DELETE'])
def delete_price_by_id(pr_id):
    with connection:
        with connection.cursor() as cursor:
            cursor.execute("CALL DELETE_PRICE_BY_ID(%s);", (pr_id,))
            if cursor.rowcount == 0:
                return jsonify({"Error while executing delete_price_by_id": f"Price with ID {pr_id} not found."}), 404
    return jsonify({"Message (not included in database)": f"Price with ID {pr_id} was successfully deleted."})



# if __name__ == '__main__':
#     app.run(debug=True)
