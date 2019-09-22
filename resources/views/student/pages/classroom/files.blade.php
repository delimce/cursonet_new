<table id="file-list" data-search="true" class="cn-grid table table-striped">
    <thead>
    <tr>
        <th data-field="id" data-visible="false"></th>
        <th data-field="dir" data-sortable="true" scope="col">Recurso</th>
        <th data-field="tipo_id" data-visible="false"></th>
        <th data-field="tipo" data-sortable="true" scope="col">Tipo</th>
        <th data-field="fecha" scope="col">Fecha</th>
    </tr>
    </thead>
    <tbody>
    @foreach($files as $file)
        <tr>
            <td>{{$file->file->id}}</td>
            <td>{{str_limit($file->file->dir,105)}}</td>
            <td>{{$file->file->tipo}}</td>
            <td>{{$file->file->getType()}}</td>
            <td>{{$file->file->date()}}</td>
        </tr>
    @endforeach
    </tbody>
</table>
@push('scripts-ready')
    $('#file-list').bootstrapTable();
@endpush


