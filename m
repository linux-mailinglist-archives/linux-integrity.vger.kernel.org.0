Return-Path: <linux-integrity+bounces-8089-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D4DCC85AA
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 16:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C3A4307A2B2
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 15:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCF5328B7D;
	Wed, 17 Dec 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YMKOziYO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YUuHmz/j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m1eXf7EM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lq5mpX/T"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4F335090
	for <linux-integrity@vger.kernel.org>; Wed, 17 Dec 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981521; cv=none; b=Q0vwbkQa6gHbdJ6K69J7yC2J6BoZoeYCVQfaIorGyyTP8Z91dlspLdP3NQpM4ksxzeQc6UDCbiG/b01qVSkgBpoBbNysQJ12vyMigWigqWnvo2e1JMKFT3pDjM408ncSn6qBq9SxHbqsoiX+6z3n4o41t6ZxVph7uxKZb2SpFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981521; c=relaxed/simple;
	bh=4T4dt3x86/iShGn7e4jvhTFIVe0IoSPzZNYfyuq3Jv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/vWfzfRXwJUTxQEkjX0WYgu959JlpcDTXu0KGqz44lHTpV2wYeNw2kOZjcptNlP53YqjqcqNWKQaoB6Zt5RqB6AtK+usqlR8tD3qsZrZ4B20cw1ZfHTNW5WS9oQdKcx79SJiartMRJpPt6fCnFZbgwP3mVIng/7RhPs3sLqFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YMKOziYO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YUuHmz/j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m1eXf7EM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lq5mpX/T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 851005BCFC;
	Wed, 17 Dec 2025 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765981518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGc4zvn4VyyoN2L6CuBnyqtYJ4UNfZuIMN98KMw17z8=;
	b=YMKOziYOnTWIW32dZvfPZkGhH/88J2lpr/gkhk+O9IXnSgmxrZNiqTZiXgsfbVKhT5MJMd
	CVmn0EByQD70O+svlljK1QZFzD6gpSFONQXCMDRtBrUxWSV5VNuRaPlsWBFkCGkK3BRfW1
	koOTpXoh89RCgR6Fp+apqhrm+EqYoz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765981518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGc4zvn4VyyoN2L6CuBnyqtYJ4UNfZuIMN98KMw17z8=;
	b=YUuHmz/j6dumd8ZQ+rpZwI/P97NzTDwvwnKJulxeZEHlQD/2MIcU64mcyLXqA5KfDirBkx
	PYpH/46ueqhIc9BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m1eXf7EM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Lq5mpX/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765981517;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGc4zvn4VyyoN2L6CuBnyqtYJ4UNfZuIMN98KMw17z8=;
	b=m1eXf7EMxkkWZcRjrgfqNTFJWZxMUYkxMf7ijHATU3dgSbSEEr+9FEhy/YuHi3zwQRqLHT
	6zy73vKZMuR0VUH9m9CMQh9FYjo0c0+4lDZpCSqs834TKoxywdKLlgEE+V4aCrqbUBU1rz
	algxBXrbZt6ZCGIoC1/05JiLWQZukf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765981517;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGc4zvn4VyyoN2L6CuBnyqtYJ4UNfZuIMN98KMw17z8=;
	b=Lq5mpX/Tq8/y/2nw2qa6R6MA3SCg8H/12ieLfJBGIipvfCGH7ort23dUY4NPL0vB3paUBB
	7pllTECevuVn+ZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42D4C3EA63;
	Wed, 17 Dec 2025 14:25:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cYGiDk29QmnPCQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Dec 2025 14:25:17 +0000
Date: Wed, 17 Dec 2025 15:25:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
	Martin Doucha <mdoucha@suse.cz>,
	Andrea Cervesato <andrea.cervesato@suse.de>
Subject: Re: [PATCH] ima_violations.sh: Another fix of condition evaluation
Message-ID: <20251217142515.GA66146@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251211111046.87297-1-pvorel@suse.cz>
 <c5450636264354dbf4d5e52d2441904d665e96ee.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5450636264354dbf4d5e52d2441904d665e96ee.camel@linux.ibm.com>
X-Spam-Flag: NO
X-Spam-Score: -3.71
X-Rspamd-Queue-Id: 851005BCFC
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

> On Thu, 2025-12-11 at 12:10 +0100, Petr Vorel wrote:
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

> Thanks, Martin, Petr.  LGTM

Thanks! FYI merged with simpler code suggested by Andrea.

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

> Violations only occur when there are policy rules containing "func=FILE_CHECK"
> defined.  The secure boot mode should only affects the arch specific policies,
> which do not include "func=FILE_CHECK" rules.  There is a slight difference
> between the builtin the original "ima_tcb" and newer "ima_policy=tcb" policies,
> which might affect violations.

Thanks for the hints! I'll have to dig more into tthe problem to see what is
wrong.

Anyway at least for example policy I see the differences between the old [1] and
new [2]:

-measure func=FILE_CHECK mask=MAY_READ uid=0
+measure func=FILE_CHECK mask=^MAY_READ euid=0
+measure func=FILE_CHECK mask=^MAY_READ uid=0    # root opened r/o, r/w

I guess I'll just add for older kernels this example policy:
measure func=FILE_CHECK mask=MAY_READ uid=0

Kind regards,
Petr

[1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-policy-tcb
[2] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb

