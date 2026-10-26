shader_type canvas_item;

const vec4 original_rouge = vec4(0.89,0.00,0.34,1.00);

uniform bool using_shader;

//Ici c'est la liste des couleurs utilisés. On va les changer depuis le gdscript
uniform vec4 shader_color;

void fragment() {
	if (using_shader){
		vec4 og_pixel_color = texture(TEXTURE, UV);
		if (distance(texture(TEXTURE, UV), original_rouge) < 0.0066){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur
			COLOR = shader_color;
		}
	}
}