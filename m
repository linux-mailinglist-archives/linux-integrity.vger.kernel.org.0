Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA7B3E2C5D
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Aug 2021 16:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhHFOSt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Aug 2021 10:18:49 -0400
Received: from smtp1.axis.com ([195.60.68.17]:26533 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234520AbhHFOSs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Aug 2021 10:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1628259513;
  x=1659795513;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=oJyVeNAsXlYCxq0SZK6pymR2gKq/VG3wMDOx/8a6DEE=;
  b=XQHHBiVaRiIVwS+9yDJmB1arOFuwoWU9XOcAJa9e5+RIt3VlsfAIWROa
   DkDE1Hc9G5jGrjyNLnzpK0ZUohcbqEikwOLHYmO949evFhp4RDtis5cYe
   YUV2z3i8i/m4jBDoRMaes4GnvxuDM7rjhiIFoNIevvDwNwFYk2bJfXjqc
   uO1RLAG7R7AsbzjRIJYbFr19WYDxPCKJ+D3ycW5OGubUJeVX8i33s88wl
   nNGKD3dReUDD1aSb4WyvJmter7pr4M4VV1n/nuIXXxulXb4dyhSnQMre+
   l03AyISOPKxXmDAnl3aII18jwu0cs9gS/WGU1vdTZHkYrg90uf2LJbZT+
   Q==;
Subject: Re: [PATCH v3] tpm: Add Upgrade/Reduced mode support for TPM2 modules
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Borys Movchan <Borys.Movchan@axis.com>
CC:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel <kernel@axis.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210804162132.24786-1-borysmn@axis.com>
 <20210805205245.qcdqcuog7zmsp7j5@kernel.org>
From:   Borys Movchan <borysmn@axis.com>
Message-ID: <d6cd1eb6-48b5-c1ad-e063-a26bc7509d95@axis.com>
Date:   Fri, 6 Aug 2021 16:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805205245.qcdqcuog7zmsp7j5@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail04w.axis.com (10.20.40.10) To se-mail07w.axis.com
 (10.20.40.13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/5/21 10:52 PM, Jarkko Sakkinen wrote:
> On Wed, Aug 04, 2021 at 06:21:31PM +0200, Borys Movchan wrote:
>> If something went wrong during the TPM firmware upgrade, like power
>> failure or the firmware image file get corrupted, the TPM might end
>> up in Upgrade or Failure mode upon the next start. The state is
>> persistent between the TPM power cycle/restart.
>>
>> According to TPM specification:
>>  * If the TPM is in Upgrade mode, it will answer with TPM2_RC_UPGRADE
>>    to all commands except Field Upgrade related ones.
>>  * If the TPM is in Failure mode, it will allow performing TPM
>>    initialization but will not provide any crypto operations.
>>    Will happily respond to Field Upgrade calls.
>>
>> The fix changes the behavior of the `tpm2_auto_startup` function, so
>                                 
> In commit messages, you ought to use imperative form:
>
> "Change the behaviour of tpm2_auto_startup(), ..."
>
Done
>> it tries to detect what mode TPM is running in. If the chip is in the
>> Upgrade or Failure mode, the function returns -EIO error code which
>> can be used later to adjust driver behavior later.
> *How* tpm2_auto_startup() detects the mode?
Done
>> After `tpm_chip_register` calls `tpm2_auto_startup` it checks for the
> Please remove all these hyphens. They make the commit message a pain
> to read. E.g. instead write tpm_chip_register(). This is not Github.
Done
>> error code. If the TPM is in Upgrade or Failure mode, set the
>> `limited_mode` flag. The calls to `tpm2_get_cc_attrs_tbl`,
>> `tpm_add_hwrng` and `tpm_get_pcr_allocation` will fail if the TPM is
>> in Failure or Upgrade mode, so use `limited_mode` flag to exclude
>> them from the module initialization sequence.
>>
>> Signed-off-by: Borys Movchan <borysmn@axis.com>
>> ---
>>
>> Notes:
>>     Commit message updated
> v2:
> * Commit message updated.
>
> Notes would be something that had existed already in the first version.
> Here we want a simple change log.
Corrected
> /Jarkko
>

Kind regards,

Borys

