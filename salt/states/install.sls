{% if grains['os'] == 'MacOS' %}

{% set uname = grains['uname']['system'] %}

/Library/Caches/com.megan.cloud.java:
  file.directory:
    - user: root
    - group: wheel
    - mode: 755

{% for version in pillar['java_version'][uname] %}

{% set java_major_version = pillar['java_version'][uname][version]['major_version'] %}
{% set java_minor_version = pillar['java_version'][uname][version]['minor_version'] %}
{% set java_update_version = pillar['java_version'][uname][version]['update_version'] %}
# in theory everything below this should be correctly built from the lines set above.
{% set java_version = java_major_version ~ 'u' ~ java_update_version %}
{% set java_pkg = 'jdk-' ~ java_major_version ~ 'u' ~ java_update_version ~ '-macosx-x64.pkg' %}
{% set java_foldername = 'jdk1.' ~ java_major_version ~ '.0_' ~ java_update_version ~ '.jdk' %}
{% set java_securityfolder = '/Library/Java/JavaVirtualMachines/' ~ java_foldername ~ '/Contents/Home/jre/lib/security' %}


/Library/Caches/com.megan.cloud.java/{{ java_pkg }}:
  file.managed:
    - source: salt://java/{{ uname }}/{{ java_pkg }}
    - user: root
    - group: wheel
    - mode: 755

installJDK-{{ version }}:
  cmd.wait:
    - cwd: /Library/Caches/com.megan.cloud.java/
    - name: /usr/sbin/installer -pkg {{ java_pkg }} -target /
    - watch:
      - file: /Library/Caches/com.megan.cloud.java/{{ java_pkg }}

{% for file in ['local_policy.jar', 'US_export_policy.jar'] %}
{{ java_securityfolder }}/{{ file }}:
  file.managed:
    - source: salt://java/{{ uname }}/UnlimitedJCEPolicy/{{ file }}
    - require:
      - file: /Library/Caches/com.megan.cloud.java/{{ java_pkg }}
{% endfor %}

unloadJDKlaunchagent-{{ version }}:
  cmd.run:
    - onlyif: test -e /Library/LaunchAgents/com.oracle.java.Java-Updater.plist
    - names:
      - launchctl unload /Library/LaunchAgents/com.oracle.java.Java-Updater.plist;

rmJDKlaunchagent-{{ version }}:
  cmd.wait:
    - watch:
      - cmd: unloadJDKlaunchagent-{{ version }}
    - names:
      - rm -f /Library/LaunchAgents/com.oracle.java.Java-Updater.plist

unloadJDKlaunchdaemon-{{ version }}:
  cmd.run:
    - onlyif: test -e /Library/LaunchDaemons/com.oracle.java.Helper-Tool.plist
    - names:
      - launchctl unload /Library/LaunchDaemons/com.oracle.java.Helper-Tool.plist

rmJDKlaunchdaemon-{{ version }}:
  cmd.wait:
    - watch:
      - cmd: unloadJDKlaunchdaemon-{{ version }}
    - names:
      - rm -f /Library/LaunchDaemons/com.oracle.java.Helper-Tool.plist

{% endfor %}

/Library/Preferences/com.oracle.java.Java-Updater.plist:
  file.managed:
    - source: salt://java/com.oracle.java.Java-Updater.plist
    - user: root
    - group: wheel
    - mode: 755

/Library/Application Support/Oracle/Java/Deployment/:
  file.directory:
    - user: root
    - group: wheel
    - mode: 755

/Library/Application Support/Oracle/Java/Deployment/deployment.properties:
  file.managed:
    - source: salt://java/deployment.properties
    - user: root
    - group: wheel
    - mode: 755

/Library/Application Support/Oracle/Java/Deployment/deployment.config:
  file.managed:
    - source: salt://java/deployment.config
    - user: root
    - group: wheel
    - mode: 755


{% elif grains['os'] == 'Ubuntu' %}

{% set uname = grains['uname']['system'] %}

/usr/lib/jvm/:
  file.directory:
    - makedirs: True

{% for version in pillar['java_version'][uname] %}

{% set java_major_version = pillar['java_version'][uname][version]['major_version'] %}
{% set java_minor_version = pillar['java_version'][uname][version]['minor_version'] %}
{% set java_update_version = pillar['java_version'][uname][version]['update_version'] %}
{% set java_hash = '1ad9a5be748fb75b31cd3bd3aa339cac' %}
# in theory everything below this should be correctly built from the lines set above.
{% set java_version = java_major_version ~ 'u' ~ java_update_version %}
{% set java_tarball = 'jdk-' ~ java_major_version ~ 'u' ~ java_update_version ~ '-linux-x64.tar.gz' %}
{% set java_foldername = 'jdk1.' ~ java_major_version ~ '.0_' ~ java_update_version %}
{% set java_securityfolder = '/usr/lib/jvm/' ~ java_foldername ~ '/jre/lib/security' %}
{% set java_alternativespriority = java_major_version ~ java_update_version %}

{{ java_version }}:
  archive:
    - extracted
    - name: /usr/lib/jvm/
    - source: salt://java/Linux/{{java_tarball}}
    - source_hash: md5={{ java_hash }}
    - archive_format: tar
    - tar_options: xz
    - if_missing: /usr/lib/jvm/{{ java_foldername }}

{% for file in ['local_policy.jar', 'US_export_policy.jar'] %}
{{ java_securityfolder }}/{{ file }}:
  file.managed:
    - source: salt://java/{{ uname }}/UnlimitedJCEPolicy/{{ file }}
    - require:
      - archive: {{ java_version}}
{% endfor %}

{% for alternate in ['java', 'javac', 'javaws', 'jps'] %}
# this makes the java version available via the alternates command.
{{ java_version }}{{ alternate }}-altinstall:
  alternatives.install:
    - name: {{ alternate }}
    - path: /usr/lib/jvm/{{ java_foldername }}/bin/{{ alternate }}
    - link: /usr/bin/{{ alternate }}
    - priority: {{ java_alternativespriority }}

# this activates the java version via alternates.
# Only the default version shuld be made active.
{% if version == "default" %}
{{ java_version }}{{ alternate }}-altset:
  alternatives.set:
    - name: {{ alternate }}
    - path: /usr/lib/jvm/{{ java_foldername }}/bin/{{ alternate }}
{% endif %}
{% endfor %}

{% endfor %}

#as per above, removing symlinks believed not needed
{% for jdksymlink in ['jdk1.8.0', 'jdk1.7.0'] %}
/usr/lib/jvm/{{ jdksymlink }}:
  file.absent
{% endfor %}

{% endif %}
