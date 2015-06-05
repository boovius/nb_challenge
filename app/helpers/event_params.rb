class EventParams
  attr_accessor :date, :type, :user, :data, :errors

  def initialize params
    @errors = []
    @date = process_date(params)
    @user = process_user(params)
    @type = process_type(params)
  end

  def errors?
    !self.errors.empty?
  end

  def error_messages
    @errors.map { |e| "#{e}"}.join(',')
  end

  private

  def process_date(params)
    Time.parse(pull_date(params))
  end

  def pull_date(params)
    params['date'] || params[:date]
  end

  def process_type(params)
    type = pull_type(params).to_sym
    case type
    when :enter
    when :leave
    when :comment
      @data = process_message(params)
    when :highfive
      @data = process_otheruser(params)
    else
      @errors << 'invalidType'
    end
    type
  end

  def pull_type(params)
    params['type'] || params[:type]
  end

  def process_user(params)
    user = pull_user(params)
    if user == nil || user == ''
      @errors << 'noUser'
    end
    user
  end

  def pull_user(params)
    params['user'] || params[:user]
  end

  def process_message(params)
    message = pull_message(params)
    if message == nil || message.length == 0
      @errors << 'emptyMessageSent'
    end
    message
  end

  def pull_message(params)
    params['message'] || params[:message]
  end

  def process_otheruser(params)
    otheruser = pull_otheruser(params)
    if otheruser == nil || otheruser.length == 0
      @errors << 'noHighFiveReceiver'
    end
    otheruser
  end

  def pull_otheruser(params)
    params['otheruser'] || params[:otheruser]
  end
end
