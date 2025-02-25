Return-Path: <linux-integrity+bounces-4984-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D62A43654
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2025 08:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BD13AE8A3
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2025 07:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109821C84A6;
	Tue, 25 Feb 2025 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j668kcDt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8QjHUCm9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j668kcDt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8QjHUCm9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477C61A5B89
	for <linux-integrity@vger.kernel.org>; Tue, 25 Feb 2025 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469554; cv=none; b=Y0fecSFMmeZeHqDiwP/ZVptoLQnBM60MEcygL2Nauc5sZx4j7NQ5sJWw5FAZPygZxhrOGRGxJTx+v4lj54ei86/dcFxmjugezBG+nTYf66aHFBMgCzcyo05HRHmuTI4JW6FWfiSMEN59QuzIKqxZZKqAwwMfmeU7F65huYnXzhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469554; c=relaxed/simple;
	bh=dXSzB+L5EkhVZa7IYV2TbiqRH9HqhLWRNmao6nfiEIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZacl2zDFOqnWIC2uuhO3TNayjE13RLt1vhZiOLDIaB+ZwwrOt3BNYC55snL++tBTBvOMjVkfBZ3WV/E1PyfPYyjlxiEvTXZLyop1BzPzr3A3GZw80dPrpU4igRTGzF9i2IDAdU8JjbglaMx5F4wKg8aDr5EVHQsUr38C7oI+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j668kcDt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8QjHUCm9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j668kcDt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8QjHUCm9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4946B1F44F;
	Tue, 25 Feb 2025 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740469550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+loGt5I0RIal7QdaYVYL93YNtRnAfFHUzCDJ6+v6tw=;
	b=j668kcDt1rW4kBJnKipZca5l6YX4cjCgY1Wjv5Og8P/IKoO6QpBIL44vZhcRMgp+hz30Bw
	yd92vH2GqmFd9OnmPPmXPJ+2PeKdr/PmvXpt1RwsQu0mM/8agx7+O3zkod4LxdkIyR39Hh
	iXEA3ddfGJkztnhjLbkKXxTnA0Uz7jI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740469550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+loGt5I0RIal7QdaYVYL93YNtRnAfFHUzCDJ6+v6tw=;
	b=8QjHUCm9Jm1yeUXQUkJRxLoPL88tnEg9cGY1hFH2CX36NFzujNOg6mkci/LR+xTvjfr+M5
	fWMAJOR+m13wpxBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740469550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+loGt5I0RIal7QdaYVYL93YNtRnAfFHUzCDJ6+v6tw=;
	b=j668kcDt1rW4kBJnKipZca5l6YX4cjCgY1Wjv5Og8P/IKoO6QpBIL44vZhcRMgp+hz30Bw
	yd92vH2GqmFd9OnmPPmXPJ+2PeKdr/PmvXpt1RwsQu0mM/8agx7+O3zkod4LxdkIyR39Hh
	iXEA3ddfGJkztnhjLbkKXxTnA0Uz7jI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740469550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+loGt5I0RIal7QdaYVYL93YNtRnAfFHUzCDJ6+v6tw=;
	b=8QjHUCm9Jm1yeUXQUkJRxLoPL88tnEg9cGY1hFH2CX36NFzujNOg6mkci/LR+xTvjfr+M5
	fWMAJOR+m13wpxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 287FE13332;
	Tue, 25 Feb 2025 07:45:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n6d/CC51vWfwcAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 25 Feb 2025 07:45:50 +0000
Date: Tue, 25 Feb 2025 08:45:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] ima: additional ToMToU violation tests
Message-ID: <20250225074543.GA2901073@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250220160054.12149-3-zohar@linux.ibm.com>
 <20250220181604.GA2709977@pevik>
 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
 <20250220191342.GA2716312@pevik>
 <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
 <2637152a2715b8e84e966b12bc9c9cb1c27592c2.camel@linux.ibm.com>
 <20250220214333.GA2726725@pevik>
 <cd07d8052fbfa0cde426b4b07fde0c70e6aa046f.camel@linux.ibm.com>
 <20250221081623.GA2739743@pevik>
 <26a46dd0c56d95108c575937c15fa35d48f67577.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26a46dd0c56d95108c575937c15fa35d48f67577.camel@linux.ibm.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

