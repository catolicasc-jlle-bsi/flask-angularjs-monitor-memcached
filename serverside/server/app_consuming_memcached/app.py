import threading
import memcache
import random

tables = ['produtos', 'pedidos', 'cliente', 'usuario']
produtos_json = {
   'id': 1,
   'nome': 'Coca-cola',
   'preco': 14
}

def populate_memcached():
    threading.Timer(5.0, populate_memcached).start()
    client = memcache.Client([('127.0.0.1', 11211)])
    choice = random.choice(tables)
    client.set(choice, produtos_json, time=60)
    print 'generate key %s' % choice

populate_memcached()