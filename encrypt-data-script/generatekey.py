from cryptography.fernet import Fernet

key = Fernet.generate_key()

with open("secretkey.txt", "wb") as file:
    file.write(key)

