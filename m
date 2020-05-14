Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD831D2E39
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 13:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgENL0X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 07:26:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:35176 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENL0W (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 07:26:22 -0400
IronPort-SDR: ZmwZzeHN14KIJYkoNZ6u8t72slnvL8kj2RV8dl6rEKgDE5O02sYdfmek13PeZ5VQn11U9A3ICy
 kVqaUJMFeRcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 04:26:22 -0700
IronPort-SDR: +jfDun7cOEjJ/dNmFy7jyIpp1N07moS8qViN2jFj9nFLdqUijfTUpompb60TjJ87ofQ9AwFqrA
 k0dHHnJhWC6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="262807125"
Received: from apogrebi-mobl2.ger.corp.intel.com ([10.249.39.119])
  by orsmga003.jf.intel.com with ESMTP; 14 May 2020 04:26:14 -0700
Message-ID: <5e66f2d3e3f2c6af4bafd25f0d228774b8302e8d.camel@linux.intel.com>
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
Date:   Thu, 14 May 2020 14:26:14 +0300
In-Reply-To: <20200512141431.83833-2-amirmizi6@gmail.com>
References: <20200512141431.83833-1-amirmizi6@gmail.com>
         <20200512141431.83833-2-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-05-12 at 17:14 +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Only tpm_tis can use memory-mapped I/O, which is truly mapped into
> the kernel's memory space. Therefore, using ioread16/ioread32/iowrite32
> turns into a straightforward pointer dereference.
> Every other driver requires more complicated operations to read more than
> one byte at a time and will just fall back to read_bytes/write_bytes.
> Therefore, move this common code out of tpm_tis_spi and into tpm_tis_core
> so that it is used automatically when low-level drivers do not implement
> the specialized methods.
> 
> Co-developed-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

OK, so I applied this one:

http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/fa05dc792ea02043f3c21467cb4485a38ac19bdf

I.e. no need to carry this one any more in the series. Sorry that
I haven't done this before (should have).

/Jarkko

