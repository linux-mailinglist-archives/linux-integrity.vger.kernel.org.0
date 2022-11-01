Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD3614302
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 03:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKACE3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Oct 2022 22:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKACE3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Oct 2022 22:04:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234AC2BCD
        for <linux-integrity@vger.kernel.org>; Mon, 31 Oct 2022 19:04:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b2so21850287lfp.6
        for <linux-integrity@vger.kernel.org>; Mon, 31 Oct 2022 19:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XnWPXPy8fDCwsE9klqtEPx8NZUiyCRwYOkzrkUocKhk=;
        b=eowQ5ZJWhE+2nJtdAIj91j3f63C8uvMGr3c3LBD30hQSEZUpfNQmvdVRwM7TmY96kj
         PuLFbJVvUvBkKeNn+u6KQyAvtH9kxpXzH/SwDKXG54a6K3ntjDjwQ+ydqDJxTCeLZWap
         GLW8wbiP06bz7u71FZWmCk7t9EfTfo7nYaYcD7PZVxeNyU2kMdzihzJvgkBHspvp8abc
         MsvkPAucvCKX+LBX0PAKyg/KYb2WfDyUDxUnVis7jhQGl+7DlpzlwLV9rEGLcAkmQP22
         1P/ejbAXlEAr/K9/uxD9kRzudExmqEClLt5zbfBKleCHIlykpCRvJjcwgvomM9x7DJXw
         j5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnWPXPy8fDCwsE9klqtEPx8NZUiyCRwYOkzrkUocKhk=;
        b=pPRzhCtotfCQXZk7Y8l8QMqOUDUcYjdpyVrzGrxA2Tb46jS5r7vNCuDtMHPEBsknN1
         Dy2FfWKv8uV5whkXXWGNrEbKyfOCSO5BxTbVSXyAAgPHjX0g3sWCH4aI05IdVP1e1oYH
         4L3bWaEN2C3VGTU0PfDbT22T0ZB5Z5QQGGM2wT7CY5EAuEpZG4ptaE1Kt2U481EarUO/
         vGxbTtMFtZJ+hVY/BASjUzZpLb8Bn5GyGHf6OiaexL95G1nIEFsktISpxSv2FQS1jJrD
         ufS3EV636+BfWgDZ6z5RaoKPJUG0Lhip8ZeeNIZuLOpuYIdDpS23VZ2XR1P2HaKLab9z
         wpaw==
X-Gm-Message-State: ACrzQf3blGMdbFazCfWhbw9Sv6Jw/OSqAtc/e5DQ+yR3aIkLm5gjOUoX
        qZxQJWMvEjWQtnPTxiy5kUlukm+DkRSoGV5N
X-Google-Smtp-Source: AMsMyM6EEznrk8YEX4L4ga+puECA9eWpo5kKhW8R5ap1plKgotW0sW2XRmrj9M3G1Nj2k0saJ7anbg==
X-Received: by 2002:a05:6512:31d3:b0:4a2:5c39:d446 with SMTP id j19-20020a05651231d300b004a25c39d446mr7084138lfe.591.1667268266088;
        Mon, 31 Oct 2022 19:04:26 -0700 (PDT)
Received: from dabros-l.roam.corp.google.com ([185.157.14.92])
        by smtp.gmail.com with ESMTPSA id k11-20020ac257cb000000b00494942bec60sm1508799lfo.17.2022.10.31.19.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 19:04:25 -0700 (PDT)
From:   Jan Dabros <jsd@semihalf.com>
To:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rrangel@chromium.org, timvp@google.com, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com, jsd@semihalf.com
Subject: [PATCH 0/3] char: tpm: Adjust cr50_i2c locking mechanism
Date:   Tue,  1 Nov 2022 03:03:49 +0100
Message-Id: <20221101020352.939691-1-jsd@semihalf.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patchset aims to add support for a platforms with cr50(tpm) i2c
chip shared across two CPUs. We need to provide a mechanism, which will
allow to synchronize accesses on a TPM-transaction boundaries.

First commit in a patchset is a generic fix for an issue encountered
during suspend stress test.

Next two patches are modifying cr50 to use generic callbacks for
locality management and then leverage this solution to apply i2c bus
locking on a TPM-operation level.

Jan Dabros (3):
  char: tpm: Protect tpm_pm_suspend with locks
  char: tpm: cr50: Use generic request/relinquish locality ops
  char: tpm: cr50: Move i2c locking to request/relinquish locality ops

 drivers/char/tpm/tpm-interface.c    |   5 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 118 +++++++++++++++++-----------
 2 files changed, 75 insertions(+), 48 deletions(-)

-- 
2.38.1.273.g43a17bfeac-goog

