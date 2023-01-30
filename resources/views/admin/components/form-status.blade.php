<div class="form-group">
    <label for="status" class="control-label" required>Trạng thái</label>
    <div>
        <div class="form-group">
        <label class="w-60">
            <input type="radio" class="" name="status"  value="1"  checked/>  Hoạt động   
            </label>
            <br>
            <label class="w-60">
            <input type="radio" class="" name="status"  value="0"  />  Ngưng hoạt động   
            </label>
            <br>
        </div>
    </div>
</div>
@if($errors->has('status'))
    <div class="error"> {{ $errors->first('status') }} </div>
@endif