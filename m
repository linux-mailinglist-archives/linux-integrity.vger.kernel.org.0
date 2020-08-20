Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCB524C330
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 18:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgHTQPE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Aug 2020 12:15:04 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60766 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729471AbgHTQPC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Aug 2020 12:15:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CE6CF8EE45B;
        Thu, 20 Aug 2020 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597940100;
        bh=GNAzGx2BdDQxSfyJ4JXMXwIX5fjt7ttuOVHDCDkX0No=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DHDf1MySTSro5Adr9mcytJ5D+FvozzrMcrA7fnj2flWRk/ZyHrxWN2hdV48knsLiS
         vRr0KCzopzeoB5xcwesDetwvKQcw1F5zzh6CFnKbpLbdN0DGk1US5D7YgVoYCW4nXF
         lFuIa/yY+/QRhG1ZJQeBPpNcWYPvdeyyXZDOnykI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yhkDpnyFK6tS; Thu, 20 Aug 2020 09:14:56 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C97AE8EE0E4;
        Thu, 20 Aug 2020 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597940091;
        bh=GNAzGx2BdDQxSfyJ4JXMXwIX5fjt7ttuOVHDCDkX0No=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h5P7561iUdBTEXvOqd6THaNCGGqZAB/96Xv1Y55Yd3lcqZIaX8Bop9cEtUi2NXKBz
         v5gvW4UoKyBjt1wA6KTpq2A8Op8dMEyZKMWwmtj7lYw6whoIwpEk79Jdi5/LUTtWqZ
         PLePEe8av5yEWqkwJar9Y6GkwLuqyIxMlOhdRnt4=
Message-ID: <1597940084.3864.35.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 20 Aug 2020 09:14:44 -0700
In-Reply-To: <20200819232132.GT1152540@nvidia.com>
References: <20200818164602.GZ1152540@nvidia.com>
         <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
         <20200818183603.GC1152540@nvidia.com>
         <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
         <20200819120238.GD1152540@nvidia.com>
         <1597850231.3875.13.camel@HansenPartnership.com>
         <20200819161845.GK1152540@nvidia.com>
         <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
         <20200819171709.GN1152540@nvidia.com>
         <1597867756.3875.39.camel@HansenPartnership.com>
         <20200819232132.GT1152540@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-19 at 20:21 -0300, Jason Gunthorpe wrote:
> On Wed, Aug 19, 2020 at 01:09:16PM -0700, James Bottomley wrote:
> > On Wed, 2020-08-19 at 14:17 -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 19, 2020 at 12:57:42PM -0400, Mimi Zohar wrote:
> > > > On Wed, 2020-08-19 at 13:18 -0300, Jason Gunthorpe wrote:
> > > > > Yes - it was dropped because TPM 2 was a *complete ABI break*
> > > > > for everything. The kernel was reset to a uABI that matches
> > > > > current uABI standards starting TPM 2.
> > > > > 
> > > > > The whole userspace needed to be redone anyhow, and certainly
> > > > > nobody objected at the time.
> > > > > 
> > > > > At least my expecation was that a sensible userspace for TPM
> > > > > (for administrator user) would be built, like we see in other
> > > > > subsystems eg 'ip' for netdev.
> > > > 
> > > > "Because TPM 2 was a complete ABI break for everything" could
> > > > be reason for upstreaming a minimal subset of functionality
> > > > initially, which could be expanded over time.  I don't recall a
> > > > discussion about limting features in the future.
> > > 
> > > All new uAPI additions need to pass the usual uAPI hurdles.
> > > 
> > > As James outlined, justify why the kernel must present a
> > > duplicated uAPI between sysfs and /dev/tpm. 
> > > 
> > > There have been good reasons in the past, eg SCSI inquiry.
> > 
> > First, can we please agree /dev/tpm does not substitute as a
> > "duplicate API". 
> 
> Er? Huh? How so?

Because like the SCSI command interface it's a binary marshalled
protocol we want to abstract for users.  We can still argue whether the
kernel or a toolkit should do the abstraction but it's not one we want
to dump on users and say "this is it, what do you mean you don't like
it?"

