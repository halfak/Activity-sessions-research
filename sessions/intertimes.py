"""
Converts a sorted dataset of <user> <timestamp> pairs into <user> <intertime>
pairs.

Usage:
    intertimes (-h|--help)
    intertimes [--timestamp-format=<format>]

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


def read_user_actions(f, format):
    
    for line in f:
        parts = line.strip().split("\t")
        
        user = parts[0]
        if format == "<unix timestamp>":
            timestamp = Timestamp(float(parts[1]))
        else:
            timestamp = Timestamp.strptime(parts[1], format)
        
        if len(parts) >= 3:
            action = parts[2]
        else:
            action = None
        
        yield user, timestamp, action
    

def main():
    args = docopt.docopt(__doc__)
    
    run(sys.stdin, args['--timestamp-format'])

def run(f, format):
    
    user_actions = read_user_actions(f, format)
    
    print("user\tintertime")
    
    for user, actions in groupby(user_actions, key=lambda ua: ua[0]):
        
        last_action = None
        
        sys.stderr.write("Processing {0}: ".format(user))
        
        for _, timestamp, action in actions:
            
            if last_action is not None:
                print(
                    "{0}\t{1}".format(
                        user.replace("\t", "\\t").replace("\n", "\\n"),
                        timestamp - last_action[0]
                    )
                )
            
            sys.stderr.write(".")
            last_action = (timestamp, action)
        
        sys.stderr.write("\n")
