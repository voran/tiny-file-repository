class ApplicationController < ActionController::Base
  protect_from_forgery

  
  def search
    if params[:query]
      query = params[:query].split
      conditions = [(['lower(path) LIKE ?'] * query.length).join(' AND ')] + query.map { |keyword| "%#{keyword.downcase}%" }
      @files = Kaminari.paginate_array(FileRecord.find(:all, :conditions => conditions)).page(params[:page])
    end
    
    respond_to do |format|
      format.html { render }
      format.json { render :json => @files}
      format.xml {render :xml => @files.to_xml(:root => 'output')}
    end
  end
  
  def do_index
    if params[:password] == Rails.configuration.index_password
      index_entries = index_recursive(Rails.configuration.public_path + Rails.configuration.files_url)
      FileRecord.delete_all
      FileRecord.create(index_entries)
      status = :ok
    else
      status = :wrong_password
    end
    result = { :status => status }
    respond_to do |format|
      format.html { redirect_to search_path }
      format.json { render :json => result}
      format.xml {render :xml => result.to_xml(:root => 'output')}
    end
  end
  
  def browse
    @entry =  params[:dir] || ""
    @output = find_entries(Rails.configuration.public_path + Rails.configuration.files_url + @entry)
    
    respond_to do |format|
      format.html { render }
      format.json { render :json => @output}
      format.xml {render :xml => @output.to_xml(:root => 'output')}
    end
  end
  
  def find_entries(entry_path)
    files = Array.new
    subdirs = Array.new
    Dir.foreach(entry_path) do |subentry|
      subentry_path = entry_path + "/" + subentry
      if File.directory?(subentry_path) and !Rails.configuration.blacklist_dirs.include? subentry
        subdirs.push(subentry)
      elsif File.file?(subentry_path)
        files.push(subentry)
      end
    end
    return { :subdirs => subdirs.sort.reverse, :files => files.sort }
  end
  
  def index_recursive(entry_path, records = Array.new)
    Dir.foreach(entry_path) do |subentry|
      subentry_path = entry_path + '/' + subentry
      if File.directory?(subentry_path) and !Rails.configuration.blacklist_dirs.include?(subentry)
        index_recursive(subentry_path, records)
      elsif File.file?(subentry_path)
        records.push({ :path => subentry_path.force_encoding('ISO-8859-1').encode('UTF-8').split('/')[3..-1].join('/')})
      end
    end
    return records
  end
  
  private
    def file_record_params
      params.require(:file_record).permit(:path)
    end
end