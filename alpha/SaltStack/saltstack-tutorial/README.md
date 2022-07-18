# Сопроводительные материалы к видеопособию по SaltStack

## Описание

Репозиторий содержит материалы к неофициальному русскоязычному видеопособию по
системе управления конфигурациями [SaltStack](https://docs.saltproject.io).

:link:[Скачать
презентацию](https://bergentroll-docs.gitlab.io/saltstack-tutorial/saltstack_tutorial_slides.pdf)
[![pipeline
status](https://gitlab.com/bergentroll-docs/saltstack-tutorial/badges/main/pipeline.svg)](https://gitlab.com/bergentroll-docs/saltstack-tutorial/-/commits/main)

Ссылки на видео:

  - [Rutracker.org](https://rutracker.org/forum/viewtopic.php?t=6230652) (с
    образами шаблонных машин)
  - [PeerTube
    videos.redeyes.site](https://videos.redeyes.site/w/4QWvHfk8zC5kpDdUqRtHwW)
  - [PeerTube
    video.sadmin.io](https://video.sadmin.io/w/kxhS9MrJF8NY3sLga7Ju5o)
  - [Archive.org](https://archive.org/details/saltstack-tutorial) (с
    образами шаблонных машин)
  - [Youtube](https://youtu.be/6zY41M2anrY)

## Условия

Пособие и материалы к нему могут быть использованы без ограничений.

Пусть пособие вдохновляет на применение свободных лицензий на благо всех.

## Быстрый запуск окружения

### Конфигурации

Конфигурационные файлы находятся в `./srv/` и `./etc/`. Для быстрого
копирования есть скрипт `./deploy.sh`, следует иметь в виду, что он
переписывает директории назначения.

### Стенд

Используется [Salt Cloud с драйвером libvirt](
https://docs.saltproject.io/en/latest/topics/cloud/libvirt.html). См.
файлы профиля и провайдера в `./etc/salt/`. Локальная машина в роли гипервизора
и мастера. Должны существовать шаблонные ВМ с чистой совместимой ОС. Готовые образы
дисков для создания шаблонных ВМ доступны по некоторым ссылкам на видео (см. список).

Создать миньоны по описанию:
```
# salt-cloud -m ./mapfile.yaml -P
```

Для ручного управления машинами можно использовать `virt-manager` или `virsh`. 

Удалить миньоны:
```
# salt-cloud -d ./mapfile.yaml
```

## Примеры комманд из видео

Файл [examples.md](./examples.md) содержит перечень команд для запуска примеров по
темам аналогично тому, как они выполняются в видео.
