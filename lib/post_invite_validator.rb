class PostInviteValidator < ActiveModel::Validator
  def validate(record)
    # Validate we have a name set when we update the record
    # when accepting an invitation
    unless record.invitation_token.nil?
      if record.name.empty? or record.name.nil?
        record.errors[:name] << "can't be blank"
      end

    end
  end
end