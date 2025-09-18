### 📄 ofApp.h
```cpp
#pragma once
#include "ofMain.h"
#include "ofEasyCam.h"

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);

private:
    std::vector<glm::vec3> spherePositions; // Todas las posiciones de las esferas

    // Parámetros que afectan forma/onda
    int xStep = 50;
    int yStep = 50;
    float distDiv = 100.0f;
    float amplitud = 100.0f;
    void mousePressed(int x, int y, int button);
    void convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd);
    bool rayIntersectsSphere(const glm::vec3& rayStart, const glm::vec3& rayDir, const glm::vec3& sphereCenter, float sphereRadius, glm::vec3& intersectionPoint);
    void generateGrid();

    ofEasyCam cam;

};

// Selección de esfera
bool sphereSelected = false; // Si hay una esfera seleccionada
glm::vec3 selectedSpherePosition; // Coordenadas de la seleccionada
```

### OfApp.cpp

```cpp
#include "ofApp.h"

void ofApp::setup() {
    ofBackground(0);
    generateGrid();
}

void ofApp::generateGrid() {
    spherePositions.clear(); // Limpia esferas anteriores

    for (int x = -ofGetWidth() / 2; x < ofGetWidth() / 2; x += xStep) {
        for (int y = -ofGetHeight() / 2; y < ofGetHeight() / 2; y += yStep) {
            float z = cos(ofDist(x, y, 0, 0) / distDiv) * amplitud;
            spherePositions.push_back(glm::vec3(x, y, z));
        }
    }
}

void ofApp::update() {
}

void ofApp::draw() {
    cam.begin();

    // Primero calculamos minHeight y maxHeight para normalizar la posición Y
    float minHeight = FLT_MAX;
    float maxHeight = -FLT_MAX;

    for (auto& pos : spherePositions) {
        if (pos.y < minHeight) minHeight = pos.y;
        if (pos.y > maxHeight) maxHeight = pos.y;
    }

    for (auto& pos : spherePositions) {
        if (sphereSelected && pos == selectedSpherePosition) {
            ofSetColor(255, 0, 0); // Rojo para la esfera seleccionada
            ofDrawSphere(pos, 8);  // Más grande
        }
        else {
            // Color basado en la altura
            float normalizedHeight = ofMap(pos.y, minHeight, maxHeight, 0.0f, 1.0f);

            // Interpolamos entre azul (bajo) y amarillo (alto).
            ofColor color = ofColor::blue.getLerped(ofColor::yellow, normalizedHeight);
            ofSetColor(color);

            ofDrawSphere(pos, 5); // Tamaño normal
        }
    }

    cam.end();

    // Mostrar coordenadas si hay una esfera seleccionada
    if (sphereSelected) {
        std::string info = "Esfera seleccionada en: (" +
            std::to_string((int)selectedSpherePosition.x) + ", " +
            std::to_string((int)selectedSpherePosition.y) + ", " +
            std::to_string((int)selectedSpherePosition.z) + ")";
        ofSetColor(0, 255, 0);
        ofDrawBitmapString(info, 20, 20);
    }
}



ofEasyCam cam;


void ofApp::keyPressed(int key) {
    switch (key) {
    case '+':
        xStep = std::max(10, xStep - 5);
        yStep = std::max(10, yStep - 5);
        generateGrid();
        break;
    case '-':
        xStep += 5;
        yStep += 5;
        generateGrid();
        break;
    case 'a':
        amplitud += 10.0f;
        generateGrid();
        break;
    case 'z':
        amplitud = std::max(0.0f, amplitud - 10.0f);
        generateGrid();
        break;
    case 'd':
        distDiv += 10.0f;
        generateGrid();
        break;
    case 'c':
        distDiv = std::max(10.0f, distDiv - 10.0f);
        generateGrid();
        break;
    }
}

void ofApp::mousePressed(int x, int y, int button) {
    // Convertir el clic del mouse en un rayo 3D
    glm::vec3 rayStart, rayEnd;
    convertMouseToRay(x, y, rayStart, rayEnd);

    // Comenzar asumiendo que no hay esfera seleccionada
    sphereSelected = false;

    // Recorrer todas las esferas
    for (auto& pos : spherePositions) {
        glm::vec3 intersectionPoint;
        if (rayIntersectsSphere(rayStart, rayEnd - rayStart, pos, 5.0, intersectionPoint)) {
            // Si hay intersección, guardar la esfera seleccionada
            selectedSpherePosition = pos;
            sphereSelected = true;
            break; // Salir después de seleccionar una
        }
    }
}

void ofApp::convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd) {
    glm::mat4 modelview = cam.getModelViewMatrix();
    glm::mat4 projection = cam.getProjectionMatrix();
    ofRectangle viewport = ofGetCurrentViewport();

    float x = 2.0f * (mouseX - viewport.x) / viewport.width - 1.0f;
    float y = 1.0f - 2.0f * (mouseY - viewport.y) / viewport.height;

    glm::vec4 rayStartNDC(x, y, -1.0f, 1.0f);
    glm::vec4 rayEndNDC(x, y, 1.0f, 1.0f);

    glm::vec4 rayStartWorld = glm::inverse(projection * modelview) * rayStartNDC;
    glm::vec4 rayEndWorld = glm::inverse(projection * modelview) * rayEndNDC;

    rayStartWorld /= rayStartWorld.w;
    rayEndWorld /= rayEndWorld.w;

    rayStart = glm::vec3(rayStartWorld);
    rayEnd = glm::vec3(rayEndWorld);
}

bool ofApp::rayIntersectsSphere(const glm::vec3& rayStart, const glm::vec3& rayDir, const glm::vec3& sphereCenter, float sphereRadius, glm::vec3& intersectionPoint) {
    glm::vec3 oc = rayStart - sphereCenter;

    float a = glm::dot(rayDir, rayDir);
    float b = 2.0f * glm::dot(oc, rayDir);
    float c = glm::dot(oc, oc) - sphereRadius * sphereRadius;

    float discriminant = b * b - 4 * a * c;

    if (discriminant < 0) {
        return false;
    }
    else {
        float t = (-b - sqrt(discriminant)) / (2.0f * a);
        intersectionPoint = rayStart + t * rayDir;
        return true;
    }
}
```