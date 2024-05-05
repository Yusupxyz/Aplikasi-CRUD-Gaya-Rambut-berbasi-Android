<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Wajah;
use File;

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
        $request->validate([
            'wajah' => 'required',
            'wajah.*' => 'mimes:jpg,jpeg,png|max:2000'
        ]);
        if ($request->hasfile('wajah')) {            
            $filename = round(microtime(true) * 1000).'-'.str_replace(' ','-',$request->file('wajah')->getClientOriginalName());
            $request->file('wajah')->move(public_path('images'), $filename);
             $wajah = Wajah::create(
                    [            
                        'nama' => $request->nama,            
                        'wajah' =>$filename
                    ]
                );
                return response()->json([
                    'message' => "Tambah Data Berhasil",
                    'code' => "200",
                    'data'  => $wajah
                ]);
        }else{
            return response()->json([
                'message' => "Tambah Data Gagal!",
                'code' => "401",
                'data'  => null
            ]);
        }
        
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
        $request->validate([
            'wajah.*' => 'mimes:jpg,jpeg,png|max:2000'
        ]);
        $wajah = Wajah::find($id);

        if ($request->hasfile('wajah')) {    
            if (File::exists(public_path('images/'.$wajah->wajah))) {
                File::delete(public_path('images/'.$wajah->wajah));
            }            $filename = round(microtime(true) * 1000).'-'.str_replace(' ','-',$request->file('wajah')->getClientOriginalName());
            $request->file('wajah')->move(public_path('images'), $filename);
             $wajah =  $wajah->update(
                    [            
                        'nama' => $request->nama,            
                        'wajah' =>$filename
                    ]
                );
                return response()->json([
                    'message' => "Ubah Data Berhasil",
                    'code' => "200",
                    'data'  => $wajah
                ]);
        }else{
            $wajah =  $wajah->update(
                [            
                    'nama' => $request->nama,            
                ]
            );
            return response()->json([
                'message' => "Ubah Data Berhasil",
                'code' => "200",
                'data'  => $wajah
            ]);
        }
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
        if (File::exists(public_path('images/'.$wajah->wajah))) {
            File::delete(public_path('images/'.$wajah->wajah));
        }  
        $wajah->delete();
        return response()->json([
            'message' => "Hapus Data Berhasil",
            'code' => "200",
            'data'  => null
        ]); 
    }
}
