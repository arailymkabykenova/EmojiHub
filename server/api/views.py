import requests
from rest_framework.decorators import api_view
from rest_framework.response import Response

@api_view(['GET'])
def get_emojis(request):
    try:
        response = requests.get('https://emojihub.yurace.pro/api/all')
        response.raise_for_status()
        return Response(response.json())
    except requests.RequestException as e:
        return Response({'error': 'Failed to fetch emojis'}, status=500)
    