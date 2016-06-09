$(document).on('page:load ready', function(){
	$('#vote-table').DataTable({
		paging: false,
		ordering: true,
		searching: false,
		info: false,
		responsive: false,
		scrollx: false
	});
	$('[data-toggle="popover"]').popover();
	$('table').wrap('<div class="table-responsive"></div>');
});
