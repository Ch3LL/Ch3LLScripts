/etc/pki/tls/private/mykey.key:
  file.managed:
    - source: salt://files/mykey.key
    - mode: 0600
    - user: root
    - group: root 
