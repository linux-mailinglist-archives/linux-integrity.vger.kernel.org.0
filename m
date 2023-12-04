Return-Path: <linux-integrity+bounces-335-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F009B8033BA
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 14:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65491F21051
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3048F249F0;
	Mon,  4 Dec 2023 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="E94zR/+u";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="oRWL/Xd2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB9EAC;
	Mon,  4 Dec 2023 05:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701694891;
	bh=TbSN/TIsT1vJTUru8xlpu7RRtQQnVbHwMvjzSHkN48I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=E94zR/+ueus8EPk2f+4TPecbKM8XcBOTnPDi4M6HJHGfxiOxkQnXLOJX7uFAmJif4
	 NavHTxsZU4EyqNBZONqJ+Y6pdViqlJaZ8716c3H+Jt0G3XOppCMd6acj6QVph8qCO2
	 twuPBIAxPMphsvhlUlSndeEkVFhjtHRV9jjbnA6w=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1696C1280F2A;
	Mon,  4 Dec 2023 08:01:31 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id WkQhZoOS6q3k; Mon,  4 Dec 2023 08:01:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701694890;
	bh=TbSN/TIsT1vJTUru8xlpu7RRtQQnVbHwMvjzSHkN48I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=oRWL/Xd2776oym4PHkRVFZMZoRmrKl9EjcNlcXCsOWFEMdcxjfhgStUKWBkq31lSC
	 8Z1B/xDumy5NxbyMIG+2Jnntl0bv7vklj9Y5breEMBTfR9vkxfAi+eIaLOlJA7CFe3
	 mg/yNQP7SBn4eBDaIsXCTiQ2Pthg+EooW/ZM87oI=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3649B1280FB4;
	Mon,  4 Dec 2023 08:01:30 -0500 (EST)
Message-ID: <222405b5ba1a581079409a724c4ee76e6800253f.camel@HansenPartnership.com>
Subject: Re: Discussion about using NV indexes for kernel properties like
 localities and PCRs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Lennart Poettering <lennart@poettering.net>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Matthew
 Garrett <mjg59@srcf.ucam.org>, ilias.apalodimas@linaro.org
Date: Mon, 04 Dec 2023 08:01:27 -0500
In-Reply-To: <ZW2Z7jdO7cHlMsbp@gardel-login>
References: 
	<49b9916f60649ad66b87f29e9e87c9375b907975.camel@HansenPartnership.com>
	 <ZWpRhUNj_M5Pxeif@gardel-login>
	 <4d9bf547516c50617fe944590075c802492a0c04.camel@HansenPartnership.com>
	 <ZW2Z7jdO7cHlMsbp@gardel-login>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2023-12-04 at 10:20 +0100, Lennart Poettering wrote:
> On Fr, 01.12.23 17:23, James Bottomley
> (James.Bottomley@HansenPartnership.com) wrote:
[...]
> > > > I'm bringing this up for discussion now, in case anyone has a
> > > > better idea or wants to add nuances (like measuring the
> > > > creation to a real PCR and adding an event log to measured
> > > > boot) before I (or someone else) look into coding it up.
> > > 
> > > Why would that be necessary though? The "name" of an nvindex pins
> > > the access policy of the nvindex.
> > 
> > I assume you're talking about using TPM2_PolicyNameHash coupled
> > with TPM2_PolicyNV?  That pins to NV index value and name, but the
> > problem is that still doesn't necessarily solve the deletion
> > problem (see below).
> 
> I was thinking TPM2_PolicyAuthorizeNV and similar things too. They
> generally pin NVs by "name".

Heh, well, you have to be careful with that one as I just discovered
with NV PINs.  Most of the TPMs I have in my system actually comply
with rev 116.  NV PIN was added in rev 124 and PolicyAuthorizeNV in rev
132 which means they're not universally supported by TPM2 systems.

