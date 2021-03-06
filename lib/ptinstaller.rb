require 'pathname'
require "thor"
require 'xcodeproj'
class ProjectInstaller < Thor

  def initialize(*args)
    @current_dir = Pathname.pwd
    Dir.foreach(@current_dir) do |filename| 
      if filename.include? 'xcodeproj'
        project_path = "#{@current_dir}/#{filename}"
        @project_name = File.basename(filename) 
        @project = Xcodeproj::Project.open project_path 
        @source_path = "#{@current_dir}/#{@project_name}/Source"
        @pod_file_path = "#{@current_dir}/podfile"
        break
      end
    end

    super(*args)
  end

  desc "install project temple", "install my project temple form github"
  def install 
    if File.exist? @source_path
      if $stdin.getc == 'y'
        puts "Source directory exist, do you want to delete and continue(y or n) ?" 
        downloadFile
        source_group = @project.main_group.children[0]
        add_all_to_group @source_path, source_group
        @project.save
      end 
    else
        downloadFile
        source_group = @project.main_group.children[0]
        add_all_to_group @source_path, source_group
        @project.save
    end
  end

  private

  def downloadFile

    FileUtils.rm_rf  @source_path if File.exist? @source_path
    FileUtils.rm_rf  @pod_file_path if File.exist? @pod_file_path
    download_command = "svn export https://github.com/kaich/ProjectTemple/trunk/ProjectTemple/Source"
    download_podfile = "svn export https://github.com/kaich/ProjectTemple/trunk/podfile"
    system download_command
    system download_podfile
    FileUtils.mv "#{current_dir}/Source" , source_path

  end

  def add_all_to_group(path ,target_group)
    exist_sub_group = target_group["Source"]
    if exist_sub_group 
       exist_sub_group.remove_from_project
    end
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
 
