Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345B4604A8
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 12:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfGEKmY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 06:42:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:63154 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbfGEKmY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 06:42:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 03:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="158476114"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by orsmga008.jf.intel.com with ESMTP; 05 Jul 2019 03:42:19 -0700
Message-ID: <f315356e7c00378c8785bd20d5869c9046ece2f2.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: fixes uninitialized allocated banks for IBM vtpm
 driver
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Date:   Fri, 05 Jul 2019 13:42:18 +0300
In-Reply-To: <1562211121-2188-1-git-send-email-nayna@linux.ibm.com>
References: <1562211121-2188-1-git-send-email-nayna@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-07-03 at 23:32 -0400, Nayna Jain wrote:
> The nr_allocated_banks and allocated banks are initialized as part of
> tpm_chip_register. Currently, this is done as part of auto startup
> function. However, some drivers, like the ibm vtpm driver, do not run
> auto startup during initialization. This results in uninitialized memory
> issue and causes a kernel panic during boot.
> 
> This patch moves the pcr allocation outside the auto startup function
> into tpm_chip_register. This ensures that allocated banks are initialized
> in any case.
> 
> Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with
> PCR read")
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Please add

Reported-by: Michal Suchanek <msuchanek@suse.de>

It is missing. Michal is there a chance you could try this out once
Nayna send a new version?

> ---
>  drivers/char/tpm/tpm-chip.c | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm.h      |  1 +
>  drivers/char/tpm/tpm1-cmd.c | 12 ------------
>  drivers/char/tpm/tpm2-cmd.c |  6 +-----
>  4 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 8804c9e916fd..958508bb8379 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -550,6 +550,39 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
>  	return hwrng_register(&chip->hwrng);
>  }
>  
> +/*
> + * tpm_pcr_allocation() - initializes the chip allocated banks for PCRs
> + */
> +static int tpm_pcr_allocation(struct tpm_chip *chip)

Why that name and not tpm_get_pcr_allocation()? Do not get why
"get_" has been dropped. Please add it back.

Would be senseful to create tpm1_get_pcr_allocation() to tpm1-cmd.c
now that a new function needs to be introduced anyway. Please do
it for that for TPM 1.x part.

/Jarkko

