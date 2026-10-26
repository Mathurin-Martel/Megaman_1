shader_type canvas_item;

const vec4 original_blanc = vec4(0.98,0.98,0.98,1.00);
const vec4 original_light_gris = vec4(0.73,0.73,0.73,1.00);
const vec4 original_gris = vec4(0.45,0.45,0.45,1.00);

uniform bool using_shader;

uniform vec4 color_1;
uniform vec4 color_2;
uniform vec4 color_3;

void fragment() {
	if (using_shader){
		vec4 og_pixel_color = texture(TEXTURE, UV);
		if (distance(texture(TEXTURE, UV), original_blanc) < 0.015){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur
			COLOR = color_1;
		}
		else if (distance(texture(TEXTURE, UV), original_light_gris) < 0.0126){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur
			COLOR = color_2;
		}
		else if (distance(texture(TEXTURE, UV), original_gris) < 0.0085){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur
			COLOR = color_3;
		}
	}
}
