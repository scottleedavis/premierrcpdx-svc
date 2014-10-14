require 'yaml'


def stash(files)
  yml_file = 'results_store.yml'
  store = YAML.load_file(yml_file)
  todays_day = Time.new.to_a
  today = todays_day[4].to_s+'_'+todays_day[3].to_s+'_'+todays_day[5].to_s

  store[today] = files
  File.open(yml_file, "w") do |file|
    file.write store.to_yaml
  end
end

def view_stash
  yml_file = 'results_store.yml'
  store = YAML.load_file(yml_file)
  puts store.to_s
end

