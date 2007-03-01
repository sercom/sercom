# Custom useful widget
#

from turbogears import widgets

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

MultiSelectAjax = '''

    function _on_alumno_get_result(lista, loading, results)
    {
        load = MochiKit.DOM.getElement(loading);
        load.style.visibility = 'hidden';
        if (results.error) {
            alert(results.msg);
            return;
        }
        MochiKit.DOM.appendChildNodes(lista, OPTION({'value':results.msg.id}, results.msg.value));
        l = MochiKit.DOM.getElement(lista);
    }

    function _on_alumno_get_error(loading, results)
    {
        alert(results)
        load = MochiKit.DOM.getElement(loading);
        load.style.visibility = 'hidden';
    }

    function sacar_de_la_lista(lista)
    {
        l = MochiKit.DOM.getElement(lista);
        if (l.selectedIndex < 0) return;
        
        /* caso especial, 1 solo item */
        if (l.options.length == 1) {
            l.options.length = 0
            return;
        }

        for (i=l.selectedIndex; i<l.options.length-1;i++)
            l.options[i] = l.options[i+1];
    }

    function _do_add(callback, texto, lista, loading)
    {
        url = callback(texto, lista);
        t = MochiKit.DOM.getElement(texto);

        /* Como no se si se puede hacer de otra manera, asumo que tengo en
         * el form un Combo que se llama curso en el codigo, y tiro error si
         * no existe
         */
        curso = MochiKit.DOM.getElement('form_cursoID');
        if (!curso) {
            alert("No deberias ver esto, y quiere decir que tu form esta roto.\\nTe falta un combo de curso");
            return;
        }
        if (curso.options[curso.selectedIndex].value <= 0) {
            alert('Debes seleccionar un curso primero');
            return;
        }
        load = MochiKit.DOM.getElement(loading);
        load.style.visibility = 'visible';
        var d = loadJSONDoc(url);
        d.addCallbacks(partial(_on_alumno_get_result, lista, loading), partial(_on_alumno_get_error, loading));
    }

'''

class AjaxMultiSelect(widgets.MultipleSelectField):
    template = '''
    <div style="width:250px" xmlns:py="http://purl.org/kid/ns#">  
    <div>
    <input type="text" id="${field_id}_nuevo" size="10" />
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

    def __init__(self, **kw):
        self.params.append('on_add')
        self.on_add = "alert('Not defined action');"
        widgets.MultipleSelectField.__init__(self, **kw)
