/* CPU temperature meter (CTM).
 * Copyright (C) 2015  Gonzalo Exequiel Pedone
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

import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaComponents.Label {
    id: lblTemperature
    color: theme.textColor
    font.bold: true

    property real overheatLevel: 80
    property color overheatColor: Qt.rgba(1, 0, 0, 1)

    function strToFloat(str)
    {
        return str.length < 1? 0: parseFloat(str)
    }

    PlasmaCore.DataSource  {
        engine: "systemmonitor"
        connectedSources: ["acpi/Thermal_Zone/0/Temperature"]
        interval: 500

        onNewData: {
            if (typeof(data.value) != "string")
                return

            lblTemperature.text = data.value + "°C"
            
            var temperature = strToFloat(data.value)
            lblTemperature.color = temperature >= lblTemperature.overheatLevel? lblTemperature.overheatColor: theme.textColor
        }
    }
}
