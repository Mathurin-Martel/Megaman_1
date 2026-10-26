shader_type canvas_item;

uniform bool using_shader=false;

const vec4 original_jaune = vec4(0.98, 0.89, 0.62, 1.00);
const vec4 original_blanc = vec4(0.98, 0.98, 0.98, 1.00);
const vec4 original_noir = vec4(0.00, 0.00, 0.00, 1.00);

uniform vec4 shader_color_1;
uniform vec4 shader_color_2;
uniform vec4 shader_color_3;

void fragment() {
	if (using_shader){
		vec4 og_pixel_color = texture(TEXTURE, UV);
		if (distance(texture(TEXTURE, UV), original_jaune) < 0.012){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur
			COLOR = shader_color_1;
		}
		else if (distance(texture(TEXTURE, UV), original_blanc) < 0.015){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur
			COLOR = shader_color_2;
		}
		else if (distance(texture(TEXTURE, UV), original_noir) < 0.004){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur. 
			//Mais uniquement pour ordinateur. Pour les autres ca va.
			COLOR = shader_color_3;
		}
	}
}