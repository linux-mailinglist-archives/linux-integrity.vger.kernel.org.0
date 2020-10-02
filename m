Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB45281971
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Oct 2020 19:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbgJBRii (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Oct 2020 13:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388335AbgJBRih (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311B7C0613AB
        for <linux-integrity@vger.kernel.org>; Fri,  2 Oct 2020 10:38:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h23so1220741pjv.5
        for <linux-integrity@vger.kernel.org>; Fri, 02 Oct 2020 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49NcK3Fme0jYUKwd2j3ovAlb1goyRmSbkHCdODdIeDc=;
        b=B2AcK2G2Zh3IWqw0qnXXSEyovKhS81QCGmrhMZ3ce/zFAH8Sg5udPHdnENJ50X13Ny
         mEJHMqIwsp/h8jMADbLs/i5ewGbAbYqXGdprV6QTunJ845w4WHhNz8T8QGab64x5e6+Q
         YLHO8obovOngL6OSrlrGgaARlZ7WxNMPSsEac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49NcK3Fme0jYUKwd2j3ovAlb1goyRmSbkHCdODdIeDc=;
        b=Cq6nG8kJjqkd3YsvUjCbt1UXfYsV7EClcs35Mm47QOji0ji2ADQpTnUz0o9yuJK8AJ
         pmReLFhobSkHasDR0cNR2Pk1f3WcOQY/L2K2V20uZelCfT9AviNV4LJvjCaH0YVmBRpB
         pGgTXxeoMWqOpgMJ2HsvwA2jtFhl9XFMipQU/kEcTciZxa6GvOEQGubckQON9H6PEEGl
         ZjaVjBOR7vHAj+P5Wp/jBUVl1eYLwWLG1BCbI7GGLB7kERUqANd2v8vAQNr+BzSTl8H4
         VN6N50g/j3IZzoaqkKyWax39GCLnNXCfXcXtC+QngOutm1ernqjyf7+9UoQs4/GsyhRM
         32Og==
X-Gm-Message-State: AOAM533d4pyf1+NnoP2WTLQ8pMKxyUojaXZOB5RMf2+gEwN737X30CJ0
        pDWsEsQLUsqDe/4/qiJ2gWPzFg==
X-Google-Smtp-Source: ABdhPJzd49fqaj3jNCPJ5+x9jDSGu4Py3vop91Y7k3rEOOPzUXlaVdJLNBBHCW5hBUb3EGuK0nLHtQ==
X-Received: by 2002:a17:90a:71c2:: with SMTP id m2mr4004540pjs.34.1601660315767;
        Fri, 02 Oct 2020 10:38:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q65sm2660305pfq.219.2020.10.02.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/16] Introduce partial kernel_read_file() support
Date:   Fri,  2 Oct 2020 10:38:12 -0700
Message-Id: <20201002173828.2099543-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v5:
- add more reviews (thank you!)
- add "description" string to post_load_data API (mimi)
- drop bug fix that got taken already
v4: https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/20200724213640.389191-1-keescook@chromium.org/
v2: lost to the ether
v1: https://lore.kernel.org/lkml/20200717174309.1164575-1-keescook@chromium.org/

Hi,

Here's my tree for adding partial read support in kernel_read_file(),
which fixes a number of issues along the way. It's got Scott's firmware
and IMA patches ported and everything tests cleanly for me (even with
CONFIG_IMA_APPRAISE=y), and now appears to pass 0day. :)

The intention is for this to go via Greg's tree since Scott's driver
code will depend on it.

Thanks,

-Kees

Kees Cook (12):
  fs/kernel_read_file: Remove FIRMWARE_PREALLOC_BUFFER enum
  fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
  fs/kernel_read_file: Split into separate source file
  fs/kernel_read_file: Remove redundant size argument
  fs/kernel_read_file: Switch buffer size arg to size_t
  fs/kernel_read_file: Add file_size output argument
  LSM: Introduce kernel_post_load_data() hook
  firmware_loader: Use security_post_load_data()
  module: Call security_kernel_post_load_data()
  LSM: Add "contents" flag to kernel_read_file hook
  fs/kernel_file_read: Add "offset" arg for partial reads
  firmware: Store opt_flags in fw_priv

Scott Branden (4):
  fs/kernel_read_file: Split into separate include file
  IMA: Add support for file reads without contents
  firmware: Add request_partial_firmware_into_buf()
  test_firmware: Test partial read support

 drivers/base/firmware_loader/fallback.c       |  19 +-
 drivers/base/firmware_loader/fallback.h       |   5 +-
 .../base/firmware_loader/fallback_platform.c  |  12 +-
 drivers/base/firmware_loader/firmware.h       |   7 +-
 drivers/base/firmware_loader/main.c           | 135 ++++++++++---
 fs/Makefile                                   |   3 +-
 fs/exec.c                                     | 132 +-----------
 fs/kernel_read_file.c                         | 189 ++++++++++++++++++
 include/linux/firmware.h                      |  12 ++
 include/linux/fs.h                            |  39 ----
 include/linux/ima.h                           |  20 +-
 include/linux/kernel_read_file.h              |  55 +++++
 include/linux/lsm_hook_defs.h                 |   6 +-
 include/linux/lsm_hooks.h                     |  13 ++
 include/linux/security.h                      |  21 +-
 kernel/kexec.c                                |   2 +-
 kernel/kexec_file.c                           |  19 +-
 kernel/module.c                               |  24 ++-
 lib/test_firmware.c                           | 154 ++++++++++++--
 security/integrity/digsig.c                   |   8 +-
 security/integrity/ima/ima_fs.c               |  10 +-
 security/integrity/ima/ima_main.c             |  73 +++++--
 security/integrity/ima/ima_policy.c           |   1 +
 security/loadpin/loadpin.c                    |  17 +-
 security/security.c                           |  28 ++-
 security/selinux/hooks.c                      |   8 +-
 .../selftests/firmware/fw_filesystem.sh       |  91 +++++++++
 27 files changed, 807 insertions(+), 296 deletions(-)
 create mode 100644 fs/kernel_read_file.c
 create mode 100644 include/linux/kernel_read_file.h

-- 
2.25.1

