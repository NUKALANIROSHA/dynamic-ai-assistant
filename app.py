import json
import requests
import psycopg2
import pandas as pd
import streamlit as st
import os
import re
from datetime import datetime

# ---------- PAGE CONFIG ----------
st.set_page_config(
    page_title="Dynamic AI Assistant",
    page_icon="🤖",
    layout="wide",
    initial_sidebar_state="expanded"
)

# ---------- SESSION STATE INITIALIZATION (MUST BE FIRST) ----------
if "messages" not in st.session_state:
    st.session_state.messages = []

# ---------- AI THEME CUSTOM CSS ----------
st.markdown("""
<style>
    .stApp {
        background: radial-gradient(ellipse at top left, #1A0B2E, #0D0A20 50%, #05050F 100%);
        background-attachment: fixed;
    }
    .css-1d391kg {
        background: linear-gradient(180deg, #1F0A3A 0%, #0B061A 100%) !important;
        border-right: 1px solid #2D1B4E !important;
    }
    .sidebar-title {
        color: #F0F6FC;
        font-size: 24px;
        font-weight: 700;
        padding: 10px 0;
        border-bottom: 2px solid #A855F7;
        margin-bottom: 20px;
        text-shadow: 0 0 30px rgba(168, 85, 247, 0.4);
    }
    .sidebar-item {
        color: #C4B5D4;
        padding: 8px 12px;
        border-radius: 6px;
        margin: 2px 0;
        cursor: default;
        transition: all 0.2s;
        border-left: 3px solid transparent;
    }
    .sidebar-item:hover {
        background-color: #2D1B4E;
        color: #F0F6FC;
        border-left-color: #06B6D4;
        transform: translateX(4px);
    }
    .section-label {
        color: #8B7AAB;
        font-size: 12px;
        text-transform: uppercase;
        letter-spacing: 1px;
        padding: 10px 0 5px 0;
        font-weight: 600;
    }
    .recent-chat-item {
        padding: 6px 12px;
        border-radius: 6px;
        margin: 2px 0;
        font-size: 14px;
        color: #A89BC0;
        border-left: 3px solid transparent;
        cursor: default;
        transition: all 0.2s;
    }
    .recent-chat-item:hover {
        background-color: #2D1B4E;
        border-left-color: #A855F7;
        color: #F0F6FC;
    }
    .recent-chat-time {
        color: #5A4A7A;
        font-size: 11px;
        float: right;
    }
    .user-profile {
        border-top: 1px solid #2D1B4E;
        padding-top: 15px;
        margin-top: 15px;
    }
    .user-name {
        font-weight: 600;
        color: #F0F6FC;
    }
    .user-email {
        color: #8B7AAB;
        font-size: 12px;
    }
    .stChatMessage {
        background-color: transparent !important;
    }
    .stChatMessage [data-testid="stChatMessageContent"] {
        background: linear-gradient(135deg, #1F0A3A, #2D1B4E) !important;
        border-radius: 18px 18px 4px 18px !important;
        padding: 12px 18px !important;
        border: 1px solid #3B2A5A !important;
        color: #F4F0FF !important;
        box-shadow: 0 4px 20px rgba(168, 85, 247, 0.15) !important;
    }
    .stChatMessage [data-testid="stChatMessageContent"]:has(.assistant) {
        background: linear-gradient(135deg, #0D0A20, #19162E) !important;
        border-radius: 18px 18px 18px 4px !important;
        border: 1px solid #2D1B4E !important;
        color: #F4F0FF !important;
        box-shadow: 0 4px 20px rgba(6, 182, 212, 0.1) !important;
    }
    .streamlit-expanderHeader {
        background: linear-gradient(90deg, #1A0B2E, #0D0A20) !important;
        border-radius: 8px !important;
        border: 1px solid #3B2A5A !important;
        color: #A855F7 !important;
        font-weight: 600 !important;
    }
    .streamlit-expanderContent {
        background-color: #0D0A20 !important;
        border-radius: 0 0 8px 8px !important;
        border: 1px solid #3B2A5A !important;
        border-top: none !important;
    }
    .stCodeBlock {
        background-color: #0D0A20 !important;
        border: 1px solid #2D1B4E !important;
        border-radius: 6px !important;
    }
    .dataframe {
        border-radius: 10px !important;
        overflow: hidden !important;
        border: 1px solid #2D1B4E !important;
    }
    .dataframe thead tr th {
        background: linear-gradient(90deg, #1F0A3A, #2D1B4E) !important;
        color: #A855F7 !important;
        font-weight: 600 !important;
        border-bottom: 2px solid #A855F7 !important;
    }
    .dataframe tbody tr td {
        background-color: #0D0A20 !important;
        color: #E6EDF3 !important;
        border-bottom: 1px solid #1F0A3A !important;
    }
    .dataframe tbody tr:hover td {
        background-color: #1A0B2E !important;
    }
    .stAlert {
        border-radius: 10px !important;
        border-left: 5px solid #06B6D4 !important;
        background: linear-gradient(90deg, #0D2818, #0B0A1A) !important;
        color: #B7E4C7 !important;
        border: 1px solid #06B6D4 !important;
    }
    .stAlert[data-baseweb="notification"] {
        border-radius: 10px !important;
        border-left: 5px solid #F43F5E !important;
        background: linear-gradient(90deg, #2D0A0A, #0B0A1A) !important;
        color: #F2A8A5 !important;
        border: 1px solid #F43F5E !important;
    }
    .stChatInputContainer {
        border-top: 1px solid #2D1B4E !important;
        background-color: transparent !important;
        padding-top: 10px !important;
    }
    .stChatInputContainer textarea {
        background-color: #16102E !important;
        border: 1px solid #3B2A5A !important;
        border-radius: 25px !important;
        color: #F4F0FF !important;
        padding: 12px 20px !important;
        box-shadow: 0 0 20px rgba(168, 85, 247, 0.1) !important;
    }
    .stChatInputContainer textarea:focus {
        border-color: #A855F7 !important;
        box-shadow: 0 0 30px rgba(168, 85, 247, 0.3) !important;
    }
    .main-header {
        color: #F0F6FC;
        font-size: 32px;
        font-weight: 800;
        background: linear-gradient(90deg, #A855F7, #06B6D4, #A855F7);
        background-size: 200% auto;
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        animation: shimmer 3s linear infinite;
        padding: 10px 0;
    }
    @keyframes shimmer {
        0% { background-position: 0% center; }
        100% { background-position: 200% center; }
    }
    .main-subheader {
        color: #8B7AAB;
        font-size: 15px;
        font-weight: 400;
        margin-top: -10px;
        padding-bottom: 20px;
        border-bottom: 1px solid #2D1B4E;
    }
    .stChatMessage .st-emotion-cache-1v3fvcr {
        font-size: 28px !important;
    }
</style>
""", unsafe_allow_html=True)

