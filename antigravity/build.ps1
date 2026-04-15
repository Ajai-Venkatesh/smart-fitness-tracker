$files = @("index.html", "profile-setup.html", "step-02.html", "analyzing.html", "dashboard.html", "workout.html", "push-day.html", "diet.html", "profile.html")
$out = "app.html"

$head = @"
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>NutriMuscles | High-Performance App</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Epilogue:ital,wght@0,400;0,700;0,800;0,900;1,100..900&family=Inter:wght@400;500;600&family=Space+Grotesk:wght@300;400;500;600;700&family=Bebas+Neue&family=Rajdhani:wght@400;500;600;700&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&display=swap" rel="stylesheet"/>
<script>
tailwind.config = {
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        "primary": "#f8ffb8",
        "primary-fixed": "#e1f800",
        "primary-container": "#e1f800",
        "on-primary-fixed": "#414900",
        "on-primary-container": "#535c00",
        "secondary": "#00eefc",
        "secondary-fixed": "#00eefc",
        "secondary-container": "#006970",
        "tertiary": "#ff6b98",
        "tertiary-container": "#fc0078",
        "error": "#ff7351",
        "error-container": "#b92902",
        "background": "#0e0e13",
        "surface": "#0e0e13",
        "surface-container": "#19191f",
        "surface-container-low": "#131319",
        "surface-container-high": "#1f1f26",
        "surface-container-highest": "#25252d",
        "surface-container-lowest": "#000000",
        "on-background": "#f9f5fd",
        "on-surface": "#f9f5fd",
        "on-surface-variant": "#acaab1",
        "outline": "#76747b",
        "outline-variant": "#48474d"
      },
      fontFamily: {
        "headline": ["Epilogue"],
        "body": ["Inter"],
        "label": ["Space Grotesk"],
        "bebas": ["Bebas Neue"],
        "rajdhani": ["Rajdhani"],
        "mono": ["Space Mono"],
        "mono-tech": ["Space Mono"]
      }
    }
  }
}
</script>
<style>
  .technical-grid {
      background-image: radial-gradient(circle at 1px 1px, rgba(225, 248, 0, 0.03) 1px, transparent 0);
      background-size: 20px 20px;
  }
  .material-symbols-outlined {
      font-family: 'Material Symbols Outlined' !important;
      font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
  }
  body { min-height: max(884px, 100dvh); }
  .no-scrollbar::-webkit-scrollbar { display: none; }
  .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
  .glow-primary { box-shadow: 0 0 24px rgba(225, 248, 0, 0.1); }
  .active .text-outline { color: #e1f800 !important; font-weight: bold; }
  #activity-group .active span { color: #e1f800 !important; font-variation-settings: 'FILL' 1 !important; }
</style>
</head>
<body class="bg-background text-on-surface font-body technical-grid min-h-screen selection:bg-primary-container selection:text-black overflow-x-hidden">
<div id="app-root" class="relative min-h-screen w-full pb-20"></div>

<!-- Global AI Integration Component -->
<button id="ai-fab" class="fixed bottom-24 right-5 w-14 h-14 bg-primary-fixed rounded-none shadow-[0_0_20px_rgba(225,248,0,0.4)] z-[100] flex items-center justify-center hover:scale-105 active:scale-95 transition-all group overflow-hidden border-2 border-primary-fixed cursor-pointer">
  <div class="absolute inset-0 bg-white/20 opacity-0 group-hover:opacity-100 transition-opacity"></div>
  <span class="material-symbols-outlined text-[#0e0e13] text-3xl animate-pulse" data-icon="smart_toy">smart_toy</span>
</button>

<div id="ai-drawer" class="fixed right-0 top-0 h-screen w-full sm:w-[400px] bg-[#101016] border-l border-outline-variant/30 shadow-[0_0_50px_rgba(0,0,0,0.9)] z-[150] transform translate-x-full transition-transform duration-300 flex flex-col">
  <div class="h-20 border-b border-[#e1f800]/20 bg-[#000000] flex items-center justify-between px-6 shrink-0 shadow-md">
    <div class="flex items-center gap-3">
      <span class="material-symbols-outlined text-primary-fixed text-2xl">memory</span>
      <div>
        <h3 class="font-headline font-black text-lg tracking-widest text-primary-fixed leading-none">NUTRIMUSCLES AI</h3>
        <p class="font-mono-tech text-[10px] text-on-surface-variant uppercase tracking-widest">Neural Link Established</p>
      </div>
    </div>
    <button id="ai-close" class="text-on-surface-variant hover:text-white transition-colors cursor-pointer p-2">
      <span class="material-symbols-outlined hover:rotate-90 transition-transform">close</span>
    </button>
  </div>
  
  <div id="ai-chat-history" class="flex-1 overflow-y-auto p-6 space-y-6 flex flex-col pb-10 scroll-smooth custom-scrollbar relative">
    <div class="absolute inset-0 bg-gradient-to-b from-[#e1f800]/5 to-transparent pointer-events-none opacity-20"></div>
  </div>
  
  <div class="p-4 bg-[#000000] border-t border-[#e1f800]/10 shrink-0">
    <div class="bg-surface-container-high focus-within:ring-1 focus-within:ring-[#e1f800] border border-outline-variant/30 flex items-center p-2 transition-all">
      <input type="text" id="ai-input" class="w-full bg-transparent border-none text-white font-body text-sm focus:ring-0 placeholder:text-outline outline-none px-2" placeholder="Ask AI about macros, recipes...">
      <button id="ai-send" class="w-10 h-10 shrink-0 flex items-center justify-center bg-[#e1f800]/10 text-primary-fixed hover:bg-[#e1f800] hover:text-[#0e0e13] transition-colors ml-2 cursor-pointer shadow-none">
        <span class="material-symbols-outlined font-bold text-[20px]">send</span>
      </button>
    </div>
  </div>
</div>
"@

[IO.File]::WriteAllText("$(Get-Location)\$out", $head, [System.Text.Encoding]::UTF8)

# Inject Food Database
$csvPath = "C:\Users\HP\Desktop\projects\archive\Food and Calories - Sheet1.csv"
if (Test-Path $csvPath) {
    try {
        $csvObj = Import-Csv $csvPath | ConvertTo-Json -Compress
        $csvSnippet = "`n<script>window.FOOD_DATABASE = $csvObj;</script>`n"
        [IO.File]::AppendAllText("$(Get-Location)\$out", $csvSnippet, [System.Text.Encoding]::UTF8)
    } catch {
        Write-Host "Warning: CSV dataset compression failed."
    }
}

foreach ($f in $files) {
    if (Test-Path $f) {
        $content = [IO.File]::ReadAllText("$(Get-Location)\$f")
        $bodyStart = $content.IndexOf("<body")
        $bodyEnd = $content.IndexOf("</body>")
        if ($bodyStart -ge 0 -and $bodyEnd -ge 0) {
            $bodyStart = $content.IndexOf(">", $bodyStart) + 1
            $bodyContent = $content.Substring($bodyStart, $bodyEnd - $bodyStart)
            $id = $f.Replace(".html", "")
            $template = "`n`n<template id='page-$id'>$bodyContent</template>"
            [IO.File]::AppendAllText("$(Get-Location)\$out", $template, [System.Text.Encoding]::UTF8)
        }
    }
}

$script = @"

<script>
function render(pageId) {
    const root = document.getElementById("app-root");
    const tpl = document.getElementById("page-" + pageId);
    if (!tpl) return;
    
    // Add a simple fade transition effect
    root.style.opacity = '0';
    setTimeout(() => {
        root.innerHTML = tpl.innerHTML;
        window.scrollTo(0, 0);
        root.style.transition = 'opacity 0.2s';
        root.style.opacity = '1';
        
        // Wire up all navigation links dynamically
        root.querySelectorAll("a").forEach(a => {
            a.onclick = (e) => {
                const href = a.getAttribute("href");
                if (href && href !== "#" && href.endsWith(".html")) {
                    e.preventDefault();
                    let p = href.replace(".html", "");
                    render(p);
                }
            };
        });

        // Specific actions for the Analyzing screen
        if (pageId === "analyzing") {
            setTimeout(() => { render("dashboard"); }, 4000);
        }

        // --- INTERACTIVE FORM LOGIC ---
        function bindRadioGroup(groupId, activeClasses, inactiveClasses) {
            const group = root.querySelector('#' + groupId);
            if (!group) return;
            const items = group.children;
            Array.from(items).forEach(item => {
                item.style.cursor = 'pointer';
                item.onclick = () => {
                    Array.from(items).forEach(i => {
                        i.classList.remove(...activeClasses.split(' ').filter(Boolean), 'active');
                        i.classList.add(...inactiveClasses.split(' ').filter(Boolean));
                    });
                    item.classList.remove(...inactiveClasses.split(' ').filter(Boolean));
                    item.classList.add(...activeClasses.split(' ').filter(Boolean), 'active');
                };
            });
        }

        // Apply Mathematical Models
        function refreshMetrics(pid) {
            if (!window.APP_STATE) return;
            const { age, weight, height, gender, activity, goal } = window.APP_STATE;
            if (!age || !weight || !height) return;
            
            let bmr = (10 * weight) + (6.25 * height) - (5 * age);
            bmr += (gender === 'MALE') ? 5 : -161;
            
            let multiplier = 1.2;
            if (activity === 'Light') multiplier = 1.375;
            if (activity === 'Moderate') multiplier = 1.55;
            if (activity === 'Very Active') multiplier = 1.725;
            if (activity === 'Extreme') multiplier = 1.9;
            
            let tdee = Math.round(bmr * multiplier);
            
            let target = tdee;
            if (goal === 'Fat Loss') target -= 500;
            if (goal === 'Muscle Gain') target += 300;
            
            let protein = Math.round(weight * 2.2);
            let fat = Math.round((target * 0.25) / 9);
            let carbs = Math.round((target - (protein * 4) - (fat * 9)) / 4);
            
            const setInner = (id, val) => {
                const el = root.querySelector('#' + id);
                if (el) el.innerHTML = val;
            };
            const fmt = num => num.toLocaleString();

            if (pid === "dashboard") {
                setInner('val-dash-cals', fmt(target));
                setInner('val-dash-protein', protein);
                setInner('val-dash-carbs', carbs);
                setInner('val-dash-fat', fat);
            }
            if (pid === "diet") {
                setInner('val-diet-cals', fmt(target));
                setInner('val-diet-protein', protein + 'G');
                setInner('val-diet-total-cals', fmt(target) + ' KCAL');
                setInner('val-diet-total-protein', protein + 'G PROTEIN');
            }
            if (pid === "analyzing") {
                setInner('val-analyze-cals', fmt(target) + ' kcal');
                setInner('val-analyze-macros', protein + 'g / ' + carbs + 'g / ' + fat + 'g');
            }
            if (pid === "profile") {
                setInner('val-profile-cals', fmt(target) + ' kcal');
                setInner('val-profile-protein', protein + 'g');
            }
        }
        
        refreshMetrics(pageId);

        if (pageId === "profile-setup") {
            bindRadioGroup("gender-group", "bg-primary-fixed text-on-primary-fixed border-primary-fixed", "bg-transparent text-on-surface-variant border-outline-variant hover:border-primary-fixed/50");
			
            const btnNext = root.querySelector('#btn-profile-next');
            if (btnNext) {
                btnNext.onclick = (e) => {
                    const ageEl = root.querySelector('#val-age');
                    const weightEl = root.querySelector('#val-weight');
                    const heightEl = root.querySelector('#val-height');
                    
                    if(ageEl && ageEl.value) window.APP_STATE.age = parseInt(ageEl.value);
                    if(weightEl && weightEl.value) window.APP_STATE.weight = parseInt(weightEl.value);
                    if(heightEl && heightEl.value) window.APP_STATE.height = parseInt(heightEl.value);
                    
                    const activeGender = root.querySelector('#gender-group .active');
                    if (activeGender) window.APP_STATE.gender = activeGender.textContent.trim();
                    
                    e.preventDefault();
                    render("step-02");
                };
            }
			
            const bfSlider = root.querySelector('#bf-slider');
            const bfText = root.querySelector('#bf-text');
            if (bfSlider && bfText) {
                bfSlider.oninput = (e) => { bfText.textContent = e.target.value + '%'; };
            }
        }
        if (pageId === "step-02") {
            const btnGenerate = root.querySelector('#btn-generate-plan');
            if (btnGenerate) {
                btnGenerate.onclick = (e) => {
                    const activeActivity = root.querySelector('#activity-group .active span:last-child');
                    if (activeActivity) window.APP_STATE.activity = activeActivity.textContent.trim();
                    
                    const activeGoal = root.querySelector('#goal-group .active h3');
                    if (activeGoal) window.APP_STATE.goal = activeGoal.textContent.trim();
                    
                    e.preventDefault();
                    render("analyzing");
                };
            }

            bindRadioGroup("activity-group", "border-primary-fixed ring-1 ring-primary-fixed/20", "border-transparent");
            bindRadioGroup("goal-group", "bg-surface-container-high ring-1 ring-white/20", "bg-surface-container");
            bindRadioGroup("level-group", "bg-primary-fixed text-on-primary-fixed shadow-[0_0_15px_rgba(225,248,0,0.3)]", "text-outline hover:bg-surface-container-high");
			
            const dietBtn = root.querySelector('#diet-pref-btn');
            const dietText = root.querySelector('#diet-pref-text');
            if (dietBtn && dietText) {
                const diets = ['Standard', 'Vegetarian', 'Vegan', 'Keto', 'Paleo'];
                let currentDietIndex = 0;
                dietBtn.onclick = () => {
                    currentDietIndex = (currentDietIndex + 1) % diets.length;
                    dietText.textContent = diets[currentDietIndex];
                };
            }

            const btnMinus = root.querySelector('#btn-days-minus');
            const btnPlus = root.querySelector('#btn-days-plus');
            const textDays = root.querySelector('#text-days-count');
            if (btnMinus && btnPlus && textDays) {
                let days = parseInt(textDays.textContent) || 5;
                btnMinus.onclick = () => {
                    if (days > 1) { days--; textDays.textContent = days; }
                };
                btnPlus.onclick = () => {
                    if (days < 7) { days++; textDays.textContent = days; }
                };
            }
        }
        
        if (pageId === "diet") {
            const searchInput = root.querySelector('#food-search-input');
            const searchResults = root.querySelector('#food-search-results');
            if (searchInput && searchResults && window.FOOD_DATABASE) {
                searchInput.addEventListener('input', (e) => {
                    const val = e.target.value.toLowerCase().trim();
                    if (!val) {
                        searchResults.classList.add('hidden');
                        searchResults.innerHTML = '';
                        return;
                    }
                    const hits = window.FOOD_DATABASE.filter(item => 
                        item.Food && item.Food.toLowerCase().includes(val)
                    ).slice(0, 20);
                    
                    if (hits.length === 0) {
                        searchResults.innerHTML = '<div class="p-6 text-outline text-sm text-center tracking-widest uppercase">No verified data block found.</div>';
                    } else {
                        searchResults.innerHTML = hits.map(h => 
                            '<div class="px-5 py-4 border-b border-outline-variant/20 hover:bg-surface-container-high cursor-pointer flex justify-between items-center group transition-all active:scale-[0.98]">' +
                                '<div>' +
                                    '<div class="text-on-surface font-semibold text-sm tracking-wide group-hover:text-secondary-fixed transition-colors">' + h.Food + '</div>' +
                                    '<div class="text-outline text-[10px] uppercase font-mono-tech mt-1 tracking-widest">' + h.Serving + '</div>' +
                                '</div>' +
                                '<div class="font-headline font-black text-xl text-error tracking-tighter drop-shadow-[0_0_5px_rgba(255,115,81,0.2)]">' + h.Calories + '</div>' +
                            '</div>'
                        ).join('');
                    }
                    searchResults.classList.remove('hidden');
                });
            }
        }

    }, 50);
}

// Initialize App State defaults based on design
window.APP_STATE = window.APP_STATE || { 
    age: 25, weight: 75, height: 175, gender: 'MALE', activity: 'Moderate', goal: 'Muscle Gain' 
};

// Start with the splash screen
render("index");

// Global AI Initialization
function initAI() {
    const fab = document.getElementById('ai-fab');
    const drawer = document.getElementById('ai-drawer');
    const closeBtn = document.getElementById('ai-close');
    const chatHistory = document.getElementById('ai-chat-history');
    const input = document.getElementById('ai-input');
    const sendBtn = document.getElementById('ai-send');

    if (!fab) return;

    function toggleDrawer() {
        drawer.classList.toggle('translate-x-full');
        if (!drawer.classList.contains('translate-x-full') && chatHistory.children.length === 0) {
            const state = window.APP_STATE || {};
            const goal = state.goal ? state.goal.toUpperCase() : "OPTIMIZATION";
            appendMessage('ai', "Neural link active. I am currently synthesizing models for your **" + goal + "** progression metric. How can I optimize your protocols today?");
        }
    }

    fab.onclick = toggleDrawer;
    closeBtn.onclick = toggleDrawer;

    function appendMessage(sender, text) {
        const div = document.createElement('div');
        div.className = sender === 'user' ? 'flex justify-end z-10' : 'flex justify-start z-10';
        
        const bubble = document.createElement('div');
        bubble.className = sender === 'user' 
            ? 'bg-primary-fixed text-[#0e0e13] p-4 max-w-[85%] font-body text-sm font-semibold border-none'
            : 'bg-surface-container-highest text-on-surface p-4 max-w-[85%] font-body text-sm border-l-4 border-l-[#e1f800]';
            
        bubble.innerHTML = text.replace(/\*\*(.*?)\*\*/g, '<span class="font-bold text-[#e1f800] tracking-wide">$1</span>');
        if (sender === 'user') bubble.innerHTML = text; // Safe raw text for user
        
        div.appendChild(bubble);
        chatHistory.appendChild(div);
        chatHistory.scrollTop = chatHistory.scrollHeight;
    }

    function processAIResponse(msg) {
        const lower = msg.toLowerCase();
        let reply = "I have integrated that variable into your profile telemetry. Would you like me to scan your food database or adjust your training load limits?";
        
        if (lower.includes("protein") || lower.includes("macros") || lower.includes("diet")) {
            const p = document.getElementById("val-dash-protein") ? document.getElementById("val-dash-protein").innerHTML : "calculated";
            reply = "To satisfy the thermodynamic requirement of your goal, you MUST achieve a **" + p + "g protein** threshold daily. I strongly recommend prioritizing whey isolates post-workout or utilizing the Database Search block above.";
        } else if (lower.includes("tired") || lower.includes("fatigue") || lower.includes("sleep")) {
            reply = "Sustained fatigue is severely detrimental to muscular hypertrophy. I advise immediately substituting today's compound lifting session with **Zone 2 Active Recovery** and increasing your sleep feed casein by exactly 10g.";
        } else if (lower.includes("food") || lower.includes("eat") || lower.includes("calorie")) {
            const cals = document.getElementById("val-dash-cals") ? document.getElementById("val-dash-cals").innerHTML : "target";
            reply = "Engine limit set: **" + cals + " kcal**. Navigate to your NUTRITION tab. You are highly encouraged to parse any desired meal substitutions through the verified Live Data Scanner.";
        } else if (lower.includes("workout") || lower.includes("lift") || lower.includes("train")) {
            reply = "Your next queued sequence is **PUSH DAY (HYPERTROPHY)**. Physical load tolerances have been aggressively mapped to your previous cyclic performance. Execute.";
        }

        setTimeout(() => {
            const typing = document.getElementById('ai-typing');
            if(typing) typing.remove();
            appendMessage('ai', reply);
        }, 1100);
    }

    function handleSend() {
        const text = input.value.trim();
        if (!text) return;
        input.value = '';
        appendMessage('user', text);
        
        const typingDiv = document.createElement('div');
        typingDiv.id = 'ai-typing';
        typingDiv.className = 'flex justify-start z-10';
        typingDiv.innerHTML = '<div class="bg-surface-container text-outline px-4 py-3 font-mono-tech text-[10px] uppercase tracking-[0.2em] flex items-center gap-2">PROCESSING<span class="flex gap-1"><div class="w-1 h-1 bg-[#e1f800] rounded-full animate-bounce"></div><div class="w-1 h-1 bg-[#e1f800] rounded-full animate-bounce" style="animation-delay: 0.1s"></div><div class="w-1 h-1 bg-[#e1f800] rounded-full animate-bounce" style="animation-delay: 0.2s"></div></span></div>';
        chatHistory.appendChild(typingDiv);
        chatHistory.scrollTop = chatHistory.scrollHeight;

        processAIResponse(text);
    }

    sendBtn.onclick = handleSend;
    input.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') handleSend();
    });
}
initAI();
</script>
</body>
</html>
"@

[IO.File]::AppendAllText("$(Get-Location)\$out", $script, [System.Text.Encoding]::UTF8)
