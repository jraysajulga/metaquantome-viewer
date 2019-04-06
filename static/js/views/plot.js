define(["views/options"],
    function(OptionTable) {
    return Backbone.View.extend({

        className : "chart-container",

        initialize: function(config){
            this.id = this.model.cid;
            this.model = config.model;
            this.dataModel = config.dataModel;
            this.data = this.dataModel.get("data");
            this.headers = this.dataModel.get("headers");

            this.model.surmiseDefaultValues();

            // Adds options table and chart divs
            this.$el.html(new OptionTable({model : this.model,
                                           dataModel : config.dataModel}).el);
            this.$el.append($("<div>", {id : this.id + "-plotly"}));
            
            this.model.on("change:ready change:values change:type", this.render, this);
            this.dataModel.on("change:loadingSamplesFiles", this.render, this);
        },

        render : function(){
          var type = this.model.get("type");
          if (this.model.changed.type){
            this.model.surmiseDefaultValues();
          };
          if (type == "Bar Chart"){
            this.renderBarChart();
          } else if (type == "Heat Map"){
            console.log("HEAT MAP");
            //this.generateValuesFromSamplesFiles()
            this.renderHeatMap();
          }
        },

        renderBarChart : function(){
          var values = this.model.get("values");
          var label = this.data[values["Label"]];
          var group_1 = this.data[values["Group 1"]];
          var group_2 = this.data[values["Group 2"]];
          
          group_1 = group_1.map(function(e) {e = 2**e; return e; })
          group_2 = group_2.map(function(e) {e = 2**e; return e; })

          var NS_data = {
            x: label,
            y: group_1,
            name: 'NS',
            type: 'bar'
          };

          var WS_data = {
            x: label,
            y: group_2,
            name: 'WS',
            type: 'bar'
          };

          var data = [NS_data, WS_data];
          var layout = {barmode: 'group'};

          Plotly.newPlot(this.id + "-plotly", data, layout);
        },

        renderHeatMap : function(){
        }
    });
});
