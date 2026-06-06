<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Club Detail - PadelApp</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            .border-grid { border-color: #e5e5e5; }
            .brutalist-shadow { box-shadow: 8px 8px 0px 0px rgba(0,0,0,1); }
        </style>
    </head>
    <body class="bg-gray-50 text-black min-h-screen flex flex-col">

        <header class="flex justify-between items-center p-4 md:p-6 border-b-4 border-black bg-white sticky top-0 z-50">
            <h1 class="text-xl font-black tracking-tighter uppercase md:text-2xl">
                Padel<span class="text-blue-400">App</span>
            </h1>
            <a href="MySquadController" class="text-xs font-bold uppercase tracking-widest bg-black text-white px-4 py-2 hover:bg-blue-400 hover:text-black transition-colors border-2 border-black">
                ← Back
            </a>
        </header>

        <%
            java.util.Map<String, Object> club = (java.util.Map<String, Object>) request.getAttribute("clubData");
            java.util.List<String> memberList = (java.util.List<String>) request.getAttribute("members");
            
            if (club != null) {
        %>
        <div class="bg-white border-b-4 border-black p-8 md:p-16 flex flex-col md:flex-row items-center justify-between">
            <div>
                <span class="bg-blue-400 text-[10px] font-black px-2 py-1 border-2 border-black uppercase tracking-widest"><%= club.get("status") %> CLUB</span>
                <h1 class="text-5xl md:text-7xl font-black uppercase tracking-tighter mt-4 mb-2"><%= club.get("name") %></h1>
                <p class="text-xs font-bold uppercase opacity-50 tracking-widest mt-2">FOUNDED BY <%= club.get("creator") %></p>
            </div>
            <div class="mt-8 md:mt-0 flex flex-col gap-4 w-full md:w-auto">
                <a href="BookingController" class="text-center bg-lime-400 text-black border-4 border-black px-8 py-4 font-black uppercase text-sm brutalist-shadow hover:translate-y-1 hover:translate-x-1 hover:shadow-none transition-all block">
                    Book Arena
                </a>
                <a href="LeaveController?club_id=<%= club.get("club_id") %>" class="text-center bg-white text-red-500 border-4 border-black px-8 py-4 font-black uppercase text-sm hover:bg-red-500 hover:text-white transition-all block">
                    Leave Club X
                </a>
            </div>
        </div>

        <main class="flex flex-col lg:flex-row flex-1 p-8 md:p-12 gap-12 max-w-7xl mx-auto w-full">
            
            <div class="w-full lg:w-2/3 flex flex-col gap-8">
                <div class="bg-yellow-100 border-4 border-black p-6 relative">
                    <h3 class="text-xl font-black uppercase mb-2">Description</h3>
                    <p class="text-sm font-bold uppercase leading-relaxed text-gray-700">
                        <%= club.get("description") %> 
                    </p>
                </div>

                <div>
                    <h4 class="text-2xl font-black uppercase tracking-tighter mb-4 border-b-4 border-black pb-2">Next Match</h4>
                    <div class="bg-white border-4 border-black p-6 flex flex-col md:flex-row justify-between items-center">
                        <h5 class="text-lg font-black uppercase"><%= club.get("next_match") %></h5>
                        <a href="BookingController" class="mt-4 md:mt-0 bg-black text-white px-6 py-2 font-bold uppercase text-xs border-2 border-black hover:bg-blue-400 hover:text-black transition-colors">
                            Join Match
                        </a>
                    </div>
                </div>
            </div>

            <div class="w-full lg:w-1/3 flex flex-col gap-8">
                <div class="bg-white border-4 border-black p-6">
                    <h4 class="text-xl font-black uppercase border-b-2 border-black pb-2 mb-4">Club Stats</h4>
                    <div class="mb-4">
                        <label class="text-[10px] font-bold uppercase opacity-50">Admin</label>
                        <p class="font-black uppercase"><%= club.get("contact") %></p>
                    </div>
                    <div>
                        <label class="text-[10px] font-bold uppercase opacity-50">Quota</label>
                        <p class="font-black uppercase"><%= club.get("quota") %></p>
                    </div>
                </div>

                <div class="bg-gray-100 border-4 border-black p-6">
                    <h4 class="text-xl font-black uppercase mb-4 border-b-2 border-black pb-2">r</h4>
                    <ul class="text-sm font-bold space-y-2 uppercase">
                        <% if (memberList != null && !memberList.isEmpty()) { 
                               for (String memberName : memberList) { %>
                            <li class="flex items-center gap-2">
                                <span class="w-2 h-2 bg-black"></span> <%= memberName %>
                            </li>
                        <%     }
                           } else { %>
                            <li class="opacity-50 italic">No members yet.</li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </main>
        <% } %>

        <footer class="p-6 border-t-4 border-black bg-white mt-auto text-center text-[10px] font-black uppercase">
            © 2026 PadelApp - All Rights Reserved
        </footer>
    </body>
</html>