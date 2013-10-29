uniform mat4 modelviewMatrix;
uniform mat4 transformMatrix;
uniform mat3 normalMatrix;
uniform mat4 texMatrix;

uniform vec4 lightPosition;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec3 ecNormal;
varying vec4 vertColor;
varying vec4 vertTexCoord;

varying vec3 lightDir;

void main() {
  gl_Position = transformMatrix * position;    
  vec3 ecPosition = vec3(modelviewMatrix * position);  
  ecNormal = normalize(normalMatrix * normal);
  vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0);
  lightDir = normalize(lightPosition.xyz - ecPosition);  
  vertColor = color;
}