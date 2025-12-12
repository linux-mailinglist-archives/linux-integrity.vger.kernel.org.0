Return-Path: <linux-integrity+bounces-7937-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A80CB8B34
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Dec 2025 12:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4EE33008D67
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Dec 2025 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7004631A7E1;
	Fri, 12 Dec 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C5ABT3Ms";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mREAyL01";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VACxPnjp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rMHqZ0op"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180D2836AF
	for <linux-integrity@vger.kernel.org>; Fri, 12 Dec 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538431; cv=none; b=FLTTjldI4Wt5G7xqF7jlvTTxJ33M54o3hcAnJG5e5zl8P5MtP4vFsDaYQOxJ5sZ3GwAWIS0rLdpKSEnRyBBgGZA80f6IrkgKi/HQ4WZJI4cV0Ew5lvitbg1dtxMvUMHhwYNRPQYGJancN/nEhRRq42TCeitJceHq9iEvTlUUDbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538431; c=relaxed/simple;
	bh=/b8Dnf8YvRqwZXNw46Ni+lZUhYfrIhdWq8PDjtNyqHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd7FWBUuexLkl3YI5tFsx7Vm0dbDFoxur5Iwy41mo/khpdpG0F2zbEYuWlgfG+7PJxLYVyCCaxEmEcPUFO3YbAMITtQ1DZ5rfhY2hlI7fi8SrYbjXUTK37tv1mPmWb1lRk4F42uDFz3leZojSrg/CqX92glQvLjiGZfqee8JMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C5ABT3Ms; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mREAyL01; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VACxPnjp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rMHqZ0op; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C4585BD6E;
	Fri, 12 Dec 2025 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765538427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEGNYwXplzlfZoIz2e4wjeNskOlBi7zGlDq8PligUjA=;
	b=C5ABT3MsySKIIFvTnnslOrByQeSWZJPq4I2buD5GEEObp62KsNmc7xDNtDbpIztt9soXSa
	/srOT5yq5ZVIPYk9yqN4l/e3nPNlseNyZnWE13nfSPNtgEL4FyUayWhhmggscqx+P1/hpw
	4zrg6yGl7GsT9LZhAxNJCYFpBz9G4TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765538427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEGNYwXplzlfZoIz2e4wjeNskOlBi7zGlDq8PligUjA=;
	b=mREAyL01rVUzUfPRlsJiK4KC3jNKxR9DZ1+rtMAvlHEgcYQ0rdhVQTZcGk/iLPoA/e/OJn
	J03UhEdHZCBTcXBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VACxPnjp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rMHqZ0op
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765538426;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEGNYwXplzlfZoIz2e4wjeNskOlBi7zGlDq8PligUjA=;
	b=VACxPnjpR/aQEcVFIPPaaHcIB6yAHkw6rVoJ5mWU91c006SHZFkCV9QT2i/TlVmVWVxYhy
	WYAevrtg8wL3YV2jrfJRtlInCirTOKB3ImgW4Qlmmhb7jWAv1QiDeP3Z+7OIJ3TOM+1kPM
	dE0r6B83Bqj8sBKuvvFA1WncWwUhUOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765538426;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEGNYwXplzlfZoIz2e4wjeNskOlBi7zGlDq8PligUjA=;
	b=rMHqZ0opU7HR7qp1AhwGaNsPXh+TC8711XFMtwzVqtogJAjLRCSUSltCNatKdr9ssn1Ar9
	mnfVFxvb5II+YsDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F09F3EA63;
	Fri, 12 Dec 2025 11:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F4AMCnr6O2kVFQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 12 Dec 2025 11:20:26 +0000
Date: Fri, 12 Dec 2025 12:20:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
	Martin Doucha <martin.doucha@suse.com>
Subject: Re: [LTP] [PATCH] ima_violations.sh: Another fix of condition
 evaluation
