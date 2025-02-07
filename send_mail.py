import smtplib

email = "" # Please fill
receiver_email = "" # Please fill

subject = "Ping Detected"
message = "Somebody is trying to ping your machine"

text = f"Subject: {subject}\n\n{message}"

server = smtplib.SMTP("smtp.gmail.com", 587)
server.starttls()

server.login(email, "") # Second argument should be "App Password"

server.sendmail(email, receiver_email, text)

#print("Email has been sent to " + receiver_email)