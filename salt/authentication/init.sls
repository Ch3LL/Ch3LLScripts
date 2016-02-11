/tmp/access.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - source: salt://ops/authentication/access.conf
