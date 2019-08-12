Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152928AA77
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 00:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfHLWgZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Aug 2019 18:36:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35058 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfHLWgZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Aug 2019 18:36:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so50442146pfn.2
        for <linux-integrity@vger.kernel.org>; Mon, 12 Aug 2019 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6mriydnSdub6NLxi9wqFzvu5hE6ZUJo3BQ8+EaefM4=;
        b=ZRtFtRvm1oV6CJpoQ2JmmiXx4skqxreM/j5Eq1L3u7P6MBUgm98D6eStmtXDzSdAx2
         d0Tztc4qqhTp3f4DyRhQ7LXQvDzFhawgKNNGLy3/oHYyFx/u0l911wkAhjuwi52HkAmP
         VhzhDXCzfRJ9JQbU5ilewfYrPvXB6sZ09Ajek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6mriydnSdub6NLxi9wqFzvu5hE6ZUJo3BQ8+EaefM4=;
        b=heEzUwYeepeyx1mpQ4Cp0gbpbBo41kq7SDiylGJanTy3e2lQlQ7L3bIYR8VytlSz5A
         aosyAzTiD1aH80tPOkeVV0JTuddiHaLY6Ucz710v0Uy2C4aZ8hJ8z5hGvF7TgNmzAaWW
         N5finJmF082bAK/SKlMcDs5gzb4tNPDFAyTlJwFTSsaKz/fFjD8RBsYtC9aoX66PSXmY
         6MYvbUWEL0s+VQ2vbVufP6FFapDNlQAL4qZLjLoNCvTMb07PZRoukfFR7aUlcrFV0cs4
         lvFuIcj0wP1U3Z7nE1S4MGPfMt1GHAikyeCyFLa+u04/iPHsQ2Jck4RPUIUDQWJVZeYv
         JeHA==
X-Gm-Message-State: APjAAAXwScWY19s9gvh41COsWEEXjgsA2la5qNWemJi0CTGCpi7qiPgy
        i9ASjCC6fmu3bS1vToyKy31akw==
X-Google-Smtp-Source: APXvYqzmFOkbH6SBGaWwWz4cygxr9IHT2YmFXmQSOx4uGKqh6XAch5qOBif62M+Lb7U9C95PfCgqJA==
X-Received: by 2002:a63:211c:: with SMTP id h28mr31780020pgh.438.1565649384405;
        Mon, 12 Aug 2019 15:36:24 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b6sm93911594pgq.26.2019.08.12.15.36.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:36:23 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v4 0/6] tpm: Add driver for cr50
Date:   Mon, 12 Aug 2019 15:36:16 -0700
Message-Id: <20190812223622.73297-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
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

[1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org

TODO:
 * Add a patch to spit out WARN_ON() when TPM is suspended and some
   kernel code attempts to use it
 * Rework the i2c driver per Alexander's comments on v2

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

Andrey Pronin (2):
  dt-bindings: tpm: document properties for cr50
  tpm: add driver for cr50 on SPI

Stephen Boyd (4):
  tpm: Add a flag to indicate TPM power is managed by firmware
  tpm: tpm_tis_spi: Introduce a flow control callback
  tpm: tpm_tis_spi: Add a pre-transfer callback
  tpm: tpm_tis_spi: Export functionality to other drivers

 .../bindings/security/tpm/google,cr50.txt     |  19 +
 drivers/char/tpm/Kconfig                      |   9 +
 drivers/char/tpm/Makefile                     |   1 +
 drivers/char/tpm/cr50_spi.c                   | 372 ++++++++++++++++++
 drivers/char/tpm/tpm-interface.c              |   8 +-
 drivers/char/tpm/tpm.h                        |   1 +
 drivers/char/tpm/tpm_tis_spi.c                |  98 +++--
 drivers/char/tpm/tpm_tis_spi.h                |  37 ++
 8 files changed, 502 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 create mode 100644 drivers/char/tpm/cr50_spi.c
 create mode 100644 drivers/char/tpm/tpm_tis_spi.h


base-commit: 0ecfebd2b52404ae0c54a878c872bb93363ada36
prerequisite-patch-id: ce0cac49be5e67df1427e4207cf38c6e31091445
-- 
Sent by a computer through tubes

