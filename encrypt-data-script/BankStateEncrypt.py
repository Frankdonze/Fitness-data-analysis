import time
import os
import subprocess
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from cryptography.fernet import Fernet

class MyEventHandler(FileSystemEventHandler):
                            
    def on_created(self, event):
        time.sleep(10)
        file_path = event.src_path
        filename = os.path.basename(file_path)
        output_folder = r"C:\Users\Frank Donze\bankstate"
        output_path = os.path.join(output_folder, filename)

        with open("secretkey.txt", "rb") as file:
            key = file.read()

        with open(file_path, "rb") as data:
            f = Fernet(key)
            file_contents = data.read()
            encrypted_data = f.encrypt(file_contents)

        with open(output_path + ".enc", "wb") as new_file:
            new_file.write(encrypted_data)

        new_path = output_path + ".enc"
        subprocess.run("scp " + str(new_path) + "frank@10.10.20.3/home/frank/FIT-DA/data/bronze")
            
            
        
        print(key)
        print(encrypted_data)       
        print(f"Event detected: A file was created or added to folder and has been encrypted")

if __name__ == "__main__":
    event_handler = MyEventHandler()
    observer = Observer()
    observer.schedule(event_handler, path=r"C:\Users\Frank Donze\bankstatetemp", recursive=True)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
