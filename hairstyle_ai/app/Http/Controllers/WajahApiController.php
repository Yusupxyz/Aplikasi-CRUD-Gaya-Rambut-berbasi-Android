<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Wajah;

class WajahApiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $wajah = Wajah::all();
        return response()->json([
            'message' => "Success",
            'code' => "200",
            'data'  => $wajah
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
        $wajah = Wajah::create($request->all());
        return response()->json([
            'message' => "Tambah Data Berhasil",
            'code' => "200",
            'data'  => $wajah
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
        $wajah = Wajah::find($id);
        return response()->json([
            'message' => "Success",
            'code' => "200",
            'data'  => $wajah
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
        $wajah = Wajah::find($id);
        $wajah->update($request->all());
        return response()->json([
            'message' => "Ubah Data Berhasil",
            'code' => "200",
            'data'  => $wajah
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
        $wajah = Wajah::find($id);
        $wajah->delete();
        return response()->json([
            'message' => "Hapus Data Berhasil",
            'code' => "200",
            'data'  => null
        ]); 
    }
}
