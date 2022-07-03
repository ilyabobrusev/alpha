# Памятка по демонстрации ⚗️

## Мотивирующий пример

```bash
sudo salt salt-owls-red grains.item ipv4
```

Открыть в браузере

```bash
sudo salt salt-owls-red state.apply site
```

## Разбор YAML

```python
with open('examples/yaml-file.yaml') as f:
    data = yaml.safe_load(f)
```

## Демонстрация установки

https://repo.saltproject.io/

## Конфигурационные файлы

```bash
vim /etc/salt/
```

## Команды

```bash
sudo ./examples/salt-key.sh
```

```bash
sudo ./examples/targeting-key.sh
```

```bash
sudo ./examples/execution-modules.sh
```

## Топ-файл и хайстейт

```bash
vim /srv/salt/top.sls
sudo salt '*' state.test
```

## Состояния

```bash
sudo salt salt-owls-red state.apply kernel_updated_simple
vim /srv/salt/kernel_updated_simple.sls
```

## Порядок исполнения

```bash
vim /srv/salt/states_ordering/
```

```bash
sudo salt salt-owls-red state.apply states_ordering.plain
sudo salt salt-owls-red state.apply states_ordering.hardcoded
sudo salt salt-owls-red state.apply states_ordering.requisites
```

## Порядок исполнения LIVE
```bash
vim /srv/salt/kernel_updated.sls
sudo salt salt-owls-red state.apply kernel_updated
```

## Jinja рендеринг

```bash
ipython
```
```python
import jinja2

s = "{{ ['соль', 'мука', 'шаблонизатор'] | join(', ') | capitalize }}"

jinja2.Template(s).render()
```

## Jinja в формулах

```bash
vim /srv/salt/jinja_sample.sls
sudo salt --local salt-owls-red slsutil.renderer salt://jinja_sample.sls
```

```bash
vim /srv/salt/jinja_pillar_sample.sls
sudo salt salt-owls-red slsutil.renderer salt://jinja_pillar_sample.sls

sudo vim /srv/pillar/
sudo salt salt-owls-red saltutil.refresh_pillar
sudo salt salt-owls-red slsutil.renderer salt://jinja_pillar_sample.sls
sudo salt salt-owls-red state.test jinja_pillar_sample pillar='{"power_settings": ["any", "mubmo", "jumbo"]}'
```

## Пишем модули

```bash
vim /srv/salt/_modules/

sudo salt salt-owls-red fibonacci.list
sudo salt salt-owls-red sys.doc fibonacci
sudo salt salt-owls-red fibonacci.list start=99 end=99 length=false

sudo salt '*' pkg_manager.version
```

```bash
vim /srv/salt/_grains/

sudo salt '*' grains.item pkg_manager
```

## Реакторы

```bash
sudo vim /etc/salt/master /srv/salt/reactor/

sudo salt-key -L
sudo salt-run event.send 'salt/auth'
sudo salt-key -L

sudo salt-key -d '*-red'
```

Затем перезагрузить машины `*-red`.

## Планировщик

```bash
sudo salt salt-owls-red schedule.add write_to_file function='cmd.run' seconds=5 job_args='["date >> /tmp/salt.log"]' splay=3

sudo salt salt-owls-red cmd.run 'ls /etc/salt/minion.d/'
sudo salt salt-owls-red cmd.run 'cat /etc/salt/minion.d/_schedule.conf'
sudo salt salt-owls-red cmd.run 'cat /tmp/salt.log'
```

## Оркестрация

```bash
sudo salt-run state.orchestrate orch.stand

vim /srv/salt/orch/stand.sls

sudo salt -N 'rpm-hosts' grains.item ipv4
sudo salt -N 'dev-hosts' grains.item ipv4
```

Демонстрация в браузере.

```bash
vim site.sls proxy.sls files/ ../pillar/ipv4.sls

sudo salt '*' mine.get '*' network.ip_addrs
sudo salt '*' network.ip_addrs

sudo salt-run state.orchestrate orch.stand
sudo salt -N 'rpm-hosts' grains.setval custom_grain 'All glory to the toad'
sudo salt-run state.orchestrate orch.stand
```

## Salt Cloud

```bash
sudo salt-cloud -m mapfile.yaml
sudo salt-cloud -m mapfile.yaml -d
sudo salt-cloud -P -m mapfile.yaml -y
```

## Заключение

- Показываем жабуса 🐸
- Резюме по рассмотреннным материалам.
- SaltStack — это как Ansible, только эффективно и непопулярно.
- Бывают мозголомные вещи.
- По опыту — система для серверов, датацентров, а не для рабочих станций.
- Успехов, всех благ!
