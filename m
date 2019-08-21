Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D39840F
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Aug 2019 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfHUTLg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Aug 2019 15:11:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:65053 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbfHUTLg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Aug 2019 15:11:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 12:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="379060817"
Received: from kumarsh1-mobl.ger.corp.intel.com (HELO localhost) ([10.249.33.104])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2019 12:11:32 -0700
Date:   Wed, 21 Aug 2019 22:11:31 +0300
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
Subject: Re: [PATCH v4 3/6] tpm: tpm_tis_spi: Add a pre-transfer callback
Message-ID: <20190821191131.y7cmdtkxfs3ojmv6@linux.intel.com>
References: <20190812223622.73297-1-swboyd@chromium.org>
 <20190812223622.73297-4-swboyd@chromium.org>
 <20190819163505.wnyhgrtg4akiifdn@linux.intel.com>
 <5d5ad75e.1c69fb81.43fc3.5a77@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5ad75e.1c69fb81.43fc3.5a77@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 19, 2019 at 10:07:41AM -0700, Stephen Boyd wrote:
> Any name is fine for me. Any suggestions?

What if just add @ready to struct tpm_tis_spi_phy add drop this patch
altogether?

It is only used only by CR50 but I think it is less of an overkill than
adding a callback.

/Jarkko
