Return-Path: <linux-integrity+bounces-4509-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96202A00929
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2025 13:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCAD3A3B2C
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2025 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2371F866F;
	Fri,  3 Jan 2025 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v1SaE3Xa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4ekhy6Gm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v1SaE3Xa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4ekhy6Gm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4C219E0
	for <linux-integrity@vger.kernel.org>; Fri,  3 Jan 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735906747; cv=none; b=UMX52kgWfiGeD3/UWiGco8j+nyYtQ/HZhAOo6i+HczHOhxtjemyquqXVlZxAb6X4z3jFuTYxJ2DMAy4oEwTflDNJ79AFWtHLWLzCDpWG4qqcQZimoaARwl3kGEZkKhw9y4NeyEybSyu0eRpfjY3SQfK51BlNGz779c12FLoC9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735906747; c=relaxed/simple;
	bh=3UA51+BBdBS/mW4Vc9Yt2FhtEoi3AryokGyYM/EPGus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppAW4meIMK4A6Y7ExGaXXz15/gigBeYcV5vC1ynUoiq5Uv2eLa9qEEMp5pcJCkZfdrh7p3bSLm6k0FIecU46U9TXsAP2Nytt2bjXO5QnIc3InOAo+7DKUr86CuP4GGe/rcLqsRa3715XssyKlncI6Lq0Zf/L7PAzJvHRtIp/paI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v1SaE3Xa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4ekhy6Gm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v1SaE3Xa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4ekhy6Gm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0EB1321114;
	Fri,  3 Jan 2025 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735906744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCCmtVwgPhrDKWKe0rGu0fanaPp9HeohivRvCaksz4o=;
	b=v1SaE3Xa0iZ4w6ejzVfteBVu/apDPVclN6i9QpBypBCNy5t5e3glE0TejQII/L8ASgeU31
	Cjdi4dHh7ax3AYLMzryLOUAKIROtukMOkdXYqca4ZCXucjs5L3Ma/719ICyoJTC19NVBpG
	g0BPXY50z6a9YV9sfu1sUcc+mBSfz98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735906744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCCmtVwgPhrDKWKe0rGu0fanaPp9HeohivRvCaksz4o=;
	b=4ekhy6GmZLFl9Wg0qWNrCngnV2UfqYTSE1RPZDX1S/WRIzVlPdbY7P1dJGSQR/Wio//AYY
	yAnapeiZ3kAWm4Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735906744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCCmtVwgPhrDKWKe0rGu0fanaPp9HeohivRvCaksz4o=;
	b=v1SaE3Xa0iZ4w6ejzVfteBVu/apDPVclN6i9QpBypBCNy5t5e3glE0TejQII/L8ASgeU31
	Cjdi4dHh7ax3AYLMzryLOUAKIROtukMOkdXYqca4ZCXucjs5L3Ma/719ICyoJTC19NVBpG
	g0BPXY50z6a9YV9sfu1sUcc+mBSfz98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735906744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCCmtVwgPhrDKWKe0rGu0fanaPp9HeohivRvCaksz4o=;
	b=4ekhy6GmZLFl9Wg0qWNrCngnV2UfqYTSE1RPZDX1S/WRIzVlPdbY7P1dJGSQR/Wio//AYY
	yAnapeiZ3kAWm4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9515F134E4;
	Fri,  3 Jan 2025 12:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xr1GILfVd2fiOgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 03 Jan 2025 12:19:03 +0000
Date: Fri, 3 Jan 2025 13:18:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 2/8] ima_setup.sh: Allow to load predefined policy
Message-ID: <20250103121858.GC211314@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-3-pvorel@suse.cz>
 <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
 <20241231100057.GB36475@pevik>
 <b577405f0c6d2af8de6650eb1cd8c69305f616bf.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b577405f0c6d2af8de6650eb1cd8c69305f616bf.camel@linux.ibm.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi,

...
> > Do I understand correctly you talk about policy containing func=POLICY_CHECK [1]?

> Yes.  On a secure boot enabled system, the architecture specific policy might
> require the IMA policy itself to be signed.

> Snippet from ima_fs.c:

> #if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) &&
> IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
>         "appraise func=POLICY_CHECK appraise_type=imasig",
> #endif

> > Maybe there could be a test based on example [2].

> > echo /home/user/tmpfile > /sys/kernel/security/ima/policy
> > cp tmpfile /sys/kernel/security/ima/policy
> > cat tmpfile > /sys/kernel/security/ima/policy

> All of the above will load a policy, assuming the policy itself doesn't need to
> be signed.  Only "echo /home/user/tmpfile > /sys/kernel/security/ima/policy" can
> load a signed policy.

> Loading a CA key (mokutil), signing (evmctl)[1] and loading (keyctl) an IMA
> policy is probably beyond LTP.  The purpose of this test would be to detect
> whether policies need to be signed.

The most advanced for LTP is currently solving reboot [3].

FYI we plan to add support [4] to our kirk tool [5] (currently supports running LTP,
kselftest and liburing, testing via SSH, qemu).

I suppose given how sparse is IMA/EVM testing in LTP this can wait (there are
more basic features not covered by testing). I suppose most of the testing you
have in ima-evm-utils repo (at least I found only IMA related code in kselftest
in BPF tests).

> Going forward what's probably needed is a new package containing a set of pre-
> defined sample custom policies, which are signed by the distro.

Please let me now once you or other IMA devs are doing any work in this.

Kind regards,
Petr

> [1] Directions for signing and loading a custom policy,
> https://ima-doc.readthedocs.io/en/latest/ima-utilities.html#sign-and-install-a-custom-policy

> Thanks,

> Mimi


> > Kind regards,
> > Petr

> > [1] https://ima-doc.readthedocs.io/en/latest/policy-syntax.html#func-policy-check
> > [2] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#runtime-custom-policy

[3] https://github.com/linux-test-project/ltp/issues/868
[4] https://github.com/linux-test-project/kirk/issues/12
[5] https://github.com/linux-test-project/kirk

> > > > +}

> > > Mimi




