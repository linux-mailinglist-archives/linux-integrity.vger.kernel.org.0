Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD8E43C4E
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfFMPfN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 11:35:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34562 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfFMKbX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 06:31:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so7957333plt.1
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=c4lD5Ja/W68zU30yx+ZIDKDyIrqaAIZ94VRiCyeCO0Y=;
        b=YkW4wOsmtRXKF39IQeQs8ZdcwD+6X2M5iCF/r6jKCp49Ml1bgkwnn9qLqERse4MXnS
         JvE/JUr1cR6fI4sYp9RHlrto71AB7k+bS6GVAtsKrhT2Wmz0R/Nn7NUSf9qGlSMRGqGX
         VFRL05138Hd3JVcXhBoLNfRo+SP5MpLwlqKq3bPblTc9ut7nk6RpFrhz/AS0kQLMdp7W
         NYPunno5BmFlawT6AG9mFdUyJvmrBka68PEWDGES8yBZtUknvd3nXlEXBJq+d80A2PuT
         pOlbAZYM12CmFbPUcdVThV/+qdhyEwwMTvqzkqBEoGhYmCw5qx4Uu3CqrowG+fxR70zk
         EXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c4lD5Ja/W68zU30yx+ZIDKDyIrqaAIZ94VRiCyeCO0Y=;
        b=ZQfmiSAuoCBGeehQSgbauHiAMAHFgijKyhm+Fp+7FsbHiRmRbmi14MsqdfvmPqiiUr
         nLTuqouRDGBhzVcK+Hzl4xwsrGATrjvvQ9o9LuEfdxMutVEP6ElSD4HX9qP2ECc2mBCL
         Vr9WybQvBkyqkXI4UlrBSu9HkcNkxZ6V1GLO0KoawlBg/Xy3dydQ1KJ57VJDFrykG/7S
         v9U6gO6IM9/J3mkWG4NjCneVQdatbROlo6946MkxqgoeNJYBa/I1uKoCU8To/HFNNMoC
         puQbb1lHx6MyPBYr8JEohFHmWA8KPpt4Eth3EypPT9Aewdc1ngVep8mhfz8/TgpPZrvW
         /8hA==
X-Gm-Message-State: APjAAAWCWOhe1vW7oaRjvrOEt3dcS9tuqJcPAXgqcLJ41VxnBhQknoxv
        VOzsGOsWK/9bkqQN2TDTtZ4xaQ==
X-Google-Smtp-Source: APXvYqwf629GmUVbhLZnIAU/FAePATiykUd+OC7xErJfaA+0pIRy9XJpSrc4JheBzy9dpn/uP2D0ug==
X-Received: by 2002:a17:902:106:: with SMTP id 6mr23919253plb.64.1560421882686;
        Thu, 13 Jun 2019 03:31:22 -0700 (PDT)
Received: from localhost.localdomain ([117.196.234.139])
        by smtp.gmail.com with ESMTPSA id a12sm2265078pgq.0.2019.06.13.03.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 03:31:21 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 0/7] Introduce TEE based Trusted Keys support
Date:   Thu, 13 Jun 2019 16:00:26 +0530
Message-Id: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add support for TEE based trusted keys where TEE provides the functionality
to seal and unseal trusted keys using hardware unique key. Also, this is
an alternative in case platform doesn't possess a TPM device.

This series also adds some TEE features like:

Patch #1, #2 enables support for registered kernel shared memory with TEE.

Patch #3 enables support for private kernel login method required for
cases like trusted keys where we don't wan't user-space to directly access
TEE service to retrieve trusted key contents.

Rest of the patches from #4 to #7 adds support for TEE based trusted keys.

This patch-set has been tested with OP-TEE based pseudo TA which can be
found here [1].

Looking forward to your valuable feedback/suggestions.

[1] https://github.com/OP-TEE/optee_os/pull/3082

Sumit Garg (7):
  tee: optee: allow kernel pages to register as shm
  tee: enable support to register kernel memory
  tee: add private login method for kernel clients
  KEYS: trusted: Introduce TEE based Trusted Keys
  KEYS: encrypted: Allow TEE based trusted master keys
  doc: keys: Document usage of TEE based Trusted Keys
  MAINTAINERS: Add entry for TEE based Trusted Keys

 Documentation/security/keys/tee-trusted.rst      |  93 +++++
 MAINTAINERS                                      |   9 +
 drivers/tee/optee/call.c                         |   7 +
 drivers/tee/tee_core.c                           |   6 +
 drivers/tee/tee_shm.c                            |  16 +-
 include/keys/tee_trusted.h                       |  84 ++++
 include/keys/trusted-type.h                      |   1 +
 include/linux/tee_drv.h                          |   1 +
 include/uapi/linux/tee.h                         |   2 +
 security/keys/Kconfig                            |   3 +
 security/keys/Makefile                           |   3 +
 security/keys/encrypted-keys/masterkey_trusted.c |  10 +-
 security/keys/tee_trusted.c                      | 506 +++++++++++++++++++++++
 13 files changed, 737 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/security/keys/tee-trusted.rst
 create mode 100644 include/keys/tee_trusted.h
 create mode 100644 security/keys/tee_trusted.c

-- 
2.7.4

