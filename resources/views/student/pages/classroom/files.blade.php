<table id="content-file" class="table table-striped">
    <thead>
    <tr>
        <th data-field="id" data-visible="false"></th>
        <th data-field="dir" data-sortable="true" scope="col">Recurso</th>
        <th data-field="tipo" data-sortable="true" scope="col">Tipo</th>
        <th data-field="fecha" scope="col">Fecha</th>
    </tr>
    </thead>
    <tbody>
    @foreach($files as $file)
        <tr>
            <td>{{$file->file->id}}</td>
            <td>{{str_limit($file->file->dir,105)}}</td>
            <td>{{$file->file->getType()}}</td>
            <td>{{$file->file->date()}}</td>
        </tr>
    @endforeach
    </tbody>
</table>
@push('scripts-ready')
    $('#content-file').bootstrapTable();

    $('#content-file').on('click-cell.bs.table', function (field, value, row, $element) {
    console.log($element.id+' '+$element.tipo);
    });
@endpush

