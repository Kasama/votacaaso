$(document).on('page:load ready', function(){
	$('#vote-table').DataTable({
		paging: false,
		ordering: true,
		searching: false,
		info: false,
		responsive: false,
		scrollx: false
	});
	$('table').wrap('<div class="table-responsive"></div>');
	$('.read-reason').click(function() {
		$('#modal-head').text($(this).data('header'));
		$('#modal-text').text(($(this).data('body')).replace(/(:?\r?\n|\r)/g, '<br />'));
	});
});
