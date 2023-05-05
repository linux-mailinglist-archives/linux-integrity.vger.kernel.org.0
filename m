Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD8A6F88C8
	for <lists+linux-integrity@lfdr.de>; Fri,  5 May 2023 20:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjEESoP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 May 2023 14:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjEESoO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 May 2023 14:44:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08423C10
        for <linux-integrity@vger.kernel.org>; Fri,  5 May 2023 11:44:13 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f19ab994ccso21597395e9.2
        for <linux-integrity@vger.kernel.org>; Fri, 05 May 2023 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683312252; x=1685904252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOft8V3poWwKGQYv2fbFWbi4vvY+surZitO1qc1yIVw=;
        b=t8d/519efYOhOnacRAzOYC0VPKglKsmmZePchT3MPLdLzv6N2FOEFziG842IIpSB9X
         eWBBkoTm7RqACfDWu9JEyVebdogXKMufa6pU/+jM5m/qO4dQruwr1o+UZTeS5m8TRhMt
         PUM7gKhQqH4pkxGISuW3mu38qIdU31NVO860yTjvJTWkFZfgpIfs19X2t8d8Mmgh56Nk
         i7zqDzgiGE7M4vudf9j5jOMgF8ABprrUjP1D7mFxsZo/TXoQwWozW8urUBEq73zPyuTx
         Gj9DQjuVSEJAFC2Ra5UFkueQ+AexnQSqybTNiC0uCmXCxuwkcKM25PCneBBcTjizzbw3
         PrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312252; x=1685904252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOft8V3poWwKGQYv2fbFWbi4vvY+surZitO1qc1yIVw=;
        b=GIc/PPhafyCSXtP+sllyobEdzFy7efd9v2uxnk8Z/Zp+un5EZAIe8GWWFLqmL+l1j/
         3XBQwplpy1oVYqNphWN8ZoP0mKOFaWuFCyvHJRgf2BqT1GmL6DumGLz403rP+LtC1HOO
         NIc06LtWuWGd0tmP7x7HFmAMx9+IGkfgrCMWPquSaBO62bX8u3aAZcIiI8YtNJQ7pzpJ
         RCU5J9wKrYPqx1gHv98724//xer1SprhJdvWJB8/IsSaBj2ndEDudzOaneeDSOh3lQ0l
         fgH9H8dEbxchZxFSGMb2qxp+M8qCfdqB7CneJc+5NzMGZtj3SOcfkMUXTEMmM6RB8LZd
         NHkw==
X-Gm-Message-State: AC+VfDwId+cjuaJBNQf2D7uUV1JIsabtoStQL4jZRsGE76GJkF56S8ep
        Mh14FNCtV+a/DX1O5+6qw60v/g==
X-Google-Smtp-Source: ACHHUZ7GcTP+k/N8hq5FhBGVRp44QZn75YCloLg6L6SGE7jjV0GbozUmEtaRHRxSHBjQtbgjWyLu6A==
X-Received: by 2002:a1c:4b06:0:b0:3f1:69cc:475b with SMTP id y6-20020a1c4b06000000b003f169cc475bmr1852971wma.36.1683312252124;
        Fri, 05 May 2023 11:44:12 -0700 (PDT)
Received: from lmecxl1178.lme.st.com (lfbn-nan-1-1169-52.w86-212.abo.wanadoo.fr. [86.212.112.52])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c211400b003f183127434sm8686370wml.30.2023.05.05.11.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 11:44:11 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH] char: tpm: ftpm_tee: use kernel login identifier
Date:   Fri,  5 May 2023 20:43:18 +0200
Message-Id: <20230505184318.1355446-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Changes fTPM TEE driver to open the TEE session with REE kernel login
identifier rather than public login. This is needed in case fTPM service
it denied to user land application and restricted to kernel operating
system services only.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 528f35b14fb6..6d32e260af43 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -241,7 +241,7 @@ static int ftpm_tee_probe(struct device *dev)
 	/* Open a session with fTPM TA */
 	memset(&sess_arg, 0, sizeof(sess_arg));
 	export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
-	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
 	sess_arg.num_params = 0;
 
 	rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
-- 
2.25.1

