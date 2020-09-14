Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3872F269124
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Sep 2020 18:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgINQLX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Sep 2020 12:11:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:56368 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgINQKi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Sep 2020 12:10:38 -0400
IronPort-SDR: deVWHz8DCvVjXaTg8SjliIStbEx/VYihGHeHXIS9AJ+UzQGOpgj2/EqZB3py04SdNDgNHvJ/Pr
 dC9RuddCDCsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="138609994"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="138609994"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 09:10:38 -0700
IronPort-SDR: tSFl7hCHlBiQeWsfz5lFgpf7V0tPemhN4x7dz2+dcWTcwOtHmxdFhQT4dgDGqHuEZwomiFaK1a
 GBxMKtZYGaKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="335328460"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2020 09:10:36 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kHr3p-00GdcQ-MH; Mon, 14 Sep 2020 19:10:33 +0300
Date:   Mon, 14 Sep 2020 19:10:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1] tpm: use %*ph to print small buffer
Message-ID: <20200914161033.GN3956970@smile.fi.intel.com>
References: <20200730161613.41607-1-andriy.shevchenko@linux.intel.com>
 <20200818053351.GA119714@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818053351.GA119714@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 18, 2020 at 08:33:51AM +0300, Jarkko Sakkinen wrote:
> On Thu, Jul 30, 2020 at 07:16:13PM +0300, Andy Shevchenko wrote:
> > Use %*ph format to print small buffer as hex string.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Oh, this is handy, thanks.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Thanks!

Anybody to push this?

-- 
With Best Regards,
Andy Shevchenko


