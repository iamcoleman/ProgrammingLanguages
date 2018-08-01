use strict;
use warnings;
use diagnostics;
# We define the above (pragmas) to force us to write good code
# and to provide information on how to correct errors
# gives us error messages that make sense 

use feature 'say';
# say ends the line with a newline

use feature "switch";
# Use a Perl version of switch called given when

use v5.16;
# use version 5.16 of Perl

use JSON;
# use JSON

use Data::Dumper;
# SQLite

use DBI;
# Data Base something... look up

use Text::CSV;
# write to csv files

use Statistics::R;
# embed R into Perl


my $driver   = "SQLite"; 
my $database = "wh.db";
my $dsn      = "DBI:$driver:dbname=$database";
my $userid   = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
	or die $DBI::errstr;
print "Opened database successfully\n\n";


#########################
##  Running R in Perl  ##
#########################
my $R = Statistics::R->new();

$R->startR ;
 
$R->send( 'weightdata <- read.csv("sample-weight-data-1.csv")' );
$R->send( 'library(ggplot2)' );

$R->send( 'jpeg("rplot.jpg")' );
$R->send( 'qplot(Days.Elapsed, Weight, data=weightdata)' );
$R->send( 'dev.off()' );

 
$R->stopR();


##################
## Create Table ##
##################
my $stmt = qq(CREATE TABLE WORKOUTHUB (
	user_id integer NOT NULL,
	name text NOT NULL,
	age integer NOT NULL,
	year integer NOT NULL,
	month integer NOT NULL,
	day integer NOT NULL,
	weight real NOT NULL
	);
);

my $rv = $dbh->do($stmt);
if($rv < 0) {
   print $DBI::errstr;
} else {
   print "Table created successfully\n";
}
$dbh->disconnect();


#####################
## Insert in Table ##
#####################
my $stmt = qq(INSERT INTO WORKOUTHUB (user_id,name,age,year,month,day,weight)
               VALUES (001, 'Coleman Lyski', 20, 2018, 5, 28, 183.00 ));
my $rv = $dbh->do($stmt) or die $DBI::errstr;

$stmt = qq(INSERT INTO WORKOUTHUB (user_id,name,age,year,month,day,weight)
               VALUES (001, 'Coleman Lyski', 20, 2018, 6, 4, 182.00 ));
$rv = $dbh->do($stmt) or die $DBI::errstr;

$stmt = qq(INSERT INTO WORKOUTHUB (user_id,name,age,year,month,day,weight)
               VALUES (001, 'Coleman Lyski', 20, 2018, 6, 11, 180.50 ));
$rv = $dbh->do($stmt) or die $DBI::errstr;

$stmt = qq(INSERT INTO WORKOUTHUB (user_id,name,age,year,month,day,weight)
               VALUES (001, 'Coleman Lyski', 20, 2018, 6, 18, 181.00 ));
$rv = $dbh->do($stmt) or die $DBI::errstr;

$stmt = qq(INSERT INTO WORKOUTHUB (user_id,name,age,year,month,day,weight)
               VALUES (001, 'Coleman Lyski', 20, 2018, 6, 25, 182.00 ));
$rv = $dbh->do($stmt) or die $DBI::errstr;

$stmt = qq(INSERT INTO WORKOUTHUB (user_id,name,age,year,month,day,weight)
               VALUES (001, 'Coleman Lyski', 20, 2018, 7, 2, 183.00 ));
$rv = $dbh->do($stmt) or die $DBI::errstr;

$stmt = qq(INSERT INTO WORKOUTHUB (user_id,name,age,year,month,day,weight)
               VALUES (001, 'Coleman Lyski', 20, 2018, 7, 9, 183.50 ));
$rv = $dbh->do($stmt) or die $DBI::errstr;

$stmt = qq(INSERT INTO WORKOUTHUB (user_id,name,age,year,month,day,weight)
               VALUES (001, 'Coleman Lyski', 20, 2018, 7, 16, 183.50 ));
$rv = $dbh->do($stmt) or die $DBI::errstr;

$stmt = qq(INSERT INTO WORKOUTHUB (user_id,name,age,year,month,day,weight)
               VALUES (001, 'Coleman Lyski', 20, 2018, 7, 23, 184.00 ));
$rv = $dbh->do($stmt) or die $DBI::errstr;

$stmt = qq(INSERT INTO WORKOUTHUB (user_id,name,age,year,month,day,weight)
               VALUES (001, 'Coleman Lyski', 20, 2018, 7, 30, 184.50 ));
