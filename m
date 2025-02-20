Return-Path: <linux-integrity+bounces-4947-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065E7A3E4D9
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 20:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253123BCBA0
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 19:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC8A2638B4;
	Thu, 20 Feb 2025 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cFKOxLHn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cnKlinJ6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cFKOxLHn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cnKlinJ6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D261DE8A8
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078833; cv=none; b=QNCoQdSBVZT1nIEWPfcQGxsOrhrL8ity7fBb166GMnTAJqGZL6gxyTKU21xXH+Is05zU5nAxMn2s3yBI9TA+WNQNkVlqJk0eregCnPB9tC+KXwJX106XyZRx25B5mT5jeeAiKmPhdYpWk2v1md71aPkS2IKs3wevLgKo8sr6xAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078833; c=relaxed/simple;
	bh=30ElvISlLECJfUHZxDds29v+ycNASFYtqULWlWpVXq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXYavfQOmltEpr71Y4Roq8KoapUDJDg9RizZx0zm2r7znS79rDwRRzGXxuV12RKaHpJa8IiiNUWoe4GQQeLLvhkaEN1BkFssoUKYMiGP/BtrZ9GuI4V+X16Drs1k/O3RPupNsu3KBubojduXAquhQpmFZ5aoe86lW/9i62u5JQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cFKOxLHn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cnKlinJ6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cFKOxLHn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cnKlinJ6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 604B41F387;
	Thu, 20 Feb 2025 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740078829;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlzUcSTDSEkNHy8Fobz9oUsMdz91Ct8W7U/s9j/zWSI=;
	b=cFKOxLHn1FMUwUmSUNg2I+gsPkGtdFAeRVKew+EljQfPRG9PTJiQbIoprhMc8XE1D6AbaZ
	AqULBPwhm8TPq5XIAqO98MMILW8h9VRJW4/oOYNPSzh6JeLWHiIsefHc8CJEMdQY7EVAo9
	K7tEtyIo+MGoPH8XPo5r2l5o7ZwKwmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740078829;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlzUcSTDSEkNHy8Fobz9oUsMdz91Ct8W7U/s9j/zWSI=;
	b=cnKlinJ6clYdZuhNWVmTTgfhR4mMWILShB7bxf4WnuGq7kv9aud2RqZ2XVxs0UUeihA0pq
	4nqRGZoxZ6kCbwCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740078829;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlzUcSTDSEkNHy8Fobz9oUsMdz91Ct8W7U/s9j/zWSI=;
	b=cFKOxLHn1FMUwUmSUNg2I+gsPkGtdFAeRVKew+EljQfPRG9PTJiQbIoprhMc8XE1D6AbaZ
	AqULBPwhm8TPq5XIAqO98MMILW8h9VRJW4/oOYNPSzh6JeLWHiIsefHc8CJEMdQY7EVAo9
	K7tEtyIo+MGoPH8XPo5r2l5o7ZwKwmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740078829;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlzUcSTDSEkNHy8Fobz9oUsMdz91Ct8W7U/s9j/zWSI=;
	b=cnKlinJ6clYdZuhNWVmTTgfhR4mMWILShB7bxf4WnuGq7kv9aud2RqZ2XVxs0UUeihA0pq
	4nqRGZoxZ6kCbwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D99213301;
	Thu, 20 Feb 2025 19:13:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +prKIOx+t2e0NgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 19:13:48 +0000
Date: Thu, 20 Feb 2025 20:13:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] ima: additional ToMToU violation tests
Message-ID: <20250220191342.GA2716312@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-3-zohar@linux.ibm.com>
 <20250220181604.GA2709977@pevik>
 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
X-Spam-Score: -7.50
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

> On Thu, 2025-02-20 at 19:16 +0100, Petr Vorel wrote:
> > Hi Mimi,

> > > Kernel patch "ima: limit the number of ToMToU integrity violations"
> > > prevents superfluous ToMToU violations.  Add corresponding LTP tests.

> > > Link:
> > > https://lore.kernel.org/linux-integrity/20250219162131.416719-3-zohar@linux.ibm.com/
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

> > Unfortunately tests fail on both mainline kernel and kernel with your patches.

> The new LTP IMA violations patches should fail without the associated kernel patches.

> > Any hint what could be wrong?

