<%-- 
    Document   : store_rent
    Created on : 5 May 2026, 13.47.13
    Author     : Faizul Afiat
--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shop & Rent - PadelApp</title>
        <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <header class="flex border-b border-grid bg-white sticky top-0 z-50">
            <div class="p-4 md:p-6 border-r border-grid w-1/2 md:w-1/4">
                <h1 class="text-xl font-black tracking-tighter uppercase md:text-2xl">Padel<span class="text-blue-400">App</span></h1>
            </div>
            <div class="flex-1 border-r border-grid hidden md:flex items-center px-8">
                <a href="../index.jsp" class="text-xs font-bold uppercase tracking-widest hover:underline">← Back to Dashboard</a>
            </div>
            <div class="p-4 md:p-6 w-1/2 md:w-1/4 flex items-center justify-end gap-4">
                <span class="text-[10px] font-bold uppercase tracking-widest">
                    <%= session.getAttribute("user")%>
                </span>
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-5 h-5">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z" />
                </svg>
            </div>
        </header>
    <div class="min-h-screen bg-gray-50 p-6 pb-24">
        <!-- Header -->
        <div class="max-w-6xl mx-auto mb-10">
            <h1 class="text-5xl font-black uppercase tracking-tighter italic">Pro Shop <span class="text-cyan-500">&</span> Rentals</h1>
            <p class="text-gray-400 font-bold uppercase text-xs tracking-widest mt-2">Equip yourself with the best gear</p>
        </div>

        <div class="max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-6">
            <c:forEach var="product" items="${productList}">
                <div class="bg-white border-4 border-black rounded-[2.5rem] p-6 flex flex-col shadow-[8px_8px_0px_0px_rgba(0,0,0,1)] group h-fit">
                    <div class="w-full h-full bg-gray-100 rounded-2xl overflow-hidden mb-4">
                        <img src="${pageContext.request.contextPath}/assets/images/${product.image}" 
                             alt="${product.name}" 
                             class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300">
                    </div>

                    <div class="flex-1">
                        <span class="text-[10px] font-black uppercase opacity-50">${product.type}</span>
                        <h3 class="font-black uppercase italic text-xl leading-tight">${product.name}</h3>
                        <p class="font-black text-cyan-600 mt-1">Rp ${product.price}</p>
                    </div>

                    <button class="mt-6 w-full bg-black text-white py-3 rounded-xl font-black uppercase text-xs">
                        ${product.type == 'Rent' ? 'Rent Now' : 'Add to Cart'}
                    </button>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
