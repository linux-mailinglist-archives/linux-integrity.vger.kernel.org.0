Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF75B5EF58
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 01:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfGCXB3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 19:01:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:13942 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfGCXB3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 19:01:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 16:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="184871694"
Received: from elsaidmo-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.33.22])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2019 16:01:27 -0700
Date:   Thu, 4 Jul 2019 02:01:25 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Milan Broz <gmazyland@gmail.com>, linux-integrity@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH] tpm: Fix null pointer dereference on chip register error
 path
Message-ID: <20190703230125.aynx4ianvqqjt5d7@linux.intel.com>
References: <20190612084210.13562-1-gmazyland@gmail.com>
 <9df0a432-eb9c-914e-5ddc-2680a6fecebd@gmail.com>
 <a8fc7162019168ab3b9b662fb629855205a6b1ca.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8fc7162019168ab3b9b662fb629855205a6b1ca.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 02, 2019 at 09:37:51PM +0300, Jarkko Sakkinen wrote:
> On Fri, 2019-06-28 at 09:56 +0200, Milan Broz wrote:
> > Hi,
> > 
> > is there any problem in this with the trivial patch below?
> > 
> > I just get the same crash again with stable 5.1 kernel...
> > 
> > Milan
> 
> I'm sorry but I'm seeing this patch for the first time.

OK, I finally reviewed your patch. Thank for finding this sever bug! I
just have a few remarks.

First of all, we need to add the necessary fixes tag to the patch, which
will tell the commit ID that caused the crash and the one who we should
blame:

Fixes: 719b7d81f204 ("tpm: introduce tpm_chip_start() and tpm_chip_stop()")

It was a piece of a fairly large and complex refactorization [1] but it
is not really a legit excuse and this is very unfortunate.

I think it'd be better to take a different path how this will be fixed.

Right after tpm_go_idle(), please add these:

static void tpm_clk_enable(struct tpm_chip *chip)
{
	if (chip->ops->clk_enable)
		chip->ops->clk_enable(chip);
}

static void tpm_tpm_clk_disable(struct tpm_chip *chip)
{
	if (chip->ops->tpm_clk_disable)
		chip->ops->tpm_clk_disable(chip);
}

This is consistent with the other callbacks and gives better guarantees
that a similar thing won't happen the next time when something happens
to the call sites. This is what I should have done in my patch set to
zero out the risk but failed to do that.

You should categorically include the corresponding subsystem
maintainers. Please check [2]. It is not like I would ignore any
patches. It is more related to the risk of human error.

Like many people, I filter any mailing list emails out of my inbox and
go through them at some point. This will cause a random number of days
of latency and with extremely bad luck I even might miss a patch
completely.

As a last remark put patch signed-off-by's and similar tags as last in
your patch and put cc and fixes (in that order) before them.

[1] https://lore.kernel.org/linux-integrity/20190205224723.19671-1-jarkko.sakkinen@linux.intel.com/
[2] https://www.kernel.org/doc/html/v5.1/process/submitting-patches.html#select-the-recipients-for-your-patch

/Jarkko
