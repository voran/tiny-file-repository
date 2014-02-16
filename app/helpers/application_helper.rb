module ApplicationHelper
  #include Faenza
  
  def urlencode(entry)
    entry_urlencoded = Array.new
    entry.split('/').each do | url_chunk |
      entry_urlencoded.push(URI::encode(url_chunk))
     end
     return entry_urlencoded.join('/')
  end
   
  def icon_for(type)
    "/" + (FAENZA_ICONS_FILES[type] || FAENZA_ICONS_FILES["unknown"])
  end
end
