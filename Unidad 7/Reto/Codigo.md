# OfApp.cpp

```cpp
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
	ofDisableArbTex();
	if(ofIsGLProgrammableRenderer()){
		shaderBlurX.load("shadersGL3/shaderBlurX");
		shaderBlurY.load("shadersGL3/shaderBlurY");
	}else{
		shaderBlurX.load("shadersGL2/shaderBlurX");
		shaderBlurY.load("shadersGL2/shaderBlurY");
	}

	image.load("reto.jpg");
	
	fboBlurOnePass.allocate(image.getWidth(), image.getHeight());
	fboBlurTwoPass.allocate(image.getWidth(), image.getHeight());
}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
	
	float blur = ofMap(mouseX, 0, ofGetWidth(), 4, 0, true);

	
	//----------------------------------------------------------
	fboBlurOnePass.begin();
	
	shaderBlurX.begin();
	shaderBlurX.setUniform1f("mousePos", mouseX / float(ofGetWidth()));

	shaderBlurX.setUniform1f("blurAmnt", blur);
	shaderBlurX.setUniform1f("texwidth", image.getWidth());

	shaderBlurX.setUniformTexture("originalTex", image.getTexture(), 1);
	shaderBlurX.setUniform4f("tintColor", 1.0, 0.3, 0.6, 1.0); // rosado


	image.draw(0, 0);
	
	shaderBlurX.end();
	
	fboBlurOnePass.end();
	
	//----------------------------------------------------------
	fboBlurTwoPass.begin();
	
	shaderBlurY.begin();
	shaderBlurY.setUniform1f("mousePos", mouseX / float(ofGetWidth()));

	shaderBlurY.setUniform1f("blurAmnt", blur);
	shaderBlurY.setUniform1f("texheight", image.getHeight());
	shaderBlurY.setUniformTexture("originalTex", image.getTexture(), 1);
	shaderBlurY.setUniform4f("tintColor", 1.0, 0.3, 0.6, 1.0);

	
	fboBlurOnePass.draw(0, 0);
	
	shaderBlurY.end();
	
	fboBlurTwoPass.end();
	
	//----------------------------------------------------------
	ofSetColor(ofColor::white);
	fboBlurTwoPass.draw(0, 0);
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){
	
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y){
	
}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
```

# OfApp.h:

```cpp
#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp{
	public:
		
	void setup();
	void update();
	void draw();
	
	void keyPressed(int key);
	void keyReleased(int key);
	void mouseMoved(int x, int y);
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased(int x, int y, int button);
	void windowResized(int w, int h);
	void dragEvent(ofDragInfo dragInfo);
	void gotMessage(ofMessage msg);

	ofShader shaderBlurX;
	ofShader shaderBlurY;

	ofFbo fboBlurOnePass;
	ofFbo fboBlurTwoPass;
	
	ofImage image;
};
```

# shaderBlurX.frag:

```glsl
OF_GLSL_SHADER_HEADER

uniform sampler2D tex0;
uniform sampler2D originalTex;
uniform vec4 tintColor;

uniform float mousePos;


uniform float blurAmnt;
uniform float texwidth;

in vec2 texCoordVarying;
out vec4 outputColor;

// Gaussian weights from http://dev.theomader.com/gaussian-kernel-calculator/

void main()
{
	vec4 color = vec4(0.0, 0.0, 0.0, 0.0);

	color += 0.000229 * texture(tex0, texCoordVarying + vec2(blurAmnt * -4.0/texwidth, 0.0));
	color += 0.005977 * texture(tex0, texCoordVarying + vec2(blurAmnt * -3.0/texwidth, 0.0));
	color += 0.060598 * texture(tex0, texCoordVarying + vec2(blurAmnt * -2.0/texwidth, 0.0));
	color += 0.241732 * texture(tex0, texCoordVarying + vec2(blurAmnt * -1.0/texwidth, 0.0));

	color += 0.382928 * texture(tex0, texCoordVarying + vec2(0.0, 0));

	color += 0.241732 * texture(tex0, texCoordVarying + vec2(blurAmnt * 1.0/texwidth, 0.0));
	color += 0.060598 * texture(tex0, texCoordVarying + vec2(blurAmnt * 2.0/texwidth, 0.0));
	color += 0.005977 * texture(tex0, texCoordVarying + vec2(blurAmnt * 3.0/texwidth, 0.0));
	color += 0.000229 * texture(tex0, texCoordVarying + vec2(blurAmnt * 4.0/texwidth, 0.0));

  
vec4 original = texture(originalTex, texCoordVarying);


float reveal = smoothstep(0.5, 1.0, mousePos);


vec4 revealed = mix(original, color, reveal);


float tintAmount = 1.0 - reveal;
vec4 tinted = mix(revealed, tintColor, tintAmount * 0.6);

outputColor = tinted;


}
```

