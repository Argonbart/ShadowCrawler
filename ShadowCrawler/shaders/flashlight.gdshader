shader_type canvas_item;

uniform vec2 light_origin;                        // Static position of the light source
uniform float cone_angle;                         // Half-angle of the cone in radians
uniform float cone_length;                        // Maximum length of the light cone
uniform vec4 light_color : source_color = vec4(1.0, 1.0, 0.8, 1.0); // Color of the light

uniform vec2 mouse_position;                      // Position of the mouse, set in GDScript

void fragment() {
    // Get the UV coordinates of the fragment
    vec2 uv = FRAGCOORD.xy;
    
    // Calculate the vector from the light origin to the current fragment
    vec2 light_direction = normalize(uv - light_origin);
    
    // Calculate the vector from the light origin to the mouse position
    vec2 cone_direction = normalize(mouse_position + vec2(480.0, 0.0) - light_origin);

    // Calculate the angle between the light direction and the cone direction
    float angle_to_cone = acos(dot(light_direction, cone_direction));

    // Calculate the distance from the light origin to this fragment
    float dist_to_light = distance(uv, light_origin);

    // Check if the fragment is within the cone angle and length
    if (angle_to_cone < cone_angle && dist_to_light < cone_length) {
        // Calculate the light intensity based on the distance to the light
        float intensity = 1.0 - (dist_to_light / cone_length);

        // Set the color of the fragment based on the light color and intensity
        //COLOR = light_color * intensity;
		COLOR = vec4(1.0, 1.0, 1.0, 1.0);
    } else {
        // Outside the cone, keep the color transparent or dark
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);  // You can set this to any color or alpha you like
    }
}
