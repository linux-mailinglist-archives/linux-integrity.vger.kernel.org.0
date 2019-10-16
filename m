Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A95D9584
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394126AbfJPP1j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Oct 2019 11:27:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:64212 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394125AbfJPP1j (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Oct 2019 11:27:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 08:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="370830735"
Received: from hagarwal-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.5.165])
  by orsmga005.jf.intel.com with ESMTP; 16 Oct 2019 08:27:33 -0700
Date:   Wed, 16 Oct 2019 18:27:31 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v7 0/6] tpm: Add driver for cr50
Message-ID: <20191016152731.GD4261@linux.intel.com>
References: <20190920183240.181420-1-swboyd@chromium.org>
 <4042311.vcUrecXYXX@diego>
 <20191014195607.GK15552@linux.intel.com>
 <11998737.dOvWaeisEJ@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11998737.dOvWaeisEJ@phil>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 15, 2019 at 10:23:15PM +0200, Heiko Stuebner wrote:
> Hi,
> 
> Am Montag, 14. Oktober 2019, 21:56:30 CEST schrieb Jarkko Sakkinen:
> > On Fri, Oct 11, 2019 at 09:50:27AM +0200, Heiko Stübner wrote:
> > > Am Montag, 7. Oktober 2019, 00:39:00 CEST schrieb Jarkko Sakkinen:
> > > > On Fri, Sep 20, 2019 at 11:32:34AM -0700, Stephen Boyd wrote:
> > > > > This patch series adds support for the H1 secure microcontroller
> > > > > running cr50 firmware found on various recent Chromebooks. This driver
> > > > > is necessary to boot into a ChromeOS userspace environment. It
> > > > > implements support for several functions, including TPM-like
> > > > > functionality over a SPI interface.
> > > > > 
> > > > > The last time this was series sent looks to be [1]. I've looked over the
> > > > > patches and review comments and tried to address any feedback that
> > > > > Andrey didn't address (really minor things like newlines). I've reworked
> > > > > the patches from the last version to layer on top of the existing TPM
> > > > > TIS SPI implementation in tpm_tis_spi.c. Hopefully this is more
> > > > > palatable than combining the two drivers together into one file.
> > > > > 
> > > > > Please review so we can get the approach to supporting this device
> > > > > sorted out.
> > > > > 
> > > > > [1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org
> > > 
> > > [...]
> > > 
> > > > OK, so, I put these to my master in hopes to get testing exposure.
> > > > I think the changes are in great shape now. Thank you.
> > > 
> > > on a rk3399-gru-bob it works nicely for me, so
> > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > 
> > Thank you! I updated my tree with your tag. Mind if I also add
> > reviewed-by's?
> 
> I think I did spent enough time with the patches to warrant that, so
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thank you!

/Jarkko
