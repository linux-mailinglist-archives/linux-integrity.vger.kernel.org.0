Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B4B26A413
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Sep 2020 13:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgIOLYA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Sep 2020 07:24:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:63536 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgIOLW5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Sep 2020 07:22:57 -0400
IronPort-SDR: q2heLnW7EBDdAoYSghDKPHpd+N44HiJJ8dzdT4MiU0QEGjxwTyv0Q02SUaLAGmmmN4fauO1DlQ
 e97fhnTSpkeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="220794378"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="220794378"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 04:22:11 -0700
IronPort-SDR: hPJS4EL7yWv/b9KyWBfeyDlNgLpfQnLwicVYGrXGMwJfqf1xkbNX148Hyrw/NIiotFh0dR+Fi3
 nPu3DQgbnnBw==
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="482732138"
Received: from aroessle-mobl.ger.corp.intel.com (HELO localhost) ([10.252.62.198])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 04:22:08 -0700
Date:   Tue, 15 Sep 2020 14:22:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200915112206.GA896555@linux.intel.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200914174158.GA5106@linux.intel.com>
 <1600111168.4061.15.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600111168.4061.15.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 14, 2020 at 12:19:28PM -0700, James Bottomley wrote:
> On Mon, 2020-09-14 at 20:41 +0300, Jarkko Sakkinen wrote:
> > On Mon, Aug 17, 2020 at 02:35:06PM -0700, James Bottomley wrote:
> > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > plugged in to a PCR read function which is TPM version agnostic, so
> > > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > > 
> > > Note: the macros used to create the hashes emit spurious checkpatch
> > > warnings.  Do not try to "fix" them as checkpatch recommends,
> > > otherwise
> > > they'll break.
> > 
> > "PCR access is required because IMA tools should be able to run
> > without any sort of TSS dependencies."
> > 
> > AFAIK, this is the only reason to merge this and it is missing from
> > the description. Perhaps you could either include that sentence, or
> > alternatively write something along the lines?
> 
> Sure, I'll add all of them: it's IMA tools, early boot and key locking
> to PCR policy.

Great!

> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > > om>
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > 
> > Please also cc this at least to Greg and Jason Gunthorpe next time.
> 
> OK
> 
> [...]
> 
> > > 
> > enum tpm_alg_misc {
> > 	TPM_ALG_ERROR		= 0x0000,
> > 	TPM_ALG_KEYEDHASH	= 0x0008,
> > 	TPM_ALG_NULL		= 0x0010,
> > }
> > 
> > enum tpm_alg_hash {
> > 	TPM_ALG_SHA1		= 0x0004,
> > 	TPM_ALG_SHA256		= 0x000B,
> > 	TPM_ALG_SHA384		= 0x000C,
> > 	TPM_ALG_SHA512		= 0x000D,
> > 	TPM_ALG_SM3_256		= 0x0012,
> > 	TPM_ALG_HASH_MAX,
> > };
> 
> I can separate them if you insist, but the latter construction won't
> work.  TPM_ALG_HASH_MAX will get set to the previous value plus one.
> 
> You can see this with the test programme:
> 
> ---
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> 
> enum tpm_alg_hash {
>         TPM_ALG_SHA1            = 0x0004,
>         TPM_ALG_SHA256          = 0x000B,
>         TPM_ALG_SHA384          = 0x000C,
>         TPM_ALG_SHA512          = 0x000D,
>         TPM_ALG_SM3_256         = 0x0012,
>         TPM_ALG_HASH_MAX,
> };
> 
> int main()
> {
> 	printf("TPM_ALG_HASH_MAX = %d\n", TPM_ALG_HASH_MAX);
> }
> ---
> 
> Which gives
> 
> jejb@jarvis> ./a.out
> TPM_ALG_HASH_MAX = 19
> 
> Which is clearly the wrong value (it's 0x12 + 1).
> 
> That being so, is there any reason to separate up the algorithms enum?
> 
> James

No, my bad.

/Jarkko
