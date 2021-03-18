import consumer from "./consumer"

if ($("meta[name= 'current-user']").length > 0 ){
  consumer.subscriptions.create("RemainderChannel", {
    connected() {
      console.log("connected");
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      console.log("disconnected");
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log("recieved");
      if (Notification.permission === 'granted'){
        var title= 'Haiku Remainder'
        var body= data
        var options= {body: body}
        new Notification(title, options)
      }
    }
  });
}