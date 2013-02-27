class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def search
    results = Array.new
    
    swish = SwishE.new("db/index.swish-e")
    swish.query(params[:query]).each do |result|
      results.push(result.docpath)
    end
    render :json => results.sort
    swish.close
  end


  
  def browse
    files = Array.new
    subdirs = Array.new
    
    current_dir = "/home/yavor/Music/#{params[:dir]}"
    
    Dir.foreach(current_dir) do |entry|
      entry_fullpath = "#{current_dir}/#{entry}"
      if File.directory?(entry_fullpath) and entry != '.' and (entry != '..' or !params[:dir].nil?)
        subdirs.push(entry)
      elsif File.file?(entry_fullpath)
        files.push(entry)
      end
    end
    render :json => {:subdirs => subdirs.sort, :files => files.sort }
  end
end