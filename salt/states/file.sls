/etc/pki/tls/private/mykey.key:
  file.managed:
    - source: salt://files/mykey.key
    - mode: 0600
    - user: root
    - group: root 

/etc/pki/tls/private/mykey2.key:
  file.managed:
    - source: salt://files/mykey2.key
    - mode: 0600
    - user: root
    - group: root 
