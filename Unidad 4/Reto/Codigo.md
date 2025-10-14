# OfApp.h:

```cpp
#pragma once
#include "ofMain.h"

// --------------------------- Nodo para la lista enlazada (trazo) ---------------------------
class Node {
public:
    float x, y;
    Node* next;

    Node(float _x, float _y);
    ~Node();
};

// --------------------------- Lista enlazada (trazo) ---------------------------
class LinkedList {
public:
    Node* head;
    Node* tail;
    int size;
    int maxNodes; // límite para evitar sobrecarga

    LinkedList(int maxN = 60); // por defecto 60 nodos
    ~LinkedList();

    void clear();
    void addNode(float x, float y);   // añade al final (tail)
    void removeHead();                // elimina el primer nodo (head)
    void update(float x, float y);    // propaga la posición como "serpiente"
    void display();
};

// --------------------------- Nodo para la queue de gotas ---------------------------
class Drop {
public:
    float x, y;
    float vy;      // velocidad vertical
    float radius;
    ofColor color;
    Drop* next;

    Drop(float _x, float _y, const ofColor& c);
    ~Drop();
};

// --------------------------- Queue para gotas (FIFO) ---------------------------
class DropQueue {
public:
    Drop* front;
    Drop* rear;
    int size;

    DropQueue();
    ~DropQueue();

    void enqueue(float x, float y, const ofColor& c);
    void dequeue();    // desencola (libera memoria)
    void clear();

    void update();     // solo lógica física (posiciones, eliminar fuera de pantalla)
    void draw();       // solo dibujo
};

// --------------------------- ofApp ---------------------------
class ofApp : public ofBaseApp {
public:
    LinkedList stroke;    // trazos que siguen el mouse
    DropQueue drops;      // gotas que caen desde el trazo

    bool dropsActive;     // 'A' activa/desactiva encolado de gotas
    int dropInterval;     // frames entre encolados
    int frameCounter;
    ofColor dropColor;    // color actual de las gotas

    float lastMouseX, lastMouseY; // para detectar movimiento
    float addDistanceThreshold;   // distancia mínima para añadir nodo

    void setup();
    void update();
    void draw();

    void keyPressed(int key);
    void mouseMoved(int x, int y);

    // helpers
    void trySpawnDropFromStroke();
};
```


# OfApp.cpp:

