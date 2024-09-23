'use strict';

const SockJS = require('sockjs-client');
const { Client } = require('@stomp/stompjs');

function register(registrations) {
	// Create a new STOMP client
	const stompClient = new Client({
		// Set up the WebSocket connection using SockJS
		webSocketFactory: () => new SockJS('/payroll'), // The '/payroll' endpoint should match your backend configuration
		reconnectDelay: 5000, // Reconnect every 5 seconds if the connection is lost
		debug: (str) => {
			console.log(str); // Optional: Logs the WebSocket events for debugging purposes
		},
		onConnect: () => {
			// Subscribe to the routes provided in 'registrations' upon connection
			registrations.forEach(function (registration) {
				stompClient.subscribe(registration.route, function(message) {
					// Parse the incoming message and execute the callback
					registration.callback(JSON.parse(message.body));
				});
			});
		}
	});

	// Activate the STOMP client to start the WebSocket connection
	stompClient.activate();
}

module.exports = {
	register: register
};
