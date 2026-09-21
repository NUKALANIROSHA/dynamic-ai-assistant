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
def ask_myai(user_inp):
    user_inp = user_inp.lower()
     if "total" in user_inp or "count" in user_inp or "how many" in user_inp:
        return "SELECT COUNT(*) AS total_students FROM students;"
    else "information technology" in user_inp or " it" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Information Technology' LIMIT 20;"
    elif "civil" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Civil Engineering' LIMIT 20;"
    elif "computer science" in user_inp or "cse" in user_inp or "cs" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Computer Science' LIMIT 20;"
    elif "electronics" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Electronics' LIMIT 20;"
    elif "mechanical" in user_inp:
        return "SELECT * FROM students WHERE department ILIKE 'Mechanical Engineering' LIMIT 20;"
    elif "event" in user_inp:
        return "SELECT * FROM events;"
    elif "mark" in user_inp or "score" in user_inp:
        return "SELECT * FROM marks LIMIT 10;"
    else:
        return "SELECT * FROM students LIMIT 10;"
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
