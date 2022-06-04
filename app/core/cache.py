from django.core.cache import cache


def increment_key(key, value, timeout=None):
    # increments the value by one
    return cache.incr(key, delta=value)


def set_key(key, value, timeout=None):
    # sets a value to the cache, regardless of whether it exists.
    return cache.set(key, value, timeout=timeout)


def add_key(key, value, timeout=None):
    # add a value to the cache, failing if the key already exists.
    return cache.add(key, value, timeout=timeout)


def getKey(key):
    return cache.get('*')


def delete_key(key):
    # Removes a key from the cache
    return cache.delete(key)


def getallkeys(pattern):
    return getKey('*')
