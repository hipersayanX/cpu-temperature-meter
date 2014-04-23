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

        property real temperature: 0
        property real overheatLevel: 80
        property color overheatColor: Qt.rgba(1, 0, 0, 1)
    }

    Timer
    {
        id: tmrTemperature
        running: true
        repeat: true
        interval: 500

        property string temperature: ""

        onTriggered:
        {
            tmrTemperature.temperature = ""
            // /sys/bus/platform/devices/coretemp.0/temp2_input     ex: 47000
            // /sys/bus/acpi/devices/LNXTHERM:00/thermal_zone/temp  ex: 47000
            var temperatureRead = plasmoid.getUrl("/sys/class/thermal/thermal_zone0/temp");

            temperatureRead.data.connect(readTemperature);
            temperatureRead.finished.connect(readTemperatureFinished);
        }

        function readTemperature(job, data)
        {
            if (data.length)
                tmrTemperature.temperature += data.toUtf8()
        }

        function readTemperatureFinished(job)
        {
            txtTemperature.temperature = parseInt(tmrTemperature.temperature, 10) / 1e3
            txtTemperature.color = txtTemperature.temperature >= txtTemperature.overheatLevel? txtTemperature.overheatColor: theme.textColor
        }
    }
}
