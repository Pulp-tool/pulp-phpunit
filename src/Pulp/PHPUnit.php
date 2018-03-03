<?php

namespace Pulp;

use Fs\VirtualFile as vfile;

class PHPUnit extends DataPipe {

	public $liveReload = NULL;
	public $phpbin          = '';
	public $phpunitPhar     = '';
	public $junitLog        = 'tmp/junit.xml';
	public $testDir         = 'tests/';
	public $bootstrap       = '';

	public function __construct($opts=array()) {
		$this->setOpts($opts);
	}

	public function setOpts($opts) {
		$settings = get_object_vars($this);
		$newSettings = array_replace($settings, $opts);
		foreach ($newSettings as $key=>$val) {
			$this->{$key} = $val;
		}
	}

	public function enableLiveReload($lr) {
		$lr->addStaticRoute('/phpunit.html', function ($path) {
			return file_get_contents('tmp/index.html');
		});
		$this->liveReload = $lr;
	}

	protected function _onWrite($data) {
		$this->runTests();
		$this->xslt();
		$this->push($data);
	}

	public function runTests() {
		$out = [];
		@mkdir('tmp');
		$cmd = '--stderr --log-junit '.$this->junitLog.' '.$this->testDir.' 2>&1';
		if ($this->phpunitPhar) {
			$cmd = $this->phpunitPhar. ' '.$cmd;
		}
		if ($this->phpbin) {
			$cmd = $this->phpbin. ' '.$cmd;
		}

		exec($cmd , $out);
		$this->xslt();

		return $out;
	}

	protected function xslt() {
		if (!class_exists('XSLTPRocessor')) {
			//TODO: emit warning
			return;
		}
		$xproc = new \XSLTProcessor();

		$junitLog = file_get_contents('tmp/junit.xml');
		if (!strlen($junitLog)) {
			return [];
		}
		$junit = new \DOMDocument();
		$junit->loadXML($junitLog);
		$xsl = new \DOMDocument();
		$xsl->loadXML(file_get_contents('phpunit-twbs4.xsl'));
		$xproc->importStylesheet($xsl);
		$html = @$xproc->transformToXml($junit);
		if (strlen($html)) {
			file_put_contents('tmp/index.html', $html);
			$port = 35729;
			$this->log("available @: http://localhost:".$port."/phpunit.html");
		}
	}
}
