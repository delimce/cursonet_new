@extends('student.layout.app')
@section('title', trans('students.ratings.title'))

@section('content')
<div class="wrapper">
    <div class="cn-container" id="rating-list">
        <span class="in-title">@lang('students.ratings.title')</span>

        @if(count($results)==0)
            <div class="section-info-text">@lang('students.ratings.noregs')</div>
        @else
            <div class="section-info-text">@lang('students.ratings.select')</div>
            <table id="ratings" data-search="true" class="table table-striped cn-grid">
                <thead>
                <tr>
                    <th data-field="id" data-visible="false"></th>
                    <th data-field="titulo" data-sortable="true" scope="col">Plan</th>
                    <th data-field="grupo" data-sortable="true" scope="col">Grupo</th>
                    <th data-field="curso" data-sortable="true" scope="col">Curso</th>
                    <th data-field="base" data-sortable="true" scope="col">Base</th>
                    <th data-field="items" data-sortable="true" scope="col">Total items</th>
                </tr>
                </thead>
                <tbody>
                @foreach($results as $res)
                    <tr>
                        <td>{{$res->id}}</td>
                        <td>{{$res->titulo}}</td>
                        <td>{{$res->grupo}}</td>
                        <td>{{$res->curso}}</td>
                        <td>{{$res->en_base}}</td>
                        <td>{{$res->items}}</td>
                    </tr>
                @endforeach
                </tbody>
            </table>
        @endif

        

    </div>    
</div>

{{-- ratinglist items --}}

<div class="modal fade" id="ratings-item" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="exampleModalLongTitle">
                    <i class="fas fa-graduation-cap"></i>
                    @lang('students.ratings.detail.title')</h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body container">
                <span class="subtext">@lang('commons.name'):</span>
                <span id="plan-name">&nbsp;</span><br>
                <span class="subtext">@lang('commons.group'):</span>
                <span  id="plan-group">&nbsp;</span><br>
                <span class="subtext">@lang('commons.course'):</span>
                <span  id="plan-course">&nbsp;</span>
                <p>&nbsp;</p>
                <div class="row">
                    <div class="col-6 subtext">
                        @lang('commons.item')
                    </div>
                    <div class="col subtext">
                        @lang('commons.type')
                    </div>
                    <div class="col subtext">
                        @lang('commons.rating')
                    </div>
                  </div>
            <div id="plan-details"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" 
                data-dismiss="modal">@lang('commons.close')</button>
              
            </div>
        </div>
    </div>
</div>

@endsection
@push('scripts-ready')
    $('#ratings').bootstrapTable();
@endpush