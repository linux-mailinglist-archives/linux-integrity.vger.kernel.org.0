Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7F8278513
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Sep 2020 12:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgIYK3Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 06:29:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:21115 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgIYK3Y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 06:29:24 -0400
IronPort-SDR: vuOcnjED3Fx0CeCEZsVaptiom6ZqPLQHOh0joeyQC4aDCqcOWpKtr2EeWc2uTeTLwOfWR+thi1
 OgKw3v/T6uaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="140904959"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="140904959"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 03:29:24 -0700
IronPort-SDR: 6yOz4t4UbYext8bf560KO5M7v1plRNU+tSJgTyJBDE1vo7EE4RE7RggBMPB2j+H49EhzuSE9RH
 yhPJD8TzwMHA==
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="455766872"
Received: from tjhenson-mobl.amr.corp.intel.com (HELO localhost) ([10.252.48.117])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 03:29:22 -0700
Date:   Fri, 25 Sep 2020 13:29:20 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm: of: avoid __va() translation for event log address
Message-ID: <20200925102920.GA180915@linux.intel.com>
References: <20200922094128.26245-1-ardb@kernel.org>
 <20200925055626.GC165011@linux.intel.com>
 <CAMj1kXFLWsFz7HV4sHLbwBkuiEu0gT4esSH8umVrvDDrJaOLrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFLWsFz7HV4sHLbwBkuiEu0gT4esSH8umVrvDDrJaOLrQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 25, 2020 at 09:00:56AM +0200, Ard Biesheuvel wrote:
> On Fri, 25 Sep 2020 at 07:56, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Tue, Sep 22, 2020 at 11:41:28AM +0200, Ard Biesheuvel wrote:
> > > The TPM event log is provided to the OS by the firmware, by loading
> > > it into an area in memory and passing the physical address via a node
> > > in the device tree.
> > >
> > > Currently, we use __va() to access the memory via the kernel's linear
> > > map: however, it is not guaranteed that the linear map covers this
> > > particular address, as we may be running under HIGHMEM on a 32-bit
> > > architecture, or running firmware that uses a memory type for the
> > > event log that is omitted from the linear map (such as EfiReserved).
> >
> > Makes perfect sense to the level that I wonder if this should have a
> > fixes tag and/or needs to be backported to the stable kernels?
> >
> 
> AIUI, the code was written specifically for ppc64, which is a
> non-highmem, non-EFI architecture. However, when we start reusing this
> driver for ARM, this issue could pop up.
> 
> The code itself has been refactored a couple of times, so I think it
> will require different versions of the patch for different generations
> of stable kernels.
> 
> So perhaps just add Cc: <stable@vger.kernel.org>, and wait and see how
> far back it applies cleanly?

Yeah, I think I'll cc it with some note before the diffstat.

I'm thinking to cap it to only 5.x kernels (at least first) unless it is
dead easy to backport below that.

> > This is a really great catch!
> >
> > I'm a bit late of my PR a bit because of SGX upstreaming madness
> > (sending v39 soon). If you can answer to my question above, I can do
> > that nitpick change to patch and get it to my v5.10 PR.
> >
> 
> Yes, please.

Great, will do, thanks again for fixing this issue!

/Jarkko
