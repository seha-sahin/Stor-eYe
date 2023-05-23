module ApplicationHelper
    def approval_status_class(status)
    case status
    when 'approved'
      'text-success'
    when 'rejected'
      'text-danger'
    when 'pending'
      'text-warning'
    else
      'text-secondary'
    end
  end
end
