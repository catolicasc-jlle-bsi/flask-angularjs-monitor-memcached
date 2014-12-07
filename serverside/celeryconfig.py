from datetime import timedelta


CELERYBEAT_SCHEDULE = {
    'consume_memcached-every-10-seconds': {
        'task': 'tasks.consume_memcached',
        'schedule': timedelta(seconds=10),
    },
}

CELERY_TIMEZONE = 'UTC'