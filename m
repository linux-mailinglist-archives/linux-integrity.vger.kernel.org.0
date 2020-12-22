Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CC02E0F19
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Dec 2020 20:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgLVTvP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 14:51:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:36462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgLVTvP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 14:51:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23840AFBE;
        Tue, 22 Dec 2020 19:50:33 +0000 (UTC)
Date:   Tue, 22 Dec 2020 20:50:30 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        paul@paul-moore.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ima: Add test for selinux measurement
Message-ID: <20201222195030.GA141126@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200928194730.20862-1-nramas@linux.microsoft.com>
 <20200928194730.20862-2-nramas@linux.microsoft.com>
 <X9z2+nXBdTMqHPgD@pevik>
 <0db52810-c7e2-713a-80ed-748e8bb3db74@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db52810-c7e2-713a-80ed-748e8bb3db74@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

> On 12/18/20 10:37 AM, Petr Vorel wrote:

> Hi Petr,

> > @Lakshmi
> > TL;DR: I added some fixes in my fork, branch ima/selinux.v2.draft,
> > https://github.com/pevik/ltp/commits/ima/selinux.v2.draft

> > + added 3 additional commits, one of them as you as the author.
> > I moved some functions to testcases/lib/tst_security.sh, renamed them.
> > Can you please have a look and test? I don't have any SELinux machine.

> I'll take a look at the changes in your branch and test it with SELinux
> enabled.
Thanks!

> > @Mimi, all: any comment to this test? My changes are just LTP cleanup
> > so you can comment it on this patchset.
> > I suppose you get to this in January.

> > Some notes for my changes:

> > As files are quite similar (checks etc), I put both tests into single
> > file ima_selinux.sh.
> This should be fine.

> The reason I put the tests in different files was because I couldn't find a
> way to run the tests independently (i mean - say, run the SELinux policy
> measurement test but not the state measurement test or vice-versa).

Why do you need to run just one of them?
If you really need to separate them (e.g. to require different OS setup for
each) you could have 2 functions in single file, but run only one of them
(TST_CNT not set, which means TST_CNT=1), doing selection with getopt switch?
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#233-optional-command-line-parameters

> > > New functionality is being added to IMA to measure data provided by
> > > kernel components. With this feature, IMA policy can be set to enable
> > > measuring data provided by Linux Security Modules (LSM). Currently one
> > > such LSM namely selinux is being updated to use this functionality.
> > > This new functionality needs test automation in LTP.

> > > Add test cases which verify that the IMA subsystem correctly measures
> > > the data provided by selinux.

> > Could you please put into commit message and test kernel commit hash relevant
> > for the test. Is that 8861d0af642c646c8e148ce34c294bdef6f32f6a (merged into
> > v5.10-rc1) or there are more relevant commits?

> The IMA hook to measure kernel critical data + SELinux measurement changes
> are still being reviewed. Tushar has posted v9 of the patch set.
Thanks for info (note for myself:
https://lore.kernel.org/linux-integrity/20201212180251.9943-1-tusharsu@linux.microsoft.com/)
OK, not yet merged to mainline. It's good you send patches early (speed up the
inclusion to LTP), but we should merge them into LTP once it's at least
already in Mimi tree prepared for sending to Linus.

Feel free to Cc me in your next kernel patches (It *can* help to speedup the inclusion to LTP).

> > ...
> > > +### IMA SELinux test
> > > +
> > > +To enable IMA to measure SELinux state and policy, `ima_selinux_policy.sh`
> > > +and `ima_selinux_state.sh` require a readable IMA policy, as well as
> > > +a loaded measure policy with
> > > +`measure func=CRITICAL_DATA data_sources=selinux template=ima-buf`
> > I put this into
> > testcases/kernel/security/integrity/ima/datafiles/ima_selinux/selinux.policy
> > and mention it in docs.
> Sounds good - Thanks.

> "template=ima_buf" is no longer needed in the IMA policy rule since
> "ima_buf" is the default template for buffer measurement now. I will update
> "datafiles/ima_selinux/selinux.policy" file.

+1

...

> Thanks a lot for your help Petr. Appreciate it.
yw, thanks for your contributions.

>  -lakshmi
Petr
