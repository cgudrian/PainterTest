#include <QQuickPaintedItem>

#pragma once

class ControlPanel : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QPointF origin READ origin WRITE setOrigin NOTIFY worldTransformChanged)
    Q_PROPERTY(qreal zoom READ zoom NOTIFY worldTransformChanged)

signals:
    void worldTransformChanged();

public:
    ControlPanel();

    void setOrigin(const QPointF &origin);
    QPointF origin() const;

    qreal zoom() const;

    void paint(QPainter *painter);

    bool foobar() const;
    void setFoobar(bool enable);

    Q_INVOKABLE void zoomByFactor(const QPointF &viewCenter, const qreal &factor);

private:
    QPointF _origin{0, 0};
    qreal _zoom{1};
    QTransform _worldTransform{};

    void updateWorldTransform();
};
