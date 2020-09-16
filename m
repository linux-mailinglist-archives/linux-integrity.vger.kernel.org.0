Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D8126CE0A
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Sep 2020 23:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgIPVJM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Sep 2020 17:09:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:9526 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIPP4G (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Sep 2020 11:56:06 -0400
IronPort-SDR: KzBa4sdKSK3yNWgBCmea5Yshs2qyok17Brr6Qqbl/j+5OMTUL7Afzn9YwSJk0qPtcG9HukVxSI
 2i1aUYWnfBXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="244332699"
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="244332699"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 08:35:59 -0700
IronPort-SDR: vG00qaIGQ91Fq4yCMbdgwBb/Nz+V/1tmvgOiwmQQIrfAAHfRMSih1TAVTQD8x/HiLjwgFdF94T
 0AFTT2sZNxFw==
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="483354888"
Received: from mwsinger-mobl3.ger.corp.intel.com (HELO localhost) ([10.249.44.197])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 08:35:57 -0700
Date:   Wed, 16 Sep 2020 18:35:54 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1] tpm: use %*ph to print small buffer
Message-ID: <20200916153543.GA18575@linux.intel.com>
References: <20200730161613.41607-1-andriy.shevchenko@linux.intel.com>
 <20200818053351.GA119714@linux.intel.com>
 <20200914161033.GN3956970@smile.fi.intel.com>
 <20200915094332.GE3612@linux.intel.com>
 <20200915120411.GT3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915120411.GT3956970@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 15, 2020 at 03:04:11PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 15, 2020 at 12:43:32PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 14, 2020 at 07:10:33PM +0300, Andy Shevchenko wrote:
> > > On Tue, Aug 18, 2020 at 08:33:51AM +0300, Jarkko Sakkinen wrote:
> > > > On Thu, Jul 30, 2020 at 07:16:13PM +0300, Andy Shevchenko wrote:
> > > > > Use %*ph format to print small buffer as hex string.
> > > > > 
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 
> > > > Oh, this is handy, thanks.
> > > > 
> > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > 
> > > Thanks!
> > > 
> > > Anybody to push this?
> > 
> > It's in my tree git://git.infradead.org/users/jjs/linux-tpmdd.git
> > 
> > So next I'll put it to the next PR.
> 
> Thanks!
> 
> P.S. I don't see your tree connected to Linux Next, perhaps you can ask Stephen
> to add it?

The next branch is connected to the linux-next. I've just forgot to
rebase that branch (will do now).

> -- 
> With Best Regards,
> Andy Shevchenko

/Jarkko
