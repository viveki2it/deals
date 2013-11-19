//######################################################################################
// Author: ricocheting.com
// Version: v2.0
// Date: 2011-03-31
// Description: displays the amount of time until the "dateFuture" entered below.

// NOTE: the month entered must be one less than current month. ie; 0=January, 11=December
// NOTE: the hour is in 24 hour format. 0=12am, 15=3pm etc
// format: dateFuture1 = new Date(year,month-1,day,hour,min,sec)
// example: dateFuture1 = new Date(2003,03,26,14,15,00) = April 26, 2003 - 2:15:00 pm

dateFuture1 = new Date(2011,10,13,12,10,14);

// TESTING: comment out the line below to print out the "dateFuture" for testing purposes
//document.write(dateFuture +"<br />");


//###################################
//nothing beyond this point
function GetCartTimeCount(cedate, cdate, iid){
    var pattern = /^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$/;
    var cematch = pattern.exec(cedate);
    if (!cematch) {throw new Error('::Error, #dp could not parse dateStr '+cedate);}
    var cmatch = pattern.exec(cdate);
    if (!cmatch) {throw new Error('::Error, #dp could not parse dateStr '+cdate);}

    
    ddate = new Date(cematch[1], cematch[2]-1, cematch[3], cematch[4], cematch[5], cematch[6]);

    dateNow = new Date();	//grab current date
//    dateNow = new Date(cmatch[1], cmatch[2]-1, cmatch[3], cmatch[4], cmatch[5], cmatch[6]);
    amount = ddate.getTime() - dateNow.getTime();	//calc milliseconds between dates
    delete dateNow;

    // if time is already past
    if(amount < 0){
//        document.getElementById(iid).innerHTML="Now!";
        alert("Your cart has been expired")
        window.location.href = "/user_deals/expire_cart"
    }
    // else date is still good
    else{
        hours=0;
        mins=0;
        secs=0;
        out="Cart will expire in ";

        amount = Math.floor(amount/1000);//kill the "milliseconds" so just secs

        hours=Math.floor(amount/3600);//hours
        amount=amount%3600;

        mins=Math.floor(amount/60);//minutes
        amount=amount%60;

        secs=Math.floor(amount);//seconds

        if(hours != 0){
            out += hours +" "+((hours==1)?"hour":"hours")+", ";
        }
        out += mins +" "+((mins==1)?"min":"mins")+", ";
        if(secs != 0){
            out += secs +" "+((secs==1)?"sec":"secs")+", ";
        }
        out = out.substr(0,out.length-2);
        document.getElementById(iid).innerHTML=out;

        setTimeout(function(){
            GetCartTimeCount(cedate, cdate, iid)
            }, 1000);
    }
}