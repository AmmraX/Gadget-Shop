# The Gadget Hub

## 📖 Overview
[cite_start]The Gadget Hub is a service-oriented application designed for a retail chain of gadgets operating on a distributed supply chain model[cite: 2729]. [cite_start]The company does not hold its own inventory; instead, it relies on real-time communications with external distributors (TechWorld, ElectroCom, and Gadget Central)[cite: 2729, 2730]. [cite_start]This system automates the process of requesting quotations from these partners, comparing prices, and finalizing orders[cite: 2730, 2740].

## ✨ Features
* [cite_start]**Client Portal:** Allows customers to register, log in, browse the product catalog, add items to their cart, and place orders[cite: 3146, 3165, 3181, 3182].
* [cite_start]**Distributor Portal:** Provides a secure login and dashboard for distributors to view orders awaiting quotations and submit their proposed price and delivery time[cite: 3218, 3219, 3235, 3236].
* [cite_start]**Admin Dashboard:** Offers centralized control for administrators to view all orders, monitor distributor quotations, manage the product catalog, and cancel orders if necessary[cite: 3273].
* **Automated Quotation Comparison:** The system automatically evaluates distributor responses, selecting the quotation with the lowest price. [cite_start]In the event of a tie, it breaks the tie by choosing the shortest delivery time[cite: 4109, 4110].
* [cite_start]**Role-Based Access Control:** Ensures that clients, distributors, and admins are restricted to their respective portals and dashboards[cite: 4186]. 

## 🛠️ Technology Stack
[cite_start]The application is built using a Simplified 3-Layer Service-Oriented Architecture (SOA)[cite: 3066, 3139]:
* [cite_start]**Client Layer (Front-End):** ASP.NET Web Forms[cite: 3139, 3495].
* [cite_start]**Service Layer (API):** ASP.NET Web API (C#) acting as the focal point for business processing[cite: 3089, 3091, 3139].
* [cite_start]**Database Layer:** SQL Server managed with Entity Framework Code First[cite: 3116, 3139].

## 🏗️ Architecture & Services
[cite_start]The system is broken down into loosely coupled services communicating via APIs to ensure high scalability and maintainability[cite: 2767, 2768, 2791]. Key services include:
* [cite_start]**Customer Service:** Handles registration and user profile setup[cite: 2772].
* [cite_start]**Order Service:** Manages shopping carts and order processing[cite: 2774].
* [cite_start]**Quotation Service:** Gathers, compares, and selects the best distributor prices[cite: 2776, 3105, 3109].
* [cite_start]**Distributor Services:** Individual integration microservices for third-party partners[cite: 2779, 2780].

## 🚀 Recommended Deployment Strategy
[cite_start]To meet the high-performance and scalable needs of the platform, the recommended deployment utilizes Hybrid Cloud and Containerization[cite: 4249]:
* [cite_start]**Containerization & Orchestration:** Docker for packaging services and Azure Kubernetes Service (AKS) for automated scaling[cite: 4252, 4258].
* [cite_start]**Cloud Hosting:** Azure App Service for the client application and Azure SQL Database for reliable data storage[cite: 4259, 4261].
* [cite_start]**Security:** Azure API Management for the gateway and Azure Key Vault for securing credentials[cite: 4260, 4265].
