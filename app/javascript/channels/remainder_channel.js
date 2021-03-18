import consumer from "./consumer"

document.addEventListener('turboLinks:load',()=>{

  // if ($("meta[name= 'current-user']").length > 0 ){
    consumer.subscriptions.create({channel: "RemainderChannel",user_id: 79}, {
      connected() {
        console.log("connected to channel");
        // Called when the subscription is ready for use on the server
      },
  
      disconnected() {
        console.log("disconnected");
        // Called when the subscription has been terminated by the server
      },
  
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log(data);
        if (Notification.permission === 'granted'){
          var title= 'Haiku Remainder'
          var body= data
          var options= {body: body}
          new Notification(title, options)
        }
      }
    });
  // }
})
