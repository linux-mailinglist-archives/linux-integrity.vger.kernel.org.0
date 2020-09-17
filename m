Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6021D26DDF0
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 16:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgIQOMt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 10:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgIQN6l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 09:58:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50928C061224
        for <linux-integrity@vger.kernel.org>; Thu, 17 Sep 2020 06:47:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z18so1261032pfg.0
        for <linux-integrity@vger.kernel.org>; Thu, 17 Sep 2020 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=japyhlZJHqjvvY23WBswkoPhDdPOCw8vAFWR64JRMAo=;
        b=moaySg5dik4Lmk9RXXScA/9T274DPHQu5jVZ1/PZgJaWyJGy2IXTZeDsTOAmWRub7Q
         xTDMK2BkQ/z+NHQv06RZDa2oi6oALRQvwlBK1ZMpzu0Hjwa58wFxU0qYWhB4Mx3UKhYj
         XctS3mxqYaT46bZTcV6TAlP4tHHTz6YhhjEnROMaKgQdB2tdhuF+iigcIgdLlDtb1Mpx
         1bmXzG/MmuKfrTLTPh0V/VGy5AHsDqhpD9xq8geIeAXbTSIF0AG3QTNVnCpZ/oDy2os5
         T/hxpO4wSNhDTccMFo5L5LR8mP4OM8AcLrX0utHb6FG9YAlRrAYhQ8+8QR7wcarNCIhB
         vTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=japyhlZJHqjvvY23WBswkoPhDdPOCw8vAFWR64JRMAo=;
        b=RrWKvIxn3qkVhVZRbGSbMp9m/L6anWVt847cPRgPJxflHojplvxni7xyXQp58994UU
         +KzgIIIEW38xxvSe94Y7lAQJDraxR7Tso8u2sQraXYhDwq0UDtTaYqXSdicmRPPusBgQ
         K6Y0xbE0tUiqytKi41SiWIlkQMHGsYAmgQJkYF2KiFfRzEzgAweFXGoYmhLMHOKu8zi+
         IREA+UItnzDgVfobZ4Ls1j4FljsIy/wUpVPSqw0EgR5PxeKNhWuGH5X7G2+Tc31w2W15
         C3zUwbeNjAw6NArz5bk82FLNoRSUrVoKTBNs418DmFgJtgodu4UECj6U6hmDz7Z5IfR6
         8UUw==
X-Gm-Message-State: AOAM532Sa7j9oZmBhdJRj6DGYunOzKeUDz8cHw05M5ySOQiZUBiy10qF
        b4YvOh2S0BBbJsxxorMbg3gIZg==
X-Google-Smtp-Source: ABdhPJwGkICdVHzr7bA01n7thT2TYn0FduI6F4TEUuQvhGZbu4J3IGB6KK7FOQEYljS4a7Z+xROv6w==
X-Received: by 2002:a65:408b:: with SMTP id t11mr21151814pgp.199.1600350426605;
        Thu, 17 Sep 2020 06:47:06 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.163])
        by smtp.gmail.com with ESMTPSA id i73sm6821120pfe.67.2020.09.17.06.46.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 06:47:05 -0700 (PDT)
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
Subject: [PATCH v6 0/4] Introduce TEE based Trusted Keys support
Date:   Thu, 17 Sep 2020 19:16:34 +0530
Message-Id: <1600350398-4813-1-git-send-email-sumit.garg@linaro.org>
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
 include/keys/trusted-type.h                       |  42 +++
 include/keys/trusted_tee.h                        |  55 ++++
 include/keys/trusted_tpm.h                        |  17 +-
 security/keys/trusted-keys/Makefile               |   2 +
 security/keys/trusted-keys/trusted_core.c         | 325 +++++++++++++++++++++
 security/keys/trusted-keys/trusted_tee.c          | 278 ++++++++++++++++++
 security/keys/trusted-keys/trusted_tpm1.c         | 336 ++++------------------
 9 files changed, 939 insertions(+), 327 deletions(-)
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 security/keys/trusted-keys/trusted_core.c
 create mode 100644 security/keys/trusted-keys/trusted_tee.c

-- 
2.7.4

