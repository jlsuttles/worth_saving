jQuery(document).ready(function() {
  draft_save_interval = 100  // will be 6000 in real implementation and overwritable from either controller or model or both
  set_up_draft_save('Page','',draft_save_interval)
  set_up_draft_save('Page','1',draft_save_interval)
  
  jQuery('[data-record_type]').css( { backgroundColor : 'yellow' })
  
})

function save_draft(record_type, record_id) {
  alert(jQuery('[data-record_type="' + record_type + '"][data-record_id="' + record_id + '"]').serialize())
  // alert(jQuery('[data-record_type="Draft"]').serialize())
  // jQuery.post('/drafts', )
}

function set_up_draft_save(record_type, record_id, draft_save_interval) {
  setTimeout('save_draft("' + record_type + '", "' + record_id + '")', draft_save_interval)
}