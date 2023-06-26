<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page2.aspx.cs" Inherits="PersonAPI.Page2" %>
<%@ Register Assembly="DotNet.Highcharts" Namespace="DotNet.Highcharts" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Person Column Chart</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField runat ="server" ID="titleField"/>
        <div id="chartContainer">
            <asp:Literal id="ltrChart" runat="server"></asp:Literal>
            
        </div>
        
    </form>
    <script>
        $(document).ready(function () {

            var randomDates = createRandomDate();
            var randomNumbers = createRandomNumbers();

            var title = $('#<%= titleField.ClientID %>').val();
            var titleArr = title.split("|");

            var chart = new Highcharts.Chart({
                chart: {
                    renderTo: 'chartContainer',
                    type: 'column'
                },
                title: {
                    useHTML: true,
                    style: {
                        textAlign: 'center'
                    },
                    text: '<div style="display: flex; justify-content: space-between;"><span style="margin-right: 180px;" >' + titleArr[0] + '</span><span>' + titleArr[1] + '</span><span  style="margin-left: 180px;">' + titleArr[2] +'</span></div>'
    
                },
                xAxis: {
                    categories: randomDates
                },
                yAxis: {
                    title: {
                        text: 'Value'
                    }
                },
                series: [
                    {
                        name: 'RandomDates',
                        data: randomNumbers
                    },

                ]
            });
            function randomDate(start, end) {
                return new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
            }
            function randomNumber(min, max) {
                return Math.ceil(Math.random() * (max - min)) + min;
            }
            function createRandomNumbers() {
                var ranNum = [];
                for (var i = 0; i < 10; i++) {
                    var min = i + 5;
                    var max = i * 10;
                    ranNum.push(randomNumber(min, max));

                }
                return ranNum
            }

            function createRandomDate() {
                var randDate = [];
                for (var i = 0; i < 10; i++) {
                    var dte = randomDate(new Date(2012, 0, i), new Date());
                    randDate.push(formatDate(dte));
                }
                return randDate;
            }

            function formatDate(date) {
                const yyyy = date.getFullYear();
                let mm = date.getMonth() + 1; // Months start at 0!
                let dd = date.getDate();

                if (dd < 10) dd = '0' + dd;
                if (mm < 10) mm = '0' + mm;

                return mm + '/' + dd + '/' + yyyy;

            }
        });
    </script>
</body>
</html>
