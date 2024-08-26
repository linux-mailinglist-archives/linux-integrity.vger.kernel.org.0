Return-Path: <linux-integrity+bounces-3380-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C3895F925
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Aug 2024 20:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E59B21F69
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Aug 2024 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12B0198A17;
	Mon, 26 Aug 2024 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b/kSpv8a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="miUiCW1F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rCMD/45t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vrluWTuw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DCB19148F
	for <linux-integrity@vger.kernel.org>; Mon, 26 Aug 2024 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697913; cv=none; b=Thh2tVGtGZHIHWUmzQ3QdU4hwer9jq/ahS5migWmH0ZOipZE1qjrB8DUHm/H3Gy7F+B5xV/6tXdKAySx3e24hNPRJOMQeiC1NedTipU9X/Ql1kJ58A39ZHR0Xw5syXuEXHmgvw0F+Hr+oN5mOsHfWLE4QdBH3P1RDFQiKOwpnq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697913; c=relaxed/simple;
	bh=QXJxGqWB3OhgjcFpzA0rLZox2i9DibNftul93mgEBMw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OXC18+o8bQLA8TY2XxjTFQfMAHPoBDEmVOEjcBupSBEP3YT7MnMHgTLSZQl+JMYQGC5SEI4B3sqc492G3QoL15E7i+8TkSw7LMenkEZY8SiI7y/q+r6xvXacaCq9vgz8fYAzazmszUR1Xax7HjEsmU7KAwvbl7mw5gHDF8Kvz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b/kSpv8a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=miUiCW1F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rCMD/45t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vrluWTuw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A18921AD7
	for <linux-integrity@vger.kernel.org>; Mon, 26 Aug 2024 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724697909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=AaVoidsswPGGNE8cGlgGQ4FPnzeJYf0hYl7h+N2QKic=;
	b=b/kSpv8aJ+LbZ/DcF6o+M9CL6cMkoWGcraNGnxyijFBUBtiKG2m1aGPMMjiGOiuN77Wx10
	15sp1FXwYMV4jDgujRZaBUztfV11hFIQO7PLl17FYRx3WrnSXEC5+ocgnpXAoPwmNk0zXP
	HxgmsGXp06/NYYypzEvXq8LfsHfvdus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724697909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=AaVoidsswPGGNE8cGlgGQ4FPnzeJYf0hYl7h+N2QKic=;
	b=miUiCW1F7mFdmepU7Qj1UwuiTYV0PCDMj735RsWXPsiIuw7iAxiRdEp1VfHEedBq1WnIMa
	5/XRt3WR4HVlJFAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724697908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=AaVoidsswPGGNE8cGlgGQ4FPnzeJYf0hYl7h+N2QKic=;
	b=rCMD/45teAHG+fBiFmUzLKmzPLKw3Ku9P3177M7VJYbaKHQGgyA7JoZGGCJM4ktcOZhMzc
	ABzPytXN5WgmFC5AJ8dCijSM6eaPWcoNljIY1xjiWhCOxqS2WFqQTS23pKxFgwUoLq7PJD
	HC3tgxC6pp6udmjVK/89VufpiLzEDKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724697908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=AaVoidsswPGGNE8cGlgGQ4FPnzeJYf0hYl7h+N2QKic=;
	b=vrluWTuwjXWriHM2qEOkivxLnkBqBGLEQLpJrglac7nIt78LmE7F3uD484v/OvzEa095WD
	dSzAvQALg0CP78CA==
Date: Mon, 26 Aug 2024 20:45:07 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: linux-integrity@vger.kernel.org
Subject: TPM selftests require TPM2 but do not check for the requirement
Message-ID: <20240826184507.GM26466@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Score: -4.28
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.927];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:mid,kitsune.suse.cz:helo]
X-Spam-Flag: NO
X-Spam-Level: 


Hello,

I tried to run the kernel TPM selftest from
tools/testing/selftests/tpm2/ on two different VMs, and found that while
on one it works on another it reports a lot of errors.

Inspecting the emolated platfrom configuration it turns out that the
non-working VM had TPM 1.2.

While it is not expected that TPM2 tests would work on TPM 1.2 it would
be nice to report something intelligible to the user when the
requirements are not met.

Perhaps somewhat similar to commit 5627f9cffee7 ("Kernel selftests: Add check if TPM devices are supported")

Thanks

Michal

Sample output:

jostaberry-2:~/linux/tools/testing/selftests/tpm2/:[0]# ./test_smoke.sh 
test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ERROR
test_read_partial_resp (tpm2_tests.SmokeTest) ... ERROR
Exception ignored in: <bound method Client.__del__ of <tpm2.Client object at 0x7fffa89044a8>>
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 375, in __del__
    if self.tpm:
