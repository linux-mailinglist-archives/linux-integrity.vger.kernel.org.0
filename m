Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0E3728287
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jun 2023 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbjFHOVE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jun 2023 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbjFHOVA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jun 2023 10:21:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0692728;
        Thu,  8 Jun 2023 07:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEC5961460;
        Thu,  8 Jun 2023 14:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23D1C433EF;
        Thu,  8 Jun 2023 14:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686234059;
        bh=AezSRigPDaYmuwaAYQ/DcZVDhJmeNJQ+9AyhVIiB444=;
        h=From:To:Cc:Subject:Date:From;
        b=nT3TqgLNsVVOzgW/3JmEYWT/foO9agixjeVpmLi6g+XPQrLUzSYvsh1EMeDTIJNxm
         NBzrV8eUr8AKmEbKYXHRbAGJ045raXFzA+sn8nmkROvG1+B8IeTldf2KzZxd2D7rYU
         iO2aJTDCX69TdjfYzWbzuW5mEYpaHwE7hAoLJYz8TitSrosb0TWJkb7i29DVXB3Oee
         +La1GsjMasfN/XGDPitsLPU0UPuwoqVQcobPoGw4oP1qn4KCmt8ls0yLdxg68AyHAY
         WeCJFqqneVOe3a1zsr8+QMGr0Jck+th4x9+/qjETV0g+wDqvcxR4iUdl2jV7wA4Mz2
         1Dill4H2jn6fA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Redefine pr_fmt
Date:   Thu,  8 Jun 2023 17:20:52 +0300
Message-Id: <20230608142052.45287-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Redefine pr_fmt inside internal include, following the pattern from
arch/x86/kernel/cpu/sgx.h.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-interface.c | 4 ++--
 drivers/char/tpm/tpm.h           | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 586ca10b0d72..0689e5f3b4c0 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -493,13 +493,13 @@ static int __init tpm_init(void)
 
 	rc = alloc_chrdev_region(&tpm_devt, 0, 2*TPM_NUM_DEVICES, "tpm");
 	if (rc < 0) {
-		pr_err("tpm: failed to allocate char dev region\n");
+		pr_err("failed to allocate char dev region\n");
 		goto out_destroy_tpmrm_class;
 	}
 
 	rc = tpm_dev_common_init();
 	if (rc) {
-		pr_err("tpm: failed to allocate char dev region\n");
+		pr_err("failed to allocate char dev region\n");
 		goto out_unreg_chrdev;
 	}
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 460bb85dd142..13733474a235 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -27,6 +27,10 @@
 #include <linux/tpm.h>
 #include <linux/tpm_eventlog.h>
 
+
+#undef pr_fmt
+#define pr_fmt(fmt) "tpm: " fmt
+
 #ifdef CONFIG_X86
 #include <asm/intel-family.h>
 #endif
-- 
2.39.2

