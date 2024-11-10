shader_type canvas_item;

uniform sampler2D mask_texture;

void fragment() {
    // Sample the mask texture
    vec4 mask_color = texture(mask_texture, UV);
    
    // If the pixel is white (close to 1), make it transparent
    // If the pixel is black (close to 0), keep it opaque
    if (mask_color.r > 0.5 && mask_color.g > 0.5 && mask_color.b > 0.5) {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);  // Transparent for white areas
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);  // Opaque black for black areas
    }
}