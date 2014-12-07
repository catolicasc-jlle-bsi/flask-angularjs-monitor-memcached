from . import db
from datetime import datetime
from mongoengine import signals, queryset_manager


class Stats(db.Document):
    created_at_dt = db.DateTimeField()
    
    created_at = db.StringField()
    cmd_get = db.StringField()
    bytes = db.StringField()    
    get_hits = db.StringField()
    bytes_read = db.StringField()
    total_items = db.StringField()
    total_connections = db.StringField()
    cmd_set = db.StringField()
    bytes_written = db.StringField()
    curr_items = db.StringField()
    get_misses = db.StringField()
	
    @classmethod
    def pre_save(cls, sender, document, **kwargs):
        now = datetime.now()
        document.created_at = now.strftime('%Y-%m-%d %H:%M:%S')
        document.created_at_dt = now
		
    @queryset_manager
    def objects_for_json(doc_cls, queryset):
        return queryset.order_by('-created_at_dt').exclude('id', 'created_at_dt')
		
signals.pre_save.connect(Stats.pre_save, sender=Stats)


class Keys(db.Document):
    created_at_dt = db.DateTimeField()
	
    