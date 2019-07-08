Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A29462139
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbfGHPLp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 11:11:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:47636 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732146AbfGHPLp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 11:11:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 08:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="159148473"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by orsmga008.jf.intel.com with ESMTP; 08 Jul 2019 08:11:38 -0700
Message-ID: <586c629b6d3c718f0c1585d77fe175fe007b27b1.camel@linux.intel.com>
Subject: Re: [PATCH v2] tpm: tpm_ibm_vtpm: Fix unallocated banks
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mimi Zohar <zohar@linux.ibm.com>
Date:   Mon, 08 Jul 2019 18:11:40 +0300
In-Reply-To: <1562458725-15999-1-git-send-email-nayna@linux.ibm.com>
References: <1562458725-15999-1-git-send-email-nayna@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-07-06 at 20:18 -0400, Nayna Jain wrote:
> +/*
> + * tpm_get_pcr_allocation() - initialize the chip allocated banks for PCRs
> + * @chip: TPM chip to use.
> + */
> +static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> +{
> +	int rc;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		rc = tpm2_get_pcr_allocation(chip);
> +	else
> +		rc = tpm1_get_pcr_allocation(chip);
> +
> +	return rc;
> +}

It is just a trivial static function, which means that kdoc comment is
not required and neither it is useful. Please remove that. I would
rewrite the function like:

static int tpm_get_pcr_allocation(struct tpm_chip *chip)
{
	int rc;

	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
     	     tpm2_get_pcr_allocation(chip) :
     	     tpm1_get_pcr_allocation(chip);

	return rc > 0 ? -ENODEV : rc;
}

This addresses the issue that Stefan also pointed out. You have to
deal with the TPM error codes.

/Jarkko

