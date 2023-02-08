
@foreach($children as $child)
    @if ($isSameID($child['ID']))
        <option value="{{ $child['ID'] }}" data-tokens="{{ $child['name'] }}" selected> {{ $child['name'] }}  </option>
    @else
        <option value="{{ $child['ID'] }}"  data-tokens="{{ $child['name'] }}"  > {{ $tab.'  '. $child['name'] }} </option>
    @endif
    <x-optionitem :children="$child['children'] ?? []" :tab="$tab.$tab " :selected="$selected"></x-optionitem>
@endforeach