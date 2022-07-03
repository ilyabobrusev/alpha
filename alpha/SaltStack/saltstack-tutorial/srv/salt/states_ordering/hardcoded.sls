---

# Пример упорядочивания состояний ключом order

state1:
  test.succeed_with_changes:
    - order: 3

state2:
  test.succeed_with_changes:
    - order: 2

state3:
  test.succeed_with_changes:
    - order: 1

state4:
  test.succeed_with_changes:
    - order: 4
