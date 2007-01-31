# vim: set et sw=4 sts=4 encoding=utf-8 :

def resume(text, size=15):
    if text is not None and len(text) > size:
        text = text[:size-3] + '...'
    return text

