<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Start.aspx.cs" Inherits="Sogeti_Ex_jobb.Start" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Supplier Collaboration Portal</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

    <!-- Scripts for the responsive table -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/123941/stacktable.js"></script>

    <!-- Bootstrap Core CSS -->
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <link href="Content/settings.css" rel="stylesheet" />
    <link href="Content/fixed-table-header.css" rel="stylesheet" />
    <link href="Content/responsive-table.css" rel="stylesheet" />

    

    
</head>
<body>
    
    <%--<div class="page-header" style="background-color:#0a8bb7;">--%>
    <div class="container-fluid" style="background-color:#0a8bb7;">
        <div class="row vertical-align">
            <div class="col-md-1 col-md-offset-3">
                <img src="Content/logotyp.jpg" class="img-responsive" alt="Atlas Copco" width="83" height="40" /> 
            </div>
            <div class="col-md-3">
                <span style="color: white;">
                    <strong>Leverantör \ Sogeti External</strong>
                    |           SCP
                    <span class="glyphicon glyphicon-lock">Logout</span>  
                </span> 
            </div>
            <div class="col-md-2" style="color: white">
                Language setting
            </div>
        </div>
    </div>
    <%--</div>--%>
     <div class="container-fluid">
	    <div class="row">
 
          <ul class="nav nav-tabs" id="tabs">
              <li class="active"><a data-toggle="tab" href="#home">Home</a></li>       
              <li><a data-toggle="tab" href="#RFQ">RFQ</a></li>
              <li><a data-toggle="tab" href="#designNotifications">Design Notification</a></li>
              <li><a data-toggle="tab" href="#supplierAudit">Supplier Audit</a></li>
              <li><a data-toggle="tab" href="#claims">Claims</a></li>
              <li><a data-toggle="tab" href="#supplierAnalysis">Supplier Analysis</a></li>	  

              <li id="lastTab" >
                <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                  More <span class="caret"></span>
                </a>
                <ul class="dropdown-menu pull-right" id="collapsed">
              
                </ul>
                  
              </li>
          </ul>
            
        <div class="tab-content " >
            <div id="home" class ="tab-pane fade in active">
                <h3>Home</h3>
            </div>
            <div id="RFQ" class ="tab-pane fade">

                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-2 col-md-offset-2">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Divison" />
                                <span class="input-group-btn">
                                    <button class="btn btn-secondary" type="button">
                                        Set
                                    </button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-3 ">
                            <input type="search" class="form-control" placeholder="Search" />
                        </div>
                        <div class="col-md-3">
                          <ul class="nav nav-pills">
                            <li class="active"><a data-toggle="pill" href="#all">All</a></li>
                            <li><a data-toggle="pill" href="#onlyMy">Only my</a></li>
                            <li><a class="btn btn-default" href="#"><span class="glyphicon glyphicon-search">Search</span></a></li>
                            <li><a class="btn btn-default" href="#"><span class="glyphicon glyphicon-remove">Clear</span></a></li>
                          </ul>
                        </div>
                    </div>
                </div>

                <div class="col-md-2 col-md-offset-2">          
                    <ul class="nav nav-pills nav-stacked" role="tablist" id="pillList">
                        <li class="active"><a data-toggle="pill"  href="#">New</a></li>
                        <li><a data-toggle="pill" href="#">Work in Progress</a></li>
                        <li><a data-toggle="pill" href="#">Waiting Evaluation</a></li>
                        <li><a data-toggle="pill" href="#">Waiting Confirmation</a></li>
                        <li><a data-toggle="pill" href="#">Close</a></li>
                        <li><a data-toggle="pill" href="#">Archived</a></li>                                      
                    </ul>
                </div>

                <div class="container">
                    <div class="row">
                        <div class="col-md-8">
                            <table class="table table-fixed">
                              <thead>
                                <tr>
                                    <th class="col-xs-2">Number</th>
                                    <th class="col-xs-2">Title</th>
                                    <th class="col-xs-2">DN Class</th>
                                    <th class="col-xs-2">Due Date</th>
                                    <th class="col-xs-2">Com. Manager</th>
                                    <th class="col-xs-2">Created</th>
                                </tr>
                              </thead>
                              <tbody>
                                <tr>
                                    <td class="col-xs-2">16-SoIn-4177</td>
                                    <td class="col-xs-2">test</td>
                                    <td class="col-xs-2">-</td>
                                    <td class="col-xs-2">2016-03-12</td>
                                    <td class="col-xs-2">Sogeti Internal</td>
                                    <td class="col-xs-2">2016-01-01</td>
                                </tr>
                                <tr>
                                    <td class="col-xs-2">2</td>
                                    <td class="col-xs-2">test2</td>
                                    <td class="col-xs-2">-</td>
                                    <td class="col-xs-2">2016-03-12</td>
                                    <td class="col-xs-2">Sogeti Internal</td>
                                    <td class="col-xs-2">2016-01-01</td>
                                </tr>
                                <tr>
                                    <td class="col-xs-2">3</td>
                                    <td class="col-xs-2">test3</td>
                                    <td class="col-xs-2">-</td>
                                    <td class="col-xs-2">2016-03-12</td>
                                    <td class="col-xs-2">Sogeti Internal</td>
                                    <td class="col-xs-2">2016-01-01</td>
                                </tr>
                                <tr>
                                    <td class="col-xs-2">4</td>
                                    <td class="col-xs-2">test4</td>
                                    <td class="col-xs-2">-</td>
                                    <td class="col-xs-2">2016-03-12</td>
                                    <td class="col-xs-2">Sogeti Internal</td>
                                    <td class="col-xs-2">2016-01-01</td>
                                </tr>
                                <tr>
                                    <td class="col-xs-2">4</td>
                                    <td class="col-xs-2">test4</td>
                                    <td class="col-xs-2">-</td>
                                    <td class="col-xs-2">2016-03-12</td>
                                    <td class="col-xs-2">Sogeti Internal</td>
                                    <td class="col-xs-2">2016-01-01</td>
                                </tr>
                                <tr>
                                    <td class="col-xs-2">4</td>
                                    <td class="col-xs-2">test4</td>
                                    <td class="col-xs-2">-</td>
                                    <td class="col-xs-2">2016-03-12</td>
                                    <td class="col-xs-2">Sogeti Internal</td>
                                    <td class="col-xs-2">2016-01-01</td>
                                </tr>
                                <tr>
                                    <td class="col-xs-2">4</td>
                                    <td class="col-xs-2">test4</td>
                                    <td class="col-xs-2">-</td>
                                    <td class="col-xs-2">2016-03-12</td>
                                    <td class="col-xs-2">Sogeti Internal</td>
                                    <td class="col-xs-2">2016-01-01</td>
                                </tr>
                                <tr>
                                    <td class="col-xs-2">4</td>
                                    <td class="col-xs-2">test4</td>
                                    <td class="col-xs-2">-</td>
                                    <td class="col-xs-2">2016-03-12</td>
                                    <td class="col-xs-2">Sogeti Internal</td>
                                    <td class="col-xs-2">2016-01-01</td>
                                </tr>
                                <tr>
                                    <td class="col-xs-2">4</td>
                                    <td class="col-xs-2">test4</td>
                                    <td class="col-xs-2">-</td>
                                    <td class="col-xs-2">2016-03-12</td>
                                    <td class="col-xs-2">Sogeti Internal</td>
                                    <td class="col-xs-2">2016-01-01</td>
                                </tr>
                              </tbody>
                            </table>
                        </div> 
                    </div>
                </div>
            </div>

                
 

            </div>

            <div id="designNotifications" class ="tab-pane fade">
                Design Notification
            </div>

            <div id="supplierAudit" class ="tab-pane fade">
                Supplier Audit
            </div>

            <div id="claims" class ="tab-pane fade">
                Claims
            </div>

            <div id="supplierAnalysis" class ="tab-pane fade">
               Supplier Analysis
            </div>
        </div> 
      
        </div>
    </div>
    

    <div id="footer" class="container">
        <nav class="navbar navbar-default navbar-fixed-bottom text-center text-success">
            <div class="navbar-inner navbar-content-center">
                <p class="text-muted credit col-md-12">Atlas Copco | Supplier Collaboration Portal</p>
            </div>
        </nav>
    </div>
    
    <script>
        var autocollapse = function () {

            var tabs = $('#tabs');
            var tabsHeight = tabs.innerHeight();      

            if (tabsHeight >= 50) {
                while (tabsHeight > 50) {
                    //console.log("new"+tabsHeight);
                    var children = tabs.children('li:not(:last-child)');
                    var count = children.size();         
                    $(children[count - 1]).prependTo('#collapsed');
                    tabsHeight = tabs.innerHeight();
                }
            }
            else {
                while (tabsHeight < 50 && (tabs.children('li').size() > 0)) {
                    var collapsed = $('#collapsed').children('li');
                    var count = collapsed.size();
                    if (count > 0)
                        $(collapsed[0]).insertBefore(tabs.children('li:last-child'));
                    else
                        break;
                    tabsHeight = tabs.innerHeight();
                }
                if (tabsHeight > 50) { // double check height again
                    autocollapse();
                }
            }

        };

        $(document).ready(function () {
            var small = false;
            var smallPills = false;
            autocollapse(); // when document first loads
            if ($(window).width() <= 799) {
                $('table').stacktable();
                small = true;
            }
            if ($(window).width() <= 976) {
                $('#pillList').removeClass('nav-stacked')
                smallPills = true;
            }

            //$(window).on('resize', autocollapse); // when window is resized

            $(window).on('resize', function (e) { // when window is resized
                console.log($(window).width());
                autocollapse();

                if ($(window).width() <= 799 && !small) {
                    $('table').stacktable();
                    $("table.stacktable.small-only").addClass("table-bordered");
                    $("table.stacktable.small-only").addClass("table-hover");
                    small = true;

                }
                else if ($(window).width() >= 800 && small) {
                    $("table.stacktable.small-only").remove()
                    small = false;

                }

                if ($(window).width() <= 976 && !smallPills) {
                    $('#pillList').removeClass('nav-stacked')
                    smallPills = true;
                }
                else if(($(window).width() >= 977 && smallPills))
                {
                    $('#pillList').addClass('nav-stacked')
                    smallPills = false;
                }

                 
                
            });

            $('a[data-toggle="tab"]').on('click', function (e) {
                $('#lastTab li').removeClass('active');
                $(this).addClass('active');
            });

            $(window).scroll(function () {
                if (($(window).scrollTop() + $(window).height() == $(document).height()) && small == true) {
                    $('#footer').hide();
                }
                else
                {
                    if (!$('#footer').is(":visible"))
                        $('#footer').show();
                }
            });

        });




    </script>

    
</body>
</html>
