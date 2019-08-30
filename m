Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD9EA3488
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfH3J5A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 05:57:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41642 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfH3J5A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 05:57:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so4318231pfz.8;
        Fri, 30 Aug 2019 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6Jx4LeznDroJv1V+MqGkH6wNyfdO6arDu3vh6OGwO4=;
        b=P5LKAoNydxCLwtKPaKlmm7sBYONkLrbXlHqGeby2MQ2qjUeH1kDN3RHregechZ7LWZ
         MNczFl/OgDe2P7FfBdABcIydjZu5zcYZILY96v0w+Q4X+FfdB54nZF+RnZZ5+ok4QkyJ
         /wH3hsODHOExIQhlI1Vm5DdvMb5y+1XLuCu4vo64nK34T0lMNKIzWiB3NKD1uRfbieHU
         4T9MPEQuu5va2i3u/X9B2erEG1w5YSUuAMfPY/ZpabnMzDgOZmaWapp4hv0KhmUruMc7
         +g0uriOnfxwTl6QJmJDv8xUiRMqUlJSlJqnM6iW3beSkMhI8rA1dZIJJxfPKciaExPeh
         x5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6Jx4LeznDroJv1V+MqGkH6wNyfdO6arDu3vh6OGwO4=;
        b=YQ8y5NVESEFLxhwGg6n6/O8BGJscv4vwoTn1NYYAnG0SWZcDWrWOU/w4gQGmXKXYoA
         hEXSnDi4eje023exWWynX4tvfLOpgeRAWS5bdvMeYEQ3mfmB9tbrLn/afSJZjlJs+Um8
         OuPu3cCuJMEkfdak+aNuitMBib+2GFURclqd1y7x/d2s36Lqt0Sr9eD2wsl4AUm/Sy9X
         Bk0BgFbFEr06cp2Ge1N06OKSS9jCyHurJ3Az0i7i0almWgJbq4J12qTgMtfDOAcL13EV
         amyNt2p3M7tJ+aqYZvgbB6WJGMLd0xVkWhW29o5YHYkHu72/tfTWU4JnewR+sAY8e2t0
         R2vg==
X-Gm-Message-State: APjAAAXPP305BlEg1IPYDK1xQBZM9a7EoyzCaFVUKJsdT3dI5fK7QSs8
        0PbIp7HwUNL0lknTB0YZJsc=
X-Google-Smtp-Source: APXvYqxyXu8ZJM7570mg2e1+B9zCrvxJQmX/n5HI+hvj/AuetrcdvC78kRTlj9/wupB0AsWm6fhikw==
X-Received: by 2002:a65:6859:: with SMTP id q25mr12086276pgt.181.1567159019466;
        Fri, 30 Aug 2019 02:56:59 -0700 (PDT)
Received: from localhost.localdomain ([175.203.71.146])
        by smtp.googlemail.com with ESMTPSA id k64sm8329447pge.65.2019.08.30.02.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 02:56:59 -0700 (PDT)
From:   Seunghun Han <kkamagui@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH 0/2] Enhance support for the AMD's fTPM
Date:   Fri, 30 Aug 2019 18:56:37 +0900
Message-Id: <20190830095639.4562-1-kkamagui@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch series enhances the support for the AMD's fTPM. 
The AMD system assigned a command buffer and response buffer 
independently in ACPI NVS region. ACPI NVS region allowed nothing to 
assign a resource in it. 

For supporting AMD's fTPM, I made a patch to enhance the code of command 
and response buffer size calculation. I also made a patch to detect TPM 
regions in ACPI NVS and work around it. 

Seunghun Han (2):
  tpm: tpm_crb: enhance command and response buffer size calculation
    code
  tpm: tpm_crb: enhance resource mapping mechanism for supporting AMD's
    fTPM

 drivers/char/tpm/tpm_crb.c | 69 ++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 10 deletions(-)

-- 
2.21.0

