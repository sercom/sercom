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
