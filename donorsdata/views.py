from django.shortcuts import render_to_response
from django.template import RequestContext
from django.http import HttpResponse
from django import template
from htsql import HTSQL

register = template.Library()

# Create your views here.
def index(request):
    htsql = HTSQL('pgsql://root:local@localhost/test')
    results = []
    columns = []
    query = ''
    if request.method == 'POST':
    	query = request.POST['query']
        results = htsql.produce(query)
        for prop in dir( results[0] ):
            if prop.startswith( '__' ) : continue
            if prop in ['count', 'index', 'make'] : continue
            columns.append(prop)
    return render_to_response('index.html',{'results': results, 'query': query, 'columns': columns}, context_instance = RequestContext(request))

