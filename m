Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9108FD6A6C
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 21:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfJNT4j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 15:56:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:4020 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730134AbfJNT4j (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 15:56:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 12:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="195080865"
Received: from kridax-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.7.178])
  by fmsmga007.fm.intel.com with ESMTP; 14 Oct 2019 12:56:33 -0700
Date:   Mon, 14 Oct 2019 22:56:30 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
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
Message-ID: <20191014195607.GK15552@linux.intel.com>
References: <20190920183240.181420-1-swboyd@chromium.org>
 <20191006223831.GA10397@linux.intel.com>
 <4042311.vcUrecXYXX@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4042311.vcUrecXYXX@diego>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 11, 2019 at 09:50:27AM +0200, Heiko Stübner wrote:
> Am Montag, 7. Oktober 2019, 00:39:00 CEST schrieb Jarkko Sakkinen:
> > On Fri, Sep 20, 2019 at 11:32:34AM -0700, Stephen Boyd wrote:
> > > This patch series adds support for the H1 secure microcontroller
> > > running cr50 firmware found on various recent Chromebooks. This driver
> > > is necessary to boot into a ChromeOS userspace environment. It
> > > implements support for several functions, including TPM-like
> > > functionality over a SPI interface.
> > > 
> > > The last time this was series sent looks to be [1]. I've looked over the
> > > patches and review comments and tried to address any feedback that
> > > Andrey didn't address (really minor things like newlines). I've reworked
> > > the patches from the last version to layer on top of the existing TPM
> > > TIS SPI implementation in tpm_tis_spi.c. Hopefully this is more
> > > palatable than combining the two drivers together into one file.
> > > 
> > > Please review so we can get the approach to supporting this device
> > > sorted out.
> > > 
> > > [1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org
> 
> [...]
> 
> > OK, so, I put these to my master in hopes to get testing exposure.
> > I think the changes are in great shape now. Thank you.
> 
> on a rk3399-gru-bob it works nicely for me, so
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Thank you! I updated my tree with your tag. Mind if I also add
reviewed-by's?

/Jarkko
