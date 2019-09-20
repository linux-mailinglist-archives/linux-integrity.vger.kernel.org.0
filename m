Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D64B9737
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Sep 2019 20:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406572AbfITSco (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Sep 2019 14:32:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43464 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406537AbfITSco (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Sep 2019 14:32:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so3555829pld.10
        for <linux-integrity@vger.kernel.org>; Fri, 20 Sep 2019 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K1Q6m0o3+TrafclHgjOHG0m+6H8g+LU5qRKkIG7iGiw=;
        b=bZPJ+MJj4W8vY8l6xGkfhXtDvcDpoReP/i4JS77JX+SNI06w095AMpXFzzT8ok/YiM
         VwRzUSvdshJ2HJ3o3opiTP5QiiJ4+lV0cmNGvHC9A+qFYepUmB1l7WrO336hgGjdM5S+
         FFDjW13AjjpLWUTCkjN4gKOxyAHJSFm5VhCnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K1Q6m0o3+TrafclHgjOHG0m+6H8g+LU5qRKkIG7iGiw=;
        b=q0wmYAnaA16SCQ9rQ2pxqORyzNteKmABPZb+UYNycs4s4k3tuiw7Lwgx2iXfI/Ijsw
         p0+DFLIsyh2PxgcJf1r/vc2Gi/zCG6okOniLE+4N0m8OU1cA5DB7LR+A/Ox+0Ha1j0Yj
         aGPxzq+HDQL2g3aXObCqOYoRXUjJFf93gBg0G4o/IFX68AppWlVMFeD2wHYsEh8mN0gD
         gp83WikFEcmhTfySTARopCgF+dJ9cdpc0JoL9Jy+ST5pEceizSn+CaQhN58DluYsne0N
         CyNqLMYiOvTUDKemfadzX39YXOcpJKcSJV8EDVqPaUPgYnd3bERW1sgbuI6ZLpSxJdqX
         5K1A==
X-Gm-Message-State: APjAAAXGzPCJ56qJUQjBu+EaIl/i04Z4VDnkiPJsRNIu4wonMA/yyUk5
        U9hPEEQBzLf7apLZ6MAx8YfVjg==
X-Google-Smtp-Source: APXvYqzvzD3rJyVm0TQXRuhaZJj7LfE8SNo7+dWhzr3NciMTvCFNYoHvBOwgau3Pt6wWhXbahZSwvQ==
X-Received: by 2002:a17:902:8ec3:: with SMTP id x3mr18476217plo.103.1569004362243;
        Fri, 20 Sep 2019 11:32:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b69sm4436072pfb.132.2019.09.20.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:32:41 -0700 (PDT)
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
Subject: [PATCH v7 0/6] tpm: Add driver for cr50
Date:   Fri, 20 Sep 2019 11:32:34 -0700
Message-Id: <20190920183240.181420-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch series adds support for the H1 secure microcontroller
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

Changes from v6 (https://lkml.kernel.org/r/20190829224110.91103-1-swboyd@chromium.org):
 * Two new patches to cleanup includes and module usage
 * Moved cr50 C file to tpm_tis_spi_cr50.c
 * Used the tpm_tis_spi_mod target approach to make the module work
 * Brought back Kconfig option to allow user to disable cr50 code
 * Rebased to v5.3

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

Stephen Boyd (4):
  tpm: Add a flag to indicate TPM power is managed by firmware
  tpm: tpm_tis_spi: Introduce a flow control callback
  tpm: tpm_tis_spi: Cleanup includes
  tpm: tpm_tis_spi: Drop THIS_MODULE usage from driver struct

 .../bindings/security/tpm/google,cr50.txt     |  19 ++
 drivers/char/tpm/Kconfig                      |   7 +
 drivers/char/tpm/Makefile                     |   4 +-
 drivers/char/tpm/tpm-interface.c              |   8 +-
 drivers/char/tpm/tpm.h                        |   1 +
 drivers/char/tpm/tpm_tis_spi.c                | 143 +++++---
 drivers/char/tpm/tpm_tis_spi.h                |  53 +++
 drivers/char/tpm/tpm_tis_spi_cr50.c           | 321 ++++++++++++++++++
 8 files changed, 498 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 create mode 100644 drivers/char/tpm/tpm_tis_spi.h
 create mode 100644 drivers/char/tpm/tpm_tis_spi_cr50.c


base-commit: 4d856f72c10ecb060868ed10ff1b1453943fc6c8
-- 
Sent by a computer through tubes

