Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3521ACE42
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 19:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgDPRDU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 13:03:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:50347 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbgDPRDT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 13:03:19 -0400
IronPort-SDR: vUDlzR/cdcKGXgEEogqSvwCMyAWqhbIAd5l9kLxLuuB2w9RkZLuKbrLZFCUVQ6oWr7AsxnGRQC
 e7oYOhrA7ClQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 10:03:18 -0700
IronPort-SDR: CEEGn4yXi5wd4H98ULwOzR4mN4q54lq3VPqWe9q4hrEON+aIKuTlHVew6HH2jTMB0U/Ob0adM7
 EZzoMKc8vNwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="246045241"
Received: from otazetdi-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.42.128])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2020 10:03:15 -0700
Date:   Thu, 16 Apr 2020 20:03:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200416170315.GC199110@linux.intel.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410163826.GM11886@ziepe.ca>
 <20200414174433.r54hawtqxlgo3d7y@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414174433.r54hawtqxlgo3d7y@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 14, 2020 at 10:44:33AM -0700, Jerry Snitselaar wrote:
> On Fri Apr 10 20, Jason Gunthorpe wrote:
> > On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
> > > Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
> > > TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
> > > the TPM_CHIP_FLAG_IRQ ever.
> > 
> > This all used to work..
> 
> IIRC this goes all the way back to 570a36097f30 ("tpm: drop 'irq' from struct tpm_vendor_specific")
> when the flag was added. There was never anything initially setting it in the tpm_tis code.
> There were checks added, but the only place it got set was where it did the interrupt test in
> tpm_tis_send, and it can only get down to that code if the flag is set. Stefan's patch was enabling
> the flag, but with the flag enabled some systems were seeing interrupt storms. I believe it has
> been seen with both the t490 and an internal system that Dan Williams was working on at Intel.
> Without access to hw seeing the problem the decision was to revert Stefan's patches while
> we try to figure out the issues.

Thanks Jerry.

Yup, kinda hard to debug irq issues without local access
to the whole platform. They can be nasty issues to debug
in the 1st place.

/Jarkko
