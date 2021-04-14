Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D119E35FAB5
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Apr 2021 20:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353252AbhDNSUM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Apr 2021 14:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352047AbhDNSUH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Apr 2021 14:20:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D8F761153;
        Wed, 14 Apr 2021 18:19:43 +0000 (UTC)
Date:   Wed, 14 Apr 2021 20:19:40 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: null-ptr-deref in integrity_inode_free()
Message-ID: <20210414181940.fp66fiwkcfoogu44@wittgenstein>
References: <20210414115055.mayc4aeonsklgwks@wittgenstein>
 <630cc0a27a0db8fd790a767300ae0a7f2540bdc2.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <630cc0a27a0db8fd790a767300ae0a7f2540bdc2.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 14, 2021 at 01:46:46PM -0400, Mimi Zohar wrote:
> Hi Christian,
> 
> On Wed, 2021-04-14 at 13:50 +0200, Christian Brauner wrote:
> > Hey,
> > 
> > [Resending since the previous mail somehow hasn't made it onto the list.]
> > 
> > While working on a patch to port ecryptfs to use clone_private_mount() I
> > hit the splat in [1] with v5.12-rc6 (Without any of my changes.). To
> > reproduce this you can use the config in [5]. Then run the scripts [2]
> > and [3] in two terminals. The kernel command line was [4]:
> > 
> > while true; do ./test.sh; done
> > while true; do ./test2.sh; done
> > 
> > and wait for [1] to appear.
> > 
> > The two test scripts aren't specifically designed to trigger this issue.
> > They were stress tests for my ecryptfs clone_private_mount() port. They
> > just allow to trigger this issue.
> > 
> > From a very uninformed position it seemed that:
> > 
> > void integrity_inode_free(struct inode *inode)
> > {
> >         struct integrity_iint_cache *iint;
> > 
> >         if (!IS_IMA(inode))
> >                 return;
> 
> Thank you for all the details.
> 
> A builtin IMA policy wasn't specified on the boot command line.  Unless
> a custom IMA policy is loaded, it shouldn't get beyond this
> point.   Before looking any farther, I would appreciate your confirming
> that you've loaded a custom IMA policy.  To see if a policy has been
> loaded, cat /sys/kernel/security/ima/policy.

Ah, interesting thank you. Here's the output:

sudo cat /sys/kernel/security/ima/policy
  dont_measure fsmagic=0x9fa0
  dont_measure fsmagic=0x62656572
  dont_measure fsmagic=0x64626720
  dont_measure fsmagic=0x1021994
  dont_measure fsmagic=0x1cd1
  dont_measure fsmagic=0x42494e4d
  dont_measure fsmagic=0x73636673
  dont_measure fsmagic=0xf97cff8c
  dont_measure fsmagic=0x43415d53
  dont_measure fsmagic=0x27e0eb
  dont_measure fsmagic=0x63677270
  dont_measure fsmagic=0x6e736673
  dont_measure fsmagic=0xde5e81e4
  measure func=MMAP_CHECK mask=MAY_EXEC
  measure func=BPRM_CHECK mask=MAY_EXEC
  measure func=FILE_CHECK mask=^MAY_READ euid=0
  measure func=FILE_CHECK mask=^MAY_READ uid=0
  measure func=MODULE_CHECK
  measure func=FIRMWARE_CHECK
  measure func=POLICY_CHECK

Hm, note that ecryptfs is not in this list so I guess ecryptfs would be
measured?

Thanks for the quick reply!
Christian
