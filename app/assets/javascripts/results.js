$(document).on('page:load ready', function(){
	$('#vote-table').DataTable({
		paging: false,
		ordering: true,
		searching: false,
		info: false,
		scrollx: false
	});
	$('[data-toggle="popover"]').popover();
});
