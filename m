Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E532120B0DD
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 13:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgFZLuh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 07:50:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:25482 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgFZLuh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 07:50:37 -0400
IronPort-SDR: xpRXPq6Fb7PHp748Obmp6R7RO2wjf5iS6xFVieumfAXqZqICBq64QX5JoxI+Q02WF95GOaqM9f
 Ed9xNrv4Mwqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="163343416"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="163343416"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 04:50:37 -0700
IronPort-SDR: bc2Fb/KBK57u0KnnIcJyQYSEdxA0vM/5LPsogxwcKccvptmP2PPg4tTu4gTNGndKcEAXWuDNeG
 CavqtMiUB9eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="276344069"
Received: from cgheban-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.199])
  by orsmga003.jf.intel.com with ESMTP; 26 Jun 2020 04:50:31 -0700
Date:   Fri, 26 Jun 2020 14:50:30 +0300
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
Subject: Re: [PATCH v2] tpm: tpm2-space: Resize session and context buffers
 dynamically
Message-ID: <20200626115030.GC5847@linux.intel.com>
References: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
 <a6444592-234b-d77e-7403-812e19691e72@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6444592-234b-d77e-7403-812e19691e72@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 05:38:03PM -0400, Stefan Berger wrote:
> On 6/25/20 12:38 AM, Jarkko Sakkinen wrote:
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
> > v2: TPM2_SPACE_DEFAULT_BUFFER_SIZE
> >   drivers/char/tpm/tpm2-space.c | 87 ++++++++++++++++++++++++-----------
> >   include/linux/tpm.h           |  6 ++-
> >   2 files changed, 64 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> > index 982d341d8837..b8ece01d6afb 100644
> > --- a/drivers/char/tpm/tpm2-space.c
> > +++ b/drivers/char/tpm/tpm2-space.c
> > @@ -15,6 +15,9 @@
> >   #include <asm/unaligned.h>
> >   #include "tpm.h"
> > +#define TPM2_SPACE_DEFAULT_BUFFER_SIZE	PAGE_SIZE
> > +#define TPM2_SPACE_MAX_BUFFER_SIZE	(4 * PAGE_SIZE)
> > +
> >   enum tpm2_handle_types {
> >   	TPM2_HT_HMAC_SESSION	= 0x02000000,
> >   	TPM2_HT_POLICY_SESSION	= 0x03000000,
> > @@ -557,8 +588,10 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
> >   	       sizeof(space->context_tbl));
> >   	memcpy(&space->session_tbl, &chip->work_space.session_tbl,
> >   	       sizeof(space->session_tbl));
> > -	memcpy(space->context_buf, chip->work_space.context_buf, PAGE_SIZE);
> > -	memcpy(space->session_buf, chip->work_space.session_buf, PAGE_SIZE);
> > +	memcpy(space->context_buf, chip->work_space.context_buf,
> > +	       space->context_size);
> 
> 
> You have to allocate the max size the in tpm_chip_alloc (tpm-chip.c):
> 
>    chip->work_space.context_buf = kzalloc(TPM2_SPACE_MAX_BUFFER_SIZE,
> GFP_KERNEL);
> 
> 
> > +	memcpy(space->session_buf, chip->work_space.session_buf,
> > +	       space->session_size);
> 
> 
> same for this

That is not true. They should allocated as 4 kB in the dynamic scaling
scheme. The idea is to use krealloc() to increase the buffer size.

/Jarkko
