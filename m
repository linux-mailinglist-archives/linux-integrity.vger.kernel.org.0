Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34AF969927
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfGOQfC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 12:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbfGOQfC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 12:35:02 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DCDB2081C;
        Mon, 15 Jul 2019 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563208501;
        bh=P7A+7gOxObkHWO6q15pHPOZJY3ZnoB4xnL29l3PZe7s=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=qRoAXzIa+pdRPCFXmxYW6ryLdJ2CjbYC4GD+SDb0fQBtStL6KbuhUqmyfRlQFh0g9
         n7FqCIbiLmWySaaO1UByUZU6qPSTydhuwChSZkbatxzPJt+c+rFLYo1pUpwziZeyas
         4AoxFsumGv8w82GA/mGC5+C1YtW4PbLtSrEmfv4g=
Date:   Mon, 15 Jul 2019 09:34:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        syzbot <syzbot+5ab61747675a87ea359d@syzkaller.appspotmail.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.vnet.ibm.com
Subject: Re: possible deadlock in process_measurement
Message-ID: <20190715163459.GB728@sol.localdomain>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        syzbot <syzbot+5ab61747675a87ea359d@syzkaller.appspotmail.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.vnet.ibm.com
References: <00000000000054e5d1058a6df2eb@google.com>
 <1562854476.4014.47.camel@linux.ibm.com>
 <20190711195011.GA48706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190711195011.GA48706@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 11, 2019 at 12:50:13PM -0700, Eric Biggers wrote:
> Hi Mimi,
> 
> On Thu, Jul 11, 2019 at 10:14:36AM -0400, Mimi Zohar wrote:
> > Hi Eric,
> > 
> > On Mon, 2019-06-03 at 09:35 -0700, syzbot wrote:
> > > syzbot has found a reproducer for the following crash on:
> > > 
> > > HEAD commit:    3c09c195 Add linux-next specific files for 20190531
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10f61a0ea00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=6cfb24468280cd5c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=5ab61747675a87ea359d
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177c3d16a00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ec01baa00000
> > > 
> > 
> > This reproducer seems like it is similar, but the cause is different
> > than the original report.  One has to do with overlayfs, while the
> > other has to do with ext4, mprotect/mmap.  I assume in both cases an
> > IMA policy was required to trigger the locking bug.  What type of IMA
> > policy are you using?
> > 
> > Do we need to differentiate the two reports?  Is the "last occurred"
> > notification for the overlay, for mprotect, or both?  Please Cc the
> > overlay mailing list on the overlay aspect.
> 
> AFAICS, syzbot boots all kernels with "ima_policy=tcb" on the command line.
> And I don't think anything in userspace changes the IMA policy.
> 
> It's not unusual for multiple underlying bugs to get mixed into the same syzbot
> bug.  syzbot doesn't know that one "possible deadlock in process_measurement" is
> different from another.  "Last occurred" is for any crash that appeared as such.
> 
> This just needs to be handled the best we can.  Sometimes all the bugs can be
> fixed; sometimes they've already been fixed; or sometimes it's easiest to fix
> just one and then mark the syzbot bug as fixed, and syzbot will report it again
> it's still occurring for some other reason.
> 
> - Eric

Invalidating this bug report as per the discussion at
https://lkml.kernel.org/linux-integrity/1563122888.4539.119.camel@linux.ibm.com/T/#mcd083826e5843f048c914c56a4e82147fc211704

#syz invalid

For future reference, anyone can update the status of syzbot bugs; no need to
ask me to do it.  See https://goo.gl/tpsmEJ#status

- Eric
