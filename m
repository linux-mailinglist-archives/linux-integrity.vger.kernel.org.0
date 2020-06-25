Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647E820A762
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406059AbgFYVZJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:25:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:48700 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403817AbgFYVZJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:25:09 -0400
IronPort-SDR: 9aj0JHzH+46SYZmpY3zgR4ipms0dJKrn3mtpToH3uuSZJkV6ebLblFTTOgW3XqZyXJr0ZhwFHl
 UWT36zlniaCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="124731569"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="124731569"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 14:25:07 -0700
IronPort-SDR: JjzDwpV7/tC8ln67VUO2qXVTBl+4LIVaxChS5eHlCy/zuRAKXDUCyNlknQHRYEzQyWbVV0gSlN
 hSy5cQDguCRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="298925489"
Received: from gumm-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.49.123])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2020 14:25:01 -0700
Date:   Fri, 26 Jun 2020 00:24:53 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: tpm2-space: Resize session and context buffers
 dynamically
Message-ID: <20200625212453.GB20341@linux.intel.com>
References: <20200625042424.370072-1-jarkko.sakkinen@linux.intel.com>
 <2f8a0127-d2ba-21aa-75b3-2dfccfb52eab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8a0127-d2ba-21aa-75b3-2dfccfb52eab@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 08:13:09AM -0400, Stefan Berger wrote:
> On 6/25/20 12:24 AM, Jarkko Sakkinen wrote:
> > Re-allocate context and session buffers when needed. Scale them in page
> > increments so that the reallocation is only seldomly required, and thus
> > causes minimal stress to the system. Add a static maximum limit of four
> > pages for buffer sizes.
> > 
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> > Tested only for compilation.
> >   drivers/char/tpm/tpm2-space.c | 80 ++++++++++++++++++++++++-----------
> >   include/linux/tpm.h           |  6 ++-
> >   2 files changed, 59 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> > index 982d341d8837..acb9e82bf9e8 100644
> > --- a/drivers/char/tpm/tpm2-space.c
> > +++ b/drivers/char/tpm/tpm2-space.c
> > @@ -15,6 +15,8 @@
> >   #include <asm/unaligned.h>
> >   #include "tpm.h"
> > +#define TPM2_SPACE_MAX_BUFFER_SIZE	(4 * PAGE_SIZE)
> 
> PAGE_SIZE is 64k on ppc64. Rather use 4 * 4096?

Better to then just put it as 16384.

/Jarkko
