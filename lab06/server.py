import socket
import threading

class ChatServer:
    def __init__(self):
        self.host = 'localhost'
        self.port = 55556
        self.server = None
        self.clients = {}
        self.nicknames = []

    def start(self):
        self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server.bind((self.host, self.port))
        self.server.listen()

        print('Serwer nasłuchuje na {}:{}'.format(self.host, self.port))

        while True:
            client, address = self.server.accept()
            print('Nowe połączenie: {}'.format(address))

            nickname = client.recv(1024).decode('utf-8')

            self.nicknames.append(nickname)
            self.clients[client] = nickname

            self.broadcast('{} dołączył do czatu!\n'.format(nickname).encode('utf-8'))
            client.send('Połączony z serwerem!\n'.encode('utf-8'))
            client.send(self.get_online_users().encode('utf-8'))

            self.handle_client(client)

    def broadcast(self, message):
        for client in self.clients:
            client.send(message)

    def handle_client(self, client):
        while True:
            try:
                message = client.recv(1024)
                self.broadcast('{}\n'.format(message.decode('utf-8')).encode('utf-8'))
            except:
                nickname = self.clients[client]
                self.broadcast('{} opuścił czat!\n'.format(nickname).encode('utf-8'))
                del self.clients[client]
                self.nicknames.remove(nickname)
                client.close()
                break

    def stop(self):
        for client in self.clients:
            client.close()
        self.server.close()

    def get_online_users(self):
        return 'Użytkownicy online: {}\n'.format(', '.join(self.nicknames))

if __name__ == '__main__':
    server = ChatServer()
    server.start()
