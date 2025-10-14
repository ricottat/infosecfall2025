#!/usr/bin/python3

import os
from email.message import EmailMessage
import smtplib
import shutil
from datetime import datetime

THRESHOLD=01.0

base = os.getenv("BASE")
sender_email = os.getenv("SENDER_EMAIL")
sender_password = os.getenv("SENDER_PASSWORD")
receiver_email = os.getenv("RECEIVER_EMAIL")
smtp_port = os.getenv("SMTP_PORT")
smtp_server = os.getenv("SMTP_SERVER")
subject = "Disk Usage Alert"

capacity, used, free = shutil.disk_usage("/")
used_percentage=used / capacity * 100

if used_percentage >= THRESHOLD:
    msg = EmailMessage()
    msg["From"] = sender_email
    msg["To"] = receiver_email
    msg["Subject"] = subject
    msg.set_content(f"Warning: disk usage is {used_percentage:.1f}%")
    try:
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(sender_email, sender_password)
        server.send_message(msg)
        print("Email sent successfully")
        with open(f"{base}/labs/lab07/verify.txt", "a") as v:
            v.write(f"Email sent at {datetime.now()}\n")
    except Exception as e:
        print(f"Error sending email: {e}")
    finally:
        server.quit()