> On Fri, 2025-02-21 at 09:16 +0100, Petr Vorel wrote:
> > > On Thu, 2025-02-20 at 22:43 +0100, Petr Vorel wrote:
> > > > > On Thu, 2025-02-20 at 15:22 -0500, Mimi Zohar wrote:
> > > > > > On Thu, 2025-02-20 at 20:13 +0100, Petr Vorel wrote:
> > > > > > > > On Thu, 2025-02-20 at 19:16 +0100, Petr Vorel wrote:
> > > > > > > > > Hi Mimi,

> > > > > > > > > > Kernel patch "ima: limit the number of ToMToU integrity
> > > > > > > > > > violations"
> > > > > > > > > > prevents superfluous ToMToU violations.  Add corresponding LTP
> > > > > > > > > > tests.

> > > > > > > > > > Link:
> > > > > > > > > > https://lore.kernel.org/linux-integrity/20250219162131.416719-3-zohar@linux.ibm.com/
> > > > > > > > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

> > > > > > > > > Unfortunately tests fail on both mainline kernel and kernel with
> > > > > > > > > your patches.

> > > > > > > > The new LTP IMA violations patches should fail without the
> > > > > > > > associated kernel
> > > > > > > > patches.

> > > > > > > > > Any hint what could be wrong?

> > > > > > > > Of course it's dependent on the IMA policy.  The tests assume
> > > > > > > > being booted with
> > > > > > > > the
> > > > > > > > IMA
> > > > > > > > TCB measurement policy or similar policy being loaded.  Can you
> > > > > > > > share the IMA
> > > > > > > > policy?
> > > > > > > > e.g. cat /sys/kernel/security/ima/policy

> > > > > > > > thanks,

> > > > > > > > Mimi

> > > > > > > Now testing on kernel *with* your patches. First run always fails,
> > > > > > > regardless
> > > > > > > whether using ima_policy=tcb or
> > > > > > > /opt/ltp/testcases/data/ima_violations/violations.policy).

> > > > > > > Kind regards,
> > > > > > > Petr

> > > > > > I'm not seeing that on my test machine.  Could there be other things
> > > > > > running on your
> > > > > > system causing violations.  In anycase, your original test was less
> > > > > > exacting.  
> > > > > > Similarly,
> > > > > > instead of "-eq", try using "-qe" in the following test and removing
> > > > > > the subsequent
> > > > > > new
> > > > > > "gt" test.

> > > > > -> "-ge"

> > > > Sure, changing to -ge fixes the problem:
> > > > if [ $(($num_violations_new - $num_violations)) -ge $expected_violations
> > > > ]; then

> > > > I guess we need "-ge" for older kernels (unless "fix" for stable).  Should
> > > > we
> > > > accept "$expected_violations || $expected_violations + 1" for new kernels
> > > > to
> > > > avoid problems like the one on my system.

> > > The problem is that we don't control what else is running on the system.  So
> > > there could
> > > be other violations independent of these tests.  I'll have to think about it
> > > some more and
> > > get back to you.  (There's no rush to do anything with these LTP IMA
> > > violation tests.)

> > OK, thank you. The worse scenario would be to use less precise variant "-ge".

> > > > I wonder if the problem was somehow caused by the fact that I built
> > > > kernel. OTOH
> > > > it's build by OBS (official openSUSE build service).

> > > As long as you weren't building the kernel and running the tests at the
> > > same, I doubt it
> > > would be the problem.

> > Understand, just something on openSUSE Tumbleweed system.

Hi Mimi,

> Peter, thank you for the tumbleweed image.

Thanks for debugging on the image!

> The default IMA tcb policy results is measuring $LOG (/var/log/audit/audit.log)
> on the first call to validate().  To prevent that from interfering with test1, I
> would add the following line or something similar in setup() to force measuring
> $LOG to happen earlier.

+1

> exec 3< $LOG || exit 1
Ideally use:
exec 3< $LOG || tst_brk TBROK "some explanation..."

> Assuming that works, I'll update the kernel and LTP tests.

+1 (patch from you is preferred)

Kind regards,
Petr

> thanks,

> Mimi