# ---------- BACKEND FUNCTIONS ----------
# def ask_myai(user_inp):
#     query = f"""
#             You are a private AI that MUST return ONLY valid JSON.

# RULES:
# 1. Output must be a pure JSON object (no surrounding text, headings, or code fences).
# 2. NO backticks. NO markdown. NO code fences.
# 3. JSON format:
# {{ "query": "<SQL_QUERY>" }}
# 4. No explanations or extra text. If anything outside the JSON appears, correct yourself and return only the JSON object.
# 5. Use only the tables and column names from this schema. If the user's request cannot be satisfied by this schema, return an empty SQL string: {{ "query": "" }}


# Database Schema:

# students table:
# - id (INT PRIMARY KEY)
# - name (TEXT)
# - department (TEXT)
# - year (INT)
# - phone_number (INT)

# marks table:
# - id (INT PRIMARY KEY)
# - student_id (INT) → references students.id
# - subject (TEXT)
# - score (INT)

# events table:
# - event_id (INT PRIMARY KEY)
# - event_name (TEXT)
# - date (DATE)
# - location (TEXT)

# First, rewrite the schema in your own understanding (privately).
# Then use that rewritten understanding to generate the SQL query.

# remember sometimes you will need to consider two or multiple tables together they shall be so dynamic based on the given input

# User Input:
# {user_inp}

# IMPORTANT: Do NOT wrap the JSON in any code fences. The output must start with {{ and end with }} only.
# """

