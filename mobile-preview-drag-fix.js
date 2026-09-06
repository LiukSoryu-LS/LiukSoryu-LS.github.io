(function(){
  var params=new URLSearchParams(location.search);
  if(!params.has('mobile-preview')) return;
  function init(){
    var games=document.querySelector('.games');
    if(!games || games.dataset.dragFix==='v3') return;
    games.dataset.dragFix='v3';
    games.style.cursor='grab';
    games.style.userSelect='none';
    games.style.webkitUserSelect='none';
    games.style.touchAction='pan-x';
    var dragging=false, moved=false, startX=0, startScroll=0;
    games.addEventListener('mousedown',function(e){
      if(e.button!==0) return;
      dragging=true; moved=false; startX=e.clientX; startScroll=games.scrollLeft;
      games.style.cursor='grabbing';
    });
    window.addEventListener('mousemove',function(e){
      if(!dragging) return;
      var dx=e.clientX-startX;
      if(Math.abs(dx)>3) moved=true;
      if(moved) games.scrollLeft=startScroll-dx;
      if(moved) e.preventDefault();
    },true);
    window.addEventListener('mouseup',function(){
      dragging=false;
      games.style.cursor='grab';
    },true);
    games.addEventListener('dragstart',function(e){e.preventDefault();},true);
    games.addEventListener('click',function(e){
      if(moved){ e.preventDefault(); e.stopImmediatePropagation(); moved=false; }
    },true);
  }
  if(document.readyState==='loading') document.addEventListener('DOMContentLoaded',init,{once:true}); else init();
})();
