<div id="forum-wrapper">&nbsp;</div>
<table id="forum-list" class="table table-striped cn-grid">
    <thead>
    <tr>
        <th data-field="id" data-visible="false"></th>
        <th data-field="titulo" data-sortable="true" scope="col">Foro</th>
        <th data-field="grupo_desc" data-sortable="true" scope="col">Sección</th>
        <th data-field="posts" data-sortable="true" scope="col">Comentarios</th>
        <th data-field="fecha_ini" data-sortable="true" scope="col">Fecha inicio</th>
        <th data-field="fecha_fin" data-sortable="true" scope="col">Fecha fin</th>
    </tr>
    </thead>
    <tbody>
    @foreach($forums as $item)
        <tr>
            <td>{{$item->id}}</td>
            <td>{{str_limit($item->titulo,105)}}</td>
            <td>{{$item->group->nombre}}</td>
            <td>{{$item->posts->count()}}</td>
            <td>{{$item->dateInit()}}</td>
            <td>{{$item->dateEnd()}}</td>
        </tr>
    @endforeach
    </tbody>
</table>
@push('scripts-ready')
    $('#forum-list').bootstrapTable();
@endpush