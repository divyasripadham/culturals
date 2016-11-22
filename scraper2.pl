
use HTML::LinkExtor;

$base_url= 'http://blog.knowafest.com/search/label/Cultural%20Fests';

$parser = HTML::LinkExtor->new(undef, $base_url);
$parser->parse_file($filename);
@links = $parser->links;
foreach $linkarray (@links) {
    my @element = @$linkarray;
    my $elt_type = shift @element;                  # element type

    # possibly test whether this is an element we're interested in
    while (@element) {
        # extract the next attribute and its value
        my ($attr_name, $attr_value) = splice(@element, 0, 2);
        print $attr_name, $attr_value;
        # ... do something with them ...
    }
}