> > I can now clarify the objection into "it's a binary marshalled
> > interface and Linus doesn't think we should force users to use
> > them":
> > 
> > https://lore.kernel.org/linux-api/CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZ
> > sczy6GBimiogZws=rg@mail.gmail.com/
> 
> I'm not sure which part of that you want to quote?
> 
> "It's great for well-specified wire protocols." which is describing
> /dev/tpm - it has a multivendor standards body.

Actually this bit "I think marshalling binary data is actively evil and
wrong. It's great for well-specified wire protocols. It's great for
internal communication in user space. It's *NOT* great for a kernel
system call interface."

/dev/tpm is a user to kernel interface.

> Bit puzzled about the rest of this message? Do you think Linus
> belives netlink should have been implemented as ASCII? JSON parser in
> the kernel maybe? Confusing.

Heh, well I remember ASN.1 parser over my dead body and now we have one
...

> > Perhaps we should also simply copy linux-api and accept the
> > judgment of the experts on whether we should expose PCRs via sysfs.
> 
> Well, AFAIK, for a long time now the mantra has been "if it can be
> done in userspace then it should not be in the kernel" ..

Really, no, we've never had that.  A filesystem can be done in
userspace but there's no move to throw them all out of the kernel.  We
bring stuff into the kernel when it's more efficient and useful and
makes the presentation layer easier.  The question isn't could the user
do it at any cost, the question is if we do it can we maintain it
easily and does it make life easier for the user (and would they
actually use the interface).

> I would really like to see a better reason for this - one that
> doesn't boil down to it being 'too hard' to write a bit of code in
> userspace.

I haven't said that.  I've said there are three (and got corrected to
4) reasons to have easy access to PCR hex values:

   1. early boot measurement checks
   2. log verification
   3. key sealing
   4. log stability checking

> eg we can't do it because we can't access /dev/tpm for permissions or
> something.

I already said that: we can't it's root.root 0600 currently.  All the
TSSs seem to change at least /dev/tpmrm to tpm.tpm 0660 but we can't do
that in the kernel because there's no fixed tpm uid/gid.

> > The reason we provide a kernel interface instead of a library or
> > tool is that libraries and tools tend to be domain specific and the
> > information needs to be provided across domains.  So: both the
> > current TPM 2.0 TSSs are written in C.  This means they can just
> > about be plugged into python but not easily into Go because of its
> > abhorrence of ffis.  Providing the PCRs from sysfs allows Go
> > attestation easy access that the TSS tools don't because of the
> > language domain problem.
> 
> I went to try to make a python implementation.. After about 10mins I
> came up with this approximate thing:
> 
>  select = struct.pack(">BBB", 1, 0, 0) # PCR 1
>  pcrread_in = struct.pack(">IHB", 1, TPM2_ALG_SHA1, len(select)) +
> select
>  msg = struct.pack(">HII", TPM2_ST_NO_SESSIONS, 10 + len(pcrread_in),
> TPM2_CC_PCR_READ) + pcrread_in
> 
>  with open("/dev/tpm","wb") as tpm:
>     tpm.write(msg)
>     resp = tpm.read(msg)
> 
>  tag, length, return_code = struct.unpack(">HII",res[:10])
>  if not return_code:
>     raise Error()
> 
>  return res[10+20:] # digest
> 
> Which is hopefully quite close to being something working - at least
> it looks fairly close to what the kernel implementation does.
> 
> Fortunately no Phd was required! I think Go would be about similar,
> right?

I could do the same with perl, but not bash.  In the same way I could
construct an anomalous SO(3) higgs model as a party trick.

the point is that when you ask users would they rather do the above or
cat /sys/class/tpm/tpm0/pcr-sha1/1 they'll universally opt for the
latter because it's way simpler.

Now perhaps if the mechanism that services this in the kernel were
thousands of lines long and unmaintainable you'd think twice, but it's
not, it's under 200 lines.  So the maintainability bar to us providing
this is low and the user convenience quite high ... that's what makes
it look like a good interface.

James

