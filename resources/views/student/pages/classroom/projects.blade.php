<div id="project-container">&nbsp;</div>
<table id="project-list" class="cn-grid table table-striped">
    <thead>
    <tr>
        <th data-field="id" data-visible="false"></th>
        <th data-field="name" data-sortable="true" scope="col">Nombre</th>
        <th data-field="grupo_desc" data-sortable="true" scope="col">Sección</th>
        <th data-field="date_init" data-sortable="true" scope="col">Fecha inicio</th>
        <th data-field="date_end" data-sortable="true" scope="col">Fecha límite</th>
        <th data-field="status" data-sortable="true" scope="col">Estatus</th>
    </tr>
    </thead>
    <tbody>
    @foreach($projects as $item)
        <tr>
            <td>{{$item->id}}</td>
            <td>{{str_limit($item->nombre,105)}}</td>
            <td>{{ isset($item->group) ? $item->group->nombre :  __('commons.all') }}</td>
            <td>{{$item->dateInit()}}</td>
            <td>{{$item->dateEnd()}}</td>
            <td>{{$item->statusName()}}</td>
        </tr>
    @endforeach
    </tbody>
</table>
@push('scripts-ready')
    $('#project-list').bootstrapTable();
@endpush