AttributeError: 'Client' object has no attribute 'tpm'
test_seal_with_auth (tpm2_tests.SmokeTest) ... ERROR
Exception ignored in: <bound method Client.__del__ of <tpm2.Client object at 0x7fffa89046d8>>
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 375, in __del__
    if self.tpm:
AttributeError: 'Client' object has no attribute 'tpm'
test_seal_with_policy (tpm2_tests.SmokeTest) ... ERROR
Exception ignored in: <bound method Client.__del__ of <tpm2.Client object at 0x7fffa8904518>>
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 375, in __del__
    if self.tpm:
AttributeError: 'Client' object has no attribute 'tpm'
test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ERROR
Exception ignored in: <bound method Client.__del__ of <tpm2.Client object at 0x7fffa89044a8>>
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 375, in __del__
    if self.tpm:
AttributeError: 'Client' object has no attribute 'tpm'
test_send_two_cmds (tpm2_tests.SmokeTest) ... ERROR
Exception ignored in: <bound method Client.__del__ of <tpm2.Client object at 0x7fffa89046d8>>
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 375, in __del__
    if self.tpm:
AttributeError: 'Client' object has no attribute 'tpm'
test_too_short_cmd (tpm2_tests.SmokeTest) ... ERROR
Exception ignored in: <bound method Client.__del__ of <tpm2.Client object at 0x7fffa8904518>>
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 375, in __del__
    if self.tpm:
AttributeError: 'Client' object has no attribute 'tpm'
test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ERROR
Exception ignored in: <bound method Client.__del__ of <tpm2.Client object at 0x7fffa89044a8>>
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 375, in __del__
    if self.tpm:
AttributeError: 'Client' object has no attribute 'tpm'
test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ERROR
Exception ignored in: <bound method Client.__del__ of <tpm2.Client object at 0x7fffa89046d8>>
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 375, in __del__
    if self.tpm:
AttributeError: 'Client' object has no attribute 'tpm'

======================================================================
ERROR: test_read_partial_overwrite (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2_tests.py", line 16, in setUp
    self.root_key = self.client.create_root_key()
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 587, in create_root_key
    return struct.unpack('>I', self.send_cmd(cmd)[10:14])[0]
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 402, in send_cmd
    raise ProtocolError(cc, rc)
tpm2.ProtocolError: TPM_RC_UNKNOWN: cc=0x00000131, rc=0x0000000a

======================================================================
ERROR: test_read_partial_resp (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 364, in __init__
    self.tpm = open('/dev/tpm0', 'r+b', buffering=0)
OSError: [Errno 16] Device or resource busy: '/dev/tpm0'

======================================================================
ERROR: test_seal_with_auth (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 364, in __init__
    self.tpm = open('/dev/tpm0', 'r+b', buffering=0)
OSError: [Errno 16] Device or resource busy: '/dev/tpm0'

======================================================================
ERROR: test_seal_with_policy (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 364, in __init__
    self.tpm = open('/dev/tpm0', 'r+b', buffering=0)
OSError: [Errno 16] Device or resource busy: '/dev/tpm0'

======================================================================
ERROR: test_seal_with_too_long_auth (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 364, in __init__
    self.tpm = open('/dev/tpm0', 'r+b', buffering=0)
OSError: [Errno 16] Device or resource busy: '/dev/tpm0'

======================================================================
ERROR: test_send_two_cmds (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 364, in __init__
    self.tpm = open('/dev/tpm0', 'r+b', buffering=0)
OSError: [Errno 16] Device or resource busy: '/dev/tpm0'

======================================================================
ERROR: test_too_short_cmd (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 364, in __init__
    self.tpm = open('/dev/tpm0', 'r+b', buffering=0)
OSError: [Errno 16] Device or resource busy: '/dev/tpm0'

======================================================================
ERROR: test_unseal_with_wrong_auth (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 364, in __init__
    self.tpm = open('/dev/tpm0', 'r+b', buffering=0)
OSError: [Errno 16] Device or resource busy: '/dev/tpm0'

======================================================================
ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/linux/tools/testing/selftests/tpm2/tpm2_tests.py", line 15, in setUp
    self.client = tpm2.Client()
  File "/root/linux/tools/testing/selftests/tpm2/tpm2.py", line 364, in __init__
    self.tpm = open('/dev/tpm0', 'r+b', buffering=0)
OSError: [Errno 16] Device or resource busy: '/dev/tpm0'

----------------------------------------------------------------------
Ran 9 tests in 0.012s

FAILED (errors=9)