$rv = $dbh->do($stmt) or die $DBI::errstr;


print "Records created successfully\n";
$dbh->disconnect();


#######################
## Select from Table ##
#######################
my $stmt = qq(SELECT user_id,name,age,year,month,day,weight from WORKOUTHUB;);
my $sth = $dbh->prepare( $stmt );
my $rv = $sth->execute() or die $DBI::errstr;

if($rv < 0) {
   print $DBI::errstr;
}

while(my @row = $sth->fetchrow_array()) {
      print "USER_ID = ". $row[0] . "\n";
      print "NAME = ". $row[1] ."\n";
      print "AGE = ". $row[2] ."\n";
      print "YEAR = ". $row[3] ."\n";
      print "MONTH = ". $row[4] ."\n";
      print "DAY = ". $row[5] ."\n";
      print "WEIGHT =  ". $row[6] ."\n\n";
}
print "Operation done successfully\n";
$dbh->disconnect();


########################
## Convert SQL to CSV ##
########################
my $stmt = qq(SELECT user_id,name,age,year,month,day,weight from WORKOUTHUB;);
my $sth = $dbh->prepare( $stmt );
my $rv = $sth->execute() or die $DBI::errstr;

if($rv < 0) {
   print $DBI::errstr;
}

my $csv = Text::CSV->new ( { binary => 1 } ) 
   or die "Cannot use CSV: ".Text::CSV->error_diag ();

open my $fh, ">:raw", "results-1.csv";

$csv->print($fh, $sth->{NAME});
print $fh "\n";

while(my $row = $sth->fetchrow_arrayref){   
  $csv->print($fh, $row);
  print $fh "\n";
}

print "Operation done successfully\n";
$dbh->disconnect();








#################################################
############# Adding Weight Data ################
#################################################
# receive the new weight data in .txt format
my $weight_data = 'weight-data.txt';
open my $fh_weight_data, '<', $weight_data or die "Can't open file : $!";
my ($weight, $year, $month, $day);
while(my $data = <$fh_weight_data>){
	chomp($data);
	($weight, $year, $month, $day) = split /:/, $data;
}
close $fh_weight_data or die "Couldn't close file : $!";
# save the new weight data in a hash map
my $new_weight_data = {weight=>$weight, year=>$year, month=>$month, day=>$day};

# open the saved json file that corresponds to the weight data coming in
my $json = JSON->new;
my $filename = 'coleman.json';
{
	local $/;
	open my $fh_json, '<', $filename;
	$json = <$fh_json>;
	close $fh_json;
}
# decode the json file and push the new data into 'weight_history'
my $data = decode_json($json);
push @{ $data->{'weight_history'} }, $new_weight_data;

# save the json file with the new weight data
open my $fh_update_json, ">", $filename or die "Can't open file : $!";
print $fh_update_json encode_json($data);
close $fh_update_json or die "Couldn't close file : $!";







############################################
########### Adding New User ################
############################################

# Open coleman.txt file sent from app to create a new user
my $new_profile = 'coleman.txt';
open my $fh, '<', $new_profile or die "Can't open file : $!";
my ($name, $age, $weight, $time, $year, $month, $day);
# extract all the info from the .txt file 
while(my $info = <$fh>){
  chomp($info); 
  ($name, $age, $weight, $time) = split /:/, $info;
  ($year, $month, $day) = split /-/, $time;
  #print "Name: $name\nAge: $age\nWeight: $weight\nTime: $time\n";
  #print "Year: $year\nMonth: $month\nDay: $day\n";
}
close $fh or die "Couldn't close file : $!";

# turn the data from the text file into JSON format
my $json = JSON->new;
my $profile_to_json = {name=>$name, age=>$age, weight_history=>[{weight=>$weight, year=>$year, month=>$month, day=>$day}]};

# finally, save this new profile as a JSON file
#print $json->encode($profile_to_json) . "\n";
open my $fh2, ">", "coleman.json";
print $fh2 $json->encode($profile_to_json) . "\n";
close $fh2;



############################################
############# idk what this is #############
############################################

# my $filename = 'coleman.json';

# my $json_text = do {
#    open(my $json_fh, "<:encoding(UTF-8)", $filename)
#       or die("Can't open \$filename\": $!\n");
#    local $/;
#    <$json_fh>
# };

# my $json = JSON->new;
# my $data = $json->decode($json_text);

# for ( @{$data->{weight_history}} ) {
#    print $_->{weight}."\n";
#    print $_->{day}."\n";
# }