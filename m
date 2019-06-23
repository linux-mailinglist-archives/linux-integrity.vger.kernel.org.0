Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37074FEB8
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 03:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfFXBwj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Jun 2019 21:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfFXBw0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Jun 2019 21:52:26 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA11920679;
        Sun, 23 Jun 2019 22:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561328212;
        bh=IvSVNZN1N00MPlRGAbsOxh40iObSPq/1KBRUajFGdDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0wYDr8B5v+8WiDw1RKltlWxftpJe7wv2f2uHSOFi+oNNRL1/Dfbssov717/3alEnc
         uiIO+/v5nnZmaroHOv8Gq0cpReHVHvz3fXvB1TSxC9hSqDhSdSZm3zgRR2yWV9J6rL
         aSRi/Of/fjfzFmeDNI+9b+7zjPNTKoLkiE1lEzrw=
Date:   Sun, 23 Jun 2019 15:16:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+e1374b2ec8f6a25ab2e5@syzkaller.appspotmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [IMA] Re: possible deadlock in get_user_pages_unlocked (2)
Message-ID: <20190623221650.GE772@sol.localdomain>
References: <0000000000001d42b5058a895703@google.com>
 <20190610190622.GI63833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610190622.GI63833@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 10, 2019 at 12:06:23PM -0700, Eric Biggers wrote:
> On Tue, Jun 04, 2019 at 06:16:00PM -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> > 
> > commit 69d61f577d147b396be0991b2ac6f65057f7d445
> > Author: Mimi Zohar <zohar@linux.ibm.com>
> > Date:   Wed Apr 3 21:47:46 2019 +0000
> > 
> >     ima: verify mprotect change is consistent with mmap policy
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1055a2f2a00000
> > start commit:   56b697c6 Add linux-next specific files for 20190604
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1255a2f2a00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1455a2f2a00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4248d6bc70076f7d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e1374b2ec8f6a25ab2e5
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165757eea00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dd3e86a00000
> > 
> > Reported-by: syzbot+e1374b2ec8f6a25ab2e5@syzkaller.appspotmail.com
> > Fixes: 69d61f577d14 ("ima: verify mprotect change is consistent with mmap
> > policy")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > 
> 
> Hi Mimi, it seems your change to call ima_file_mmap() from
> security_file_mprotect() violates the locking order by taking i_rwsem while
> mmap_sem is held.
> 
> - Eric

This patch was dropped from linux-next, so let's invalidate the bug report.

#syz invalid

- Eric
