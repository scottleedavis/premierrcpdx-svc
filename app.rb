require_relative 'forum_connect'
require_relative 'results_store'

offroad = 'http://www.rctech.net/forum/northwest-racers/839741-premier-rc-official-offroad-3000.html'
onroad = 'http://www.rctech.net/forum/northwest-racers/839742-premier-rc-official-road-3000.html'
oval = 'http://www.rctech.net/forum/northwest-racers/839743-premier-rc-official-oval-3000.html'

results = {
  offroad: [],
  onroad: [],
  oval: []
}
get_results(offroad) do |resp|
  results[:offroad].push resp
end

get_results(onroad) do |resp|
  results[:onroad].push resp
end

get_results(oval) do |resp|
  results[:oval].push resp
end

puts results
upload results
