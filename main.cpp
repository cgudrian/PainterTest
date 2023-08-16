#include <QElapsedTimer>
#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <optional>

#include <signal.h>

void handleSignal(int signal)
{
    qCritical() << "Quitting on signal" << signal;
    qApp->quit();
}

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    qputenv("QT_VIRTUALKEYBOARD_STYLE", QByteArray("csdefault"));

    QGuiApplication app(argc, argv);
    QFontDatabase::addApplicationFont(":/NotoSans-Regular.ttf");

    signal(SIGTERM, &handleSignal);
    signal(SIGINT, &handleSignal);
    signal(SIGBREAK, &handleSignal);

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
