class NotesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notes"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
