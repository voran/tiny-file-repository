class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery
  
  @@music_baseurl = "/music/"
  
  helper_method :music_baseurl
  def music_baseurl
    @@music_baseurl
  end
  
  def search
    @output = Array.new
    @output_urlencoded = Array.new
    @query = params[:query]
    
    if !@query.nil?
      swish = SwishE.new("db/index.swish-e")
      swish.query(params[:query]).each do |result|
        entry = result.docpath
        @output.push(entry)
        @output_urlencoded.push(urlencode(entry))
      end
      swish.close
      @output = @output.sort
      @output_urlencoded = @output.sort
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
    
    @music_root = "/data/Music"
    
    @entry = (if params[:dir].nil? or !File.directory?(@music_root + '/' + params[:dir]) then "" else params[:dir] end)
    @entry_urlencoded = urlencode(@entry)
    
    Dir.foreach(@music_root + '/' + @entry) do |subentry|
      subentry_fullpath = @music_root + '/' + @entry + '/' + subentry
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