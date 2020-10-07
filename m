Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27A6285C71
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Oct 2020 12:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgJGKIR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Oct 2020 06:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgJGKIQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Oct 2020 06:08:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95234C0613D4
        for <linux-integrity@vger.kernel.org>; Wed,  7 Oct 2020 03:08:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so1053136pfn.9
        for <linux-integrity@vger.kernel.org>; Wed, 07 Oct 2020 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0QkHBy45JfxZtUUWeVh+Xo9BADxCzwJcCK5i5tE7/VU=;
        b=mjRB37NLj5SNoTE8pv7ujwZNmYXQSd/3yMHce8LtH63xvt4j7v4GQn5Vfx2QX1f6xJ
         fznOlC0w4fVcF4jdN4xKUqJsiN5dyj64LIV4fbdoj6fO8eO2umNLNNFwkovMWiMXwltK
         b0X3YB+JTIobDlZU6zCI5EQGkM36JsQfFxn3oYRIGXR7ZRlHCIWoKlqhoN9VAeC6gKwI
         uk1OKtT9vgtJ5zmTo/Qp/RO/swoOZlgKmUGyKymHLhZDNVptK2IMXpAQEEC/AoqySwpf
         nKouZsF6xRnLkoT+LckkTn/WcT3OQED6Rs1Wrr9DlJkM/Etba+XzIDydYmaVd6wukM7T
         tBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0QkHBy45JfxZtUUWeVh+Xo9BADxCzwJcCK5i5tE7/VU=;
        b=o4KnMNSGawoR9KCzz8OcP3PMQA1oWVFyZfCp06JLqy1t+KmmrXgW5UthWxuzvWNE2X
         wmqt/LQPraykPrMu/YhJUWb0mxNTtQZD8lO5d4dk3t5MOg6ti877o5HqDIFaCHhKefeZ
         qlPnpILbFvc8C8kXV09Ack7QC/NwZLuWIFTNToDyYB2ZqV4ZEVEYsOLhv1mRPtZOjzWn
         T55R/3jRhI9xut2P7zUSjQK76G8D4/vA+JtUzW+AfWD6Z4kQ9u6BC3bF0fF1iCDJTDuB
         8MYKKpWEjXjwxk3VHEfgiqmXw+Y4jyF5AvL87ugrpl2PaSxi9xJMdvqMZDfFTnb98Iin
         oj9A==
X-Gm-Message-State: AOAM533jCFuxzQXTQx+Yec08bQCoiLKg9Jzr8qCnpHt1EJqjCKVBys/l
        Rpd7i3l1gb/owSSAfBEe0PDGGQ==
X-Google-Smtp-Source: ABdhPJylY343ok9cAC6Btln4FsnUmJ5S0BSBvwLDpHlJJvlvFlZ64WTgUaTu8PpnloGMXk0GhMRqqw==
X-Received: by 2002:aa7:910c:0:b029:13e:d13d:a07b with SMTP id 12-20020aa7910c0000b029013ed13da07bmr2262427pfh.18.1602065295978;
        Wed, 07 Oct 2020 03:08:15 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.235])
        by smtp.gmail.com with ESMTPSA id m4sm2322174pgv.87.2020.10.07.03.08.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 03:08:15 -0700 (PDT)
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
Subject: [PATCH v7 0/4] Introduce TEE based Trusted Keys support
Date:   Wed,  7 Oct 2020 15:37:44 +0530
Message-Id: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
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
  MAINTAINERS: Add entry for TEE based Trusted Keys

 Documentation/security/keys/trusted-encrypted.rst | 203 ++++++++++---
 MAINTAINERS                                       |   8 +
 include/keys/trusted-type.h                       |  47 +++
 include/keys/trusted_tee.h                        |  55 ++++
 include/keys/trusted_tpm.h                        |  17 +-
 security/keys/trusted-keys/Makefile               |   2 +
 security/keys/trusted-keys/trusted_core.c         | 334 +++++++++++++++++++++
 security/keys/trusted-keys/trusted_tee.c          | 278 ++++++++++++++++++
 security/keys/trusted-keys/trusted_tpm1.c         | 336 ++++------------------
 9 files changed, 953 insertions(+), 327 deletions(-)
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 security/keys/trusted-keys/trusted_core.c
 create mode 100644 security/keys/trusted-keys/trusted_tee.c

-- 
2.7.4

