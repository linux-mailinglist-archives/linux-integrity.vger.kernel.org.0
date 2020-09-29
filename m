Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CC727BC66
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 07:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgI2FXp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 01:23:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:33802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgI2FXo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 01:23:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02318ABCC;
        Tue, 29 Sep 2020 05:23:43 +0000 (UTC)
Date:   Tue, 29 Sep 2020 07:23:40 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        paul@paul-moore.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1 0/1] ima: Add test for selinux measurement
Message-ID: <20200929052340.GA4976@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200928194730.20862-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928194730.20862-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

Thanks for your patch. FYI I'll try to have look ASAP, but as there is LTP
freeze and work needed to review fixes before release I'll probably review this
after the release (1, max. 2 weeks).

Could you please have a look at fix planned to be part of the release?
https://patchwork.ozlabs.org/project/ltp/list/?series=204230

Kind regards,
Petr

> New functionality is being added to IMA to measure data provided by
> kernel components. With this feature, IMA policy can be set to enable
> measuring data provided by Linux Security Modules (LSM). Currently one
> such LSM namely selinux is being updated to use this functionality.
> This new functionality needs test automation in LTP.

> This patch set adds tests which verify that the IMA subsystem correctly
> measures the data provided by selinux.

> This patch is based on 
> commit 286401a1c1f3 ("thp04: Add linux tag")
> in "master" branch in https://github.com/linux-test-project/ltp

> This patch is dependent on the following patch series in LTP
> https://patchwork.kernel.org/patch/11802771/
I put link to LTP patchwork to avoid the confusion.
https://patchwork.ozlabs.org/project/ltp/list/?series=204486

> This series needs a kernel built on the following repo/branch/patches:
> repo: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> branch: next
> commit 8861d0af642c ("selinux: Add helper functions to get and set checkreqprot")
Thanks for adding this info. It'd be great if it were part of kernel commit
message and also added as a comment in the test itself (we don't want to get it
lost).

BTW LTP has 2 kind ways of handling of kernel versions:

* fixes which are meant to be backported to the stable trees:
In C API it looks like (here also with CVE entry):
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/bpf/bpf_prog03.c#L187
.tags = (const struct tst_tag[]) {
		{"linux-git", "95a762e2c8c9"},
		{"CVE", "2017-16995"},
		{}
This is not part of shell API, but I'll add it after the release. Thus we don't
want to loose this info.

* new kernel features, which are likely not to be backported
You either have some way to detect this feature is presented (ideally) or you
specify kernel version since it should be run
This is used in shell API as:
https://github.com/linux-test-project/ltp/blob/master/testcases/network/tcp_cc/bbr02.sh#L8
TST_MIN_KVER="4.13"

> And the following patch series should be applied in the following order:
>   1, https://patchwork.kernel.org/patch/11709527/
>   2, https://patchwork.kernel.org/patch/11795559/
>   3, https://patchwork.kernel.org/patch/11801525/
>   4, https://patchwork.kernel.org/patch/11801585/

Kind regards,
Petr
