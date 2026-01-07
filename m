Return-Path: <linux-integrity+bounces-8195-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB848CFEF85
	for <lists+linux-integrity@lfdr.de>; Wed, 07 Jan 2026 17:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B50FD34D88EB
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jan 2026 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB2A36A02E;
	Wed,  7 Jan 2026 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mSSrjUDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3GR3Z2Cd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mSSrjUDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3GR3Z2Cd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6936997F
	for <linux-integrity@vger.kernel.org>; Wed,  7 Jan 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802820; cv=none; b=SsB5x7oXIfT7HbD9+muWbAKFB2iJOnmG76I23vrciC3sOJ8S4llnajPxCWeP5HqbKkWeB8DjsW6x1q7IkwwavfqTxxcwW0GQlsMWUOUcDx1z+3l10uMMBUALxcwIShSFUemgPScvYcGbaZS65KJXGxSOoU0G+2wRUsvIdls/9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802820; c=relaxed/simple;
	bh=Kz91InJqWj59hrcP0FQjXlPwrG+W4tpXr3ExKUaIk+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToafNbb5rJr+S0BpjSC7xsu2FiaLmAfUiPmsDkSqlld+ZEduNfqb+IePho0uIBmYeHWqznP1EaRq3LqFARbIPF4KMW0aG1B+WfmS783qO7+2jvqractb1OCIok6D8j+xtOcl2N2QjveemFAFvuSXvGe6/XoNh40E2NTKk8Ejy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mSSrjUDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3GR3Z2Cd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mSSrjUDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3GR3Z2Cd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 786975C23C;
	Wed,  7 Jan 2026 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767802810;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWd6xR80JDukzoRheenuqgYvnwM1vC3OP35oL7KMknw=;
	b=mSSrjUDU+JVbzJZ8MFM7D+H5YtcqO1qbPGNEsbTGaLH6cHd5bCzt8qusY1ZiPE8gAwNQX3
	M5cakqV3N/ZApnd1e1ZCNx9X5YUd3FSLzf4D3K+TMF3d+mc0g9KhnKU8os9CDUGZqXyTgW
	JZTR2y6YTjf8tqrJSlHP98/49y/ZRb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767802810;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWd6xR80JDukzoRheenuqgYvnwM1vC3OP35oL7KMknw=;
	b=3GR3Z2CdE5DsTK33+Kx9EThCVfQahSrqMbfgHMOiY6vWlef5ia7ZYfwOWvl9drWtUuQewE
	YDEnKAo5NFY1m+AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767802810;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWd6xR80JDukzoRheenuqgYvnwM1vC3OP35oL7KMknw=;
	b=mSSrjUDU+JVbzJZ8MFM7D+H5YtcqO1qbPGNEsbTGaLH6cHd5bCzt8qusY1ZiPE8gAwNQX3
	M5cakqV3N/ZApnd1e1ZCNx9X5YUd3FSLzf4D3K+TMF3d+mc0g9KhnKU8os9CDUGZqXyTgW
	JZTR2y6YTjf8tqrJSlHP98/49y/ZRb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767802810;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWd6xR80JDukzoRheenuqgYvnwM1vC3OP35oL7KMknw=;
	b=3GR3Z2CdE5DsTK33+Kx9EThCVfQahSrqMbfgHMOiY6vWlef5ia7ZYfwOWvl9drWtUuQewE
	YDEnKAo5NFY1m+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FCD33EA63;
	Wed,  7 Jan 2026 16:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 540bCbqHXmkLNAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 16:20:10 +0000
Date: Wed, 7 Jan 2026 17:20:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] ima_kexec.sh: Detect kernel image
Message-ID: <20260107162000.GD791855@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260107155737.791588-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107155737.791588-1-pvorel@suse.cz>
X-Spam-Flag: NO
X-Spam-Score: -3.50
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]

Hi all,

...
> +	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
> +		uname="$(uname -r)"
> +
> +		# x86_64
> +		f="/boot/vmlinuz-$uname"
> +
> +		# ppc64le, s390x
> +		if [ ! -f "$f" ]; then
> +			f="/boot/vmlinux-$uname"
> +		fi
> +
> +		# aarch64
> +		if [ ! -f "$f" ]; then
> +			f="/boot/Image-$uname"
> +		fi
> +
> +		# aarch64 often uses compression
> +		if [ ! -f "$f" ]; then
> +			f="$(ls /boot/Image-$uname.* || true)"
> +		fi
> +
> +		if [ -f "$f" ]; then
> +			IMA_KEXEC_IMAGE="$f"
> +		fi
> +	fi
> +
>  	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
>  		tst_brk TCONF "kernel image not found, specify path in \$IMA_KEXEC_IMAGE"
>  	fi

I'm sorry for the noise, I found our s390x emulation actually uses
/boot/image-$uname.  I suggest in the end to merge with following diff.

Kind regards,
Petr

+++ testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -69,18 +69,16 @@ setup()
 	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
 		uname="$(uname -r)"
 
-		# x86_64
-		f="/boot/vmlinuz-$uname"
-
-		# ppc64le, s390x
-		if [ ! -f "$f" ]; then
-			f="/boot/vmlinux-$uname"
-		fi
-
-		# aarch64
-		if [ ! -f "$f" ]; then
-			f="/boot/Image-$uname"
-		fi
+		for f in \
+			/boot/vmlinuz-$uname \
+			/boot/vmlinux-$uname \
+			/boot/Image-$uname \
+			/boot/image-$uname \
+		; do
+			if [ -f "$f" ]; then
+				break
+			fi
+		done
 
 		# aarch64 often uses compression
 		if [ ! -f "$f" ]; then

