Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E801D1E0DCD
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2020 13:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390169AbgEYLwn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 May 2020 07:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390160AbgEYLwm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 May 2020 07:52:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E13C061A0E
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 04:52:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v16so20473233ljc.8
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 04:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EAb/Fg0BKQ2SLEZWHdKOtDRqYys+prhP5YSWE2/wW08=;
        b=AAegB7qhped/HXBu/QvGmSMBrl5wssFyVxV1rgNEF2QpoXDYbIeJvgMD1VCmAFHYJl
         7Hd3/KdogUfWnQ5ttYGOqnMJV593Y8NX/KEAARakLw8f2YNk6rO8B/qNUCNQuprKoozm
         MSgKFtKH2DZ/iHAhhagSyB6So0yVUbUVpvXU/YzdYkAeYvatzmUpOXcomta996F07AAP
         rNAUuVuwQ7Bs5zmhbMagUhIfcgacL1P9sZIB5x5J8g1tUizryJWIr73h0M8PWaxl8h5b
         xL5nb9CuxNYt3UyP9EnNdiN7Ot/vfdRSCcx9VeImHtdHEoIRodQxigKMeaUQWHVDXdwf
         9aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EAb/Fg0BKQ2SLEZWHdKOtDRqYys+prhP5YSWE2/wW08=;
        b=cLK7bXqlMN0NV/Y1zYNMRva8DMPe1hsAK/0vkzgaA/xMtvWHXer/bsBzvKCJOTzCvA
         jg0NHz4mNR1uQYSs/sh+ElPUiPFDNR3SBjXYXiMIFsuW7XqsQPhR7PPzyPzQrlZrD9hr
         +fUHMAFCoeruBPFv5MRqzhjkUldk25u+V0GD8RLECsWaRsppdNHCR048InyQNykP5+Ji
         pOBQrG5BOnHDSAvyFlUdDZqAJyqwShbfzbSo+EuYlY40cxyMxPu9GNR1C/jPYwfzX1wS
         WUYCiIQ5N83c2pgGeM56plxqxDrpcynpPmMJxToM0hTiokUZZ04TqyuxZViar0mtR8gR
         ubBQ==
X-Gm-Message-State: AOAM531dBurLsARPkphkxvatflaOOl0zWCV3tfNZou3a6fgD30O1ePsy
        Witpb6Q1XsK1RKE14onzichXQQ==
X-Google-Smtp-Source: ABdhPJz4vVBkBbYK5Hebd468+iOG/jumV1UF36/XyP3voWsKxi+q/Nq4Z0xE1HYniZslqjXW8lxJXA==
X-Received: by 2002:a2e:97c2:: with SMTP id m2mr11214486ljj.404.1590407561004;
        Mon, 25 May 2020 04:52:41 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y130sm4847756lfc.22.2020.05.25.04.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 04:52:40 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv3 0/3] optee: register drivers on optee bus
Date:   Mon, 25 May 2020 14:52:32 +0300
Message-Id: <20200525115235.5405-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v3: - support tee-suppicant restart (Jens Wiklander)
    - description and comments ( Jarkko Sakkinen)
    - do not name optee drivers by index in sysfs (Sumit Garg)
v2: - write TEE with capital letters.
    - declare __optee_enumerate_device() as static.

Hello,

This patchset fixes issues with probing() tee, optee and optee driver
if they were compiled into kernel, built as modules or any mixed
combination.
These changes require optee-os changes which already were merged.
Main corresponding commits are:
https://github.com/OP-TEE/optee_os/commit/9389d8030ef198c9d7b8ab7ea8e877e0ace3369d
https://github.com/OP-TEE/optee_os/commit/bc5921cdab538c8ae48422f5ffd600f1cbdd95b2

optee_enumerate_devices() which discovers Trusted Applications on tee
bus is split up on 2 changes. Do probe of drivers which do not require
userspace support of tee-supplicant and stage two to run drivers with
support of tee-supplicant only after tee supplicant run. 

Best regards,
Maxim.
Maxim Uvarov (3):
  optee: do drivers initialization before and after tee-supplicant run
  optee: use uuid for sysfs driver entry
  tpm_ftpm_tee: register driver on TEE bus

 drivers/char/tpm/tpm_ftpm_tee.c   | 70 ++++++++++++++++++++++++++-----
 drivers/tee/optee/core.c          | 28 +++++++++++--
 drivers/tee/optee/device.c        | 23 ++++++----
 drivers/tee/optee/optee_private.h | 10 ++++-
 4 files changed, 108 insertions(+), 23 deletions(-)

-- 
2.17.1