> Of course it's dependent on the IMA policy.  The tests assume being booted with the IMA
> TCB measurement policy or similar policy being loaded.  Can you share the IMA policy?
> e.g. cat /sys/kernel/security/ima/policy

> thanks,

> Mimi

Now testing on kernel *with* your patches. First run always fails, regardless
whether using ima_policy=tcb or
/opt/ltp/testcases/data/ima_violations/violations.policy).

Kind regards,
Petr

First run fails:

# LTP_IMA_LOAD_POLICY=1 LTPROOT="/opt/ltp" PATH="/opt/ltp/testcases/bin:$PATH" ima_violations.sh
(policy is /opt/ltp/testcases/data/ima_violations/violations.policy)
ima_violations 1 TINFO: Running: ima_violations.sh 
ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-default #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86_64 x86_64 GNU/Linux
ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.XR34KhtnDM as tmpdir (tmpfs filesystem)
tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
ima_violations 1 TINFO: Formatting ext3 with opts='/dev/loop0'
ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_violations.XR34KhtnDM/mntpoint 
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
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc3-1.gb6b4102-default root=UUID=e36b2366-1af2-4408-903c-1fca82c60f4c splash=silent video=1024x768 plymouth.ignore-serial-consoles console=ttyS0 console=tty kernel.softlockup_panic=1 resume=/dev/disk/by-uuid/c3b865f9-5d5b-410e-a6d1-9ebcf721584c mitigations=auto security=apparmor ignore_loglevel
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
ima_violations 1 TFAIL: open_writers too many violations added: 2 - 0
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TPASS: 1 ToMToU violation(s) added
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TPASS: 1 open_writers violation(s) added
ima_mmap.c:41: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
ima_violations 4 TINFO: verify limiting single open writer violation
ima_violations 4 TPASS: 1 open_writers violation(s) added
ima_violations 5 TINFO: verify limiting multiple open writers violations
ima_violations 5 TPASS: 1 open_writers violation(s) added
ima_violations 6 TINFO: verify new open writer causes additional violation
ima_violations 6 TPASS: 2 open_writers violation(s) added
ima_violations 7 TINFO: verify limiting single open reader ToMToU violations
ima_violations 7 TPASS: 1 ToMToU violation(s) added
ima_violations 8 TINFO: verify new open reader causes additional ToMToU violation
ima_violations 8 TPASS: 2 ToMToU violation(s) added
ima_violations 9 TINFO: WARNING: policy loaded via LTP_IMA_LOAD_POLICY=1, reboot recommended

Summary:
passed   7
failed   1
broken   0
skipped  0
warnings 0

Second run is ok:
# LTPROOT="/opt/ltp" PATH="/opt/ltp/testcases/bin:$PATH" ima_violations.sh
ima_violations 1 TINFO: Running: ima_violations.sh 
ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-default #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86_64 x86_64 GNU/Linux
ima_violations 1 TINFO: Using /var/tmp/LTP_ima_violations.SWERFjvPTp as tmpdir (btrfs filesystem)
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
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc3-1.gb6b4102-default root=UUID=e36b2366-1af2-4408-903c-1fca82c60f4c splash=silent video=1024x768 plymouth.ignore-serial-consoles console=ttyS0 console=tty kernel.softlockup_panic=1 resume=/dev/disk/by-uuid/c3b865f9-5d5b-410e-a6d1-9ebcf721584c mitigations=auto security=apparmor ignore_loglevel
ima_violations 1 TINFO: test requires IMA policy:
measure func=FILE_CHECK mask=^MAY_READ euid=0
measure func=FILE_CHECK mask=^MAY_READ uid=0
ima_violations 1 TINFO: SUT has required policy content
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TPASS: 1 open_writers violation(s) added
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TPASS: 1 ToMToU violation(s) added
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TPASS: 1 open_writers violation(s) added
ima_mmap.c:41: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
ima_violations 4 TINFO: verify limiting single open writer violation
ima_violations 4 TPASS: 1 open_writers violation(s) added
ima_violations 5 TINFO: verify limiting multiple open writers violations
ima_violations 5 TPASS: 1 open_writers violation(s) added
ima_violations 6 TINFO: verify new open writer causes additional violation
ima_violations 6 TPASS: 2 open_writers violation(s) added
ima_violations 7 TINFO: verify limiting single open reader ToMToU violations
ima_violations 7 TPASS: 1 ToMToU violation(s) added
ima_violations 8 TINFO: verify new open reader causes additional ToMToU violation
ima_violations 8 TPASS: 2 ToMToU violation(s) added

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0

