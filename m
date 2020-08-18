Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D01247DE8
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 07:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHRFdy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 01:33:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:46036 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgHRFdy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 01:33:54 -0400
IronPort-SDR: hI1YyZYjp3i79eIOL9Uq04M3K9PU8WWpqB19f/BKXbJHD2GsnHhtzw1sVZ9I/B7wym2AWWjIy2
 haix+f9Rlv/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="155927573"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="155927573"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 22:33:53 -0700
IronPort-SDR: Gc5840vEE4FMpm/UFXJFoa4mP4vObW0VhhCGp2hoppQWzWTT8y8C3XE+x7/gUDl1ceixRFH8UF
 e+lMadhAskMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="441108338"
Received: from lcrossx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.46.217])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2020 22:33:52 -0700
Date:   Tue, 18 Aug 2020 08:33:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1] tpm: use %*ph to print small buffer
Message-ID: <20200818053351.GA119714@linux.intel.com>
References: <20200730161613.41607-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730161613.41607-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 30, 2020 at 07:16:13PM +0300, Andy Shevchenko wrote:
> Use %*ph format to print small buffer as hex string.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Oh, this is handy, thanks.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
