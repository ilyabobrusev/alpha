---

# Это local-реактор
run_highstate:
  local.state.apply:
    - tgt: '*'
