require 'xcodeproj'
class ProjectInstaller

  def initialize(*args)
    @current_dir = Pathname.pwd
    Dir.foreach(@current_dir) do |filename| 
      if filename.include? 'xcodeproj'
        project_path = "#{@current_dir}/#{filename}"
        @project_name = File.basename(filename) 
        @project = Xcodeproj::Project.open project_path 
        break
      end
    end
  end

  def install 
    source_group = @project.main_group.children[0]
  end

  def add_all_to_group( path ,target_group)
    new_group = target_group.new_group(path.dirname , path) if Dir.exist? path
    Dir.foreach(path) do |filename| 
       
    end
  end

end