Message-ID: <20251212112020.GB125889@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251211111046.87297-1-pvorel@suse.cz>
 <DEW3YDE8MMBT.DEEW2VO31X0G@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEW3YDE8MMBT.DEEW2VO31X0G@suse.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 5C4585BD6E
X-Spam-Flag: NO
X-Spam-Score: -3.71

> Hi!

> On Thu Dec 11, 2025 at 12:10 PM CET, Petr Vorel wrote:
> > c0c35509f9 was not enough to fix evaluation against empty
> > $expected_violations:

> > ima_violations 1 TINFO: verify open writers violation
> > /opt/ltp/testcases/bin/ima_violations.sh: line 96: [: 0: unary operator expected

> > Therefore split checks into two if.

> > Also improvements (readability)
> > * shorten line length with saving subtraction into variable
> > * evaluate empty variable with ${:-}

> > Fixes: 726ed71905 ("ima_violations.sh: Update validate() to support multiple violations")
> > Reported-by: Martin Doucha <mdoucha@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > NOTE: this was found on old SLES 4.4 based kernel which does not log
> > validations. But missing validations might be just a Secure Boot related
> > setup problem:

> > $ mokutil --sb-state
> > Secure Boot: EFI variables not supported on SUT

> > Events are logged when Secure Boot is off:
> > $ mokutil --sb-state
> > SecureBoot disabled

> > Or maybe violations worked differently on the old kernel (I remember
> > only 6.15 change).

> > Kind regards,
> > Petr

> >  .../integrity/ima/tests/ima_violations.sh     | 21 ++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > index 1d2f1d9447..a8476e6b59 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > @@ -87,23 +87,30 @@ validate()
> >  	local search="$3"
> >  	local expected_violations="$4"
> >  	local max_attempt=3
> > -	local count2 i num_violations_new
> > +	local count2 diff i num_violations_new pass

> >  	for i in $(seq 1 $max_attempt); do
> >  		read num_violations_new < $IMA_VIOLATIONS
> >  		count2="$(get_count $search)"
> > -		if [ -z "$expected_violations" -a $(($num_violations_new - $num_violations)) -gt 0 ] || \
> > -		   [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then
> > -			[ -z "$expected_violations" ] && expected_violations=1
> > +		diff=$(($num_violations_new - $num_violations))
> > +
> > +		if [ "$expected_violations" ] && [ $diff -eq $expected_violations ]; then
> > +			pass=1
> > +		fi
> > +		if [ -z "$expected_violations" ] && [ $diff -gt 0 ]; then
> > +			pass=1
> > +		fi

> Maybe readability can be improved (well..shell scripts are pretty ugly
> by nature anyway):

> 	diff=$((num_violations_new - num_violations))

> 	if [ "$expected_violations" ]; then
> 		[ $diff -eq $expected_violations ] && pass=1
> 	else
> 		[ $diff -gt 0 ] && pass=1
> 	fi

Thanks, makes sense, I'll modify it before merge.
Feel free to add your RBT/TBT tags if you wish (as you spent time looking into
this).

Kind regards,
Petr

> > +
> > +		if [ "$pass" = 1 ]; then
> >  			if [ $count2 -gt $count ]; then
> > -				tst_res TPASS "$expected_violations $search violation(s) added"
> > +				tst_res TPASS "${expected_violations:-1} $search violation(s) added"
> >  				return
> >  			else
> >  				tst_res TINFO "$search not found in $LOG ($i/$max_attempt attempt)..."
> >  				tst_sleep 1s
> >  			fi
> > -		elif [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
> > -			tst_res $IMA_FAIL "$search too many violations added: $num_violations_new - $num_violations"
> > +		elif [ $diff -gt 0 ]; then
> > +			tst_res $IMA_FAIL "$search too many violations added: $diff ($num_violations_new - $num_violations)"
> >  			return
> >  		else
> >  			tst_res $IMA_FAIL "$search violation not added"

