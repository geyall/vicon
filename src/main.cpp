#include <iostream>
// #include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QUrl>
#include <QtQml>
#include <QIcon>
#include <QtWebEngine>
#include <rand.h>
// using namespace std;
int main(int argc, char *argv[])
{
    // QGuiApplication app(argc, argv);
	QApplication app(argc, argv);

    QIcon::setThemeName("darkIconTheme");

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:///qml/App.qml"));

    qmlRegisterType<Rand>("Rand",1,0,"Rand");

    QtWebEngine::initialize();
    // cout << "Hello, world!" << endl;
    return app.exec();
}