<?php

$idtv = "204";
$filetv = "sctv.m3u8";
awal:
$masuk = array("Host: api.vidio.com" ,
 "Connection:keep-alive" ,
 "x-client: 1667092761" ,
 "x-signature: 14865e2daac3fa4475d8e596666ab2e59099202132d409184d9b526686611163" ,
 "referer: android-app://com.vidio.android" ,
 "x-api-platform: app-android" ,
 "x-api-auth: laZOmogezono5ogekaso5oz4Mezimew1" ,
 "user-agent: vidioandroid/5.89.8-909114e160 (3189388)" ,
 "x-api-app-info: android/5.1.1/5.89.8-909114e160-3189388" ,
 "accept-language: id" ,
 "content-type: application/vnd.api+json" ,
  "accept-encoding: gzip" ,
  "x-visitor-id: efb068c0-4170-47f4-9571-cda0b267efe5");

$ambil = ambil('https://api.vidio.com/livestreamings/'.$idtv.'/stream?initialize=true', $masuk);

//print_r($ambil[1]);
$data = json_decode($ambil[1],true);
$target = $data['data']['attributes']['hls'];

function ambil($host,$header)
  	{
  		$ch = curl_init();
  		curl_setopt($ch, CURLOPT_URL, $host);
  		curl_setopt($ch, CURLOPT_HTTPHEADER, $header);	
  		curl_setopt($ch, CURLOPT_HEADER, true);
  		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET');
  		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  		curl_setopt($ch, CURLOPT_ENCODING, 'gzip');
  		//curl_setopt($ch, CURLOPT_POSTFIELDS, $body);
  		//curl_setopt($ch, CURLOPT_COOKIEJAR, 'cookie.txt');
  		//curl_setopt($ch, CURLOPT_COOKIEFILE, 'cookie.txt');
  		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
  		$req = curl_exec($ch);
  		$req = explode("\r\n\r\n", $req);
  		return $req;
  	}
  
  

//header("location: ".$target);
//exit();
unlink($filetv);
// url target unduhan
$url = $target;
// inisialisasi curl handler
$chdw = curl_init();
// setting option url target di curl
curl_setopt($chdw, CURLOPT_URL, $url);
// setting option nama file hasil unduhan 
$filename = $filetv;
$fp = fopen($filename, 'wb');
curl_setopt($chdw, CURLOPT_FILE, $fp);
// jalankan curl
curl_exec($chdw);
// tutup curl
curl_close($chdw);
// tutup file hasil unduhan
fclose($fp);

//uploadFTP("ftp.geocities.ws","ariev7xx","arievganteng", "sctv.m3u8", "sctv.m3u8");


$chftp = curl_init();
$localfile = $filetv;
$remotefile = $filetv;
$fp = fopen($localfile, 'r');
curl_setopt($chftp, CURLOPT_URL, 'ftp://ariev7xx:arievganteng@ftp.geocities.ws/'.$remotefile);
curl_setopt($chftp, CURLOPT_UPLOAD, 1);
curl_setopt($chftp, CURLOPT_INFILE, $fp);
curl_setopt($chftp, CURLOPT_INFILESIZE, filesize($localfile));
curl_exec ($chftp);
$error_no = curl_errno($chftp);
curl_close ($chftp);
if ($error_no == 0) {
    $error = 'File uploaded succesfully./n';
} else {
    $error = 'File upload error./n';
}
echo $error;
if($idtv == "204"){
	$idtv = "205";
	$filetv ="indosiar.m3u8";
	goto awal;
	}
exit();

?>
