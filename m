Return-Path: <linux-integrity+bounces-4943-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F74A3E49A
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 20:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B50119C4353
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 19:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1041F257D;
	Thu, 20 Feb 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CUeiATSN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yu9tkbF2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CUeiATSN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yu9tkbF2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D42213E67
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078148; cv=none; b=t3G6v1couuibzQ77GI2BDvjzf+T+PDDsoDd/iKJ/rV97AIPJ7k1KGd+LVQqcBNpAKWJ3N8P9fnlDwGMRqK5YJnRTD2WcGA2z6wnmJaanKd1aB10VNDcPMnqSVUHXaV8AWw/oe8DrwnBvTW/jQDiXO5okHaW9AFDdDTWewhW1rXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078148; c=relaxed/simple;
	bh=hIfuUs8/3gF6QpnSas4d3YYqwEHKieo/YV+d/iaYjNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzXfHfE429xzHSbjNRwzj+zHN8gsIn2HBDNFzRJIthgCZM8B0xjcYdxooOAD2+OptqXEpugmvd93bkBSqGoxFmlWc/nOQ6FuPZyBTUG4yKuSF7vi2voz0Nu9oaafVfXbRWNRcoU7XIoIfge9U6raKibqYso3rEtFSTY56bFWxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CUeiATSN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yu9tkbF2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CUeiATSN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yu9tkbF2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C11D1F387;
	Thu, 20 Feb 2025 19:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740078144;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciRI9kF05ab4dzKr2iurSHt4iXIUuz3B0YUChzh4DW8=;
	b=CUeiATSNBBqJEzfxw4BeY6a9AgcnMKgc+HYwtXxJir51saIfcz7o9jvsYqV+7KjZ85dsW0
	ql2FtB2Z7pjanaPfBFOODGY+andg+gPD03PSwynRkejPJJILQ8F2B1686DI+cd4EwVpFGP
	AdDTEixaL6TaS/fQCRbpu0CfFgP2YdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740078144;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciRI9kF05ab4dzKr2iurSHt4iXIUuz3B0YUChzh4DW8=;
	b=yu9tkbF2A4eeu0gDdEu7IYPHlA+kmJ9CV6u91QvOLdBzJEQWu7eZyTkIkCsJ5bTFcMIsiG
	PQTGpL7dDBJtIiAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740078144;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciRI9kF05ab4dzKr2iurSHt4iXIUuz3B0YUChzh4DW8=;
	b=CUeiATSNBBqJEzfxw4BeY6a9AgcnMKgc+HYwtXxJir51saIfcz7o9jvsYqV+7KjZ85dsW0
	ql2FtB2Z7pjanaPfBFOODGY+andg+gPD03PSwynRkejPJJILQ8F2B1686DI+cd4EwVpFGP
	AdDTEixaL6TaS/fQCRbpu0CfFgP2YdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740078144;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciRI9kF05ab4dzKr2iurSHt4iXIUuz3B0YUChzh4DW8=;
	b=yu9tkbF2A4eeu0gDdEu7IYPHlA+kmJ9CV6u91QvOLdBzJEQWu7eZyTkIkCsJ5bTFcMIsiG
	PQTGpL7dDBJtIiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C57913301;
	Thu, 20 Feb 2025 19:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i2t7BUB8t2eBMwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 19:02:24 +0000
Date: Thu, 20 Feb 2025 20:02:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH 2/3] ima: additional open-writer violation tests
Message-ID: <20250220190218.GB2712942@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-2-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220160054.12149-2-zohar@linux.ibm.com>
X-Spam-Score: -7.50
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi,

> Kernel patch "ima: limit the number of open-writers integrity
> violations" prevents superfluous "open-writers" violations.  Add
> corresponding LTP tests.

> Link: https://lore.kernel.org/linux-integrity/20250219162131.416719-2-zohar@linux.ibm.com/
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .../integrity/ima/tests/ima_violations.sh     | 87 ++++++++++++++++++-
>  1 file changed, 86 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 7f0382fb8..65c5c3a92 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -8,7 +8,7 @@

>  TST_SETUP="setup"
>  TST_CLEANUP="cleanup"
> -TST_CNT=3
> +TST_CNT=6

>  REQUIRED_BUILTIN_POLICY="tcb"
>  REQUIRED_POLICY_CONTENT='violations.policy'
> @@ -60,6 +60,17 @@ close_file_write()
>  	exec 4>&-
>  }

> +open_file_write2()
> +{
> +	exec 5> $FILE || exit 1
maybe:
	exec 5> $FILE || tst_brk TBROK "exec 5> $FILE failed"

Because tst_brk TBROK calls test cleanup. Plain exit kills everything.
We also have ROD, but that requires binaries ('exec' is a shell builtin).
(It applies to the third patch as well.)

> +	echo 'test writing2' >&5
> +}
> +
> +close_file_write2()
> +{
> +	exec 5>&-
> +}
> +
>  get_count()
>  {
>  	local search="$1"
> @@ -160,6 +171,80 @@ test3()
>  	tst_sleep 2s
>  }

> +test4()
> +{
> +	tst_res TINFO "verify limiting single open writer violation"
> +
> +	local search="open_writers"
> +	local count num_violations
> +
> +	read num_violations < $IMA_VIOLATIONS
> +	count="$(get_count $search)"
> +
> +	open_file_write
> +	open_file_read
> +	close_file_read
> +
> +	open_file_read
> +	close_file_read
> +
> +	close_file_write
> +
> +	validate $num_violations $count $search 1
> +}
> +
> +test5()
> +{
> +	tst_res TINFO "verify limiting multiple open writers violations"
> +
> +	local search="open_writers"
> +	local count num_violations
> +
> +	read num_violations < $IMA_VIOLATIONS
> +	count="$(get_count $search)"
> +
> +	open_file_write
> +	open_file_read
> +	close_file_read
> +
> +	open_file_write2
> +	open_file_read
> +	close_file_read
> +	close_file_write2
> +
> +	open_file_read
> +	close_file_read
> +
> +	close_file_write
> +
> +	validate $num_violations $count $search 1
nit: safer to quote
	validate "$num_violations" "$count" "$search" 1
> +}
> +
> +test6()
> +{
> +	tst_res TINFO "verify new open writer causes additional violation"
> +
> +	local search="open_writers"
> +	local count num_violations
> +
> +	read num_violations < $IMA_VIOLATIONS
> +	count="$(get_count $search)"
> +
> +	open_file_write
> +	open_file_read
> +	close_file_read
> +
> +	open_file_read
> +	close_file_read
> +	close_file_write
> +
> +	open_file_write
> +	open_file_read
> +	close_file_read
> +	close_file_write
> +	validate $num_violations $count $search 2
And here.

Kind regards,
Petr

