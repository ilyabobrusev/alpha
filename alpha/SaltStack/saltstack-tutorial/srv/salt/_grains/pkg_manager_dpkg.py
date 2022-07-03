#! /bin/env python3

import subprocess
import distro


def __virtual__():
    if distro.id() not in ['debian', 'ubuntu']:
        return False, 'Unsupported distro'

    return True


def version():
    proc = subprocess.run(
        'dpkg --version'.split(),
        stdout=subprocess.PIPE,
        check=True)

    return {
        'pkg_manager': {
            'name': 'dpkg',
            'version_str': proc.stdout.decode()
        }
    }


if __name__ == '__main__':
    from pprint import pprint
    pprint(__virtual__())
    pprint(version())
