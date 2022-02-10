<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1.Default" %>

<%@ Register Assembly="DevExpress.Web.v21.2, Version=21.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraReports.v21.2.Web.WebForms, Version=21.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script>
        function onClick(s, e) {
            var p = viewer.PerformCustomDocumentOperation();
            p.done(function (arg1) {
                btn.DoClick();
            });
        }
        function onInit(s, e) {
            $('.dxrd-preview-wrapper').css('top', 10);
        }

        function customizeElements(s, e) {
            var toolbarPart = e.GetById(DevExpress.Reporting.Viewer.PreviewElements.Toolbar);
            var index = e.Elements.indexOf(toolbarPart);
            e.Elements.splice(index, 1);
            toolbarPart = e.GetById(DevExpress.Reporting.Viewer.PreviewElements.RightPanel);
            index = e.Elements.indexOf(toolbarPart);
            e.Elements.splice(index, 1);
        }

    </script>
    <style>
        .rootGroup > div:first-child {
            border-right: 1px solid #9f9f9f;
        }

        .dx-designer-viewport .dxd-back-primary-invariant {
            background-color: #ffffff;
            margin: -6px -11px 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxFormLayout runat="server" ID="formLayout" CssClass="formLayout">
            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="1000" />
            <Items>
                <dx:LayoutGroup ColumnCount="2" UseDefaultPaddings="false" GroupBoxDecoration="None" ShowCaption="False" CssClass="rootGroup">
                    <Items>
                        <dx:LayoutGroup Caption="Enter new data" ColCount="1" GroupBoxDecoration="HeadingLine" UseDefaultPaddings="false" Paddings-PaddingTop="0">
                            <Paddings PaddingTop="0px"></Paddings>
                            <Items>
                                <dx:LayoutItem Caption="First Name">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxTextBox ID="FirstName" runat="server">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Last Name">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxTextBox ID="LastName" runat="server">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Signature">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxWebDocumentViewer ID="ASPxWebDocumentViewer1" Width="360px" Height="120px" ClientInstanceName="viewer" runat="server" ColorScheme="dark" ReportSourceId="WebApplication1.XtraReport1">
                                                <ClientSideEvents CustomizeElements="customizeElements" />
                                                <ClientSideEvents Init="onInit" />
                                            </dx:ASPxWebDocumentViewer>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxButton ID="ASPxButton1" runat="server" AutoPostBack="False" Text="Send to a database">
                                                <ClientSideEvents Click="onClick" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                        <dx:LayoutGroup Caption="Here will be data from the database" ColCount="1" GroupBoxDecoration="HeadingLine" UseDefaultPaddings="false" Paddings-PaddingLeft="15px">
                            <Paddings PaddingLeft="15px"></Paddings>

                            <GroupBoxStyle>
                                <Caption>
                                    <Paddings PaddingLeft="15px" />
                                </Caption>
                            </GroupBoxStyle>
                            <Items>
                                <dx:LayoutItem Caption="First Name" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxLabel runat="server" ID="FirstNameReadOnly" CssClass="dxflFormLayout">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Last Name" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxLabel runat="server" ID="LastNameReadOnly" CssClass="dxflFormLayout">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Signature" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxLabel runat="server" ID="SignatureLabel" CssClass="dxflFormLayout">
                                            </dx:ASPxLabel>
                                            <dx:ASPxBinaryImage ID="binaryImage" runat="server" Height="120px" Enabled="false">
                                            </dx:ASPxBinaryImage>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:EmptyLayoutItem Height="29px" />
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:LayoutGroup>


            </Items>
        </dx:ASPxFormLayout>

        <dx:ASPxButton ID="btn" runat="server" AutoPostBack="true" OnClick="ASPxButton2_Click" ClientInstanceName="btn" ClientVisible="false" />
    </form>
</body>
</html>
