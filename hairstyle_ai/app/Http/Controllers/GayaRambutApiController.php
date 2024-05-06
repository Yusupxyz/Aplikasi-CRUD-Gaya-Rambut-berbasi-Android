<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\GayaRambut;

class GayaRambutApiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $gayarambut = GayaRambut::with('gaya','warna')->get();
        return response()->json([
            'message' => "Success",
            'code' => "200",
            'data'  => $gayarambut
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
        $gayarambut = GayaRambut::create($request->all());
        return response()->json([
            'message' => "Tambah Data Berhasil",
            'code' => "200",
            'data'  => $gayarambut
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
        $gayarambut = GayaRambut::with('gaya','warna')->find($id);
        return response()->json([
            'message' => "Success",
            'code' => "200",
            'data'  => $gayarambut
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
        $gayarambut = GayaRambut::find($id);
        $gayarambut->update($request->all());
        return response()->json([
            'message' => "Ubah Data Berhasil",
            'code' => "200",
            'data'  => $gayarambut
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
        $gayarambut = GayaRambut::find($id);
        $gayarambut->delete();
        return response()->json([
            'message' => "Hapus Data Berhasil",
            'code' => "200",
            'data'  => null
        ]); 
    }
}
