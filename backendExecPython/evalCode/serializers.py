from rest_framework import serializers

class EvalCodeSerializer(serializers.Serializer):
    code = serializers.CharField(required=True)        