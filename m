Return-Path: <linux-integrity+bounces-333-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 892C1802E6B
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 10:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B50AB208FB
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67900156FF;
	Mon,  4 Dec 2023 09:20:54 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFE6C3;
	Mon,  4 Dec 2023 01:20:49 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 22A22E8046B;
	Mon,  4 Dec 2023 10:20:47 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 9F12A1600FA; Mon,  4 Dec 2023 10:20:46 +0100 (CET)
Date: Mon, 4 Dec 2023 10:20:46 +0100
From: Lennart Poettering <lennart@poettering.net>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>, ilias.apalodimas@linaro.org
Subject: Re: Discussion about using NV indexes for kernel properties like
 localities and PCRs
Message-ID: <ZW2Z7jdO7cHlMsbp@gardel-login>
References: <49b9916f60649ad66b87f29e9e87c9375b907975.camel@HansenPartnership.com>
 <ZWpRhUNj_M5Pxeif@gardel-login>
 <4d9bf547516c50617fe944590075c802492a0c04.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d9bf547516c50617fe944590075c802492a0c04.camel@HansenPartnership.com>

On Fr, 01.12.23 17:23, James Bottomley (James.Bottomley@HansenPartnership.com) wrote:

> > > The flaw in both the above is that absent the ability to create
> > > platform NV indexes (which is impossible in modern firmware because
> > > the platform hierarchy gets locked out), anyone possessing the
> > > owner password (which is defined to be empty) can delete and
> > > recreate the index, causing the authorization to change for NV PIN
> > > and resetting the PCR for NV Extend.  To mitigate this, we could
> > > block out a range of NV indexes to be only accessible with the
> > > kernel (say 256 with handles of the form 010f0ffXX - I chose this
> > > so as not to be too close to either the beginning or end, but
> > > obviously the exact prefix is up for discussion).  The kernel would
> > > then snoop TPM2_NV_DefineSpace and TPM2_NV_UndefineSpace commands
> > > and trap and report an error for any attempt to add or delete an
> > > index in this range.  We could then get the kernel to create its
> > > PIN NV and say 127 NV Extend indexes, which userspace would be able
> > > to extend, query and make policies on but not delete.
> > >
> > > I'm bringing this up for discussion now, in case anyone has a
> > > better idea or wants to add nuances (like measuring the creation to
> > > a real PCR and adding an event log to measured boot) before I (or
> > > someone else) look into coding it up.
> >
> > Why would that be necessary though? The "name" of an nvindex pins the
> > access policy of the nvindex.
>
> I assume you're talking about using TPM2_PolicyNameHash coupled with
> TPM2_PolicyNV?  That pins to NV index value and name, but the problem
> is that still doesn't necessarily solve the deletion problem (see
> below).

I was thinking TPM2_PolicyAuthorizeNV and similar things too. They
generally pin NVs by "name".
>
> >  And nvindexes are always created uninitialized, thus to to
> > initialize one you just created (i.e. execute the first write to it)
> > you must be able to fulfill the write policy set for it. But if you
> > can do that, then why bother with deleting/recreating them in the
> > first place?
>
> Well, I wasn't really considering using a policy for the index, I was
> thinking of using the index for other policies (like key release).
> However, even though you can have a policy for read and write, you
> can't have a policy for delete unless you have access to the platform
> hierarchy (which the problem statement above explained is getting
> increasingly unlikely), so your index can still be reset by deleting
> and recreating it (even if it is recreated with the same policy).
> You're right that such an index would be detectably uninitialized
> unless whoever deleted it can also write to it.

Yes, deletion doesn't really matter as long as the write policy for
the NV is properly chosen so that whoever deletes/recreates the NV
cannot write to it.

> >  And if you set a different access policy on them then the "name" of
> > the nvindex would change, and it would become useless in all
> > references from other objects/quotes/…
>
> Right but to take a NV Extend index, you're saying I can delete it and
> recreate it with exactly the same policy and attributes (so same name)
> but then to prevent me placing malicious entries in it, the policy has
> to be narrowly crafted to prevent malicious actors extending it
> (because then policy can't tell the difference between that recreated
> index and the original one).  I've thought about this, but haven't ever
> really been able to come up with usable policies, because all such
> policies end up requiring either a privileged locality to write from or
> a shared secret between the TPM and the trusted writer.

So my understanding is that you want fake PCRs, i.e. NV indexes that
are world-readable, and world-extendable, and cannot be reset,
correct?

So a write policy like this should work, no:

    A TPM2_PolicyOR with three branches:
        1. TPM2_PolicyCommandCode(TPM2_NV_Write) +
           TPM2_PolicyNvWritten(writtenSet=false) +
           TPM2_PolicySigned(…)
        2. TPM2_PolicyCommandCode(TPM2_NV_Write) +
           TPM2_PolicyNvWritten(writtenSet=true)
        3. TPM2_PolicyCommandCode(TPM2_NV_Read)

(where "+" is suposed to mean AND...)

So the first branch covers initialization. The branch first checks for
*Write* access, and whether the NV hasn't been written yet. It then
combines that with PolicySigned policy whith some public key. The idea
would be to use a key pair here that you generate for this purpose
only and throw it away after initialization. You could use other
policies here too i guess. Important is that you use a policy here
that only you as the creator can fulfill, and that fully pins all
authentication objects you use, like PolicySigned does.

The second branch covers later extensions, all it checks is that the
PCR is already initialized, and then makes no further restructions.

The third branch covers reading, and makes no restrictions beyond that.

I haven't tested the above, but it was my understanding that this is
how you'd do it.

Crucial in all of the above is that you reference the NV indexes
afterwards by their full name (thus also by their policy, which pins
the public key of TPM2_PolicySigned), instead just by their numeric
handle. Because if you'd ref them by their numeric handle only, then
of course anyone can recreate them with a different policy without you
noticing it. The important part is that you assign a policy to the NV
index that ensures only you could have initialized them, because they
pin some resource only you have control over.

In upcoming systemd 255 we now provide an IPC API for local clients to
measure stuff into PCRs, and write a TCG-CEL record about it
automatically. I was looking into extending that to also allow writing
NV-index based "fake PCRs" and the above is basically what I had in
mind to implement that.

But admittedly I am talking a bit out of my ass here, since I did not
in fact implement the above. But I don't see why it wouldn't work.

> > This logic is explicitly mentioned in that tpm book btw, it took me a
> > while to grok how great that concept is, since it basically means you
> > don't have to be concerned about removed/readded nvindexes at all.
>
> Which TPM book is this?

"A practical guide to TPM 2.0". The one that always shows up in your
google searches...

Lennart

--
Lennart Poettering, Berlin

