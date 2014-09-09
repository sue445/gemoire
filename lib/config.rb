module Config
  # @return [Pathname]
  def self.satellite_root_dir
    absolute_path(Global.gemoire.satellite_root_dir)
  end

  # @return [Pathname]
  def self.doc_root_dir
    absolute_path(Global.gemoire.doc_root_dir)
  end

  # @return [Pathname]
  def self.absolute_path(path)
    dir = Pathname(path)
    dir = Pathname(Padrino.root(path)) if dir.relative?
    dir
  end
  private_class_method :absolute_path
end
