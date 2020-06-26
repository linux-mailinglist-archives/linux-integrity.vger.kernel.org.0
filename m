Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D049E20B0DB
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 13:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgFZLta (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 07:49:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:45416 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgFZLt3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 07:49:29 -0400
IronPort-SDR: itH5Wmwwuu3IIaTIQW7NdtoCRRnoxq/kyuMsGPghJsinYqFrGPH/TM1YO0PsEcZSPKyXcYgByN
 A6HlvrUFyaBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="144375106"
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="144375106"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 04:49:27 -0700
IronPort-SDR: +2Lh6LRsgHug/9yOnBIUE5tsUdtszJB9qbb0T7sCT+4526QuCLFI3GhDKzLHyaw6CHB8tBe3PA
 f3AlVHrjybBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="276343881"
Received: from cgheban-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.199])
  by orsmga003.jf.intel.com with ESMTP; 26 Jun 2020 04:49:21 -0700
Date:   Fri, 26 Jun 2020 14:49:20 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: tpm2-space: Resize session and context buffers
 dynamically
Message-ID: <20200626114920.GB5847@linux.intel.com>
References: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
 <20200625212817.rxzjsgecrfpcb6ph@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625212817.rxzjsgecrfpcb6ph@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 02:28:17PM -0700, Jerry Snitselaar wrote:
> On Thu Jun 25 20, Jarkko Sakkinen wrote:
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
> > drivers/char/tpm/tpm2-space.c | 87 ++++++++++++++++++++++++-----------
> > include/linux/tpm.h           |  6 ++-
> > 2 files changed, 64 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> > index 982d341d8837..b8ece01d6afb 100644
> > --- a/drivers/char/tpm/tpm2-space.c
> > +++ b/drivers/char/tpm/tpm2-space.c
> > @@ -15,6 +15,9 @@
> > #include <asm/unaligned.h>
> > #include "tpm.h"
> > 
> > +#define TPM2_SPACE_DEFAULT_BUFFER_SIZE	PAGE_SIZE
> > +#define TPM2_SPACE_MAX_BUFFER_SIZE	(4 * PAGE_SIZE)
> > +
> > enum tpm2_handle_types {
> > 	TPM2_HT_HMAC_SESSION	= 0x02000000,
> > 	TPM2_HT_POLICY_SESSION	= 0x03000000,
> > @@ -40,16 +43,21 @@ static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
> > 
> > int tpm2_init_space(struct tpm_space *space)
> > {
> > -	space->context_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	space->context_buf = kzalloc(TPM2_SPACE_DEFAULT_BUFFER_SIZE,
> > +				     GFP_KERNEL);
> > 	if (!space->context_buf)
> > 		return -ENOMEM;
> > 
> > -	space->session_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	space->session_buf = kzalloc(TPM2_SPACE_DEFAULT_BUFFER_SIZE,
> > +				     GFP_KERNEL);
> > 	if (space->session_buf == NULL) {
> > 		kfree(space->context_buf);
> > +		space->context_buf = NULL;
> > 		return -ENOMEM;
> > 	}
> > 
> > +	space->context_size = TPM2_SPACE_DEFAULT_BUFFER_SIZE;
> > +	space->session_size = TPM2_SPACE_DEFAULT_BUFFER_SIZE;
> > 	return 0;
> > }
> > 
> > @@ -116,11 +124,13 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> > 	return 0;
> > }
> > 
> > -static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> > -			     unsigned int buf_size, unsigned int *offset)
> > +static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 **buf,
> > +			     unsigned int *buf_size, unsigned int *offset)
> > {
> > -	struct tpm_buf tbuf;
> > +	unsigned int new_buf_size;
> > 	unsigned int body_size;
> > +	struct tpm_buf tbuf;
> > +	void *new_buf;
> > 	int rc;
> > 
> > 	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
> > @@ -131,31 +141,48 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> > 
> > 	rc = tpm_transmit_cmd(chip, &tbuf, 0, NULL);
> > 	if (rc < 0) {
> > -		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
> > -			 __func__, rc);
> > -		tpm_buf_destroy(&tbuf);
> > -		return -EFAULT;
> > +		rc = -EFAULT;
> > +		goto err;
> > 	} else if (tpm2_rc_value(rc) == TPM2_RC_REFERENCE_H0) {
> > -		tpm_buf_destroy(&tbuf);
> > -		return -ENOENT;
> > +		rc = -ENOENT;
> > +		goto out;
> > 	} else if (rc) {
> > -		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
> > -			 __func__, rc);
> > -		tpm_buf_destroy(&tbuf);
> > -		return -EFAULT;
> > +		rc = -EFAULT;
> > +		goto err;
> > 	}
> > 
> 
> Would it be worthwhile to still output something here since it is changing
> the value of rc returned from tpm_transmit_cmd()? Wondering if it would
> be useful for debugging to know what the returned error was. Other than
> that question looks good to me pending what is decided on using PAGE_SIZE.
> 
> Regards,
> Jerry

I'll submit a new version that will just allocate a static buffer of 16
kB. Dynamic scaling is saved for future.

/Jarkko
