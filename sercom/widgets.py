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

AlumnoMultiSelectAjax = '''
    function agregar_a_la_lista(texto, lista)
    {
        t = MochiKit.DOM.getElement(texto);
        MochiKit.DOM.appendChildNodes(lista, OPTION(t.value));
        t.value = "";
    }

    function sacar_de_la_lista(lista)
    {
        l = MochiKit.DOM.getElement(lista);
        if (l.selectedIndex < 0) return;

        for (i=l.selectedIndex; i<l.options.length-1;i++)
            l.options[i] = l.options[i+1];
    }
'''

class AlumnoMultiSelect(widgets.MultipleSelectField):
    template = '''
    <table xmlns:py="http://purl.org/kid/ns#" style="border:none; width:0%;">  
    <tr><td>
    <input type="text" id="${field_id}_nuevo" /><input type="button" id="_agregar" value="Agregar"
        onClick=" agregar_a_la_lista('${field_id}_nuevo', '${field_id}'); " />
    </td></tr>
    <tr><td>
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
    </td></tr>
    <tr><td align="center">
    <input type="button" id="_sacar" value="Borrar"
        onClick="sacar_de_la_lista('${field_id}'); " />
    </td></tr>
    </table>
    '''
    javascript = [widgets.JSSource(AlumnoMultiSelectAjax)]

