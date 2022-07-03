---

base:
  '*':
    - highstate.common_pkgs_installed
  'N@blue':
    - highstate.blue
  'N@red':
    - highstate.red

prod: {}

dev: {}
