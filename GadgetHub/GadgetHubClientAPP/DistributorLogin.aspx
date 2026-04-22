<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DistributorLogin.aspx.cs" Inherits="GadgetHubClientAPP.DistributorLogin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Distributor Login - GadgetHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet" />
    <style>
        :root{
            --brand:#000000;         
            --accent:#f7e3a6;         
            --accent-strong:#f5d87e; 
            --text:#1f1f1f;
            --card:rgba(255,255,255,.96);
            --radius:16px;
            --shadow:0 22px 55px rgba(0,0,0,.14);
        }
        *{box-sizing:border-box}
        html,body{height:100%}

        body{
            margin:0;
            font-family:'Poppins', system-ui, Segoe UI, Roboto, Arial;
            color:var(--text);
            display:flex;
            align-items:center;
            justify-content:center;
            padding:24px;
            background-color:#f7e3a6; 
            background-image:
                linear-gradient(to bottom, rgba(247,227,166,.85), rgba(247,227,166,.85)),
                url('gadget-bg.png');
            background-position:center center;
            background-repeat:no-repeat;
            background-size:cover;
            background-attachment:fixed;
        }

        .card{
            width:100%;
            max-width:460px;
            background:var(--card);
            border-radius:var(--radius);
            box-shadow:var(--shadow);
            padding:28px 28px 30px;
            border:1px solid rgba(0,0,0,.08);
            backdrop-filter: blur(4px);
        }

        .brand{
            display:flex; flex-direction:column; align-items:center; justify-content:center;
            gap:10px; margin-bottom:12px;
        }
        .brand img{ width:110px; height:110px; object-fit:contain; }
        .brand h1{ margin:0; font-size:1.9rem; font-weight:800; color:var(--brand); letter-spacing:.3px; }

        .subtitle{
            text-align:center; margin:0 0 18px 0; font-size:.95rem; color:#555;
        }

        label{ display:block; margin:12px 0 6px; font-weight:600; }
        .textbox{
            width:100%; padding:12px;
            border:1px solid #cfcfcf; border-radius:12px; background:#fff; font-size:1rem; outline:none;
            transition:border-color .2s, box-shadow .2s;
        }
        .textbox:focus{
            border-color:var(--accent);
            box-shadow:0 0 0 4px rgba(247,227,166,.35);
        }

        .login-button{
            width:100%; margin-top:14px; padding:12px 16px;
            border:none; border-radius:12px; background:var(--accent); color:var(--brand);
            font-weight:700; font-size:1rem; cursor:pointer; transition:background .2s, transform .02s;
        }
        .login-button:hover{ background:var(--accent-strong); }
        .login-button:active{ transform:translateY(1px); }

        #lblMessage{
            display:block; margin:6px 0 2px; color:#d32f2f; font-weight:600; text-align:center;
        }

        .footer{
            margin-top:14px; text-align:center; font-size:.95rem;
        }
        .footer a{
            color:var(--brand); font-weight:700; text-decoration:none;
        }
        .footer a:hover{ text-decoration:underline; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card" role="main" aria-label="Distributor login form">
            <div class="brand">
                <img src="logo.png" alt="Gadget Hub logo" />
                <h1>Distributor Portal</h1>
            </div>
            <p class="subtitle">Sign in to manage quotations and fulfill orders</p>

            <asp:Label ID="lblMessage" runat="server" />

            <label for="txtDistributorName">Distributor Name</label>
            <asp:TextBox ID="txtDistributorName" runat="server" CssClass="textbox" placeholder="Enter your distributor name" />

            <label for="txtPassword">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="textbox" placeholder="Enter your password" />

            <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="login-button" OnClick="btnLogin_Click" />

            
        </div>
    </form>
</body>
</html>
