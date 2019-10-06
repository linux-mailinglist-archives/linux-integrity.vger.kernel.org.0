Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F20CD980
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2019 00:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfJFWjI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Oct 2019 18:39:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:7113 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfJFWjH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Oct 2019 18:39:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 15:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,265,1566889200"; 
   d="scan'208";a="392855637"
Received: from dnlarsen-mobl4.amr.corp.intel.com (HELO localhost) ([10.252.3.159])
  by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2019 15:39:02 -0700
Date:   Mon, 7 Oct 2019 01:39:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v7 0/6] tpm: Add driver for cr50
Message-ID: <20191006223831.GA10397@linux.intel.com>
References: <20190920183240.181420-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920183240.181420-1-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 20, 2019 at 11:32:34AM -0700, Stephen Boyd wrote:
> This patch series adds support for the H1 secure microcontroller
> running cr50 firmware found on various recent Chromebooks. This driver
> is necessary to boot into a ChromeOS userspace environment. It
> implements support for several functions, including TPM-like
> functionality over a SPI interface.
> 
> The last time this was series sent looks to be [1]. I've looked over the
> patches and review comments and tried to address any feedback that
> Andrey didn't address (really minor things like newlines). I've reworked
> the patches from the last version to layer on top of the existing TPM
> TIS SPI implementation in tpm_tis_spi.c. Hopefully this is more
> palatable than combining the two drivers together into one file.
> 
> Please review so we can get the approach to supporting this device
> sorted out.
> 
> [1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org
> 
> TODO:
>  * Add a patch to spit out WARN_ON() when TPM is suspended and some
>    kernel code attempts to use it
>  * Rework the i2c driver per Alexander's comments on v2
> 
> Changes from v6 (https://lkml.kernel.org/r/20190829224110.91103-1-swboyd@chromium.org):
>  * Two new patches to cleanup includes and module usage
>  * Moved cr50 C file to tpm_tis_spi_cr50.c
>  * Used the tpm_tis_spi_mod target approach to make the module work
>  * Brought back Kconfig option to allow user to disable cr50 code
>  * Rebased to v5.3
> 
> Changes from v5 (https://lkml.kernel.org/r/20190828082150.42194-1-swboyd@chromium.org):
>  * Picked up Jarkko's ack/review tags
>  * Fixed bug with irqs happening before completion is initialized
>  * Dropped is_cr50 bool
>  * Moved wake_after to tpm_tis_spi struct
>  * Changed authorship of main cr50 patch to Andrey as I'm just shuffling
>    code here
> 
> Changes from v4 (https://lkml.kernel.org/r/20190812223622.73297-1-swboyd@chromium.org):
>  * Dropped the 'pre-transfer' hook patch and added a 'ready' member instead
>  * Combined cr50_spi and tpm_tis_spi into one kernel module
>  * Introduced a swizzle in tpm_tis_spi probe routine to jump to cr50
>    probe path
>  * Moved binding to start of the thread
>  * Picked up Jarkko reviewed-by tag on new flag for suspend/resume
>  * Added a comment to flow control patch indicating what it's all about
> 
> Changes from v3:
>  * Split out hooks into separate patches
>  * Update commit text to not say "libify"
>  * Collapse if statement into one for first patch
>  * Update commit text on first patch to mention flag
>  * Drop TIS_IS_CR50 as it's unused
> 
> Changes from v2:
>  * Sent khwrng thread patch separately
>  * New patch to expose TPM SPI functionality from tpm_tis_spi.c
>  * Usage of that new patch in cr50 SPI driver
>  * Drop i2c version of cr50 SPI driver for now (will resend later)
>  * New patch to add a TPM chip flag indicating TPM shouldn't be reset
>    over suspend. Allows us to get rid of the cr50 suspend/resume functions
>    that are mostly generic
> 
> Changes from v1:
>  * Dropped symlink and sysfs patches
>  * Removed 'is_suspended' bits
>  * Added new patch to freeze khwrng thread
>  * Moved binding to google,cr50.txt and added Reviewed-by tag from Rob
> 
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Duncan Laurie <dlaurie@chromium.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> Cc: Heiko Stuebner <heiko@sntech.de>

OK, so, I put these to my master in hopes to get testing exposure.
I think the changes are in great shape now. Thank you.

/Jarkko
