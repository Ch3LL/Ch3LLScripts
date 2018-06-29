{%- import_yaml 'versions.sls' as versions -%}
server-1:
  Version: {{versions._Versions['comp1']}}

test: gitfs
update: yes
update2: test_test
test2: two
test3: three
test4: four
test5: five
ch3ll: yep
ch3ll2: yep2
