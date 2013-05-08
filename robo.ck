// (launch with send.ck)

// the patch
SinOsc s => JCRev r => dac;
.5 => s.gain;
.1 => r.mix;

// create our OSC receiver
OscRecv recv;
// use port 6449 (or whatever)
6449 => recv.port;
// start listening (launch thread)
recv.listen();

// create an address in the receiver, store in new variable
recv.event( "/foo/notes, i" ) @=> OscEvent @ oe;

// infinite event loop
while( true )
{
    // wait for event to arrive
    oe => now;
    
    // grab the next message from the queue. 
    while( oe.nextMsg() )
    { 
        int emotion;
        
        // getFloat fetches the expected float (as indicated by "i f")
        oe.getInt() => emotion;
        
        if (emotion == 2) {
            [80, 82, 85, 83] @=> int sadNotes[];
            for ( 0 => int i; i < sadNotes.cap(); i++) {
                Std.mtof(sadNotes[i]) => s.freq;
                
                dur duration;
                if (i % 2 == 0)
                    250::ms => duration;
                else
                    400::ms => duration;
                
                duration => now;
            }
        } else if (emotion == 1) {
            [80, 82, 87, 84] @=> int happyNotes[];
            
            for ( 0 => int i; i < happyNotes.cap(); i++) {
                Std.mtof(happyNotes[i]) => s.freq;
                
                dur duration;
                if (i % 2 == 0)
                    250::ms => duration;
                else
                    400::ms => duration;
                
                duration => now;
            }
        }
        
        // print
        <<< "got (via OSC):", emotion >>>;
    }
}