from flask import Flask, request, render_template_string
import psycopg2, os

app = Flask(__name__)

db_url = os.environ.get("DATABASE_URL")

def get_db_conn():
    return psycopg2.connect(db_url)

@app.route("/", methods=["GET", "POST"])
def index():
    conn = get_db_conn()
    cur = conn.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS notes(id SERIAL PRIMARY KEY, content TEXT)")
    conn.commit()
    if request.method == "POST":
        note = request.form["note"]
        cur.execute("INSERT INTO notes(content) VALUES (%s)", (note,))
        conn.commit()
    cur.execute("SELECT * FROM notes")
    notes = cur.fetchall()
    cur.close()
    conn.close()
    return render_template_string("""
        <h1>Notes App</h1>
        <form method="POST">
            <input name="note" placeholder="Write a note">
            <button type="submit">Save</button>
        </form>
        <ul>
        {% for id, note in notes %}
            <li>{{note}}</li>
        {% endfor %}
        </ul>
    """, notes=notes)
