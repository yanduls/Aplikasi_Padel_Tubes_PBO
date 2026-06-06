<%-- 
    Document   : score
    Created on : 5 May 2026, 13.16.59
    Author     : Faizul Afiat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Score Counter - PadelApp</title>
        <script src="https://cdn.tailwindcss.com"></script></title>
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
    <div class="min-h-screen bg-gray-100 flex flex-col items-center p-6 pb-20">
        <div class="text-center mb-8">
            <h1 class="text-4xl font-black uppercase tracking-tighter">Live Match</h1>
            <div class="flex justify-center gap-4 mt-4">
                <div class="bg-black text-white px-4 py-2 rounded-full text-sm font-bold">
                    SET WIN: <span id="setA">0</span>
                </div>
                <div class="bg-white border-2 border-black px-4 py-2 rounded-full text-sm font-bold text-black">
                    SET WIN: <span id="setB">0</span>
                </div>
            </div>
        </div>

        <div class="flex flex-col md:flex-row gap-8 w-full max-w-4xl mb-12">
            <!-- Team A -->
            <div class="flex-1 bg-black text-white p-8 rounded-3xl shadow-2xl flex flex-col items-center">
                <span class="text-xs font-bold uppercase opacity-50 mb-4">Team A</span>
                <div id="scoreA" class="text-9xl font-black italic">0</div>
                <button onclick="addScore('A')" class="mt-8 w-full bg-cyan-400 text-black font-black py-4 rounded-xl hover:scale-105 transition-transform uppercase italic">+ Point</button>
            </div>

            <div class="flex-1 bg-white border-4 border-black p-8 rounded-3xl shadow-2xl flex flex-col items-center">
                <span class="text-xs font-bold uppercase opacity-40 mb-4">Team B</span>
                <div id="scoreB" class="text-9xl font-black italic text-black">0</div>
                <button onclick="addScore('B')" class="mt-8 w-full bg-black text-white font-black py-4 rounded-xl hover:scale-105 transition-transform uppercase italic">+ Point</button>
            </div>
        </div>

        <div class="w-full max-w-4xl bg-white border-4 border-black rounded-3xl p-8 shadow-[8px_8px_0px_0px_rgba(0,0,0,1)]">
            <div class="flex justify-between items-center mb-6">
                <h3 class="font-black uppercase italic text-2xl flex items-center gap-3">
                    <span class="bg-black text-white p-1 rounded">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M12 8v4l3 3"></path><circle cx="12" cy="12" r="10"></circle></svg>
                    </span>
                    Match History
                </h3>
                <span id="match-status" class="text-xs font-black bg-yellow-400 border-2 border-black px-3 py-1 rounded-full uppercase">In Progress</span>
            </div>

            <div id="historyList" class="space-y-4 max-h-[300px] overflow-y-auto pr-2 custom-scrollbar">
                <div class="text-center py-10 border-2 border-dashed border-gray-200 rounded-2xl">
                    <p class="text-gray-400 font-bold uppercase text-sm tracking-widest">Awaiting First Point...</p>
                </div>
            </div>
        </div>

        <button onclick="resetMatch()" class="mt-8 text-xs font-black uppercase tracking-widest border-b-2 border-black pb-1 hover:opacity-50 transition-opacity">Reset Total Match</button>
    </div>
</body>
</html>
<script>
            const points = ["0", "15", "30", "40", "GAME"];
            let teamAIdx = 0;
            let teamBIdx = 0;
            let setA = 0;
            let setB = 0;
            let history = [];
            function updateDisplay() {
            document.getElementById('scoreA').innerText  =  points[teamAIdx];
            document.getElementById('scoreB').innerText  =  points[teamBIdx];
            document.getElementById('setA').innerText  =  setA;
            document.getElementById('setB').innerText  =  setB;
            renderHistory();
            }

            function addScore(team) {
            if  (team ===  'A') {
            teamAIdx++;
            if  (points[teamAIdx] ===  "GAME") {
            setA++;
            addHistory("Team A wins a game");
            resetPoints();
            }
            }  else {
            teamBIdx++;
            if  (points[teamBIdx] ===  "GAME") {
            setB++;
            addHistory("Team B wins a game");
            resetPoints();
            }
            }
            updateDisplay();
            }

            function resetPoints() {
            teamAIdx  =  0;
            teamBIdx  =  0;
            }

            function addHistory(event) {
            const now  =  new  Date();
            const time  =  now.getHours().toString().padStart(2,  '0') +  ":" +
                    now.getMinutes().toString().padStart(2,  '0');

            // Simpan ke array history
            history.unshift({
            time: time,
                    event: event,
                    score: setA +  " - " +  setB
            });
            }

            function renderHistory() {
            const container  =  document.getElementById('historyList');
            if  (history.length ===  0) return;

            container.innerHTML  =  history.map((item,  index)  =>  `
        <div class="flex items-center gap-4 group">
            <div class="flex-none w-16 text-xs font-black text-gray-400">${item.time}</div>
            
            <div class="relative flex-1 bg-gray-50 border-2 border-black p-4 rounded-2xl flex justify-between items-center group-hover:bg-cyan-50 transition-colors">
                <!-- Dot Indicator -->
                <div class="absolute -left-[9px] w-4 h-4 bg-black rounded-full border-4 border-white"></div>
                
                <div class="flex flex-col">
                    <span class="text-[10px] font-black text-gray-400 uppercase">Set Event</span>
                    <span class="font-black uppercase italic ${item.event.includes('Team A') ? 'text-black' : 'text-gray-600'}">
    ${item.event}
                    </span>
                </div>
                
                <div class="flex items-center gap-3">
                    <div class="flex flex-col items-end">
                        <span class="text-[10px] font-black text-gray-400 uppercase">Current Set</span>
                        <span class="font-black text-xl tabular-nums">${item.score}</span>
                    </div>
                    <div class="bg-black text-cyan-400 p-2 rounded-lg font-black text-xs italic">
                        SET ${index + 1}
                    </div>
                </div>
            </div>
        </div>
    `).join('');
}

    function resetMatch() {
        if (confirm("Are you sure you want to reset the entire match?")) {
            setA = 0;
            setB = 0;
            history = [];
            resetPoints();
            document.getElementById('historyList').innerHTML = '<p class="text-gray-400 italic text-sm">No points recorded yet...</p>';
            updateDisplay();
        }
    }
</script>