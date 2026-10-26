shader_type canvas_item;

const vec4 original_bleu = vec4(0.00,0.45,0.96,1.00);
const vec4 original_bleu_clair = vec4(0.00,1.00,1.00,1.00);

uniform bool using_shader;
uniform bool invisible_sprite;

uniform vec4 shader_color_1;
uniform vec4 shader_color_2;

void fragment() {
	if (using_shader){
		vec4 og_pixel_color = texture(TEXTURE, UV);
		if (distance(texture(TEXTURE, UV), original_bleu) < 0.015){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur
			COLOR = shader_color_1;
		}
		else if (distance(texture(TEXTURE, UV), original_bleu_clair) < 0.01){
			COLOR = shader_color_2;
		}
	}
	if (invisible_sprite){
		COLOR = vec4(0.00, 0.00, 0.00, 0.00);
	}
}