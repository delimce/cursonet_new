<table id="sent" data-search="true" class="table table-striped cn-grid">
    <thead>
    <tr>
        <th data-field="id" data-visible="false"></th>
        <th data-field="name" data-sortable="true" scope="col">Para</th>
        <th data-field="subject" data-sortable="true" scope="col">Mensaje</th>
        <th data-field="datetime" data-sortable="true" scope="col">Fecha enviado</th>
    </tr>
    </thead>
    <tbody>
        @foreach($sent as $message)
            <tr class="my-inbox">
                <td>{{$message->id}}</td>
                <td>{{$message->sender()}}</td>
                <td>{{$message->subject}}</td>
                <td>{{$message->datetime()}}</td>
            </tr>
        @endforeach
    </tbody>
</table>