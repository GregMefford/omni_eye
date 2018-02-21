// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import * as AbsintheSocket from "@absinthe/socket";
import {Socket as PhoenixSocket} from "phoenix";

const subscribe = (socket, onResult, operation) => {
  const notifier = AbsintheSocket.send(socket, { operation });
  AbsintheSocket.observe(socket, notifier, { onResult });
}

const phxSocket = new PhoenixSocket(`ws://${window.location.host}/socket`);
const absintheSocket = AbsintheSocket.create(phxSocket);

// Barcode Subscription

const barcodeOperation = `
  subscription {
    barcodes {
      data
      points {
        x
        y
      }
    }
  }
`;

const onBarcodeData = data => {
  const barcodes = data["data"]["barcodes"];
  const dots = barcodes.map(barcode => {
    const points = barcode["points"];
    return barcode["points"].map(function(point, index) {
      const x = point["x"];
      const y = point["y"];
      if (index == 0) {
        return `
          <circle cx="${x}" cy="${y}" r="3" stroke="red" fill="transparent" stroke-width="2"/>
          <text x="${x + 5}" y="${y + 5}"><tspan font-weight="bold" fill="red">${barcode["data"]}</tspan></text>
        `
      } else {
        return `<circle cx="${x}" cy="${y}" r="3" fill="red"/>`
      }
    }).join("\n");
  }).join("\n");
  document.getElementById("canvas").innerHTML = dots;
};

subscribe( absintheSocket, onBarcodeData, barcodeOperation );

// Configuration Subscription

const configOperation = `
  subscription {
    config {
      size {
        width
        height
      }
    }
  }
`;

const onConfigData = data => {
  const {width, height} = data["data"]["config"]["size"];
  document.getElementById("canvas").setAttribute("viewBox", `0 0 ${width} ${height}`);
};

subscribe( absintheSocket, onConfigData, configOperation );

// Resolution Buttons

const setResolution = (socket, width, height) => {
  AbsintheSocket.send(socket, {
    operation: `mutation {
      size(width: ${width}, height: ${height}) {
        size {
          width
          height
        }
      }
    }`
  });
};

document.getElementById("640x480").onclick = (event) => {
  event.preventDefault();
  setResolution(absintheSocket, 640, 480);
};

document.getElementById("1280x720").onclick = (event) => {
  event.preventDefault();
  setResolution(absintheSocket, 1280, 720);
};

document.getElementById("1920x1080").onclick = (event) => {
  event.preventDefault();
  setResolution(absintheSocket, 1920, 1080);
};
