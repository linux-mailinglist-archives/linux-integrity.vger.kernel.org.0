Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF060529
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfGELPq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 07:15:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:29098 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfGELPq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 07:15:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 04:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="167032354"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by orsmga003.jf.intel.com with ESMTP; 05 Jul 2019 04:15:39 -0700
Message-ID: <2e2e646c3fae87307a149ee06e9fd4a7e493830d.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Oshri Alkoby <oshrialkoby85@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, oshri.alkoby@nuvoton.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        dan.morav@nuvoton.com, tomer.maimon@nuvoton.com
Date:   Fri, 05 Jul 2019 14:15:37 +0300
In-Reply-To: <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
         <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
         <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-07-04 at 13:29 +0200, Alexander Steffen wrote:
> On 04.07.2019 10:43, Jarkko Sakkinen wrote:
> > Check out tpm_tis_core.c and tpm_tis_spi.c. TPM TIS driver implements
> > that spec so you should only implement a new physical layer.
> 
> I had the same thought. Unfortunately, the I2C-TIS specification 
> introduces two relevant changes compared to tpm_tis/tpm_tis_spi:

I doubt that there was any comparison made.

> 1. Locality is not encoded into register addresses anymore, but stored 
> in a separate register.
> 2. Several register addresses have changed (but still contain compatible 
> contents).
> 
> I'd still prefer not to duplicate all the high-level logic from 
> tpm_tis_core. But this will probably mean to introduce some new 
> interfaces between tpm_tis_core and the physical layers.

Agreed. Some plumbing needs to be done in tpm_tis_core to make it work
for this. We definitely do not want to duplicate code that has been
field tested for years.

> Also, shouldn't the new driver be called tpm_tis_i2c, to group it with 
> all the other (TIS) drivers, that implement a vendor-independent 
> protocol? With tpm_i2c_ptp users might assume that ptp is just another 
> vendor.

Yes, absolutely. I guess the driver has been done without looking at
what already exist in the TPM kernel stack.

/Jarkko

