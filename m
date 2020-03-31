Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8831995F0
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 14:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgCaMEe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 08:04:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:3992 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbgCaMEe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 08:04:34 -0400
IronPort-SDR: 8QlVzJmy3OinDRgfR/cmPLHanxkLLnY+OXwrDSxuMkJ1IpB2o6EB6pAMvkpF1jhoZUokh6zN8D
 zAbDlAxpGjLg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 05:04:33 -0700
IronPort-SDR: 8jl0lvYsbmsqMEXaBWfMO2XgkrGQ8/WLqMPFlBqryMdC5PajiPwPT+KZkGPKKKYrHOimzKU4qQ
 hWR3x6t5sxyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="328061507"
Received: from tking1-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.59.94])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2020 05:04:21 -0700
Date:   Tue, 31 Mar 2020 15:04:20 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v4 1/7] tpm: tpm_tis: Make implementation of read16
 read32 write32 optional
Message-ID: <20200331120405.GF8295@linux.intel.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-2-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331113207.107080-2-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 31, 2020 at 02:32:01PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Only tpm_tis can use memory mapped I/O, which is truly mapped into
> the kernel's memory space. So using ioread16/ioread32/iowrite32 turn into a
> straightforward pointer dereference.
> Every other driver require more complicated operations to read more than 1
> byte at a time and will just fall back to read_bytes/write_bytes.
> Therefore, move this common code out of tpm_tis_spi into tpm_tis_core, so
> that it is automatically used when low-level drivers do not implement the
> specialized methods.
> 
> Co-developed-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