#     url = "https://myclassai.myclass189.workers.dev/"
#     headers = {
#         "Authorization": "Bearer 12345678",
#         "Content-Type": "application/json",
#     }
#     data = {"prompt": query}

#     try:
#         response = requests.post(url, headers=headers, json=data)
#         res = json.loads(response.text)
#         sec = res['response']
#         result = sec['query']
#         return result
#     except Exception as e:
#         st.error(f"AI Error: {e}")
#         return ""
# def ask_myai(user_inp):
#     user_inp = user_inp.lower()
    
#     # ---------- TOP 5 (Department-wise) ----------
#     if "top" in user_inp and "civil" in user_inp:
#         return "SELECT * FROM students WHERE department ILIKE 'Civil Engineering' LIMIT 5;"
#     elif "top" in user_inp and ("information technology" in user_inp or " it" in user_inp):
#         return "SELECT * FROM students WHERE department ILIKE 'Information Technology' LIMIT 5;"
#     elif "top" in user_inp and ("computer science" in user_inp or "cse" in user_inp or "cs" in user_inp):
#         return "SELECT * FROM students WHERE department ILIKE 'Computer Science' LIMIT 5;"
#     elif "top" in user_inp and "electronics" in user_inp:
#         return "SELECT * FROM students WHERE department ILIKE 'Electronics' LIMIT 5;"
#     elif "top" in user_inp and "mechanical" in user_inp:
#         return "SELECT * FROM students WHERE department ILIKE 'Mechanical Engineering' LIMIT 5;"
    
#     # ---------- TOTAL / COUNT ----------
#     elif "total" in user_inp or "count" in user_inp or "how many" in user_inp:
#         return "SELECT COUNT(*) AS total_students FROM students;"
    
#     # ---------- ALL STUDENTS ----------
#     elif "all students" in user_inp or "show all" in user_inp:
#         return "SELECT * FROM students;"
    
#     # ---------- DEPARTMENT-WISE (All) ----------
#     elif "information technology" in user_inp or " it" in user_inp:
#         return "SELECT * FROM students WHERE department ILIKE 'Information Technology';"
#     elif "civil" in user_inp:
#         return "SELECT * FROM students WHERE department ILIKE 'Civil Engineering';"
#     elif "computer science" in user_inp or "cse" in user_inp or "cs" in user_inp:
#         return "SELECT * FROM students WHERE department ILIKE 'Computer Science';"
#     elif "electronics" in user_inp:
#         return "SELECT * FROM students WHERE department ILIKE 'Electronics';"
#     elif "mechanical" in user_inp:
#         return "SELECT * FROM students WHERE department ILIKE 'Mechanical Engineering';"
    
#     # ---------- EVENTS & MARKS ----------
#     elif "event" in user_inp:
#         return "SELECT * FROM events;"
#     elif "mark" in user_inp or "score" in user_inp:
#         return "SELECT * FROM marks;"
    
