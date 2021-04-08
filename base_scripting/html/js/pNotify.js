// window.addEventListener("message", function(event){
//     if(event.data.options){
//         var options = event.data.options;
//         console.log(event.data.options.text)
//         new Noty(options).show();
//     } else if (event.data.maxNotifications) {
//         var maxNotifications = event.data.maxNotifications;
//         Noty.setMaxVisible(maxNotifications.max, maxNotifications.queue);
//     } else if (event.data.clearNotifications) {
//         var queueName = event.data.clearNotifications.queue;
//         if (queueName == undefined) {
//             Noty.closeAll();          	
//         } else {
//             Noty.closeAll(queueName);
//         }          
//     };
// });