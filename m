Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F261C20987B
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 04:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389070AbgFYC2W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 22:28:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:55725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388930AbgFYC2W (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 22:28:22 -0400
IronPort-SDR: ZznXFlWtZlf1jRuXcFmY/WG/e3+TD/AiA5bGTDAEnC/jGCEJ8xFcvRSiiYotO1tmrtk2yuNoUW
 oRSpjVL6MtBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="144766957"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="144766957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 19:28:21 -0700
IronPort-SDR: s7+lF6UwMW6AkLc9abIIz2Um941pICZSUCQkVO0tPdEkgAi8Y9fuypkT+RLgPol5+x4rr8m9Nh
 cDuRx2HecQJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="423577244"
Received: from hluxenbu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.218])
  by orsmga004.jf.intel.com with ESMTP; 24 Jun 2020 19:28:14 -0700
Date:   Thu, 25 Jun 2020 05:28:12 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm_tis: Remove the HID IFX0102
Message-ID: <20200625022812.GA270125@linux.intel.com>
References: <20200624230037.21192-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624230037.21192-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 02:00:33AM +0300, Jarkko Sakkinen wrote:
> Acer C720 running Linux v5.3 reports this in klog:
> 
> tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
> tpm tpm0: tpm_try_transmit: send(): error -5
> tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
> tpm_tis tpm_tis: Could not get TPM timeouts and durations
> tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
> tpm tpm0: tpm_try_transmit: send(): error -5
> tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
> tpm_tis 00:08: Could not get TPM timeouts and durations
> ima: No TPM chip found, activating TPM-bypass!
> tpm_inf_pnp 00:08: Found TPM with ID IFX0102
> 
> % git --no-pager grep IFX0102 drivers/char/tpm
> drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
> drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
> 
> Obviously IFX0102 was added to the HID table for the TCG TIS driver by
> mistake.
> 
> Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
> Cc: Kylene Jo Hall <kjhall@us.ibm.com>
> Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Sending v2 some unrelated stuff by mistake.

/Jarkko
