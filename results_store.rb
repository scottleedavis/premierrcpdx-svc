require 'yaml'


# stores results, returns values that were 'not' already store
def stash(files)
  yml_file = 'results_store.yml'
  store = YAML.load_file(yml_file)

  unless store
    new_store = store = files
  else
    new_store = {
      offroad: [],
      onroad: [],
      oval: []
    }

    files[:offroad].each do |f|
      new_store[:offroad].push f unless store[:offroad].include? f
    end

    files[:onroad].each do |f|
      new_store[:onroad].push f unless store[:onroad].include? f
    end

    files[:oval].each do |f|
      new_store[:oval].push f unless store[:oval].include? f
    end    

  end

  File.open(yml_file, "w") do |file|
    file.write store.to_yaml
  end

  new_store
end

def view_stash
  yml_file = 'results_store.yml'
  store = YAML.load_file(yml_file)
  puts store.to_s
end