```cpp
#include "ofApp.h"
#include <cmath>

// --------------------------- Node (trazo) ---------------------------
Node::Node(float _x, float _y) {
    x = _x; y = _y;
    next = nullptr;
}
Node::~Node() {
    // no recursos extra aquí
}

// --------------------------- LinkedList ---------------------------
LinkedList::LinkedList(int maxN) {
    head = nullptr;
    tail = nullptr;
    size = 0;
    maxNodes = maxN;
}

LinkedList::~LinkedList() {
    clear();
}

void LinkedList::clear() {
    Node* current = head;
    while (current != nullptr) {
        Node* nextNode = current->next;
        delete current;
        current = nextNode;
    }
    head = nullptr;
    tail = nullptr;
    size = 0;
}

void LinkedList::addNode(float x, float y) {
    Node* newNode = new Node(x, y);
    if (tail != nullptr) {
        tail->next = newNode;
        tail = newNode;
    }
    else {
        head = tail = newNode;
    }
    size++;

    // mantener el tamaño dentro del max
    while (size > maxNodes) {
        removeHead();
    }
}

void LinkedList::removeHead() {
    if (head == nullptr) return;
    Node* tmp = head;
    head = head->next;
    if (head == nullptr) tail = nullptr;
    delete tmp;
    size--;
}

void LinkedList::update(float x, float y) {
    Node* current = head;
    float prevX = x;
    float prevY = y;

    while (current != nullptr) {
        float tempX = current->x;
        float tempY = current->y;
        current->x = prevX;
        current->y = prevY;
        prevX = tempX;
        prevY = tempY;
        current = current->next;
    }
}

void LinkedList::display() {
    Node* current = head;
    float radius = 8;
    while (current != nullptr) {
        ofSetColor(30, 30, 30, 200); // trazo oscuro semi-transparente
        ofDrawCircle(current->x, current->y, radius);
        current = current->next;
        radius = std::max(2.0f, radius - 0.1f); // degradado de radio
    }
}

// --------------------------- Drop ---------------------------
Drop::Drop(float _x, float _y, const ofColor& c) {
    x = _x; y = _y;
    vy = ofRandom(1.0f, 3.5f);
    radius = ofRandom(4.0f, 10.0f);
    color = c;
    next = nullptr;
}
Drop::~Drop() {
    // no recursos extra
}

// --------------------------- DropQueue ---------------------------
DropQueue::DropQueue() {
    front = rear = nullptr;
    size = 0;
}

DropQueue::~DropQueue() {
    clear();
}

void DropQueue::enqueue(float x, float y, const ofColor& c) {
    Drop* newDrop = new Drop(x, y, c);
    if (rear == nullptr) {
        front = rear = newDrop;
    }
    else {
        rear->next = newDrop;
        rear = newDrop;
    }
    size++;
}

void DropQueue::dequeue() {
    if (front == nullptr) return;
    Drop* tmp = front;
    front = front->next;
    if (front == nullptr) rear = nullptr;
    delete tmp;
    size--;
}

void DropQueue::clear() {
    while (front != nullptr) {
        dequeue();
    }
}

void DropQueue::update() {
    Drop* current = front;
    while (current != nullptr) {
        current->y += current->vy;
        current->vy += 0.05f; // aceleración/gravedad leve
        current = current->next;
    }

    // desencolar las gotas que ya salieron de pantalla (front hacia afuera)
    while (front != nullptr && front->y - front->radius > ofGetHeight()) {
        dequeue();
    }
}

void DropQueue::draw() {
    Drop* current = front;
    while (current != nullptr) {
        ofSetColor(current->color);
        ofFill();
        ofDrawCircle(current->x, current->y, current->radius);
        // cola/cola alargada para efecto "chorro"
        ofSetColor(current->color, 80);
        ofDrawRectangle(current->x - current->radius * 0.3f, current->y - current->radius * 0.2f, current->radius * 0.6f, current->radius * 1.5f);
        current = current->next;
    }
}

// --------------------------- ofApp ---------------------------
void ofApp::setup() {
    ofSetBackgroundColor(220);    // gris por defecto
    ofSetFrameRate(60);

    // inicializamos lista con algunos nodos centrados (como en el ejemplo)
    stroke = LinkedList(80);
    for (int i = 0; i < 10; i++) {
        stroke.addNode(ofGetWidth() / 2, ofGetHeight() / 2);
    }

    drops = DropQueue();
    dropsActive = false;
    dropInterval = 6; // cada 6 frames se genera una gota si dropsActive
    frameCounter = 0;
    dropColor = ofColor(30, 140, 200); // color inicial
    lastMouseX = ofGetMouseX();
    lastMouseY = ofGetMouseY();
    addDistanceThreshold = 4.0f; // distancia mínima para añadir nodo
}

void ofApp::update() {
    frameCounter++;

    float mx = ofGetMouseX();
    float my = ofGetMouseY();

    // Si el mouse se movió lo suficiente, añadimos un nodo al final
    float dx = mx - lastMouseX;
    float dy = my - lastMouseY;
    if (sqrt(dx * dx + dy * dy) > addDistanceThreshold) {
        stroke.addNode(mx, my);
        lastMouseX = mx;
        lastMouseY = my;
    }

    // Propagar posiciones en la lista (serpiente)
    stroke.update(mx, my);

    // Si las gotas están activas, intentar encolar periódicamente desde el tail de la lista
    if (dropsActive) {
        if (frameCounter % dropInterval == 0) {
            trySpawnDropFromStroke();
        }
    }

    // SOLO actualizar la física de las gotas (sin dibujar)
    drops.update();
}

void ofApp::draw() {
    // Pintamos el fondo (gris) una vez por frame
    ofBackground(220);

    // Dibuja el trazo (lista)
    stroke.display();

    // Dibuja las gotas (ahora aquí, después de pintar el fondo)
    drops.draw();

    // info en pantalla:
    ofSetColor(0);
    ofDrawBitmapString("A: toggle drops | C: clear | V: change color", 10, 20);
    ofDrawBitmapString("Drops: " + ofToString(drops.size) + "  |  Stroke nodes: " + ofToString(stroke.size), 10, 36);
}

void ofApp::keyPressed(int key) {
    if (key == 'a' || key == 'A') {
        dropsActive = !dropsActive;
    }
    else if (key == 'c' || key == 'C') {
        // limpiar lista y cola (libera toda la memoria)
        stroke.clear();
        drops.clear();
        // volver a iniciar unos nodos base como en el ejemplo
        for (int i = 0; i < 6; i++) {
            stroke.addNode(ofGetWidth() / 2, ofGetHeight() / 2);
        }
    }
    else if (key == 'v' || key == 'V') {
        // cambiar color de las gotas (aleatorio)
        dropColor = ofColor(ofRandom(40, 255), ofRandom(40, 255), ofRandom(40, 255));
        // Si querés que el color cambie también en gotas ya existentes:
        // recorres drops.front.. y asignas current->color = dropColor;
    }
}

void ofApp::mouseMoved(int x, int y) {
    // nada extra aquí (adición de nodos manejada por update())
}

// --------------------------- helper: genera gota desde la posición del tail ---------------------------
void ofApp::trySpawnDropFromStroke() {
    // intentar spawn desde tail; si no existe tail, buscar otro nodo
    if (stroke.tail == nullptr) {
        // si no hay tail, intentar tomar head
        if (stroke.head == nullptr) return;
        drops.enqueue(stroke.head->x + ofRandom(-4, 4), stroke.head->y + ofRandom(0, 3), dropColor);
        return;
    }

    float sx = stroke.tail->x;
    float sy = stroke.tail->y;

    float spawnX = sx + ofRandom(-4.0f, 4.0f);
    float spawnY = sy + ofRandom(0.0f, 3.0f);
    drops.enqueue(spawnX, spawnY, dropColor);
}
```
