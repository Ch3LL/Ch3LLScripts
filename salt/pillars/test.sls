test:
  pillar: {{ salt['pillar.get']('getthis', '') }}
