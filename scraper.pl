my $url = 'http://blog.knowafest.com/search/label/Cultural%20Fests';
my $html = qx{curl --silent $url};

my @lines = split /\n/, $html;
$parseon= 0;
$m = 0;

foreach my $line (@lines) {
  #Skipping lines prior to "Latest Events"

  #if ($line =~ m/<h4>Latest Events/){
  #  $parseon = 1;
  #}

  if ($line =~ m/<h3 class='post-title entry-title'>/){
    $m = 1;
  }

  if ($line =~ m/<a href='.*html'>$/ and $m == 1){
      #push (@links, $line);
      print $line,"\n";
      $m=0;
  }



=for comment

  #If we match this, the next set of lines will be college post related



  if ($line =~ m/<h3 class='post-title entry-title'>/){
    #parsing the post info
    foreach my $postline (@lines) {
      if ($line =~ m/<a href='.*'>/){
        print $line,"\n";
      }
    }
  }

  if($parseon == 1){
    print $line,"\n";
  }
=cut

  #Skipping lines after <ul class='pager'> as this denotes footer
  #if ($line =~ m/<ul class='pager'>/){
  #  $parseon = 0;
  #}

}
