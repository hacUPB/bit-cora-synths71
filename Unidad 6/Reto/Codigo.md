# OfApp.cpp:

```cpp
#include "ofApp.h"

// ---------------- Subject ----------------
void Subject::addObserver(Observer * observer) {
	observers.push_back(observer);
}
void Subject::notify(const std::string & event) {
	for (Observer * obs : observers) {
		obs->onNotify(event);
	}
}

// ---------------- Planta Base ----------------
Planta::Planta() {
	position = ofVec2f(ofRandomWidth(), ofGetHeight());
	altura = 0;
	crecimiento = 1.0;
	color = ofColor::green;
	tipo = "generica";
	state = new GerminandoState();
}
Planta::~Planta() {
	delete state;
}
void Planta::update() {
	if (state) state->update(this);
}
void Planta::draw() {
	if (state) state->draw(this);
}
void Planta::setState(State * newState) {
	if (state) {
		state->onExit(this);
		delete state;
	}
	state = newState;
	if (state) state->onEnter(this);
}
void Planta::onNotify(const std::string & event) {
	if (event == "germinar")
		setState(new GerminandoState());
	else if (event == "crecer")
		setState(new CreciendoState());
	else if (event == "reposo")
		setState(new ReposoState());
	else if (event == "seca")
		setState(new SecaState());
}

// ---------------- Estados ----------------
void GerminandoState::onEnter(Planta * p) {
	p->altura = 0;
}
void GerminandoState::update(Planta * p) {
	p->altura += 0.5;
}
void GerminandoState::draw(Planta * p) {
	ofSetColor(p->color);
	ofDrawLine(p->position.x, p->position.y, p->position.x, p->position.y - p->altura);
}

void CreciendoState::update(Planta * p) {
	p->altura += 1.0;
}

void CreciendoState::draw(Planta * p) {
	float topY = p->position.y - p->altura;
	ofSetColor(p->color);

	if (p->tipo == "flor") {
		// Tallo
		ofDrawLine(p->position.x, p->position.y, p->position.x, topY);
		// Pétalos
		ofPushMatrix();
		ofTranslate(p->position.x, topY);
		float r = 3;
		for (int i = 0; i < 6; ++i) {
			float angle = ofDegToRad(i * 60);
			float x = cos(angle) * r * 2;
			float y = sin(angle) * r * 2;
			ofDrawCircle(x, y, r);
		}
		// Centro
		ofSetColor(255, 255, 0);
		ofDrawCircle(0, 0, r);
		ofPopMatrix();

	} else if (p->tipo == "arbusto") {
		// Tronco
		ofDrawLine(p->position.x, p->position.y, p->position.x, topY);
		// Ramas laterales
		ofDrawLine(p->position.x, p->position.y - p->altura * 0.5, p->position.x - 5, p->position.y - p->altura * 0.6);
		ofDrawLine(p->position.x, p->position.y - p->altura * 0.5, p->position.x + 5, p->position.y - p->altura * 0.6);
		ofDrawCircle(p->position.x - 5, p->position.y - p->altura * 0.6, 3);
		ofDrawCircle(p->position.x + 5, p->position.y - p->altura * 0.6, 3);

	} else if (p->tipo == "espiga") {
		// Zig-zag de segmentos
		float y = p->position.y;
		for (int i = 0; i < p->altura; i += 5) {
			float offset = (i % 10 == 0) ? -4 : 4;
			ofDrawLine(p->position.x, y - i, p->position.x + offset, y - i - 5);
		}

	} else {
		// Genérica
		ofDrawLine(p->position.x, p->position.y, p->position.x, topY);
		ofDrawCircle(p->position.x, topY, 5);
	}
}

void ReposoState::update(Planta * p) {
	// No crece
}
void ReposoState::draw(Planta * p) {
	ofSetColor(p->color);
	ofDrawRectangle(p->position.x - 1, p->position.y - p->altura, 2, p->altura);
}

void SecaState::update(Planta * p) {
	p->color = ofColor(139, 69, 19);
}
void SecaState::draw(Planta * p) {
	ofSetColor(p->color);
	ofDrawLine(p->position.x, p->position.y, p->position.x, p->position.y - p->altura);
}

// ---------------- Tipos de Planta ----------------
Flor::Flor() {
	color = ofColor::fromHsb(ofRandom(255), 200, 255);
	tipo = "flor";
}
Arbusto::Arbusto() {
	color = ofColor(50, 180, 70);
	tipo = "arbusto";
}
Espiga::Espiga() {
	color = ofColor(220, 200, 100);
	tipo = "espiga";
}

Planta * PlantaFactory::crearPlanta(const std::string & tipo) {
	if (tipo == "flor")
		return new Flor();
	else if (tipo == "arbusto")
		return new Arbusto();
	else if (tipo == "espiga")
		return new Espiga();
	return new Planta();
}

// ---------------- ofApp ----------------
void ofApp::setup() {
	ofBackground(20, 20, 30);

	int filas = 5;
	int porFila = 40;

	for (int fila = 0; fila < filas; ++fila) {
		float baseY = ofGetHeight() - fila * 30; // cada fila un poco más arriba
		for (int i = 0; i < porFila; ++i) {
			std::string tipo;
			if (i % 3 == 0)
				tipo = "flor";
			else if (i % 3 == 1)
				tipo = "arbusto";
			else
				tipo = "espiga";

			Planta * p = PlantaFactory::crearPlanta(tipo);
			p->position.x = i * (ofGetWidth() / porFila) + ofRandom(-15, 15);
			p->position.y = baseY;
			p->altura *= 0.8f + 0.2f * (filas - fila); // un poco más alta en filas traseras
			plantas.push_back(p);
			addObserver(p);
		}
	}
}


void ofApp::update() {
	for (Planta * p : plantas) {
		p->update();
	}
}

void ofApp::draw() {
	for (Planta * p : plantas) {
		p->draw();
	}
}

void ofApp::keyPressed(int key) {
	if (key == 'g')
		notify("germinar");
	else if (key == 'c')
		notify("crecer");
	else if (key == 'r')
		notify("reposo");
	else if (key == 's')
		notify("seca");
}
```

