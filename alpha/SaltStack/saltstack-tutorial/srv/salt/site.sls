---

nginx:
  pkg:
    - installed
  service.running:
    - watch:
        - file: /etc/nginx/nginx.conf
    - enable: true

tune_firewall:
  firewalld.present:
    - name: public
    - services:
        - http

/srv/www/site/index.html:
  file.managed:
    - source: salt://files/site_html.jinja
    - template: jinja
    - makedirs: true
    - show_changes: false

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://files/nginx.conf
    - show_changes: false
