import socket
import threading
import time

class ChatServer:
    def __init__(self):
        # IP address of the Ubuntu virtual machine
        self.host = '192.168.0.129'
        self.port = 55556
        self.server = None
        self.clients = {}
        self.nicknames = []

    def start(self):
        self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server.bind((self.host, self.port))
        self.server.listen()

        print('Server listening on {}:{}'.format(self.host, self.port))

        while True:
            client, address = self.server.accept()
            print('New connection: {}'.format(address))

            nickname = client.recv(1024).decode('utf-8')

            self.nicknames.append(nickname)
            self.clients[client] = nickname

            self.broadcast('{} joined the chat!\n'.format(nickname), 'Server')
            client.send('Connected to the server!\n'.encode('utf-8'))
            client.send(self.get_online_users().encode('utf-8'))

            # Create a new thread for each client
            threading.Thread(target=self.handle_client, args=(client,)).start()

    def broadcast(self, message, sender):
        formatted_message = '[{}] {}: {}'.format(time.strftime('%H:%M:%S'), sender, message)
        for client in self.clients:
            client.send(formatted_message.encode('utf-8'))

    def handle_client(self, client):
        nickname = self.clients[client]

        while True:
            try:
                message = client.recv(1024).decode('utf-8')
                if message == 'USERLIST':
                    client.send('USERLIST{}'.format(','.join(self.nicknames)).encode('utf-8'))
                else:
                    self.broadcast(message, nickname)
            except:
                self.remove_client(client, nickname)
                break

    def remove_client(self, client, nickname):
        del self.clients[client]
        self.nicknames.remove(nickname)
        client.close()
        self.broadcast('{} left the chat!'.format(nickname), 'Server')

    def stop(self):
        for client in self.clients:
            client.close()
        self.server.close()

    def get_online_users(self):
        return 'Online users: {}\n'.format(', '.join(self.nicknames))

if __name__ == '__main__':
    server = ChatServer()
    server.start()