# shaderBlurY.frag:

```glsl
OF_GLSL_SHADER_HEADER

uniform sampler2D tex0;
uniform sampler2D originalTex;
uniform vec4 tintColor;

uniform float mousePos;

uniform float blurAmnt;
uniform float texheight;

in vec2 texCoordVarying;
out vec4 outputColor;

// Gaussian weights from http://dev.theomader.com/gaussian-kernel-calculator/

void main()
{
	vec4 color = vec4(0.0, 0.0, 0.0, 0.0);

	color += 0.000229 * texture(tex0, texCoordVarying + vec2(0.0, blurAmnt * 4.0/texheight));
	color += 0.005977 * texture(tex0, texCoordVarying + vec2(0.0, blurAmnt * 3.0/texheight));
	color += 0.060598 * texture(tex0, texCoordVarying + vec2(0.0, blurAmnt * 2.0/texheight));
	color += 0.241732 * texture(tex0, texCoordVarying + vec2(0.0, blurAmnt * 1.0/texheight));

	color += 0.382928 * texture(tex0, texCoordVarying + vec2(0.0, 0.0));

	color += 0.241732 * texture(tex0, texCoordVarying + vec2(0.0, blurAmnt * -1.0/texheight));
	color += 0.060598 * texture(tex0, texCoordVarying + vec2(0.0, blurAmnt * -2.0/texheight));
	color += 0.005977 * texture(tex0, texCoordVarying + vec2(0.0, blurAmnt * -3.0/texheight));
	color += 0.000229 * texture(tex0, texCoordVarying + vec2(0.0, blurAmnt * -4.0/texheight));
    
   
vec4 original = texture(originalTex, texCoordVarying);


float reveal = smoothstep(0.5, 1.0, mousePos);


vec4 revealed = mix(original, color, reveal);


float tintAmount = 1.0 - reveal;
vec4 tinted = mix(revealed, tintColor, tintAmount * 0.6);

outputColor = tinted;


}
```

# shaderBlurX.vert:

```glsl
OF_GLSL_SHADER_HEADER

// these are for the programmable pipeline system
uniform mat4 modelViewProjectionMatrix;
uniform mat4 textureMatrix;

in vec4 position;
in vec2 texcoord;
in vec4 normal;
in vec4 color;

out vec2 texCoordVarying;

void main()
{
    #ifdef INTEL_CARD
    color = vec4(1.0); // for intel HD cards
    normal = vec4(1.0); // for intel HD cards
    #endif

    texCoordVarying = texcoord;
	gl_Position = modelViewProjectionMatrix * position;
}
```

# shaderBlurY.vert:

```glsl
OF_GLSL_SHADER_HEADER

// these are for the programmable pipeline system
uniform mat4 modelViewProjectionMatrix;
uniform mat4 textureMatrix;

in vec4 position;
in vec2 texcoord;
in vec4 normal;
in vec4 color;

out vec2 texCoordVarying;

void main()
{
    #ifdef INTEL_CARD
    color = vec4(1.0); // for intel HD cards
    normal = vec4(1.0); // for intel HD cards
    #endif

    texCoordVarying = texcoord;
	gl_Position = modelViewProjectionMatrix * position;
}
```
