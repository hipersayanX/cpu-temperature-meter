/* CPU temperature meter (CTM).
 * Copyright (C) 2013  Gonzalo Exequiel Pedone
 *
 * CTM is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * CTM is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with CTM. If not, see <http://www.gnu.org/licenses/>.
 *
 * Email   : hipersayan DOT x AT gmail DOT com
 * Web-Site: http://hipersayanx.blogspot.com/
 */

import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore


Item
{
    Text
    {
        id: txtTemperature
        color: theme.textColor
        text: temperature + "°C"
        font.pointSize: theme.desktopFont.pointSize
        font.bold: true

        anchors.centerIn: parent

        property real temperature: 0
        property real overheatLevel: 80
        property color overheatColor: Qt.rgba(1, 0, 0, 1)
    }

    PlasmaCore.DataSource
    {
        id: temperatureData
        engine: "systemmonitor"
        connectedSources: ["acpi/Thermal_Zone/0/Temperature"]
        interval: 500

        onNewData:{
            txtTemperature.temperature = data.value
            txtTemperature.color = txtTemperature.temperature >= txtTemperature.overheatLevel? txtTemperature.overheatColor: theme.textColor
        }
    }
}
