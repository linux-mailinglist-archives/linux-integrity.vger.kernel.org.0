Return-Path: <linux-integrity+bounces-6786-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413ACB1E333
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Aug 2025 09:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D96188E6B5
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Aug 2025 07:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C407423C8A4;
	Fri,  8 Aug 2025 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k7bBY8xL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K7sB95iA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k7bBY8xL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K7sB95iA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA536225415
	for <linux-integrity@vger.kernel.org>; Fri,  8 Aug 2025 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637413; cv=none; b=o3KsON1rnfJTgcBQfeHJU5utY9/TbtzECjuIIIJpfr/gWNr0UbSnPePCbe5/rOb4WjNjyig4H+3e3s/zpD0p+ndat4/+JxHoBxmggQto2n6pduAEXCl6KG1O5fZsj+WyMIvelB1G9Sbx/JQmZUAlibaQ1h1v9S95d4RKft5NZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637413; c=relaxed/simple;
	bh=/RMT7NTp1oEFoLLROxxuFlP024+37FuV4HdTXu/aOV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/rJl+IkdEPnBDSHJp3yHnQzpfxsfMDaGh2DJtZ+Zd4K54SS2phdST/yw+N37Y2vM6u0HuaIrhryBCZOV6heZnnSRdQ66PROXBlUH5pi5oRiZW3+mD8ejqKA0bc0mO7gT9bT2sSENQuTVr/jZ49pgKrGDoMloFjbnaZyGiXW2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k7bBY8xL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K7sB95iA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k7bBY8xL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K7sB95iA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5DCC5BDB8;
	Fri,  8 Aug 2025 07:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754637403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=St0Eh41srmPo5Myog46kRVAv2peqCfbBZggyHocAocw=;
	b=k7bBY8xL+Kr4ECaQ5f/3I8Kizo2JMds238KUeeBUC/f5mu2QDiB9s0DRrbVVX9DEEYi8/U
	GJ/mmfGww5pEvaTqeYyt0btSKosdnYFZvThMNOMCzAPEwKk5SW2b58YqvtCmlt9Jyh2/Gf
	hx3f1bcqp8f0Lm/6L0FLpnfUc0InX+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754637403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=St0Eh41srmPo5Myog46kRVAv2peqCfbBZggyHocAocw=;
	b=K7sB95iAmVh/48NcKZwsIZCE2rzmXIpjT6YJw0xkTUhARSx0vmOu29cV4lCh7R6cMG8t+p
	Awdw8RESjTprCLBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k7bBY8xL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K7sB95iA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754637403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=St0Eh41srmPo5Myog46kRVAv2peqCfbBZggyHocAocw=;
	b=k7bBY8xL+Kr4ECaQ5f/3I8Kizo2JMds238KUeeBUC/f5mu2QDiB9s0DRrbVVX9DEEYi8/U
	GJ/mmfGww5pEvaTqeYyt0btSKosdnYFZvThMNOMCzAPEwKk5SW2b58YqvtCmlt9Jyh2/Gf
	hx3f1bcqp8f0Lm/6L0FLpnfUc0InX+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754637403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=St0Eh41srmPo5Myog46kRVAv2peqCfbBZggyHocAocw=;
	b=K7sB95iAmVh/48NcKZwsIZCE2rzmXIpjT6YJw0xkTUhARSx0vmOu29cV4lCh7R6cMG8t+p
	Awdw8RESjTprCLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8531113A7E;
	Fri,  8 Aug 2025 07:16:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t5/PHVuklWhnKwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 08 Aug 2025 07:16:43 +0000
Date: Fri, 8 Aug 2025 09:16:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] tst_security.sh: Use the same value for checkreqprot
Message-ID: <20250808071632.GA406350@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250425125057.38992-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425125057.38992-1-pvorel@suse.cz>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C5DCC5BDB8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,paul-moore.com,vger.kernel.org,linux.microsoft.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -2.21

Hi all,

FYI patch merged.

Kind regards,
Petr

> kernel commit e9c38f9fc2cc ("Documentation,selinux: deprecate setting
> checkreqprot to 1") from v5.10-rc1 deprecated checkreqprot value 1
> (emit warning in dmesg). Code is used only in ima_selinux.sh
> which requires 5.12. Touching /sys/fs/selinux/checkreqprot is required
> to trigger the measurement via selinux_ima_measure_state().

> Using the same value (0 by default) works on recent 6.14, it should be
> safe changing to use the same value. This way misleading warning is
> avoided and hopefully kept working in the future.

> Also, this way it does not modify SUT setting (don't influence other
> tests), which is always better.

> Fixes: 36c695e497 ("tst_security.sh: Add helper tst_update_selinux_state()")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> @SELinux developers: FYI tst_security.sh is used in LTP test in
> ima_selinux.sh [1] test.

> Kind regards,
> Petr

> [1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh

>  testcases/lib/tst_security.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

> diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
> index 4e2d34ca98..820736c723 100644
> --- a/testcases/lib/tst_security.sh
> +++ b/testcases/lib/tst_security.sh
> @@ -142,11 +142,10 @@ tst_get_enforce()

>  tst_update_selinux_state()
>  {
> -	local cur_val new_val
> +	local val
>  	local dir=$(tst_get_selinux_dir)
>  	[ -n "$dir" ] || return 1

> -	cur_val=$(cat $dir/checkreqprot)
> -	[ $cur_val = 1 ] && new_val=0 || new_val=1
> -	echo $new_val > $dir/checkreqprot
> +	val=$(cat $dir/checkreqprot)
> +	echo $val > $dir/checkreqprot
>  }

