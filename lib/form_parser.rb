class FormParser
  def self.parse(form)
    keys = {}
    parts = form.split('&')
    parts.each do |part|
      temp = part.split('=')
      keys[temp[0]] = temp[1]
    end
    keys
  end
end
