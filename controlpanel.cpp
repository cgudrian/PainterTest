#include "controlpanel.h"

#include <QPainter>
#include <QPainterPath>

ControlPanel::ControlPanel()
{
    setAntialiasing(true);
}

void ControlPanel::setOrigin(const QPointF &origin)
{
    _origin = origin;
    updateWorldTransform();
}

QPointF ControlPanel::origin() const
{
    return _origin;
}

qreal ControlPanel::zoom() const
{
    return _zoom;
}

void ControlPanel::paint(QPainter *painter)
{
    painter->setWorldTransform(_worldTransform, true);

    painter->setPen(QPen(Qt::black, 5));

    QPainterPath path;
    path.moveTo(10, 100);
    path.lineTo(10, 20);
    path.lineTo(20, 10);
    path.lineTo(120, 10);
    painter->drawPath(path);

    painter->setPen(QPen(Qt::red, 1));
    painter->drawRect(0, 0, width(), height());
    painter->drawEllipse(-5, -5, 10, 10);
}

void ControlPanel::zoomByFactor(const QPointF &viewCenter, const qreal &factor)
{
    // we want to keep this point fixed in the viewport
    auto modelCenter = viewCenter * _worldTransform.inverted();

    _zoom *= factor;
    _origin = {viewCenter.x() - modelCenter.x() * _zoom, viewCenter.y() - modelCenter.y() * _zoom};

    updateWorldTransform();
}

void ControlPanel::updateWorldTransform()
{
    _worldTransform = QTransform::fromTranslate(_origin.x(), _origin.y()).scale(_zoom, _zoom);
    emit worldTransformChanged();
    update();
}
