defmodule ProfileManagementService.Receive do
  require Poison
  alias ProfileManagementService.Profile, as: Profile

  def start_link(), do: setup_connection()

  def wait_for_messages do
    receive do
      {:basic_deliver, payload, _meta} ->
        IO.puts " [x] Received #{payload}"
        new_profile = Poison.decode!(payload, as: %Profile{})
        Profile.create(%{"username" => new_profile.username, "email_address" => new_profile.email_address, "first_name" => new_profile.first_name, "last_name" => new_profile.last_name})
        ProfileManagementService.Receive.wait_for_messages()
    end
  end

  def setup_connection do
    {:ok, connection} = AMQP.Connection.open("amqp://mljuxpih:gOWXSg5I0ibDw8Df1-zt24I7959uJYjb@roedeer.rmq.cloudamqp.com/mljuxpih")
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, "profile")
    AMQP.Basic.consume(channel, "profile", nil, no_ack: true)
    IO.puts " [*] Waiting for messages. To exit press CTRL+C, CTRL+C"
    ProfileManagementService.Receive.wait_for_messages()
  end

end