#     # ---------- DEFAULT ----------
#     else:
#         return "SELECT * FROM students;"
def ask_myai(user_inp):
    user_inp = user_inp.lower()
    
    # ---------- TOTAL / COUNT ----------
    if "total" in user_inp or "count" in user_inp or "how many" in user_inp:
        if "civil" in user_inp:
            return "SELECT COUNT(*) AS total FROM students WHERE department ILIKE 'Civil Engineering';"
        elif " it" in user_inp or "information technology" in user_inp:
            return "SELECT COUNT(*) AS total FROM students WHERE department ILIKE 'Information Technology';"
        elif "computer science" in user_inp or "cse" in user_inp:
            return "SELECT COUNT(*) AS total FROM students WHERE department ILIKE 'Computer Science';"
        elif "electronics" in user_inp:
            return "SELECT COUNT(*) AS total FROM students WHERE department ILIKE 'Electronics';"
        elif "mechanical" in user_inp:
            return "SELECT COUNT(*) AS total FROM students WHERE department ILIKE 'Mechanical Engineering';"
        elif "event" in user_inp:
            return "SELECT COUNT(*) AS total_events FROM events;"
        elif "mark" in user_inp or "score" in user_inp:
            return "SELECT COUNT(*) AS total_marks FROM marks;"
        else:
            return "SELECT COUNT(*) AS total_students FROM students;"
    
    # ---------- ALL / SHOW ALL ----------
    elif "all students" in user_inp or "show all" in user_inp:
        if "event" in user_inp:
            return "SELECT * FROM events;"
        elif "mark" in user_inp or "score" in user_inp:
            return "SELECT * FROM marks;"
        else:
            return "SELECT * FROM students;"
    
    # ---------- TOP 5 OVERALL ----------
    elif "top" in user_inp and "overall" in user_inp:
        return "SELECT s.name, s.department, SUM(m.score) AS total_marks FROM students s JOIN marks m ON s.id = m.student_id GROUP BY s.name, s.department ORDER BY total_marks DESC LIMIT 5;"
    
    # ---------- TOP 5 BY DEPARTMENT ----------
    elif "top" in user_inp and "civil" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Civil Engineering' LIMIT 5;"
    elif "top" in user_inp and ("information technology" in user_inp or " it" in user_inp):
        return "SELECT * FROM students WHERE department ILIKE 'Information Technology' LIMIT 5;"
    elif "top" in user_inp and ("computer science" in user_inp or "cse" in user_inp):
        return "SELECT * FROM students WHERE department ILIKE 'Computer Science' LIMIT 5;"
    elif "top" in user_inp and "electronics" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Electronics' LIMIT 5;"
    elif "top" in user_inp and "mechanical" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Mechanical Engineering' LIMIT 5;"
    
    # ---------- DEPARTMENT-WISE ----------
    elif "information technology" in user_inp or " it" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Information Technology';"
    elif "civil" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Civil Engineering';"
    elif "computer science" in user_inp or "cse" in user_inp or "cs" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Computer Science';"
    elif "electronics" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Electronics';"
    elif "mechanical" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Mechanical Engineering';"
    
    # ---------- YEAR-WISE ----------
    elif "first year" in user_inp:
        return "SELECT * FROM students WHERE year = 1;"
    elif "second year" in user_inp:
        return "SELECT * FROM students WHERE year = 2;"
    elif "third year" in user_inp:
        return "SELECT * FROM students WHERE year = 3;"
    elif "fourth year" in user_inp:
        return "SELECT * FROM students WHERE year = 4;"
    
    # ---------- NAME SEARCH ----------
    elif "starts with" in user_inp:
        letter = user_inp.split("starts with")[1].strip().upper()
        return f"SELECT * FROM students WHERE name ILIKE '{letter}%';"
    elif "ends with" in user_inp:
        word = user_inp.split("ends with")[1].strip()
        return f"SELECT * FROM students WHERE name ILIKE '%{word}';"
    elif "contains" in user_inp:
        word = user_inp.split("contains")[1].strip()
        return f"SELECT * FROM students WHERE name ILIKE '%{word}%';"
    
    # ---------- SORTING ----------
    elif "sorted by name" in user_inp:
        return "SELECT * FROM students ORDER BY name;"
    elif "sorted by department" in user_inp:
        return "SELECT * FROM students ORDER BY department;"
    elif "sorted by score" in user_inp:
        return "SELECT * FROM marks ORDER BY score DESC;"
    elif "sorted by date" in user_inp:
        return "SELECT * FROM events ORDER BY date;"
    
    # ---------- FIRST / LAST ----------
    elif "first 10" in user_inp:
        return "SELECT * FROM students LIMIT 10;"
    elif "last 10" in user_inp:
        return "SELECT * FROM students ORDER BY id DESC LIMIT 10;"
    
    # ---------- MARKS ----------
    elif "highest" in user_inp:
        if "maths" in user_inp:
            return "SELECT MAX(score) AS highest FROM marks WHERE subject ILIKE 'Maths';"
        elif "physics" in user_inp:
            return "SELECT MAX(score) AS highest FROM marks WHERE subject ILIKE 'Physics';"
        else:
            return "SELECT MAX(score) AS highest FROM marks;"
    elif "lowest" in user_inp:
        return "SELECT MIN(score) AS lowest FROM marks;"
    elif "average" in user_inp:
        if "maths" in user_inp:
            return "SELECT AVG(score) AS average FROM marks WHERE subject ILIKE 'Maths';"
        elif "physics" in user_inp:
            return "SELECT AVG(score) AS average FROM marks WHERE subject ILIKE 'Physics';"
        elif "department" in user_inp:
            return "SELECT s.department, AVG(m.score) AS avg_score FROM students s JOIN marks m ON s.id = m.student_id GROUP BY s.department;"
        else:
            return "SELECT AVG(score) AS average FROM marks;"
    elif "total score" in user_inp:
        return "SELECT SUM(score) AS total_score FROM marks;"
    elif "above 80" in user_inp:
        return "SELECT s.name, m.score FROM students s JOIN marks m ON s.id = m.student_id WHERE m.score > 80;"
    elif "below 50" in user_inp:
        return "SELECT s.name, m.score FROM students s JOIN marks m ON s.id = m.student_id WHERE m.score < 50;"
    elif "top 3" in user_inp and "maths" in user_inp:
        return "SELECT * FROM marks WHERE subject ILIKE 'Maths' ORDER BY score DESC LIMIT 3;"
    elif "maths" in user_inp:
        return "SELECT * FROM marks WHERE subject ILIKE 'Maths';"
    elif "physics" in user_inp:
        return "SELECT * FROM marks WHERE subject ILIKE 'Physics';"
    elif "mark" in user_inp or "score" in user_inp:
        return "SELECT * FROM marks;"
    
    # ---------- EVENTS ----------
    elif "event" in user_inp:
        if "2025" in user_inp:
            return "SELECT * FROM events WHERE date >= '2025-01-01';"
        elif "auditorium" in user_inp:
            return "SELECT * FROM events WHERE location ILIKE '%Auditorium%';"
        elif "lab" in user_inp:
            return "SELECT * FROM events WHERE location ILIKE '%Lab%';"
        else:
            return "SELECT * FROM events;"
    
    # ---------- DEFAULT ----------
    else:
        return "SELECT * FROM students;"
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
    data = {"prompt": prompt}

    try:
        response = requests.post(url, headers=headers, json=data)
        res = json.loads(response.text)
        rea = res['response']
        return rea
    except Exception as e:
        st.error(f"Natural Answer Error: {e}")
        return "Error in AI response."

