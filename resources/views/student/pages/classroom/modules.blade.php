<section>
    <h2>Seleccione el tema</h2>

    @foreach ($modules as $module)
        <div class="module-item @if ($module["selected"]) current-module @endif">
            <i class="fas fa-book"></i>
            <span class="subtext">Tema {{$loop->index+1}},</span>
            <span>nombre del tema, puede ser muy largo por aqui</span>
        </div>
    @endforeach

</section>