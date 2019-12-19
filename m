Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 494CD125835
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2019 01:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLSAFn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 19:05:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:62680 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfLSAFn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 19:05:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 16:05:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="213073485"
Received: from jtreacy-mobl1.ger.corp.intel.com ([10.251.82.127])
  by fmsmga008.fm.intel.com with ESMTP; 18 Dec 2019 16:05:39 -0800
Message-ID: <6b67a2ae58aa627711808a52122c998fab350da3.camel@linux.intel.com>
Subject: Re: [PATCH v2] tpm/ppi: remove impossible assertion in tpm_eval_dsm
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20191218154825.11634-1-pakki001@umn.edu>
References: <20191218154825.11634-1-pakki001@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 19 Dec 2019 02:05:34 +0200
User-Agent: Evolution 3.34.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-18 at 09:48 -0600, Aditya Pakki wrote:
> In tpm_eval_dsm, BUG_ON on ppi_handle is used as an assertion.
> However, if ppi_handle is NULL, the kernel crashes. The patch
> removes the unnecessary check.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
> v1: replaced the recovery code to completely eliminate the check,
> as suggested by Jason Gunthorpe.
> ---
>  drivers/char/tpm/tpm_ppi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index b2dab941cb7f..603f7806f9af 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -42,7 +42,6 @@ static inline union acpi_object *
>  tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
>  	     union acpi_object *argv4, u64 rev)
>  {
> -	BUG_ON(!ppi_handle);
>  	return acpi_evaluate_dsm_typed(ppi_handle, &tpm_ppi_guid,
>  				       rev, func, argv4, type);
>  }

Hmm.. maybe omitting completely is actually better idea (since
it never should happen anyway).

Lets go with that.

Thanks.

/Jarkko