# OfApp.h:

```cpp
#pragma once

#include "ofMain.h"
#include <string>
#include <vector>

// -------------------- Observer --------------------
class Observer {
public:
	virtual void onNotify(const std::string & event) = 0;
};

class Subject {
public:
	void addObserver(Observer * observer);
	void notify(const std::string & event);

private:
	std::vector<Observer *> observers;
};

// -------------------- State Pattern --------------------
class Planta;

class State {
public:
	virtual void update(Planta * planta) = 0;
	virtual void draw(Planta * planta) = 0;
	virtual void onEnter(Planta * planta) { }
	virtual void onExit(Planta * planta) { }
	virtual ~State() = default;
};

class GerminandoState : public State {
public:
	void update(Planta * planta) override;
	void draw(Planta * planta) override;
	void onEnter(Planta * planta) override;
};

class CreciendoState : public State {
public:
	void update(Planta * planta) override;
	void draw(Planta * planta) override;
};

class ReposoState : public State {
public:
	void update(Planta * planta) override;
	void draw(Planta * planta) override;
};

class SecaState : public State {
public:
	void update(Planta * planta) override;
	void draw(Planta * planta) override;
};

// -------------------- Planta Base --------------------
class Planta : public Observer {
public:
	Planta();
	virtual ~Planta();

	void update();
	void draw();
	void setState(State * newState);
	void onNotify(const std::string & event) override;

	ofVec2f position;
	float altura;
	float crecimiento;
	ofColor color;
	std::string tipo;

protected:
	State * state;
};

// -------------------- Tipos de Planta --------------------
class Flor : public Planta {
public:
	Flor();
};

class Arbusto : public Planta {
public:
	Arbusto();
};

class Espiga : public Planta {
public:
	Espiga();
};

class PlantaFactory {
public:
	static Planta * crearPlanta(const std::string & tipo);
};

// -------------------- ofApp --------------------
class ofApp : public ofBaseApp, public Subject {
public:
	void setup();
	void update();
	void draw();
	void keyPressed(int key);

private:
	std::vector<Planta *> plantas;
};
```