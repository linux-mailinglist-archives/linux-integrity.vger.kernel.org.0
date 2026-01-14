Return-Path: <linux-integrity+bounces-8239-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 627A7D20492
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 17:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E5353015165
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E343A1A3A;
	Wed, 14 Jan 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NU6PJ0RQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RfXCqNsC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NU6PJ0RQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RfXCqNsC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358B43101DA
	for <linux-integrity@vger.kernel.org>; Wed, 14 Jan 2026 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409182; cv=none; b=nxUzi44BhjP0FjXKVHKwdcuLpoCfKpJOweuuRuQRS+7YPNlW9a5df20IXnlK7MfRxbAkSu5vGrODVaGjt/4ZmuOr+uEfKhFH2bNWu7DxKD/mrbK7LxuqDkTW9+hrMaFkreySWq8v/9gpOV49zpPS9YTknLRX2oaGsImf843VOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409182; c=relaxed/simple;
	bh=02VkazAv2aWHdh5XQRlAM5LovSsq3qzib4NSEuzY/nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9GtC0/1xe1B5Z4meSBLk6RLolewacKnauwkC78/ML4SALYmp+3XwGineBoNVrpewoI83q+nnW76+eWsPgu7u5BKtUpY0QMxDMnLnOdaD3970wDGfZ26ZFOLkIh0FevaYwU2hlYJd5ygW5iiOyhheYkuKGrSTCHaywK6u0iocqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NU6PJ0RQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RfXCqNsC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NU6PJ0RQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RfXCqNsC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52ADC34776;
	Wed, 14 Jan 2026 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768409179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4hayO0Og4ICjAYyQZZOg5Q0xwwWpPhddrykOhPmIlc=;
	b=NU6PJ0RQmBAvRrTVG3MIFV5LW6LawLFlOJqUNrmuWbcJUkO8jhE3Gz2fdWj+nxJnOCLl7e
	oir1JnY2mSXh8AXD/C0enkGdfDHqy39Lksnkn/XVbqIJ3ZzPODN4OuJxgNELCiDxPZpBPn
	mu11LT3XvsgP5hsytTv8abXIJMw4uds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768409179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4hayO0Og4ICjAYyQZZOg5Q0xwwWpPhddrykOhPmIlc=;
	b=RfXCqNsCMV59mCV8nmnUpry7sTk29T6DmyrF2WxV2X2028md/PcHQhq5KNfbLfXbK5QZuJ
	eTJ2NxGbkrTqZCCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768409179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4hayO0Og4ICjAYyQZZOg5Q0xwwWpPhddrykOhPmIlc=;
	b=NU6PJ0RQmBAvRrTVG3MIFV5LW6LawLFlOJqUNrmuWbcJUkO8jhE3Gz2fdWj+nxJnOCLl7e
	oir1JnY2mSXh8AXD/C0enkGdfDHqy39Lksnkn/XVbqIJ3ZzPODN4OuJxgNELCiDxPZpBPn
	mu11LT3XvsgP5hsytTv8abXIJMw4uds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768409179;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4hayO0Og4ICjAYyQZZOg5Q0xwwWpPhddrykOhPmIlc=;
	b=RfXCqNsCMV59mCV8nmnUpry7sTk29T6DmyrF2WxV2X2028md/PcHQhq5KNfbLfXbK5QZuJ
	eTJ2NxGbkrTqZCCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 363ED3EA63;
	Wed, 14 Jan 2026 16:46:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nx46DFvIZ2lqWwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 14 Jan 2026 16:46:19 +0000
Date: Wed, 14 Jan 2026 17:46:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ima_kexec.sh: Document kernel config dependencies
Message-ID: <20260114164617.GB426021@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260107155737.791588-1-pvorel@suse.cz>
 <20260107155737.791588-2-pvorel@suse.cz>
 <41d432e3b9c16d712080295235ca000a6cb6e07c.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41d432e3b9c16d712080295235ca000a6cb6e07c.camel@linux.ibm.com>
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -7.50
X-Spam-Level: 

Hi Mimi, all,

> On Wed, 2026-01-07 at 16:57 +0100, Petr Vorel wrote:
> > CONFIG_HAVE_IMA_KEXEC=y is enough for test, ie. test is working with:

> >     # CONFIG_IMA_KEXEC is not set
> >     CONFIG_HAVE_IMA_KEXEC=y

> > Probably obvious as CONFIG_HAVE_IMA_KEXEC is arch specific and
> > CONFIG_IMA_KEXEC is "TPM PCRs are only reset on a hard reboot."
> > and ima_kexec.c requires CONFIG_HAVE_IMA_KEXEC (only parts are skipped
> > when CONFIG_IMA_KEXEC not set) but better to clarify for users.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/kernel/security/integrity/ima/tests/ima_kexec.sh | 3 +++
> >  1 file changed, 3 insertions(+)

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> > index 7688690af2..de595fcdd7 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> > @@ -6,8 +6,11 @@

> >  # Verify that kexec cmdline is measured correctly.
> >  # Test attempts to kexec the existing running kernel image.
> > +#
> >  # To kexec a different kernel image export IMA_KEXEC_IMAGE=<pathname>.
> >  # Test requires example IMA policy loadable with LTP_IMA_LOAD_POLICY=1.
> > +#
> > +# Test requires CONFIG_HAVE_IMA_KEXEC=y (CONFIG_IMA_KEXEC is not mandatory).

> Correct.  The test verifies that the kernel image is measured.  It does not
> execute the kexec, so there is no need for carrying the IMA measurement list
> across kexec (CONFIG_IMA_KEXEC).

Thanks for having a look! I merged with your RBT (as we dicussed).

Kind regards,
Petr

> >  TST_NEEDS_CMDS="grep kexec sed"
> >  TST_CNT=3

