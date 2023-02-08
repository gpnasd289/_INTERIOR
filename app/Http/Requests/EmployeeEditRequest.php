<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EmployeeEditRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'id'            => 'required',
            'belong_to'     => 'required',
            'name'          => 'required',
            'date'          => 'required',
            'address'       => 'required',
            'born_place'    => 'required',
            'ccid'          => 'required',
            'phonenumber'   => 'required',
            'email'         => 'required',
            'role'          => 'required'
        ];
    }
    public function messages()
    {
        return [
            'name'                  => 'Name is required',
            'date.required'         => 'You need to provide your date of birth',
            'ccid.required'         => 'You need to provide your CCID',
            'born_place.required'   => 'You need to provide your born place',
            'address.required'      => 'You need to provide your address',
            'role.required'         => 'You need to add role',
            'email.required'        => 'Email must not be blank',
            'phonenumber.required'  => 'Phone Number must not be blank',
            'id.required'            => 'Id must not be blank',
            'belong_to.required'     => 'belong_to must not be blank',
        ];
    }
}
