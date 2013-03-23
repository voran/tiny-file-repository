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
    redirect_to "/search.html/#{params[:query]}", :status => :moved_permanently
  end


  
  def browse
    files = Array.new
    subdirs = Array.new
    
    @root = "/data/Music"
    @entry = params[:dir]
    
    if File.file?("#{@root}/#{@entry}")
      send_file @entry
      return
    end
    
    if !File.directory?("#{@root}/#{@entry}")
      @entry = ""
    end
    
    
    
    Dir.foreach("#{@root}/#{@entry}") do |subentry|
      subentry_fullpath = "#{@root}/#{@entry}/#{subentry}"
      if File.directory?(subentry_fullpath) and subentry != '.' and (subentry != '..' or !params[:dir].nil?)
        subdirs.push(subentry)
      elsif File.file?(subentry_fullpath)
        files.push(subentry)
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