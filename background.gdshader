shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV + vec2(0, 0));
}
