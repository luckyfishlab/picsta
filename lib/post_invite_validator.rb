class PostInviteValidator < ActiveModel::Validator
  def validate(record)
    # Validate we have a name set when we update the record
    # when accepting an invitation
    unless record.invitation_token.nil?
      # What about if the user invited_by user no longer
      # exists?
      #
      unless User.exists?(record.invited_by_id)
        record.errors[:base] << "the user who invited you is no longer active."
      end

      if record.name.empty? or record.name.nil?
        record.errors[:name] << "can't be blank"
      end
    end
  end
end