# ---------- REAL DATABASE FUNCTION (Connects to Neon) ----------
def run_query(query: str,
              host="ep-rapid-flower-atnugp6l.c-9.us-east-1.aws.neon.tech",
              database="neondb",
              user="neondb_owner",
              password=os.environ.get("DB_PASSWORD", ""),
              port=5432,
              readonly_only: bool = True):

    qstart = query.lstrip().split(None, 1)
    if not qstart:
        return None

    first_token = qstart[0].lower()
    allowed_readonly = {"select", "with"}

    if readonly_only and first_token not in allowed_readonly:
        st.warning(f"Safety: '{first_token}' not allowed.")
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
             
        
        # ---------- FIX: Convert = to ILIKE (Case-Insensitive) ----------
        query = re.sub(r"=\s*'([^']*)'", r" ILIKE '\1'", query, flags=re.IGNORECASE)
        # -----------------------------------------------------------------
        
        cursor.execute(query)

        if first_token in {"select", "with"}:
            rows = cursor.fetchall()
            columns = [desc[0] for desc in cursor.description]
            df = pd.DataFrame(rows, columns=columns)
            return df
        else:
            conn.commit()
            return None

    except Exception as e:
        st.error(f"DB Error: {e}")
        return None

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

# ---------- SIDEBAR ----------
with st.sidebar:
    st.markdown("""
    <h1 style="background: linear-gradient(90deg, #A855F7, #06B6D4); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-weight: 800; font-size: 26px; border-bottom: 2px solid #A855F7; padding-bottom: 10px; text-shadow: 0 0 30px rgba(168,85,247,0.3);">🤖 Dynamic AI Assistant</h1>
    """, unsafe_allow_html=True)

    if st.button("✨ New Chat", key="new_chat", use_container_width=True):
        st.session_state.messages = []
        st.rerun()

    st.markdown("---")
    st.markdown('<div class="section-label">📂 Chat History</div>', unsafe_allow_html=True)
    st.markdown('<div class="sidebar-item">📋 History</div>', unsafe_allow_html=True)
    st.markdown('<div class="section-label">⭐ Saved Answers</div>', unsafe_allow_html=True)
    st.markdown('<div class="sidebar-item">💾 Saved</div>', unsafe_allow_html=True)
    st.markdown('<div class="section-label">⚙️ Settings</div>', unsafe_allow_html=True)
    st.markdown('<div class="sidebar-item">🔧 Settings</div>', unsafe_allow_html=True)
    st.markdown('<div class="section-label">ℹ️ About</div>', unsafe_allow_html=True)
    st.markdown('<div class="sidebar-item">📖 About</div>', unsafe_allow_html=True)
    st.markdown("---")

    # ---------- RECENT CHATS (WITH SAFETY CHECK) ----------
    st.markdown('<div class="section-label">🕒 Recent Chats</div>', unsafe_allow_html=True)

    # Check if messages exists and is not empty
    if "messages" in st.session_state and st.session_state.messages:
        user_questions = [msg for msg in st.session_state.messages if msg["role"] == "user"]
        if user_questions:
            for q in reversed(user_questions[-10:]):
                question_text = q["content"]
                time = q.get("time", "")
                st.markdown(f"""
                <div class="recent-chat-item">
                    {question_text[:45]}{'...' if len(question_text) > 45 else ''}
                    <span class="recent-chat-time">{time}</span>
                </div>
                """, unsafe_allow_html=True)
        else:
            st.markdown('<div class="recent-chat-item" style="color:#5A4A7A;">No recent chats</div>', unsafe_allow_html=True)
    else:
        st.markdown('<div class="recent-chat-item" style="color:#5A4A7A;">No recent chats</div>', unsafe_allow_html=True)

    st.markdown("---")
    st.markdown("""
    <div class="user-profile">
        <div class="user-name">👤 Nirosha</div>
        <div class="user-email">nirosha@example.com</div>
    </div>
    """, unsafe_allow_html=True)
    st.markdown("---")
    st.markdown('<div class="sidebar-item">🌙 Dark Mode</div>', unsafe_allow_html=True)

