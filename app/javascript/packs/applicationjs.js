'user strict'
// dropdownが開かれていない状態でdropdownTriggerをクリックすればdropdownが開く
// dropdownが開いているならdropdownTriggerをもう一度クリックするかdropdownTrigger以外をクリックしても
// dropdownが閉じる
{
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
}

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

