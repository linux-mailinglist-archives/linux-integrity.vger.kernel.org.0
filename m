Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E6B4E52
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2019 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfIQMpv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Sep 2019 08:45:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51299 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726626AbfIQMpv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Sep 2019 08:45:51 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8HCjXH6020608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 08:45:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6BB66420811; Tue, 17 Sep 2019 08:45:33 -0400 (EDT)
Date:   Tue, 17 Sep 2019 08:45:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org
Subject: Re: IMA on remote file systems
Message-ID: <20190917124533.GD6762@mit.edu>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
 <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
 <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com>
 <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 17, 2019 at 09:30:31AM +0300, Janne Karhunen wrote:
> I might be wrong, but handling this properly would be good for the
> core IMA as well. Take an example of a memory mapped database file:
> this file will have generic write access for a group of processes.
> Now, if the attacker can create memory pressure on the host, we might
> eventually end up freeing pages from this particular file. Once this
> happens the attacker is free to modify the pages on the disk and they
> will all get eventually loaded back into the memory without no-one
> noticing.

There seems to be a philosophical debate about this.  Some IMA folks
have claimed that you want to know at the time of the binary being
executed, whether or not it is corrupt or not.  Their concern is that
if you can make a binary crash when it pages in some page of memory,
you might be able to exploit that fact by being able to force some
setuid binary to stop at some arbitrary point.  My understanding was
that they were pretty absolutist about that position, and that's one
of the reason why the original fs-verity work was completely decoupled
from IMA, and why fs-verity exists in the first place ---- if you have
gargantuan binaries with ELF debugging sections which will never get
read in normal use cases, or APK files with translation tables or
video cut scenes which are only used at when the game is first
started, or in between major sections of the game, you don't want to
delay application startup for long periods of time just to checksum
the whole darned file.

The issue about using memory pressure to push pages out to disk and
forcing a TOU/TOC security failure is the reason why Check is
interested in fs-verity.  In the original IMA design, the disk is
considered part of the Trusted Computing Base (TCB), at least while it
was spinning.  So the asssumption is the attacker wouldn't be able to
modify the disk blocks once the system was booted, and IMA merely
protected against off-line attacks (aka, "the evil maid scenario"
where the laptop or mobile device left in the hotel room gets a free
upgrade courtesy of some state intelligence agency like the MSS).  But
for NFS, the NFS server is generally not considered part of the TCB,
so the original IMA design very vulnerable to the concern you've
described.

> Could the fs-verity be plugged in as a measurement mechanism in the
> IMA? So rather than calling a hash function, call verity to measure
> and add new set of IMA hooks to report violations that arise after
> execution? IMA policy logic and functionality would be pretty much
> unchanged.

That is the plan, and it's not hard to do.  The question which I've
raised is when should we do it, given that some people believe that
pulling the entire file into memory and checksumming it at exec or
open time is a feature, not a bug.

Should we use the fs-verity merkel tree root hash as the measurement
function unconditionally if it is present?  Or does IMA want to have
some kind of tuning knob; and if so, should it be on a per-file system
basis, or globally, etc. etc.  Those are IMA design questions, and
I'll let the IMA folks decide what they want to do.

						- Ted
