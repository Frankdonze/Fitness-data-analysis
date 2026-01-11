from cryptography.fernet import Fernet

key = Fernet.generate_key()

with open("secretkey.txt", "r") as file:
    key = file.read()
    print(key)
