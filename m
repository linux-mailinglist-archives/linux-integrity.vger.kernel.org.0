Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8EAECE8
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2019 16:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfIJOZJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Sep 2019 10:25:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:48030 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbfIJOZJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 10:25:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 07:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="196564634"
Received: from agreppma-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.7])
  by orsmga002.jf.intel.com with ESMTP; 10 Sep 2019 07:25:05 -0700
Date:   Tue, 10 Sep 2019 15:25:04 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v3] KEYS: trusted: correctly initialize digests and fix
 locking issue
Message-ID: <20190910142504.GA3768@linux.intel.com>
References: <20190908174542.509-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908174542.509-1-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 08, 2019 at 07:45:42PM +0200, Roberto Sassu wrote:
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1b4f95c13e00..1fffa91fc148 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -316,14 +316,14 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  	int rc;
>  	int i;
>  
> -	chip = tpm_find_get_ops(chip);
> -	if (!chip)
> -		return -ENODEV;
> -
>  	for (i = 0; i < chip->nr_allocated_banks; i++)
>  		if (digests[i].alg_id != chip->allocated_banks[i].alg_id)
>  			return -EINVAL;
>  
> +	chip = tpm_find_get_ops(chip);
> +	if (!chip)
> +		return -ENODEV;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>  		rc = tpm2_pcr_extend(chip, pcr_idx, digests);
>  		tpm_put_ops(chip);

You can only access chip's field when you hold the lock and have a legit
refcount. This would add a potential race. The bug is very much valid
and thank you for spotting that.

I sent a patch the fix the 2nd issue with your reported-by.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes

/Jarkko


