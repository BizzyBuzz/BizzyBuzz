import { Socket } from "phoenix"

class CommissionSocket {

  constructor() {
    this.socket = new Socket("/socket", {
      params: {token: window.userToken}
    })
    this.socket.connect()
  }

  connect_to_commission() {
    this.setup_channel()
    this.channel.on("calculate_commission", commission => {
      document.getElementById("commission").innerText = commission.commission
    })
  }

  setup_channel() {
    this.channel = this.socket.channel("sales_by_vendor:commission", {})
    this.channel.join()
      .receive("ok", resp => {

      })
      .receive("error", resp => {
        throw (resp)
      })
  }

  calculate_commission(commissionRate, grandTotal) {
    this.channel.push("calculate_commission", {commission_rate: commissionRate, grand_total: grandTotal})
  }

}

export default CommissionSocket;