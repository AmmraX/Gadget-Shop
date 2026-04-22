<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DistributorDashboard.aspx.cs" Inherits="GadgetHubClientAPP.DistributorDashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Distributor Dashboard - GadgetHub</title>
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
            font-family:'Poppins',system-ui,Segoe UI,Roboto,Arial;
            color:var(--ink);
            background:
                linear-gradient(rgba(247,227,166,.22), rgba(247,227,166,.22)),
                repeating-linear-gradient(45deg, #fff0 0 16px, rgba(0,0,0,.03) 16px 32px),
                var(--bg);
        }

      
        .app{
            display:grid;
            grid-template-columns:260px 1fr;
            grid-template-rows:70px 1fr;
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
        .welcome{font-size:1rem; color:var(--muted); margin-top:2px}

        
        .card{
            background:var(--card); border:1px solid var(--ring); border-radius:var(--radius);
            box-shadow:var(--shadow-md); padding:16px;
        }
        .section-head{display:flex; align-items:end; justify-content:space-between; margin-bottom:12px}
        .section-head h2{margin:0; font-size:1.35rem}
        .hint{color:var(--muted); font-size:.92rem}

        .grid{
            display:grid; gap:16px;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        }
        .order-card{
            background:#fff; border:1px solid var(--ring); border-radius:12px; padding:14px; box-shadow:var(--shadow-md);
            display:flex; flex-direction:column; gap:8px;
        }
        .order-card h3{margin:0; font-size:1.05rem}
        .meta{color:var(--muted); font-size:.92rem}
        .line{display:flex; flex-wrap:wrap; gap:10px; align-items:center; margin-top:8px}
        .input{
            width:140px; padding:10px; border:1px solid var(--ring); border-radius:10px; font:inherit;
            transition:border-color .2s, box-shadow .2s;
        }
        .input:focus{
            outline:none; border-color:var(--accent);
            box-shadow:0 0 0 4px rgba(247,227,166,.35);
        }
        .submit{
            background:var(--brand); color:#fff; border:none; border-radius:10px; padding:10px 14px; font-weight:700; cursor:pointer;
        }
        .submit:hover{opacity:.92}

        
        .table{
            width:100%; border-collapse:separate; border-spacing:0; background:#fff;
            border:1px solid var(--ring); border-radius:12px; overflow:hidden; box-shadow:var(--shadow-md);
        }
        .table th, .table td{padding:12px 14px; border-bottom:1px solid var(--ring); text-align:left}
        .table th{background:var(--accent); color:var(--brand)}
        .table tr:last-child td{border-bottom:none}

        .message{font-weight:700; margin-bottom:10px}
        .success{color:#1b5e20}
        .error{color:#b91c1c}

        
        .drawer{
            position:fixed; right:0; top:0; height:100%; width:min(520px, 95vw);
            background:#fff; border-left:1px solid var(--ring); box-shadow:var(--shadow-lg);
            transform:translateX(100%); transition:transform .25s ease; display:flex; flex-direction:column;
        }
        .drawer.open{transform:translateX(0)}
        .drawer-head{
            display:flex; align-items:center; justify-content:space-between;
            padding:16px 18px; border-bottom:1px solid var(--ring);
        }
        .drawer-body{padding:18px; overflow:auto}

        
        @media (max-width:980px){
            .app{grid-template-columns:1fr; grid-template-rows:70px 1fr}
            .sidebar{display:none}
            .topbar{position:sticky; top:0; z-index:5}
            .main{padding:16px}
        }
    </style>
    <script>
        function toggleConfirmed(){
            var d=document.getElementById('confirmedDrawer');
            d.classList.toggle('open');
        }
    </script>
</head>
<body>
<form id="form1" runat="server">
    <div class="app">
     
        <aside class="sidebar">
            <div class="brand">
                <img src="logo.png" alt="Gadget Hub" />
                <div class="title">Distributor</div>
            </div>
            <nav class="nav">
                <a href="#"><span>📋</span> Awaiting Quotes</a>
                <a href="#" onclick="toggleConfirmed();return false;"><span>✅</span> Confirmed Orders</a>
            </nav>
        </aside>

   
        <header class="topbar">
            <div>
                <strong>Gadget Hub • Distributor Dashboard</strong>
                <div class="welcome">Welcome, <asp:Label ID="lblDistributorName" runat="server" Font-Bold="true" /></div>
            </div>
            <div class="top-actions">
                <button type="button" class="btn btn-outline" onclick="location.href='DistributorLogin.aspx'">Log out</button>
                <button type="button" class="btn btn-accent" onclick="location.reload()">Refresh</button>
            </div>
        </header>

     
        <main class="main">
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

            
            <div class="section-head">
                <h2>Orders Awaiting Your Quotation</h2>
                <span class="hint">Submit your best price and delivery time</span>
            </div>

            <div class="grid">
                <asp:Repeater ID="rptOrders" runat="server">
                    <ItemTemplate>
                        <div class="order-card">
                            <h3><%# Eval("ProductName") %></h3>
                            <div class="meta">Qty: <%# Eval("Quantity") %> • Status: <%# Eval("Status") %> • Quotes: <%# Eval("QuotationCount") %></div>

                            <div class="line">
                                <asp:TextBox ID="txtPrice" runat="server" CssClass="input" placeholder="Price (Rs.)" />
                                <asp:TextBox ID="txtDays" runat="server" CssClass="input" placeholder="Delivery Days" />
                                <asp:Button ID="btnSubmitQuotation" runat="server" Text="Submit"
                                    CommandArgument='<%# Eval("OrderId") %>' CssClass="submit"
                                    OnClick="btnSubmitQuotation_Click" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

         
            <div class="section-head" style="margin-top:28px">
                <h2>Your Confirmed Orders</h2>
                <span class="hint"><a href="#" onclick="toggleConfirmed();return false;">Open as drawer ↗</a></span>
            </div>
            <asp:Repeater ID="rptPlacedOrders" runat="server">
                <HeaderTemplate>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Product</th>
                                <th>Qty</th>
                                <th>Price</th>
                                <th>Delivery Days</th>
                                <th>Date Ordered</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("OrderId") %></td>
                        <td><%# Eval("ProductName") %></td>
                        <td><%# Eval("Quantity") %></td>
                        <td>Rs. <%# Eval("ConfirmedPrice", "{0:N2}") %></td>
                        <td><%# Eval("ConfirmedDeliveryDays") %></td>
                        <td><%# Eval("CreatedAt", "{0:yyyy-MM-dd}") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </main>
    </div>

    
    <aside id="confirmedDrawer" class="drawer" aria-label="Confirmed orders drawer">
        <div class="drawer-head">
            <strong>✅ Your Confirmed Orders</strong>
            <button type="button" class="btn btn-outline" onclick="toggleConfirmed()">Close</button>
        </div>
        <div class="drawer-body">
            <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                    <table class="table" style="box-shadow:none">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Product</th>
                                <th>Qty</th>
                                <th>Price</th>
                                <th>Delivery Days</th>
                                <th>Date Ordered</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("OrderId") %></td>
                        <td><%# Eval("ProductName") %></td>
                        <td><%# Eval("Quantity") %></td>
                        <td>Rs. <%# Eval("ConfirmedPrice", "{0:N2}") %></td>
                        <td><%# Eval("ConfirmedDeliveryDays") %></td>
                        <td><%# Eval("CreatedAt", "{0:yyyy-MM-dd}") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </aside>
</form>
</body>
</html>
