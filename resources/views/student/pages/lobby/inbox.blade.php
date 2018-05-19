@extends('student.layout.app')
@section('title', trans('students.inbox.title'))

@section('content')
    @component("student.components.preloader")
    @endcomponent

    <div class="row home-page">
        <div class="col-md-7 card-border">
            <section>
                <h2>@lang('students.inbox.title')</h2>

                @component("student.components.dataTable")
                    @slot("id")
                        inbox
                    @endslot
                @endcomponent

            </section>
        </div>

    </div>

@endsection