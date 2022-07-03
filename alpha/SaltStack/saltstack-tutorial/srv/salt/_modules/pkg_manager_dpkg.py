#! /bin/env python3

import subprocess

__virtualname__ = 'pkg_manager'


def __virtual__():
    if __grains__['os'] not in ['Debian', 'Ubuntu']:
        return False, 'Unsupported distro'

    return True


def version():
    """
    Get package manager name and version info

    CLI Example:

        salt '*' pkg_manager.version
    """

    proc = subprocess.run(
        'dpkg --version'.split(),
        stdout=subprocess.PIPE,
        check=True)

    return {
        'name': 'dpkg',
        'version_str': proc.stdout.decode()
    }


if __name__ == '__main__':
    from pprint import pprint
    pprint(__virtual__())  # Здесь ожидаемо упадёт, не увидев __grains__
    pprint(version())
