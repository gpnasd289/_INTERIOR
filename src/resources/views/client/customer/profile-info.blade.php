<x-profileinfo :type="1" id="profile_name" :customerid=" $customer  -> ID"> 
    <span id="{{ 'name-' . $customer -> ID }}">{{ $customer -> profile -> name }}</span>
</x-profileinfo>
<x-profileinfo :type="2" id="profile_username" :customerid=" $customer  -> ID "> 
    <span id="{{ 'username-' . $customer -> ID }}">{{ $customer -> username }}</span>
</x-profileinfo>
<x-profileinfo :type="3" id="profile_password" :customerid=" $customer  -> ID "> 
    <span>********</span>
</x-profileinfo>
<x-profileinfo :type="4" id="profile_address" :customerid=" $customer  -> ID "> 
    <span id="{{ 'username-' . $customer -> ID }}">{{ $customer -> profile -> address }}</span>
</x-profileinfo>
<x-profileinfo :type="5" id="profile_email" :customerid="$customer  -> ID ">
    <span id="{{ 'email-' . $customer -> ID }}">{{ $customer -> profile -> email }}</span>
</x-profileinfo>
<x-profileinfo :type="6" id="profile_phone_number" :customerid="$customer  -> ID "> 
    <span id="{{ 'phone-' . $customer -> ID }}">{{ $customer -> profile -> phone_number }}</span>
</x-profileinfo>
<x-profileinfo :type="7" id="profile_social_media" :customerid=" $customer  -> ID "> 
    <div><i class="fa-brands fa-facebook"></i> Facebook</div>
    <div><i class="fa-brands fa-google"></i> Google</div>
</x-profileinfo>