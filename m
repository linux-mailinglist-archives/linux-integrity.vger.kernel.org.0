Return-Path: <linux-integrity+bounces-5172-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481CAA5652D
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 11:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396117A9B22
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679D20E302;
	Fri,  7 Mar 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="206iIpJG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tcYZkfrI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="206iIpJG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tcYZkfrI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D004C1E1DEB
	for <linux-integrity@vger.kernel.org>; Fri,  7 Mar 2025 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343087; cv=none; b=q0Z3Bh6y/874ICY11rGTeqTPtnJHyuhaPnhov7QC7NSkoJnO8/1CmWVoSs7yiuB/nHPEq3uM5OzV3iIxJkYuccl3ON1z9ZG2gGRoEh9aKDV10X7nKKzHhf1t6C9/CRd3afvIALrgW6+segVSD1R5r/UtcvQk55qqDEsvcq5jhlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343087; c=relaxed/simple;
	bh=9NK4kAU3Jk0q0w/csh5gk3rTHDVluqtvpKiyOHt+fQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYIJ3yFCc/vrRmmlOzpBr0Yh0WanPZ0lAlmvHpDooMD0Sv4eyqrvS3lX7Jx5actzwoAx5tS3xXLnCxIu2rrB+UXVGcewFy6LqwH+VRh6Ip0IhxsPXpekCyZYVC7UnDvRTGiiOGvJytV89Y/H6opWXTGpDmIKRuvTjicWigJQP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=206iIpJG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tcYZkfrI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=206iIpJG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tcYZkfrI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60BA91F38E;
	Fri,  7 Mar 2025 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741343076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xGBPuazfuU8d/m3KNTLHqkIQ7W1iEh+aUAC591BnAzA=;
	b=206iIpJGngdxUtvntAfhGRGxs3+MOsXh2WIPsBDaihYSQ793WnV47LuqiYONxLB58nC6b/
	sfikihV2XKHby1UqDbbn/61bWNxNuIkEsHB3Ofx2Ew2QsIxU2Srm9BcVUbqJOeDt+a92Bt
	1oK9nhhuTwXm/PbbyW3fJL6EPEIyBA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741343076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xGBPuazfuU8d/m3KNTLHqkIQ7W1iEh+aUAC591BnAzA=;
	b=tcYZkfrIFot+qp5/FVk1z9/TzWiE09MTaXHX6nTt/ZxWCfXAUWQLqFA2X99rzmo+Rk5cNn
	CrSNbkkjD/EOtDAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=206iIpJG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tcYZkfrI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741343076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xGBPuazfuU8d/m3KNTLHqkIQ7W1iEh+aUAC591BnAzA=;
	b=206iIpJGngdxUtvntAfhGRGxs3+MOsXh2WIPsBDaihYSQ793WnV47LuqiYONxLB58nC6b/
	sfikihV2XKHby1UqDbbn/61bWNxNuIkEsHB3Ofx2Ew2QsIxU2Srm9BcVUbqJOeDt+a92Bt
	1oK9nhhuTwXm/PbbyW3fJL6EPEIyBA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741343076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xGBPuazfuU8d/m3KNTLHqkIQ7W1iEh+aUAC591BnAzA=;
	b=tcYZkfrIFot+qp5/FVk1z9/TzWiE09MTaXHX6nTt/ZxWCfXAUWQLqFA2X99rzmo+Rk5cNn
	CrSNbkkjD/EOtDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C269113939;
	Fri,  7 Mar 2025 10:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VQnzJmPJymdNWQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 07 Mar 2025 10:24:35 +0000
Date: Fri, 7 Mar 2025 11:24:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	Ignaz Forster <iforster@suse.de>
Subject: Re: [RFC PATCH] IMA: Remove evm_overlay.sh
Message-ID: <20250307102429.GA272497@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250114113239.611278-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114113239.611278-1-pvorel@suse.cz>
X-Rspamd-Queue-Id: 60BA91F38E
X-Spam-Score: -3.71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi, Ignaz,

