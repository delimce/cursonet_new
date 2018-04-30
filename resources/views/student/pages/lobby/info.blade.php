<section>
    <h2>Informacion del Curso</h2>

    <div>
        <span class="subtext">Nombre del curso:</span>
        <span>unknown printer took </span>
    </div>
    <div>
        <span class="subtext">Duracion:</span>
        <span>3 semanas</span>
    </div>
    <div>
        is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the
        industry's
        standard dummy text ever since the 1500s, when an unknown printer took a galley of type and
        scrambled
        it to make a type specimen book. It has survived not only five centuries, but also the leap into
        electronic typesetting
    </div>

    <div style="float: left; width: 50%">
        <div>
            <span class="subtext">Fecha Inicio:</span>
            <span>10/11/2018</span>
        </div>
        <div>
            <span class="subtext">Fecha Fin:</span>
            <span>10/11/2018</span>
        </div>
        <div>
            <span class="subtext">Facilitador:</span>
            <span><a href="#">Luis De Lima</a></span>
        </div>
    </div>

    <div style="float: right; width: 50%; padding-top: 20px">
        <div class="col-sm-auto">
            <button id="btocontent" class="btn btn-lg btn-block btn-signin" type="submit">Ir al Curso</button>
        </div>
    </div>

</section>
@push('scripts')
    <script>
        $("#btocontent").click(function () {
            redirect('{!! url('student/classroom') !!}');
        })
    </script>
@endpush