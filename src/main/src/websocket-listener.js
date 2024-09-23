'use strict';

const SockJS = require('sockjs-client');
const { Client } = require('@stomp/stompjs'); // Correct import

function register(registrations) {
    const socket = SockJS('/payroll');
    const stompClient = new Client({
        webSocketFactory: () => socket,
        // Additional stompClient options can go here
    });
    stompClient.connect({}, function(frame) {
        registrations.forEach(function (registration) {
            stompClient.subscribe(registration.route, registration.callback);
        });
    });
}

module.exports = {
    register: register,
};
