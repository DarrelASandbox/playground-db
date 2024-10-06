import psycopg2
import hidden

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

sql = "DROP TABLE IF EXISTS pythonseq CASCADE;"
print(sql)
cur.execute(sql)

sql = "CREATE TABLE pythonseq(iter integer, val integer);"
print(sql)
cur.execute(sql)

conn.commit()

number = 996592
for i in range(300):
    val = number
    sql = "INSERT INTO pythonseq (iter, val) VALUES (%s, %s);"
    cur.execute(sql, (i + 1, val))
    number = int((number * 22) / 7) % 1000000

conn.commit()
print("300 pseudorandom numbers have been inserted successfully.")

cur.close()
conn.close()
