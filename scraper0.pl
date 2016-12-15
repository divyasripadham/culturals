my $url = 'http://blog.knowafest.com/search/label/Cultural%20Fests';
my $html = qx{curl --silent $url};
use Time::Piece;


my @lines = split /\n/, $html;
$parseon= 0;
$m = 0;

print  "name|startdate|enddate|event_type|description|address_temp|is_published\n";

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
      #print $1,"\n";
      parse_url($1);
      #print "___________________________________\n\n\n";
      $m=0;
  }
}



sub parse_url {


my $url = @_[0];
#print "Prasing URL", $url;
my $html = qx{curl --silent $url};

my @lines = split /\n/, $html;
$parseon= 0;

$eventname = 0;
$organizer = 0;
$location = 0;
$date = 0;
$desc = 0;
$contact =0;
my @desclines;
my @contactlines;
$eventname_str = '';
$organizer_str = '';
$location_str = '';
$date_str = '';
$desc_str = '';
$contact_str ='';

foreach my $line (@lines) {

    #Scrape Event Name
    if ($line =~ m/<dt><strong>Event Name <\/strong><\/dt>/){
        $eventname = 1;
    }

    if ($line =~ m/<dd>(.*?)<\/dd> <br \/>/ and $eventname == 1){
        #push (@links, $line);
        #print "Event Name: ", $1,"\n";
        $eventname_str = $1;
        $eventname = 0;
    }

    #Scrape Organizer
    #if ($line =~ m/<dt><strong>Organiser <\/strong><\/dt>/){
    #    $organizer = 1;
        #print "Organizer: ","\n";
    #}

    if ($line =~ m/<dt><strong>Organiser <\/strong><\/dt>\s*<dd>\s*<a href=".*?>(.*?)<\/a> <\/dd> <br \/>/){
        #print $line;
        #push (@links, $line);
        # print "Organizer: ", $1,"\n";
        $organizer_str = $1;
        $organizer = 0;
    }

    #Scrape Location
    if ($line =~ m/<dt><strong>Location <\/strong><\/dt>/){
        $location = 1;
    }

    if ($line =~ m/<dd><i .+?><\/i>\s+<a href=.+?>(.+?)<\/a>.+<a href=.+?>(.+?)<\/a>/ and $location == 1){
        #push (@links, $line);
        #print "Location: ", $1,", ", $2,"\n";
        $location_str = $1,", ", $2;
        $location = 0;
    }


    #Scrape Date
    #if ($line =~ m/<dt><strong>Event Dates<\/strong><\/dt>/){
    #    $date = 1;
    #}

    if ($line =~ m/<dt><strong>Event Dates<\/strong><\/dt>\s*<dd><i .+?><\/i>(.+?)<\/dd>/){
        #push (@links, $line);
        #print "Date: ", $1, "\n";
        #Date:   10th-11th December 2016
        $datestr= $1;
        if($datestr =~ m/\s*(.*?)\s+(.*?)\s+(.*)/){
          #10th-11th
          $startend = $1;

          #print "Date: ", $1, " month: ", $2, " year: ", $3,  "\n";
          $month = $2;
          $year = $3;

          if($startend =~ m/([0-9]+).*?-([0-9]*).*/){
            $d1 = $1;
            $d2 = $2;
            #print $1, "----", $2, "\n";

            $dstr1 =  $d1." ".$month." ".$year;
            $dstr2 =  $d2." ".$month." ".$year;

            $date1 = Time::Piece->strptime($dstr1,"%d %B %Y");
            $date2 = Time::Piece->strptime($dstr2,"%d %B %Y");

            #print "Final Time:",  $date->strftime('%Y-%m-%d');


          }
          elsif($startend =~ m/([0-9]+).*?/){
            $d1 = $1;
            #print $1, "--\n";

            #print "New Date: ", $month, $d1, $year;

            $dstr =  $d1." ".$month." ".$year;
            #print "DSTR: " , $dstr, "\n";

            $date1 = Time::Piece->strptime($dstr,"%d %B %Y");
            $date2 = Time::Piece->strptime($dstr,"%d %B %Y");
            #print "Final Time:",  $date->strftime('%Y-%m-%d');

            #$date->mday = $d1;
            #$date->fullmonth= $month;
            #$date->year= $year;

            #print "New Date: ", $date->mday, $date->fullmonth, $date->year;
            #print "New Date: ", $date->ymd;

            #print Time::Piece->strptime($date, '%d-%b-%Y')->strftime('%m/%d/%Y');

          }
        }

    }


    #Scrape Description
    if ($desc == 1)
    {
        push @desclines, $line;
    }

     if ($line =~ m/<\/h4>/ and $desc == 0){
        $desc = 1;
    }

    if ($line =~ m/<h4> Event Details:<\/h4><p>(.*?)<\/p>/){
        $description = $1;
        $description =~ s|<.+?>||g;

        #name|startdate|enddate|event_type|description|address_temp|is_published
        #print "**********\n";
        print  $eventname_str, "|", $date1->strftime('%Y-%m-%d'), "|", $date2->strftime('%Y-%m-%d'), "|", "Cultural",  "|",  $description, "|", $organizer_str , ",", $location_str, "|", "1", "\n";
        $desc = 2;
    }


    #Scraping Contact
    if ($contact == 1){
        push @contactlines, $line;
    }

    if ($line =~ m/<div class="profile-edit tab-pane fade" id="contact">/ and $contact == 0){
        $contact = 1;
    }

    if ($line =~ m/<\/div>/ and  $contact == 1){
        $contact = 0;
        $contacts = join(" ",@contactlines);
        $contacts =~ s|<.+?>||g;
        #print "Contact:", $contacts,"\n";
    }

}
}
