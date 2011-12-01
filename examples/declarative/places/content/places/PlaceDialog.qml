/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtLocation 5.0
import "../dialogs"

Dialog {
    title: "Edit Place"

    property Place place

    Behavior on opacity { NumberAnimation { duration: 500 } }

    Component.onCompleted: prepareDialog()
    onPlaceChanged: prepareDialog()

    function latitude() {
        if (place && place.location && place.location.coordinate)
            return String(place.location.coordinate.latitude);
        else if (searchRegion && searchRegion.center)
            return String(searchRegion.center.latitude);
        else
            return "";
    }

    function longitude() {
        if (place && place.location && place.location.coordinate)
            return String(place.location.coordinate.longitude);
        else if (searchRegion && searchRegion.center)
            return String(searchRegion.center.longitude);
        else
            return "";
    }

    function prepareDialog() {
        setModel([
            ["Name", place ? place.name : ""],
            ["Street", place ? place.location.address.street : ""],
            ["District", place ? place.location.address.district : ""],
            ["City", place ? place.location.address.city : ""],
            ["County", place ? place.location.address.county : ""],
            ["State", place ? place.location.address.state : ""],
            ["Country code", place ? place.location.address.countryCode : ""],
            ["Country", place ? place.location.address.country : ""],
            ["Postal code", place ? place.location.address.postalCode : ""],
            ["Latitude", latitude()],
            ["Longitude", longitude()]
        ]);
    }

    onGoButtonClicked: {
        var modifiedPlace = place ? place : Qt.createQmlObject('import QtLocation 5.0; Place { }', page);
        modifiedPlace.plugin = placesPlugin;

        modifiedPlace.name = dialogModel.get(0).inputText;
        modifiedPlace.location.address.street = dialogModel.get(1).inputText;
        modifiedPlace.location.address.district = dialogModel.get(2).inputText;
        modifiedPlace.location.address.city = dialogModel.get(3).inputText;
        modifiedPlace.location.address.county = dialogModel.get(4).inputText;
        modifiedPlace.location.address.state = dialogModel.get(5).inputText;
        modifiedPlace.location.address.countryCode = dialogModel.get(6).inputText;
        modifiedPlace.location.address.country = dialogModel.get(7).inputText;
        modifiedPlace.location.address.postalCode = dialogModel.get(8).inputText;

        modifiedPlace.location.coordinate.latitude = parseFloat(dialogModel.get(9).inputText);
        modifiedPlace.location.coordinate.longitude = parseFloat(dialogModel.get(10).inputText);

        place = modifiedPlace;

        place.save();
    }
}