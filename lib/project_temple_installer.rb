require 'pathname'
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
    downloadFile
    source_group = @project.main_group.children[0]
    add_all_to_group "#{@current_dir}/Source", source_group
    @project.save
  end

  def downloadFile
    download_command = "svn export https://github.com/kaich/ProjectTemple/trunk/ProjectTemple/Source"
    download_podfile = "svn export https://github.com/kaich/ProjectTemple/trunk/podfile"
    system download_command
    system download_podfile
  end

  def add_all_to_group(path ,target_group)
    new_group = target_group.new_group(File.basename(path), path) if Dir.exist? path
    Dir.foreach(path) do |filename| 
      next if filename == "."              # 忽略当前目录
      next if filename == ".."             # 忽略上级目录
      next if filename.start_with? "."     # 忽略隐藏文件

      file_path = "#{path}/#{filename}" 
      
      if File.directory? file_path
        add_all_to_group file_path ,new_group
      else
        new_group.new_reference file_path
        puts "add #{file_path}\n"
      end
    end
  end

end
