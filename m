Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA56223758
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 10:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgGQIuN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 04:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGQIuL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 04:50:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D295C08C5C0
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jul 2020 01:50:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so5172797pls.5
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jul 2020 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9UVMNFESMGpOpcnnufcmxXWknzXQECyO14zJdWyPEs=;
        b=oGj7xL9T8DZ4pmVR0GplUhLo+kN4Azi9Zel5uh0iTvBae012kqBudaORY1a8+u1e6C
         62atl462gdFJpnZQyqYjiqAgGhPqaHUXDjxLKDHlLFq8h/3sGNUfdXbUekii0Ph8OXgO
         vTb9pezAyP2d+y1m1/fcO0Mxq+iPnFVEHmDKN5dDdvmfRoE8avFPmBXDYAn9tpWZZrnG
         b7NW4t74h8ljI0q1dPNDXqDIf4RUPIzPCBLP9Cd6BBDickHNQdEue8bv6o3EzHR7FuwA
         g2CqkXtrhIGe8AFOT/dxaBmLegZvHLhucTaDyYWD8sRx3kvF44ImCKl0+Z2B5zHeQRdr
         20vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9UVMNFESMGpOpcnnufcmxXWknzXQECyO14zJdWyPEs=;
        b=gbnI9AItBMREiFfXAdQLrTjj+3UE3ZAz99Ud7qBuGKlIklaz1RQQxE06KkHf7syC2K
         jxXojmiPG5DAonOf2D88OQHOyTrRhBmUklvtLMCfdDt3bc4mts/bWCuuw2/dw73c+SNs
         h9mLAYXqN4WpQER8UT0IPFgETArXX22eJC2NHq2gBfazl/joEIETEk+uIsK6GuQoNP7e
         J6/LeCSN/pqWR9Dkrva3VI55Zm1ATP5yXNeQEEVkR2iq3Tl0HwrTYHAGyLBG3q2umYjt
         D+OlWGUYLmIqkHJopRvNY2PSLoHT3ZWdhiNSouBCHqq4Y8RiIoNDkYeWLRbpiKwCrUwD
         sIaA==
X-Gm-Message-State: AOAM531tLX4WFPKrzSIRSL95x7RYY48XKRiSWNinP6phMiGhanCM9+zk
        LGEreyl9WL7GHzafsVdWwsyVemorgkXAzQ==
X-Google-Smtp-Source: ABdhPJz9ouPbblFOc5YYDDnzijV0kOq+DzYZwSpq0mseieFAdz/cz03szfTFsW7evacf8YGrf/Ll9g==
X-Received: by 2002:a17:902:ed02:: with SMTP id b2mr7002360pld.121.1594975810790;
        Fri, 17 Jul 2020 01:50:10 -0700 (PDT)
Received: from debian.flets-east.jp ([2400:2411:502:a100:c84b:19e2:9b53:48bb])
        by smtp.gmail.com with ESMTPSA id f207sm7309364pfa.107.2020.07.17.01.50.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 01:50:09 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahisa.kojima@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: [PATCH v4 0/2] synquacer: add TPM support
Date:   Fri, 17 Jul 2020 17:49:30 +0900
Message-Id: <20200717084932.3449-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This adds support for driving the TPM on Socionext SynQuacer platform
using the driver for a memory mapped TIS frame.

v4:
- add ACPI support
- modify function and structure name

v3:
- prepare new module to handle TPM MMIO access on SynQuacer platform

v2:
- don't use read/write_bytes() to implement read/write16/32 since that uses
  the wrong address

Cc: jarkko.sakkinen@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: ardb@kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: peterhuewe@gmx.de
Cc: jgg@ziepe.ca

Masahisa Kojima (2):
  tpm: tis: add support for MMIO TPM on SynQuacer
  dt-bindings: Add SynQucer TPM MMIO as a trivial device

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 drivers/char/tpm/Kconfig                      |  12 +
 drivers/char/tpm/Makefile                     |   1 +
 drivers/char/tpm/tpm_tis_synquacer.c          | 209 ++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c

-- 
2.20.1

