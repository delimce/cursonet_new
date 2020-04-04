<table id="inbox" data-search="true" class="table table-striped cn-grid">
    <thead>
    <tr>
        <th data-field="id" data-visible="false"></th>
        <th data-field="nombre" data-sortable="true" scope="col">Remitente</th>
        <th data-field="asunto" data-sortable="true" scope="col">Mensaje</th>
        <th data-field="fecha" data-sortable="true" scope="col">Fecha</th>
    </tr>
    </thead>
    <tbody>
        @foreach($messages as $message)
            <tr class="@if (!$message->leido) subtext @endif my-inbox">
                <td>{{$message->id}}</td>
                <td>{{$message->sender()}}</td>
                <td>{{$message->subject}}</td>
                <td>{{$message->datetime()}}</td>
            </tr>
        @endforeach
    </tbody>
</table>

<div style="width: 200px; float: right; padding: 20px">
    <button id="new-msg" class="btn btn-lg btn-block btn-primary" type="button">
        @lang('students.inbox.compose')
    </button>
</div>