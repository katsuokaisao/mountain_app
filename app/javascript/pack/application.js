'user strict'

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

document.addEventListener('DOMContentLoaded', function(){
  const modal = document.getElementById('modal')
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
})

// document.addEventListener('DOMContentLoaded', function(){
//   document.getElementById('modal').addEventListener('click', showModal);

//   function showModal() {
    // const modalElement = document.createElement('div');
    // modalElement.classList.add('modal');
    // const innerElement = document.createElement('div');
    // innerElement.classList.add('inner');

    // innerElement.innerHTML = '<input type="button" id="closeBtn" value="close">'

    // const sideNav = document.getElementsByClassName('left')[0];
    // innerElement.appendChild(sideNav);
    // sideNav.classList.add('active');

    // modalElement.appendChild(innerElement);
    // document.body.appendChild(modalElement);

    // modalElement.classList.add('active');
    // const right = document.getElementsByClassName('right')[0];
    
    // right.addEventListener('click', (e) => {
    //   closeModal(modalElement);
    // })
    // innerElement.addEventListener('click', (e) => {
    //   closeModal(modalElement);
    // });
//   }

//   function closeModal(modalElement) {
//     if (document.getElementsByClassName('modal').length == 2) {
//       document.getElementsByClassName('modal')[0].remove();
//     }
//     modalElement.classList.remove('active');
//     const content = document.getElementsByClassName('content')[0];
//     const sideNav = document.getElementsByClassName('left')[0];
//     content.prepend(sideNav);
//     sideNav.classList.remove('active');
//   }
// })