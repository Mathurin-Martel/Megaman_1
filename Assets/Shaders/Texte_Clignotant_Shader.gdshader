shader_type canvas_item;

const vec4 original_blanc = vec4(0.98,0.98,0.98,1.00);
const vec4 remplacement_light_bleu = vec4(0.00,0.90,0.84,1.00);

uniform bool using_shader=false;

void fragment() {
	if (using_shader){
		vec4 og_pixel_color = texture(TEXTURE, UV);
		if (distance(texture(TEXTURE, UV), original_blanc) < 0.015){
			//Je sais pas pourquoi mais en dessous de cette valeur il ne reconnait pas la couleur
			COLOR = remplacement_light_bleu;
		}
	}
}
