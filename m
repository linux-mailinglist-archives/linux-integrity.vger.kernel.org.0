Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04700184A6D
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2020 16:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgCMPSI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Mar 2020 11:18:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:18550 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgCMPSI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Mar 2020 11:18:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 08:18:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="237250642"
Received: from mlitka-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.155.148])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2020 08:18:02 -0700
Date:   Fri, 13 Mar 2020 17:18:00 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v7 1/3] tpm: of: Handle IBM,vtpm20 case when getting log
 parameters
Message-ID: <20200313151800.GA142269@linux.intel.com>
References: <20200312155332.671464-1-stefanb@linux.vnet.ibm.com>
 <20200312155332.671464-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312155332.671464-2-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 12, 2020 at 11:53:30AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> A vTPM 2.0 is identified by 'IBM,vtpm20' in the 'compatible' node in
> the device tree. Handle it in the same way as 'IBM,vtpm'.
> 
> The vTPM 2.0's log is written in little endian format so that for this
> aspect we can rely on existing code.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Nayna Jain <nayna@linux.ibm.com>
> Tested-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  drivers/char/tpm/eventlog/of.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index af347c190819..a9ce66d09a75 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -51,7 +51,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	 * endian format. For this reason, vtpm doesn't need conversion
>  	 * but physical tpm needs the conversion.
>  	 */
> -	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
> +	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
> +	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
>  		size = be32_to_cpup((__force __be32 *)sizep);
>  		base = be64_to_cpup((__force __be64 *)basep);
>  	} else {
> -- 
> 2.23.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
