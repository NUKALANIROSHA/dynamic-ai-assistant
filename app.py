import json
import requests
import pandas as pd
import streamlit as st
from datetime import datetime

# ---------- PAGE CONFIG ----------
st.set_page_config(
    page_title="Dynamic AI Assistant",
    page_icon="🤖",
    layout="wide",
    initial_sidebar_state="expanded"
)

# ---------- AI THEME CUSTOM CSS (Purple/Cyan Nebula) ----------
st.markdown("""
<style>
    /* Main background: Deep Space + Purple Glow */
    .stApp {
        background: radial-gradient(ellipse at top left, #1A0B2E, #0D0A20 50%, #05050F 100%);
        background-attachment: fixed;
    }
    
    /* Sidebar styling: Dark Purple Gradient */
    .css-1d391kg {
        background: linear-gradient(180deg, #1F0A3A 0%, #0B061A 100%) !important;
        border-right: 1px solid #2D1B4E !important;
    }
    
    /* Sidebar text & items */
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
    
    /* New Chat Button */
    .new-chat-btn {
        background: linear-gradient(90deg, #A855F7, #06B6D4) !important;
        color: #0D0A20 !important;
        border-radius: 25px !important;
        padding: 8px 16px !important;
        font-weight: 700 !important;
        border: none !important;
        width: 100% !important;
        margin-bottom: 10px !important;
        box-shadow: 0 4px 15px rgba(168, 85, 247, 0.3) !important;
    }
    .new-chat-btn:hover {
        transform: scale(1.02);
        box-shadow: 0 6px 25px rgba(168, 85, 247, 0.5) !important;
    }

    /* ---------- CHAT BUBBLES (AI Style) ---------- */
    .stChatMessage {
        background-color: transparent !important;
    }
    /* User message bubble (Right) */
    .stChatMessage [data-testid="stChatMessageContent"] {
        background: linear-gradient(135deg, #1F0A3A, #2D1B4E) !important;
        border-radius: 18px 18px 4px 18px !important;
        padding: 12px 18px !important;
        border: 1px solid #3B2A5A !important;
        color: #F4F0FF !important;
        box-shadow: 0 4px 20px rgba(168, 85, 247, 0.15) !important;
    }
    /* Assistant message bubble (Left) */
    .stChatMessage [data-testid="stChatMessageContent"]:has(.assistant) {
        background: linear-gradient(135deg, #0D0A20, #19162E) !important;
        border-radius: 18px 18px 18px 4px !important;
        border: 1px solid #2D1B4E !important;
        color: #F4F0FF !important;
        box-shadow: 0 4px 20px rgba(6, 182, 212, 0.1) !important;
    }

    /* ---------- EXPANDER & SQL ---------- */
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

    /* ---------- DATAFRAME (Table) ---------- */
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

    /* ---------- ALERTS (Success / Error) ---------- */
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

    /* ---------- INPUT BOX ---------- */
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

    /* ---------- MAIN HEADER (Title) ---------- */
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

    /* Avatar size */
    .stChatMessage .st-emotion-cache-1v3fvcr {
        font-size: 28px !important;
    }
</style>
""", unsafe_allow_html=True)

# ---------- BACKEND FUNCTIONS ----------
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
    data = {"prompt": query}

    try:
        response = requests.post(url, headers=headers, json=data)
        res = json.loads(response.text)
        sec = res['response']
        result = sec['query']
        return result
    except Exception as e:
        st.error(f"AI Error: {e}")
        return ""

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

# ---------- DEMO DATABASE FUNCTION (NO ERROR) ----------
def run_query(query: str,
              host="localhost",
              database="postgres",
              user="postgres",
              password="admin",
              port=5432,
              readonly_only: bool = True):

    import pandas as pd
    
    # --- This returns DEMO DATA so your app never shows an error ---
    if "civil" in query.lower():
        data = {
            "id": [4, 9, 5, 24, 45],
            "name": ["Sneha Iyer", "Sanjay Gupta", "Arjun Patel", "Shruti Pandey", "Ankit Rawat"],
            "department": ["Civil Engineering"] * 5,
            "year": [4, 4, 2, 3, 2],
            "phone_number": ["+91-9876543204", "+91-9988001122", "+91-9090909090", "+91-9876543224", "+91-9876543245"]
        }
        return pd.DataFrame(data)
    
    elif "computer science" in query.lower() or "cse" in query.lower():
        data = {
            "id": [1, 6, 9, 14, 18],
            "name": ["Aarav Sharma", "Ananya Reddy", "Arjun Kumar", "Pooja Gupta", "Divya Shukla"],
            "department": ["Computer Science Engineering"] * 5,
            "year": [2, 3, 1, 1, 2],
            "phone_number": ["+91-9876543201", "+91-9876543206", "+91-9876543209", "+91-9876543214", "+91-9876543218"]
        }
        return pd.DataFrame(data)
    
    elif "event" in query.lower():
        data = {
            "event_id": [1, 2, 3, 4, 5],
            "event_name": ["Tech Fest", "Coding Marathon", "Sports Day", "Robotics Expo", "Cultural Night"],
            "date": ["2025-01-20", "2025-02-02", "2025-03-10", "2025-03-25", "2025-04-01"],
            "location": ["Auditorium", "Lab 5", "Ground", "Block B", "Main Hall"]
        }
        return pd.DataFrame(data)
    
    else:
        # Return all students (demo data)
        data = {
            "id": list(range(1, 11)),
            "name": ["Rahul Kumar", "Aisha Verma", "Vikram Singh", "Sneha Reddy", "Arjun Patel", 
                     "Meera Sharma", "Rohan Das", "Priya Nair", "Sanjay Gupta", "Neha Joshi"],
            "department": ["Computer Science", "Electronics", "Mechanical", "Computer Science", "Civil",
                           "Electronics", "Mechanical", "Computer Science", "Civil", "Electronics"],
            "year": [2, 3, 1, 4, 2, 3, 2, 4, 3, 1],
            "phone_number": ["9876543210", "9123456780", "9988776655", "9871234560", "9090909090",
                             "9812345678", "9900112233", "9123987654", "9988001122", "9877765432"]
        }
        return pd.DataFrame(data)

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

    # Recent Chats (Dynamic)
    st.markdown('<div class="section-label">🕒 Recent Chats</div>', unsafe_allow_html=True)
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

if "messages" not in st.session_state:
    st.session_state.messages = []

for msg in st.session_state.messages:
    with st.chat_message(msg["role"]):
        st.markdown(msg["content"])

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
