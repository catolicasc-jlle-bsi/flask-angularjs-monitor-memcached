from flask import Response, Blueprint, redirect, url_for, request
from .models import Stats
import json
import datetime

controller = Blueprint('controller', __name__)

	
def stats_per_page(page=1):
    callback = request.args.get('callback')
    
    items_per_page = 10 
    offset = (page - 1) * items_per_page
    stats = Stats.objects_for_json.skip(offset).limit(items_per_page)
    
    if callback:
        json_response = "%s(%s)" % (callback, stats.to_json())
    else:
        json_response = stats.to_json()
        
    return Response(callback, status=200, mimetype='application/json;charset=UTF-8', headers={'Access-Control-Allow-Origin': '*'})
	
def stats():
    initial = request.args.get('initial')
    callback = request.args.get('callback')
	
    if initial:
        created_at = datetime.datetime.strptime(initial, '%Y-%m-%d %H:%M:%S')
        stats = Stats.objects_for_json(created_at_dt__gte=created_at).limit(10)
    else:
        stats = Stats.objects_for_json.all().limit(10)
    
    if callback:
        json_response = "%s(%s)" % (callback, stats.to_json())
    else:
        json_response = stats.to_json()
		
    return Response(json_response, status=200, mimetype='application/json;charset=UTF-8', headers={'Access-Control-Allow-Origin': '*'})

def stats_last():
    callback = request.args.get('callback')
    
    stats = Stats.objects_for_json.all().limit(1).first()
    
    if callback:
        json_response = "%s(%s)" % (callback, stats.to_json())
    else:
        json_response = stats.to_json()
        
    return Response(json_response, status=200, mimetype='application/json;charset=UTF-8', headers={'Access-Control-Allow-Origin': '*'})
	

controller.add_url_rule('/stats/', view_func=stats)
controller.add_url_rule('/stats/last/', view_func=stats_last)
controller.add_url_rule('/stats/page/<int:page>', view_func=stats_per_page)
