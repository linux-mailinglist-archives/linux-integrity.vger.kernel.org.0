Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4721326A275
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Sep 2020 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIOJnj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Sep 2020 05:43:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:22247 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgIOJnh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Sep 2020 05:43:37 -0400
IronPort-SDR: n75KC0TM4rZrpg28r+qY+cecbw0A3qxry4gGl2vKMH3hSWR5U7VEt7ouvAL1yueG8Bg0pSQ7OP
 BY4jl9tJElKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="160161366"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="160161366"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 02:43:37 -0700
IronPort-SDR: aHfUOfoMw95zXogLWeCz/ty91ta8tI+pUka20QnYOyHZvoIarxaVVlqQ0waGloILpIqn1u2+PT
 OoBGmyv8s1Gw==
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="451239757"
Received: from blank-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.208])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 02:43:35 -0700
Date:   Tue, 15 Sep 2020 12:43:32 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1] tpm: use %*ph to print small buffer
Message-ID: <20200915094332.GE3612@linux.intel.com>
References: <20200730161613.41607-1-andriy.shevchenko@linux.intel.com>
 <20200818053351.GA119714@linux.intel.com>
 <20200914161033.GN3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914161033.GN3956970@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 14, 2020 at 07:10:33PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 18, 2020 at 08:33:51AM +0300, Jarkko Sakkinen wrote:
> > On Thu, Jul 30, 2020 at 07:16:13PM +0300, Andy Shevchenko wrote:
> > > Use %*ph format to print small buffer as hex string.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Oh, this is handy, thanks.
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Thanks!
> 
> Anybody to push this?

It's in my tree git://git.infradead.org/users/jjs/linux-tpmdd.git

So next I'll put it to the next PR.

/Jarkko
