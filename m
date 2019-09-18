Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD914B6775
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 17:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbfIRPtS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Sep 2019 11:49:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54588 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387523AbfIRPtR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Sep 2019 11:49:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5F9FA8EE39B;
        Wed, 18 Sep 2019 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568821756;
        bh=pV+U3JrxZ0vg1uc8q3EfdqiS1pD5NdIKNyj2PdHTzus=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mNohVmX8Oz3sWR10a0BNZnJ+Ygd4itmKWIwjD+Kcmyt1zK5EXgeHi6pZhggt6c+ks
         7oXgaQaZwEtuFEuPVCkrc08u0JI7HfHgbQzxjL9lKz06uf5DH0dPeHldyJJzZ32nEE
         ljY5P0kc4JxMeK63srvn2Ip8osyAwCPbBKgOPom8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sITLx5HxDuuJ; Wed, 18 Sep 2019 08:49:16 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8199F8EE10C;
        Wed, 18 Sep 2019 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568821755;
        bh=pV+U3JrxZ0vg1uc8q3EfdqiS1pD5NdIKNyj2PdHTzus=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=izjOkg9ln4xDlCVs9nWS28jfI3m7CwX/KNqebRiaCZNPh6ZoJwK8TbsZW9PdFhZW6
         Si9d8ojk+wgGAzWv+9oQR5kaRqqPW4uN05Hy9XDwMntArri/KOZYaanNXlGtDhzbwR
         aEJwG6uimruuVrw0dBPSbbTapo1WlgEMsqd+tO/g=
Message-ID: <1568821751.5817.12.camel@HansenPartnership.com>
Subject: Re: IMA on remote file systems
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 18 Sep 2019 08:49:11 -0700
In-Reply-To: <20190918123724.GJ6762@mit.edu>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
         <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
         <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com>
         <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
         <20190917124533.GD6762@mit.edu>
         <1568732169.11799.18.camel@HansenPartnership.com>
         <20190918123724.GJ6762@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-09-18 at 08:37 -0400, Theodore Y. Ts'o wrote:
> On Tue, Sep 17, 2019 at 09:56:09AM -0500, James Bottomley wrote:
> > > There seems to be a philosophical debate about this.  Some IMA
> > > folks have claimed that you want to know at the time of the
> > > binary being executed, whether or not it is corrupt or
> > > not.  Their concern is that if you can make a binary crash when
> > > it pages in some page of memory,,,,
> > 
> > That's not my recollection of the IMA position.
> 
> I had *several* conversations with IMA folks, including Mimi, who
> very carefully explained to me why fs-verity was bad from a security
> perspective.  We also had security experts inside Google who said it
> was fine, so it's fair to say that there is no unaminimity on this
> issue.  (Put 4 security experts in a room, and watch 5 different
> positions develop).
> 
> > I'd more say the Linux Kernel itself, at least for executables, has
> > mechanisms to ensure open files aren't updated because that ends up
> > causing potential I/D cache incoherence with resulting binary
> > crashes, so for executables, IMA relies on this mechanism.
> 
> But that's only true because the disk is inside the TCB.

No, it's because Linux can't let an I/D cache inconsistency develop. 
IMA merely piggy backed off that.

>   If you can modify the disk while file is open --- for example, if
> the NSA has created trojaned HDD firmware

The NSA isn't necessary ... root can write to the underlying disk even
if it has a mounted filesystem.  If you can control the system such
that you can trust root, then you can start on the NSA conspiracy
theories.

>  --- then assuming that the kernel can ensure that the file can't be
> modified while it's being executed is completely false.  Consider
> what happens if the file is stored on iSCSI, where either (a) there
> is no protection of the network connection, or (b) the iSCSI device
> is under the control of the malicious attacker.

As I said, there are solutions which pull remote devices into the
security envelope, but there are reasons why a user might have
problems, with not having the security solution available topping the
list.

> > I'd also be wary of pushing a merkle tree as a solution to the
> > TOC/TOU problem because, while it's true you can appraise a page at
> > a time using the lowest layer hash, unless you do a full merkle
> > tree check on that hash every time, you're still vulnerable to the
> > attacker corrupting both the hash and the page (especially as the
> > merkle tree can be so huge, requiring that it be paged too).
> 
> If the page containing the lowest layer hash is in memory (and memory
> is considered part of the TCB), then we don't need to do the full
> merkle tree check.

Root can modify the page cache, so this is, again, an implicit
assumption you can trust root.  If you're on the NSA conspiracy theory
then the BMC can be trojan'd and can modify memory ...

>   If the lowest layer hash has been pushed out of memory, then it has
> to be read from the storage device, but we might not still have to do
> a full merkle tree check.  We only have to do a check up to the
> merkle tree block which is still in memory.  In practice, both for
> dm-verity and fs-verity, the upper layers of the Merkle tree are will
> tend to be kept in memory because we can touch them as "accessed"
> even though we didn't need to actually recompute the hash of tree
> nodes which are still in memory.

If I've managed to push out the lower nodes, I've likely managed to
push out the upper nodes too along with most of the tree, so this is
rather weak protection.

As I said in the prior email, I think you can overcome this by forcing
a check up to the top every time you read the tree, but that's an
O(logN) effort.

> So the Merkle tree *does* solve the TOC/TOU issue, so long as we are
> careful and explicit about what are trust assumptions are.  And
> certainly treating the memory as being in the TCB is fairly
> uncontroversial thing to do!

In my mind, it's no more or less controversial than the disk being in
it, which, as I said, you have to be careful about.

The general point is there is no absolute trust in anything.  However,
customers are often willing to trust some things, with different
customers willing to trust different things, so having a configurable
policy here is really the required thing.

James

