<table id="{{$id}}" class="display stripe dataTableCn">
    <thead>
      {{$head}}
    </thead>
    <tbody>
      {{$body}}
    </tbody>
</table>
@push('scripts-ready')
        $('#{{$id}}').DataTable( {
            "paging":   true,
            "ordering": true,
            "info":     true,
            "language": {
                "zeroRecords": "@lang('students.nofound')",
                "search": "@lang('commons.search')",
                "info": "@lang('students.paging')",
                "infoEmpty": "@lang('students.nofound')",
                "infoFiltered": "(@lang('students.filtered'))"
            }
        } );
@endpush
