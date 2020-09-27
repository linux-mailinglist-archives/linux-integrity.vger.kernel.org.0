Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2D27A498
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 01:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgI0Xog (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 19:44:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:49228 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgI0Xof (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 19:44:35 -0400
IronPort-SDR: myz93UbUXq+313TweIkD60PEEJc1x4J3hTjFAzlJvwRnE1cx9SiUI8VOwbMJ9kTZTNf0qOZZPk
 sYeRtxFWKgsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="226066131"
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="226066131"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 16:44:34 -0700
IronPort-SDR: p/MoEwnZUTIU6YADym/9tny3NBWILcdmUcBVG/1LvGtme765bN2LwleFvXBR+JX1SFCFJi8nh0
 Tbob45FrVRsw==
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="488337532"
Received: from memara-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 16:44:32 -0700
Date:   Mon, 28 Sep 2020 02:44:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] tpm: of: avoid __va() translation for event log address
Message-ID: <20200927234434.GA5283@linux.intel.com>
References: <20200922094128.26245-1-ardb@kernel.org>
 <20200925055626.GC165011@linux.intel.com>
 <CAMj1kXFLWsFz7HV4sHLbwBkuiEu0gT4esSH8umVrvDDrJaOLrQ@mail.gmail.com>
 <20200925102920.GA180915@linux.intel.com>
 <20200925120018.GH9916@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925120018.GH9916@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 25, 2020 at 09:00:18AM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 25, 2020 at 01:29:20PM +0300, Jarkko Sakkinen wrote:
> > On Fri, Sep 25, 2020 at 09:00:56AM +0200, Ard Biesheuvel wrote:
> > > On Fri, 25 Sep 2020 at 07:56, Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > On Tue, Sep 22, 2020 at 11:41:28AM +0200, Ard Biesheuvel wrote:
> > > > > The TPM event log is provided to the OS by the firmware, by loading
> > > > > it into an area in memory and passing the physical address via a node
> > > > > in the device tree.
> > > > >
> > > > > Currently, we use __va() to access the memory via the kernel's linear
> > > > > map: however, it is not guaranteed that the linear map covers this
> > > > > particular address, as we may be running under HIGHMEM on a 32-bit
> > > > > architecture, or running firmware that uses a memory type for the
> > > > > event log that is omitted from the linear map (such as EfiReserved).
> > > >
> > > > Makes perfect sense to the level that I wonder if this should have a
> > > > fixes tag and/or needs to be backported to the stable kernels?
> > > >
> > > 
> > > AIUI, the code was written specifically for ppc64, which is a
> > > non-highmem, non-EFI architecture. However, when we start reusing this
> > > driver for ARM, this issue could pop up.
> > > 
> > > The code itself has been refactored a couple of times, so I think it
> > > will require different versions of the patch for different generations
> > > of stable kernels.
> > > 
> > > So perhaps just add Cc: <stable@vger.kernel.org>, and wait and see how
> > > far back it applies cleanly?
> > 
> > Yeah, I think I'll cc it with some note before the diffstat.
> > 
> > I'm thinking to cap it to only 5.x kernels (at least first) unless it is
> > dead easy to backport below that.
> 
> I have this vauge recollection of pointing at this before and being
> told that it had to be __va for some PPC reason?
> 
> Do check with the PPC people first, I see none on the CC list.
> 
> Jason

Thanks, added arch/powerpc maintainers.

/Jarkko
