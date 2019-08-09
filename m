Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DADE788369
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Aug 2019 21:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHITnw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Aug 2019 15:43:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:12176 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfHITnw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Aug 2019 15:43:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 12:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,366,1559545200"; 
   d="scan'208";a="169405835"
Received: from wulili-mobl1.ger.corp.intel.com ([10.249.36.9])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2019 12:43:45 -0700
Message-ID: <93400d11833bd42c4be0b846416ff1f469904784.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/4] tpm: Add a flag to indicate TPM power is
 managed by firmware
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>, Peter Huewe <peterhuewe@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <20190806220750.86597-2-swboyd@chromium.org>
References: <20190806220750.86597-1-swboyd@chromium.org>
         <20190806220750.86597-2-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Fri, 09 Aug 2019 21:02:01 +0300
User-Agent: Evolution 3.32.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-08-06 at 15:07 -0700, Stephen Boyd wrote:
> On some platforms, the TPM power is managed by firmware and therefore we
> don't need to stop the TPM on suspend when going to a light version of
> suspend such as S0ix ("freeze" suspend state). Add a chip flag to
> indicate this so that certain platforms can probe for the usage of this
> light suspend and avoid touching the TPM state across suspend/resume.

The commit message should mention the new constant.

> +	if (chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED)
> +		if (!pm_suspend_via_firmware())

Why both checks are needed?

If both checks are needed, you could write it as a single
conditional statement:

if (chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED &&
    !pm_suspend_via_firmware())

/Jarkko

