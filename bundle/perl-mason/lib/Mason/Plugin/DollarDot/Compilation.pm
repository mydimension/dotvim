package Mason::Plugin::DollarDot::Compilation;
use Mason::PluginRole;

after 'process_perl_code' => sub {
    my ( $self, $coderef ) = @_;
    $$coderef =~ s/ \$\.([^\W\d]\w*) / \$self->$1 /gx;
};

1;
