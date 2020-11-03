Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1781A2A4A96
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgKCQCY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 11:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgKCQCY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 11:02:24 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C0AC061A48
        for <linux-integrity@vger.kernel.org>; Tue,  3 Nov 2020 08:02:24 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id o129so14601272pfb.1
        for <linux-integrity@vger.kernel.org>; Tue, 03 Nov 2020 08:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8p0zAqijMFY2LZHySc9B1ski8j200B9xN63VufhvfZE=;
        b=WUvK9hiBfaewCF9lu/rnHA/ky1TO9SLKq5ubWrc5NfyBQalP1EDJFCgB620q5hzm8P
         w7RqbA90o7pWxpiD+JQTGkZj/vELhrwHlo53vmxaXkdrHs56KSdUT8cmWchK9SdOLPsb
         MIyRS6VCBLK3GkPdVZpsjiuVJ8eZo29MM7dRDd/oC3PF2hJu9WHHNg8Q3/eeqDnEVe8M
         u5s/UYCObUpv8BdQ2ssY0JMUat1++qs66Y2pTlhfDXutXg95e2WmlZ0amNC2BUaQsQfu
         T+70gsyMITdKOD5SRY5wpAN6KRH2geAbi9LnGmLunPGcay45ZutIZULvHh8iF/s+a1Js
         Z2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8p0zAqijMFY2LZHySc9B1ski8j200B9xN63VufhvfZE=;
        b=EYc7/ygtvchHnpAa+itsraK4q/JgfK0Db7mvcWz+PfkwoSnUPZHgp1fKytrXqfbAwf
         aAsr1KMd/Ay696sZYL7+HyukeEwTxvcte9UZcQ9Pi/uUOM2gYy4b9vowXPptUpMHLiQr
         WbTzGwxUdr2pmwBismyyU3THt7AyyJdo8o1RLz+hkY6SijoPt41JAwzVDIyJvGLYRK+U
         bNq8/sc6WyJIC4kxyi5VbWH9RTlDDBJeNaW4wO5FhEqv3Ql4CO+2tV3kcKZPltwAskx+
         p0hr9TOAs1UKknzNCSUyM6Bc9ksYrE54YXBx7iRNzanq7yrALgsJr0R6LFYusGG15cPR
         AVHw==
X-Gm-Message-State: AOAM530hUzBeOxWj7PBFvtfqy+aCDSLAly960jRVw7n+2SYG7wWBIiB+
        aBRfz58ckPpXkfvs1tSFnb5UJg==
X-Google-Smtp-Source: ABdhPJzP+u5vyjCsNCaso/eSJbT/0D07SqbTdgo7fO1H1p7jSMwcJ3JjzNbr2nmtIaOIuGQqaoxE5Q==
X-Received: by 2002:a63:5466:: with SMTP id e38mr17855102pgm.23.1604419343676;
        Tue, 03 Nov 2020 08:02:23 -0800 (PST)
Received: from localhost.localdomain ([122.173.169.225])
        by smtp.gmail.com with ESMTPSA id j140sm8471006pfd.216.2020.11.03.08.02.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 08:02:22 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v8 0/4] Introduce TEE based Trusted Keys support
Date:   Tue,  3 Nov 2020 21:31:42 +0530
Message-Id: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add support for TEE based trusted keys where TEE provides the functionality
to seal and unseal trusted keys using hardware unique key. Also, this is
an alternative in case platform doesn't possess a TPM device.

This patch-set has been tested with OP-TEE based early TA which is already
merged in upstream [1].

[1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee070d7e5b86b

Changes in v8:
1. Added static calls support instead of indirect calls.
2. Documented trusted keys source module parameter.
3. Refined patch #1 commit message discription.
4. Addressed misc. comments on patch #2.
5. Added myself as Trusted Keys co-maintainer instead.
6. Rebased to latest tpmdd master.

Changes in v7:
1. Added a trusted.source module parameter in order to enforce user's
   choice in case a particular platform posses both TPM and TEE.
2. Refine commit description for patch #1.

Changes in v6:
1. Revert back to dynamic detection of trust source.
2. Drop author mention from trusted_core.c and trusted_tpm1.c files.
3. Rebased to latest tpmdd/master.

Changes in v5:
1. Drop dynamic detection of trust source and use compile time flags
   instead.
2. Rename trusted_common.c -> trusted_core.c.
3. Rename callback: cleanup() -> exit().
4. Drop "tk" acronym.
5. Other misc. comments.
6. Added review tags for patch #3 and #4.

Changes in v4:
1. Pushed independent TEE features separately:
  - Part of recent TEE PR: https://lkml.org/lkml/2020/5/4/1062
2. Updated trusted-encrypted doc with TEE as a new trust source.
3. Rebased onto latest tpmdd/master.

Changes in v3:
1. Update patch #2 to support registration of multiple kernel pages.
2. Incoporate dependency patch #4 in this patch-set:
   https://patchwork.kernel.org/patch/11091435/

Changes in v2:
1. Add reviewed-by tags for patch #1 and #2.
2. Incorporate comments from Jens for patch #3.
3. Switch to use generic trusted keys framework.

Sumit Garg (4):
  KEYS: trusted: Add generic trusted keys framework
  KEYS: trusted: Introduce TEE based Trusted Keys
  doc: trusted-encrypted: updates with TEE as a new trust source
  MAINTAINERS: Add myself as Trusted Keys co-maintainer

 Documentation/admin-guide/kernel-parameters.txt   |  12 +
 Documentation/security/keys/trusted-encrypted.rst | 203 +++++++++++--
 MAINTAINERS                                       |   2 +
 include/keys/trusted-type.h                       |  47 +++
 include/keys/trusted_tee.h                        |  55 ++++
 include/keys/trusted_tpm.h                        |  17 +-
 security/keys/trusted-keys/Makefile               |   2 +
 security/keys/trusted-keys/trusted_core.c         | 354 ++++++++++++++++++++++
 security/keys/trusted-keys/trusted_tee.c          | 278 +++++++++++++++++
 security/keys/trusted-keys/trusted_tpm1.c         | 336 ++++----------------
 10 files changed, 979 insertions(+), 327 deletions(-)
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 security/keys/trusted-keys/trusted_core.c
 create mode 100644 security/keys/trusted-keys/trusted_tee.c

-- 
2.7.4

