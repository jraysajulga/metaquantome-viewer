<%
    default_title = "Metaquantome"
    info = hda.name
    if hda.info:
        info += ' : ' + hda.info
    root            = h.url_for( "/static/" )

    data =  hda.datatype.dataprovider(hda, 'base')
    app_root        = root + "plugins/visualizations/metaquantome/static"
    app_root = "static/js"
    repository_root = 'static'
    hdadict = trans.security.encode_dict_ids( hda.to_dict() )
    import re
    re_img = re.compile(r"<img .*?>")
%>

<!DOCTYPE HTML>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>${hda.name | h} | Metaquantome Visualizer</title>

        <link rel="stylesheet" href="static/css/index.css">

        <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>

        ${h.js( 'libs/jquery/jquery',
                'libs/jquery/jquery-ui')}

        <link rel="stylesheet" type="text/css" href="static/js/lib/DataTables/datatables.min.css"/>
        <script type="text/javascript" src="static/js/lib/DataTables/datatables.min.js"></script>
        <script src="//d3js.org/d3.v5.min.js"></script>
        <!--<script src="//cdn.rawgit.com/newrelic-forks/d3-plugins-sankey/master/sankey.js"></script> -->
        <script type="text/javascript" src="https://www.google.com/jsapi?autoload={'modules':[{'name':'visualization','version':'1.1','packages':['sankey']}]}"></script>

        ${h.js( 'libs/jquery/select2',
                'libs/bootstrap-tour',
                'libs/underscore',
                'libs/backbone',
                'libs/require')}
        ${h.css( 'base', 'jquery-ui/smoothness/jquery-ui' )}
        <!--'libs/d3',-->
    </head>
<body>
    <!--<button id="resetBtn">Reset</button>-->
    <!--<table id="data-table"></table>-->
</body>

<script>
    var app_root = '${app_root}';
    var repository_root = '${repository_root}';

     var Galaxy = Galaxy || parent.Galaxy || {
                root    : '${root}',
                emit    : {
                    debug: function() {}
                }
            };
            window.console = window.console || {
                log     : function(){},
                debug   : function(){},
                info    : function(){},
                warn    : function(){},
                error   : function(){},
                assert  : function(){}
            };
            require.config({
                baseUrl: 'static/js',
                paths: {
                    "plugin"        : "",
                    "d3"            : "libs/d3",
                    "repository"    : "${repository_root}"
                },
                shim: {
                    "libs/underscore": { exports: "_" },
                    "libs/backbone": { exports: "Backbone" },
                    "d3": { exports: "d3" }
                }
            });
    $(function() {
        require( [ 'app' ], function( App ) {
            var app = new App({dataset_id : "${hdadict['id']}",
                                history_id : "${hdadict['history_id']}",
                                column_types : ${[x.encode('utf-8') for x in hdadict['metadata_column_types']]}});
            $('body').append(app.$el);
        });
    });

    /*var volcanoPlot = volcanoPlot()
        .xAxisLabel('-log<tspan baseline-shift="sub">10</tspan>False Discovery Rate',)
        .yAxisLabel('log<tspan baseline-shift="sub">2</tspan>Fold-change')
        .foldChangeThreshold(2.0)
        .sampleID("gene")
        .xColumn("log2(fold_change)")
        .yColumn("q_value");

    d3.select('#chart')
        .data([[{"gene" : "C13orf15", "log2(fold_change)" : -3.26837, "q_value" : 2.50041e-13},
                {"gene" : "TSC22D3", "log2(fold_change)" : -3.26657, "q_value" : 2.50041e-13},
                {"gene" : "CRISPLD2", "log2(fold_change)" : -2.69648, "q_value" : 6.9242e-13},
                {"gene" : "PER1", "log2(fold_change)" : -3.20034, "q_value" : 3.64345e-12}]])
        .call(volcanoPlot);*/
</script>