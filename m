Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656865ED3F6
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 06:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiI1ElI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Sep 2022 00:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI1ElH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Sep 2022 00:41:07 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D97B72B7D;
        Tue, 27 Sep 2022 21:41:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v4so11179538pgi.10;
        Tue, 27 Sep 2022 21:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=2aGBJX41wwhP5xiOS3w6q9sOFoPx6hcoxIUBu1dhhaE=;
        b=XVw9Jd+hyeAyhNNgBtEF1vJ6HqOCKnXDqoaV3VUmmWZpeufHOtB8bF9EalEEH5OJqJ
         jbwAS50QkX09nzPsBXMubHMStMcGxk3JYhgpryTS9S4I0Wt0qJ5DJSH5MIx5lht2aLFt
         jUiXbQmR5vtDdxo/ag0tEFGxmo8lvtBt0TYixJteXEw0YCAEa1YVuzD5TKmRufELf1Rg
         IDPOZpl9mv2anlmDfcSjojuEvl7aa2tjf69O13Osz2DzvhMkhAbvNO0m65ZJipLg44dw
         GAXjnFsg7NPbwVXB4czpfzlZzZBQxRUBc9CJYezxWeIk4zcI1d6do/1KdU7b3mWHPSz3
         yvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=2aGBJX41wwhP5xiOS3w6q9sOFoPx6hcoxIUBu1dhhaE=;
        b=L0kw3kdo/vojLZmFLlF8AbAVmN0uYNrxuEM0pIwoUe0RK22jpRDgJK0kkM4512HyAn
         qL8pvpJ9Nzl7AEiDszQQkr7vpNsI7bhtRKJcjQlg/todz/SQaYNybDw5N1BsJ74R8mqM
         3VJwWRlByAa+CkgmiS19W9zykOXs84z9O6UhPGD/IdEzNX0cq0US7me6k7QkADeQM19K
         /1RNlG75tk+LzXtE6hC7ZRuyf3XD03qxC30XZ9/kSveLqBLL8UFtobsNYtVH+qkRpqBZ
         ZaGMMvczyQnasu0sJBiZ9iu+KLjV9l9UN2aSlZ6b64jTDcd5LC7h/vi92wfizP5aAGBa
         BEsQ==
X-Gm-Message-State: ACrzQf0RBkN3UuGOaYnusJ3gHBQFliZfj0sABmedFjd3ApZ8oFFFPmhT
        eyj+O9x4VhQgDHcbiH2J1b0=
X-Google-Smtp-Source: AMsMyM7LdmQNUBvc6yH9dqBJb3XFMwlC9JHatFE0JcTkvSgVBszIqKiwESVztToKe/kcF00Ths+32g==
X-Received: by 2002:a63:2a02:0:b0:42b:2711:d534 with SMTP id q2-20020a632a02000000b0042b2711d534mr27362498pgq.176.1664340065808;
        Tue, 27 Sep 2022 21:41:05 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e80800b00178ac4e70dcsm2504439plg.185.2022.09.27.21.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 21:41:05 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>,
        eajames@linux.ibm.com
Subject: [PATCH v2 1/3] dt-bindings: trivial-devices: Remove Infineon SLB9673 TPM
Date:   Wed, 28 Sep 2022 14:09:55 +0930
Message-Id: <20220928043957.2636877-2-joel@jms.id.au>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220928043957.2636877-1-joel@jms.id.au>
References: <20220928043957.2636877-1-joel@jms.id.au>
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

This reverts commit 2353673d8a025a6ba3b3aa3917a3a98944e64702.

It will be added to its own bindings document.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 61746755c107..7c62c2740330 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -139,8 +139,6 @@ properties:
           - infineon,slb9635tt
             # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
           - infineon,slb9645tt
-            # Infineon SLB9673 I2C TPM 2.0
-          - infineon,slb9673
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
             # Infineon Multi-phase Digital VR Controller xdpe11280
-- 
2.35.1

