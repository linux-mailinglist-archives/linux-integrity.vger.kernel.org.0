Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF4462A5
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFNPYo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 11:24:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:44482 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfFNPYo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 11:24:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 08:24:44 -0700
X-ExtLoop1: 1
Received: from mdumitrx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.32.245])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2019 08:24:38 -0700
Date:   Fri, 14 Jun 2019 18:24:36 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 2/8] tpm_tis_core: add optional max xfer size check
Message-ID: <20190614152436.GC11241@linux.intel.com>
References: <20190613180931.65445-1-swboyd@chromium.org>
 <20190613180931.65445-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613180931.65445-3-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 13, 2019 at 11:09:25AM -0700, Stephen Boyd wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> If tpm reports a bigger burstcnt than allowed by the physical protocol,
> set burstcnt to the max allowed value.
> 
> In practice, seen in case of xfer issues (e.g. in spi interface case,
> lost header causing flow control issues and wrong values returned on read
> from TPM_STS). Without catching, causes the physical layer to reject xfer.
> 
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> [swboyd@chromium.org: Drop extra parenthesis in if statement]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
