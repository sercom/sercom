# Custom useful widget
#

from turbogears import widgets

class LoadEventJSSource(widgets.JSSource):
    def __init__(self, onload_callback):
        widgets.JSSource.__init__(self, "MochiKit.DOM.addLoadEvent(%s);" % onload_callback,
            location = widgets.js_location.bodytop)

class FocusJSSource(widgets.JSSource):
    def __init__(self, element_id):
        widgets.JSSource.__init__(self, "MochiKit.DOM.focusOnLoad('%s');" % element_id, 
            location = widgets.js_location.bodytop)


class SeparatorField(widgets.Label):
    label =''
    template = '<hr/>' 
    engine_name = 'kid'

class LiteralField(widgets.Label):
    template = '<span>${XML(value)}</span>'
    engine_name = 'kid'

class CustomTextField(widgets.TextField):
    """Un input con un div al lado para ponerle info"""
    template = '''
        <span xmlns:py="http://purl.org/kid/ns#">
        <input
            type="text"
            name="${name}"
            class="${field_class}"
            id="${field_id}"
            value="${value}"
            py:attrs="attrs"
         />
         <span id="${field_id}_info" />
        </span>
'''
    engine_name = 'kid'

MultiSelectAjax = '''

    function _on_alumno_get_result(lista, loading, results)
    {
        load = MochiKit.DOM.getElement(loading);
        load.style.visibility = 'hidden';
        if (results.error) {
            alert(results.msg);
            return;
        }
        /* Verifico si esta y no lo agrego si esta repetido */
        l = MochiKit.DOM.getElement(lista);
        esta = false;
        for(i=0; i<l.options.length; i++) {
            if (results.msg.id == l.options[i].value) {
                esta = true;
                break;
            }
        }
        if (!esta)
            MochiKit.DOM.appendChildNodes(lista, OPTION({'value':results.msg.id}, results.msg.value));
    }

    function _on_alumno_get_error(loading, results)
    {
        alert(results)
        load = MochiKit.DOM.getElement(loading);
        load.style.visibility = 'hidden';
    }

    function sacar_de_la_lista(lista)
    {
        replaceChildNodes(lista,
            list(ifilterfalse(itemgetter('selected'), $(lista).options))
        );
    }

    function _do_add(callback, texto, lista, loading)
    {
        url = callback(texto, lista);
        t = MochiKit.DOM.getElement(texto);

        load = MochiKit.DOM.getElement(loading);
        load.style.visibility = 'visible';
        var d = loadJSONDoc(url);
        d.addCallbacks(partial(_on_alumno_get_result, lista, loading), partial(_on_alumno_get_error, loading));
        t.value = 'padron';
        t.style.color = "#aaa";
    }
'''

class AjaxMultiSelect(widgets.MultipleSelectField):
    template = '''
    <div style="width:250px" xmlns:py="http://purl.org/kid/ns#">
    <div>
    <input type="text" id="${field_id}_nuevo" size="10" value="padron"
        style="color:#aaa;"
        onfocus="this.style.color='#000'; if (this.value =='padron') { this.value=''; }"
        onblur="if (this.value == '') { this.style.color='#aaa'; this.value='padron'; }" />
    <img src="/static/images/loading.gif" align="baseline" style="visibility:hidden;" id="${name}_loading" width="16px" height="16px" />
    <input type="button" id="_agregar" value="Agregar"
        onClick=" _do_add(${on_add}, '${field_id}_nuevo', '${field_id}', '${name}_loading'); " />
    </div>
    <div>
    <select
        multiple="multiple"
        size="${size}"
        name="${name}"
        class="${field_class}"
        id="${field_id}"
        py:attrs="attrs"
        style="width:250px;"
    >
        <optgroup py:for="group, options in grouped_options"
            label="${group}"
            py:strip="not group"
        >
        <option py:for="value, desc, attrs in options"
            value="${value}"
            py:attrs="attrs"
            py:content="desc"
        />
        </optgroup>
    </select>
    </div>
    <div align="center">
    <input type="button" id="_sacar" value="Borrar" style="width:100%;"
        onClick="sacar_de_la_lista('${field_id}'); " />
    </div>
    </div>
    '''
    javascript = [widgets.JSSource(MultiSelectAjax)]
    on_add = "alert('Not defined action');"
    engine_name = 'kid'

    def __init__(self, **kw):
        self.params.append('on_add')
        self.on_add = "alert('Not defined action');"
        widgets.MultipleSelectField.__init__(self, **kw)

DosListasAjax = '''
    function makeOption(option) {
        return OPTION({"value": option.value}, option.text);
    }

    function moveOption( fromSelect, toSelect) {
        // add 'selected' nodes toSelect
        appendChildNodes(toSelect,
            map( makeOption,ifilter(itemgetter('selected'), $(fromSelect).options)));
        // remove the 'selected' fromSelect
        replaceChildNodes(fromSelect,
            list(ifilterfalse(itemgetter('selected'), $(fromSelect).options))
        );
    }
'''

class AjaxDosListasSelect(widgets.MultipleSelectField):
    template = '''
    <div xmlns:py="http://purl.org/kid/ns#">
    <table style="border:0; margin:0px; border-spacing:0px 0px">
    <tr class="nada">
        <td style="padding:0 0 0 0;" align="center">${title_from}</td>
        <td>&nbsp;</td>
        <td style="padding:0 0 0 0;" align="center">${title_to}</td>
    </tr>
    <tr class="nada">
    <td style="padding:0 0 0 0;">
    <select
        multiple="multiple"
        size="${size}"
        class="${field_class}"
        name="${name}_from"
        id="${field_id}_from"
        py:attrs="attrs"
        style="width:200px;">
        <optgroup py:for="group, options in grouped_options" label="${group}" py:strip="not group">
        <option py:for="value, desc, attrs in options" value="${value}" py:attrs="attrs" py:content="desc" />
        </optgroup>
    </select>
    </td>
    <td style="padding:0 10px 0 10px;" valign="center" align="center">
        <input type="button" value="&gt;&gt;&gt;" style="font-size:90%;" onClick="moveOption('${field_id}_from', '${field_id}_to'); ${move_signal}; " />
        <br />
        <br />
        <input type="button" value="&lt;&lt;&lt;" style="font-size:90%;" onClick="moveOption('${field_id}_to', '${field_id}_from'); ${move_signal}; " />
    </td>
    <td style="padding:0 0 0 0;">
    <select
        multiple="multiple"
        size="${size}"
        name="${name}_to"
        class="${field_class}"
        id="${field_id}_to"
        py:attrs="attrs"
        style="width:200px;">
    </select>
    </td>
    </tr>
    </table>
    </div>
    '''
    javascript = [widgets.JSSource(DosListasAjax)]
    title_from = ""
    title_to = ""
    move_signal = ""
    engine_name = 'kid'

    def __init__(self, **kw):
        self.params.append('title_from')
        self.params.append('title_to')
        self.params.append('move_signal')
        self.title_from = "&nbsp;"
        self.title_to = "&nbsp;"
        self.move_signal = ""
        widgets.MultipleSelectField.__init__(self, **kw)