> Proof of concept, it was never fixed in the kernel.
> Instead we should have some basic EVM tests.

gently ping. Is evm_overlay.sh test useful for you?
Otherwise I'll delete it.

Kind regards,
Petr

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/ima                                   |  1 -
>  .../kernel/security/integrity/ima/README.md   | 64 -------------
>  .../integrity/ima/tests/evm_overlay.sh        | 93 -------------------
>  3 files changed, 158 deletions(-)
>  delete mode 100755 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh

> diff --git a/runtest/ima b/runtest/ima
> index 01942eefa3..75e5a99e7c 100644
> --- a/runtest/ima
> +++ b/runtest/ima
> @@ -7,4 +7,3 @@ ima_keys ima_keys.sh
>  ima_kexec ima_kexec.sh
>  ima_selinux ima_selinux.sh
>  ima_conditionals ima_conditionals.sh
> -evm_overlay evm_overlay.sh
> diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
> index 5b261a1914..d3c3206bf2 100644
> --- a/testcases/kernel/security/integrity/ima/README.md
> +++ b/testcases/kernel/security/integrity/ima/README.md
> @@ -64,67 +64,3 @@ and reading the IMA policy allowed in the kernel configuration:
>  CONFIG_SECURITY_SELINUX=y
>  CONFIG_IMA_READ_POLICY=y
>  ```
> -
> -## EVM tests
> -
> -`evm_overlay.sh` requires a builtin IMA appraise tcb policy (e.g. `ima_policy=appraise_tcb`
> -kernel parameter) which appraises the integrity of all files owned by root and EVM setup.
> -Again, for simplicity ignore possibility to load requires rules via custom policy.
> -
> -Mandatory kernel configuration for EVM tests:
> -```
> -CONFIG_INTEGRITY=y
> -CONFIG_INTEGRITY_SIGNATURE=y
> -CONFIG_IMA=y
> -CONFIG_IMA_APPRAISE=y
> -CONFIG_EVM=y
> -CONFIG_KEYS=y
> -CONFIG_TRUSTED_KEYS=y
> -CONFIG_ENCRYPTED_KEYS=y
> -```
> -
> -Example of preparing environment on for EVM on openSUSE:
> -
> -* Boot install system with `ima_policy=tcb|appraise_tcb ima_appraise=fix evm=fix` kernel parameters
> -  (for IMA measurement, IMA appraisal and EVM protection)
> -* Proceed with installation until summary screen, but do not start the installation yet
> -* Select package `dracut-ima` (required for early boot EVM support) for installation
> -  (Debian based distros already contain IMA + EVM support in `dracut` package)
> -* Change to a console window and run commands to generate keys required by EVM:
> -```
> -# mkdir /etc/keys
> -# user_key=$(keyctl add user kmk-user "`dd if=/dev/urandom bs=1 count=32 2>/dev/null`" @u)
> -# keyctl pipe "$user_key" > /etc/keys/kmk-user.blob
> -# evm_key=$(keyctl add encrypted evm-key "new user:kmk-user 64" @u)
> -# keyctl pipe "$evm_key" >/etc/keys/evm.blob
> -# cat <<END >/etc/sysconfig/masterkey
> -MASTERKEYTYPE="user"
> -MASTERKEY="/etc/keys/kmk-user.blob"
> -END
> -# cat <<END >/etc/sysconfig/evm
> -EVMKEY="/etc/keys/evm.blob"
> -END
> -# mount -t securityfs security /sys/kernel/security
> -# echo 1 >/sys/kernel/security/evm
> -```
> -
> -* Go back to the installation summary screen and start the installation
> -* During the installation execute the following commands from the console:
> -```
> -# cp -r /etc/keys /mnt/etc/ # Debian based distributions: use /target instead of /mnt
> -# cp /etc/sysconfig/{evm,masterkey} /mnt/etc/sysconfig/
> -```
> -
> -This should work on any distribution using dracut.
> -Loading EVM keys is also possible with initramfs-tools (Debian based distributions).
> -
> -Of course it's possible to install OS usual way, add keys later and fix missing xattrs with:
> -```
> -evmctl -r ima_fix /
> -```
> -
> -or with `find` if evmctl is not available:
> -```
> -find / \( -fstype rootfs -o -fstype ext4 -o -fstype btrfs -o -fstype xfs \) -exec sh -c "< '{}'" \;
> -```
> -Again, fixing requires `ima_policy=tcb|appraise_tcb ima_appraise=fix evm=fix` kernel parameters.
> diff --git a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
> deleted file mode 100755
> index 12b2a28c25..0000000000
> --- a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
> +++ /dev/null
> @@ -1,93 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
> -# Based on reproducer and further discussion with Ignaz Forster <iforster@suse.de>
> -# Reproducer for not upstreamed patchset [1] and previous report [2].
> -# [1] https://www.spinics.net/lists/linux-integrity/msg05926.html
> -# [2] https://www.spinics.net/lists/linux-integrity/msg03593.html
> -
> -TST_SETUP="setup"
> -TST_CLEANUP="cleanup"
> -TST_CNT=4
> -
> -setup()
> -{
> -	EVM_FILE="/sys/kernel/security/evm"
> -
> -	[ -f "$EVM_FILE" ] || tst_brk TCONF "EVM not enabled in kernel"
> -	[ $(cat $EVM_FILE) -eq 1 ] || tst_brk TCONF "EVM not enabled for this boot"
> -
> -	require_ima_policy_cmdline "appraise_tcb"
> -
> -	lower="$TST_MNTPOINT/lower"
> -	upper="$TST_MNTPOINT/upper"
> -	work="$TST_MNTPOINT/work"
> -	merged="$TST_MNTPOINT/merged"
> -	mkdir -p $lower $upper $work $merged
> -
> -	device_backup="$TST_DEVICE"
> -	TST_DEVICE="overlay"
> -
> -	fs_type_backup="$TST_FS_TYPE"
> -	TST_FS_TYPE="overlay"
> -
> -	mntpoint_backup="$TST_MNTPOINT"
> -	TST_MNTPOINT="$PWD/$merged"
> -
> -	params_backup="$TST_MNT_PARAMS"
> -	TST_MNT_PARAMS="-o lowerdir=$lower,upperdir=$upper,workdir=$work"
> -
> -	tst_mount
> -	mounted=1
> -}
> -
> -test1()
> -{
> -	local file="foo1.txt"
> -
> -	tst_res TINFO "overwrite file in overlay"
> -	EXPECT_PASS echo lower \> $lower/$file
> -	EXPECT_PASS echo overlay \> $merged/$file
> -}
> -
> -test2()
> -{
> -	local file="foo2.txt"
> -
> -	tst_res TINFO "append file in overlay"
> -	EXPECT_PASS echo lower \> $lower/$file
> -	EXPECT_PASS echo overlay \>\> $merged/$file
> -}
> -
> -test3()
> -{
> -	local file="foo3.txt"
> -
> -	tst_res TINFO "create a new file in overlay"
> -	EXPECT_PASS echo overlay \> $merged/$file
> -}
> -
> -test4()
> -{
> -	local f
> -
> -	tst_res TINFO "read all created files"
> -	for f in $(find $TST_MNTPOINT -type f); do
> -		EXPECT_PASS cat $f \> /dev/null 2\> /dev/null
> -	done
> -}
> -
> -cleanup()
> -{
> -	[ -n "$mounted" ] || return 0
> -
> -	tst_umount $TST_MNTPOINT
> -
> -	TST_DEVICE="$device_backup"
> -	TST_FS_TYPE="$fs_type_backup"
> -	TST_MNTPOINT="$mntpoint_backup"
> -	TST_MNT_PARAMS="$params_backup"
> -}
> -
> -. ima_setup.sh
> -tst_run

