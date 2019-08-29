Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79CD0A29D7
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 00:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfH2WlN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 18:41:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38026 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfH2WlN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 18:41:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id e11so2369350pga.5
        for <linux-integrity@vger.kernel.org>; Thu, 29 Aug 2019 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6nJOSi4D9t11ZjLGLX1URk37n+Py9rDA9nyBNP0uqE=;
        b=HiTUd/SAL/dMFGev5Pow+VRZ9ogeTuj6uSem+jheeDsY8X00m4GPx9dtJteiRJ5ftV
         N1JEqDZN357B7twtttg+p2lqZTrax6Armpdc0727nQz/JwW4ZbBGuMo6DKFkfNNrB3K9
         1sWt3mInRrjx/9Czgqo/HKnpJktuc6mskEUIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6nJOSi4D9t11ZjLGLX1URk37n+Py9rDA9nyBNP0uqE=;
        b=rgi9lfOu5lWYn9l7pnOcz4oi36b6MXyKFpmd4P9Zv+Sde+AMIwMW6CtNzE32+vNgVk
         WTzSxYHggpXdPG0dUu0+NjyqPNkB+2XoBjIeXJRd4DJ0hKc4d9u7DV6q63CV3uwPmQaL
         Fsoy06zatyT+yXVASIkC/050o6ygac1/Rk1LNiLpN27jwAcloOT6jfviO0ZE2++Ix7kr
         gfLFuPLubFa/P+YLMBUu9/k8wQK1fIpcJ9zPWbpRegsNvkwKYebfrjRW9jH63hHkWVY/
         Vk1K87RNDF1v+j0ejt6noxtHoBhRutj9Rwyd5YgQsNd5V83xs4dh6nD2jIQZn+c82ya7
         I3tw==
X-Gm-Message-State: APjAAAXM4Xor8imdFGCWo7RjisWSKX5a9iaP+/3XBi5YP/EsFG/pdKiJ
        0lUoMt1hcX3OWLV1ibxyLHAINA==
X-Google-Smtp-Source: APXvYqzFZVgQNBqCAAUglNY8AFSmHQvLxrgGkto0HqXqXUOxgYjee1fTFryzutevntEo79cvpRevvw==
X-Received: by 2002:a17:90a:b908:: with SMTP id p8mr12311011pjr.65.1567118472392;
        Thu, 29 Aug 2019 15:41:12 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q8sm3882531pjd.28.2019.08.29.15.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:41:11 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v6 0/4] tpm: Add driver for cr50
Date:   Thu, 29 Aug 2019 15:41:06 -0700
Message-Id: <20190829224110.91103-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch series adds support for the the H1 secure microcontroller
running cr50 firmware found on various recent Chromebooks. This driver
is necessary to boot into a ChromeOS userspace environment. It
implements support for several functions, including TPM-like
functionality over a SPI interface.

The last time this was series sent looks to be [1]. I've looked over the
patches and review comments and tried to address any feedback that
Andrey didn't address (really minor things like newlines). I've reworked
the patches from the last version to layer on top of the existing TPM
TIS SPI implementation in tpm_tis_spi.c. Hopefully this is more
palatable than combining the two drivers together into one file.

Please review so we can get the approach to supporting this device
sorted out.

[1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org

TODO:
 * Add a patch to spit out WARN_ON() when TPM is suspended and some
   kernel code attempts to use it
 * Rework the i2c driver per Alexander's comments on v2

Changes from v5 (https://lkml.kernel.org/r/20190828082150.42194-1-swboyd@chromium.org):
 * Picked up Jarkko's ack/review tags
 * Fixed bug with irqs happening before completion is initialized
 * Dropped is_cr50 bool
 * Moved wake_after to tpm_tis_spi struct
 * Changed authorship of main cr50 patch to Andrey as I'm just shuffling
   code here

Changes from v4 (https://lkml.kernel.org/r/20190812223622.73297-1-swboyd@chromium.org):
 * Dropped the 'pre-transfer' hook patch and added a 'ready' member instead
 * Combined cr50_spi and tpm_tis_spi into one kernel module
 * Introduced a swizzle in tpm_tis_spi probe routine to jump to cr50
   probe path
 * Moved binding to start of the thread
 * Picked up Jarkko reviewed-by tag on new flag for suspend/resume
 * Added a comment to flow control patch indicating what it's all about

Changes from v3:
 * Split out hooks into separate patches
 * Update commit text to not say "libify"
 * Collapse if statement into one for first patch
 * Update commit text on first patch to mention flag
 * Drop TIS_IS_CR50 as it's unused

Changes from v2:
 * Sent khwrng thread patch separately
 * New patch to expose TPM SPI functionality from tpm_tis_spi.c
 * Usage of that new patch in cr50 SPI driver
 * Drop i2c version of cr50 SPI driver for now (will resend later)
 * New patch to add a TPM chip flag indicating TPM shouldn't be reset
   over suspend. Allows us to get rid of the cr50 suspend/resume functions
   that are mostly generic

Changes from v1:
 * Dropped symlink and sysfs patches
 * Removed 'is_suspended' bits
 * Added new patch to freeze khwrng thread
 * Moved binding to google,cr50.txt and added Reviewed-by tag from Rob

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: Heiko Stuebner <heiko@sntech.de>

Andrey Pronin (2):
  dt-bindings: tpm: document properties for cr50
  tpm: tpm_tis_spi: Support cr50 devices

Stephen Boyd (2):
  tpm: Add a flag to indicate TPM power is managed by firmware
  tpm: tpm_tis_spi: Introduce a flow control callback

 .../bindings/security/tpm/google,cr50.txt     |  19 ++
 drivers/char/tpm/Makefile                     |   2 +-
 drivers/char/tpm/cr50_spi.c                   | 321 ++++++++++++++++++
 drivers/char/tpm/tpm-interface.c              |   8 +-
 drivers/char/tpm/tpm.h                        |   1 +
 drivers/char/tpm/tpm_tis_spi.c                | 130 ++++---
 drivers/char/tpm/tpm_tis_spi.h                |  46 +++
 7 files changed, 478 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 create mode 100644 drivers/char/tpm/cr50_spi.c
 create mode 100644 drivers/char/tpm/tpm_tis_spi.h


base-commit: 0ecfebd2b52404ae0c54a878c872bb93363ada36
-- 
Sent by a computer through tubes

