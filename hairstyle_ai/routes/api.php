<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\WarnaApiController;
use App\Http\Controllers\GayaApiController;
use App\Http\Controllers\WajahApiController;
use App\Http\Controllers\GayaRambutApiController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// API Warna
Route::get('/warna',[WarnaApiController::class, 'index']);
Route::get('/warna/{id}',[WarnaApiController::class, 'show']);
Route::post('/warna',[WarnaApiController::class, 'store']);
Route::put('/warna/{id}',[WarnaApiController::class, 'update']);
Route::delete('/warna/{id}',[WarnaApiController::class, 'destroy']);

// API Gaya
Route::get('/gaya',[GayaApiController::class, 'index']);
Route::get('/gaya/{id}',[GayaApiController::class, 'show']);
Route::post('/gaya',[GayaApiController::class, 'store']);
Route::put('/gaya/{id}',[GayaApiController::class, 'update']);
Route::delete('/gaya/{id}',[GayaApiController::class, 'destroy']);

// API Wajah
Route::get('/wajah',[WajahApiController::class, 'index']);
Route::get('/wajah/{id}',[WajahApiController::class, 'show']);
Route::post('/wajah',[WajahApiController::class, 'store']);
Route::put('/wajah/{id}',[WajahApiController::class, 'update']);
Route::delete('/wajah/{id}',[WajahApiController::class, 'destroy']);

// API Gaya Rambut
Route::get('/gayarambut',[GayaRambutApiController::class, 'index']);
Route::get('/gayarambut/{id}',[GayaRambutApiController::class, 'show']);
Route::post('/gayarambut',[GayaRambutApiController::class, 'store']);
Route::put('/gayarambut/{id}',[GayaRambutApiController::class, 'update']);
Route::delete('/gayarambut/{id}',[GayaRambutApiController::class, 'destroy']);