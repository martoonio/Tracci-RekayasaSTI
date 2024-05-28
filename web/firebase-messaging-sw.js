importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyDpROO3WN04QMGym0iheu5RNFs-6zqoQT0",
  authDomain: "rekayasasti-tracci.firebaseapp.com",
  databaseURL: "https://rekayasasti-tracci-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "rekayasasti-tracci",
  storageBucket: "rekayasasti-tracci.appspot.com",
  messagingSenderId: "170779542490",
  appId: "1:170779542490:web:2ab6f2aa630bd60559f6e3",
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  // Customize notification here
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/firebase-logo.png'
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});