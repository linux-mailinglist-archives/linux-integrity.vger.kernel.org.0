Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECC7257750
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 12:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgHaK3h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 06:29:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:57494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgHaK3h (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 06:29:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38548AC1D;
        Mon, 31 Aug 2020 10:30:11 +0000 (UTC)
Date:   Mon, 31 Aug 2020 12:29:34 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
Message-ID: <20200831102934.GB17121@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
 <20200827132354.GA20439@dell5510>
 <20200827135503.GA11990@dell5510>
 <b72657042d13f9b8f30d5bdea7e2d06835e4a1d1.camel@linux.ibm.com>
 <20200827225417.GA29921@dell5510>
 <d6087ee43d18605ee6cdc6b80450b0024af14fb6.camel@linux.ibm.com>
 <20200828060554.GB15251@dell5510>
 <3c720a7060a846088f8e60ce8b5c032467e97f23.camel@linux.ibm.com>
 <20200828124924.GB15355@dell5510>
 <889c90c2777e2683749ab6d339e25aa85b192407.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889c90c2777e2683749ab6d339e25aa85b192407.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> On Fri, 2020-08-28 at 14:49 +0200, Petr Vorel wrote:
> > > On Fri, 2020-08-28 at 08:05 +0200, Petr Vorel wrote:
> > > > BTW there are also plans for reboot support [1] [2], that could be used as
> > > > workaround for configuration without CONFIG_IMA_READ_POLICY=y and
> > > > CONFIG_IMA_WRITE_POLICY=y.
> > > The reboot support could also be used for carrying the IMA measurement
> > > list across kexec and verifying the TPM PCRs.

> > Adding into my TODO list. I'd just run whole test ima_kexec.sh twice and reboot
> > in between.

> The ima_kexec.sh tests measures the kexec boot cmdline and kernel
> image.   What's needed is walking the measurement list re-calculating
> the PCRs and then verifying them against the actual TPM PCRs.  Maybe
> running the ima_tpm.sh test twice.
Right, thanks for clarification :).

It takes some time till reboot implementation in LTP API is implemented. But I
hope to send fix for TPM 2.0 and sha256 hash (these changes in v5.8) for
ima_tpm.sh this week.


Kind regards,
Petr
