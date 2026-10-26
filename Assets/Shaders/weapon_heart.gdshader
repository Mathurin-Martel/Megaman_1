shader_type canvas_item;

const vec4 original_rouge = vec4(0.89,0.00,0.34,1.00);
const vec4 original_orange = vec4(0.98,0.59,0.21,1.00);
const vec4 original_noir = vec4(0.00,0.00,0.00,1.00);

uniform bool using_shader;
uniform bool seconde_phase;

//Ici c'est la liste des couleurs utilisés. On va les changer depuis le gdscript
uniform vec4 shader_color_1_1;
uniform vec4 shader_color_1_2;
uniform vec4 shader_color_1_3;
uniform vec4 shader_color_2_1;
uniform vec4 shader_color_2_2;
uniform vec4 shader_color_2_3;

void fragment() {
	if (using_shader){
		vec4 og_pixel_color = texture(TEXTURE, UV);
		if (distance(texture(TEXTURE, UV), original_orange) < 0.015){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur
			if (!seconde_phase){ COLOR = shader_color_1_1; }
			else { COLOR = shader_color_2_1; }
		}
		else if (distance(texture(TEXTURE, UV), original_rouge) < 0.01){
			if (!seconde_phase){ COLOR = shader_color_1_2; }
			else { COLOR = shader_color_2_2; }
		}
		else if (distance(texture(TEXTURE, UV), original_noir) < 0.001){
			if (!seconde_phase){ COLOR = shader_color_1_3; }
			else { COLOR = shader_color_2_3; }
		}
	}
}