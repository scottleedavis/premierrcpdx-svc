var request = require('request');
var cheerio = require('cheerio');

offroad = 'http://www.rctech.net/forum/northwest-racers/839741-premier-rc-official-offroad-3000.html';
onroad = 'http://www.rctech.net/forum/northwest-racers/839742-premier-rc-official-road-3000.html';
oval = 'http://www.rctech.net/forum/northwest-racers/839743-premier-rc-official-oval-3000.html';

request(onroad, function (error, response, html) {
  if (!error && response.statusCode == 200) {
    var $ = cheerio.load(html);
    console.log(html);
    $('a.bigusername').each(function(i,e){
      if( e.children && e.children[1] && e.children[1].data == 'PremierRCpdx') {
      debugger;
      }
    });
    // $('span.comhead').each(function(i, element){
    //   var a = $(this).prev();
    //   console.log(a.text());
    // });

  }
});