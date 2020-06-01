Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C15F1EA67C
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 17:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgFAPGy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jun 2020 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAPGw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 11:06:52 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD205C05BD43
        for <linux-integrity@vger.kernel.org>; Mon,  1 Jun 2020 08:06:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so8553563ljn.4
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jun 2020 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iEiCGCNKaMD66MoJP2AKpqHacUaAH/f4s3pzlpCGMA=;
        b=r4/Jk/X+0VvbIMxP/4r3ZkaHk+4qEhVzKfvsmthnaW5EG6bGAaAYDKViYPjasM7+hp
         +LREw9CTHY3kFBirnbPdSHDlGGz37FczAcmAuZtaLsBPMsmhSfxF03449Bj206wYmoD5
         ON3ZaxlwEd8Od4Np84t5Nek8dGUNq+pWyrjSuZ5aZ6grIVPAj+ovpi79eKMcqSiihC3E
         rz2SgayRAxeWmzyjlay2vIvvv4gm5ZXbyicBfu6DsjYy+4qUb9YUAvBMORMVVUO5Od3q
         HMekSr9GG5F3EoT04oHaQ6k5rDxuliCT0gHx63OSoIj7caObWjATkcN5XP+gZ8KbP1Ey
         8dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iEiCGCNKaMD66MoJP2AKpqHacUaAH/f4s3pzlpCGMA=;
        b=LHwCCFL6K5o5WQ6Vbko7F5CyZJVs+j2+puwHDrSuIAubLhzqXymnHNQ8toZH8NIsVs
         9nt80jLLjAgc1aBOlKXLfdLjbczMT59yQmhvMtpst4RBebsUxXJ+Qf9dRIVYWefLdZp7
         ocUf4UgF/FAXrqYCp5jdHIon1zTIglsZv4s9+4ImGJm8Zoa+WSXQukTrR6Ud89pReksE
         eTOY84ybfbK255Z7Gy4dzj7wotroZyJDfzthV5plOe1TtpR2Qlju9/5XfOLxM+Oe6jp5
         zhhgvffB7Qv1UypcH06m3zW/uHJD1G5z3rx7TJYtcoCbaG7qt+ARAmcBipFizvbvwAiQ
         JcFA==
X-Gm-Message-State: AOAM531F7lELh/iI7x1bzec4Aj+frpz6dsoAWsyONcCim3VS2nfPFPUn
        vDUU9kGJmpTIGNlJ0U3ljC+ZZw==
X-Google-Smtp-Source: ABdhPJwOHMPCl3serLF/OAt9lba4jibjP+pGWaqQCn8CWSPIszFALsIPYi50qEeWwNyiba6Z23Cxlg==
X-Received: by 2002:a2e:2e0b:: with SMTP id u11mr8624018lju.281.1591024010195;
        Mon, 01 Jun 2020 08:06:50 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id q15sm4823537lfc.44.2020.06.01.08.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:06:49 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv6 0/3] optee: register drivers on optee bus
Date:   Mon,  1 Jun 2020 18:06:42 +0300
Message-Id: <20200601150645.13412-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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

 .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
 MAINTAINERS                                   |  1 +
 drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
 drivers/tee/optee/core.c                      | 27 ++++++-
 drivers/tee/optee/device.c                    | 35 ++++------
 drivers/tee/optee/optee_private.h             | 10 ++-
 6 files changed, 116 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

-- 
2.17.1

