import json
import requests
import psycopg2
import pandas as pd
from tabulate import tabulate



def ask_myai(user_inp):
    query = f"""
            You are a private AI that MUST return ONLY valid JSON.

RULES:
1. Output must be a pure JSON object (no surrounding text, headings, or code fences).
2. NO backticks. NO markdown. NO code fences.
3. JSON format:
{{ "query": "<SQL_QUERY>" }}
4. No explanations or extra text. If anything outside the JSON appears, correct yourself and return only the JSON object.
5. Use only the tables and column names from this schema. If the user's request cannot be satisfied by this schema, return an empty SQL string: {{ "query": "" }}


Database Schema:

students table:
- id (INT PRIMARY KEY)
- name (TEXT)
- department (TEXT)
- year (INT)
- phone_number (INT)

marks table:
- id (INT PRIMARY KEY)
- student_id (INT) → references students.id
- subject (TEXT)
- score (INT)

events table:
- event_id (INT PRIMARY KEY)
- event_name (TEXT)
- date (DATE)
- location (TEXT)

First, rewrite the schema in your own understanding (privately).
Then use that rewritten understanding to generate the SQL query.

remember sometimes you will need to consider two or multiple tables together they shall be so dynamic based on the given input

User Input:
{user_inp}

IMPORTANT: Do NOT wrap the JSON in any code fences. The output must start with {{ and end with }} only.
"""

    url = "https://myclassai.myclass189.workers.dev/"

    headers = {
        "Authorization": "Bearer 12345678",
        "Content-Type": "application/json",
    }

    data = {
        "prompt": query,
    }

    response = requests.post(url, headers=headers, json=data)
    res = json.loads(response.text)
    sec = res['response']
    result = sec['query']
    print(f"*******************************{result}")
    return result




def myai_natural_output(inputq: str, query: str, relevantdata):
    prompt = f"""
        You are an answer-generation tool. Given the user's question, the SQL used, and the relevant DB rows,
generate one concise English sentence that answers the user's question using the relevant data.

Do NOT include JSON or code fences. Do not explain the SQL. Output must be one sentence only.

User question: {inputq}
SQL used: {query}
Relevant data (first 20 rows shown): {relevantdata}
"""

    url = "https://myclassai.myclass189.workers.dev/"

    headers = { 
        "Authorization": "Bearer 12345678",
        "Content-Type": "application/json",
    }

    data = {
        "prompt": prompt,
    }

    response = requests.post(url, headers=headers, json=data)
    res = json.loads(response.text)
    rea = res['response']
    print(f"*******************************{rea}")
    return rea





# --------------------------
# PostgreSQL runner (safe)
# --------------------------
def run_query(query: str,
              host="localhost",
              database="postgres",
              user="postgres",
              password="admin",
              port=5432,
              readonly_only: bool = True):

    qstart = query.lstrip().split(None, 1)

    if not qstart:
        print("Empty query.")
        return None

    first_token = qstart[0].lower()

    allowed_readonly = {"select", "with"}

    if readonly_only and first_token not in allowed_readonly:
        print(f"Safety block: query starts with '{first_token}' which is not allowed in readonly mode.")
        return None

    conn = None
    cursor = None

    try:
        conn = psycopg2.connect(
            host=host,
            database=database,
            user=user,
            password=password,
            port=port
        )

        cursor = conn.cursor()
        cursor.execute(query)

        if first_token in {"select", "with"}:

            rows = cursor.fetchall()

            columns = [desc[0] for desc in cursor.description]

            df = pd.DataFrame(rows, columns=columns)

            print("\n================ QUERY RESULT ================\n")

            if df.empty:
                print("No records found.")
                return []

            print(
                tabulate(
                    df,
                    headers="keys",
                    tablefmt="grid",
                    showindex=False
                )
            )

            return df.head(20).to_dict(orient="records")

        else:
            conn.commit()
            print("Query executed and committed.")
            return None

    except Exception as e:
        print("Error executing query:", e)
        return None

    finally:
        if cursor:
            cursor.close()

        if conn:
            conn.close()



# --------------------------
# Example interactive flow
# --------------------------
while True:
    user_inp = input("Enter the question: ")

    # Build schema-aware prompt (same as you had but kept compact)

    # ask model
    raw = ask_myai(user_inp)
    print("Raw LLM output (for debugging):", raw)  # you can remove or comment out this line

    # sanitize & parse
    # sql_query = clean_output(raw)
    if not raw:
        print("No valid SQL to run. Exiting.")
    else:
        print("SQL to execute:", raw)
        # run safe (readonly only). Set readonly_only=False if you want to allow write statements.
        rows = run_query(raw, readonly_only=True)
        # produce natural answer
        answer = myai_natural_output(user_inp, raw, rows)
        print("\nNatural answer from LLM:")
        print(answer)
