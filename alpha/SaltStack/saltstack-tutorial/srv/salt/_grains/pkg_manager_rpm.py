#! /bin/env python3

import subprocess
import distro


def __virtual__():
    # Есть и другие способы проверки...
    if distro.id() not in ['centos', 'rhel', 'fedora']:
        return False, 'Unsupported distro'

    return True


def version():
    proc = subprocess.run(
        'rpm --version'.split(),
        stdout=subprocess.PIPE,
        check=True)

    return {
        'pkg_manager': {
            'name': 'rpm',
            'version_str': proc.stdout.decode()
        }
    }


if __name__ == '__main__':
    from pprint import pprint
    pprint(__virtual__())
    pprint(version())
