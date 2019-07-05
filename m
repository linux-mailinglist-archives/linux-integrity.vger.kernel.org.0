Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A11B60B2D
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfGERuf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 13:50:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:8637 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfGERuf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 13:50:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 10:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="175559214"
Received: from hsolima-mobl1.ger.corp.intel.com ([10.252.48.252])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2019 10:50:28 -0700
Message-ID: <1270cd6ab2ceae1ad01e4b83b75fc4c6fc70027d.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: fixes uninitialized allocated banks for IBM vtpm
 driver
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        George Wilson <gcwilson@linux.ibm.com>
Date:   Fri, 05 Jul 2019 20:50:27 +0300
In-Reply-To: <164b9c6e-9b6d-324d-9df8-d2f7d1ac8cfc@linux.vnet.ibm.com>
References: <1562211121-2188-1-git-send-email-nayna@linux.ibm.com>
         <1998ebcf-1521-778f-2c80-55ad2c855023@linux.ibm.com>
         <164b9c6e-9b6d-324d-9df8-d2f7d1ac8cfc@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-07-05 at 11:32 -0400, Nayna wrote:
> I am not sure of the purpose of tpm_stop_chip(), so I have left it as it 
> is. Jarkko, what do you think about the change ?

Stefan right. Your does not work, or will randomly work or not work
depending on the chip.

You need to turn the TPM on with tpm_chip_start() and turn it off with
tpm_chip_stop() once you are done. This is done in tpm_chip_register()
before calling tpm_auto_startup().

TPM power management was once in tpm_transmit() but not anymore after my
patch set that removed nested tpm_transmit() calls.

While you're on it please take into account my earlier feedback.

Also, short summary could be "tpm: tpm_ibm_vtpm: Fix unallocated banks"

Some oddballs in your patch that I have to ask.

if (chip->flags & TPM_CHIP_FLAG_TPM2) {
	rc = tpm2_get_pcr_allocation(chip);
	if (rc)
		goto out;
}

chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
		GFP_KERNEL);
if (!chip->allocated_banks) {
	rc = -ENOMEM;
	goto out;
}

Why you don't return on site and instead jump somewhere? Also the
2nd line for kcalloc() is misaligned.

out:
	if (rc < 0)
		rc = -ENODEV;

This will cause a new regression i.e. you let TPM error codes
through.

To summarize this patch fixes one regression and introduces two
completely new ones...

/Jarkko`

