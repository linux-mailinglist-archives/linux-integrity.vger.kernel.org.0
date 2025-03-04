Return-Path: <linux-integrity+bounces-5063-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A396A4DF44
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 14:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B651767F4
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBA31E505;
	Tue,  4 Mar 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LwiC/OWT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f9O+pZxq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LwiC/OWT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f9O+pZxq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288981E4A4
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095067; cv=none; b=u/U6hmdiMY1RxauRXesR3do9/S85+MsRwBvpf3N/R6RMvmPzEM/vWpqeqJBD8msiE9VKYQkS6VWF7FO6PS8k4/YbBMKnLuo48Gne/X/dK03JfDv0908zkIX59ciVXOPpbhPPyeGjM+TjtrKX7WrhcA0XImN5QHi52gTA75dUtpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095067; c=relaxed/simple;
	bh=NLJ8GYzvhWEmmthZs2K25tdggrlTgnAFAVHuL6t3xLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAGGb3KlK1DKHoin1Zvrtr1azw/nfQ4+1Ocw+jsqCVu5eoLHOtO/i8OFp9LBGYrwei1WS+YY4KxJvXkC4IcmCQdpr/SmWF0C4hDDcvg7iRCsiYfkTpEZyLkxOugmtdlYsHFH+LvKqkeS0i+fSqVNHXsZaeBGHzWaMjb4N4TvLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LwiC/OWT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f9O+pZxq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LwiC/OWT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f9O+pZxq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 376A321199;
	Tue,  4 Mar 2025 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741095063;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/kZrOsa9tD9+gamYifafCzB0KHy2gUJnD71URfRw4Y=;
	b=LwiC/OWTkP/WeUZdhE7OWDVXpS+BIxB/7SQq/wfdzea4Sr6uq6QUxieggheFv2dfKPda9a
	+i1mnaWLYz38avWmV6h4RKJQWsMH+ei0kMS0tUqfZTdi9dL1eEw39Wdilrr12PBREcRaXj
	lZ7yia2utb6WKcAxw46QPR/aHG4G+Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741095063;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/kZrOsa9tD9+gamYifafCzB0KHy2gUJnD71URfRw4Y=;
	b=f9O+pZxqgFl6JNqq3lD/EJxW4dmpa62XN8RQ1Ga/j5d130mXEmPnWaIPx+JdYgC6EZFWyH
	FZ3qEPWipF0SO6BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741095063;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/kZrOsa9tD9+gamYifafCzB0KHy2gUJnD71URfRw4Y=;
	b=LwiC/OWTkP/WeUZdhE7OWDVXpS+BIxB/7SQq/wfdzea4Sr6uq6QUxieggheFv2dfKPda9a
	+i1mnaWLYz38avWmV6h4RKJQWsMH+ei0kMS0tUqfZTdi9dL1eEw39Wdilrr12PBREcRaXj
	lZ7yia2utb6WKcAxw46QPR/aHG4G+Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741095063;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/kZrOsa9tD9+gamYifafCzB0KHy2gUJnD71URfRw4Y=;
	b=f9O+pZxqgFl6JNqq3lD/EJxW4dmpa62XN8RQ1Ga/j5d130mXEmPnWaIPx+JdYgC6EZFWyH
	FZ3qEPWipF0SO6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1742513967;
	Tue,  4 Mar 2025 13:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a+5/BJcAx2f8HgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 04 Mar 2025 13:31:03 +0000
Date: Tue, 4 Mar 2025 14:31:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ima_violations.sh: Update validate() to support
 multiple violations
Message-ID: <20250304133101.GC81126@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
 <20250304115331.524842-2-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304115331.524842-2-zohar@linux.ibm.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi,

> Add support for the number of expected violations.  Include the
> expected number of violations in the output.

