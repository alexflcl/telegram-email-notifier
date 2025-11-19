from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import ssl
from sqlalchemy import create_engine, Column, Integer, String, Boolean
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session
from pydantic import BaseModel, EmailStr
from imapclient import IMAPClient
import requests
import os
from pathlib import Path

# Database setup
DB_PATH = Path("/app/data/telegram_notifier.db")
DB_PATH.parent.mkdir(parents=True, exist_ok=True)
DATABASE_URL = f"sqlite:///{DB_PATH}"

engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Models
class TelegramBot(Base):
    __tablename__ = "telegram_bots"
    id = Column(Integer, primary_key=True)
    name = Column(String)
    token = Column(String, unique=True)
    chat_id = Column(String)
    active = Column(Boolean, default=True)

class EmailAccount(Base):
    __tablename__ = "email_accounts"
    id = Column(Integer, primary_key=True)
    email = Column(String, unique=True)
    password = Column(String)
    imap_server = Column(String)
    imap_port = Column(Integer, default=993)

class EmailMonitor(Base):
    __tablename__ = "email_monitors"
    id = Column(Integer, primary_key=True)
    bot_id = Column(Integer)
    email_id = Column(Integer)
    folder = Column(String)
    check_interval = Column(Integer, default=300)
    active = Column(Boolean, default=True)

Base.metadata.create_all(bind=engine)

# Schemas
class BotSchema(BaseModel):
    name: str
    token: str
    chat_id: str

class EmailSchema(BaseModel):
    email: EmailStr
    password: str
    imap_server: str
    imap_port: int = 993

class MonitorSchema(BaseModel):
    bot_id: int
    email_id: int
    folder: str
    check_interval: int = 300

# FastAPI app
app = FastAPI(title="Telegram Email Notifier")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Database dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Email Service
def get_ssl_context():
    ssl_context = ssl.create_default_context()
    ssl_context.check_hostname = False
    ssl_context.verify_mode = ssl.CERT_NONE
    return ssl_context

def test_email_connection(email: str, password: str, imap_server: str, imap_port: int):
    try:
        with IMAPClient(imap_server, port=imap_port, ssl=True, ssl_context=get_ssl_context()) as client:
            client.login(email, password)
        return True
    except:
        return False

def send_telegram_message(token: str, chat_id: str, message: str):
    try:
        url = f"https://api.telegram.org/bot{token}/sendMessage"
        requests.post(url, json={"chat_id": chat_id, "text": message})
        return True
    except:
        return False

# Routes
@app.get("/health")
def health_check():
    return {"status": "ok"}

@app.post("/bots")
def create_bot(bot: BotSchema, db: Session = next(get_db())):
    db_bot = TelegramBot(**bot.dict())
    db.add(db_bot)
    db.commit()
    return db_bot

@app.get("/bots")
def list_bots(db: Session = next(get_db())):
    return db.query(TelegramBot).all()

@app.post("/emails")
def create_email(email: EmailSchema, db: Session = next(get_db())):
    if not test_email_connection(email.email, email.password, email.imap_server, email.imap_port):
        raise HTTPException(status_code=400, detail="Email connection failed")
    db_email = EmailAccount(**email.dict())
    db.add(db_email)
    db.commit()
    return db_email

@app.get("/emails")
def list_emails(db: Session = next(get_db())):
    return db.query(EmailAccount).all()

@app.post("/monitors")
def create_monitor(monitor: MonitorSchema, db: Session = next(get_db())):
    db_monitor = EmailMonitor(**monitor.dict())
    db.add(db_monitor)
    db.commit()
    return db_monitor

@app.get("/monitors")
def list_monitors(db: Session = next(get_db())):
    return db.query(EmailMonitor).all()

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
