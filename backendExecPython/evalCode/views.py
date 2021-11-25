from rest_framework import generics
from .serializers import EvalCodeSerializer
from rest_framework.response import Response

from io import StringIO
from contextlib import redirect_stdout
import traceback

class EvalCodeAPIView(generics.GenericAPIView):
    serializer_class = EvalCodeSerializer

    def post(self, request, *args, **kwargs):
        code = request.data['code']
        res = StringIO()
        verbose = False

        with redirect_stdout(res):
            try:
                exec(code)
            except Exception as e:
                line = traceback.format_exc()
                verbose=True
                print(line[line.find('string')+10:len(line)])
        res = res.getvalue()
        return Response({'response':res,'verbose':verbose})