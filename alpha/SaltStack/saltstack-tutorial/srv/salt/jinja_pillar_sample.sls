---

# Пример использования пилларов в формуле

{%
  set settings = pillar.get(
    'power_settings',
    ['standby', 'hibernate', 'monitor', 'disk'])
%}

power_management_timeouts:
  cmd.run:
    - names:
      {% for setting in settings %}
      {% for power_mode in pillar.get('power_modes', ['ac', 'dc']) %}
      - powercfg /change /{{ setting }}-timeout-{{ power_mode }} 0
      {% endfor %}
      {% endfor %}
