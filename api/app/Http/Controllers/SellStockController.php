<?php

namespace App\Http\Controllers;

use GuzzleHttp\Client;
use Illuminate\Http\Request;

class SellStockController extends Controller
{
    public function __construct(private Client $client) {}

    public function get()
    {
        $result = $this->client->get("https://datsorange.devteam.games/sellStock",
            ["headers" =>
                ["token" => "64ef6461c7ea364ef6461c7ea5"]
            ]
        );
        $response = $result->getBody()->getContents();
        $response = json_decode($response);
        $result = [];
        foreach ($response as $res)
        {
            if (count($res->bids) !== 0)
            {
                $result[] = $res;
            }
        }
        dd($result);
    }
}
