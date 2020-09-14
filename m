Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B1626958C
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Sep 2020 21:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgINTTe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Sep 2020 15:19:34 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51588 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbgINTTc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Sep 2020 15:19:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 70A2D8EE188;
        Mon, 14 Sep 2020 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600111171;
        bh=2HCTVqMcQP0NKG9QiCEjFdXhz4QnZn2LQdgmK3u2lOM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pBo2dugGAutN/uhbwzqKQbMFXe4QCJ9gNa+Ai8QGwhxfv0ybcxuZx6Ps47zdykgZc
         54e71ET+Smt5CpcIIY2k5jpmfedP2NJJYSf0vVQLGafRx+XjQjf7Rjh8c88eAo5ekE
         9rwgAVE/bEzQP/bDjLKoC3SF3OZKlzuVGSsd/OTY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8-33P5cjekY5; Mon, 14 Sep 2020 12:19:30 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 934C98EE111;
        Mon, 14 Sep 2020 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600111170;
        bh=2HCTVqMcQP0NKG9QiCEjFdXhz4QnZn2LQdgmK3u2lOM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a/JHsS/ik6d8CvZzl+VZe77qyOfUheILRa2i9/JzCOcwLojqtgftpJjlUMWjBJw4W
         st3QZU7qlOjiW8nWUAcYIKk4wMk+y7CPxwTgpluyS84Me/KTv+VfBmwOoi3C6md16o
         iqevS02dxLPYxA0TOhwJ/aWK+U/aujwFjUHtIL84=
Message-ID: <1600111168.4061.15.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Date:   Mon, 14 Sep 2020 12:19:28 -0700
In-Reply-To: <20200914174158.GA5106@linux.intel.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
         <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20200914174158.GA5106@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-09-14 at 20:41 +0300, Jarkko Sakkinen wrote:
> On Mon, Aug 17, 2020 at 02:35:06PM -0700, James Bottomley wrote:
> > Create sysfs per hash groups with 24 PCR files in them one group,
> > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > plugged in to a PCR read function which is TPM version agnostic, so
> > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > 
> > Note: the macros used to create the hashes emit spurious checkpatch
> > warnings.  Do not try to "fix" them as checkpatch recommends,
> > otherwise
> > they'll break.
> 
> "PCR access is required because IMA tools should be able to run
> without any sort of TSS dependencies."
> 
> AFAIK, this is the only reason to merge this and it is missing from
> the description. Perhaps you could either include that sentence, or
> alternatively write something along the lines?

Sure, I'll add all of them: it's IMA tools, early boot and key locking
to PCR policy.

> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> Please also cc this at least to Greg and Jason Gunthorpe next time.

OK

[...]

> > 
> enum tpm_alg_misc {
> 	TPM_ALG_ERROR		= 0x0000,
> 	TPM_ALG_KEYEDHASH	= 0x0008,
> 	TPM_ALG_NULL		= 0x0010,
> }
> 
> enum tpm_alg_hash {
> 	TPM_ALG_SHA1		= 0x0004,
> 	TPM_ALG_SHA256		= 0x000B,
> 	TPM_ALG_SHA384		= 0x000C,
> 	TPM_ALG_SHA512		= 0x000D,
> 	TPM_ALG_SM3_256		= 0x0012,
> 	TPM_ALG_HASH_MAX,
> };

I can separate them if you insist, but the latter construction won't
work.  TPM_ALG_HASH_MAX will get set to the previous value plus one.

You can see this with the test programme:

---
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

enum tpm_alg_hash {
        TPM_ALG_SHA1            = 0x0004,
        TPM_ALG_SHA256          = 0x000B,
        TPM_ALG_SHA384          = 0x000C,
        TPM_ALG_SHA512          = 0x000D,
        TPM_ALG_SM3_256         = 0x0012,
        TPM_ALG_HASH_MAX,
};

int main()
{
	printf("TPM_ALG_HASH_MAX = %d\n", TPM_ALG_HASH_MAX);
}
---

Which gives

jejb@jarvis> ./a.out
TPM_ALG_HASH_MAX = 19

Which is clearly the wrong value (it's 0x12 + 1).

That being so, is there any reason to separate up the algorithms enum?

James

