Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2107375154
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 11:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhEFJP4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 May 2021 05:15:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:41866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231815AbhEFJPz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 May 2021 05:15:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A334B17E;
        Thu,  6 May 2021 09:14:57 +0000 (UTC)
Date:   Thu, 6 May 2021 11:14:55 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        linux-integrity@vger.kernel.org, dm-devel@redhat.com,
        ltp@lists.linux.it
Subject: Re: [PATCH v2 2/2] IMA: Add test for dm-crypt measurement
Message-ID: <YJOzjw0k+ZgWaQO3@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200928035605.22701-1-tusharsu@linux.microsoft.com>
 <20200928035605.22701-3-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928035605.22701-3-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar, Mimi, Lakshmi,

> New functionality is being added to IMA to measure data provided by
> kernel components. With this feature, IMA policy can be set to enable
> measuring data provided by device-mapper targets. Currently one such
> device-mapper target - dm-crypt, is being updated to use this
> functionality. This new functionality needs test automation in LTP.

> Add a testcase which verifies that the IMA subsystem correctly measures
> the data coming from a device-mapper target - dm-crypt.

I noticed v10 patchset [1] has been merged, including SELinux commit
fdd1ffe8a812 ("selinux: include a consumer of the new IMA critical data hook"),
thus I merge this patchset.

I suppose fdd1ffe8a812 is the commit which should be mentioned in
ima_dm_crypt.sh, right? (the only change to v3 [2])

Kind regards,
Petr

[1] https://lore.kernel.org/linux-integrity/20210108040708.8389-1-tusharsu@linux.microsoft.com/
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=230766&state=*
