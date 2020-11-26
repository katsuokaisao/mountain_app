'user strict'

// 無限スクロール
$(function() {
  $('.jscroll').jscroll({
    nextSelector: 'a.next',
    contentSelector: '.jscroll', 
    loadingHtml: '読み込み中',
    padding: 50
  });
});

// dropdownが開かれていない状態でdropdownTriggerをクリックすればdropdownが開く
// dropdownが開いているならdropdownTriggerをもう一度クリックするかdropdownTrigger以外をクリックしても
// dropdownが閉じる

document.addEventListener("DOMContentLoaded", function(){
  const dropdownTrigger = document.getElementsByClassName('dropdown-trigger')[0];
  const dropdown = document.getElementById('dropdown');
  dropdownTrigger.addEventListener('click', function() {
    if(!dropdown.classList.contains('is-active')) {
      dropdown.classList.add('is-active');
    } else {
      dropdown.classList.remove('is-active');
    }
    document.addEventListener('click', (e)=> {
      const clickLocation = e.target;
      if (!clickLocation.classList.contains('dropdown-trigger') && dropdown.classList.contains('is-active')) {
        dropdown.classList.remove('is-active');
      }
    })
  });
}, false);

document.addEventListener('DOMContentLoaded', function(){
  const modal = document.getElementById('modal')
  if (modal !== null) {
    modal.addEventListener('click', showModal);
    const modalElement = document.getElementsByClassName('modal')[0];
    function showModal() {
      modalElement.classList.add('active');
    }
    document.addEventListener('click', (ev) => {
      if (modalElement.classList.contains('active') && !ev.target.classList.contains('fas') ) {
        console.log(ev.target);
        console.log(ev.target.classList);
        modalElement.classList.remove('active');
      }
    })  
  }
})

// 複数画像のプレビュー機能
document.addEventListener('DOMContentLoaded', function(){
  document.getElementById('image-up').addEventListener('change', function(e) {
    // console.log(e);
    // console.log(e.target);
    // console.log(e.target.files);
    // console.log(e.target.files.length);
    for(let i = 0; i < e.target.files.length; i++) {
      const file = e.target.files[i];
      const reader = new FileReader();
      const preview = document.getElementById('preview');
      const previewImage = document.getElementById('previewImage');
      if (previewImage != null) {
        preview.removeChild(previewImage);
      }
      // onloadは、FileReaderのイベントです。データの読み込みが正常に完了した時にloadイベントが発生し、ここに設定したコールバック関数が呼び出されます。
      reader.onload = function(event) {
        const img = document.createElement('img');
        img.setAttribute('src', reader.result);
        img.setAttribute('id',  'previewImage');
        preview.appendChild(img);
      }
      reader.readAsDataURL(file);
    }
  })
});


// フォロー・フォロワーリストのtab
// {
//   const tabs = document.getElementsByClassName('user-tab');
//   for(let i = 0; i < tabs.length; i++ ) {
//     tabs[i].addEventListener('click', (e)=> {
//       e.preventDefault();
//       const currentTab = e.currentTarget;
//       for(let i = 0; i < tabs.length;  i++) {
//         tabs[i].classList.remove('is-active');
//       }
//       currentTab.classList.add('is-active');
//     });
//   }
// }

// const images = document.getElementById('daily_images');
// images.addEventListener('click', ()=> {
//   for(i=0; i<images.files.length; i++) {
//     const size_in_megabytes = this.files[i].size/1024/1024;
//     if (size_in_megabytes > 5) {
//       alert("最大5MBまでです。");
//       images.value = "";
//     }
//   }
// });