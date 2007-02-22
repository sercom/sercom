# vim: set et sw=4 sts=4 encoding=utf-8 :

from turbogears.validators import *

class ParseError(ValueError): pass

def params_to_list(params):
    r"""Parsea un string de forma similar al bash, separando por espacios y
    teniendo en cuenta comillas simples y dobles para agrupar. Para poner
    comillas se puede usar el \ como caracter de escape (\' y \") y también
    interpreta \n y \t. Devuelve una lista con los parámetros encontrados.
    >>> param2seq('--prueba')
    ['--prueba']
    >>> params_to_list('--prueba larga "con espacios"')
    ['--prueba', 'larga', 'con espacios']
    >>> params_to_list(u'''"con enter\\nentre 'comillas \\"dobles\\"'" --unicode''')
    [u'con enter\nentre \'comillas "dobles"\'', u'--unicode']
    >>> params_to_list('"archivo\\tseparado\\tpor\\ttabs" -h')
    ['archivo\tseparado\tpor\ttabs', '-h']
    """
    # Constantes
    SEP, TOKEN, DQUOTE, SQUOTE = ' ', None, '"', "'"
    seq = []
    buff = ''
    escape = False
    state = SEP
    if not params: return seq
    for c in params:
        # Es un caracter escapado
        if escape:
            if c == 'n':
                buff += '\n'
            elif c == 't':
                buff += '\t'
            else:
                buff += c
            escape = False
            continue
        # Es una secuencia de escape
        if c == '\\':
            escape = True
            continue
        # Si está buscando espacios
        if state == SEP:
            if c == SEP:
                continue
            else:
                state = TOKEN # Encontró
        if state == TOKEN:
            if c == DQUOTE:
                state = DQUOTE
                continue
            if c == SQUOTE:
                state = SQUOTE
                continue
            if c == SEP:
                state = SEP
                seq.append(buff)
                buff = ''
                continue
            buff += c
            continue
        if state == DQUOTE:
            if c == DQUOTE:
                state = TOKEN
                continue
            buff += c
            continue
        if state == SQUOTE:
            if c == SQUOTE:
                state = TOKEN
                continue
            buff += c
            continue
        raise ParseError, 'Invalid syntax'
    if state == DQUOTE or state == SQUOTE:
        raise ParseError, 'Missing closing quote %s' % state
    if buff:
        seq.append(buff)
    return seq

class ParamsValidator(UnicodeString):
    def validate_python(self, value, state):
        try:
            params_to_list(value)
        except ParseError, e:
            raise Invalid(str(e), value, state)

