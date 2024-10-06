import json

import hidden
import psycopg2
import requests

# Load the secrets
secrets = hidden.secrets()

conn = psycopg2.connect(
    host=secrets["host"],
    port=secrets["port"],
    database=secrets["database"],
    user=secrets["user"],
    password=secrets["pass"],
    connect_timeout=3,
)

cur = conn.cursor()

sql = "CREATE TABLE IF NOT EXISTS pokeapi (id INTEGER, body JSONB);"
print(sql)
cur.execute(sql)
conn.commit()

base_url = "https://pokeapi.co/api/v2/pokemon/"

for i in range(1, 101):
    url = f"{base_url}{i}"
    try:
        res = requests.get(url, timeout=10)
        if res.status_code == 200:
            data = res.json()
            json_data = json.dumps(data)
            sql = "INSERT INTO pokeapi (body) VALUES (%s);"
            cur.execute(sql, [json_data])
        else:
            print(f"Failed to fetch data for {url}, status code: {res.status_code}")
    except requests.exceptions.Timeout:
        print(f"Timeout occurred for {url}. Skipping...")
    except requests.exceptions.RequestException as e:
        print(f"An error occurred: {e}. Skipping {url}...")

conn.commit()
cur.close()
conn.close()
