<?xml-model href="http://www.ncl.org.br/NCL4.0/profiles/NCL40.xsd"?>
<ncl xmlns="http://www.ncl.org.br/NCL4.0/NCL40Profile">
    <head>
        <regionBase>
            <region id="bgReg" width="100%" height="100%" zIndex="1"/>
            <region id="loadReg" top="40%" left="40%" width="20%" height="20%" zIndex="1"/>
        </regionBase>
                
        <descriptorBase>
            <descriptor id="bgDesc" region="bgReg"/>
            <descriptor id="loadDesc" region="loadReg" focusIndex="0"/>
        </descriptorBase>

        <connectorBase id="connBaseId">
            <importBase alias="conn" documentURI="defaultConnBase.ncl"/>
            
            <causalConnector id="onBeginStartPrep">
                <simpleCondition role="onBegin"/>
                <simpleAction role="startPreparation" max="unbounded"/>
            </causalConnector>
            
            <causalConnector id="onEndPrepStart">
                <simpleCondition role="onEndPreparation"/>
                <simpleAction role="start" max="unbounded"/>
            </causalConnector>
        </connectorBase>
    </head>

    <body>
        <port id="entry" component="loading"/>
        <media id="loading" src="media/connect.jpeg" descriptor="loadDesc"/>
        
        <media id="bg" src="media/bg.mp4" descriptor="bgDesc"/>
        
        <media id="guarana" type="application/x-ncl360" src="flower.ncl360">
            <area id="flower360" label="flower360"/>
            <area id="sea360" label="sea360"/>
        </media>

        <media id="opa" src="media/connect.jpeg" descriptor="loadDesc"/>

        <link xconnector="conn#onSelectionStopStart">
            <bind role="onSelection" component="loading"/>
            <bind role="stop" component="loading"/>
            <bind role="start" component="bg"/>
        </link>

        <link xconnector="onBeginStartPrep">
            <bind role="onBegin" component="bg"/>
            <bind role="startPreparation" component="guarana"/>
        </link>
        
        <link xconnector="onEndPrepStart">
            <bind role="onEndPreparation" component="guarana"/>
            <bind role="start" component="guarana" interface="flower360"/>
        </link>

        <link xconnector="conn#onBeginStart">
            <bind role="onBegin" component="guarana" interface="flower360"/>
            <bind role="start" component="opa"/>
        </link>

        <link xconnector="conn#onEndStop">
            <bind role="onEnd" component="guarana" interface="flower360"/>
            <bind role="stop" component="opa"/>
        </link>
    </body>
</ncl>
