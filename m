Return-Path: <linux-integrity+bounces-343-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6B08037EE
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 15:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA591C20BEF
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDBC28E1B;
	Mon,  4 Dec 2023 14:58:35 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3F6CA;
	Mon,  4 Dec 2023 06:58:30 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 033A2E803A4;
	Mon,  4 Dec 2023 15:58:26 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 8BFA41601CC; Mon,  4 Dec 2023 15:58:25 +0100 (CET)
Date: Mon, 4 Dec 2023 15:58:25 +0100
From: Lennart Poettering <lennart@poettering.net>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>, ilias.apalodimas@linaro.org
Subject: Re: Discussion about using NV indexes for kernel properties like
 localities and PCRs
Message-ID: <ZW3pEehUrFu1az55@gardel-login>
References: <49b9916f60649ad66b87f29e9e87c9375b907975.camel@HansenPartnership.com>
 <ZWpRhUNj_M5Pxeif@gardel-login>
 <4d9bf547516c50617fe944590075c802492a0c04.camel@HansenPartnership.com>
 <ZW2Z7jdO7cHlMsbp@gardel-login>
 <222405b5ba1a581079409a724c4ee76e6800253f.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <222405b5ba1a581079409a724c4ee76e6800253f.camel@HansenPartnership.com>

On Mo, 04.12.23 08:01, James Bottomley (James.Bottomley@HansenPartnership.com) wrote:

> On Mon, 2023-12-04 at 10:20 +0100, Lennart Poettering wrote:
> > On Fr, 01.12.23 17:23, James Bottomley
> > (James.Bottomley@HansenPartnership.com) wrote:
> [...]
> > > > > I'm bringing this up for discussion now, in case anyone has a
> > > > > better idea or wants to add nuances (like measuring the
> > > > > creation to a real PCR and adding an event log to measured
> > > > > boot) before I (or someone else) look into coding it up.
> > > >
> > > > Why would that be necessary though? The "name" of an nvindex pins
> > > > the access policy of the nvindex.
> > >
> > > I assume you're talking about using TPM2_PolicyNameHash coupled
> > > with TPM2_PolicyNV?  That pins to NV index value and name, but the
> > > problem is that still doesn't necessarily solve the deletion
> > > problem (see below).
> >
> > I was thinking TPM2_PolicyAuthorizeNV and similar things too. They
> > generally pin NVs by "name".
>
> Heh, well, you have to be careful with that one as I just discovered
> with NV PINs.  Most of the TPMs I have in my system actually comply
> with rev 116.  NV PIN was added in rev 124 and PolicyAuthorizeNV in rev
> 132 which means they're not universally supported by TPM2 systems.

Yeah, I am aware. In systemd we started to use TPM2_PolicyAuthorizeNV
now (for implementing a PCR access policy for disk encryption that can
relatively nicely handle PCR changes), but I have the luxury to simply
say that this is not supported on old TPMs, and treat old TPMs like
non-existing TPMs.

> Yes, effectively a simple extension of the PCR system beyond 24 indexes
> for anyone to use.
>
> > So a write policy like this should work, no:
> >
> >     A TPM2_PolicyOR with three branches:
> >         1. TPM2_PolicyCommandCode(TPM2_NV_Write) +
> >            TPM2_PolicyNvWritten(writtenSet=false) +
> >            TPM2_PolicySigned(…)
> >         2. TPM2_PolicyCommandCode(TPM2_NV_Write) +
> >            TPM2_PolicyNvWritten(writtenSet=true)
> >         3. TPM2_PolicyCommandCode(TPM2_NV_Read)
> >
> > (where "+" is suposed to mean AND...)
>
> Well, no, that would mean the entity doing the create (first write) has
> to be able to sign the command.  That requires a permanent secret (the
> private key).  The problem I have is that I want to do this in the
> kernel.  The kernel can generate ephemeral secrets but not permanent
> ones that last across a boot and it certainly can't usefully (without
> leaking) carry persistent private keys, so whatever scheme we come up
> with for the kernel can't code a policy that contains a long lived
> secret.

These fake-PCR NVs are semi-persistent anyway (i.e. their definition
is persistent, but their value is not). Hence if you allocate one NV
index for this anyway, then maybe just allocated a second, and you
might just store the key in it? And that other NV index uses
TPM2_NV_ReadLock stuff so that it can be read during early boot, and
then no more until a reset happens.

I suggested this to Matthew for the hibernation stuff: store the
encryption secret in an nvindex and make sure it is only accessible
during kernel initialization, and not later via the read lock stuff.

Lennart

--
Lennart Poettering, Berlin

