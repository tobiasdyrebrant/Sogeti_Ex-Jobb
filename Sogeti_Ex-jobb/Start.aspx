<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Start.aspx.cs" Inherits="Sogeti_Ex_jobb.Start" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Supplier Collaboration Portal</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" href="Content/logotyp.jpg" />

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

    <!-- Scripts for the responsive table -->
    <%--<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>--%>
    <script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/123941/stacktable.js"></script>
    

    <!-- Bootstrap Core CSS -->
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <link href="Content/scrollTopStyle.css" rel="stylesheet" />
    <link href="Content/settings.css" rel="stylesheet" />
    <link href="Content/fixed-table-header.css" rel="stylesheet" />
    <link href="Content/responsive-table.css" rel="stylesheet" />

    <!-- Font-awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css" />
    
    


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


            if ($('#collapsed li').size() == 0 && $('#lastTab').is(":visible")) {
                $('#lastTab').hide();
                autocollapse();
            }
            else if ($('#collapsed li').size() != 0 && !$('#lastTab').is(":visible")) {
                $('#lastTab').show();
                autocollapse();
            }


        };

        var loadCorrectSide = function(hash)
        {
            var sides = hash.split("#");
            
            $("#tabs").find('a[href="#' + sides[1] + "\"]").trigger("click");
        }

        $(document).ready(function () {
            if (window.location.hash == "")
            {
                window.location.hash = "#home";
            }
            else {
                loadCorrectSide(window.location.hash);
            }
            

            var small = false;
            var smallPills = false;

            autocollapse(); // when document first loads
            $('tbody').css("height", $(window).height() - $('#footer').height() - $('#tabs').height() - $('#pageHeader').height() - $('#rfqTopRow').height() - $('th').height() - 50);

            if ($(window).width() <= 799) {
                $('.table-fixed').stacktable();
                small = true;
            }
            if ($(window).width() <= 976) {
                $('#pillListRfqHome').removeClass('nav-stacked');
                $('#pillListItemPage').removeClass('nav-stacked');
                $('#pillListDesignNotifications').removeClass('nav-stacked');
                $('#pillListDNItemPage').removeClass('nav-stacked');
                smallPills = true;
            }


            $(window).on('resize', function (e) { // when window is resized
                //console.log($(window).width());
                autocollapse();

                if ($(window).width() <= 799 && !small) {
                    $('.table-fixed').stacktable();
                            
                    small = true;

                }
                else if ($(window).width() >= 800 && small) {
                    $(".table-fixed.stacktable.small-only").remove();
                    small = false;

                }

                if ($(window).width() <= 976 && !smallPills) {
                    $('#pillListRfqHome').removeClass('nav-stacked');
                    $('#pillListItemPage').removeClass('nav-stacked');
                    $('#pillListDesignNotifications').removeClass('nav-stacked');
                    $('#pillListDNItemPage').removeClass('nav-stacked');
                    smallPills = true;
                }
                else if(($(window).width() >= 977 && smallPills)) {
                    $('#pillListRfqHome').addClass('nav-stacked');
                    $('#pillListItemPage').addClass('nav-stacked');
                    $('#pillListDesignNotifications').addClass('nav-stacked');
                    $('#pillListDNItemPage').addClass('nav-stacked');
                    
                    smallPills = false;
                }

                if($(window).width() >= 800)
                {
                    $('tbody').css("height", $(window).height() - $('#footer').height() - $('#tabs').height() - $('#pageHeader').height() - $('#rfqTopRow').height() - $('th').height() - 50)
                    //$('table').height($(window).height() - $('#footer').height() - $('#tabs').height() - $('#pageHeader').height() - $('#rfqTopRow').height());
                }

                 
                
            });

            $(window).scroll(function () {
                if (($(window).scrollTop() + $(window).height() == $(document).height()))
                    $('#footer').hide();

                else
                {
                    if (!$('#footer').is(":visible"))
                        $('#footer').show();
                }

                if ($(this).scrollTop() >= 150) {
                    $('.scrollToTop').fadeIn();
                } else {
                    $('.scrollToTop').fadeOut();
                }
            });

            $('[data-toggle="popover"]').popover();

            $('a[data-toggle="tab"]').on('click', function (e) {
                $('#lastTab li').removeClass('active');
                $(this).addClass('active');
                if ($(this).attr('id') == "rfqToggle")
                {
                    $('#rfqHome').show();
                    $('#itemPage').hide();

                    $('#pillListRfqHome li.active').removeClass("active");
                    $("#pillListRfqHome li").first().addClass("active");
                }

                if($(this).attr('id') == "designNotificationsToggle")
                {
                    $('#designNotificationsHome').show();
                    $('#designNotificationsItem').hide();

                    $('#pillListDesignNotifications li.active').removeClass("active");
                    $("#pillListDesignNotifications li").first().addClass("active");
                }
            });


            $(function () {
                var hash = window.location.hash;
                hash && $('ul.nav a[href="' + hash + '"]').tab('show');
                
                $('.nav-tabs a').click(function (e) {
                    $(this).tab('show');
                    var scrollmem = $('body').scrollTop() || $('html').scrollTop();
                    window.location.hash = this.hash;
                    $('html,body').scrollTop(scrollmem);
                });

                $('.nav-pills a').click(function (e) {
                    $(this).tab('show');
                    var scrollmem = $('body').scrollTop() || $('html').scrollTop();
                    window.location.hash = this.hash;
                    $('html,body').scrollTop(scrollmem);
                });
            });

            $(function () {
                var hash = window.location.hash;
                hash && $('ul.nav a[href="' + hash + '"]').tab('show');

                $('.table-fixed a').click(function (e) {
                    $(this).tab('show');
                    var scrollmem = $('body').scrollTop() || $('html').scrollTop();
                    window.location.hash += this.hash;
                    $('html,body').scrollTop(scrollmem);
                });
            });


            $(document).keypress(function (e) {              
                if (e.which == 98) {
                    window.history.back();
                    setTimeout(
                      function () {
                          window.location.reload();
                      },
                    1);
                }
            });


            $('[data-toggle="popover"]').on('click', function (e) {
                $("#rfqHome").hide();
                $('#itemPage').show();

                setTimeout(function () {
                    $('textarea').each(function () {
                        this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
                    }).on('input', function () {
                        this.style.height = 'auto';
                        this.style.height = (this.scrollHeight) + 'px';
                    });
                }, 300);
            });

            $('#rfqItem').click(function() {
                $("#rfqHome").hide();
                $('#itemPage').show();
            });

            $('.scrollToTop').click(function () {
                $('html, body').animate({ scrollTop: 0 }, 800);
                return false;
            });

            $('#backButton').click(function() {
                window.history.back();
                setTimeout(
                    function() {
                        window.location.reload();
                    },
                    1);
            });

            $(".dropdown-menu li a.selectable").click(function () {
                $(this).parents(".dropdown").find('.btn').html($(this).text() + ' <span class="caret"></span>');
                $(this).parents(".dropdown").find('.btn').val($(this).data('value'));
            });

            $('.dropdown.keep-open').on({
                "shown.bs.dropdown": function () { this.closable = false; },
                "click": function () { this.closable = true; },
                "hide.bs.dropdown": function () { return this.closable; }
            });

            $('.selectableRow').click(function () {
                if ($(this).closest('tbody').attr('id') == "itemListBody") {
                    $('#itemList').slideUp();
                    $('#itemInfo').slideDown();
                }
                else if ($(this).closest('tbody').attr('id') == "partListBody") {
                    $('#partList').slideUp();
                    $('#partInfo').slideDown();

                    setTimeout(function () {
                        $('textarea').each(function () {
                            this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
                        }).on('input', function () {
                            this.style.height = 'auto';
                            this.style.height = (this.scrollHeight) + 'px';
                        });
                    }, 300);
                }
                
            });

            $('#toggleItemList').click(function() {
                $('#itemList').slideDown();
                $('#itemInfo').slideUp();
            }); 
            
            $('#togglePartsList').click(function () {
                $('#partList').slideDown();
                $('#partInfo').slideUp();
            }); 

            $('[data-toggle="pill"]').on('click', function (e) {
                if (($(this).attr('id') == "commentsPill") || ($(this).attr('id') == "itemPill") || ($(this).attr('id') == "DNoverviewPill") || ($(this).attr('id') == "overviewPill") || ($(this).attr('id') == "DNdetailsPill") || ($(this).attr('id') == "DNcommentsPill")) {
                    setTimeout(function() {
                        $('textarea').each(function() {
                            this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
                        }).on('input', function() {
                            this.style.height = 'auto';
                            this.style.height = (this.scrollHeight) + 'px';
                        });
                    }, 300);
                }
                
            });

            $('#DNTable').on('click', function() {
                $('#designNotificationsHome').hide();
                $('#designNotificationsItem').show();

                setTimeout(function () {
                    $('textarea').each(function () {
                        this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
                    }).on('input', function () {
                        this.style.height = 'auto';
                        this.style.height = (this.scrollHeight) + 'px';
                    });
                }, 300);
            });


        });

    </script>
