Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3581017A47C
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2020 12:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCELna (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Mar 2020 06:43:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:22040 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgCELna (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 06:43:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 03:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="275058937"
Received: from unknown (HELO jsakkine-mobl1) ([10.237.50.161])
  by fmsmga002.fm.intel.com with ESMTP; 05 Mar 2020 03:43:28 -0800
Message-ID: <b761fab86e36ca2167b6d15474315ca2d75cc8d1.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: st33zp24: Convert to use GPIO descriptors
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        Jeremy Boone <jeremy.boone@nccgroup.trust>
Date:   Thu, 05 Mar 2020 13:43:29 +0200
In-Reply-To: <20200304221700.22958-1-linus.walleij@linaro.org>
References: <20200304221700.22958-1-linus.walleij@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.35.92-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-03-04 at 23:17 +0100, Linus Walleij wrote:
> The ST33ZP24 is using the old deprecated GPIO API.
> It also goes to some measures to convert from the
> new to the old API in the ACPI probe path of both
> the I2C and SPI interfaces for the module.
> 
> Change the driver and subdrivers to use struct
> gpio_desc * all the way and pass this around in
> platform data and in probe and all associated
> functions.
> 
> Cc: Jeremy Boone <jeremy.boone@nccgroup.trust>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, look great.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
[with the assumption that it passes sparse and checkpatch.pl]

Any chance to get like maybe even one tested-by for this? The change
is so straightforward and obvious that I'll pick it up anyway but
would feel better to have it tested by another peer.

/Jarkko

