Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED281E57F5
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 08:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE1Gzi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 May 2020 02:55:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:23389 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgE1Gzi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 May 2020 02:55:38 -0400
IronPort-SDR: YJCV4C/c7o61HAwkwuKP2Y2ePdQTPC4RCJ/uXqk7fQ3FF1hmlVL81aNrncwpnp0xSgMAPXzYwf
 79dZHe/S8Ufw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 23:55:35 -0700
IronPort-SDR: 3IEqIiEUBBetwpf/IvyCFg/yD1qwQb21ZmP+w11fkr+Uf/TJ5arGx3UyKKNQBMnnVHgfgQrxGv
 Mi92cHz9rh0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="267117506"
Received: from dmescala-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.59.102])
  by orsmga003.jf.intel.com with ESMTP; 27 May 2020 23:55:29 -0700
Date:   Thu, 28 May 2020 09:55:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tstruk@gmail.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Alex Guzman <alex@guzman.io>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
Message-ID: <20200528065527.GE188849@linux.intel.com>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
 <1590520454.11810.40.camel@HansenPartnership.com>
 <f63afdc1-6c40-dc0d-bb9a-154bc51d3b95@gmail.com>
 <20200528003040.GA4781@linux.intel.com>
 <e939739d-d193-95e8-c142-4efa57be2502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e939739d-d193-95e8-c142-4efa57be2502@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 27, 2020 at 09:40:25PM -0700, Tadeusz Struk wrote:
> On 5/27/20 5:30 PM, Jarkko Sakkinen wrote:
> >> This won't help if the message is read by an async tcti. If the problem lies
> >> in the chip get locality code, perhaps this could help to debug the root-cause
> >> instead of masking it out in the upper layer code:
> > What is TCTI and async TCTI? Not following.
> 
> TPM Command Transmission Interface (TCTI) as defined by TCG in
> https://trustedcomputinggroup.org/resource/tss-tcti-specification/
> 
> the reason we added the O_NONBLOCK mode was to satisfy the TCG spec for async TCTI.
> 
> Thanks,
> Tadeusz

OK, thanks recalling.

/Jarkko
