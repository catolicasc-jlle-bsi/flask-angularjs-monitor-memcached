import os, sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from celery import Celery
from memcached_stats import MemcachedStats
from server.models import Stats

celery = Celery('tasks', broker='amqp://guest@localhost//')
celery.config_from_object('celeryconfig')

mem = MemcachedStats()

@celery.task
def consume_memcached():
    data = mem.stats()
    stats = Stats(**data).save()
    return stats
