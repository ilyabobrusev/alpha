import logging

logger = logging.getLogger(__name__)

# Потому что list -- имя типа
__func_alias__ = {
    "list_": "list",
}


def _fibonacci(n) -> list:
    result = [1, 1]

    for i in range(n - 2):
        result.append(result[i] + result[i + 1])

    return result


def list_(start=1, end=10, length=True):
    """
    Calculate fibonacci sequence from element start to element end

    CLI Example:

        salt '*' fibonacci.list start=1 end=100 length=False
    """

    logger.info(f'Counting fibbonaci from {start} to {end} element')

    result = {
        'start': start,
        'end': end,
        'fibonacci': _fibonacci(end)[start - 1:]
    }

    if length:
        result['length'] = len(result['fibonacci'])
    return result


if __name__ == '__main__':
    import json
    print(json.dumps(list_(), indent=2))
