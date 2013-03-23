class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def search
    results = Array.new
    
    swish = SwishE.new("db/index.swish-e")
    swish.query(params[:query]).each do |result|
      results.push(result.docpath)
    end
    swish.close
    results = results.sort
    respond_to do |format|
      format.html render
      format.json render :json => { :results => results }
    end
  end


  
  def browse
    files = Array.new
    subdirs = Array.new
    
    current_dir = "/data/Music/#{params[:dir]}"
    
    Dir.foreach(current_dir) do |entry|
      entry_fullpath = "#{current_dir}/#{entry}"
      if File.directory?(entry_fullpath) and entry != '.' and (entry != '..' or !params[:dir].nil?)
        subdirs.push(entry)
      elsif File.file?(entry_fullpath)
        files.push(entry)
      end
    end
    fiels = files.sort
    subdirs = subdirs.sort
    respond_to do |format|
      format.html render
      format.json { render :json => {:subdirs => subdirs, :files => files } }
    end
    
  end
end