module FormatHelper
  def format obj, params = {}
    if obj.is_a? ActiveSupport::TimeWithZone
      obj.strftime '%Y-%m-%d %H:%M:%S'
    end
  end
end
