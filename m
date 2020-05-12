Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB591CF16F
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 11:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgELJVB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 05:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729288AbgELJU4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 05:20:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA8CC061A0C
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 02:20:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so12794973ljl.2
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 02:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNH+m8omjPnk476jGLpu8Vt8kPOpg3agkUbWl32XtLw=;
        b=RTRXN6UpK2F7NEYSZFbq/6CmZAZUEetFV4/nF5JiSYvyNI5g4nTSNhLFkFoHjZwByP
         Zlg/5cua8es2+gXO0jg7lEsyOvayqu+1Hiy9tJXNKfbH9AVH8hYCjEcmgZTtRBulz2Nv
         j6Mr9nFwWAwPdaQvT4mLPIwg+38zt89Y0MZnSr1WSC3bzYdVCOHwU9KexFMQP8ObqJiA
         nBLhku7TpS+EYOBoPcY4ND81ZhxYJsgVdGS/XnsbZtHryPTOr7O9aoNvFmt04d5nNqBj
         9UF8fA1bnUgTKmVgdIIWE7HfRRJy9I5vVOQGLLjoyfo8I+eVeGK3r5ReIXgumar2WDhx
         uWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNH+m8omjPnk476jGLpu8Vt8kPOpg3agkUbWl32XtLw=;
        b=kXsCel4WLTlcCyBIem8Vv+1msXxAzVHkO0Yc0pHW6EFHIafY5qOPfbtYBL6+Byc8O7
         Hik5J3ONrX8BDbe+uOmkm5bosGgN3NcgBEqwGHDe0elc5Cq27a0Oa+JIteoNOSxKjd8R
         kWFd4rC00yWMlux8GSZ3V2yqUMX3DCFswbjGvWCOcWax2vyu9HP1Wj6/QygM7K9v+SnL
         hzm9SvoOBhcvrtxAda/W6awEHCGAixs3X5evQ0h5iYdXjGvXeIM5iK2D6bJjmI3HcpE+
         +JP5djQaUERtQy6ftb/pLXGFp33DOveFlE2sVNzoccVtO+BAWuzfd58WsVL3AQAuk+5H
         eYrw==
X-Gm-Message-State: AOAM531sm2pi2O1/Mm7nDEec5863r0DlrqUCIuFkCHpwgoIEtOQ32D+b
        3UUlOCeAQ1ziabWHEg6FjXuSMDK/C9V19iD5M2ezMA==
X-Google-Smtp-Source: ABdhPJxY70vedCXTAc/sVhR66GczTIpt7w0KW9ze1vEeSXLFO3Eq/mp5nh3QrQuPhD0UQIwMuEug7EhXdEzryApWOnc=
X-Received: by 2002:a05:651c:1b9:: with SMTP id c25mr9138973ljn.285.1589275253855;
 Tue, 12 May 2020 02:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 12 May 2020 14:50:42 +0530
Message-ID: <CAFA6WYNgBQDBY+670fG38Yrg8tMg6U74TW12WON=9dVvsT0t6w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Introduce TEE based Trusted Keys support
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     dhowells@redhat.com, Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 6 May 2020 at 15:10, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key. Also, this is
> an alternative in case platform doesn't possess a TPM device.
>
> This patch-set has been tested with OP-TEE based early TA which can be
> found here [1].
>
> [1] https://github.com/OP-TEE/optee_os/pull/3838

Fyi, this PR has been merged in OP-TEE OS as commit [1]. Looking
forward to any further comments/feedback on this patch-set.

[1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee070d7e5b86b

-Sumit

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
>   MAINTAINERS: Add entry for TEE based Trusted Keys
>
>  Documentation/security/keys/trusted-encrypted.rst | 203 ++++++++++---
>  MAINTAINERS                                       |   8 +
>  include/keys/trusted-type.h                       |  48 ++++
>  include/keys/trusted_tee.h                        |  66 +++++
>  include/keys/trusted_tpm.h                        |  15 -
>  security/keys/Kconfig                             |   3 +
>  security/keys/trusted-keys/Makefile               |   2 +
>  security/keys/trusted-keys/trusted_common.c       | 336 ++++++++++++++++++++++
>  security/keys/trusted-keys/trusted_tee.c          | 282 ++++++++++++++++++
>  security/keys/trusted-keys/trusted_tpm1.c         | 335 ++++-----------------
>  10 files changed, 974 insertions(+), 324 deletions(-)
>  create mode 100644 include/keys/trusted_tee.h
>  create mode 100644 security/keys/trusted-keys/trusted_common.c
>  create mode 100644 security/keys/trusted-keys/trusted_tee.c
>
> --
> 2.7.4
>
