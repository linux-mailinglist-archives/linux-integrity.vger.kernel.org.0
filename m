Return-Path: <linux-integrity+bounces-7079-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCFAB57293
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 10:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B42718924B8
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 08:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80BC2EA477;
	Mon, 15 Sep 2025 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DhxtuIjK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W+K2gdsw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DhxtuIjK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W+K2gdsw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314592D4B61
	for <linux-integrity@vger.kernel.org>; Mon, 15 Sep 2025 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923843; cv=none; b=B1GqxdmeX6ifLvbCNFG6em6x2hTXmv5OFrzXWyOBExQyn7fP5wNd4yrAmYi/XSKmoXtPuodDrmIM/jc2J5LP19ejME2buk4OlQO4QnCzVVPq1AorImaa6sa9RiuxqJtXoDOg1LnGwFTGYd2qNT1pJxI1n0COoX1cTapLgKwHnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923843; c=relaxed/simple;
	bh=ydyKws+nqEg8H/nF9V4OWWxJt3j/OvMlxMlg9asjmH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFUgcyVK57qkR9se/ct78fvmf06G993NxXRdYWKz1r8wrkR/KbvIqeakbkFsMlvfesyJhwgQHeVh0xAbusyrZhBEhyiH0hIYzmmk66WxOiJdzwqa2MXjQbfDQefZFNZltM+0+Jw4wncPVEp1dd1pKYej7fBL32ba5Q4XTR0jUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DhxtuIjK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W+K2gdsw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DhxtuIjK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W+K2gdsw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AD3322274;
	Mon, 15 Sep 2025 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757923840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLaR5hpCkQB0JLaDrirBNLA3y9+oo8Li0ikMURch4Wk=;
	b=DhxtuIjKdzUVuObQ8CnLmSCjJjtDkbeLC0dQJwJOubVVqb+Jb9VA5gmQhZM1VGHb5SBzNU
	vxAJQKHcikn/6ZsMpgmndncs+2YlW7J4BhDh8/syFZlcv9d6lepoMOTvJd08UfV5ijmmIo
	rGtXmFZZNn60WuJrcRyucyF1+FLdo7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757923840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLaR5hpCkQB0JLaDrirBNLA3y9+oo8Li0ikMURch4Wk=;
	b=W+K2gdsws45tNWecIv+J1rVs5Z2GeW6fvStYXbek4hhkmD7o/YnNqQF8KcsSeSP5M/Fryj
	j2yEFpYy0ytRQzCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DhxtuIjK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W+K2gdsw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757923840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLaR5hpCkQB0JLaDrirBNLA3y9+oo8Li0ikMURch4Wk=;
	b=DhxtuIjKdzUVuObQ8CnLmSCjJjtDkbeLC0dQJwJOubVVqb+Jb9VA5gmQhZM1VGHb5SBzNU
	vxAJQKHcikn/6ZsMpgmndncs+2YlW7J4BhDh8/syFZlcv9d6lepoMOTvJd08UfV5ijmmIo
	rGtXmFZZNn60WuJrcRyucyF1+FLdo7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757923840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLaR5hpCkQB0JLaDrirBNLA3y9+oo8Li0ikMURch4Wk=;
	b=W+K2gdsws45tNWecIv+J1rVs5Z2GeW6fvStYXbek4hhkmD7o/YnNqQF8KcsSeSP5M/Fryj
	j2yEFpYy0ytRQzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 347761368D;
	Mon, 15 Sep 2025 08:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v6olDADKx2jpYQAAD6G6ig
	(envelope-from <akumar@suse.de>); Mon, 15 Sep 2025 08:10:40 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Coiby Xu <coxu@redhat.com>, selinux@vger.kernel.org,
 linux-integrity@vger.kernel.org
Subject:
 Re: [LTP] [PATCH 1/2] ima_policy.sh: Optimize check for policy writable
Date: Mon, 15 Sep 2025 10:10:39 +0200
Message-ID: <12750853.O9o76ZdvQC@thinkpad>
In-Reply-To: <20250912073210.47637-2-pvorel@suse.cz>
References:
 <20250912073210.47637-1-pvorel@suse.cz>
 <20250912073210.47637-2-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:email,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4AD3322274
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

Hi,

On Friday, September 12, 2025 9:32:08 AM CEST Petr Vorel wrote:
> Previously policy was checked in setup and in all tests
> (redundant in test1). It should be enough to test in setup and after
> write in test1, but let's being careful and test before writing the
nit:
s/let's being/let's be
> policy in load_policy().
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Avinesh Kumar <akumar@suse.de>
for both the patches.

Regards,
Avinesh
> ---
>  .../kernel/security/integrity/ima/tests/ima_policy.sh      | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> index af1fb0028c..1c4763d838 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2009 IBM Corporation
> -# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2018-2025 Petr Vorel <pvorel@suse.cz>
>  # Author: Mimi Zohar <zohar@linux.ibm.com>
>  #
>  # Test replacing the default integrity measurement policy.
> @@ -11,8 +11,6 @@ TST_CNT=2
>  
>  setup()
>  {
> -	require_policy_writable
> -
>  	VALID_POLICY="$TST_DATAROOT/measure.policy"
>  	[ -f $VALID_POLICY ] || tst_brk TCONF "missing $VALID_POLICY"
>  
> @@ -24,6 +22,7 @@ load_policy()
>  {
>  	local ret
>  
> +	require_policy_writable
>  	exec 2>/dev/null 4>$IMA_POLICY
>  	[ $? -eq 0 ] || exit 1
>  
> @@ -43,7 +42,6 @@ test1()
>  
>  	local p1
>  
> -	require_policy_writable
>  	load_policy $INVALID_POLICY & p1=$!
>  	wait "$p1"
>  	if [ $? -ne 0 ]; then
> @@ -59,7 +57,6 @@ test2()
>  
>  	local p1 p2 rc1 rc2
>  
> -	require_policy_writable
>  	load_policy $VALID_POLICY & p1=$!
>  	load_policy $VALID_POLICY & p2=$!
>  	wait "$p1"; rc1=$?
> 





