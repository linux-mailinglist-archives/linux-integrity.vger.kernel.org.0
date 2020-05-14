Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFA51D41B7
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 01:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgENXcc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 19:32:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:15797 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgENXcc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 19:32:32 -0400
IronPort-SDR: vsyOoDT3emlGh5iOTYA/v1OE3N6hG3JRXGdkBowU334UgS3HTvGenrWxjxedQk7ynQ4151cObB
 TAXcszonfLcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 16:32:31 -0700
IronPort-SDR: AGf3EJk7tM8SlSjLEDYCzZ23Rp2H3cq6MSyBBtVyJEpl4LUf6aIl2O9wJ2mcgH6a5YyUB3Yo0S
 wQTHkMcurE2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="341784788"
Received: from ashadrin-mobl1.ccr.corp.intel.com ([10.249.38.112])
  by orsmga001.jf.intel.com with ESMTP; 14 May 2020 16:32:23 -0700
Message-ID: <2a2e2c8c4a9364fa515fe772d2216d77c45ae854.camel@linux.intel.com>
Subject: Re: [PATCH v8 1/8] tpm: tpm_tis: Make implementation of read16,
 read32 and write32 optional
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com, Eyal.Cohen@nuvoton.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, benoit.houyere@st.com, mark.rutland@arm.com,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Date:   Fri, 15 May 2020 02:32:12 +0300
In-Reply-To: <5e66f2d3e3f2c6af4bafd25f0d228774b8302e8d.camel@linux.intel.com>
References: <20200512141431.83833-1-amirmizi6@gmail.com>
         <20200512141431.83833-2-amirmizi6@gmail.com>
         <5e66f2d3e3f2c6af4bafd25f0d228774b8302e8d.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-14 at 14:26 +0300, Jarkko Sakkinen wrote:
> On Tue, 2020-05-12 at 17:14 +0300, amirmizi6@gmail.com wrote:
> > From: Amir Mizinski <amirmizi6@gmail.com>
> > 
> > Only tpm_tis can use memory-mapped I/O, which is truly mapped into
> > the kernel's memory space. Therefore, using ioread16/ioread32/iowrite32
> > turns into a straightforward pointer dereference.
> > Every other driver requires more complicated operations to read more than
> > one byte at a time and will just fall back to read_bytes/write_bytes.
> > Therefore, move this common code out of tpm_tis_spi and into tpm_tis_core
> > so that it is used automatically when low-level drivers do not implement
> > the specialized methods.
> > 
> > Co-developed-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> > Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> > Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> OK, so I applied this one:
> 
> http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/fa05dc792ea02043f3c21467cb4485a38ac19bdf
> 
> I.e. no need to carry this one any more in the series. Sorry that
> I haven't done this before (should have).

Dropped it. Breaks the compilation:

ld: drivers/char/tpm/tpm_tis_spi_cr50.o:(.rodata+0x10): undefined reference to `tpm_tis_spi_read16'
ld: drivers/char/tpm/tpm_tis_spi_cr50.o:(.rodata+0x18): undefined reference to `tpm_tis_spi_read32'
ld: drivers/char/tpm/tpm_tis_spi_cr50.o:(.rodata+0x20): undefined reference to `tpm_tis_spi_write32'

Please fix this issue in the next version of the patch and remove my
reviewed-by. I will have to re-review the patch.

/Jarkko

