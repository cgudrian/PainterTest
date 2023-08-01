#include <QElapsedTimer>
#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);
    QFontDatabase::addApplicationFont(":/NotoSans-Regular.ttf");

    QQmlApplicationEngine engine;

    QElapsedTimer elapsed;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [&elapsed](QObject *o) {
        qDebug() << "QML loading took" << elapsed.elapsed() << "ms";
    });

    elapsed.start();
    engine.loadFromModule("PainterTest", "Main");

    return app.exec();
}
