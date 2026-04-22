<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClientRegister.aspx.cs" Inherits="GadgetHubClientAPP.ClientRegister" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Register - GadgetHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet" />
    <style>
        :root{
            --brand:#000000;           
            --brand-accent:#f7e3a6;   
            --text:#1f1f1f;
            --card:rgba(255,255,255,.95);
            --radius:16px;
            --shadow:0 20px 50px rgba(0,0,0,.14);
        }
        *{ box-sizing:border-box; }

        html, body { height: 100%; }
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

        .auth-card{
            width:100%;
            max-width: 480px;
            background:var(--card);
            border-radius:var(--radius);
            box-shadow:var(--shadow);
            padding:28px 28px 30px;
            backdrop-filter: blur(4px);
            border: 1px solid rgba(0,0,0,.08);   
        }

        .brand{
            display:flex;
            align-items:center;
            justify-content:center;
            gap:14px;
            margin-bottom:12px;
        }
        .brand img{
            width:100px;         
            height:100px;
            object-fit:contain;
        }
        .brand h1{
            margin:0;
            font-size:2rem;
            font-weight:800;
            color:var(--brand);
            letter-spacing:.3px;
        }

        .subtitle{
            text-align:center;
            margin:0 0 18px 0;
            font-size:.95rem;
            color:#555;
        }

        label{
            display:block;
            margin:12px 0 6px;
            font-weight:600;
        }
        .textbox{
            width:100%;
            padding:12px;
            border:1px solid #ccc;
            border-radius:12px;
            background:#fff;
            font-size:1rem;
            outline:none;
            transition:border-color .2s, box-shadow .2s;
        }
        .textbox:focus{
            border-color:var(--brand-accent);
            box-shadow:0 0 0 4px rgba(247,227,166,.35);
        }

        .register-button{
            width:100%;
            margin-top:14px;
            padding:12px 16px;
            border:none;
            border-radius:12px;
            background:var(--brand-accent);
            color:var(--brand);
            font-weight:700;
            font-size:1rem;
            cursor:pointer;
            transition:background .2s, transform .02s;
        }
        .register-button:hover{ background:#f5d87e; }
        .register-button:active{ transform:translateY(1px); }

        #lblMessage{
            display:block;
            margin:6px 0 2px;
            color:#d32f2f;
            font-weight:600;
            text-align:center;
        }

        .footer{
            text-align:center;
            margin-top:14px;
            font-size:.95rem;
        }
        .footer a{
            color:var(--brand);
            font-weight:700;
            text-decoration:none;
        }
        .footer a:hover{ text-decoration:underline; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-card" role="main" aria-label="Register form">
            <div class="brand">
                <img src="logo.png" alt="Gadget Hub logo" />
                <h1>Gadget Hub</h1>
            </div>
            <p class="subtitle">Create your account to start ordering and tracking gadgets</p>

            <asp:Label ID="lblMessage" runat="server" />

            <label for="txtUsername">Username</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="textbox" placeholder="Enter your username" />

            <label for="txtPassword">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="textbox" placeholder="Enter your password" />

            <label for="txtConfirmPassword">Confirm Password</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="textbox" placeholder="Re-enter your password" />

            <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="register-button" OnClick="btnRegister_Click" />

            <div class="footer">
                Already have an account? <a href="ClientLogin.aspx">Log in</a>
            </div>
        </div>
    </form>
</body>
</html>
