Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC93212DFF
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jul 2020 22:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgGBUoR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jul 2020 16:44:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:41083 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGBUoR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jul 2020 16:44:17 -0400
IronPort-SDR: akNsFXPEHAEni4tceiX6tnOP08wJrORER/DDrezP+lzdT/dijNLd6JvjcLcxAifNmcIhEcVQHe
 rzijlNcaZ1nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="231888268"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="231888268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 13:44:16 -0700
IronPort-SDR: Jv5lhpoXtZAaNPvlPtQaF51tu7Xxn0jnqTFQOYWUg1V7tKXfsBh9FpES+u0UHaCnlddZyYTGf1
 sVjC2aJys0mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="278228138"
Received: from frichard-mobl.ger.corp.intel.com (HELO localhost) ([10.249.44.59])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2020 13:44:12 -0700
Date:   Thu, 2 Jul 2020 23:44:11 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v8 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
Message-ID: <20200702204411.GB31291@linux.intel.com>
References: <20200626153948.2059251-1-stefanb@linux.vnet.ibm.com>
 <20200626153948.2059251-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626153948.2059251-3-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 26, 2020 at 11:39:48AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> to get the event log from ACPI. If one is found, use it to get the
> start and length of the log area. This allows non-UEFI systems, such
> as SeaBIOS, to pass an event log when using a TPM2.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/eventlog/acpi.c | 63 +++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 63ada5e53f13..51312c460335 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -49,9 +49,9 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	void __iomem *virt;
>  	u64 len, start;
>  	struct tpm_bios_log *log;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		return -ENODEV;
> +	struct acpi_table_tpm2 *tbl;
> +	struct acpi_tpm2_phy *t2phy;

This is a rather cryptic variable name. Should be either 'phy' or
'tpm2_phy' (I don't care that much which one). Did not spot this
earlier.

/Jarkko
