Rails.autoloaders.main do |autoloader|
  autoloader.ignore("#{root}/lib/tasks")
end
