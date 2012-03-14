/****************************************************************************
**
** Copyright (C) 2012 Nokia Corporation and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/
**
** This file is part of the QtLocation module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU General
** Public License version 3.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of this
** file. Please review the following information to ensure the GNU General
** Public License version 3.0 requirements will be met:
** http://www.gnu.org/copyleft/gpl.html.
**
** Other Usage
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef ICONHANDLER_H
#define ICONHANDLER_H

#include "icon.h"
#include "jsondb.h"

#include <QtCore/QObject>
#include <QtCore/QJsonObject>
#include <QtCore/QVariant>
#include <QtLocation/QPlaceIcon>
#include <QtLocation/QPlaceReply>

QT_BEGIN_HEADER

QT_BEGIN_NAMESPACE

class IdReply;
class QNetworkAccessManager;

class IconHandler : public QObject
{
    Q_OBJECT
public:
    IconHandler(const QPlaceIcon &icon, const QJsonObject &thumbnailsJson,
                IdReply *parent);
    ~IconHandler();

    QPlaceReply::Error error() const;
    QString errorString() const;

    QNetworkAccessManager *networkAccessManager();

signals:
    void finished(QJsonObject thumbnailsJson);

private slots:
    void processIcons();
    void trySetDestination(const QString &destination);

private:
    void triggerDone(const QPlaceReply::Error error, const QString &errorString);
    QUrl convertToUrl(const QVariant &var, bool *ok);

    QJsonObject m_thumbnailsJson;

    QPlaceReply::Error m_error;
    QString m_errorString;

    QList<Icon *> m_icons;
    int m_currIconIndex;

    IdReply *m_reply;
};


QT_END_NAMESPACE

QT_END_HEADER

#endif