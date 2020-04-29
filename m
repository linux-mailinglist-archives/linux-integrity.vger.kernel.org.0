Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9941BD40E
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2020 07:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD2FhO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Apr 2020 01:37:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:36541 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgD2FhO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Apr 2020 01:37:14 -0400
IronPort-SDR: O81g6KqpK4OdUDJLzAR+FS54OyY0Di+P6EDg5qZsqDBtbbzMHkgXk7Pie0WkgaV3UIVfT9AmwY
 Hj4/WqL4aUFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 22:37:13 -0700
IronPort-SDR: cNeJ/V/2f0ImcfTb/2WmKmeZ7ww37gMV6bZ5hyTMGlztWbDDgtcUkCbmuGAeOEnXWf7lQANrQV
 9a3PUne0OTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
   d="scan'208";a="249366729"
Received: from ramibuso-mobl.ger.corp.intel.com (HELO localhost) ([10.249.47.170])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2020 22:37:05 -0700
Date:   Wed, 29 Apr 2020 08:37:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        oshri.alkoby@nuvoton.com, tmaimon77@gmail.com, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com
Subject: Re: [PATCH v7 3/7] tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()"
Message-ID: <20200429053703.GF8452@linux.intel.com>
References: <20200427124931.115697-1-amirmizi6@gmail.com>
 <20200427124931.115697-4-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427124931.115697-4-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 27, 2020 at 03:49:27PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Using this function while reading/writing data resulted in an aborted
> operation.
> After investigating the issue according to the TCG TPM Profile (PTP)
> Specifications, I found that "request to cancel" should occur only if
> TPM_STS.commandReady bit is lit.
> Note that i couldn't find a case where the present condition
> (in the linux kernel) is valid, so I'm removing the case for
> "TPM_VID_WINBOND" since we have no need for it.
> 
> Also, the default comparison is wrong. Only cmdReady bit needs to be
> compared instead of the full lower status register byte.
> 
> Fixes: 1f86605 (tpm: Fix cancellation of TPM commands (polling mode))

Needs to have exactly 12 hex digits of the hash.

/Jarkko
