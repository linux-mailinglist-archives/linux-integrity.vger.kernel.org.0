Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525E7B635E
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfIRMhg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Sep 2019 08:37:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33304 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725902AbfIRMhg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Sep 2019 08:37:36 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8ICbOWC010072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 08:37:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4E445420811; Wed, 18 Sep 2019 08:37:24 -0400 (EDT)
Date:   Wed, 18 Sep 2019 08:37:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org
Subject: Re: IMA on remote file systems
Message-ID: <20190918123724.GJ6762@mit.edu>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
 <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
 <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com>
 <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
 <20190917124533.GD6762@mit.edu>
 <1568732169.11799.18.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568732169.11799.18.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 17, 2019 at 09:56:09AM -0500, James Bottomley wrote:
> > There seems to be a philosophical debate about this.  Some IMA folks
> > have claimed that you want to know at the time of the binary being
> > executed, whether or not it is corrupt or not.  Their concern is that
> > if you can make a binary crash when it pages in some page of memory,,,,
>
> That's not my recollection of the IMA position.

I had *several* conversations with IMA folks, including Mimi, who very
carefully explained to me why fs-verity was bad from a security
perspective.  We also had security experts inside Google who said it
was fine, so it's fair to say that there is no unaminimity on this
issue.  (Put 4 security experts in a room, and watch 5 different
positions develop).

> I'd more say the Linux Kernel itself, at least for executables, has
> mechanisms to ensure open files aren't updated because that ends up
> causing potential I/D cache incoherence with resulting binary crashes,
> so for executables, IMA relies on this mechanism.

But that's only true because the disk is inside the TCB.  If you can
modify the disk while file is open --- for example, if the NSA has
created trojaned HDD firmware --- then assuming that the kernel can
ensure that the file can't be modified while it's being executed is
completely false.  Consider what happens if the file is stored on
iSCSI, where either (a) there is no protection of the network
connection, or (b) the iSCSI device is under the control of the
malicious attacker.

> I'd also be wary of pushing a merkle tree as a solution to the TOC/TOU
> problem because, while it's true you can appraise a page at a time
> using the lowest layer hash, unless you do a full merkle tree check on
> that hash every time, you're still vulnerable to the attacker
> corrupting both the hash and the page (especially as the merkle tree
> can be so huge, requiring that it be paged too).

If the page containing the lowest layer hash is in memory (and memory
is considered part of the TCB), then we don't need to do the full
merkle tree check.  If the lowest layer hash has been pushed out of
memory, then it has to be read from the storage device, but we might
not still have to do a full merkle tree check.  We only have to do a
check up to the merkle tree block which is still in memory.  In
practice, both for dm-verity and fs-verity, the upper layers of the
Merkle tree are will tend to be kept in memory because we can touch
them as "accessed" even though we didn't need to actually recompute
the hash of tree nodes which are still in memory.

So the Merkle tree *does* solve the TOC/TOU issue, so long as we are
careful and explicit about what are trust assumptions are.  And
certainly treating the memory as being in the TCB is fairly
uncontroversial thing to do!

						 Ted
