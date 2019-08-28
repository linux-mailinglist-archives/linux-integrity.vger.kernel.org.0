Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AC9FCC8
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 10:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfH1IVx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 04:21:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46446 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1IVx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 04:21:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3so1024710pgv.13
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hf45YlPIP8ddQ+9IgXrDwMOTvaQuW/eJTBteOBX/I9Q=;
        b=QarfX3x0RNlBXL5Ags3BPwGvEk2tmhISwqTlgLs+nnJdfUu8v9vBXxkfDrfYh5Vya2
         43ggcvc2Mg3BdWJKUmTultr306gJ7l1jxLSgEWbl0YLd0GQhdtcp08Eq8UP045Ut/ZxD
         gmwm6WnDGUw8iXqz+gmKwdYiT0w/Y19bKqw8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hf45YlPIP8ddQ+9IgXrDwMOTvaQuW/eJTBteOBX/I9Q=;
        b=ELd+ybIWsl9/oE9ZvTDAj1476XfTTZIxUhnY8OkfE0QSUEyh5KFoK8/C7Fu5YpbQJ8
         vJC3gsceC9iQitAHMqtmlw1ZdnYIguLq9sI9P9ks7g2BLWBh6GRM4Vf4Jd6vDl56VDxD
         SswHwSYCyy5lkYpXSoO7VDfMZyq6myvFkQDv4p0wZJzJ0zw4n3iYEzyEbOB3Dll5Ixwf
         qk6Pq8gF4PLAY8MkEd5Q+RFvCy15bkHxHJRC1xvx6jcekbz4NOu02FJCyzWNBpJFbFZK
         34spsZIbpR0ugWGXy4Z/2nEfFJskJd81DXqNzaSJZDdoqdZu/yrI/GGrSHJWL+u6fJe0
         f2rQ==
X-Gm-Message-State: APjAAAUOHC6MsU1qemeto0KKvIvkAonpfFvfYfPNj8PP1Fhk5f86IyWS
        mrvfwu4Iyu0uqRYZh4j7XJOraA==
X-Google-Smtp-Source: APXvYqxCPCA1MOy9GycrKtPgCXdfjpa6uXiu0S0qmGw9WCDhKe6OzRKVoCmqWF8RYpNk1oM4LDzfcw==
X-Received: by 2002:a17:90a:32a3:: with SMTP id l32mr3126610pjb.14.1566980511903;
        Wed, 28 Aug 2019 01:21:51 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y10sm1296959pjp.27.2019.08.28.01.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 01:21:51 -0700 (PDT)
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
Subject: [PATCH v5 0/4] tpm: Add driver for cr50
Date:   Wed, 28 Aug 2019 01:21:46 -0700
Message-Id: <20190828082150.42194-1-swboyd@chromium.org>
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

Note, I wasn't sure exactly what was wanted in v4, so I've combined
the two files but I wasn't able to avoid adding a bool indicating
the phy is cr50 or not, because suspend/resume is a hook that attaches
to the driver and not the device.

Please review so we can get the approach to supporting this device
sorted out.

[1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org

TODO:
 * Add a patch to spit out WARN_ON() when TPM is suspended and some
   kernel code attempts to use it
 * Rework the i2c driver per Alexander's comments on v2

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

Andrey Pronin (1):
  dt-bindings: tpm: document properties for cr50

Stephen Boyd (3):
  tpm: Add a flag to indicate TPM power is managed by firmware
  tpm: tpm_tis_spi: Introduce a flow control callback
  tpm: tpm_tis_spi: Support cr50 devices

 .../bindings/security/tpm/google,cr50.txt     |  19 +
 drivers/char/tpm/Kconfig                      |   7 +
 drivers/char/tpm/Makefile                     |   4 +-
 drivers/char/tpm/cr50_spi.c                   | 327 ++++++++++++++++++
 drivers/char/tpm/tpm-interface.c              |   8 +-
 drivers/char/tpm/tpm.h                        |   1 +
 drivers/char/tpm/tpm_tis_spi.c                | 110 +++---
 drivers/char/tpm/tpm_tis_spi.h                |  54 +++
 8 files changed, 486 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 create mode 100644 drivers/char/tpm/cr50_spi.c
 create mode 100644 drivers/char/tpm/tpm_tis_spi.h


base-commit: 0ecfebd2b52404ae0c54a878c872bb93363ada36
-- 
Sent by a computer through tubes

