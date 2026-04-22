<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GadgetHubClientAPP._Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Gadget Hub | Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet" />
   <style>
    :root{
        --brand:#000;              
        --accent:#f7e3a6;          
        --accent-strong:#f5d87e;   
        --bg:#faf7ec;              
        --ink:#1f2937;
        --muted:#6b7280;
        --card:#ffffff;
        --ring:rgba(0,0,0,.08);
        --radius:14px;
        --shadow-lg:0 24px 60px rgba(0,0,0,.12);
        --shadow-md:0 10px 24px rgba(0,0,0,.10);
    }
    *{box-sizing:border-box}
    html,body{height:100%}
    body{
        margin:0;
        font-family:'Poppins',system-ui,Segoe UI,Roboto,Arial;
        color:var(--ink);
        background:
          linear-gradient(rgba(247,227,166,.25), rgba(247,227,166,.25)),
          repeating-linear-gradient(45deg, #fff0 0 16px, rgba(0,0,0,.02) 16px 32px),
          var(--bg);
    }

    .app{
        display:grid;
        grid-template-columns: 260px 1fr;
        grid-template-rows: 70px 1fr;
        gap:0;
        min-height:100vh;
    }
    .sidebar{
        grid-row: 1 / span 2;
        background:#fff;
        border-right:1px solid var(--ring);
        padding:20px 16px;
    }
    .brand{
        display:flex; align-items:center; gap:12px; padding:4px 6px 16px 6px;
        border-bottom:1px dashed var(--ring);
        margin-bottom:14px;
    }
    .brand img{width:42px;height:42px;object-fit:contain}
    .brand .title{font-weight:800;letter-spacing:.2px}

    .nav a{
        display:flex; align-items:center; gap:10px;
        padding:10px 12px; margin:6px 0;
        color:var(--ink); text-decoration:none; border-radius:10px;
    }
    .nav a:hover{background: rgba(0,0,0,.04)}
    .nav .pill{margin-left:auto; background:var(--accent); color:var(--brand); font-weight:700; font-size:.8rem; padding:2px 8px; border-radius:999px}

    .topbar{
        display:flex; align-items:center; justify-content:space-between;
        padding:14px 20px; background:#fff; border-bottom:1px solid var(--ring);
    }
    .search{
        display:flex; align-items:center; gap:10px;
        background:#fff; padding:10px 12px; border:1px solid var(--ring); border-radius:12px; width: min(520px, 60vw);
    }
    .search input{border:none; outline:none; width:100%; font:inherit}

    .actions{display:flex; gap:10px; align-items:center}
    .btn{
        border:none; cursor:pointer; font-weight:700; border-radius:12px;
        padding:10px 14px; transition:transform .02s, background .15s;
    }
    .btn:active{transform:translateY(1px)}
    .btn-cart{background:var(--accent); color:var(--brand)}
    .btn-cart:hover{background:var(--accent-strong)}
    .btn-outline{background:#fff; border:1px solid var(--ring);}

    .main{
        padding:24px 24px 96px; 
    }

    .section-head{
        display:flex; align-items:end; justify-content:space-between; margin-bottom:16px;
    }
    .section-head h2{margin:0; font-size:1.4rem}
    .hint{color:var(--muted); font-size:.9rem}

    .grid{
        display:grid;
        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
        gap:18px;
        margin-bottom:96px; 
    }
    .card{
        background:var(--card); border:1px solid var(--ring); border-radius:var(--radius);
        box-shadow:var(--shadow-md);
        padding:14px; display:flex; flex-direction:column; gap:10px;
    }
    .card .imgbox {
    height: 180px; 
    background: #fff;
    border: 1px dashed var(--ring);
    border-radius: 12px;
    display: grid;
    place-items: center;
    overflow: hidden;
    padding: 10px;
}
.card img {
    width: 100%;
    height: 100%;
    object-fit: contain; 
}
    .name{font-weight:700; line-height:1.2}
    .desc{color:var(--muted); font-size:.92rem; min-height:42px}

    .line{
        display:flex; gap:10px; align-items:center; margin-top:auto;
    }
    .qty{
        width:64px; text-align:center; padding:10px 8px; border:1px solid var(--ring); border-radius:10px; font:inherit;
    }
    .add{
        background:var(--brand); color:#fff; border:none; border-radius:10px; padding:10px 14px; font-weight:700; cursor:pointer;
    }
    .add:hover{opacity:.92}

    .drawer{
        position:fixed; top:0; right:0; height:100%; width:min(420px, 92vw);
        background:#fff; border-left:1px solid var(--ring); box-shadow:var(--shadow-lg);
        transform:translateX(100%); transition: transform .25s ease;
        display:flex; flex-direction:column;
    }
    .drawer.open{transform:translateX(0)}
    .drawer-head{
        display:flex; align-items:center; justify-content:space-between;
        padding:16px 18px; border-bottom:1px solid var(--ring);
    }
    .drawer-body{padding:18px; overflow:auto}
    .drawer .checkout{
        margin:16px 18px 22px; padding:12px 16px; border:none; border-radius:12px;
        background:#2e7d32; color:#fff; font-weight:800; cursor:pointer;
    }
    .drawer .checkout:hover{background:#256728}
    .success{color:#1b5e20; font-weight:700; margin-left:18px; margin-bottom:16px}

    .table{
        width:100%; border-collapse:separate; border-spacing:0; background:#fff;
        border:1px solid var(--ring); border-radius:12px; overflow:hidden; box-shadow:var(--shadow-md);
    }
    .table th, .table td{padding:12px 14px; border-bottom:1px solid var(--ring); text-align:left}
    .table th{background:var(--accent); color:var(--brand)}
    .table tr:last-child td{border-bottom:none}
    .badge{
        display:inline-block; padding:2px 8px; border-radius:999px; font-size:.82rem;
        background:#eef2ff; color:#3730a3; font-weight:700;
    }

    @media (max-width: 980px){
        .app{grid-template-columns: 1fr; grid-template-rows: 70px 1fr}
        .sidebar{grid-row:auto; display:none}
        .topbar{position:sticky; top:0; z-index:5}
        .main{padding:16px 16px 110px;}  
        .grid{gap:14px; margin-bottom:110px;}
    }
</style>

    <script>
        function toggleCart() {
            var d = document.getElementById('cartDrawer');
            d.classList.toggle('open');
            if (d.classList.contains('open')) setTimeout(() => d.querySelector('button, input, a')?.focus(), 120);
        }
    </script>
</head>
<body>
<form id="form1" runat="server">
    <div class="app">
        <aside class="sidebar">
            <div class="brand">
                <img src="logo.png" alt="Gadget Hub" />
                <div class="title">Gadget Hub</div>
            </div>
            <nav class="nav">
                <a href="#"><span>🏠</span> Dashboard</a>
                <a href="#"><span>🛍️</span> Products <span class="pill">Live</span></a>
                <a href="#" onclick="toggleCart(); return false;"><span>🛒</span> Cart</a>
                <a href="#"><span>📦</span> Orders</a>
            </nav>
        </aside>

        <header class="topbar">
            <div class="search">
                <span>🔎</span>
                <input type="text" placeholder="Search products…" aria-label="Search products" />
            </div>
            <div class="actions">
                <button type="button" class="btn btn-outline" onclick="location.href='ClientLogin.aspx'">Log out</button>
                <button type="button" class="btn btn-cart" onclick="toggleCart()">🛒 View Cart</button>
            </div>
        </header>

        <main class="main">
            <div class="section-head">
                <h2>Products</h2>
                <span class="hint">Browse and add to your cart</span>
            </div>

            <div class="grid">
                <asp:Repeater ID="rptProducts" runat="server">
                    <ItemTemplate>
                        <div class="card">
                            <div class="imgbox">
                                <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Name") %>' />
                            </div>

                            <div class="name">
                                <%# Eval("Name") %>
                                <asp:Literal ID="litProductName" runat="server" Visible="false" Text='<%# Eval("Name") %>' />
                            </div>

                            <div class="desc"><%# Eval("Description") %></div>

                            <div class="line">
                                <asp:TextBox ID="txtQty" runat="server" CssClass="qty" Text="1" />
                                <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="add"
                                    CommandArgument='<%# Eval("ProductId") %>' OnClick="btnAddToCart_Click" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div style="margin-top:34px" class="section-head">
                <h2>Placed Orders</h2>
                <span class="hint">Latest updates from distributors</span>
            </div>
            <asp:Repeater ID="rptPlacedOrders" runat="server">
                <HeaderTemplate>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Product</th>
                                <th>Qty</th>
                                <th>Distributor</th>
                                <th>Price</th>
                                <th>Delivery</th>
                                <th>Ordered</th>
                                <th>Est. Delivery</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("OrderId") %></td>
                        <td><%# Eval("ProductName") %></td>
                        <td><span class="badge"><%# Eval("Quantity") %></span></td>
                        <td><%# Eval("DistributorName") %></td>
                        <td>Rs. <%# Eval("ConfirmedPrice") %></td>
                        <td><%# Eval("ConfirmedDeliveryDays") %> days</td>
                        <td><%# Eval("CreatedAt", "{0:yyyy-MM-dd}") %></td>
                        <td>
                            <%# Eval("EstimatedDeliveryDate") != null 
                                ? string.Format("{0:yyyy-MM-dd}", Eval("EstimatedDeliveryDate")) 
                                : "Pending" %>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </main>
    </div>

    <aside id="cartDrawer" class="drawer" aria-label="Cart drawer">
        <div class="drawer-head">
            <strong>🛒 Your Cart</strong>
            <button type="button" class="btn btn-outline" onclick="toggleCart()">Close</button>
        </div>
        <div class="drawer-body">
            <asp:Repeater ID="rptCart" runat="server">
                <HeaderTemplate>
                    <table class="table" style="box-shadow:none">
                        <thead>
                            <tr>
                                <th style="width:65%">Product</th>
                                <th>Qty</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("ProductName") %></td>
                        <td><%# Eval("Quantity") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>

        <asp:Button ID="btnCheckout" runat="server" Text="Checkout All" CssClass="checkout" OnClick="btnCheckout_Click" />
        <asp:Label ID="lblResult" runat="server" CssClass="success" />
    </aside>
</form>
</body>
</html>
