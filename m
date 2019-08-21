Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA2898272
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Aug 2019 20:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfHUSNL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Aug 2019 14:13:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:59967 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbfHUSNL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Aug 2019 14:13:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 11:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="203109821"
Received: from kumarsh1-mobl.ger.corp.intel.com (HELO localhost) ([10.249.33.104])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2019 11:13:06 -0700
Date:   Wed, 21 Aug 2019 21:13:05 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v4 2/6] tpm: tpm_tis_spi: Introduce a flow control
 callback
Message-ID: <20190821181305.e6dgrez5n4ovtg5s@linux.intel.com>
References: <20190812223622.73297-1-swboyd@chromium.org>
 <20190812223622.73297-3-swboyd@chromium.org>
 <20190819163240.vsgylmctemzgqd34@linux.intel.com>
 <5d5ad721.1c69fb81.6a514.e649@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5ad721.1c69fb81.6a514.e649@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 19, 2019 at 10:06:40AM -0700, Stephen Boyd wrote:
> > AFAIK the flow control is not part of the SPI standard itself but is
> > proprietary for each slave device. Thus, the flow control should be
> > documented to the source code. I do not want flow control mechanisms to
> > be multiplied before this is done.
> 
> Can you clarify this please? I don't understand what "the flow control
> should be documented to the source code" means.

Off the top of my head:

/* TCG SPI flow control is documented in the section 6.4 of [1]. However,
 * Google's CR50 chip has its own proprietary flow control. This struct
 * is used to bind the appropriate flow control mechanism.
 *
 * [1] https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
 */

> > 
> > The magic number 0x01 would be also good to get rid off.
> > 
> 
> Ok. What name should the #define be? I can make that another patch.

Do nothing. Not part of your patch set scope, was a stupid comment from
my side.

/Jarkko
