module Handler.Home where

import Import



{-

Yesod follows a naming convention for handler function names: the lower-cased
HTTP request method, followed by the route name. Therefore, the function for
HomeR's GET handler would be getHomeR.

Each handler function lives in the Handler monad, and has to return a value
that can be serialized over an HTTP connection. Two common examples of such
values are HTML and JSON data. In this case, we'll return Html.

-}
getHomeR :: Handler Html
-- defaultLayout uses the application's standard page layout to display
-- some contents. In our application, we're just using the standard
-- layout, which includes a basic HTML 5 page outline.
getHomeR = defaultLayout $ do
    -- Set the HTML <title> tag.
    setTitle "Michi's Playground!"

    -- Include some CDN-hosted Javascript and CSS to make our page a little nicer.
    addScriptRemote "//ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"
    -- addStylesheetRemote "//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"

    -- Hamlet is the standard HTML templating language used by Yesod.
    -- In this case, we include some specific markup to take advantage of
    -- the bootstrap CSS we just included.
    -- For more information on Hamlet, please see:
    -- http://www.yesodweb.com/book/shakespearean-templates
    [whamlet|
        <div .container-fluid>
          <div .row-fluid>
            <h1>Michi's Playground
        
          <div .row-fluid>
            <div .span6>
                <h2>_{MsgTitle}
                <p>
                    _{MsgMass}
                    <input #massinput type=number value=70>
                    _{MsgSize}
                    <input #sizeinput type=double value=1.75>
                    <br>
                    _{MsgResult}
                    <input #bmioutput disabled>
                <h2>Inkrementator
                <p>
                    <input #timer value="00.0" disabled>
                    <button #restart>Neu Starten!
                    <br>
                    <input #incrementor type=number value=0 disabled>
                    <button #inc>Erhöhen!
    |]

    -- Similar to Hamlet, Yesod has Lucius for CSS, and Julius for Javascript.
    toWidget [lucius|
        body {
            margin: 0 auto;
        }
    |]
    toWidget [julius|
        function updateBMI() {
            $.getJSON("/bmi/" + $("#massinput").val() + "/" + $("#sizeinput").val(), function (o) {
                $("#bmioutput").val(o.value.toFixed(2));
            });
        }

        var timer_running = false;
        var starttime = 0;
        var duration = 60e3;

        function updateTimer() {
            var now = $.now();

            if(starttime == 0 && timer_running){
                starttime = now;
                $("#incrementor").val(0);
            }

            var rem = starttime + duration - now;

            if(rem <= 0 && timer_running) {
                timer_running = false;
                $("#inc").attr("disabled", "disabled");
            }

            if (timer_running)
                $("#timer").val(Math.floor(rem/100) / 10);
            else
                $("#timer").val("00.0");
        }
        
        $(function(){
            updateBMI();
            $("#massinput").change(updateBMI);
            $("#sizeinput").change(updateBMI);

            window.setInterval(updateTimer, 100);
            
            $("#inc").click(function() {
                var value = $("#incrementor").val();
                ++value;
                $("#incrementor").val(value);

                timer_running = true;
            });

            $("#restart").click(function(){
                starttime = 0;
                timer_running = false;
                $("#inc").removeAttr("disabled");
            })
            
        });
    |]