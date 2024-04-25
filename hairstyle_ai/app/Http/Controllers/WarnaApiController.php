<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Warna;

class WarnaApiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $warna = Warna::all();
        return response()->json([
            'message' => "Success",
            'code' => "200",
            'data'  => $warna
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $warna = Warna::create($request->all());
        return response()->json([
            'message' => "Tambah Data Berhasil",
            'code' => "200",
            'data'  => $warna
        ]); 
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $warna = Warna::find($id);
        return response()->json([
            'message' => "Success",
            'code' => "200",
            'data'  => $warna
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $warna = Warna::find($id);
        $warna->update($request->all());
        return response()->json([
            'message' => "Ubah Data Berhasil",
            'code' => "200",
            'data'  => $warna
        ]); 
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $warna = Warna::find($id);
        $warna->delete();
        return response()->json([
            'message' => "Hapus Data Berhasil",
            'code' => "200",
            'data'  => null
        ]); 
    }
}