> > >  And nvindexes are always created uninitialized, thus to to
> > > initialize one you just created (i.e. execute the first write to
> > > it) you must be able to fulfill the write policy set for it. But
> > > if you can do that, then why bother with deleting/recreating them
> > > in the first place?
> > 
> > Well, I wasn't really considering using a policy for the index, I
> > was thinking of using the index for other policies (like key
> > release). However, even though you can have a policy for read and
> > write, you can't have a policy for delete unless you have access to
> > the platform hierarchy (which the problem statement above explained
> > is getting increasingly unlikely), so your index can still be reset
> > by deleting and recreating it (even if it is recreated with the
> > same policy). You're right that such an index would be detectably
> > uninitialized unless whoever deleted it can also write to it.
> 
> Yes, deletion doesn't really matter as long as the write policy for
> the NV is properly chosen so that whoever deletes/recreates the NV
> cannot write to it.
> 
> > >  And if you set a different access policy on them then the "name"
> > > of the nvindex would change, and it would become useless in all
> > > references from other objects/quotes/…
> > 
> > Right but to take a NV Extend index, you're saying I can delete it
> > and recreate it with exactly the same policy and attributes (so
> > same name) but then to prevent me placing malicious entries in it,
> > the policy has to be narrowly crafted to prevent malicious actors
> > extending it (because then policy can't tell the difference between
> > that recreated index and the original one).  I've thought about
> > this, but haven't ever really been able to come up with usable
> > policies, because all such policies end up requiring either a
> > privileged locality to write from or a shared secret between the
> > TPM and the trusted writer.
> 
> So my understanding is that you want fake PCRs, i.e. NV indexes that
> are world-readable, and world-extendable, and cannot be reset,
> correct?

Yes, effectively a simple extension of the PCR system beyond 24 indexes
for anyone to use.

> So a write policy like this should work, no:
> 
>     A TPM2_PolicyOR with three branches:
>         1. TPM2_PolicyCommandCode(TPM2_NV_Write) +
>            TPM2_PolicyNvWritten(writtenSet=false) +
>            TPM2_PolicySigned(…)
>         2. TPM2_PolicyCommandCode(TPM2_NV_Write) +
>            TPM2_PolicyNvWritten(writtenSet=true)
>         3. TPM2_PolicyCommandCode(TPM2_NV_Read)
> 
> (where "+" is suposed to mean AND...)

Well, no, that would mean the entity doing the create (first write) has
to be able to sign the command.  That requires a permanent secret (the
private key).  The problem I have is that I want to do this in the
kernel.  The kernel can generate ephemeral secrets but not permanent
ones that last across a boot and it certainly can't usefully (without
leaking) carry persistent private keys, so whatever scheme we come up
with for the kernel can't code a policy that contains a long lived
secret.  That's why I went for restricted creation and deletion: The
kernel can create the index and populate it with a random auth known
only to it and no-one else can delete and recreate.  Thus we have an
index that can be mentioned in PolicNV of a sealed object meaning that
only the kernel can unseal it.  For the NV Extend Indexes it means
they're wold readable and writable but usable by anyone and possessing
a no reset guarantee.

> So the first branch covers initialization. The branch first checks
> for *Write* access, and whether the NV hasn't been written yet. It
> then combines that with PolicySigned policy whith some public key.
> The idea would be to use a key pair here that you generate for this
> purpose only and throw it away after initialization. You could use
> other policies here too i guess. Important is that you use a policy
> here that only you as the creator can fulfill, and that fully pins
> all authentication objects you use, like PolicySigned does.
> 
> The second branch covers later extensions, all it checks is that the
> PCR is already initialized, and then makes no further restructions.
> 
> The third branch covers reading, and makes no restrictions beyond
> that.
> 
> I haven't tested the above, but it was my understanding that this is
> how you'd do it.
> 
> Crucial in all of the above is that you reference the NV indexes
> afterwards by their full name (thus also by their policy, which pins
> the public key of TPM2_PolicySigned), instead just by their numeric
> handle. Because if you'd ref them by their numeric handle only, then
> of course anyone can recreate them with a different policy without
> you noticing it. The important part is that you assign a policy to
> the NV index that ensures only you could have initialized them,
> because they pin some resource only you have control over.
> 
> In upcoming systemd 255 we now provide an IPC API for local clients
> to measure stuff into PCRs, and write a TCG-CEL record about it
> automatically. I was looking into extending that to also allow
> writing NV-index based "fake PCRs" and the above is basically what I
> had in mind to implement that.
> 
> But admittedly I am talking a bit out of my ass here, since I did not
> in fact implement the above. But I don't see why it wouldn't work.

I think it could work.  However to be effective in the above
PolicySigned, the entity creating the NV index will have to sign the
nonceTPM, meaning systemd will have to have the private key ... how
does that get provisioned? (it seems like a similar problem to
provisioning the kernel with a private key)

> 
> > > This logic is explicitly mentioned in that tpm book btw, it took
> > > me a while to grok how great that concept is, since it basically
> > > means you don't have to be concerned about removed/readded
> > > nvindexes at all.
> > 
> > Which TPM book is this?
> 
> "A practical guide to TPM 2.0". The one that always shows up in your
> google searches...

Thanks ... I didn't know anyone had written an actual book about the
TPM. I usually just get my insights from the architecture documents
(and how they change).

James