Unfortunately this works only on fixed kernel (e.g. the one with v1 of your
"ima: limit both open-writers and ToMToU violations" kernel patchset [1]
(I haven't built v2 [2], but it's really just
s/IMA_LIMIT_VIOLATIONS/IMA_EMITTED_OPENWRITERS/ => it will work)

Testing on any other kernel it fails on first testing after reboot:

# LTP_IMA_LOAD_POLICY=1 LTPROOT="/opt/ltp" PATH="/opt/ltp/testcases/bin:$PATH" ima_violations.sh # openSUSE Tumbleweed 6.13, without your patch
tmpfs is skipped
ima_violations 1 TINFO: Running: ima_violations.sh
ima_violations 1 TINFO: Tested kernel: Linux tss 6.13.1-1-default #1 SMP PREEMPT_DYNAMIC Mon Feb  3 05:33:25 UTC 2025 (1918d13) x86_64 x86_64 x86_64 GNU/Linux
ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.bbGjQQLJIx as tmpdir (tmpfs filesystem)
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
ima_violations 1 TINFO: Formatting ext3 with opts='/dev/loop0'
ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_violations.bbGjQQLJIx/mntpoint
ima_violations 1 TINFO: timeout per run is 0h 5m 0s
ima_violations 1 TINFO: IMA kernel config:
ima_violations 1 TINFO: CONFIG_IMA=y
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=y
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_violations 1 TINFO: CONFIG_IMA_ARCH_POLICY=y
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
ima_violations 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
ima_violations 1 TINFO: CONFIG_IMA_DISABLE_HTABLE=y
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-6.13.1-1-default root=UUID=1e7acd04-4289-49c9-ba76-a406b385cdc9 splash=silent video=1024x768 plymouth.ignore-serial-consoles console=ttyS0 console=tty kernel.softlockup_panic=1 mitigations=auto ignore_loglevel security=selinux selinux=1 enforcing=1 ima_policy=critical_data
ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_violations 1 TINFO: test requires IMA policy:
measure func=FILE_CHECK mask=^MAY_READ euid=0
measure func=FILE_CHECK mask=^MAY_READ uid=0
ima_violations 1 TINFO: WARNING: missing required policy content: 'measure func=FILE_CHECK mask=^MAY_READ euid=0'
ima_violations 1 TINFO: trying to load '/opt/ltp/testcases/data/ima_violations/violations.policy' policy:
measure func=FILE_CHECK mask=^MAY_READ euid=0
measure func=FILE_CHECK mask=^MAY_READ uid=0
ima_violations 1 TINFO: example policy successfully loaded
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TFAIL: open_writers too many violations added: 3 - 1
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TFAIL: ToMToU too many violations added: 6 - 4
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1900: TINFO: LTP version: 20250130
tst_test.c:1904: TINFO: Tested kernel: 6.13.1-1-default #1 SMP PREEMPT_DYNAMIC Mon Feb  3 05:33:25 UTC 2025 (1918d13) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TFAIL: open_writers too many violations added: 9 - 7
ima_violations 4 TINFO: WARNING: policy loaded via LTP_IMA_LOAD_POLICY=1, reboot recommended
ima_mmap.c:41: TPASS: test completed

It keeps failing repeatedly.
I was able to reproduce the problem on SLE15-SP6 (6.4 based) and SLE15-SP4 (5.14 based).

I tried to test also some Debian VM. It fails when run after reboot:

# LTP_IMA_LOAD_POLICY=1 LTPROOT="/opt/ltp" PATH="/opt/ltp/testcases/bin:$PATH" ima_violations.sh # some Debian VM
tmpfs is skipped
ima_violations 1 TINFO: Running: ima_violations.sh
ima_violations 1 TINFO: Tested kernel: Linux tt 6.9.9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.9.9-1 (2024-07-13) x86_64 GNU/Linux
ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.RbX4HA7oZx as tmpdir (tmpfs filesystem)
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
ima_violations 1 TINFO: Formatting ext3 with opts='/dev/loop0'
ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_violations.RbX4HA7oZx/mntpoint
ima_violations 1 TINFO: timeout per run is 0h 5m 0s
ima_violations 1 TINFO: IMA kernel config:
ima_violations 1 TINFO: CONFIG_IMA=y
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_violations 1 TINFO: CONFIG_IMA_SIG_TEMPLATE=y
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-sig"
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_violations 1 TINFO: CONFIG_IMA_ARCH_POLICY=y
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
ima_violations 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-6.9.9-amd64 root=UUID=e55db984-06ad-45d3-9707-dcaec157aebd ro quiet
ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_violations 1 TINFO: test requires IMA policy:
measure func=FILE_CHECK mask=^MAY_READ euid=0
measure func=FILE_CHECK mask=^MAY_READ uid=0
ima_violations 1 TINFO: WARNING: policy is not readable, failure will be treated as TCONF
ima_violations 1 TINFO: trying to load '/opt/ltp/testcases/data/ima_violations/violations.policy' policy:
measure func=FILE_CHECK mask=^MAY_READ euid=0
measure func=FILE_CHECK mask=^MAY_READ uid=0
ima_violations 1 TINFO: example policy successfully loaded
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TFAIL: open_writers too many violations added: 3 - 1
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TFAIL: ToMToU too many violations added: 6 - 4
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1890: TINFO: LTP version: 20240930-58-g15ce5997c
tst_test.c:1894: TINFO: Tested kernel: 6.9.9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.9.9-1 (2024-07-13) x86_64
tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TFAIL: open_writers too many violations added: 9 - 7
ima_mmap.c:41: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
ima_violations 4 TINFO: WARNING: policy loaded via LTP_IMA_LOAD_POLICY=1, reboot recommended

Summary:
passed   0
failed   3
broken   0
skipped  0
warnings 0

But it TCONF when repeatedly run:

ima_violations 1 TCONF: open_writers too many violations added: 13 - 11
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TCONF: ToMToU too many violations added: 16 - 14
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1890: TINFO: LTP version: 20240930-58-g15ce5997c
tst_test.c:1894: TINFO: Tested kernel: 6.9.9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.9.9-1 (2024-07-13) x86_64
tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TCONF: open_writers too many violations added: 19 - 17

I guess this is not what you expected. I wonder what is wrong.

Kind regards,
Petr

[1] https://lore.kernel.org/linux-integrity/20250219162131.416719-1-zohar@linux.ibm.com/
[2] https://lore.kernel.org/linux-integrity/20250228205505.476845-1-zohar@linux.ibm.com/

