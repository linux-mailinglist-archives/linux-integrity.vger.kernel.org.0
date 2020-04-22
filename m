Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598001B483B
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2020 17:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDVPHp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Apr 2020 11:07:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:18564 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDVPHp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Apr 2020 11:07:45 -0400
IronPort-SDR: w1xeYJ5X17w5OTrj6V5vcF3MLy9NMzXXd9CQgIMmZtcP6ymIzEdRoRu776LIXb8Vr0KaLIPfVB
 /DbCoCVLpqDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 08:07:45 -0700
IronPort-SDR: hxer6s5qRRnr/lfuuvFEsiyVKmVrOMPPo8v4jO03VWWF80/J8YJ32hWeCYMBgB+8mpAf/MJYHF
 x9WxZ8U4tMpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="259098214"
Received: from ryanchev-mobl.ger.corp.intel.com (HELO localhost) ([10.252.45.252])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2020 08:07:43 -0700
Date:   Wed, 22 Apr 2020 18:07:42 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1] tpm/tpm_ftpm_tee: Use UUID API for exporting the UUID
Message-ID: <20200422150742.GA89432@linux.intel.com>
References: <20200422130135.38555-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422130135.38555-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 22, 2020 at 04:01:35PM +0300, Andy Shevchenko wrote:
> There is export_uuid() function which exports uuid_t to the u8 array.
> Use it instead of open coding variant.
> 
> This allows to hide the uuid_t internals.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I guess no need for backports?

/Jarkko
