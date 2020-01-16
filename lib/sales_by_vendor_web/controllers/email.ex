defmodule SalesByVendorWeb.Email do

  @mailer_url "https://api.sendgrid.com/v3/mail/send"


  def send(to, body_text) do
    if System.get_env("SEND_GRID_API_KEY") do
      HTTPotion.post(@mailer_url, [body: mail_json(to, body_text), headers: headers()])
      |> case do
        %{status_code: code} when code in (200..299) ->
          :ok
        error ->
          IO.puts "Failed to send mail: #{inspect error}"
          {:error, error}
      end
    else
      :ok
    end
  end

  defp mail_json(to, body_text) do
    %{
      "personalizations"=> [
        %{
          "to"=> [
            %{"email"=> to }
          ]
        }
      ],
      "from"=> %{
        "email"=> "ryan_walther@hotmail.com "
      }, 
      "subject"=> "Bizzy Buzz Artisan Market", 
      "content"=> [
        %{
          "type"=> "text/plain",
          "value"=> body_text
        }
      ]
    }
    |> Poison.encode!
  end

  defp headers do
    [
      "Content-Type": "application/json",
      "Authorization": "Bearer #{System.get_env("SEND_GRID_API_KEY")}"
    ]
  end

end