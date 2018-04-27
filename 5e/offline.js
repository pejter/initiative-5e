// Version 0.2

var cacheName = 'initiative-5e-ver-1';
var filesToCache = [
	'index.html'
];

self.addEventListener('install', function(event) {
	event.waitUntil(
		caches.open(cacheName)
		.then(function(cache) {
			return cache.addAll(filesToCache)
			.then(function() {
				return self.skipWaiting();
			});
		})
	);
});

self.addEventListener('activate', function(event) {
  event.waitUntil(self.clients.claim());
});

self.addEventListener('fetch', function(event) {
  console.log(event.request.url);

  event.respondWith(
    caches.match(event.request).then(function(response) {
      return response || fetch(event.request);
    })
  );
});