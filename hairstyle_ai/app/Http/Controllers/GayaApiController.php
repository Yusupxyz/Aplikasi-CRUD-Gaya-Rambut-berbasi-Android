<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Gaya;

class GayaApiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $gaya = Gaya::all();
        return response()->json([
            'message' => "Success",
            'code' => "200",
            'data'  => $gaya
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
        $gaya = Gaya::create($request->all());
        return response()->json([
            'message' => "Tambah Data Berhasil",
            'code' => "200",
            'data'  => $gaya
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
        $gaya = Gaya::find($id);
        return response()->json([
            'message' => "Success",
            'code' => "200",
            'data'  => $gaya
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
        $gaya = Gaya::find($id);
        $gaya->update($request->all());
        return response()->json([
            'message' => "Ubah Data Berhasil",
            'code' => "200",
            'data'  => $gaya
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
        $gaya = Gaya::find($id);
        $gaya->delete();
        return response()->json([
            'message' => "Hapus Data Berhasil",
            'code' => "200",
            'data'  => null
        ]); 
    }
}
