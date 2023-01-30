<?php

namespace App\Http\Controllers;

use App\Http\Requests\createTestimonialRequest;
use App\Models\Testimonial;
use Illuminate\Http\Request;

class TestimonialController extends Controller
{
    public function storeTestimonial(createTestimonialRequest $request) {
        $data = $request -> all();
        $review = Testimonial::create($data);
        $review -> save();
        return response() -> json([
            'code' => 200,
            'message' => 'Tạo đánh giá thành công',
            'data' => [
                'value' => $review
            ]
        ]);
    }
}
