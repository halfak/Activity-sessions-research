"""
Converts a sorted dataset of <user> <timestamp> pairs into <user> <intertime>
pairs.

Usage:
    last_osm_change (-h|--help)
    last_osm_change [--timestamp-format=<format>]

Options:
    -h|--help                    Shows this documentation
    --timestamp-format=<format>  Format for timestamp.  If no format is
                                 specified, timestamp will be interpretted as a
                                 unix timestamp.
                                 [default: <unix timestamp>]
"""
import sys
from itertools import groupby

import docopt
from mw import Timestamp


def read_osm_changes(f, format):
    
    for line in f:
        parts = line.strip().split("\t")
        
        user = parts[0]
        if format == "<unix timestamp>":
            timestamp = Timestamp(float(parts[1]))
        else:
            timestamp = Timestamp.strptime(parts[1], format)
        
        if len(parts) >= 3:
            change_id = parts[2]
        else:
            change_id = None
        
        yield user, timestamp, change_id
    

def main():
    args = docopt.docopt(__doc__)
    
    run(sys.stdin, args['--timestamp-format'])

def run(f, format):
    
    user_changes = read_osm_changes(f, format)
    
    print("user_id\ttimestamp\tchange_id")
    
    user_change_groups = groupby(user_changes, key=lambda ua: (ua[0],ua[2]))
    for (user, change_id), changes in user_change_groups:
                
        sys.stderr.write("Processing {0}: ".format(user))
        
        last_timestamp = None
        for _, timestamp, change_id in changes:
            
            sys.stderr.write(".")
            last_timestamp = timestamp
        
        print("{0}\t{1}\t{2}".format(user,
                                     last_timestamp.strftime(format),
                                     change_id))
        
        sys.stderr.write("\n")

if __name__ == "__main__": main()
