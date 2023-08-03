shader_type canvas_item;

//hace el link con godot/inspector/gdscript
uniform vec3 color: source_color = vec3(1);
uniform float progress: hint_range(0.0, 1.0, 0.1) = 0;

// fragment : color y alpha de cada pixel
void fragment() {
	float current_a = texture(TEXTURE, UV).a;  //TEXTURE es el sprite, .a elige el alpha value
	//COLOR= vec4(UV.x,1,1,1); //UV es la posicion del pixel, a medida q X aumente, va de 0 a 1, 1 es rojo, por lo q la imagens e vuelve blanca
	//COLOR = vec4(1,1,1,0.5); // vec4 es color
//
	//mix mezcla dos valores, dos vector 4 en este caso, la imagen -primer argumento- y otro vec4 todo blanco y el current alpha
	// 1.0 significa tennes todo del 2do vector y nada del primero
	vec4 target_color = mix(texture(TEXTURE,UV), vec4(color, current_a), progress);
	COLOR = target_color;
//	if (current_a == 1.0){
//		COLOR = vec4(1,1,1,1);
//	}
	
	
}

// position de cada single pixel
//void vertex(){
//
//}
