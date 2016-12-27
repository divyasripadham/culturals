my $url = 'http://blog.knowafest.com/search/label/Cultural%20Fests';
my $html = qx{curl --silent $url};

use Time::Piece;

use HTML::TokeParser::Simple;

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };


my @lines = split /\n/, $html;
$parseon= 0;
$m = 0;

print  "name|description|organizer|location|startdate|enddate|college_url|url|contact|is_published\n";

#print "Name|", $eventdetails, "|", $organizer, "|", $location, "|", $startdate, "|", $enddate, "|", $weburl,"|", $eventurl,"|", $festmailid, "|", $eventcoord , "\n";

foreach my $line (@lines) {
  #Skipping lines prior to "Latest Events"

  #if ($line =~ m/<h4>Latest Events/){
  #  $parseon = 1;
  #}

  if ($line =~ m/<h3 class='post-title entry-title'>/){
    $m = 1;
  }

  if ($line =~ m/<a href='(.*html)'>$/ and $m == 1){
      #push (@links, $line);
      #system "wget $1";
      #print $1,"\n";
      #parse_url($1);
      #print "___________________________________\n\n\n";


      my $parser = HTML::TokeParser::Simple->new(url => $1);
      # while (my $anchor = $parser->get_tag('a')) {
      #   next unless defined(my $href = $anchor->get_attr('href'));
      #   say $href;
      # }

      my $eventname = '';
      my $organizer = '';
      my $location = '';
      my $startdate = '';
      my $enddate = '';
      my $weburl = '';
      my $eventurl = '';
      my $eventdetails = '';
      my $festmailid = '';
      my $eventcoord = '';


      while ( my $token = $parser->get_token ) {

        if ($token->is_text){
          my $val = $token->as_is;
          $val = trim($val);

          if($val eq "Event Details:"){
              #print "Event Details:\n";
              while ( $token = $parser->get_token ) {
                #next unless $token->is_start_tag("p");
                next unless $token->is_text;
                #if ($token->is_text){
                  $eventdetails = trim($token->as_is);

                  #$eventdetails =~ s/\'/\\\'/g;
                  $eventdetails =~ s/\"/\'/g;

                  #print $val, ":",  $eventdetails, "\n";

                  last;
                #}
              }

          }
          elsif ($val eq "Fest Mail ID:"){
              #print "Event Details:\n";
              while ( $token = $parser->get_token ) {
                next unless $token->is_end_tag("h4");
                $festmailid = trim($parser->get_token->as_is);
                #print $val, ":",  $festmailid, "\n";
                last;
              }
          }
          elsif ($val eq "Event Co-ordinators:"){
              #print "Event Details:\n";
              while ( $token = $parser->get_token ) {
                next unless $token->is_end_tag("h4");
                $eventcoord = trim($parser->get_token->as_is);
                #print $val, ":",  $eventcoord, "\n";
                last;
              }
          }
        }



        if ($token->is_text){
          my $val = $token->as_is;
          $val = trim($val);
          if($val eq "For more Information please visit"){
              my $count = 1;
              while ( $token = $parser->get_token ) {
                #next unless $token->is_end_tag("h4");
                #$attr = $parser->get_attr(['onclick']);
                #$token = $parser->get_token;
                if($token->is_start_tag('button')){
                  ++$count;

                  $url = $token->get_attr('onclick');
                  if($token->get_attr('onclick') =~ m/window.open\('(.*?)'\)/){
                    $url= $1;
                    #print $val, ":",  $url, "\n";
                  }

                  if ($count == 2){
                    $eventurl = $url;
                    #print  "Event URL:",  $eventurl, "\n";
                  }
                  if ($count == 3){
                    $weburl = $url;
                    #print  "Website URL:",  $weburl, "\n";
                    last;
                  }
                }

              }
          }
        }

        if ( $token->is_start_tag('dl') ) {
            #print $token->as_is, "\n";
            $parseon = 1;
        }
        elsif ( $token->is_end_tag( 'dl' ) ) {
               #print $token->as_is, "\n";
               $parseon = 0;
        }
        if($parseon == 1 ){
          if ($token->is_text){
            my $val = $token->as_is;
            #print $val, "--";
            $val = trim($val);
            if($val eq "Event Name"){
                while ( $token = $parser->get_token ) {
                  next unless $token->is_start_tag("dd");
                  $eventname = trim($parser->get_token->as_is);
                  #$eventname =~ s/\'/\\\'/g;
                  $eventname =~ s/\"/\'/g;
                  #print $val, ":",  $eventname, "\n";
                  last;
                }
            }

            if($val eq "Organiser"){
                while ( $token = $parser->get_token ) {
                  next unless $token->is_start_tag("a");
                  $organizer = trim($parser->get_token->as_is);
                  #print $val, ":",  $organizer, "\n";
                  last;
                }
            }

            if($val eq "Location"){
                my $count =0;
                #print $val, ":";
                while ( $token = $parser->get_token ) {
                  next unless $token->is_start_tag("a");
                  $token = $parser->get_token;

                  ++$count;

                  if($count == 1){
                    $location = trim($token->as_is). ", ";
                  }
                  if($count == 2)
                  {
                    $location = $location. trim($token->as_is);
                    #print $location;
                    last;
                  }


                }
            }

            if($val eq "Event Dates"){
                while ( $token = $parser->get_token ) {
                  next unless $token->is_end_tag("i");
                  $token = $parser->get_token;
                  #print $val, ":",  $token->as_is, "\n";
                  $datestr= $token->as_is;

                  if($datestr =~ m/\s*(.*?)\s+(.*?)\s+(.*)/){


                    #10th-11th
                    $startend = $1;

                    #print "Date: ", $1, " month: ", $2, " year: ", $3,  "\n";
                    $month = $2;
                    $year = trim($3);

                    if($startend =~ m/([0-9]+).*?-([0-9]*).*/){

                      $d1 = $1;
                      $d2 = $2;
                      #print $1, "----", $2, "\n";

                      $dstr1 =  $d1." ".$month." ".$year;
                      $dstr2 =  $d2." ".$month." ".$year;

                      $startdate = Time::Piece->strptime($dstr1,"%d %B %Y");
                      $enddate = Time::Piece->strptime($dstr2,"%d %B %Y");

                      #print "Final Time:",  $date->strftime('%Y-%m-%d');
                      #print "Start Date :",  $startdate->strftime('%Y-%m-%d'), "\n";
                      #print "End Date :",  $enddate->strftime('%Y-%m-%d'), "\n";

                    }
                    elsif($startend =~ m/([0-9]+).*?/){

                      $d1 = $1;
                      #print $1, "--\n";

                      #print "New Date: ", $month, $d1, $year;

                      $dstr =  $d1." ".$month." ".$year;
                      #print "DSTR: " , $dstr, "\n";

                      $startdate = Time::Piece->strptime($dstr,"%d %B %Y");
                      $enddate = Time::Piece->strptime($dstr,"%d %B %Y");
                      #print "Start Date :",  $startdate->strftime('%Y-%m-%d'), "\n";
                      #print "End Date :",  $enddate->strftime('%Y-%m-%d'), "\n";

                      #print "Final Time:",  $date->strftime('%Y-%m-%d');

                      #$date->mday = $d1;
                      #$date->fullmonth= $month;
                      #$date->year= $year;

                      #print "New Date: ", $date->mday, $date->fullmonth, $date->year;
                      #print "New Date: ", $date->ymd;

                      #print Time::Piece->strptime($date, '%d-%b-%Y')->strftime('%m/%d/%Y');

                    }
                  }
                  last;
                }
            }




          }
           #  print $token->as_is, "--";
        }


      }

      # while ( my $token = $parser->get_token ) {
      #     # This prints all text in an HTML doc (i.e., it strips the HTML)
      #     next unless $token->is_text;
      #     #print $token->as_is;
      #     if ( $token->is_start_tag('dl') ) {
      #       #my $action = $token->get_attr(action);
      #       #$action =~ s/www\.foo\.com/www.bar.com/;
      #       #$token->set_attr('action', $action);
      #       print $token->as_is;
      #     }
      #   }

      print $eventname, "|", $eventdetails, "|", $organizer, "|", $location, "|", $startdate, "|", $enddate, "|", $weburl,"|", $eventurl,"|", $festmailid." ". $eventcoord , "|", 1, "\n";
      $m=0;
      #last;
  }
}
