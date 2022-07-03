---

# Файл содержит пример для orchestrate runner
# Запускается командой salt-run state.orchestrate orch.stand

saltutil.sync_all:
  salt.function:
    - tgt: '*'

mine.update:
  salt.function:
    - tgt: '*'

highstate:
  salt.state:
    - tgt: '*'
    - highstate: true

site:
  salt.state:
    - tgt: 'rpm-hosts'
    - tgt_type: nodegroup
    - sls:
        - site

proxy:
  salt.state:
    - tgt: 'deb-hosts'
    - tgt_type: nodegroup
    - sls:
        - proxy
