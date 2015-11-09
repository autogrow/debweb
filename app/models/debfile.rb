class Debfile < ActiveRecord::Base
  serialize :control, Hash

  has_many :packages

  #after_initialize :read_control_file
  before_create :read_control_file

  def filepath
    File.join(path, name)
  end

  def exist?
    File.exist? filepath
  end

  def read_control_file
    hash = DebianFileScanner.scan(filepath)
    
    write_attribute(:control, hash)
    write_attribute(:version, control["Version"])
    write_attribute(:package_name, control["Package"])
    write_attribute(:file_size, File.size(filepath))
    write_attribute(:modified_at, File.mtime(filepath))
  end

  def megabytes
    (file_size.to_f / 1024 / 1024).round(2)
  end

  def kilobytes
    (file_size.to_f / 1024).round(2)
  end

  def human_size
    _size = megabytes

    if _size < 0.1
      _size = kilobytes
      _size = "#{_size} kB"
    else
      _size = "#{_size} MB"
    end

    _size
  end

  def other_versions
    self.class.where(package_name: package_name).order('version DESC')
  end

end
