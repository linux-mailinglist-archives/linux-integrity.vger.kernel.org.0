Return-Path: <linux-integrity+bounces-4941-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816A7A3E43A
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 19:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26633A727B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 18:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB6D214215;
	Thu, 20 Feb 2025 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NMqh1uiE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ATRyU21B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JrZROVnL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZrmfCPjQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E52211A1D
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077437; cv=none; b=XbiMwy8qLO4NNU+R4COoQlOMdadoLXIzAl2V21LGwh5UJqVZKImsh5ssr4SxpXOj3WoysOAUXCGQ+/sPkEy3AjcCYyWBFstrUug9Ll6EgtIrQScvXxbLgTVwFbycRZqMlbBPh4YayD7RH//fu0JpeMYJMCyVEphhSWH6wcsQC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077437; c=relaxed/simple;
	bh=twezPN89u1gHVLcv92wcRvyzzRfRT/IxflhRkFGL/Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQzzfZv/7ULhe0aPYgoTFYAVoXx4F7OLhp6LO4QGjn0nNu+NqwfND/aao0ns7CRwhc+GATSqFCxV7EbkDuN2JcWAn0+xmAlHuNqhQEKfKIeJzA0v7rDV1mRux1LWWPr5CP6zRQuswv9VgMQt4J/nyuLGJqFTgrvjhz4Omr4NC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NMqh1uiE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ATRyU21B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JrZROVnL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZrmfCPjQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F1091F38F;
	Thu, 20 Feb 2025 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740077433;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mAgeTxSAdu/tWsLhE16VOffBlYQ0u9ic275GezsMZw=;
	b=NMqh1uiEsRNdu5mNB4Xh1o9S1AnmsWx0xqtWAht+om+OGu0eDSSRSrzrLO9D/JpSUkRhZG
	t5qwxsolyt18TwZiYgY9oq7U0jXiDWnC3Xvvugixb+Z42q4bHolQwOOspi7FG2Fi5f4yl3
	+K93uVWyx2Y7TFtjgUhfXH3EAWrW1tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740077433;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mAgeTxSAdu/tWsLhE16VOffBlYQ0u9ic275GezsMZw=;
	b=ATRyU21BSlJwSmBERdzIk1rU9pdeMx6Inddk2TxumgRPrsTxT+xH/5PNxxjatLjfjm8zkW
	2HLO6kVR9E+W7DBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740077432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mAgeTxSAdu/tWsLhE16VOffBlYQ0u9ic275GezsMZw=;
	b=JrZROVnLQ5iyz30NTs9VC7GbbNjRN2R4ir4f0HqPxTGNCoeK0uoSmaIprX4nqO2rSoMLG/
	EIChv5psVU14JEtWtguCO9MMaCDfYjwTpFDQeIzNky6envTmjtarRA5d3S6/U8esx4dcLr
	r8Y3g9LDFft9HcQby312M7IaJxk31rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740077432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mAgeTxSAdu/tWsLhE16VOffBlYQ0u9ic275GezsMZw=;
	b=ZrmfCPjQV6kwY1kUgWBFiqn6C10yRCx+TiuEXwM5fRGYw259oWn2BUZuNajRI96epA4PNU
	2OI0gfwabyuqvCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2C1713A42;
	Thu, 20 Feb 2025 18:50:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7/X1Lnd5t2cIMAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 18:50:31 +0000
Date: Thu, 20 Feb 2025 19:50:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH 1/3] Update validate() to support multiple violations
Message-ID: <20250220185026.GA2712942@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220160054.12149-1-zohar@linux.ibm.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi,

> Add support for the number of expected violations.  Include the
> expected number of violations in the output.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .../security/integrity/ima/tests/ima_violations.sh     | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 37d8d473c..7f0382fb8 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -71,20 +71,26 @@ validate()
>  	local num_violations="$1"
>  	local count="$2"
>  	local search="$3"
> +	local expected_violations=$4
nit: safer to quote as much as possible (="$4") to avoid errors.

>  	local max_attempt=3
>  	local count2 i num_violations_new

> +	[ -z $expected_violations ] && expected_violations=1
Also here: -z "$expected_violations"

I can add quotes before merge if you don't want to bother (I would send you a
diff to ack it before merging).

> +
>  	for i in $(seq 1 $max_attempt); do
>  		read num_violations_new < $IMA_VIOLATIONS
>  		count2="$(get_count $search)"
> -		if [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
> +		if [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then
>  			if [ $count2 -gt $count ]; then
> -				tst_res TPASS "$search violation added"
> +				tst_res TPASS "$expected_violations $search violation(s) added"
>  				return
>  			else
>  				tst_res TINFO "$search not found in $LOG ($i/$max_attempt attempt)..."
>  				tst_sleep 1s
>  			fi
> +		elif [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
> +			tst_res $IMA_FAIL "$search too many violations added"
nit: maybe print values for debugging?

			tst_res $IMA_FAIL "$search too many violations added: $num_violations_new - $num_violations"

FYI failing tests has 2 or 3 higher:

ima_violations 1 TINFO: SUT has required policy content
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TFAIL: open_writers too many violations added: 106 - 104
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TFAIL: ToMToU too many violations added: 109 - 107
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
tst_test.c:1904: TINFO: Tested kernel: 6.13.0-2.g0127a37-default #1 SMP PREEMPT_DYNAMIC Thu Jan 23 11:21:55 UTC 2025 (0127a37) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TFAIL: open_writers too many violations added: 112 - 110
ima_mmap.c:41: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
ima_violations 4 TINFO: verify limiting single open writer violation
ima_violations 4 TFAIL: open_writers too many violations added: 116 - 113
ima_violations 5 TINFO: verify limiting multiple open writers violations
ima_violations 5 TFAIL: open_writers too many violations added: 121 - 117
ima_violations 6 TINFO: verify new open writer causes additional violation
ima_violations 6 TFAIL: open_writers too many violations added: 126 - 122
ima_violations 7 TINFO: verify limiting single open reader ToMToU violations
ima_violations 7 TFAIL: ToMToU too many violations added: 130 - 127
ima_violations 8 TINFO: verify new open reader causes additional ToMToU violation
ima_violations 8 TFAIL: ToMToU too many violations added: 134 - 131

As I noted in previous mail, either has of a backport (can be added later, we
don't have to wait for merging) or skip on older kernels (tst_kvcmp -lt ...).

Kind regards,
Petr