Reboot and running with ima_policy=tcb also fails on the first time:

# LTPROOT="/opt/ltp" PATH="/opt/ltp/testcases/bin:$PATH" ima_violations.sh 
tmpfs is skipped
ima_violations 1 TINFO: Running: ima_violations.sh 
ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-default #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86_64 x86_64 GNU/Linux
ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.FKQSfezAwR as tmpdir (tmpfs filesystem)
tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
ima_violations 1 TINFO: Formatting ext3 with opts='/dev/loop0'
ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_violations.FKQSfezAwR/mntpoint 
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
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc3-1.gb6b4102-default root=UUID=e36b2366-1af2-4408-903c-1fca82c60f4c splash=silent video=1024x768 plymouth.ignore-serial-consoles console=ttyS0 console=tty kernel.softlockup_panic=1 resume=/dev/disk/by-uuid/c3b865f9-5d5b-410e-a6d1-9ebcf721584c mitigations=auto security=apparmor ignore_loglevel ima_policy=tcb
ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_violations 1 TINFO: booted with IMA policy: tcb
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TFAIL: open_writers too many violations added: 3 - 1
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TPASS: 1 ToMToU violation(s) added
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TPASS: 1 open_writers violation(s) added
ima_mmap.c:41: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
ima_violations 4 TINFO: verify limiting single open writer violation
ima_violations 4 TPASS: 1 open_writers violation(s) added
ima_violations 5 TINFO: verify limiting multiple open writers violations
ima_violations 5 TPASS: 1 open_writers violation(s) added
ima_violations 6 TINFO: verify new open writer causes additional violation
ima_violations 6 TPASS: 2 open_writers violation(s) added
ima_violations 7 TINFO: verify limiting single open reader ToMToU violations
ima_violations 7 TPASS: 1 ToMToU violation(s) added
ima_violations 8 TINFO: verify new open reader causes additional ToMToU violation
ima_violations 8 TPASS: 2 ToMToU violation(s) added

Summary:
passed   7
failed   1
broken   0
skipped  0
warnings 0

Second and later run is again OK
# LTPROOT="/opt/ltp" PATH="/opt/ltp/testcases/bin:$PATH" ima_violations.sh 
tmpfs is skipped
ima_violations 1 TINFO: Running: ima_violations.sh 
ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-default #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86_64 x86_64 GNU/Linux
ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.1Qf6qJuSoo as tmpdir (tmpfs filesystem)
tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
ima_violations 1 TINFO: Formatting ext3 with opts='/dev/loop0'
ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_violations.1Qf6qJuSoo/mntpoint 
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
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc3-1.gb6b4102-default root=UUID=e36b2366-1af2-4408-903c-1fca82c60f4c splash=silent video=1024x768 plymouth.ignore-serial-consoles console=ttyS0 console=tty kernel.softlockup_panic=1 resume=/dev/disk/by-uuid/c3b865f9-5d5b-410e-a6d1-9ebcf721584c mitigations=auto security=apparmor ignore_loglevel ima_policy=tcb
ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_violations 1 TINFO: booted with IMA policy: tcb
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TPASS: 1 open_writers violation(s) added
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TPASS: 1 ToMToU violation(s) added
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TPASS: 1 open_writers violation(s) added
ima_mmap.c:41: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
ima_violations 4 TINFO: verify limiting single open writer violation
ima_violations 4 TPASS: 1 open_writers violation(s) added
ima_violations 5 TINFO: verify limiting multiple open writers violations
ima_violations 5 TPASS: 1 open_writers violation(s) added
ima_violations 6 TINFO: verify new open writer causes additional violation
ima_violations 6 TPASS: 2 open_writers violation(s) added
ima_violations 7 TINFO: verify limiting single open reader ToMToU violations
ima_violations 7 TPASS: 1 ToMToU violation(s) added
ima_violations 8 TINFO: verify new open reader causes additional ToMToU violation
ima_violations 8 TPASS: 2 ToMToU violation(s) added

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0

