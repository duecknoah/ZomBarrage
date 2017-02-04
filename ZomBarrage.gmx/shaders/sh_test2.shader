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
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    // Original colours
    vec4 orgHairCol = vec4 (110.0, 95.0, 5.0, 1.0);
    // New colours
    vec4 newHairCol = vec4(255.0, 0.0, 0.0, 1.0);
    
    vec4 finalHairCol = texture2D(gm_BaseTexture, v_vTexcoord);
    
    if (finalHairCol == vec4(orgHairCol.r / 255.0, orgHairCol.g / 255.0, orgHairCol.b / 255.0, orgHairCol.a / 255.0)) {
        finalHairCol = newHairCol;
    }
    
    vec4 finalCol = finalHairCol;
    
    gl_FragColor = finalCol;
}
