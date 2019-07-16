Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A306B1FB
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 00:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfGPWpV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 18:45:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43058 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbfGPWpV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 18:45:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so3899527pld.10
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmlUiz5MsLUASaCZMmjAe5Nq25BIWTu0nIyWKoUI4ls=;
        b=d9ye7oSxzBqYGdQCWjx3eR4Fyl6C15u7RitgZrZD/iXkRtQtT+Z0Rt9BZQTaI/aFok
         UTImGu1WaCEkeRWjY2h3axeBkKknI70MK2jnBH8sQcDqtZKCIn67xsizSU6cQjz/a9pM
         sQT2nHbXtCBHL+8nQmAyck5ee7/uJtKaL0mQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmlUiz5MsLUASaCZMmjAe5Nq25BIWTu0nIyWKoUI4ls=;
        b=eZTAJEZ5Y3RrYEDhfAyxjh+3f1gZS15EEEIlOnHZpAfvc91fx52XHPtncNhuopOt6k
         ZqTQncMU0vyPxaKBXgwhG/4O/sUlCm78+reyAzdUdUrZkdVCQTFh5pMqbQbRcBlIPw6d
         FD1TbuTRdb63Qqn0DiKu+20wgdsKd8h7NZIe8f9bHgsoig0nOQu5TnRu8nqDMZIL6QQK
         oclJTkFLE5jceu+b5PwfPMnvZiIpH0te97mpLHUW70vhe+m5DPbqgCpViKKHCIfLsGTH
         eb/+RafO1iju6DOd6ZATqnUZ/0q0Fr+D0Tdbu+9k9QDtQAj0sn/DQOCKW30a7LjbRZsR
         SgyA==
X-Gm-Message-State: APjAAAV1I6+miaclfjYY7TZk3dR1ug8rRRsh5m7IzE8g6WImFW88RWZ4
        /tIeRH1pJI4I4D2RlzI708MviA==
X-Google-Smtp-Source: APXvYqzU5gux6ISRcXCpIgf4jpzMJipCJqvczwYbpekKH6PlWvdVfY1o60VXcLz8sbKM8Y64Kyiejw==
X-Received: by 2002:a17:902:8d97:: with SMTP id v23mr37704806plo.157.1563317120399;
        Tue, 16 Jul 2019 15:45:20 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 64sm22182562pfe.128.2019.07.16.15.45.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:45:19 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 0/6] tpm: Add driver for cr50
Date:   Tue, 16 Jul 2019 15:45:12 -0700
Message-Id: <20190716224518.62556-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
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
functionality, and supports SPI and I2C interfaces.

The last time this was series sent looks to be [1]. I've looked over the
patches and review comments and tried to address any feedback that
Andrey didn't address (really minor things like newlines). The first
three patches add a couple pre-requisite core changes so that the
drivers can be merged. The last three patches add the SPI and i2c drivers
along with the DT binding.

[1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org

Changes from v1:
 * Dropped symlink and sysfs patches
 * Removed 'is_suspended' bits
 * Added new patch to freeze khwrng thread
 * Moved binding to google,cr50.txt and added Reviewed-by tag from Rob

Andrey Pronin (4):
  tpm_tis_core: add optional max xfer size check
  tpm_tis_spi: add max xfer size
  dt-bindings: tpm: document properties for cr50
  tpm: add driver for cr50 on SPI

Duncan Laurie (1):
  tpm: Add driver for cr50 on I2C

Stephen Boyd (1):
  hwrng: core: Freeze khwrng thread during suspend

 .../bindings/security/tpm/google,cr50.txt     |  19 +
 drivers/char/hw_random/core.c                 |   5 +-
 drivers/char/tpm/Kconfig                      |  26 +
 drivers/char/tpm/Makefile                     |   3 +
 drivers/char/tpm/cr50.c                       |  33 +
 drivers/char/tpm/cr50.h                       |  15 +
 drivers/char/tpm/cr50_i2c.c                   | 705 ++++++++++++++++++
 drivers/char/tpm/cr50_spi.c                   | 450 +++++++++++
 drivers/char/tpm/tpm_tis_core.c               |   9 +-
 drivers/char/tpm/tpm_tis_core.h               |   1 +
 drivers/char/tpm/tpm_tis_spi.c                |   1 +
 11 files changed, 1265 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 create mode 100644 drivers/char/tpm/cr50.c
 create mode 100644 drivers/char/tpm/cr50.h
 create mode 100644 drivers/char/tpm/cr50_i2c.c
 create mode 100644 drivers/char/tpm/cr50_spi.c


base-commit: 0ecfebd2b52404ae0c54a878c872bb93363ada36
-- 
Sent by a computer through tubes

