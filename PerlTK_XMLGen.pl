#!/usr/local/bin/perl

use Tk;
use Tk::FileSelect;

### Variable declare
#my $path = `pwd`;
my $curr_path = "C:/my_perl/perl-tk/PFU_xml_1.xml";

# Main Window
my $mw = new MainWindow;
my $label = $mw -> Label(-text=>"Enter the data form for XML update  ") -> pack(-fill=>'x');
        
#Entry menu size and Title
my $menu = $mw -> configure(-title =>'# Table Entry of DotHill FW version', -background=>'lightblue');
$mw -> geometry('500x300');

#Build entry field
my $data_form1  = $mw -> Frame(-relief=>'groove',-borderwidth=>5,-background=>'lightblue',)->pack(-side=>'top',-fill=>'x');
my $data_entry1 = $data_form1->Label(-text=>'Build : ',-background=>'lightblue',-foreground=>'black',)->pack(-side=>'left');
my $data_val1 = $data_form1->Entry(-width=>25,-background=>'white')->pack(-side=>'left',-pady=>5);

#MC code entry field
my $data_form2  = $mw -> Frame(-relief=>'groove',-borderwidth=>5,-background=>'lightblue',)->pack(-side=>'top',-fill=>'x');
my $data_entry2 = $data_form2->Label(-text=>'MC :   ',-background=>'lightblue',-foreground=>'black',)->pack(-side=>'left');
my $data_val2 = $data_form2->Entry(-width=>25,-background=>'white')->pack(-side=>'left',-pady=>5);

#SC code entry field
my $data_form3  = $mw -> Frame(-relief=>'groove',-borderwidth=>5,-background=>'lightblue',)->pack(-side=>'top',-fill=>'x');
my $data_entry3 = $data_form3->Label(-text=>'SC :   ',-background=>'lightblue',-foreground=>'black',)->pack(-side=>'left');
my $data_val3 = $data_form3->Entry(-width=>25,-background=>'white')->pack(-side=>'left',-pady=>5);

#EC code entry field
my $data_form4  = $mw -> Frame(-relief=>'groove',-borderwidth=>5,-background=>'lightblue',)->pack(-side=>'top',-fill=>'x');
my $data_entry4 = $data_form4->Label(-text=>'EC :   ',-background=>'lightblue',-foreground=>'black',)->pack(-side=>'left');
my $data_val4 = $data_form4->Entry(-width=>25,-background=>'white')->pack(-side=>'left',-pady=>5);

#SCL entry field
my $data_form5  = $mw -> Frame(-relief=>'groove',-borderwidth=>5,-background=>'lightblue',)->pack(-side=>'top',-fill=>'x');
my $data_entry5 = $data_form5->Label(-text=>'SCL : ',-background=>'lightblue',-foreground=>'black',)->pack(-side=>'left');
my $data_val5 = $data_form5->Entry(-width=>25,-background=>'white')->pack(-side=>'left',-pady=>5);

##my $exit = $data_val5->bind('<Return>'=>sub{&exitProgam,$mw->destroy,if($ret_val){exit($ret_val)}});

##my $button = $mw -> Button(-text => "Quit",-command =>\&exitProgam)-> pack();


my $button_frame = $mw->Frame()->pack(-side => "bottom");
$button_frame->Button(-text => "Load",-background => "lightblue",-command=>\&sub_load)->pack(-side => "left",-ipadx => "15");
$button_frame->Button(-text => "Clear",-background => "lightblue",-command => \&sub_clear)->pack(-side => "left",-ipadx => "15");
#my $paste_text = $mw->Text(-background => "lightblue",-foreground => "black")->pack(-side => "bottom");
$button_frame->Button(-text => "Quit",-background => "lightblue",-command => \&sub_quit)->pack(-side => "bottom",-ipadx => "15");


#main loop here
MainLoop;

sub sub_load
{
  my $build = $data_val1->get();
	my $mc =$data_val2->get();
	my $sc =$data_val3->get();
	my $ec =$data_val4->get();
	my $scl =$data_val5->get();

	if (-e $curr_path) {
		unlink ($curr_path);
	} 
	sleep 2;

	open(LOAD_XML, ">>$curr_path")or die " Cannot open the specified file : $!";
	print LOAD_XML "<Modules>\n";
	print LOAD_XML "\t<Build>$build</Build>\n";
	print LOAD_XML "\t<SoftwareVersion>\n";
	print LOAD_XML "\t\t<mc>$mc</mc>\n";
	print LOAD_XML "\t\t<sc>$sc</sc>\n";
	print LOAD_XML "\t\t<ec>$ec</ec>\n";
	print LOAD_XML "\t\t<scl>$scl</scl>\n";
	print LOAD_XML "\t</SoftwareVersion>\n";
	print LOAD_XML "</Modules>\n";

	sleep 2;
	while (<LOAD_XML>) {
		chomp;
		$size = length $line;
	}

	close(LOAD_XML);

	if (-e $curr_path ) {
		print " Data loading to the XML file is successful \n";
		my $output_frame = $mw->Frame()->pack(-side => "bottom");
		my $paste_out = $output_frame->Text(-background => "lightblue",-foreground => "black")->pack(-side => "bottom");
		$paste_out->insert("end", "Data loading to the XML file is successful");
		$paste_out->insert("end", "\nFile Location > '$curr_path'");

		
	}else 
	{
		print " Data loading error \n";
		my $output_frame = $mw->Frame()->pack(-side => "bottom");
		my $paste_out = $output_frame->Text(-background => "white",-foreground => "black")->pack(-side => "bottom");
		$paste_out->insert("end", "Error in XML file load");
	}
}

#clear action
sub sub_clear
{
	$data_val1->delete(0,'end');
	$data_val2->delete(0,'end');
	$data_val3->delete(0,'end');
	$data_val4->delete(0,'end');
	$data_val5->delete(0,'end');
}


#Exit program :
sub sub_quit {
 	$mw->messageBox(-message=>"Goodbye");

	exit;
}

