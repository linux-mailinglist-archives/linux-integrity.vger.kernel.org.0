Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383052A76C7
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Nov 2020 06:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgKEFHp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Nov 2020 00:07:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgKEFHp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Nov 2020 00:07:45 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B0532151B;
        Thu,  5 Nov 2020 05:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604552864;
        bh=nk1WdBkWqE96DNUgpPnEgglR9AlimFCtq6FRxMGc7xE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MycmoIqlkHNfLdg/4eGDLGTmTVseEVmjDsa9Y+lDCzshvrSFnTMbODg/YOsr8jpvp
         bt3wEVqbRwnfEdZ1sVqbgB2ur0kJqMOeax8TzItcBA907CqmsfE2TIGpctankw3exh
         yiE528psxV5h9SfQ3XD2GJfPmeipD8HjJcN770T4=
Date:   Thu, 5 Nov 2020 07:07:36 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com, dhowells@redhat.com, jens.wiklander@linaro.org,
        corbet@lwn.net, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, janne.karhunen@gmail.com,
        daniel.thompson@linaro.org, Markus.Wamser@mixed-mode.de,
        lhinds@redhat.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 0/4] Introduce TEE based Trusted Keys support
Message-ID: <20201105050736.GA702944@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 03, 2020 at 09:31:42PM +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key. Also, this is
> an alternative in case platform doesn't possess a TPM device.
> 
> This patch-set has been tested with OP-TEE based early TA which is already
> merged in upstream [1].

Is the new RPI400 computer a platform that can be used for testing
patch sets like this? I've been looking for a while something ARM64
based with similar convenience as Intel NUC's, and on the surface
this new RPI product looks great for kernel testing purposes.

/Jarkko

> 
> [1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee070d7e5b86b
> 
> Changes in v8:
> 1. Added static calls support instead of indirect calls.
> 2. Documented trusted keys source module parameter.
> 3. Refined patch #1 commit message discription.
> 4. Addressed misc. comments on patch #2.
> 5. Added myself as Trusted Keys co-maintainer instead.
> 6. Rebased to latest tpmdd master.
> 
> Changes in v7:
> 1. Added a trusted.source module parameter in order to enforce user's
>    choice in case a particular platform posses both TPM and TEE.
> 2. Refine commit description for patch #1.
> 
> Changes in v6:
> 1. Revert back to dynamic detection of trust source.
> 2. Drop author mention from trusted_core.c and trusted_tpm1.c files.
> 3. Rebased to latest tpmdd/master.
> 
> Changes in v5:
> 1. Drop dynamic detection of trust source and use compile time flags
>    instead.
> 2. Rename trusted_common.c -> trusted_core.c.
> 3. Rename callback: cleanup() -> exit().
> 4. Drop "tk" acronym.
> 5. Other misc. comments.
> 6. Added review tags for patch #3 and #4.
> 
> Changes in v4:
> 1. Pushed independent TEE features separately:
>   - Part of recent TEE PR: https://lkml.org/lkml/2020/5/4/1062
> 2. Updated trusted-encrypted doc with TEE as a new trust source.
> 3. Rebased onto latest tpmdd/master.
> 
> Changes in v3:
> 1. Update patch #2 to support registration of multiple kernel pages.
> 2. Incoporate dependency patch #4 in this patch-set:
>    https://patchwork.kernel.org/patch/11091435/
> 
> Changes in v2:
> 1. Add reviewed-by tags for patch #1 and #2.
> 2. Incorporate comments from Jens for patch #3.
> 3. Switch to use generic trusted keys framework.
> 
> Sumit Garg (4):
>   KEYS: trusted: Add generic trusted keys framework
>   KEYS: trusted: Introduce TEE based Trusted Keys
>   doc: trusted-encrypted: updates with TEE as a new trust source
>   MAINTAINERS: Add myself as Trusted Keys co-maintainer
> 
>  Documentation/admin-guide/kernel-parameters.txt   |  12 +
>  Documentation/security/keys/trusted-encrypted.rst | 203 +++++++++++--
>  MAINTAINERS                                       |   2 +
>  include/keys/trusted-type.h                       |  47 +++
>  include/keys/trusted_tee.h                        |  55 ++++
>  include/keys/trusted_tpm.h                        |  17 +-
>  security/keys/trusted-keys/Makefile               |   2 +
>  security/keys/trusted-keys/trusted_core.c         | 354 ++++++++++++++++++++++
>  security/keys/trusted-keys/trusted_tee.c          | 278 +++++++++++++++++
>  security/keys/trusted-keys/trusted_tpm1.c         | 336 ++++----------------
>  10 files changed, 979 insertions(+), 327 deletions(-)
>  create mode 100644 include/keys/trusted_tee.h
>  create mode 100644 security/keys/trusted-keys/trusted_core.c
>  create mode 100644 security/keys/trusted-keys/trusted_tee.c
> 
> -- 
> 2.7.4
> 
> 
