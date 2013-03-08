module UsersHelper
  def roles_helper(record)
    ret_text = ''
    if Power.current.is_admin?
      record.roles.each do |role|
        ret_text << role.name
        ret_text << " "
      end
    end
    ret_text.html_safe
  end

  def groups_helper(record)
    ret_text = ''
    if Power.current.is_admin?
      record.groups.each do |g|
        ret_text << g.id.to_s
        ret_text << ' '
      end
    end
    ret_text.html_safe
  end

end
