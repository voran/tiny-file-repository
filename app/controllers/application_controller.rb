class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def search
    @output = Array.new
    @query = params[:query]
    
    if !@query.nil?
      swish = SwishE.new("db/index.swish-e")
      swish.query(params[:query]).each do |result|
        @output.push(result.docpath)
      end
      swish.close
      @output = @output.sort
    end
    
    
    respond_to do |format|
      format.html { render }
      format.json { render :json => @output}
      format.xml {render :xml => @output.to_xml(:root => 'output')}
    end
  end

  def submit
    reirect_to "/search.html/#{params[:query]}", :status => :moved_permanently
  end


  
  def browse
    files = Array.new
    subdirs = Array.new
    
    current_dir = "/data/Music/#{params[:dir]}"
    
    if File.file?(current_dir)
      send_file current_dir
      return
    end
    
    if !File.directory?(current_dir)
      current_dir ="/data/Music/"
    end
    
    
    
    Dir.foreach(current_dir) do |entry|
      entry_fullpath = "#{current_dir}/#{entry}"
      if File.directory?(entry_fullpath) and entry != '.' and (entry != '..' or !params[:dir].nil?)
        subdirs.push(entry)
      elsif File.file?(entry_fullpath)
        files.push(entry)
      end
    end
    
    @output = { :subdirs => subdirs.sort, :files => files.sort }
    
    respond_to do |format|
      format.html { render }
      format.json { render :json => @output}
      format.xml {render :xml => @output.to_xml(:root => 'output')}
    end
  end
end