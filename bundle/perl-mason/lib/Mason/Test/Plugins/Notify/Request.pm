package Mason::Test::Plugins::Notify::Request;
use Mason::PluginRole;

before 'run' => sub {
    my ( $self, $path ) = @_;
    print STDERR "starting request run - $path\n";
};

before 'comp' => sub {
    my ( $self, $path ) = @_;
    print STDERR "starting request comp - $path\n";
};

1;
