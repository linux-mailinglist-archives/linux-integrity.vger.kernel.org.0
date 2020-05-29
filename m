Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B271E7849
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2020 10:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgE2I1W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 May 2020 04:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2I1V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 May 2020 04:27:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0633C03E969
        for <linux-integrity@vger.kernel.org>; Fri, 29 May 2020 01:27:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q2so1520700ljm.10
        for <linux-integrity@vger.kernel.org>; Fri, 29 May 2020 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6UQE/mAll7rVLi4VPpwEHXC2IWoXCtROl3EiNZAwRO8=;
        b=ycDzMQmtIxL6lDpp2m41RyTEW9DhzxlEQ9V9CAN9TJSEoRHJbfO+a3f7d9qf+hHNS4
         Kj0KHIttMZI+Ag5l5vPWNv22AIBkAPezJI4Xs8zJWnZwuBHtoj0nxyFiwfGTwVO4Gx7Z
         KSWUi4ruriRjaOsX7/QZbGC7JttB4VHY1U3OJERz07RVI7XBdkiqCe5N8idYvMfqnd/f
         U1VdfT2SuGsi/mOL8p4NEghCog50AkMCEEOWLmUCB1KWUMYJYiHS98pQQjgM/RpENbQo
         MM3wl4DT1UN2g6OjL+JVxa+uaVYP9f/c1ta3U91avAxHQTOomHOffmDovRTcjvd+pkb0
         0PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6UQE/mAll7rVLi4VPpwEHXC2IWoXCtROl3EiNZAwRO8=;
        b=W8bQpXbuW3CZN3nezTTYqhzVmsFpA1k+QoRgcEff3rthYoAOVV1MbewLdN7uatZjx/
         V+kVmv2hT3+8GrWMzvPXvRmNwzjruVw47Vv97r+PeyV1NcI4lLXwcf3mYtnBDWnZ16hJ
         4DyUoI2ITFs6RvzLWoNsmbeEFhrDADbht1S8pZMbT/n8Zc2Y8V9/usK3hhh7BAoCeOQi
         gQ9GbZwltOSqhImiZKpR1/h1G8mCd5r5dFQp1LMYCdMie7QIams3kJnHpnl0RmfNkNww
         vhTIK/ewEesDefu808Qfd8dXYbrWNkKpUqVOANNCy37DPp9RX1x1Omb9zIp6PIiDiIfO
         tTVA==
X-Gm-Message-State: AOAM532TJpAo2KKgVP3Oy2cnWqt72GX/bom9qgoPud+0ANEzbzNtSJeG
        /65s34rLVjrrujQ/5bY1bsjZJw==
X-Google-Smtp-Source: ABdhPJwsoCOWGqkz3zk1Bc8knROHTezUnpe/8krWFSr26/RAH/a/Nb7QCfBniy0JZx6gbS+Mn08Y9w==
X-Received: by 2002:a2e:750d:: with SMTP id q13mr185328ljc.448.1590740839237;
        Fri, 29 May 2020 01:27:19 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y20sm1878450lji.31.2020.05.29.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:27:18 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv5 0/3] optee: register drivers on optee bus
Date:   Fri, 29 May 2020 11:26:58 +0300
Message-Id: <20200529082701.13457-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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
  optee: do drivers initialization before and after tee-supplicant run
  optee: use uuid for sysfs driver entry
  tpm_ftpm_tee: register driver on TEE bus

 .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
 MAINTAINERS                                   |  2 +
 drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
 drivers/tee/optee/core.c                      | 24 ++++++-
 drivers/tee/optee/device.c                    | 23 +++---
 drivers/tee/optee/optee_private.h             | 10 ++-
 6 files changed, 114 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

-- 
2.17.1