# ---------- MAIN CHAT INTERFACE ----------
st.markdown('<div class="main-header">🌌 Dynamic AI Assistant</div>', unsafe_allow_html=True)
st.markdown('<div class="main-subheader">Ask me anything about Students, Marks, or Events. Instant AI insights!</div>', unsafe_allow_html=True)

# Display chat history
for msg in st.session_state.messages:
    with st.chat_message(msg["role"]):
        st.markdown(msg["content"])

# Input
prompt = st.chat_input("💬 Ask me anything about your college data...")

if prompt:
    current_time = datetime.now().strftime("%I:%M %p")
    st.session_state.messages.append({"role": "user", "content": prompt, "time": current_time})
    with st.chat_message("user"):
        st.markdown(prompt)

    with st.chat_message("assistant"):
        with st.status("🔍 Processing your request...", expanded=False) as status:
            status.write("🤖 Generating SQL query...")
            sql = ask_myai(prompt)
            
            if not sql:
                response = "❌ Sorry, I couldn't understand that. Please try rephrasing."
                status.update(label="❌ Failed", state="error")
            else:
                status.write("📦 Querying database...")
                df = run_query(sql, readonly_only=True)
                
                if df is not None and not df.empty:
                    with st.expander("📝 View Generated SQL", expanded=False):
                        st.code(sql, language="sql")
                    
                    status.write("📊 Formatting results...")
                    st.markdown("#### 📈 Results")
                    st.dataframe(df, use_container_width=True, height=300)
                    
                    status.write("💬 Generating final answer...")
                    data_dict = df.head(20).to_dict(orient="records")
                    answer = myai_natural_output(prompt, sql, data_dict)
                    
                    st.success(f"💡 {answer}")
                    response = answer
                    status.update(label="✅ Done", state="complete")
                else:
                    response = "⚠️ No results found for your query."
                    status.update(label="⚠️ No data", state="error")
        
        st.session_state.messages.append({"role": "assistant", "content": response})
