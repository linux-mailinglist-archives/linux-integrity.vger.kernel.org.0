Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B461D79F2
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2020 15:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgERNfJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 May 2020 09:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgERNfI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 May 2020 09:35:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A811C061A0C
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2020 06:35:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u6so9868536ljl.6
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2020 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TJEmqH8moaId2d4jgjNtmZXM7aLHVUBuzHkgd4v5uTQ=;
        b=EFc1O+IjhL0SP1/08apU2IJjGo2zoURwB7EpGcYfnpzaNYLxDBq5IGfAAYnW/uj1wa
         fdaaRESpTSmfECFJ0MgCWBPbFms4nyn50bZcaNU8MXSJ6Ui1dRNN1c0nHyo4LK7TDDsi
         wAMqRpL1/XM9rurVOKhmQm6Av/KRCxTt8R9Y54hqodFdFYwpX/Ksq7K113FJj2YnW/UI
         /bEnF3r8nCw32yJyKmoZVrFUudGUibpnkLNoYL3Roz5liry/239WuQUVCjFSTXWSq+RB
         Uj5O+VGJD7rRXiB2mz5Lf2fsJ1rcd1duMuczxTXbMoE55TVohz9aZMnGDxFPBD8uFznf
         ER/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TJEmqH8moaId2d4jgjNtmZXM7aLHVUBuzHkgd4v5uTQ=;
        b=lgZkdKR53mqzFAPGjdDKDmsNQN2RFJJn70z9OvOiWfy5BsWOXmaixJOU4Co2F230Uj
         25XVdUsFRLLYCXNeVBgywvtACT9wF6vGl45ZkJWTlAAu2xRPtUZXD4WajukRGgYmwBx0
         /QO0y1DDZgMbuHrlDqdORUv2yuPzxksIi/DD0oXhRiM6tA2QdL/Bc782Gaa443yh6jrH
         t6VRfm7chUJcqfrFeApB2h8Y2YkbP8ydf2SkJ9kijYfhwU/1ZaH6JIwZNpIM6JQh8JHM
         XsOC2Yrai2GOKdGQpaID0sS08wFjPt4tClCUvlCJRCTvKTnZnYi50Jz+aUtdE0ZAv2no
         JsmA==
X-Gm-Message-State: AOAM531nhLWGXpb7RQea8yc2eTNcAwwJv/UgrWu8zsyhHiPzjlOVnqS9
        eilD4fGhKQGi0Y7y3S7Yf+LhEw==
X-Google-Smtp-Source: ABdhPJzWPVMIjZuoi38Jtq2nlQdFddOvGFN0zc5c7R2qW5AFMCqDojyJ63Se3mFm1ug65K7K+JZ/Jw==
X-Received: by 2002:a2e:2241:: with SMTP id i62mr10326881lji.13.1589808904951;
        Mon, 18 May 2020 06:35:04 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id w20sm1370439lfk.56.2020.05.18.06.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:35:03 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCH 0/2] optee: register drivers on optee bus
Date:   Mon, 18 May 2020 16:34:57 +0300
Message-Id: <20200518133459.28019-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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
  tpm_ftpm_tee: register driver on tee bus

 drivers/char/tpm/tpm_ftpm_tee.c   | 69 ++++++++++++++++++++++++++-----
 drivers/tee/optee/core.c          | 25 +++++++++--
 drivers/tee/optee/device.c        | 17 +++++---
 drivers/tee/optee/optee_private.h |  8 +++-
 4 files changed, 99 insertions(+), 20 deletions(-)

-- 
2.17.1

