Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF41204627
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 02:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbgFWAun (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 20:50:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:3802 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbgFWAum (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 20:50:42 -0400
IronPort-SDR: Zjqf4XvfGRdjFl7zUBQCRnyRQODuGd4Twn9aoJR5bMYU8/ja+UgPaQstSzBYwykBabtQUF2gfm
 VI0umvLrXOPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="228576385"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="228576385"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 17:50:41 -0700
IronPort-SDR: NQZ2b+kbGeudWWVrnRpJr4mCx+Xzw+yu2KbiQYirZ5UPucKt2IqPwMYdi7GcuJMa26OHkjLr+B
 3bIWN0DPA74A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="275174181"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2020 17:50:36 -0700
Date:   Tue, 23 Jun 2020 03:50:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv8 0/3] optee: register drivers on optee bus
Message-ID: <20200623005034.GC28795@linux.intel.com>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
 <20200616082907.GA2305431@jade>
 <20200617233755.GI62794@linux.intel.com>
 <20200618075613.GA97184@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618075613.GA97184@jade>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 18, 2020 at 09:56:13AM +0200, Jens Wiklander wrote:
> On Thu, Jun 18, 2020 at 02:37:55AM +0300, Jarkko Sakkinen wrote:
> > On Tue, Jun 16, 2020 at 10:29:07AM +0200, Jens Wiklander wrote:
> > > Hi Maxim and Jarkko,
> > > 
> > > On Mon, Jun 15, 2020 at 05:32:40PM +0300, Maxim Uvarov wrote:
> > > > ping.
> > > > Patchset was reviewed and all comments are codeverd. Optee-os patches
> > > > were merged. These kernel patches look like they are hanging
> > > > somewhere...
> > > 
> > > I'm almost OK with this patchset, except that
> > > Documentation/ABI/testing/sysfs-bus-optee-devices needs to be updated
> > > for the new kernel version and TEE mailing list which we're changing right
> > > now.
> > > 
> > > The last patch touches files I'm not maintainer of. That patch depends
> > > on the previous patches so it makes sense to keep them together.  If a
> > > TPM device driver maintainer would ack that patch I can take it via my
> > > tree. Or we can do it the other way around (with a v9 patchset),
> > > whichever is preferred.
> > > 
> > > Cheers,
> > > Jens
> > 
> > Probably easier if you pick all three and I ack the one touching TPM.
> 
> Makes sense, let's do that.

Great, thanks!

/Jarkko
