<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="GadgetHubClientAPP.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - GadgetHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet" />
    <style>
        :root{
            --brand:#000;              
            --accent:#f7e3a6;          
            --accent-strong:#f5d87e;
            --ink:#1f2937;
            --muted:#6b7280;
            --ring:rgba(0,0,0,.08);
            --card:#ffffff;
            --bg:#faf7ec;
            --radius:14px;
            --shadow-md:0 10px 24px rgba(0,0,0,.10);
            --shadow-lg:0 24px 60px rgba(0,0,0,.12);
        }
        *{box-sizing:border-box}
        html,body{height:100%}
        body{
            margin:0;
            font-family:'Poppins', system-ui, Segoe UI, Roboto, Arial;
            color:var(--ink);
            background:
                linear-gradient(rgba(247,227,166,.22), rgba(247,227,166,.22)),
                repeating-linear-gradient(45deg, #fff0 0 16px, rgba(0,0,0,.03) 16px 32px),
                var(--bg);
        }


        .app{
            display:grid;
            grid-template-columns: 260px 1fr;
            grid-template-rows: 70px 1fr;
            min-height:100vh;
        }
        .sidebar{
            grid-row:1 / span 2;
            background:#fff;
            border-right:1px solid var(--ring);
            padding:18px 14px;
        }
        .brand{
            display:flex; align-items:center; gap:12px;
            padding:6px 8px 16px; border-bottom:1px dashed var(--ring); margin-bottom:12px;
        }
        .brand img{width:42px;height:42px;object-fit:contain}
        .brand .title{font-weight:800;letter-spacing:.2px}

        .nav a{
            display:flex; align-items:center; gap:10px;
            padding:10px 12px; margin:6px 0;
            color:var(--ink); text-decoration:none; border-radius:10px;
        }
        .nav a:hover{background:rgba(0,0,0,.04)}

        .topbar{
            display:flex; align-items:center; justify-content:space-between;
            padding:14px 20px; background:#fff; border-bottom:1px solid var(--ring);
        }
        .top-actions{display:flex; gap:10px; align-items:center}
        .btn{
            border:none; cursor:pointer; font-weight:700; border-radius:10px;
            padding:10px 14px; transition:transform .02s, background .15s;
        }
        .btn:active{transform:translateY(1px)}
        .btn-accent{background:var(--accent); color:var(--brand)}
        .btn-accent:hover{background:var(--accent-strong)}
        .btn-outline{background:#fff; border:1px solid var(--ring);}

        .main{padding:22px 22px 40px}
        .section-head{display:flex; align-items:end; justify-content:space-between; margin-bottom:14px}
        .section-head h2{margin:0; font-size:1.35rem}
        .hint{color:var(--muted); font-size:.92rem}

      
        .card{
            background:var(--card); border:1px solid var(--ring); border-radius:var(--radius);
            box-shadow:var(--shadow-md); padding:16px;
        }
        .table{
            width:100%; border-collapse:separate; border-spacing:0; background:#fff;
            border:1px solid var(--ring); border-radius:12px; overflow:hidden; box-shadow:var(--shadow-md);
        }
        .table th, .table td{padding:12px 14px; border-bottom:1px solid var(--ring); text-align:left}
        .table th{background:var(--accent); color:var(--brand)}
        .table tr:last-child td{border-bottom:none}

        .message{font-weight:700; color:#b91c1c; margin-bottom:10px}

        .btn-mini{
            padding:7px 12px; border-radius:8px; border:none; font-weight:700; cursor:pointer;
        }
        .btn-view{background:#111827; color:#fff}
        .btn-view:hover{opacity:.92}
        .btn-delete{background:#e11d48; color:#fff}
        .btn-delete:hover{opacity:.92}
        .btn-close{background:#374151; color:#fff}

      
        .panel{
            margin-top:20px;
            background:#fff; border:1px solid var(--ring); border-radius:12px; box-shadow:var(--shadow-md);
            padding:16px;
        }

    
        @media (max-width:980px){
            .app{grid-template-columns:1fr; grid-template-rows:70px 1fr}
            .sidebar{display:none}
            .topbar{position:sticky; top:0; z-index:5}
            .main{padding:16px}
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="app">
     
        <aside class="sidebar">
            <div class="brand">
                <img src="logo.png" alt="Gadget Hub" />
                <div class="title">Gadget Hub Admin</div>
            </div>
            <nav class="nav">
                <a href="#"><span>📊</span> Overview</a>
                <a href="#"><span>📦</span> Orders</a>
                <a href="#"><span>🏷️</span> Quotations</a>
                <a href="#"><span>🧩</span> Products</a>
            </nav>
        </aside>

        
        <header class="topbar">
            <div style="font-weight:800;">Admin Dashboard</div>
            <div class="top-actions">
                <button type="button" class="btn btn-outline" onclick="location.href='ClientLogin.aspx'">Log out</button>
                <button type="button" class="btn btn-accent" onclick="location.reload()">Refresh</button>
            </div>
        </header>

        
        <main class="main">
            <asp:Label ID="lblMessage" runat="server" CssClass="message" />

            <div class="section-head">
                <h2>All Orders</h2>
                <span class="hint">Manage orders and view quotations</span>
            </div>

            <div class="card" style="padding:0">
                
                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False"
                    OnRowCommand="gvOrders_RowCommand" GridLines="None" ShowHeader="true" CssClass="table">
                    <Columns>
                        <asp:BoundField DataField="OrderId" HeaderText="Order ID" />
                        <asp:BoundField DataField="ProductName" HeaderText="Product" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                        <asp:BoundField DataField="DistributorName" HeaderText="Distributor" />
                        <asp:BoundField DataField="ConfirmedPrice" HeaderText="Price (LKR)" DataFormatString="LKR {0:N2}" />
                        <asp:BoundField DataField="ConfirmedDeliveryDays" HeaderText="Days" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                        <asp:BoundField DataField="CreatedAt" HeaderText="Ordered" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnViewQuotes" runat="server" Text="View" CssClass="btn-mini btn-view"
                                    CommandName="ViewQuotes" CommandArgument='<%# Eval("OrderId") %>' />
                                <asp:Button ID="btnDelete" runat="server" Text="Cancel" CssClass="btn-mini btn-delete"
                                    CommandName="DeleteOrder" CommandArgument='<%# Eval("OrderId") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

       
            <asp:Panel ID="pnlQuotes" runat="server" Visible="false" CssClass="panel">
                <div class="section-head" style="margin-bottom:10px">
                    <h2>Quotations</h2>
                    <span class="hint">Order ID: <asp:Label ID="lblQuotesTitle" runat="server" /></span>
                </div>

                <asp:GridView ID="gvQuotes" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table" ShowHeader="true">
                    <Columns>
                        <asp:BoundField DataField="DistributorName" HeaderText="Distributor" />
                        <asp:BoundField DataField="PricePerUnit" HeaderText="Price/Unit (LKR)" DataFormatString="LKR {0:N2}" />
                        <asp:BoundField DataField="DeliveryDays" HeaderText="Delivery Days" />
                    </Columns>
                </asp:GridView>

                <div style="margin-top:12px; display:flex; justify-content:flex-end; gap:8px">
                    <asp:Button ID="btnCloseQuotes" runat="server" Text="Close" CssClass="btn btn-close" OnClick="btnCloseQuotes_Click" />
                </div>
            </asp:Panel>
        </main>
    </div>
</form>
</body>
</html>
