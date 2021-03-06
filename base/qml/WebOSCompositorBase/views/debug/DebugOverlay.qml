// Copyright (c) 2014-2018 LG Electronics, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// SPDX-License-Identifier: Apache-2.0

import QtQuick 2.4
import WebOSCompositorBase 1.0

Item {
    id: root

    Loader {
        id: focusHighlightId
        source: Settings.local.debug.focusHighlight ? "FocusHighlight.qml" : ""
    }

    Loader {
        id: fpsGraphOverlayId
        anchors.fill: parent
        source: Settings.local.debug.fpsGraphOverlay ? "FpsGraphOverlay.qml" : ""
    }

    Loader {
        id: touchOverlayId
        anchors.fill: parent
        source: Settings.local.debug.touchOverlay ? "TouchOverlay.qml" : ""
    }

    Item {
        id: debugWindowId

        property var layers: []
        property var topLayer

        Loader {
            id: resourceMonitorId
            source: Settings.local.debug.resourceMonitor ? "ResourceMonitor.qml" : ""


            onLoaded: {
                resourceMonitorId.item.parent = debugWindowId;
                resourceMonitorId.item.x = debugWindowId.requestTopItem(resourceMonitorId.item) * 50;
                resourceMonitorId.item.y = resourceMonitorId.item.x;
            }

            Connections {
               target: resourceMonitorId.item
               onSelected: debugWindowId.requestTopItem(resourceMonitorId.item);
            }
        }

        Loader {
            id: logConsoleId
            source: Settings.local.debug.logConsole ? "LogConsole.qml" : ""

            onLoaded: {
                logConsoleId.item.parent = debugWindowId;
                logConsoleId.item.x = debugWindowId.requestTopItem(logConsoleId.item) * 50;
                logConsoleId.item.y = logConsoleId.item.x;
            }

            Connections {
               target: logConsoleId.item
               onSelected: debugWindowId.requestTopItem(logConsoleId.item);
            }
        }

        Loader {
            id: focusConsoleId
            source: Settings.local.debug.focusConsole ? "FocusConsole.qml" : ""

            onLoaded: {
                focusConsoleId.item.parent = debugWindowId;
                focusConsoleId.item.x = debugWindowId.requestTopItem(focusConsoleId.item) * 50;
                focusConsoleId.item.y = focusConsoleId.item.x;
            }

            Connections {
               target: focusConsoleId.item
               onSelected: debugWindowId.requestTopItem(focusConsoleId.item);
            }
        }

        Loader {
            id: surfaceConsoleId
            source: Settings.local.debug.surfaceConsole ? "SurfaceConsole.qml" : ""

            onLoaded: {
                surfaceConsoleId.item.parent = debugWindowId;
                surfaceConsoleId.item.x = debugWindowId.requestTopItem(surfaceConsoleId.item) * 50;
                surfaceConsoleId.item.y = surfaceConsoleId.item.x;
            }

            Connections {
               target: surfaceConsoleId.item
               onSelected: debugWindowId.requestTopItem(surfaceConsoleId.item);
            }
        }

        function requestTopItem(item) {
            if (topLayer != item) {
                if (layers.indexOf(item) == -1) {
                    layers.push(item);
                } else {
                    for (var i = layers.length - 1; i >= 0; i--)
                        if (layers[i] != item)
                            layers[i].z -= 1;
                }
                item.z = layers.length;
                topLayer = item;
            }
            return item.z;
        }
    }
}
