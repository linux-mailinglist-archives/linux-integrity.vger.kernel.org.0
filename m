Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D431A4B7C
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2020 23:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDJVHC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Apr 2020 17:07:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:39396 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgDJVHC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Apr 2020 17:07:02 -0400
IronPort-SDR: /OkiI031xD30IJdUBrv6mXHrKoRMzexrdnbzoxz2bhWwGKtMxyFFQHGUy7HpqxLHSp58r7O+NO
 Oq6srYptSIvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 14:07:02 -0700
IronPort-SDR: 9OoFls8ne/B5++UDV+hFMXThVO91c6Mzbc4InHuw2MfyKlL3McSBelHT2mtgQYJrTIJfktdDZJ
 CcdM7eNLqZrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="scan'208";a="243017942"
Received: from sartorig-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.43.100])
  by fmsmga007.fm.intel.com with ESMTP; 10 Apr 2020 14:06:59 -0700
Date:   Sat, 11 Apr 2020 00:06:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200410210652.GA16905@linux.intel.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409211044.21625-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
> Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
> TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
> the TPM_CHIP_FLAG_IRQ ever.
> 
> So the whole IRQ probing code is not useful, worse we rely on the
> IRQ-test path of tpm_tis_send() to call disable_interrupts() if
> interrupts do not work, but that path never gets entered because we
> never set the TPM_CHIP_FLAG_IRQ.
> 
> So the remaining IRQ probe code calls request_irq() and never calls
> free_irq() even when the interrupt is not working.
> 
> On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
> to use and never free creates an interrupt storm followed by
> an "irq XX: nobody cared" oops.
> 
> Since it is non-functional at the moment anyways, lets just completely
> disable the IRQ code in tpm_tis_core for now.
> 
> Fixes: dda8b2af395b ("tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts"")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note I'm working with Lenovo to try and get to the bottom of this.
> ---

OK if I recall correctly the reason for reverting was that the fixes
Stefan was sending were broken and no access to hardware were the
issues would be visible. The reason for not doing anything til this
day is that we don't have T490 available.

The lack of devm_free_irq() is an by itself, so please instead send
a fix that adds that to the code instead of "#if 0" crap.

Thank you.

/Jarkko
