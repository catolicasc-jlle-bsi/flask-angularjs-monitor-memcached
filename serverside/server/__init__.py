from flask import Flask
from flask.ext.mongoengine import MongoEngine

app = Flask(__name__)

app.config['MONGODB_SETTINGS'] = {
    'db': 'monitor_db',
	'host': '127.0.0.1',
	'port': 27017,
}

db = MongoEngine(app)

def register_blueprints(app):
    from .views import controller
    app.register_blueprint(controller)

register_blueprints(app)

if __name__ == '__main__':
    app.run()
