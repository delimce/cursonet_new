<table class="cn-grid" id="content-file" data-search="true" class="table table-striped">
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
    $('#content-file').bootstrapTable();
@endpush
<script>
    $('#content-file').on('click-cell.bs.table', function (field, value, row, $element) {
        if (Number($element.tipo_id) === 0) {
            axios.request({
                responseType: 'blob',
                url: '{!! url('api/student/class/file') !!}' + '/' + $element.id,
                method: 'get',
            }).then(function (response) {
                downloadFile(response,String($element.dir))
            }).catch(function (error) {
                showAlert("no es posible encontrar el archivo")
            });
        } else {
            window.open(String($element.dir), '_blank');
        }

    });
</script>

