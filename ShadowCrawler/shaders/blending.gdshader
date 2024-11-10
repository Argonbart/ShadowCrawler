shader_type canvas_item;

uniform sampler2D lightcone_texture : hint_screen_texture;
uniform sampler2D previous_texture;

void fragment() {

    // Sample each texture at the current UV coordinates
    vec4 color1 = texture(lightcone_texture, UV);
    vec4 color2 = texture(previous_texture, UV);

    // Combine colors by taking the maximum of each color channel
	vec4 combined_color = max(color1, color2);

    // Set the fragment color to the combined result
	COLOR = combined_color;
}
