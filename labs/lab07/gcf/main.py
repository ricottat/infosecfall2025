#!/usr/bin/python3

import os
from email.message import EmailMessage
import smtplib
import shutil
from datetime import datetime
import logging
from flask import jsonify


logging.basicConfig(level=logging.INFO)

def main(request):
    try:
        THRESHOLD = 80.0

        sender_email = os.getenv("SENDER_EMAIL")
        sender_password = os.getenv("SENDER_PASSWORD")
        receiver_email = os.getenv("RECEIVER_EMAIL")
        smtp_server = os.getenv("SMTP_SERVER")
        smtp_port = os.getenv("SMTP_PORT", 8080)

        capacity, used, free = shutil.disk_usage("/")
        used_percentage = used / capacity * 100

        logs = []

        if used_percentage >= THRESHOLD:
            msg = EmailMessage()
            msg["From"] = sender_email
            msg["To"] = receiver_email
            msg["Subject"] = "Disk Usage Alert"
            msg.set_content(f"Warning: disk usage is {used_percentage:.1f}%")

            try:
                server = smtplib.SMTP(smtp_server, smtp_port, timeout=10)
                server.starttls()
                server.login(sender_email, sender_password)
                server.send_message(msg)
                log_msg = f"Email sent successfully at {datetime.now()}\n"
                logging.info(log_msg)
                logs.append(log_msg)
            except Exception as e:
                log_msg = f"Error sending email: {e}"
                logging.error(log_msg)
                logs.append(log_msg)
            finally:
                server.quit()
        else:
            log_msg = f"Disk usage is OK at {datetime.now()}\n"
            logging.info(log_msg)
            logs.append(log_msg)

        return jsonify({"status": "success", "logs": logs}), 200

    except Exception as e:
        log_msg = f"Error: {e}"
        logging.error(log_msg)
        return jsonify({"status": "error", "message": str(e)}), 500
