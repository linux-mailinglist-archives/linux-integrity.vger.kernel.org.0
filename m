Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF9DD3FA0
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2019 14:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfJKMiH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Oct 2019 08:38:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:26504 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbfJKMiH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Oct 2019 08:38:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 05:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="206436900"
Received: from mkaltenb-mobl.ger.corp.intel.com (HELO localhost) ([10.251.83.92])
  by orsmga002.jf.intel.com with ESMTP; 11 Oct 2019 05:37:58 -0700
Date:   Fri, 11 Oct 2019 15:37:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     dhowells@redhat.com, peterhuewe@gmx.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org
Subject: Re: [Patch v7 0/4] Create and consolidate trusted keys subsystem
Message-ID: <20191011123757.GD3129@linux.intel.com>
References: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 07, 2019 at 10:55:31AM +0530, Sumit Garg wrote:
> This patch-set does restructuring of trusted keys code to create and
> consolidate trusted keys subsystem.
> 
> Also, patch #2 replaces tpm1_buf code used in security/keys/trusted.c and
> crypto/asymmertic_keys/asym_tpm.c files to use the common tpm_buf code.
> 
> Changes in v7:
> 1. Rebased to top of tpmdd/master
> 2. Patch #4: update tpm2 trusted keys code to use tpm_send() instead of
>    tpm_transmit_cmd() which is an internal function.
> 
> Changes in v6:
> 1. Switch TPM asymmetric code also to use common tpm_buf code. These
>    changes required patches #1 and #2 update, so I have dropped review
>    tags from those patches.
> 2. Incorporated miscellaneous comments from Jarkko.
> 
> Changes in v5:
> 1. Drop 5/5 patch as its more relavant along with TEE patch-set.
> 2. Add Reviewed-by tag for patch #2.
> 3. Fix build failure when "CONFIG_HEADER_TEST" and
>    "CONFIG_KERNEL_HEADER_TEST" config options are enabled.
> 4. Misc changes to rename files.
> 
> Changes in v4:
> 1. Separate patch for export of tpm_buf code to include/linux/tpm.h
> 2. Change TPM1.x trusted keys code to use common tpm_buf
> 3. Keep module name as trusted.ko only
> 
> Changes in v3:
> 
> Move TPM2 trusted keys code to trusted keys subsystem.
> 
> Changes in v2:
> 
> Split trusted keys abstraction patch for ease of review.
> 
> Sumit Garg (4):
>   tpm: Move tpm_buf code to include/linux/
>   KEYS: Use common tpm_buf for trusted and asymmetric keys
>   KEYS: trusted: Create trusted keys subsystem
>   KEYS: trusted: Move TPM2 trusted keys code
> 
>  crypto/asymmetric_keys/asym_tpm.c                  | 101 +++----
>  drivers/char/tpm/tpm-interface.c                   |  56 ----
>  drivers/char/tpm/tpm.h                             | 226 ---------------
>  drivers/char/tpm/tpm2-cmd.c                        | 307 --------------------
>  include/Kbuild                                     |   1 -
>  include/keys/{trusted.h => trusted_tpm.h}          |  49 +---
>  include/linux/tpm.h                                | 251 ++++++++++++++--
>  security/keys/Makefile                             |   2 +-
>  security/keys/trusted-keys/Makefile                |   8 +
>  .../{trusted.c => trusted-keys/trusted_tpm1.c}     |  96 +++----
>  security/keys/trusted-keys/trusted_tpm2.c          | 314 +++++++++++++++++++++
>  11 files changed, 652 insertions(+), 759 deletions(-)
>  rename include/keys/{trusted.h => trusted_tpm.h} (77%)
>  create mode 100644 security/keys/trusted-keys/Makefile
>  rename security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} (94%)
>  create mode 100644 security/keys/trusted-keys/trusted_tpm2.c
> 
> -- 
> 2.7.4
> 

I fixed a merge conflict caused by James' commit. Already pushed.
Compiling test kernel ATM i.e. tested-by's will follow later.

/Jarkko
