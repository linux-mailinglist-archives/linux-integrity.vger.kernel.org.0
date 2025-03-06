Return-Path: <linux-integrity+bounces-5137-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C4CA55303
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 18:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7FA1882955
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6981922ED;
	Thu,  6 Mar 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L7pm3+Tm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8htN2tAi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L7pm3+Tm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8htN2tAi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808E255E54
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281991; cv=none; b=CfyI8XnCyXhDu6uWgJ9MUlbCWvexbTbbQazOkxlLMTIkkr5bFtQgkqOtYR3z1GW3/mCXuZrzglBy0Kgo+BG+jHFsML/t9enSS7RxuyG+dnLj0TcqWDqJ2URWUZdKqjGgZqUKZsMFfDlzVNbaCkbKetNLslFyxTCcGYLJw6jNGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281991; c=relaxed/simple;
	bh=qiPHH4LccwHkpH+Ol3hOdscXJRpYBXbxTj2hoCjs4rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3zKm5sSzi7UZMefxYd8mIsyRF3G9+6S5bg4JGNkrmOafva/xqq6dWAr0AwiEmURge3kXZ0lxG4hirmnTWZk1GlrxQbN7OFGjrelKUeyGSVC2oQc7/9pqY5vAoNaddBaktIt5+gPyXBU0bLJ7dCKNHV0A9EAFp+2JORORUDMz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L7pm3+Tm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8htN2tAi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L7pm3+Tm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8htN2tAi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27DA32118D;
	Thu,  6 Mar 2025 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741281988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmGmfy2uHW8AaKSzaBV9xdsoBubhk5MJ3iEAl3p4Sho=;
	b=L7pm3+Tm7TXF9jFFNt2o3CsZauQIQIniQUQELNqhQ1WmLX6j+CJEocpnQSX5FD49O4L5z/
	QdDBrgfGUaYhK2IPcDZJ9yPY+1dBgeywAw8cJiUGze8gKhG35YVOre0j5M+MEHNFYrPtN1
	bbUAlV8sIysYwbVNZeW8AVwKs5VLBt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741281988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmGmfy2uHW8AaKSzaBV9xdsoBubhk5MJ3iEAl3p4Sho=;
	b=8htN2tAieookVO5Y1M+uBFwrwXXNHL2fuxZtzYRcIsaIeEskXA/fH/Tjl3jJgHlyZLX0zk
	ryGYbaZj3iJeDmDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L7pm3+Tm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8htN2tAi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741281988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmGmfy2uHW8AaKSzaBV9xdsoBubhk5MJ3iEAl3p4Sho=;
	b=L7pm3+Tm7TXF9jFFNt2o3CsZauQIQIniQUQELNqhQ1WmLX6j+CJEocpnQSX5FD49O4L5z/
	QdDBrgfGUaYhK2IPcDZJ9yPY+1dBgeywAw8cJiUGze8gKhG35YVOre0j5M+MEHNFYrPtN1
	bbUAlV8sIysYwbVNZeW8AVwKs5VLBt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741281988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmGmfy2uHW8AaKSzaBV9xdsoBubhk5MJ3iEAl3p4Sho=;
	b=8htN2tAieookVO5Y1M+uBFwrwXXNHL2fuxZtzYRcIsaIeEskXA/fH/Tjl3jJgHlyZLX0zk
	ryGYbaZj3iJeDmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E22813A61;
	Thu,  6 Mar 2025 17:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F1twHcPayWfMOwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 06 Mar 2025 17:26:27 +0000
Date: Thu, 6 Mar 2025 18:26:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 5/5] ima_violations.sh: require kernel v6.14 for
 minimizing violations tests
Message-ID: <20250306172622.GB186319@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250305145421.638857-1-zohar@linux.ibm.com>
 <20250305145421.638857-5-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305145421.638857-5-zohar@linux.ibm.com>
X-Rspamd-Queue-Id: 27DA32118D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi Mimi,

> Depending on the IMA policy and the number of violations, the kernel
> patches for minimizing the number of open-writers and ToMToU (Time of
> Measure Time of Use) violations may be a major performance improvement.

I would prefer this to be squashed into "ima_violations.sh: additional
open-writer violation tests" commit, which adds this incompatibility.

But it's a minor detail, therefore I merged whole patchset as is.

Thanks!

Kind regards,
Petr

> Most likely the kernel patches will be back ported, but for now limit
> the new tests to new kernels with the applied patches.  Bail after the
> first new test.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .../kernel/security/integrity/ima/tests/ima_violations.sh     | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 0395f8d0a..8e988fca6 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -177,6 +177,10 @@ test4()
>  {
>  	tst_res TINFO "verify limiting single open writer violation"

> +	if tst_kvcmp -lt 6.14; then
> +		tst_brk TCONF "Minimizing violations requires kernel 6.14 or newer"
> +	fi
> +
>  	local search="open_writers"
>  	local count num_violations

