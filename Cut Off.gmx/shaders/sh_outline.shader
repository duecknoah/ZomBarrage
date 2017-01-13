//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Draws an outline around the sprite. The outline colour is determined
// by the background fill color that is 100% transparent. So the colour is 
// kept, but the alpha is 0.
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float pixelW;
uniform float pixelH;

void main()
{
    vec2 offsetX;
    offsetX.x = pixelW;
    vec2 offsetY;
    offsetY.y = pixelH;
    
    float alpha = texture2D( gm_BaseTexture, v_vTexcoord ).a;
    
    alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord + offsetX ).a);
    alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord - offsetX ).a);
    alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord + offsetY ).a);
    alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord - offsetY ).a);
    
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor.a = alpha;
}
