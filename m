Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4741FF3EE
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 15:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgFRNw7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 09:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgFRNw4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 09:52:56 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30267C06174E
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 06:52:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y11so7325639ljm.9
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qj3LT34tWN51iOOJ4mJdNrdJmQibtyKe/xjeI2mJQFQ=;
        b=ulPrDM6YGm23/CCKuij/YFME1OgWjz12T6he4JmOYnNTklxP5k0EmK7cZUyaC8YxAq
         6TdEyDL8Zl9bypcF0DRwnjAHwopEollw/H01rMgntDUrVjSJx/qn3QNhKz3G21klYbc/
         eXbBH48QAoP4DCvhacxL2wrSU1HLQxd8auFqTIiYBTackiw9ZW7XsvbIS1kGLFpFqRAN
         6MpjGkyG3MwxuWuURobYFu6lYztOye341rdgyq4i9GcxQEdv8Rf+OxrYDP+ZIIDPIlz0
         w1l/c2bSUQ0kH46r7qElgSjh89MhYQhQlF0y1MR6SCQeOe8YmIfHeerIb4dNTROeVIeY
         EMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qj3LT34tWN51iOOJ4mJdNrdJmQibtyKe/xjeI2mJQFQ=;
        b=jS/wDLyrfNYGqxfC4py80k/mplcIUIbaQMLBOmkDg+WaOyKP9lpR9t19Zf+n2TOios
         vlo0lvono/gSorhVzMBA+TLlkwONonfIwj03SKmcp1sjackdhfn3dXaAU2L6cr4Ez0Zn
         oPpLV6crV2oktZn2BVh7yuZ36oNIKYQJUf8z8hrwmkdPBtVRW2PEZL94ZZWwXbL4uBwl
         AUf0jJd7EjQWGBn6G0hwWTiKmHk4lLWUDpal7yTW2OQ/63jUGPl8JtOTYHZ0V3FILICs
         yAilKmaU1ZXkr+kfszmOndwA/QyjcQgaI980xZWBGPepg786z4BbbOrjgiHMrrcG3kaz
         F+eA==
X-Gm-Message-State: AOAM532R3a0Wv7zJ2yOZOIHS4ydLazR4Bf6i3UIqP/qeYU1PZaiet3Oy
        ApFAh8TR3PWGjSuaGahuDlSEug==
X-Google-Smtp-Source: ABdhPJwaMJiel+UnL81pH7RKKu0ZzlHkyaNhB0u/XhfY7cznaMGmnZfRuXmOYmLSbjrorIzuICtysQ==
X-Received: by 2002:a2e:b0c3:: with SMTP id g3mr2326087ljl.31.1592488374584;
        Thu, 18 Jun 2020 06:52:54 -0700 (PDT)
Received: from maximlap.d-systems.local ([185.75.190.112])
        by smtp.gmail.com with ESMTPSA id f2sm768324lfc.11.2020.06.18.06.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:52:54 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 0/3] optee: register drivers on optee bus
Date:   Thu, 18 Jun 2020 16:52:48 +0300
Message-Id: <20200618135251.5761-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v9: - new mailing list in Docs, update kernel version (Jens Wiklander)
    - use Big Endian format to print UUID (Sumit Garg)
v8: - fix v7 check.
v7: - check return value of dev_set_name() (Jarkko Sakkinen)
v6: - description, comments, patches reorder and destroy workqueue (Sumit Garg)
v5: - removed pr_err and fix typos in description (Jarkko Sakkinen)
    - added missed kfree in optee_open()
v4: - sysfs entry is optee-ta-uuid (Jerome Forissier, Sumit Garg)
    - added Documentation/ABI/testing/sysfs-bus-optee-devices (Greg Kroah-Hartman)
v3: - support tee-suppicant restart (Jens Wiklander)
    - description and comments (Jarkko Sakkinen)
    - do not name optee drivers by index in sysfs (Sumit Garg)
v2: - write TEE with capital letters.
    - declare __optee_enumerate_device() as static.

Maxim Uvarov (3):
  optee: use uuid for sysfs driver entry
  optee: enable support for multi-stage bus enumeration
  tpm_ftpm_tee: register driver on TEE bus
Maxim Uvarov (3):
  optee: use uuid for sysfs driver entry
  optee: enable support for multi-stage bus enumeration
  tpm_ftpm_tee: register driver on TEE bus

 .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
 MAINTAINERS                                   |  1 +
 drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
 drivers/tee/optee/core.c                      | 27 ++++++-
 drivers/tee/optee/device.c                    | 38 +++++-----
 drivers/tee/optee/optee_private.h             | 10 ++-
 6 files changed, 119 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

-- 
2.17.1