</head>

<body>
    

    <div class="container-fluid" style="background-color:#0a8bb7;" id="pageHeader">
        <div class="row vertical-align">
            <div class="col-md-1">
                <img src="Content/logotyp.jpg" class="" alt="Atlas Copco" width="83" height="40" /> 
            </div>
            <div class="col-md-4">
                <span style="color: white;">
                    <strong>Leverantör \ Sogeti External</strong>
                    |           SCP
                </span> 
            </div>

            <div class="col-md-offset-3 col-md-1"> 
                <div class="dropdown ">
                    <button class="dropbtn"><span class="fa fa-bell-o"><span class="label label-pill label-danger">6</span></span></button>
                    <div class="dropdown-content dropdown-menu-right">
                        <a href="#"><span class="glyphicon glyphicon-grain"><span class="label label-pill label-danger">2</span></span> RFQ</a>
                        <a href="#"><span class="fa fa-wrench"><span class="label label-pill label-danger">2</span></span> Design Notification</a>
                        <a href="#"><span class="fa fa-coffee"><span class="label label-pill label-danger">2</span></span> Claims</a>
                        <a href="#"><span class="fa fa-hourglass-half"><span class="label label-pill label-danger">2</span></span> Design Notification</a>
                        <a href="#"><span class="fa fa-close"><span class="label label-pill label-danger">2</span></span> RFQ</a>
                        <a href="#"><span class="fa fa-archive"><span class="label label-pill label-danger">2</span></span> Claims</a>
                    </div>
                </div> 
            </div>

            <div class="col-md-1">
                <div class="dropdown">
                    <button class="dropbtn"><span class="fa fa-comment"><span class="label label-pill label-danger">5</span></span></button>
                    <div class="dropdown-content dropdown-menu-right">
                        <a href="#"><p><span class="glyphicon glyphicon-grain"> RFQ</span></p>Item number</a>
                        <a href="#"><p><span class="fa fa-wrench"> Design Notification</span></p>Item number</a>
                        <a href="#"><p><span class="fa fa-coffee"> Design Notification</span></p>Item number</a>
                        <a href="#"><p><span class="fa fa-hourglass-half"> Claims</span></p>Item number</a>
                        <a href="#"><p><span class="fa fa-hourglass-half"> Claims</span></p>Item number</a>
                    </div>
                </div>
            </div>

            <div class="col-md-1">
                <div class="col-md-12 lock">
                        <span class="fa fa-lock"></span>
                </div>
            </div>

            <div class="col-md-1" style="color: white;">         
                <div class="dropdown">
                    <button class="dropbtn"><span class="fa fa-language"></span></button>
                    <div class="dropdown-content dropdown-menu-right">
                        <a href="#">English</a>
                        <a href="#">Chinese</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">
	    <div class="row">
            <ul class="nav nav-tabs" id="tabs">
                <li><a data-toggle="tab" href="#home">Home</a></li>       
                <li><a data-toggle="tab" href="#RFQ" id="rfqToggle">RFQ</a></li>
                <li><a data-toggle="tab" href="#designNotifications" id="designNotificationsToggle">Design Notification</a></li>
                <li><a data-toggle="tab" href="#claims">Claims</a></li>
                <li><a data-toggle="tab" href="#supplierAnalysis">Supplier Analysis</a></li>	  
                <li><a data-toggle="tab" href="#search">Search</a></li>	

                <li id="lastTab" >
                    <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                        More <span class="caret"></span>
                    </a>
                <ul class="dropdown-menu pull-right" id="collapsed">
                </ul>
                </li>
            </ul>
            
            <div class="tab-content">
                <div id="home" class ="tab-pane fade">
                    Home
                </div>

                <div id="RFQ" class ="tab-pane fade">

                    <div id="rfqHome">
                        <div class="col-md-2">          
                            <ul class="nav nav-pills nav-stacked" role="tablist" id="pillListRfqHome">
                                <li class="active"><a data-toggle="pill" href="#RFQ#new">New<span class="glyphicon glyphicon-grain pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#RFQ#workInProgress">Work in Progress<span class="fa fa-wrench pull-right"></span><span class="label label-pill label-danger" style="border-radius: 1em;">2</span></a></li>
                                <li><a data-toggle="pill" href="#RFQ#waitingEvaluation">Waiting Evaluation<span class="fa fa-coffee pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#RFQ#waitingConfirmation">Waiting Confirmation<span class="fa fa-hourglass-half pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#RFQ#closed">Closed<span class="fa fa-close pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#RFQ#archived">Archived<span class="fa fa-archive pull-right"></span></a></li>      
                                <li class="dropup"> <a href="#RFQ#search" class="dropdown-toggle" data-toggle="dropdown">Search Settings <span class="caret pull-right"></span></a>
                                    <ul class="dropdown-menu" role="menu">
                                        <li>
                                            <div class="input-group">
                                                <input type="text" class="form-control" placeholder="Divison" />
                                                <span class="input-group-btn">
                                                    <button class="btn btn-secondary" type="button">
                                                        Set
                                                    </button>
                                                </span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="search" class="form-control" placeholder="Search" />
                                        </li>
                                        <li>
                                            <a class="btn btn-default" href="#"><span class="glyphicon glyphicon-remove">Clear</span></a>
                                        </li>
                                    </ul>
                                </li>                                 
                            </ul>
                        </div>

                        <div class="container col-md-10">
                            <div class="row">
                                <div class="">
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
                                            <td class="col-xs-2"><a href="#16-SoIn-4177" id="rfqItem" title="Header" data-toggle="popover" data-trigger="hover" data-content="Some content">16-SoIn-4177</a></td>
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

                    <div id="itemPage" style="display: none;">
                        <div class="col-md-2">     
                            <h4>16-SoIn-4177</h4>
                            <ul class="nav nav-pills nav-stacked" role="tablist" id="pillListItemPage">
                                <li class="active"><a data-toggle="pill" href="#overview" id="overviewPill">Overview<span class="fa fa-eye pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#items" id="itemPill">Items<span class="fa fa-tasks pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#attachments">Attachments<span class="fa fa-paperclip pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#logs">Logs<span class="fa fa-book pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#comments" id="commentsPill">Comments<span class="fa fa-comments pull-right"></span><span class="label label-pill label-danger" style="border-radius: 1em;">2</span></a></li>                                               
                            </ul>
                        </div>  

                        <div class="tab-content col-md-10" >
                            <div id="overview" class="tab-pane fade in active">
                                <div class="row vertical-align-baseline">
                                    <div style="float:left;">
                                        <h3>Overview</h3>        
                                    </div>
                                    <div style="float:left; padding-left: 2em; font-size: 6px;">
                                        <h5 class="custom" style="background-color: orange">RFQ is waiting for supplier's answer <span title="Info" data-toggle="popover" data-trigger="hover" data-content="This specific RFQ (16-SoIn-4177) is waiting for YOUR actions, YOU need to REPLY to the RFQ which have been sent to you." class="info fa fa-info-circle"></span></h5>      
                                    </div>
                                </div>       
                                                       
                                <form>
                                    <div class="row formBackground">
                                        <div class="form-group col-xs-2 col-md-2">
                                            <label for="rfqNumber">RFQ-Number</label>
                                            <input type="text" class="form-control" id="rfqNumber" placeholder="16-SoIn-4177" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-2 col-md-2">
                                            <label for="dnNumber">DN-Number</label>
                                            <input type="text" class="form-control" id="dnNumber" placeholder="-" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-3 col-md-3">
                                            <label for="title">Title</label>
                                            <input type="text" class="form-control" id="title" placeholder="test" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-3 col-md-3">
                                            <label for="project">Project</label>
                                            <input type="text" class="form-control" id="project" placeholder="---" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-2 col-md-2">
                                            <label for="createdDate">Created Date</label>
                                            <input type="text" class="form-control" id="createdDate" placeholder="2016-01-01" readonly="readonly" />
                                        </div>
                                    </div>

                                    <div class="row formBackground">
                                        <div class="form-group col-xs-3 col-md-3">
                                            <label for="createdBy">Created By</label>
                                            <input type="text" class="form-control" id="createdBy" placeholder="Sogeti Internal" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-3 col-md-3">
                                            <label for="replyDate">Reply Date</label>
                                            <input type="text" class="form-control" id="replyDate" placeholder="2016-03-15" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-3 col-md-3">
                                            <div class="input-group">
                                                <label for="validity">Validity</label>
                                                <input type="text" class="form-control" id="validity" placeholder="2016-03-15" />
                                                <span class="input-group-btn">
                                                    <button class="btn btn-secondary" type="button" style="margin-top: 25px">
                                                        Set
                                                    </button>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="form-group col-xs-3 col-md-3">
                                            <label for="contactPerson">Contact Person</label>
                                            <input type="text" class="form-control" id="contactPerson" placeholder="Sogeti External" readonly="readonly" />
                                        </div>
                                    </div>

                                    <div class="row formBackground">
                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="owner">Owner</label>
                                            <input type="text" class="form-control" id="owner" placeholder="Internal, Sogeti" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="email">E-mail</label>
                                            <input type="text" class="form-control" id="email" placeholder="example@sogeti.se" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="phoneNumber">Phone Number</label>
                                            <input type="text" class="form-control" id="phoneNumber" placeholder="07X-XXXXXXX" readonly="readonly" />
                                        </div>
                                    </div>

                                    <div class="row formBackground">
                                        <div class="form-group col-md-6">
                                            <label for="supplierStakeholders">Supplier Stakeholders</label><br />
                                            <div class="btn-group">
                                                <div class="dropdown" id="supplierStakeholders" style="float:left;">
                                                  <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="width: 300px">
                                                    Select Stakeholder
                                                    <span class="caret pull-right"></span>
                                                  </button>

                                                  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style="width: 300px; text-align:center;">
                                                    <li><a class="selectable">Name Namesson</a></li>
                                                    <li><a class="selectable">Example Exampleton</a></li>
                                                    <li><a class="selectable">Sample Samplebury</a></li>
                                                  </ul>
                                                </div>
                                                <button class="btn btn-secondary" type="button" style="float:left">
                                                    Add
                                                </button>
                                            </div>
                                        </div>

                                        <div class="form-group col-md-6">    
                                            <div class="dropdown keep-open" id="currentStakeholders" style="margin-top: 25px;">
                                                <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="width: 300px;">
                                                Click to view current stakeholders
                                                <span class="label label-pill label-danger" style="border-radius: 1em;">2</span>
                                                </button>

                                                <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style="width: 300px; text-align:center;">
                                                    <li><a>Name Nameford</a></li>
                                                    <li><a>Example Exampleham</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-md-12">
                                            <label for="overviewComment">Comment: </label>
                                            <textarea class="form-control" rows="3" id="overviewComment" readonly="readonly"></textarea>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-md-10">
                                            <button class="btn btn-default" type="button">
                                                Close
                                            </button>
                                            <button class="btn btn-success" type="button">
                                                Save
                                            </button>
                                            <button class="btn btn-danger" type="button">
                                                Reject RFQ
                                            </button>
                                            <button class="btn btn-primary" type="button">
                                                Send
                                            </button>
                                        </div>
                                    </div>
                                </form>

                            </div>

                            <div id="items" class="tab-pane fade">
                                <div class="row vertical-align-baseline">
                                    <div style="float:left;">
                                        <h3>Items</h3>        
                                    </div>
                                    <div style="float:left; padding-left: 2em; font-size: 6px;">
                                        <h5 class="custom" style="background-color: orange">RFQ is waiting for supplier's answer <span title="Info" data-toggle="popover" data-trigger="hover" data-content="This specific RFQ (16-SoIn-4177) is waiting for YOUR actions, YOU need to REPLY to the RFQ which have been sent to you." class="info fa fa-info-circle"></span></h5>    
                                    </div>
                                </div>
                              
                                <div class="container col-md-12" id="itemInfo" style="display: none;">
                                    <div class="row vertical-align-baseline">                                   
                                        <div class="itemInfo" style="float:left;">
                                            <h3>Wheel</h3>        
                                        </div>
                                        <button type="button" class="btn btn-danger" style="margin-left:50px" >Reject Item</button>
                                        <button type="button" class="btn btn-primary" id="toggleItemList" style=" margin-left:50px" >Show list again</button>                                        
                                    </div>
                                    
                                    <form>
                                        <div class="row">
                                            <div class="form-group col-md-6" style="margin-top: 10px;">
                                                <label for="acItemNo">AC-Item No</label>
                                                <input type="text" class="form-control" id="acItemNo" placeholder="1" readonly="readonly" />
                                            </div>
                                            <div class="form-group col-md-6" style="margin-top: 10px;">
                                                <label for="annualVolume">Annual volume</label>
                                                <input type="text" class="form-control" id="annualVolume" placeholder="1" readonly="readonly" />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="form-group col-md-6">
                                                <label for="description">Description</label>
                                                <textarea class="form-control" rows="3" id="description" readonly="readonly"></textarea>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label for="itemComment">Comment</label>
                                                <textarea class="form-control" rows="3" id="itemComment" readonly="readonly"></textarea>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top: 10px;">
                                            <div class="col-md-offset-2 col-md-8 col-md-offset-2" style="border-bottom:groove;">
                                                <b style="float:left; margin-top: 10px;">Currency</b>
                                                <div class="dropdown" id="currency" style="float:right; margin-bottom: 5px;">
                                                  <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"> 
                                                    Please select a currency
                                                    <span class="caret pull-right"></span>
                                                  </button>

                                                  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                                    <li><a class="selectable">SEK</a></li>
                                                    <li><a class="selectable">CAD</a></li>
                                                    <li><a class="selectable">CNY</a></li>
                                                  </ul>
                                                </div>
                                            </div>
                                         </div>

                                        <div class="row" style="margin-top: 10px;">    
                                            <div class="form-inline col-md-offset-2 col-md-8 col-md-offset-2" style="border-bottom: groove; ">
                                                <label style=" margin-top: 10px;">Serial price</label>                                 
                                                <button type="button" class="btn btn-primary" style="float:right; margin-bottom: 5px;">Set Price Breaks</button>  
                                                <input type="text" class="form-control " id="serialPriceInput" placeholder="1.00" style="float:right; margin-bottom: 5px;"/>  
                                                <b style="float:right; margin-top: 10px;">Qty 1</b>       
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="margin-top: 10px;">
                                            <div class="form-inline col-md-offset-2 col-md-8 col-md-offset-2" style="border-bottom: groove; ">
                                                <b style="float: left; margin-top: 10px;" >Min Order Quantity</b>
                                                <input type="text" class="form-control" id="minOrderQuantity" placeholder="2" style="float: right; margin-bottom: 5px;" />
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="margin-top: 10px;">
                                            <div class="col-md-offset-2 col-md-8 col-md-offset-2" style="border-bottom: groove; ">
                                                <b style="float:left; margin-top: 10px;" >Country of Origin</b>
                                                <div class="dropdown" id="countryOfOrigin" style="float:right; margin-bottom: 5px;">
                                                    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" >
                                                    Please select a country
                                                    <span class="caret pull-right"></span>
                                                    </button>

                                                    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" >
                                                    <li><a class="selectable">DENMARK</a></li>
                                                    <li><a class="selectable">NORWAY</a></li>
                                                    <li><a class="selectable">SWEDEN</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                          </div>
                                                                                
                                        <div class="row" style="margin-top: 10px;">
                                            <div class="col-md-offset-2 col-md-8 col-md-offset-2" style="border-bottom: groove;">
                                                <b style="float:left; margin-top: 10px;" >Unit</b>
                                                <div class="dropdown" id="unit" style="float:right; margin-bottom: 5px;">
                                                    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                    Please select an option
                                                    <span class="caret pull-right"></span>
                                                    </button>

                                                    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" >
                                                        <li><a class="selectable">PCE</a></li>
                                                        <li><a class="selectable">FOOT</a></li>
                                                        <li><a class="selectable">GALLON</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                            
                                        <div class="row" style="margin-top: 10px;">
                                            <div class="form-inline col-md-offset-2 col-md-8 col-md-offset-2" style="border-bottom: groove; ">
                                                <b style="float: left; margin-top: 10px;" >Weight (kg)</b>
                                                <input type="text" class="form-control" id="weight" placeholder="2" style="float: right; margin-bottom: 5px;" />
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="margin-top: 10px;">
                                            <div class="form-inline col-md-offset-2 col-md-8 col-md-offset-2" style="border-bottom: groove; ">
                                                <b style="float: left; margin-top: 10px;" >Lead Time First Delivery (Business days)</b>
                                                <input type="text" class="form-control" id="leadTimeFirstDelivery" placeholder="2" style="float: right; margin-bottom: 5px;" />
                                            </div>
                                        </div>  

                                        <div class="row" style="margin-top: 10px;">
                                            <div class="form-inline col-md-offset-2 col-md-8 col-md-offset-2" style="border-bottom: groove; ">
                                                <b style="float: left; margin-top: 10px;" >Lead Time Production (Business days)</b>
                                                <input type="text" class="form-control" id="leadTimeProduction" placeholder="2" style="float: right; margin-bottom: 5px;" />
                                            </div>
                                        </div>  
                                        
                                        <div class="row" style="margin-top: 10px;">
                                            <div class="col-md-offset-2 col-md-8 col-md-offset-2" style="border-bottom: groove;">
                                                <b style="float:left; margin-top: 10px;" >Review of technical specification (RTS)</b>
                                                <div class="dropdown" id="RTS" style="float:right; margin-bottom: 5px;">
                                                    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                    Please select an option
                                                    <span class="caret pull-right"></span>
                                                    </button>

                                                    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" >
                                                        <li><a class="selectable">1. OK</a></li>
                                                        <li><a class="selectable">2. Not possible to manufacture(RTS needed)</a></li>
                                                        <li><a class="selectable">3. Quality Improvement(RTS needed)</a></li>
                                                        <li><a class="selectable">3. Cost reduction(RTS needed)</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="margin-top: 10px;">    
                                            <div class="form-inline col-md-offset-2 col-md-8 col-md-offset-2" style="border-bottom: groove; ">
                                                <div>
                                                    <b style=" margin-top: 10px;">RTS document</b>  
                                                    <small style="color: grey;">RTS document can be downloaded from Attachment \ General</small>
                                                </div>    
                                                <button type="button" class="btn btn-danger" style="float:right; margin-bottom: 5px;">Delete</button>                              
                                                <button type="button" class="btn btn-primary" style="float:right; margin-bottom: 5px;">Download RTS-document</button>                                                
                                            </div>
                                        </div>
                                                                              
                                        <div class="row" style="margin-top: 10px;">
                                            <div class="form-inline col-md-offset-2 col-md-8 col-md-offset-2">
                                                <button type="button" class="btn btn-primary" style="float:left; margin-bottom: 5px; ">Send</button>  
                                                <button type="button" class="btn btn-success" style="float:left; margin-bottom: 5px; margin-left: 5px;">Save</button>  
                                                <button type="button" class="btn btn-secondary" style="float:left; margin-bottom: 5px; margin-left: 5px;">Close</button>  
                                            </div>
                                        </div>  

                                    </form>

                                </div>
                                            
                                <div id="itemList">                                          
                                    <div class="container col-md-10" >
                                        <div class="row">
                                            <div class="">
                                                <table class="table" style="outline: solid; outline-color: #0a8bb7;">
                                                    <thead>
                                                        <tr style="background-color: #0a8bb7; color: white;">
                                                            <th class="col-xs-2">Name</th>
                                                            <th class="col-xs-2">Atlas Item No</th>
                                                            <th class="col-xs-2">Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="itemListBody">
                                                        <tr class="selectableRow" style="background-color:#4CAF50; color: white;">
                                                            <td class="col-xs-2">Wheel</td>
                                                            <td class="col-xs-2">1</td>
                                                            <td class="col-xs-2"><i class="fa fa-check" aria-hidden="true"></i></td>
                                                        </tr>
                                                        <tr class="selectableRow" style="background-color:indianred; color: white;">
                                                            <td class="col-xs-2">Drill</td>
                                                            <td class="col-xs-2">2</td>
                                                            <td class="col-xs-2"><i class="fa fa-thumbs-o-down" aria-hidden="true"></i></td>
                                                        </tr>
                                                        <tr class="selectableRow" style="background-color:#4CAF50; color: white;">
                                                            <td class="col-xs-2">Crane</td>
                                                            <td class="col-xs-2">3</td>
                                                            <td class="col-xs-2"><i class="fa fa-check" aria-hidden="true"></i></td>
                                                        </tr>
                                                    </tbody>
                                                </table> 
                                            </div>
                                        </div>
                                    </div>

                                    <div class="container col-md-10" style="color:white; background-color: #4CAF50; opacity: 0.7; filter: alpha(opacity=40)">
                                        All items are answered and ready to be sent
                                    </div>
                                </div>
                            </div>    
                           
                            <div id="attachments" class="tab-pane fade">
                                <div class="row vertical-align-baseline">
                                    <div style="float:left;">
                                        <h3>Attachments</h3>        
                                    </div>
                                    <div style="float:left; padding-left: 2em; font-size: 6px;">
                                        <h5 class="custom" style="background-color: orange">RFQ is waiting for supplier's answer <span title="Info" data-toggle="popover" data-trigger="hover" data-content="This specific RFQ (16-SoIn-4177) is waiting for YOUR actions, YOU need to REPLY to the RFQ which have been sent to you." class="info fa fa-info-circle"></span></h5>     
                                    </div>
                                </div>
                                                              
                                <div class="row" style="border-bottom: groove; "> 
                                    <div class="form-inline col-md-11">
                                        <ul class="nav nav-pills" role="tablist">
                                            <li class="active"><a data-toggle="pill" href="#general" ><span class="label label-pill label-danger" style="border-radius: 1em;">1</span><i style="color:black;"> General</i><span class="fa fa-paperclip pull-right" style="color:black;"></span></a></li>
                                            <li><a data-toggle="pill" href="#oneone"><span class="label label-pill label-danger" style="border-radius: 1em;">2</span><i style="color:black;"> 1 1</i><span class="fa fa-paperclip pull-right" style="color:black;"></span></a></li>
                                            <li><a data-toggle="pill" href="#twotwo"><span class="label label-pill label-danger" style="border-radius: 1em;">2</span><i style="color:black;"> 2 2</i><span class="fa fa-paperclip pull-right" style="color:black;"></span></a></li>
                                            <li><a data-toggle="pill" href="#threethree"><span class="label label-pill label-danger" style="border-radius: 1em;">1</span><i style="color:black;"> 3 3</i><span class="fa fa-paperclip pull-right" style="color:black;"></span></a></li>  
                                            <li style="float:right;"><button type="button" class="btn btn-primary" >Dowload All</button></li>                                       
                                        </ul>                                     
                                    </div>     
                                </div>  
                                
                                <div class="tab-content col-md-10" >
                                    <div id="general" class="tab-pane fade in active">                                    
                                        <button type="button" class="btn btn-primary" style="float:left;">Add files</button> 
                                        <button type="button" class="btn btn-primary" style="float:left; margin-left: 5px;">Download files all below</button> 
                                        <div class="row" style="margin-top: 5px;">
                                            <div class="form-inline col-md-11" style="margin-top: 10px; border-bottom: groove;">
                                                <a href="#" class="fa fa-file-o" aria-hidden="true" style="margin-top: 10px;">REVIEW OF TECHNICAL SPECIFICATION_8.xls (118kb)</a>
                                                <i>Atlas Copco</i>
                                                <button type="button" class="btn btn-danger" style="float:right;">Delete</button>    
                                            </div>  
                                        </div>
                                    </div>
                                    
                                    <div id="oneone" class="tab-pane fade">
                                        <button type="button" class="btn btn-primary" style="float:left;">Add files</button> 
                                        <button type="button" class="btn btn-primary" style="float:left; margin-left: 5px;">Download files all below</button>                                       
                                        <div class="row" style="margin-top: 5px;">
                                            <div class="form-inline col-md-11" style="margin-top: 10px; border-bottom: groove;">
                                                <a href="#" class="fa fa-file-o" aria-hidden="true" style="margin-top: 10px;">Octopus.rdp (61b)</a>
                                                <i>5452 * Svensk leverantör</i>
                                                <button type="button" class="btn btn-danger" style="float:right;">Delete</button>    
                                            </div>  
                                        </div>

                                        <div class="row" >
                                            <div class="form-inline col-md-11" style="margin-top: 10px; border-bottom: groove;">
                                                <a href="#" class="fa fa-file-o" aria-hidden="true" style="margin-top: 10px;">launch (3).ica (2kb)</a>
                                                <i>5452 * Svensk leverantör</i>
                                                <button type="button" class="btn btn-danger" style="float:right;">Delete</button>    
                                            </div>  
                                        </div>                                       
                                    </div>
                                    
                                    <div id="twotwo" class="tab-pane fade">
                                        <button type="button" class="btn btn-primary" style="float:left;">Add files</button> 
                                        <button type="button" class="btn btn-primary" style="float:left; margin-left: 5px;">Download files all below</button>                                       
                                        <div class="row" style="margin-top: 5px;">
                                            <div class="form-inline col-md-11" style="margin-top: 10px; border-bottom: groove;">
                                                <a href="#" class="fa fa-file-o" aria-hidden="true" style="margin-top: 10px;">Octopus.rdp (61b)</a>
                                                <i>5452 * Svensk leverantör</i>
                                                <button type="button" class="btn btn-danger" style="float:right;">Delete</button>    
                                            </div>  
                                        </div>

                                        <div class="row" style="margin-top: 5px;">
                                            <div class="form-inline col-md-11" style="margin-top: 10px; border-bottom: groove;">
                                                <a href="#" class="fa fa-file-o" aria-hidden="true" style="margin-top: 10px;">Octopus (1).rdp (61b)</a>
                                                <i>5452 * Svensk leverantör</i>
                                                <button type="button" class="btn btn-danger" style="float:right;">Delete</button>    
                                            </div>  
                                        </div>                                       
                                    </div>
                                    
                                    <div id="threethree" class="tab-pane fade">
                                        <button type="button" class="btn btn-primary" style="float:left;">Add files</button> 
                                        <button type="button" class="btn btn-primary" style="float:left; margin-left: 5px;">Download files all below</button>                                      
                                        <div class="row" style="margin-top: 5px;">
                                            <div class="form-inline col-md-11" style="margin-top: 10px; border-bottom: groove;">
                                                <a href="#" class="fa fa-file-o" aria-hidden="true" style="margin-top: 10px;">Octopus.rdp (61b)</a>
                                                <i>5452 * Svensk leverantör</i>
                                                <button type="button" class="btn btn-danger" style="float:right;">Delete</button>    
                                            </div>  
                                        </div>                                    
                                    </div>
                                    

                                </div>
                            </div>

                            <div id="logs" class="tab-pane fade">
                                <div class="row vertical-align-baseline">
                                    <div style="float:left;">
                                        <h3>Logs</h3>        
                                    </div>
                                    <div style="float:left; padding-left: 2em; font-size: 6px;">
                                        <h5 class="custom" style="background-color: orange">RFQ is waiting for supplier's answer <span title="Info" data-toggle="popover" data-trigger="hover" data-content="This specific RFQ (16-SoIn-4177) is waiting for YOUR actions, YOU need to REPLY to the RFQ which have been sent to you." class="info fa fa-info-circle"></span></h5>     
                                    </div>
                                </div>
                                
                                <div class="row" style="border-bottom: groove; "> 
                                    <div class="form-inline col-md-11">
                                        <ul class="nav nav-pills" role="tablist">
                                            <li class="active"><a data-toggle="pill" href="#rfqMainLog" style="color: black;">RFQ Main Log<span class="fa fa-book pull-right"></span></a></li>
                                            <li class="tabSeparator"><a style="color: black;">Item Log(s): </a></li>
                                            <li><a data-toggle="pill" href="#oneoneLog" style="color: black;">1 - 1<span class="fa fa-comment pull-right"></span></a></li>
                                            <li><a data-toggle="pill" href="#twotwoLog" style="color: black;">2 - 2<span class="fa fa-comment pull-right"></span></a></li>
                                            <li><a data-toggle="pill" href="#threethreeLog" style="color: black;">3 - 3<span class="fa fa-comment pull-right"></span></a></li>                            
                                        </ul>                                     
                                    </div>     
                                </div>  
                                
                                <div class="tab-content col-md-10" >
                                    <div id="rfqMainLog" class="tab-pane fade in active">
                                        <div class="container col-md-12" >
                                            <div class="row" style="margin-top: 10px;">
                                                <div class="">
                                                    <table class="table" style="outline: solid; outline-color: #0a8bb7;">
                                                        <thead>
                                                            <tr style="background-color: #0a8bb7; color: white;">
                                                                <th class="col-xs-2">Date</th>
                                                                <th class="col-xs-2">Action</th>
                                                                <th class="col-xs-2">User</th>
                                                                <th class="col-xs-6">Comment</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td class="col-xs-2">2016-02-29 08:03</td>
                                                                <td class="col-xs-2">RE-OPEN</td>
                                                                <td class="col-xs-2">System</td>
                                                                <td class="col-xs-6">Reopened for 5462 * Svensk leverantör</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">2016-02-26 08:50</td>
                                                                <td class="col-xs-2">INFO</td>
                                                                <td class="col-xs-2">Sogeti External</td>
                                                                <td class="col-xs-6">Recieved by Sogeti External</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">2016-02-26 08:48</td>
                                                                <td class="col-xs-2">SENT</td>
                                                                <td class="col-xs-2">Sogeti Internal</td>
                                                                <td class="col-xs-6">Sent to suppliers</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">2016-02-26 08:46</td>
                                                                <td class="col-xs-2">INFO</td>
                                                                <td class="col-xs-2">Sogeti Internal</td>
                                                                <td class="col-xs-6">RFQ created</td>
                                                            </tr>
                                                        </tbody>
                                                    </table> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="oneoneLog" class="tab-pane fade">
                                        <div class="container col-md-12" >
                                            <div class="row" style="margin-top: 10px;">
                                                <div class="">
                                                    <table class="table" style="outline: solid; outline-color: #0a8bb7;">
                                                        <thead>
                                                            <tr style="background-color: #0a8bb7; color: white;">
                                                                <th class="col-xs-2">Date</th>
                                                                <th class="col-xs-2">Action</th>
                                                                <th class="col-xs-2">User</th>
                                                                <th class="col-xs-6">Comment</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td class="col-xs-2">2016-03-24 13:20</td>
                                                                <td class="col-xs-2">UPLOAD</td>
                                                                <td class="col-xs-2">Sogeti External</td>
                                                                <td class="col-xs-6">launch (3).ica uploaded</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">2016-03-11 14:33</td>
                                                                <td class="col-xs-2">DELETE</td>
                                                                <td class="col-xs-2">Sogeti External</td>
                                                                <td class="col-xs-6">.DS_Store deleted</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">2016-03-11 14:21</td>
                                                                <td class="col-xs-2">UPLOAD</td>
                                                                <td class="col-xs-2">Sogeti External</td>
                                                                <td class="col-xs-6">.DS_Store uploaded</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">2016-03-11 14:19</td>
                                                                <td class="col-xs-2">DELETE</td>
                                                                <td class="col-xs-2">Sogeti External</td>
                                                                <td class="col-xs-6">.DS_Store deleted</td>
                                                            </tr>
                                                        </tbody>
                                                    </table> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div id="twotwoLog" class="tab-pane fade">
                                        <div class="container col-md-12" >
                                            <div class="row" style="margin-top: 10px;">
                                                <div class="">
                                                    <table class="table" style="outline: solid; outline-color: #0a8bb7;">
                                                        <thead>
                                                            <tr style="background-color: #0a8bb7; color: white;">
                                                                <th class="col-xs-2">Date</th>
                                                                <th class="col-xs-2">Action</th>
                                                                <th class="col-xs-2">User</th>
                                                                <th class="col-xs-6">Comment</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td class="col-xs-2">2016-03-07 16:22</td>
                                                                <td class="col-xs-2">UPLOAD</td>
                                                                <td class="col-xs-2">Sogeti External</td>
                                                                <td class="col-xs-6">Octopus (1).rdp uploaded</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">2016-03-07 13:36</td>
                                                                <td class="col-xs-2">UPLOAD</td>
                                                                <td class="col-xs-2">Sogeti External</td>
                                                                <td class="col-xs-6">Octopus (1).rdp uploaded</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">2016-02-29 08:04</td>
                                                                <td class="col-xs-2">REJECT</td>
                                                                <td class="col-xs-2">Sogeti External</td>
                                                                <td class="col-xs-6">Rejected by 5462 * Svensk leverantör</td>
                                                            </tr>
                                                        </tbody>
                                                    </table> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div id="threethreeLog" class="tab-pane fade">
                                        <div class="container col-md-12" >
                                            <div class="row" style="margin-top: 10px;">
                                                <div class="">
                                                    <table class="table" style="outline: solid; outline-color: #0a8bb7;">
                                                        <thead>
                                                            <tr style="background-color: #0a8bb7; color: white;">
                                                                <th class="col-xs-2">Date</th>
                                                                <th class="col-xs-2">Action</th>
                                                                <th class="col-xs-2">User</th>
                                                                <th class="col-xs-6">Comment</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td class="col-mdxs2">2016-03-07 16:22</td>
                                                                <td class="col-xs-2">UPLOAD</td>
                                                                <td class="col-xs-2">Sogeti External</td>
                                                                <td class="col-xs-6">Octopus (1).rdp uploaded</td>
                                                            </tr>
                                                        </tbody>
                                                    </table> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="comments" class="tab-pane fade">
                                <div class="row vertical-align-baseline">
                                    <div style="float:left;">
                                        <h3>Comments</h3>        
                                    </div>
                                    <div style="float:left; padding-left: 2em; font-size: 6px;">
                                        <h5 class="custom" style="background-color: orange">RFQ is waiting for supplier's answer <span title="Info" data-toggle="popover" data-trigger="hover" data-content="This specific RFQ (16-SoIn-4177) is waiting for YOUR actions, YOU need to REPLY to the RFQ which have been sent to you." class="info fa fa-info-circle"></span></h5>    
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <textarea class="form-control" rows="3" placeholder="Write a comment"></textarea>
                                        <button class="btn btn-primary" type="button" style="float: right; margin-top: 5px;">
                                            Send
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="row" >
                                    <div class="form-group col-md-8" style ="float: left;">
                                        <label for="comment1">2016-04-25 15:12, Sogeti External</label>
                                        <textarea class="form-control externalComment" id="comment1">Hej Såg ni att jag skickade tillbaka ärende 449 https://atlas-scp.axosoft.com/viewitem?id=449&type=defects&force_use_number=true Mailet som skickas ut vid ny artikel i DN är fortfarande det gamla och inte enligt mall. Best regards, FREDRIK AHNELL Commodity and Business Application Manager Atlas Copco Rock Drills AB Underground Rock Excevation Address: Klerkgatan 21 70191, Örebro - Sweden Phone: Mobile: Skype: +46 19 676 5924 +46 72 524 5623 se46725425623 VAT Reg No: SE556077901801 E-mail: fredrik.ahnell@se.atlascopco.com Visit us at: Follow us at: http://www.atlascopco.com Facebook / Twitter / LinkedIn / YouTube Committed to sustainable productivity</textarea>
                                    </div>
                                </div>
                                
                                <div class="row" >
                                    <div class="form-group col-md-8" style ="float: right;">
                                        <label for="comment2">2016-04-18 14:34, Sogeti Internal</label>
                                        <textarea class="form-control internalComment "  id="comment2" readonly="readonly">test</textarea>
                                    </div>
                                </div>
                                
                                <div class="row" >
                                    <div class="form-group col-md-8" style ="float: left;">
                                        <label for="comment3">2016-04-25 15:12, Sogeti External</label>
                                        <textarea class="form-control externalComment"id="comment3" readonly="readonly">Hej Såg ni att jag skickade tillbaka ärende 449 https://atlas-scp.axosoft.com/viewitem?id=449&type=defects&force_use_number=true Mailet som skickas ut vid ny artikel i DN är fortfarande det gamla och inte enligt mall. Best regards, FREDRIK AHNELL Commodity and Business Application Manager Atlas Copco Rock Drills AB Underground Rock Excevation Address: Klerkgatan 21 70191, Örebro - Sweden Phone: Mobile: Skype: +46 19 676 5924 +46 72 524 5623 se46725425623 VAT Reg No: SE556077901801 E-mail: fredrik.ahnell@se.atlascopco.com Visit us at: Follow us at: http://www.atlascopco.com Facebook / Twitter / LinkedIn / YouTube Committed to sustainable productivity</textarea>
                                    </div>
                                </div>
                                
                                <div class="row" >
                                    <div class="form-group col-md-8" style ="float: right;">
                                        <label for="comment4">2016-04-18 14:34, Sogeti Internal</label>
                                        <textarea class="form-control internalComment" id="comment4"readonly="readonly">asd
                                            asd
                                            asd
                                            asd
                                            asd
                                            asd
                                            asd
                                            asd
                                            asd
                                            asd
                                            asd
                                        </textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
 
                <div id="designNotifications" class ="tab-pane fade">
                
                    <div id="designNotificationsHome">                      
                        <div class="col-md-2">          
                            <ul class="nav nav-pills nav-stacked" role="tablist" id="pillListDesignNotifications">
                                <li class="active"><a data-toggle="pill" href="#DesignNotifications#Unread">Unread<span class="fa fa-envelope pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#DesignNotifications#WorkInProgress">Work in Progress<span class="fa fa-wrench pull-right"></span><span class="label label-pill label-danger" style="border-radius: 1em;">2</span></a></li>
                                <li><a data-toggle="pill" href="#DesignNotifications#Evaluation">Evaluation<span class="fa fa-coffee pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#DesignNotifications#Closed">Closed<span class="fa fa-close pull-right"></span></a></li>  
                                <li class="dropup"> <a href="#DesignNotifications#search" class="dropdown-toggle" data-toggle="dropdown">Search Settings <span class="caret pull-right"></span></a>
                                    <ul class="dropdown-menu" role="menu">
                                        <li>
                                            <div class="input-group">
                                                <input type="text" class="form-control" placeholder="Divison" />
                                                <span class="input-group-btn">
                                                    <button class="btn btn-secondary" type="button">
                                                        Set
                                                    </button>
                                                </span>
                                            </div>
                                        </li>
                                        <li>
                                            <input type="search" class="form-control" placeholder="Search" />
                                        </li>
                                        <li>
                                            <a class="btn btn-default" href="#"><span class="glyphicon glyphicon-remove">Clear</span></a>
                                        </li>
                                    </ul>
                                </li>                                                                
                            </ul>
                        </div>
                        
                        <div class="container col-md-10">
                            <div class="row">
                                <div class="">
                                    <table class="table table-fixed DNTable" id="DNTable">
                                      <thead>
                                        <tr>
                                            <th class="col-xs-3">DN-Number</th>
                                            <th class="col-xs-3">Created</th>
                                            <th class="col-xs-2">Class</th>
                                            <th class="col-xs-2">Response date</th>
                                            <th class="col-xs-2">Preperator</th>
                                        </tr>
                                      </thead>
                                      <tbody>
                                        <tr class="red">
                                            <td class="col-xs-3">mailtest1</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-3">123123123</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">2123112</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>
                                        <tr class="red">
                                            <td class="col-xs-3">test</td>
                                            <td class="col-xs-3">2016-04-08</td>
                                            <td class="col-xs-2">Class 1</td>
                                            <td class="col-xs-2">2016-04-15</td>
                                            <td class="col-xs-2">Sogeti Internal</td>
                                        </tr>

                                      </tbody>
                                    </table>
                                </div> 
                            </div>
                        </div>
                    </div>
                    
                    <div id="designNotificationsItem">
                        <div class="col-md-2">     
                            <h4>mailtest1</h4>
                            <ul class="nav nav-pills nav-stacked" role="tablist" id="pillListDNItemPage">
                                <li class="active"><a data-toggle="pill" href="#DNoverview" id="DNoverviewPill">Overview<span class="fa fa-eye pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#DNdetails" id="DNdetailsPill">Details<span class="fa fa-tasks pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#DNattachments">Attachments<span class="fa fa-paperclip pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#DNlogs">Logs<span class="fa fa-book pull-right"></span></a></li>
                                <li><a data-toggle="pill" href="#DNcomments" id="DNcommentsPill">Comments<span class="fa fa-comments pull-right"></span><span class="label label-pill label-danger" style="border-radius: 1em;">2</span></a></li>                                               
                            </ul>
                        </div>  
                        
                        <div class="tab-content col-md-10">
                        
                            <div id="DNoverview" class="tab-pane fade in active">
                                <div class="row vertical-align-baseline">
                                    <div style="float:left;">
                                        <h3>Overview</h3>        
                                    </div>
                                    <div style="float:left; padding-left: 2em; font-size: 6px;">
                                        <h5 class="custom" style="background-color: orange">Confirm that you have recieved the Design Notification by clicking the Recieve button<span title="Info" data-toggle="popover" data-trigger="hover" data-content="This specific Design Notification (mailtest1) is waiting for YOUR actions, YOU need to REPLY to the Design Notifications which have been sent to you. Do this by clicking on the recieve button at the bottom of this page" class="info fa fa-info-circle"></span></h5>      
                                    </div>
                                </div> 

                                <form>
                                    <div class="row formBackground">
                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="preperatorName">Preperator Name</label>
                                            <input type="text" class="form-control" id="preperatorName" placeholder="Sogeti Internal" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="DNemail">E-mail</label>
                                            <input type="text" class="form-control" id="DNemail" placeholder="example@sogeti.se" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="DNphoneNumber">Title</label>
                                            <input type="text" class="form-control" id="DNphoneNumber" placeholder="07X-XXXXXXX" readonly="readonly" />
                                        </div>
                                    </div>

                                    <div class="row formBackground">
                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="class">Class</label>
                                            <input type="text" class="form-control" id="class" placeholder="Class 1" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="type">Type</label>
                                            <input type="text" class="form-control" id="type" placeholder="Existing Article" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="timeToRespond">Time to respond</label>
                                            <input type="text" class="form-control" id="timeToRespond" placeholder="Sogeti External" readonly="readonly" />
                                        </div>
                                    </div>

                                    <div class="row formBackground">
                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="DNtitle">Title</label>
                                            <input type="text" class="form-control" id="DNtitle" placeholder="test" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="DNproject">Project</label>
                                            <input type="text" class="form-control" id="DNproject" placeholder="test" readonly="readonly" />
                                        </div>

                                        <div class="form-group col-xs-4 col-md-4">
                                            <label for="division">Division</label>
                                            <input type="text" class="form-control" id="division" placeholder="07X-XXXXXXX" readonly="readonly" />
                                        </div>
                                    </div>

                                    <div class="row formBackground">
                                        <div class="form-group col-md-6">
                                            <label for="DNoverviewComment">Cause: </label>
                                            <textarea class="form-control" rows="3" id="DNoverviewComment">test
                                                test
                                                test
                                                test
                                                test
                                                test                                                                         
                                            </textarea>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="DNcause">Comment: </label>
                                            <textarea class="form-control" rows="3" id="DNcause"></textarea>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-md-10">
                                            <button class="btn btn-default" type="button">
                                                Close
                                            </button>
                                            <button class="btn btn-warning" type="button">
                                                Recieve
                                            </button>
                                        </div>
                                    </div>
                                </form>   
                            </div>
                        
                            <div id="DNdetails" class="tab-pane fade">
                                <div class="row vertical-align-baseline">
                                    <div style="float:left;">
                                        <h3>Parts</h3>        
                                    </div>

                                    <div style="float:left; padding-left: 2em; font-size: 6px;">
                                        <h5 class="custom" style="background-color: orange">Confirm that you have recieved the Design Notification by clicking the Recieve button<span title="Info" data-toggle="popover" data-trigger="hover" data-content="This specific Design Notification (mailtest1) is waiting for YOUR actions, YOU need to REPLY to the Design Notifications which have been sent to you. Do this by clicking on the recieve button at the bottom of this page" class="info fa fa-info-circle"></span></h5>      
                                    </div>
                                </div> 
                            
                                <div id="partList">                                          
                                    <div class="container col-md-11" >
                                        <div class="row">
                                            <div class="">
                                                <table class="table" style="outline: solid; outline-color: #0a8bb7;">
                                                    <thead>
                                                        <tr style="background-color: #0a8bb7; color: white;">
                                                            <th class="col-xs-2">Name</th>
                                                            <th class="col-xs-2">Purchase Level</th>
                                                            <th class="col-xs-1">Supplier Part No</th>
                                                            <th class="col-xs-2">Replace Date</th>
                                                            <th class="col-xs-2">Description</th>
                                                            <th class="col-xs-2">Reply date</th>
                                                            <th class="col-xs-1">State</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="partListBody">
                                                        <tr class="selectableRow">
                                                            <td class="col-xs-2">test</td>
                                                            <td class="col-xs-2">321123321123</td>
                                                            <td class="col-xs-1">21</td>
                                                            <td class="col-xs-2">2016-07-12</td>
                                                            <td class="col-xs-2">test that are being tested</td>
                                                            <td class="col-xs-2">2016-07-01</td>
                                                            <td class="col-xs-1">Unread</td>
                                                        </tr>
                                                        <tr class="selectableRow">
                                                            <td class="col-xs-2">test</td>
                                                            <td class="col-xs-2">321123321123</td>
                                                            <td class="col-xs-1">21</td>
                                                            <td class="col-xs-2">2016-07-12</td>
                                                            <td class="col-xs-2">test that are being tested</td>
                                                            <td class="col-xs-2">2016-07-01</td>
                                                            <td class="col-xs-1">Unread</td>
                                                        </tr>
                                                    </tbody>
                                                </table> 
                                            </div>
                                        </div>                                                          
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-md-12" style="float: left;">
                                            <button class="btn btn-default" type="button">
                                                Close
                                            </button>
                                            <button class="btn btn-warning" type="button">
                                                Recieve
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            
                                <div id="partInfo" class="container col-md-12" style="display:none;">
                                    <div class="row vertical-align-baseline">                                   
                                        <div style="float:left; border-bottom:groove;">
                                            <h4>Part Data</h4>        
                                        </div>
                                        <button type="button" class="btn btn-primary" id="togglePartsList" style=" margin-left:50px">Show list again</button>                                        
                                    </div>
                                
                                    <form class="formBackground">
                                        <div class="row">
                                            <div class="form-group col-md-4" style="margin-top: 10px;">
                                                <label for="acPartNo">AC Part No</label>
                                                <input type="text" class="form-control" id="acPartNo" value="321123321123"/>
                                            </div>
                                            <div class="form-group col-md-4" style="margin-top: 10px;">
                                                <label for="name">Name</label>
                                                <input type="text" class="form-control" id="name" value="test" />
                                            </div>
                                            <div class="form-group col-md-4" style="margin-top: 10px;">
                                                <label for="supplierPartNumber">Supplier part number</label>
                                                <input type="text" class="form-control" id="supplierPartNumber" value="test"/>
                                            </div>
                                        </div>
                                    
                                        <div class="row ">
                                            <div class="form-group col-md-12">
                                                <label for="DNdescription">Description</label>
                                                <textarea class="form-control" rows="3" id="DNdescription"> test </textarea>
                                            </div>
                                        </div>
                                    </form>
                                                              
                                    <div class="row vertical-align-baseline">                                   
                                        <div style="float:left; border-bottom:groove;">
                                            <h4>Revision</h4>        
                                        </div>                                                                      
                                    </div>
                                
                                    <form class="formBackground">
                                        <div class="row">
                                            <div class="form-group col-md-4" style="margin-top: 10px;">
                                                <label for="replacementForRevision">Replacement for revision</label>
                                                <input type="text" class="form-control" id="replacementForRevision" value="1"/>
                                            </div>

                                            <div class="form-group col-md-4" style="margin-top: 10px;">
                                                <label for="introducedOnOrder">Introduced on order</label><br />
                                                <div class="btn-group">
                                                    <div class="dropdown" id="introducedOnOrder" style="float:left;">
                                                        <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="min-width: 300px;" >
                                                            Select option
                                                            <span class="caret pull-right"></span>
                                                        </button>

                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style=" text-align:center; min-width: 300px;">
                                                            <li><a class="selectable">Indwelling</a></li>
                                                            <li><a class="selectable">Next</a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
 
                                            <div class="form-group col-md-4" style="margin-top: 10px;">
                                                <label for="status">Status</label><br />
                                                <div class="btn-group">
                                                    <div class="dropdown" id="status" style="float:left;">
                                                        <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="min-width: 300px;" >
                                                            Select option
                                                            <span class="caret pull-right"></span>
                                                        </button>

                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style=" text-align:center; min-width: 300px;">
                                                            <li><a class="selectable">In Work</a></li>
                                                            <li><a class="selectable">Prototype</a></li>
                                                            <li><a class="selectable">Production</a></li>
                                                            <li><a class="selectable">Sparepart Only</a></li>
                                                            <li><a class="selectable">Obsolite</a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                
                                    <div class="row vertical-align-baseline">                                   
                                        <div style="float:left; border-bottom:groove;">
                                            <h4>Part Specific</h4>        
                                        </div>                                                                      
                                    </div>
                                
                                    <form class="formBackground">
                                        <div class="row">
                                            <div class="form-group col-md-3" style="margin-top: 10px;">
                                                <label for="weightPartInfo">Replacement for revision</label>
                                                <input type="text" class="form-control" id="weightPartInfo" value="1"/>
                                            </div>
                                        
                                            <div class="form-group col-md-2" style="margin-top: 10px;">
                                                <label for="unitPartInfo">Introduced on order</label><br />
                                                <div class="btn-group">
                                                    <div class="dropdown" id="unitPartInfo" style="float:left;">
                                                        <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                            Select option
                                                            <span class="caret pull-right"></span>
                                                        </button>

                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style=" text-align:center;">
                                                            <li><a class="selectable">PCE</a></li>
                                                            <li><a class="selectable">Foot</a></li>
                                                            <li><a class="selectable">Gallon</a></li>
                                                            <li><a class="selectable">Inch</a></li>
                                                            <li><a class="selectable">KG</a></li>
                                                            <li><a class="selectable">Pound</a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        
                                            <div class="form-group col-md-2" style="margin-top: 10px;">
                                                <label for="dangerousGoods">Dangerous goods</label><br />
                                                <div class="btn-group">
                                                    <div class="dropdown" id="dangerousGoods" style="float:left;">
                                                        <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                            Select option
                                                            <span class="caret pull-right"></span>
                                                        </button>

                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style=" text-align:center;">
                                                            <li><a class="selectable">Yes</a></li>
                                                            <li><a class="selectable">No</a></li>         
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        
                                            <div class="form-group col-md-2" style="margin-top: 10px;">
                                                <label for="safetyDetail">Dangerous goods</label><br />
                                                <div class="btn-group">
                                                    <div class="dropdown" id="safetyDetail" style="float:left;">
                                                        <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" >
                                                            Select option
                                                            <span class="caret pull-right"></span>
                                                        </button>

                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style=" text-align:center;">
                                                            <li><a class="selectable">Yes</a></li>
                                                            <li><a class="selectable">No</a></li>         
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        
                                            <div class="form-group col-md-3" style="margin-top: 10px;">
                                                <label for="purchaseLevel">Replacement for revision</label>
                                                <input type="text" class="form-control" id="purchaseLevel" value="1"/>
                                            </div>

                                        </div>
                                    </form>
                                
                                    <form class="formBackground">
                                        <div class="row">
                                            <div class="form-group col-md-3" style="margin-top: 10px;">
                                                <label for="contactPersonPartInfo">Contact Person</label><br />
                                                <div class="btn-group">
                                                    <div class="dropup" id="contactPersonPartInfo" style="float:left;">
                                                        <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="min-width: 300px;" >
                                                            Select option
                                                            <span class="caret pull-right"></span>
                                                        </button>

                                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style=" text-align:center; min-width: 300px;">
                                                            <li><a class="selectable">Name Namesson</a></li>
                                                            <li><a class="selectable">Sogeti External</a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>  
                                        </div>
                                    </form>
                                
                                    <div class="row">
                                        <div style="float: left; padding-bottom: 10px;">
                                            <button class="btn btn-default" type="button">
                                                Close
                                            </button>
                                            <button class="btn btn-warning" type="button">
                                                Recieve
                                            </button>
                                        </div>
                                    </div>
                                
                                </div>
                            </div>
                        
                            <div id="DNattachments" class="tab-pane fade">
                                <div class="row vertical-align-baseline">
                                    <div style="float:left;">
                                        <h3>Attachments</h3>        
                                    </div>
                                    <div style="float:left; padding-left: 2em; font-size: 6px;">
                                        <h5 class="custom" style="background-color: orange">Confirm that you have recieved the Design Notification by clicking the Recieve button<span title="Info" data-toggle="popover" data-trigger="hover" data-content="This specific Design Notification (mailtest1) is waiting for YOUR actions, YOU need to REPLY to the Design Notifications which have been sent to you. Do this by clicking on the recieve button at the bottom of this page" class="info fa fa-info-circle"></span></h5>     
                                    </div>
                                </div>
                                                              
                                <div class="row" style="border-bottom: groove; "> 
                                    <div class="form-inline col-md-11">
                                        <ul class="nav nav-pills" role="tablist">
                                            <li class="active"><a data-toggle="pill" href="#generalPartInfo" ><span class="label label-pill label-danger" style="border-radius: 1em;">0</span><i style="color:black;"> General</i><span class="fa fa-paperclip pull-right" style="color:black;"></span></a></li>
                                            <li><a data-toggle="pill" href="#test"><span class="label label-pill label-danger" style="border-radius: 1em;">1</span><i style="color:black;"> test</i><span class="fa fa-paperclip pull-right" style="color:black;"></span></a></li>
                                            <li style="float:right;"><button type="button" class="btn btn-primary">Download All</button></li>                                       
                                        </ul>                                     
                                    </div>     
                                </div>  
                                
                                <div class="tab-content col-md-10" >
                                    <div id="generalPartInfo" class="tab-pane fade in active">                                    
                                        <button type="button" class="btn btn-primary" style="float:left;">Add files</button> 
                                        <button type="button" class="btn btn-primary" style="float:left; margin-left: 5px;">Download files all below</button> 
                                        <div class="row" style="margin-top: 5px;">
                                            <div class="form-inline col-md-11" style="margin-top: 10px; border-bottom: groove;">
                                                <i>No files</i>
                                            </div>  
                                        </div>
                                    </div>
                                    
                                    <div id="test" class="tab-pane fade">
                                        <button type="button" class="btn btn-primary" style="float:left;">Add files</button> 
                                        <button type="button" class="btn btn-primary" style="float:left; margin-left: 5px;">Download files all below</button>                                       
                                        <div class="row" style="margin-top: 5px;">
                                            <div class="form-inline col-md-11" style="margin-top: 10px; border-bottom: groove;">
                                                <a href="#" class="fa fa-file-o" aria-hidden="true" style="margin-top: 10px;">Thumbs.db</a>
                                                <button type="button" class="btn btn-danger" style="float:right;">Delete</button>    
                                            </div>  
                                        </div>                                
                                    </div>
                                </div>
                            </div>
                        
                            <div id="DNlogs" class="tab-pane fade">
                                <div class="row vertical-align-baseline">
                                        <div style="float:left;">
                                            <h3>Logs</h3>        
                                        </div>
                                        <div style="float:left; padding-left: 2em; font-size: 6px;">
                                        <h5 class="custom" style="background-color: orange">Confirm that you have recieved the Design Notification by clicking the Recieve button<span title="Info" data-toggle="popover" data-trigger="hover" data-content="This specific Design Notification (mailtest1) is waiting for YOUR actions, YOU need to REPLY to the Design Notifications which have been sent to you. Do this by clicking on the recieve button at the bottom of this page" class="info fa fa-info-circle"></span></h5>     
                                    </div>
                                    </div>
                                
                                    <div class="row" style="border-bottom: groove; "> 
                                        <div class="form-inline col-md-11">
                                            <ul class="nav nav-pills" role="tablist">
                                                <li class="active"><a data-toggle="pill" href="#DNMainLog" style="color: black;">Log<span class="fa fa-book pull-right"></span></a></li>
                                                <li class="tabSeparator"><a style="color: black;">Part Logs: </a></li>
                                                <li><a data-toggle="pill" href="#testLog" style="color: black;">test<span class="fa fa-comment pull-right"></span></a></li>                          
                                            </ul>                                     
                                        </div>     
                                    </div>  
                                
                                    <div class="tab-content col-md-10" >
                                        <div id="DNMainLog" class="tab-pane fade in active">
                                            <div class="container col-md-12" >
                                                <div class="row" style="margin-top: 10px;">
                                                    <div class="">
                                                        <table class="table" style="outline: solid; outline-color: #0a8bb7;">
                                                            <thead>
                                                                <tr style="background-color: #0a8bb7; color: white;">
                                                                    <th class="col-xs-2">Date</th>
                                                                    <th class="col-xs-2">Action</th>
                                                                    <th class="col-xs-2">User</th>
                                                                    <th class="col-xs-6">Comment</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td class="col-xs-2">2016-04-08 13:32</td>
                                                                    <td class="col-xs-2">SendToSupplier</td>
                                                                    <td class="col-xs-2">Sogeti Internal</td>
                                                                    <td class="col-xs-6">Design Notification sent to suppliers</td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="col-xs-2">2016-04-08 13:32</td>
                                                                    <td class="col-xs-2">DnUpdated</td>
                                                                    <td class="col-xs-2">Sogeti Internal</td>
                                                                    <td class="col-xs-6">Design Notification info is updated</td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="col-xs-2">2016-04-08 13:25</td>
                                                                    <td class="col-xs-2">Created</td>
                                                                    <td class="col-xs-2">Sogeti Internal</td>
                                                                    <td class="col-xs-6">Design Notification created</td>
                                                                </tr>
  
                                                            </tbody>
                                                        </table> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="testLog" class="tab-pane fade">
                                            <div class="container col-md-12" >
                                                <div class="row" style="margin-top: 10px;">
                                                    <div class="">
                                                        <table class="table" style="outline: solid; outline-color: #0a8bb7;">
                                                            <thead>
                                                                <tr style="background-color: #0a8bb7; color: white;">
                                                                    <th class="col-xs-2">Date</th>
                                                                    <th class="col-xs-2">User</th>
                                                                    <th class="col-xs-6">Comment</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td class="col-xs-2">2016-04-12 08:01</td>
                                                                    <td class="col-xs-2">Sogeti Internal</td>
                                                                    <td class="col-xs-6">Mail sent to supplier regarding a receive overdue DN.</td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="col-xs-2">2016-04-11 15:28</td>
                                                                    <td class="col-xs-2">Sogeti Internal</td>
                                                                    <td class="col-xs-6">Mail sent to supplier regarding a receive overdue DN.</td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="col-xs-2">2016-04-08 13:32</td>
                                                                    <td class="col-xs-2">Sogeti Internal</td>
                                                                    <td class="col-xs-6">Part sent to supplier</td>
                                                                </tr>
  
                                                            </tbody>
                                                        </table> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    
                                                                      
                                    </div>
                            </div>
                        
                            <div id="DNcomments" class="tab-pane fade">
                                <div class="row vertical-align-baseline">
                                    <div style="float:left;">
                                        <h3>Comments</h3>        
                                    </div>
                                    <div style="float:left; padding-left: 2em; font-size: 6px;">
                                        <h5 class="custom" style="background-color: orange">Confirm that you have recieved the Design Notification by clicking the Recieve button<span title="Info" data-toggle="popover" data-trigger="hover" data-content="This specific Design Notification (mailtest1) is waiting for YOUR actions, YOU need to REPLY to the Design Notifications which have been sent to you. Do this by clicking on the recieve button at the bottom of this page" class="info fa fa-info-circle"></span></h5>      
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <textarea class="form-control" placeholder="Write a comment"></textarea>
                                        <button class="btn btn-primary" type="button" style="float: right; margin-top: 5px;">
                                            Add Comment
                                        </button>
                                        <div class="dropdown" id="choosePart" style="margin-top: 5px; margin-right: 5px; float: right;">
                                            <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                            Choose part
                                            </button>

                                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style="text-align:center;">
                                                <li><a>General comment</a></li>
                                                <li><a>test</a></li>
                                            </ul>
                                        </div>                                    
                                    </div>
                                </div>
                                
                                <div class="row" style="border-bottom: groove; "> 
                                    <div class="form-inline col-md-11">
                                        <ul class="nav nav-pills" role="tablist">
                                            <li class="active"><a data-toggle="pill" href="#DNGeneralComments" style="color: black;">General Comments<span class="fa fa-book pull-right"></span></a></li>
                                            <li class="tabSeparator"><a style="color: black;">Part Comments: </a></li>
                                            <li><a data-toggle="pill" href="#testComment" style="color: black;">test<span class="fa fa-comment pull-right"></span></a></li>                          
                                        </ul>                                     
                                    </div>     
                                </div>  
                                
                                <div class="tab-content col-md-10">
                                    <div id="DNGeneralComments" class="tab-pane fade in active">
                                        hej
                                    </div>
                                    
                                    <div id="testComment" class="tab-pane fade">
                                        hej
                                    </div>
                                </div>
                                                                                       
                            </div>

                        </div>
                    </div>     
                                         
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

    <div class="container">
        <nav class="navbar navbar-default navbar-fixed-bottom text-center text-success" id="footer">
            <div class="navbar-inner">
                <p class="text-muted credit col-md-offset-1 col-md-10">Atlas Copco | Supplier Collaboration Portal</p>
                <a class="text-muted credit col-md-1" id="backButton" style="float:right"><span class="fa fa-arrow-circle-left fa-3x"></span></a>
            </div>                                          
        </nav>
        
    </div>

    <a href="#" class="scrollToTop">Scroll To Top</a>

    
</body>
</html>
