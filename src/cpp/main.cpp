#include <QGuiApplication>
#include <QQmlApplicationEngine>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("Marcel Blanck");
    app.setOrganizationDomain("marcel-blanck.de");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/src/qml/main.qml")));

    return app.exec();
}
