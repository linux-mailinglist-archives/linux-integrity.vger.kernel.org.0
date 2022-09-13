Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CF85B6A5A
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiIMJKp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 05:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiIMJKk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 05:10:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4109D56BB8;
        Tue, 13 Sep 2022 02:10:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l10so11161206plb.10;
        Tue, 13 Sep 2022 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=ZnvQVruhJU/h5Yds13DXPknO7AFmnymrR0Gd+hkc3sY=;
        b=PB3GF1ut/xatBBMpC9/2RrfMPK51CmgxDjx5hn4dMV65Hr+OlBoTBaZzGwCsBK4TA0
         NyFr7K0DldDLJ1yDRCRz5/rb0pGvKCAsIn4mrhkNPOPAJSJrZahWH/dV0nN7/sfykNC3
         icfnQUHtPQiOOejW0EKRUOi2JP8yVWtbqBAhrgpZSQ2lKeH1dSvugKRcppkZoJL0WxNI
         wOnmx/AuZPl2gdhmmLHCJFr8PkV2mejYu2ar7LWkaOSm1xx1X9nKCwVTYneGm7itkg3C
         v4XA79lqnQANvqMRJbmSMGNtDSn2IY6olL5uDfM/3b7muvJ+PwFwetAZNrwSXb1HBCSY
         8Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=ZnvQVruhJU/h5Yds13DXPknO7AFmnymrR0Gd+hkc3sY=;
        b=uaa1NyNCIWs3g+31Hk+Xoz30H2JMjpRmpI9jZfJdY26PbpWJRlt2sovFj/sh4LETJo
         7RzYMb0PXtf8YLbSAW7rGo8ioOm804jRrktiNOAyDzB6ZSWR7IG8uyoPjJQ5NeX+MUOi
         wdzhV/nm+2WeZmyE4Pwm9canSH5ncebabXPJI98v2N8f8iy/vvFAzl3MMC9jVenIN29R
         l3wbQyjqSD7uYtoxE1LBtgoArCR6pPy8lT2bi0FffqhvtKmWDZ097cUaP9RAtBN0P04f
         K79NwGrWZwHnWqBiBFMxm998Y83DiI+DO2A4iTnW/6ojDAkyTuANAgYtRht/KNaEaAyR
         0Fgg==
X-Gm-Message-State: ACgBeo1+COAfIla2Ei50nhiL9Xtj+rFjoST0UF3xnyMdcLuiQWsjoXdS
        Hn44BZTDADTEIucQPQQobjAe+ZrTEIU=
X-Google-Smtp-Source: AA6agR7KNOWPrzX0E6oR7Rnqp8F/RZfQ63zqY3xG4M5z71/3Y9odmdqYdHT+WQ14jmjft0XI+e2QVg==
X-Received: by 2002:a17:90b:16d3:b0:202:9e20:704b with SMTP id iy19-20020a17090b16d300b002029e20704bmr2906429pjb.141.1663060237514;
        Tue, 13 Sep 2022 02:10:37 -0700 (PDT)
Received: from voyager.lan ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090ad48800b001f2fa09786asm6801668pju.19.2022.09.13.02.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 02:10:36 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>,
        eajames@linux.ibm.com
Subject: [PATCH 0/2] tpm: tsi-i2c: Add compatible strings
Date:   Tue, 13 Sep 2022 18:40:22 +0930
Message-Id: <20220913091025.1768882-1-joel@jms.id.au>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Joel Stanley (1):
  tpm: tis-i2c: Add more compatible strings

Johannes Holland (1):
  dt-bindings: tpm: Add schema for TIS I2C devices

 drivers/char/tpm/tpm_tis_i2c.c                |  2 +
 .../bindings/security/tpm/tpm-tis-i2c.yaml    | 49 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

-- 
2.35.1

