# The Gadget Hub 🛒

## 📖 Overview
The Gadget Hub is a service-oriented web application designed for a modern gadget retail chain operating on a distributed supply chain model. Without holding its own inventory, the system seamlessly connects with external distributors (TechWorld, ElectroCom, and Gadget Central) in real-time to automate quotation requests, price comparisons, and order fulfillment.

## ✨ Features
* **Client Application:** Allows customers to securely register, log in, browse a dynamic product catalog, manage their shopping cart, and place orders.
* **Distributor Portal:** A dedicated interface for authorized distributors to view pending orders and submit competitive quotations (price and estimated delivery days).
* **Admin Dashboard:** Centralized control panel for administrators to monitor the entire order flow, view all quotations, approve or cancel orders, and manage the product catalog.
* **Automated Quotation Engine:** Automatically evaluates distributor responses to select the best quotation based on the lowest price, utilizing delivery speed as a tie-breaker.
* **Service-Oriented Architecture (SOA):** Highly modular system where authentication, order processing, and quotation management operate as independent, scalable services.

## 🛠️ Technology Stack
The application is built utilizing a simplified 3-layer Service-Oriented Architecture:
* **Client Layer (Front-End):** ASP.NET Web Forms
* **Service Layer (API):** ASP.NET Web API (C#)
* **Database Layer:** SQL Server with Entity Framework (Code First)

## 🚀 Getting Started

### Prerequisites
* [Visual Studio](https://visualstudio.microsoft.com/) (or compatible C# IDE)
* SQL Server
* .NET Framework

### Installation
1. Clone the repository:
   ```bash
   git clone [https://github.com/AmmraX/The-Gadget-Hub.git](https://github.com/AmmraX/The-Gadget-Hub.git)
2. Open the solution file (GadgetHubSolution.sln) in Visual Studio.
3. Configure your database connection string in the Web.config file to connect to your local SQL Server instance.
4. Run Entity Framework migrations to set up the database schema. Open the Package Manager Console and run:
   Update-Database
5. Build the solution and run the application.
