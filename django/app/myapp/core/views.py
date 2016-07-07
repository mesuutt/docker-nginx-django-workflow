import socket

from django.http import HttpResponse
from django.views.generic import View
# Create your views here.


class HostInfoView(View):

    def get(self, *args, **kwargs):
        hostname = socket.gethostname()
        return HttpResponse('Hostname: {}'.format(hostname))
