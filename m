Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF2A1DC724
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2020 08:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgEUGry (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 May 2020 02:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgEUGrw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 May 2020 02:47:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C614C061A0E
        for <linux-integrity@vger.kernel.org>; Wed, 20 May 2020 23:47:51 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z18so6883147lji.12
        for <linux-integrity@vger.kernel.org>; Wed, 20 May 2020 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/V4uURW0jRfKsNYalJYuMTZMvO7QgRZlAwqGceY/IXQ=;
        b=p3kRQ9466W7CRtzT5rKWiDR0bYSrvXpkrurxn66c/TW2Y6hBhQKg6cSzWj3FX/O5wI
         r7z7N/j3TSpcAf+XKXafQ+O0ZlWILWxzt5F1LhWdhVFPLNXWWUTkASHdLLDxI34PDcXN
         N8uvVM8i9ShVpf5iCd8hLFnNw17mZ5diPVi8jdxZNl1AXYkY65WReT806uGaQFHaSOT2
         mM4esed/wcGVQ8RwVuP4SupRJnIrJgQ+mliGLwNY8f4KuKQcp//5jSSUerbaaBA7vJV3
         xw4XRv/inC34LfhEVN1v3Ie/u56RWkw3I+7V1QXmvX7mGhs4UqVlB1Q1Wz8WK73wzaOg
         Dx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/V4uURW0jRfKsNYalJYuMTZMvO7QgRZlAwqGceY/IXQ=;
        b=FrMZu5AsSVIJuB4xor1002aI4ZzKgJz9eMDAShWN9UIpeNJtpQ9X9HHSKuSRGnPW/G
         GjsxQveuSYo0XmN+8lLKwoLrMS+Xmny+q5iFBSsywzaSE7+VR6jyjviVNYcYzYbTpFUS
         b4kjxcDD6G/KPZsPKiSlUjVfbrGMl+6VUo7CARdgSq7pjuPIYaXioQOVWvF2eaCcTSJD
         lmr451wIcOAO22pLQqTfsvNnQFLyrs6J2NuLtg81jCoHFKFlNkmDBmu7cU+vWQsuRt5Y
         /LniC/LdqSes5VAbosI3eAGM2Gd5/bxReqb90QhwbrTyS4vyu/SRdX43Vwk1lZxBW4BH
         UogA==
X-Gm-Message-State: AOAM530L6l3XO5gRQU2qcnjeXTFPuXP6NKGwrs5CBY5q+u2bRx+nStUk
        vf43eQdvSh7d8RMQM7Eg6ZOdGw==
X-Google-Smtp-Source: ABdhPJzXP8sZI9ePaKgxk/a4v5VzxugkjKQVLdzSYb1AU9K7dMCNh6rLNHnLjpFiiuPEPZ8Jb969KA==
X-Received: by 2002:a2e:980d:: with SMTP id a13mr4515140ljj.277.1590043669208;
        Wed, 20 May 2020 23:47:49 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id z16sm1807465lfq.18.2020.05.20.23.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 23:47:48 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv2 0/2] optee: register drivers on optee bus
Date:   Thu, 21 May 2020 09:47:40 +0300
Message-Id: <20200521064743.4769-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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

Maxim Uvarov (2):
  optee: do drivers initialization before and after tee-supplicant run
  tpm_ftpm_tee: register driver on TEE bus

 drivers/char/tpm/tpm_ftpm_tee.c   | 69 ++++++++++++++++++++++++++-----
 drivers/tee/optee/core.c          | 25 +++++++++--
 drivers/tee/optee/device.c        | 17 +++++---
 drivers/tee/optee/optee_private.h |  8 +++-
 4 files changed, 99 insertions(+), 20 deletions(-)

-- 
2.17.1

