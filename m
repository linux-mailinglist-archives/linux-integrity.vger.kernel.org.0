Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9A75ED3F3
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 06:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiI1ElF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Sep 2022 00:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiI1ElE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Sep 2022 00:41:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAB3696D0;
        Tue, 27 Sep 2022 21:41:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so788208pjq.3;
        Tue, 27 Sep 2022 21:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=kPq7M4Md13aOtxnmroOiniNbRX42UPy2OogHgQ3+zsQ=;
        b=cMNEI89+UhSbr4/8mbhU00KI9G09pXfwWq11fxQZYfxYj0ElXvHVA+CKc6dSMq159Y
         7FMFI6fZSyLpI6asddzATvRwHbftbW3O6kGhjx26nj2m2Wxp7s3U8PsaB2hLVmTyJyeD
         rD5HcOgnao2jIBonLAzA13DbFcn0v9CcuelBEbZt2lKgxC8AkwfhPtDQcYqvqpJ00guV
         zavexdSs8SM0e541cHRY1QXgnpiQQpfFl4yi6+q0llMmmQquGvXjt8AhpZ/tK+k4Cu1I
         RVB7N2FDScnkXK7u8C1gliL+Ze04dmhb6/prorOe+rWIj81sA/5Pcqw3vEllIvB2tj5z
         85Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=kPq7M4Md13aOtxnmroOiniNbRX42UPy2OogHgQ3+zsQ=;
        b=qDx9Md3gWpxdSADZGWRRIOAb/SaQRsPDmNlnuCJrBuN5jAencNJVgPinA+z4EhgieO
         iF2as/aFxk2HMtiZolUchVq1tmI/1g1MzdKx8zMXO73O5NPqZft5C4msIKGZxnLaaeJk
         HdMx3p4VhvBPDxNnuISU9RUJQUNwhLwsu3ySA0E/KasVzPUTO4K1bYuEqFZxLIUHf2WI
         sMOfD6r/mUxJmdV2osLp1P/kHtwKNh5y5Gmm1Kctt1fz/H6pa5pBJXK7JiMPMdn7X4mo
         mo/wQVrTh6Clu6RjRNjKt+kkAYjRiFeGPURg4o3+TQ8RwmjYkalC/64+3tdNzC2LdtKO
         s+eA==
X-Gm-Message-State: ACrzQf1AdDEFrmTYzuP5SJQiXnFe6qqbCVTdeHlfen9irqdxDTh0vnXE
        UXa/zSkMHDLSAeLLbh8DWro=
X-Google-Smtp-Source: AMsMyM660N9slqQLphUogL5eege7EN0lEwmEWw2lnnK0r6Tp9knJ2WFa/VMciY6iONCGbF8NltmuWA==
X-Received: by 2002:a17:90b:3909:b0:202:c879:51a9 with SMTP id ob9-20020a17090b390900b00202c87951a9mr8045110pjb.83.1664340061483;
        Tue, 27 Sep 2022 21:41:01 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e80800b00178ac4e70dcsm2504439plg.185.2022.09.27.21.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 21:41:00 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>,
        eajames@linux.ibm.com
Subject: [PATCH v2 0/3] tpm: tsi-i2c: Add compatible strings
Date:   Wed, 28 Sep 2022 14:09:54 +0930
Message-Id: <20220928043957.2636877-1-joel@jms.id.au>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v2 removes the string from trivial devices and changes some of the
strings in the bindings.

Joel Stanley (2):
  dt-bindings: trivial-devices: Remove Infineon SLB9673 TPM
  tpm: tis-i2c: Add more compatible strings

Johannes Holland (1):
  dt-bindings: tpm: Add schema for TIS I2C devices

 drivers/char/tpm/tpm_tis_i2c.c                |  2 +
 .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 3 files changed, 52 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

-- 
2.35.1

