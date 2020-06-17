Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF381FC2E6
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 02:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgFQAhj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 20:37:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:35560 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQAhi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 20:37:38 -0400
IronPort-SDR: 6btyEopYtcWhQIIfwVIMkuBwT0xT1Xt3erNtWipWo7a+2XBgHYk4xefjBwHFOLrP0gUmqkU/54
 5g0L3LU3TqSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 17:37:37 -0700
IronPort-SDR: lODsoQHi8rVMcS8JBOZM22ZQFpr+o4U38aSiRKsTumXaHJosXss88z+9i8pLOq+lgsd28ULTQN
 e1b3CvWqFPDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400"; 
   d="scan'208";a="351914039"
Received: from mjlewis-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.33.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2020 17:37:27 -0700
Date:   Wed, 17 Jun 2020 03:37:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v10 1/8] tpm: Make read{16, 32}() and write32() in
 tpm_tis_phy_ops optional
Message-ID: <20200617003726.GA3646@linux.intel.com>
References: <20200604134713.157951-1-amirmizi6@gmail.com>
 <20200604134713.157951-2-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604134713.157951-2-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 04, 2020 at 04:47:06PM +0300, amirmizi6@gmail.com wrote:
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

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I tested this with my T480 ThinkPad, which has Infineon SLB 9670 TPM
chip according to TPM_PT_VENDOR_STRING_* [*]

[*] tpm2_getcap properties-fixed from tpm2-tools package to fetch this
    information.

/Jarkko
