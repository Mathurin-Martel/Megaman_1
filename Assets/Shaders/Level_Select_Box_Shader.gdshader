shader_type canvas_item;

const vec4 original_bleu = vec4(0.23,0.73,0.98,1.00);
const vec4 original_bleu_clair = vec4(0.61,0.98,0.94,1.00);
const vec4 original_jaune = vec4(0.94,0.73,0.23,1.00);

const vec4 shader_color_1 = vec4(0.98,0.76,0.84,1.00);
const vec4 shader_color_2 = vec4(0.98,0.98,0.98,1.00);
const vec4 shader_color_3 = vec4(0.00,0.00,0.00,1.00);

uniform bool using_shader = false;
uniform bool level_beaten = false;

void fragment() {
	if (using_shader){
		if (distance(texture(TEXTURE, UV), original_bleu) < 0.015){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur
			COLOR = shader_color_1;
		}
		else if (distance(texture(TEXTURE, UV), original_bleu_clair) < 0.015){
			COLOR = shader_color_2;
		}
	}
	if (level_beaten){
		if (distance(texture(TEXTURE, UV), original_jaune) < 0.015){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur
			COLOR = shader_color_3;
		}
	}
}