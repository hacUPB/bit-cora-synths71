OfApp.h:

#pragma once

#include "ofMain.h"

// Nodo básico reutilizado para ambas estructuras
class Node {
public:
    ofVec2f position;
    ofColor color;
    Node* next;

    Node(float x, float y, ofColor c);
    ~Node();
};

// Lista enlazada (para seguir el mouse)
class LinkedList {
public:
    Node* head;
    Node* tail;
    int maxSize;

    LinkedList(int _maxSize = 100);
    ~LinkedList();

    void addNode(float x, float y, ofColor c);
    void display();
    void clear();
};

// Cola (para gotas que caen)
class Queue {
public:
    Node* front;
    Node* rear;

    Queue();
    ~Queue();

    void enqueue(float x, float y, ofColor c);
    void update(float speed); // Caída
    void display();
    void dequeue(); // eliminar el primero
    void clear();
};

class ofApp : public ofBaseApp {

public:
    LinkedList trail;
    Queue fallingDrops;

    ofColor currentColor;
    bool raining;

    void setup();
    void update();
    void draw();
    void keyPressed(int key);
};







OfApp.cpp:

#include "ofApp.h"

// ========== NODE ==========
Node::Node(float x, float y, ofColor c) {
    position.set(x, y);
    color = c;
    next = nullptr;
}

Node::~Node() {
    // Destructor, por si luego agregamos recursos
}

// ========== LINKED LIST ==========

LinkedList::LinkedList(int _maxSize) {
    head = nullptr;
    tail = nullptr;
    maxSize = _maxSize;
}

LinkedList::~LinkedList() {
    clear();
}

void LinkedList::addNode(float x, float y, ofColor c) {
    Node* newNode = new Node(x, y, c);
    if (tail != nullptr) {
        tail->next = newNode;
        tail = newNode;
    } else {
        head = tail = newNode;
    }

    // Limitar tamaño
    int count = 1;
    Node* current = head;
    Node* prev = nullptr;
    while (current != nullptr && count <= maxSize) {
        prev = current;
        current = current->next;
        count++;
    }
    if (current != nullptr) {
        if (prev != nullptr) prev->next = nullptr;
        while (current != nullptr) {
            Node* temp = current;
            current = current->next;
            delete temp;
        }
        tail = prev;
    }
}

void LinkedList::display() {
    Node* current = head;
    while (current != nullptr) {
        ofSetColor(current->color);
        ofDrawCircle(current->position.x, current->position.y, 5);
        current = current->next;
    }
}

void LinkedList::clear() {
    Node* current = head;
    while (current != nullptr) {
        Node* nextNode = current->next;
        delete current;
        current = nextNode;
    }
    head = tail = nullptr;
}

// ========== QUEUE ==========

Queue::Queue() {
    front = rear = nullptr;
}

Queue::~Queue() {
    clear();
}

void Queue::enqueue(float x, float y, ofColor c) {
    Node* newNode = new Node(x, y, c);
    if (rear == nullptr) {
        front = rear = newNode;
    } else {
        rear->next = newNode;
        rear = newNode;
    }
}

void Queue::update(float speed) {
    Node* current = front;
    Node* prev = nullptr;

    while (current != nullptr) {
        current->position.y += speed;
        if (current->position.y > ofGetHeight()) {
            Node* toDelete = current;
            if (prev == nullptr) {
                front = current->next;
            } else {
                prev->next = current->next;
            }

            if (current == rear) {
                rear = prev;
            }

            current = current->next;
            delete toDelete;
        } else {
            prev = current;
            current = current->next;
        }
    }
}

void Queue::display() {
    Node* current = front;
    while (current != nullptr) {
        ofSetColor(current->color);
        ofDrawCircle(current->position.x, current->position.y, 10);
        current = current->next;
    }
}

void Queue::clear() {
    while (front != nullptr) {
        dequeue();
    }
}

void Queue::dequeue() {
    if (front != nullptr) {
        Node* temp = front;
        front = front->next;
        if (front == nullptr) rear = nullptr;
        delete temp;
    }
}

// ========== APP ==========

void ofApp::setup() {
    ofSetBackgroundColor(0);
    currentColor = ofColor::fromHsb(ofRandom(255), 200, 255);
    raining = false;
}

void ofApp::update() {
    // Seguir al mouse
    trail.addNode(ofGetMouseX(), ofGetMouseY(), currentColor);

    // Simular caída
    if (raining && ofGetFrameNum() % 5 == 0) {
        fallingDrops.enqueue(ofGetMouseX(), ofGetMouseY(), currentColor);
    }

    fallingDrops.update(3.0); // velocidad de caída
}

void ofApp::draw() {
    trail.display();
    fallingDrops.display();
}

void ofApp::keyPressed(int key) {
    if (key == 'a') {
        raining = !raining;
    } else if (key == 'c') {
        trail.clear();
        fallingDrops.clear();
    } else if (key == 'v') {
        currentColor = ofColor::fromHsb(ofRandom(255), 200, 255);
    }
}
