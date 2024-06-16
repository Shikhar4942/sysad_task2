# server/server.py
from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

# Database configuration
db_config = {
    'user': 'user',
    'password': 'password',
    'host': 'db',
    'database': 'taskdb'
}

@app.route('/users', methods=['POST'])
def add_user():
    data = request.json
    username = data.get('username')
    email = data.get('email')

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO users (username, email) VALUES (%s, %s)", (username, email))
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"message": "User added"}), 201

@app.route('/domains', methods=['POST'])
def add_domain():
    data = request.json
    domain_name = data.get('domain_name')

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO domains (name) VALUES (%s)", (domain_name,))
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"message": "Domain added"}), 201

@app.route('/tasks', methods=['POST'])
def add_task():
    data = request.json
    user_id = data.get('user_id')
    domain_id = data.get('domain_id')
    description = data.get('description')
    due_date = data.get('due_date')

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO tasks (user_id, domain_id, description, due_date) VALUES (%s, %s, %s, %s)", (user_id, domain_id, description, due_date))
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"message": "Task added"}), 201

@app.route('/submissions', methods=['POST'])
def add_submission():
    data = request.json
    task_id = data.get('task_id')

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO submissions (task_id) VALUES (%s)", (task_id,))
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"message": "Submission added"}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
