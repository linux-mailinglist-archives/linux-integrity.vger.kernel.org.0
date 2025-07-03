Return-Path: <linux-integrity+bounces-6606-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4724CAF74EF
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 15:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848DC1887C7C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E099B2D77F2;
	Thu,  3 Jul 2025 13:04:15 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7228D8F1;
	Thu,  3 Jul 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751547855; cv=none; b=twfLOGDolGpYBaJyZ2iVTAlaqlyAbq6anJcbbVgP1A+SKi/C5/54PhnbwYzn1kjMQnQCDpRn/8hTaR8uA+CLFsAzxfhuucQ7ohXAuGx2nLvKmjvj6U7t/SSkBj4OpQiRvB+0XIkJ4hngwEPAQMy3mhgAeR82CH4iqjnAiHoKBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751547855; c=relaxed/simple;
	bh=1sv+eWZirka/W7c2+072tNVMXGRP+e/3BDtJucLxipU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em8adUtvuev0FvFZjwZvxqfiGegdf2YYa9dyd8frg8iNSldm96qd4A59EbBmhTbHQ20DALLl9pXxxrL7ztUldJp531rVFhERyhLZP6n5PT9IEbchMKVdWkk4KTIl1/Yw+aMoGR/8/Q2zk6KLWKHpu9StvpBLE9f7q7jk+YTSQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 9F738E81788;
	Thu,  3 Jul 2025 15:04:08 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 38A1616005E; Thu,  3 Jul 2025 15:04:07 +0200 (CEST)
Date: Thu, 3 Jul 2025 15:04:07 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: Re: [PATCH] Revert "integrity: Do not load MOK and MOKx when secure
 boot be disabled"
Message-ID: <aGZ_x8Ar6iwzt2zV@gardel-login>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
 <1a6cf2097487816e4b93890ad760f18fe750bd70.camel@linux.ibm.com>
 <aGYurikYK1ManAp3@gardel-login>
 <8401c23009db3b8447b0b06710b37b1585a081ab.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8401c23009db3b8447b0b06710b37b1585a081ab.camel@linux.ibm.com>

On Do, 03.07.25 07:23, Mimi Zohar (zohar@linux.ibm.com) wrote:

> > > The ability of loading MOK keys onto the .machine keyring and linked to the
> > > .secondary_trusted_keys keyring is an exception based on the assumption that
> > > that there is a secure boot chain of trust.  Allowing untrusted keys onto or
> > > linked to the .secondary_trusted_keys keyring, would potentially allow loading
> > > code signing keys onto the IMA keyring signed by untrusted MOK keys.
> > >
> > > I was really hesitant to allow this exception of loading MOK keys onto the
> > > .machine keyring in the first place.  I'm now even more concerned.
> > >
> > > This is not just an issue of being more or less restrictive, but of adding a new
> > > integrity gap when one didn't exist previously.
> >
> > But we are talking of the case here where SecureBoot is *off*,
>
> Exactly, so there is no trust in any keys other than those built into the
> kernel.

No! There *is* *no *trust* in this case where SB is off, not in those
keys built into the kernel nor in any other. Believing there was is
just a really broken security model!

> True that is of course dependent on trusting the kernel.  In the case of
> MOK, trusting additional keys requires at minimum a "safe" secure boot
> environment and other things to prevent its abuse.

The thing is that if SB is off, then all bets are off, it's really
pointless in assuming the kernel image had any trust left you'd need
to protect. That's just *not* the case. Where do you think that trust
should come from?

If SB is off, then anything that got loaded early enough could just
patch arbitrary keys into the ELF image of the kernel before starting
it, and everything will look perfect later on, because the image is
not authenticated after all via SB. So there *already* is a way into
the kernel keyring with this – it's just really messy to parse and
patch ELF at runtime like this from the bootloader. My hope with just
relaxing the rules on MOK keys when SB is off is to just make this
stuff cleaner and more elegant (and also to leave the ELF image intact
so that we get clean measurements, both of the kernel and of the keys
we add).

> > i.e. there is a concious decision in place that there is no trust
> > chain, and that the firmware *happily* *already* accepts unsigned boot
> > loaders/kernels and just runs with them. If SecureBoot is already off,
> > then an attacker can patch around in the kernel invoked at boot
> > completely freely anyway, there is *no* authentication done. Hence
> > it's really weird to then insist that the path into the kernel keyring
> > via mok keys is off in *only* this case, because an attacker can get
> > into that anyway in this case, it's just a lot more cumbersome.
> >
> > It's really strange that currently when people ask for tight security
> > (i.e. SB on) the linux kernel is super relaxed and allows any keys to
> > be inserted, but if people ask for security checks to be off (i.e. SB
> > off) the kernel starts being super strict and doesn't allow any keys
> > to propagate into mok. That's really confusing and contradictory, no?
>
> That all may be true, but you're ignoring what I said about only "trusting" MOK
> in certain situations.  If you have another safer, better mechanism for
> establishing a new root of trust for keys (e.g. TPM), then by all means share it
> and we can make additional exceptions.

Yes, we have that in systemd: there's local attestation in place
already in systemd via the "systemd-pcrlock" feature. i.e. the idea is
that the disk encryption keys are only released to the OS if the
measurements of the boot phase match some golden measurements. This is
in a way a reasonable alternative (or addition) to SecureBoot: instead of
prohibiting code to run if it doesn't carry a signature of some
trusted key, you let it all run, but then later on you refuse to give
it the disk encryptions keys – the keys to the kingdom – unless the
measurements all along the way match what you expect them to be. This
protects the OS quite nicely, and makes SB to some level optional, as
we basically enforce security "a-posteriori" rather than "a-priori" – by
means of the TPM's key policies.

Now you might wonder: if we have such local attestation policies, why
do we *also* want to get keys into the kernel keyring? That's because
the attestation policies are checked (primarily) when FDE is unlocked,
so that's our security boundary, our milestone where eveything
*before* is protected via attestation, but which cannot protect
anything *after*. In my model we then want to protect
any further resources via the kernel keyring then. hence it matters to
us to have a clean, elegant way, to insert keys *before* that
milestone that then can protect resources comeing *after* it.

Why do I want to avoid SB at all for these setups? Mostly, because
it's a bureacractic effort to get your keys intot he Microsoft
keyring, and if you do get them there, then their security value is
kinda weak anyway, because the allowlist that the keyring is is such
an extremely wide net, it's at best a denylist of bad stuff rather
than an allowlist of good stuff at this point. It's kinda undemocratic
too. But anyway, the pros and cons of SB are another discussion. I am
primarily interested in making it optional, so that you can get
security with SB and without SB, because you always have someting to
protect the boot, and always something that protects the rest.

Lennart

--
Lennart Poettering, Berlin

