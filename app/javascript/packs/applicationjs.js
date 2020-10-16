const dropdownTrigger = document.getElementById('dropdown-trigger');
const dropdown = document.getElementById('dropdown');
dropdownTrigger.addEventListener('click', function() {
  if(dropdown.classList.contains('is-active') === true ) {
    dropdown.classList.remove('is-active');
  }else {
    dropdown.classList.add('is-active');
  } 
});
