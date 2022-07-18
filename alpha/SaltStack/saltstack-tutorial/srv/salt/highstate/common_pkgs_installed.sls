---

# Пример установки пакетов на разные миньоны

{% set vim = 'vim' %}
{% if grains['os_family'] == 'RedHat' %}
  {% set vim = 'vim-enhanced' %}
{% endif %}

common_pkgs_installed:
  pkg.installed:
    - pkgs:
      - {{ vim }}
      - git
    - refresh: true
