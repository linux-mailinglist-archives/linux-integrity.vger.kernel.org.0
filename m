Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED3826A4D2
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Sep 2020 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgIOMPU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Sep 2020 08:15:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:51087 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgIOMPP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Sep 2020 08:15:15 -0400
IronPort-SDR: raW72nE/iwZg43sMciheqleYTl6OGj7OjUL2KfgWe9elBqKxRCd49A5uSJB7tH+4EdTPlI5cka
 eUiWYKnCPX5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="159291373"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="159291373"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 05:15:10 -0700
IronPort-SDR: as83Ldh1nOjMKIVxg5d4Ro4g0TgWHqR6bV/HbfDifdcgoZJmtj3D0Tj1u1OkGI/Gl3yF9OeiE7
 IiDveKo80RJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="335619231"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 15 Sep 2020 05:15:09 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kI9gx-00GpfV-T2; Tue, 15 Sep 2020 15:04:11 +0300
Date:   Tue, 15 Sep 2020 15:04:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1] tpm: use %*ph to print small buffer
Message-ID: <20200915120411.GT3956970@smile.fi.intel.com>
References: <20200730161613.41607-1-andriy.shevchenko@linux.intel.com>
 <20200818053351.GA119714@linux.intel.com>
 <20200914161033.GN3956970@smile.fi.intel.com>
 <20200915094332.GE3612@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915094332.GE3612@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 15, 2020 at 12:43:32PM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 14, 2020 at 07:10:33PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 18, 2020 at 08:33:51AM +0300, Jarkko Sakkinen wrote:
> > > On Thu, Jul 30, 2020 at 07:16:13PM +0300, Andy Shevchenko wrote:
> > > > Use %*ph format to print small buffer as hex string.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > Oh, this is handy, thanks.
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Thanks!
> > 
> > Anybody to push this?
> 
> It's in my tree git://git.infradead.org/users/jjs/linux-tpmdd.git
> 
> So next I'll put it to the next PR.

Thanks!

P.S. I don't see your tree connected to Linux Next, perhaps you can ask Stephen
to add it?

-- 
With Best Regards,
Andy Shevchenko


