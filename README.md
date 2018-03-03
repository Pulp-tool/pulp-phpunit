Pulp-PHPUnit
===

```php
$phpunit = new phpunit([
	'phpbin'      => 'php7.1',
	'phpunitPhar' => '/usr/local/bin/phpunit',
	'testDir'     => 'tests/unit/',
]);


$p->task('watch', function() use($p, $watchDirsCode, $phpunit) {
	$lr = new lr();
	$lr->listen($p->loop);
	$phpunit->enableLiveReload($lr);

	$out = $phpunit->runTests();
	foreach ($out as $_l) {
		$p->log($_l);
	}

	return $p->watch( $watchDirsCode )->on('change', function($file) use ($p, $lr, $phpunit) {
		$p->debug( "file changed: <file>%s</>", [$file]);
		$out = $phpunit->runTests();
		foreach ($out as $_l) {
			$p->log($_l);
		}
		$lr->fileChanged($file);
	});
});


$p->task('runTests', function() use($phpunit) { 
	$phpunit->runTests();
});
```

Open a browser to: [http://localhost:35729/phpunit.html]
