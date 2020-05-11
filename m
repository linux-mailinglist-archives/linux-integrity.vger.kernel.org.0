Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E6B1CE3A6
	for <lists+linux-integrity@lfdr.de>; Mon, 11 May 2020 21:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgEKTOa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 May 2020 15:14:30 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52996 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728613AbgEKTOa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 May 2020 15:14:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 067DA8EE151;
        Mon, 11 May 2020 12:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589224470;
        bh=ykG8RmU9A9Oo1E+ZiJkMVKMXNl8JaMw+O89DjobW29o=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=eF/keRR0NmEm0CRC9dEkhFIeEdKyNJjGF56MWvEji2oJZAE4SzzNtFVTrSKmgRn90
         XCBEZtrJIvI+xE/ADN2OMM3uohL2hmqabIKRTlnI5Wqh5IDk96MAABqEIgAvxKgDOq
         ZDMpi14kWr5VVRjyRCorT80Gc/Np6qkqVC32M/qw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6mFsMtbloqLR; Mon, 11 May 2020 12:14:29 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 94A568EE100;
        Mon, 11 May 2020 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589224469;
        bh=ykG8RmU9A9Oo1E+ZiJkMVKMXNl8JaMw+O89DjobW29o=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=q5e1dYaV4cDiU88BqeCVxZk+XSa1HI76NT8pgscV/dhNHIYzk3bfzY7GTNcPPR84c
         7ZrEN5dJO2gg4mWPguXKKy0i1l0mI879u5zklI9wPB8UnLhwO9BYFRZzMk8p2N1sVX
         vTTh7jflJBZuSkDr+KUkAOx+vcWaAlDLFin4yamA=
Message-ID: <1589224468.4201.3.camel@HansenPartnership.com>
Subject: Re: Questions on SHA1 in ima_init
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Roberts, William C" <william.c.roberts@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Mon, 11 May 2020 12:14:28 -0700
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649EDCB91@ORSMSX101.amr.corp.intel.com>
References: <476DC76E7D1DF2438D32BFADF679FC5649EDCB91@ORSMSX101.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-05-11 at 17:49 +0000, Roberts, William C wrote:
> Hello,
> 
> I'm part of the tpm2 users pace tooling and libraries, and I am
> trying to track down an issue in where boot aggregate is only
> extended in the SHA1
> bank of PCR10.
> 
> You can read the details on the link below, but ill summarize here
>   - https://lists.01.org/hyperkitty/list/tpm2@lists.01.org/thread/FUB
> D3MY5U5YICNUYSF3NE2STO3YAW7Y4/
> 
> It looks like ima_add_boot_aggregate() is hardcoded to SHA1, our
> guess is, that it's so it works between TPM 1.X and TPM2.0 chips. Is
> that
> correct?
> 
> I was wondering if that synopsis is correct and if there would be
> traction to add something like querying the tpm chip and getting the
> version And picking SHA256 if its tpm2.0, as a sample to guide the
> discussion I included the patch below (totally untested/not-
> compiled). The main downside would be leaking TPM versions into IMA
> to make a decisions, so it may be better to have a helper in the tpm
> code to pick the best default algorithm where it could pick SHA1 for
> TPM1.X and SHA256 for TPM2.0. Thoughts?

I think you're not tracking the list.  The current patch set doing this
among other things is here:

https://lore.kernel.org/linux-integrity/20200325104712.25694-1-roberto.sassu@huawei.com/

The patch below is too simplistic. If you follow the threads on the
list, you'll see we found a Dell with a TPM2 that won't enable the
sha256 bank if it's set in bios to sha1 mode, which is why the actual
patch here:

https://lore.kernel.org/linux-integrity/20200325104712.25694-1-roberto.sassu@huawei.com/

Checks the supported banks and uses sha256 if it's listed.

James

> diff --git a/security/integrity/ima/ima_init.c
> b/security/integrity/ima/ima_init.c
> index 567468188a61..d0513bafeebf 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -15,6 +15,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
> +#include <linux/printk.h>
>  
>  #include "ima.h"
>  
> @@ -59,6 +60,16 @@ static int __init ima_add_boot_aggregate(void)
>         iint->ima_hash->length = SHA1_DIGEST_SIZE;
>  
>         if (ima_tpm_chip) {
> +               result = tpm_is_tpm2(ima_tpm_chip);
> +               if (result > 0) {
> +                       /* yes it's a TPM2 chipset use sha256 */
> +                       iint->ima_hash->algo = HASH_ALGO_SHA256;
> +                       iint->ima_hash->length = SHA256_DIGEST_SIZE;
> +               } else if (result < 0) {
> +                       /* ignore errors here, as we can just move on
> with SHA1 */
> +                       pr_warn("Could not query TPM chip version,
> got: %d\n", result);
> +               }
> +
>                 result = ima_calc_boot_aggregate(&hash.hdr);
>                 if (result < 0) {
>                         audit_cause = "hashing_error";
> 
> 
> 
> 
> 

