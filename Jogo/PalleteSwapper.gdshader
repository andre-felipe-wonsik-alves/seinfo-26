shader_type canvas_item;

uniform sampler2D newPalette;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	// qual cor vai ser substituida
	float brightness = (pixelColor.r + pixelColor.g + pixelColor.b)/3.0;
	
	vec4 gradientColor = texture(newPalette, vec2(brightness));
	COLOR = vec4(gradientColor.rgb, pixelColor.a);
}
