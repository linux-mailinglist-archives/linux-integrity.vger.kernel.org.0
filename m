Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEEFCB50D2
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2019 16:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfIQO4u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Sep 2019 10:56:50 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33614 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728187AbfIQO4u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Sep 2019 10:56:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E7D828EE112;
        Tue, 17 Sep 2019 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568732203;
        bh=VB6eHdsjCnDwJBZQE9Q2QLgbNZ/Qo2NtYCQ4sTU+zhA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iNOVK/9fEUj2IZQtaWtfDWjyy/pCB96TyBAmc1YOjgpzqklBgDxCnwAuYTLPmfHsd
         0E9Eb/HuED+Xbx8x+g428e5M2vIXiod7jgghg1dN8aLk0NrF2Op7+sNTTn25hWSdda
         rFSjEtRiyNRL+wNzrpI4CVjXaX8CyEIZLVVYpxik=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U_mHac_XmPNT; Tue, 17 Sep 2019 07:56:16 -0700 (PDT)
Received: from [172.16.8.204] (unknown [63.86.108.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B0FF58EE10C;
        Tue, 17 Sep 2019 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568732176;
        bh=VB6eHdsjCnDwJBZQE9Q2QLgbNZ/Qo2NtYCQ4sTU+zhA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WKX8jHjlOi7pd9M8MMvKNum/UGw4uLS6id8unw0M2TxmOc/dxzIm6MhEd/2rX1pQE
         eHYBJBcTpCaw8vGbiIex8qsbNmUxonNBhhLo30V//TQJl2sUNLTDpr7Yn0ruHp1naR
         twmIcdJNESARB3QrxQ3IuzjfWYnTbIHKu8gq1Y4g=
Message-ID: <1568732169.11799.18.camel@HansenPartnership.com>
Subject: Re: IMA on remote file systems
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 17 Sep 2019 09:56:09 -0500
In-Reply-To: <20190917124533.GD6762@mit.edu>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
         <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
         <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com>
         <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
         <20190917124533.GD6762@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-09-17 at 08:45 -0400, Theodore Y. Ts'o wrote:
> On Tue, Sep 17, 2019 at 09:30:31AM +0300, Janne Karhunen wrote:
> > I might be wrong, but handling this properly would be good for the
> > core IMA as well. Take an example of a memory mapped database file:
> > this file will have generic write access for a group of processes.
> > Now, if the attacker can create memory pressure on the host, we
> > might eventually end up freeing pages from this particular file.
> > Once this happens the attacker is free to modify the pages on the
> > disk and they will all get eventually loaded back into the memory
> > without no-one noticing.
> 
> There seems to be a philosophical debate about this.  Some IMA folks
> have claimed that you want to know at the time of the binary being
> executed, whether or not it is corrupt or not.  Their concern is that
> if you can make a binary crash when it pages in some page of memory,
> you might be able to exploit that fact by being able to force some
> setuid binary to stop at some arbitrary point.  My understanding was
> that they were pretty absolutist about that position, and that's one
> of the reason why the original fs-verity work was completely
> decoupled from IMA, and why fs-verity exists in the first place ----
> if you have gargantuan binaries with ELF debugging sections which
> will never get read in normal use cases, or APK files with
> translation tables or video cut scenes which are only used at when
> the game is first started, or in between major sections of the game,
> you don't want to delay application startup for long periods of time
> just to checksum the whole darned file.

That's not my recollection of the IMA position.  My recollection is
that when IMA was created the idea was to use a single hash, gated in a
variety of places dependent on policy, which would appraise the whole
file when the gate was hit.  The reason seems to be more pragmatic:
single hashes and signed single hashes are small enough to store in
xattrs, well understood in cryptographic situations and easy to deal
with.  The biggest problem with fs-verity has been where to store the
merkel tree.  However, what I've heard from IMA people is as long as
the merkle tree storage problem gets solved satisfactorily, they're 
perfectly happy to have per page hash verification be an IMA mechanism
because it's a simple extension of policy and an addition of a gate.

> The issue about using memory pressure to push pages out to disk and
> forcing a TOU/TOC security failure is the reason why Check is
> interested in fs-verity.  In the original IMA design, the disk is
> considered part of the Trusted Computing Base (TCB), at least while
> it was spinning.  So the asssumption is the attacker wouldn't be able
> to modify the disk blocks once the system was booted, and IMA merely
> protected against off-line attacks (aka, "the evil maid scenario"
> where the laptop or mobile device left in the hotel room gets a free
> upgrade courtesy of some state intelligence agency like the MSS).

I'd more say the Linux Kernel itself, at least for executables, has
mechanisms to ensure open files aren't updated because that ends up
causing potential I/D cache incoherence with resulting binary crashes,
so for executables, IMA relies on this mechanism.  For non executables,
it tries to use the inode generation to see if a recheck is required. 
In order to corrupt the underlying file, you have to be able to write
to it outside the VFS ... not impossible, but a well understood attack
vector.

I'd also be wary of pushing a merkle tree as a solution to the TOC/TOU
problem because, while it's true you can appraise a page at a time
using the lowest layer hash, unless you do a full merkle tree check on
that hash every time, you're still vulnerable to the attacker
corrupting both the hash and the page (especially as the merkle tree
can be so huge, requiring that it be paged too).

So I'd rather say the monolithic hash and merkle tree have different
potential TOC/TOU failure modes and thus different potential security
properties, so it's right a user gets to choose the properties they
want by policy.

>   But for NFS, the NFS server is generally not considered part of the
> TCB, so the original IMA design very vulnerable to the concern you've
> described.

A lot of work has gone into NFS security, so I wouldn't say you can
never trust the NFS server (A lot of cloud storage still uses NFS, for
instance, and they've sold it to their customers as secure).  However,
again, by policy, there might be situations where you have trust
problems with the NFS server and want additional security.  There it
certainly seems that the merkle tree approach can provide useful
additions to this situation provided you're careful how the hash is
supplied and checked (this seems to me where we should be focussing the
technical discussion).

> > Could the fs-verity be plugged in as a measurement mechanism in the
> > IMA? So rather than calling a hash function, call verity to measure
> > and add new set of IMA hooks to report violations that arise after
> > execution? IMA policy logic and functionality would be pretty much
> > unchanged.
> 
> That is the plan, and it's not hard to do.  The question which I've
> raised is when should we do it, given that some people believe that
> pulling the entire file into memory and checksumming it at exec or
> open time is a feature, not a bug.
> 
> Should we use the fs-verity merkel tree root hash as the measurement
> function unconditionally if it is present?  Or does IMA want to have
> some kind of tuning knob; and if so, should it be on a per-file
> system basis, or globally, etc. etc.  Those are IMA design questions,
> and I'll let the IMA folks decide what they want to do.

That's surely policy and IMA is very flexible with regard to policy, so
you wouldn't really want to make a global prescription.   I believe the
current IMA plan is simply to let the policy decide the question, which
seems right to me.

James

