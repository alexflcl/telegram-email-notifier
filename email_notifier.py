import time
import os
import ssl
import logging
from imapclient import IMAPClient
import requests

# Setup logging
logging.basicConfig(level=logging.INFO)

EMAIL = os.environ['EMAIL']
PASSWORD = os.environ['PASSWORD']
IMAP_SERVER = os.environ['IMAP_SERVER']
IMAP_PORT = int(os.environ['IMAP_PORT'])
BOT_TOKEN = os.environ['BOT_TOKEN']
CHAT_ID = os.environ['CHAT_ID']

def check_email():
    # Create SSL context that doesn't verify certificates
    # This is necessary for some IMAP servers with certificate issues
    ssl_context = ssl.create_default_context()
    ssl_context.check_hostname = False
    ssl_context.verify_mode = ssl.CERT_NONE
    
    with IMAPClient(IMAP_SERVER, port=IMAP_PORT, ssl=True, ssl_context=ssl_context) as client:
        client.login(EMAIL, PASSWORD)
        client.select_folder('INBOX')
        messages = client.search(['UNSEEN'])
        for msg_id, data in client.fetch(messages, ['ENVELOPE']).items():
            envelope = data[b'ENVELOPE']
            subject = envelope.subject.decode()
            sender = envelope.from_[0].mailbox.decode() + '@' + envelope.from_[0].host.decode()
            send_telegram_message(f'New email from {sender}\nSubject: {subject}')
            client.add_flags(msg_id, ['\\Seen'])

def send_telegram_message(message):
    url = f'https://api.telegram.org/bot{BOT_TOKEN}/sendMessage'
    data = {'chat_id': CHAT_ID, 'text': message}
    requests.post(url, json=data)

while True:
    check_email()
    time.sleep(60)  # Check every minute

