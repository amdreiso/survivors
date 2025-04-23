
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
	vec4 mul = vec4( 0.85, 0.07, 0.74, 1.0 );
	vec4 finalColor = v_vColour * mul;
	
  gl_FragColor = finalColor * texture2D( gm_BaseTexture, v_vTexcoord );
}
