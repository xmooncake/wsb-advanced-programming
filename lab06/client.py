import socket
import threading
import random
import string
import tkinter as tk
from tkinter import scrolledtext, messagebox, simpledialog

class ChatClient:
    def __init__(self):
        self.host = 'localhost'
        self.port = 55556
        self.nickname = None
        self.client = None

        self.gui = tk.Tk()
        self.gui.title('Chat Client')
        self.gui.geometry('400x500')

        self.chat_area = scrolledtext.ScrolledText(self.gui, state='disabled')
        self.chat_area.pack(padx=10, pady=10)

        self.message_entry = tk.Entry(self.gui)
        self.message_entry.pack(padx=10, pady=10)

        self.send_button = tk.Button(self.gui, text='Wyślij', command=self.send_message)
        self.send_button.pack(padx=10, pady=10)

        self.gui.protocol("WM_DELETE_WINDOW", self.on_closing)

    def connect(self):
        self.client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.client.connect((self.host, self.port))

        self.nickname = self.generate_nickname()

        self.client.send(self.nickname.encode('utf-8'))

        receive_thread = threading.Thread(target=self.receive_messages)
        receive_thread.start()

        self.gui.mainloop()

    def receive_messages(self):
        while True:
            try:
                message = self.client.recv(1024).decode('utf-8')
                self.display_message(message)
            except:
                print('Wystąpił błąd podczas odbierania wiadomości!')
                self.client.close()
                break

    def send_message(self):
        message = self.message_entry.get()
        self.message_entry.delete(0, 'end')
        self.client.send(message.encode('utf-8'))

    def display_message(self, message):
        self.chat_area.configure(state='normal')
        self.chat_area.insert('end', message)
        self.chat_area.configure(state='disabled')

    def prompt_for_nickname(self):
        return simpledialog.askstring('Nickname', 'Podaj swój nickname')

    def on_closing(self):
        self.client.send('koniec'.encode('utf-8'))
        self.client.close()
        self.gui.quit()
        
    def generate_nickname(self):
        return 'Gość_'+''.join(random.choices(string.ascii_letters + string.digits, k=8))

if __name__ == '__main__':
    client = ChatClient()
    client.connect()
