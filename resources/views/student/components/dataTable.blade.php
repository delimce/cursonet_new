<table id="{{$id}}" class="display stripe dataTableCn">
    <thead>
    <tr>
        <th>Nombre</th>
        <th>Asunto</th>
        <th>Fecha</th>
       </tr>
    </thead>
    <tbody>
    <tr>
        <td>Tiger Nixon</td>
        <td>System Architect</td>
        <td>2011/04/25</td>
    </tr>
    <tr>
        <td>Tiger Nixon</td>
        <td>System Architect</td>
        <td>2011/04/25</td>
    </tr>
    </tbody>
</table>
@push('head')
    <link href="{!! url('bower_components/datatables/media/css/jquery.dataTables.min.css') !!}" rel="stylesheet">
    <script src="{!! url('bower_components/datatables/media/js/jquery.dataTables.js') !!}"></script>
@endpush
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