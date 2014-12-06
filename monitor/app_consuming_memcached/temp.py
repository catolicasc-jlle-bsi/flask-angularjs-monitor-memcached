
from memcached_stats import MemcachedStats

mem = MemcachedStats()

keys = mem.keys()

print keys

import memcached2
memcache = memcached2.Memcache(('memcached://localhost/',))

import pprint
pprint.pprint(memcache.get_multi(keys))