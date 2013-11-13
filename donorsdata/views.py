from django.shortcuts import render_to_response
from django.template import RequestContext
from django import template
from htsql import HTSQL
from django.conf import settings

register = template.Library()

# Create your views here.
def index(request):
    htsql = HTSQL('pgsql://%s:%s@%s/%s' % (settings.DATABASES['default']['USER'],
                                           settings.DATABASES['default']['PASSWORD'],
                                           settings.DATABASES['default']['HOST'],
                                           settings.DATABASES['default']['NAME']))
    results = []
    columns = []
    query = ''
    if request.method == 'POST':
        query = request.POST['query']
        results = htsql.produce(query)
        for prop in dir( results[0] ):
            if prop.startswith( '__' ) : continue
            if prop in ['count', 'index', 'make', 'bit_length', 'conjugate', 'denominator', 'imag', 'numerator'] : continue
            columns.append(prop)
    return render_to_response('index.html',{'results': results, 'query': query, 'columns': columns}, context_instance = RequestContext(request))

