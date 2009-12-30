 tinyMCE.init(
	{
		mode:"textareas",
		theme:"advanced",
		plugins:"table,paste",
		theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|formatselect,fontselect,fontsizeselect,|,charmap,|,removeformat",
		theme_advanced_buttons2 : "cut,copy,paste,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,image,code,|,forecolor,backcolor,|,table",
		theme_advanced_buttons3 : "",
                valid_elements : "a[href|id|target],img[src|alt|id|title],p[id],strong/b,em/i,iframe[*]," +
                        "ul,ol,li[type|value], dl,dt,dd" +
                        "blockquote,q,pre,code" +
                        "tbody,thead,tfoot," +
                        "-table[border|cellspacing|cellpadding|width|frame|rules|height|align|summary|bgcolor|background|bordercolor]," +
                        "-tr[rowspan|width|height|align|valign|bgcolor|background|bordercolor]," +
                        "#td[colspan|rowspan|width|height|align|valign|bgcolor|background|bordercolor|scope]," +
                        "#th[colspan|rowspan|width|height|align|valign|scope]," +
                        "object[height|width],param[name|value],embed[src|type|allowscriptaccess|allowfullscreen|height|width]"


	}
	);
