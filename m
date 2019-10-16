Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48E1D952F
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbfJPPM4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Oct 2019 11:12:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:36205 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388822AbfJPPMz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Oct 2019 11:12:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 08:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="370827051"
Received: from hagarwal-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.5.165])
  by orsmga005.jf.intel.com with ESMTP; 16 Oct 2019 08:12:47 -0700
Date:   Wed, 16 Oct 2019 18:12:46 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] tpm/tpm_ftpm_tee: add shutdown call back
Message-ID: <20191016151246.GA4261@linux.intel.com>
References: <20191014202135.429009-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014202135.429009-1-pasha.tatashin@soleen.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 14, 2019 at 04:21:35PM -0400, Pavel Tatashin wrote:
> add shutdown call back to close existing session with fTPM TA
> to support kexec scenario.

Sentences start in English with a capital letter :-)

> 
> Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 6640a14dbe48..ad16ea555e97 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -328,6 +328,19 @@ static int ftpm_tee_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +/**
> + * ftpm_tee_shutdown - shutdown the TPM device

A function name has to have parentheses in kdoc. I know this not
consistently done in the subsystem ATM but this is what is documented
here:

https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

/Jarkko
