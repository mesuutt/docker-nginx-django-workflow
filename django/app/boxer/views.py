import socket

from django.views.generic import ListView
from .models import Boxer


__all__ = (
    'BoxerListView',
)


class BoxerListView(ListView):
    template_name = 'index.html'
    model = Boxer

    def get_context_data(self, *args, **kwargs):
        context = super(BoxerListView, self).get_context_data(**kwargs)

        context['hostname'] = socket.gethostname()

        return context
