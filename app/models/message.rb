class Message < ActiveRecord::Base

  belongs_to :profile

  def delete_message(profile_id)
    if profile_id == self.sender_id
      self.sender_flag = false
      self.save
    elsif profile_id == self.receiver_id
      self.receiver_flag = false
      self.save
    end
    if (self.sender_flag == false) && (self.receiver_flag == false)
      self.destroy
    end
  end

end