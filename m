Return-Path: <linux-integrity+bounces-4937-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988FBA3E39E
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 19:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE3B42160B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D995214803;
	Thu, 20 Feb 2025 18:16:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D321504B
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075371; cv=none; b=ABrhpcLRGeaAsohUsMRmo/PRot205vXuDEJ4e0UseH8NBMZxkl+gLLaL+iFtfiX5kXq+gPPZAkWwLcqxzErm/YZbTqxzNl1Bpbdmxq6le1IhiIJYNC5KYvugT/C08OZrFU0EzGvDRiSkkVIq3UzhWWKH3w66ekfRCNN9x8qj9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075371; c=relaxed/simple;
	bh=EJgZqsofTnBrCwGNEqheqjf9VxiFdN1LaGnmhpfB0Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkOwgZGegyFbRREDZnKzRuKQMu72t4SSNKKYgblEbNsd9mFwbVW3VUHVXYjjYyinTi7VonLIKTkwgxPNKlFRTzn/4ZH3DZDjwWfUL2Ne19pRDm2IcsD5YUZKqfgiVyfagRrn6H35gHk5/tBOFql6I6Icrisr8Jf1xjNw9+g9wgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77C3B1F387;
	Thu, 20 Feb 2025 18:16:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36A0C13A42;
	Thu, 20 Feb 2025 18:16:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HW+lCWZxt2dtJgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 18:16:06 +0000
Date: Thu, 20 Feb 2025 19:16:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] ima: additional ToMToU violation tests
Message-ID: <20250220181604.GA2709977@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-3-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220160054.12149-3-zohar@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 77C3B1F387
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Hi Mimi,

> Kernel patch "ima: limit the number of ToMToU integrity violations"
> prevents superfluous ToMToU violations.  Add corresponding LTP tests.

> Link: https://lore.kernel.org/linux-integrity/20250219162131.416719-3-zohar@linux.ibm.com/
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Unfortunately tests fail on both mainline kernel and kernel with your patches.

Any hint what could be wrong?

Mainline kernel (on kernel with your patches it looks the same):
ima_violations 1 TINFO: Running: ima_violations.sh
ima_violations 1 TINFO: Tested kernel: Linux ts 6.13.0-2.g0127a37-default #1 SMP PREEMPT_DYNAMIC Thu Jan 23 11:21:55 UTC 2025 (0127a37) x86_64 x86_64 x86_64 GNU/Linux
ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.cKm34XVZk2 as tmpdir (tmpfs filesystem)
tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
ima_violations 1 TINFO: Formatting ext3 with opts='/dev/loop0'
ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_violations.cKm34XVZk2/mntpoint
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
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-6.13.0-2.g0127a37-default root=UUID=e36b2366-1af2-4408-903c-1fca82c60f4c splash=silent video=1024x768 plymouth.ignore-serial-consoles console=ttyS0 console=tty kernel.softlockup_panic=1 resume=/dev/disk/by-uuid/c3b865f9-5d5b-410e-a6d1-9ebcf721584c mitigations=auto security=apparmor ignore_loglevel
ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_violations 1 TINFO: test requires IMA policy:
measure func=FILE_CHECK mask=^MAY_READ euid=0
measure func=FILE_CHECK mask=^MAY_READ uid=0
ima_violations 1 TINFO: SUT has required policy content
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TFAIL: open_writers too many violations added
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TFAIL: ToMToU too many violations added
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
tst_test.c:1904: TINFO: Tested kernel: 6.13.0-2.g0127a37-default #1 SMP PREEMPT_DYNAMIC Thu Jan 23 11:21:55 UTC 2025 (0127a37) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TFAIL: open_writers too many violations added
ima_mmap.c:41: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
ima_violations 4 TINFO: verify limiting single open writer violation
ima_violations 4 TFAIL: open_writers too many violations added
ima_violations 5 TINFO: verify limiting multiple open writers violations
ima_violations 5 TFAIL: open_writers too many violations added
ima_violations 6 TINFO: verify new open writer causes additional violation
ima_violations 6 TFAIL: open_writers too many violations added
ima_violations 7 TINFO: verify limiting single open reader ToMToU violations
ima_violations 7 TFAIL: ToMToU too many violations added
ima_violations 8 TINFO: verify new open reader causes additional ToMToU violation
ima_violations 8 TFAIL: ToMToU too many violations added

Kind regards,
Petr

