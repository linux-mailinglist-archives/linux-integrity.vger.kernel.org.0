Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4439152EE1D
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 16:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiETO0Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 10:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiETO0V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 10:26:21 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8ED35244
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653056778;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TKVzWMWh/iK70Mm9HetHCSrG8L7/6BKdS9Anokzny/s=;
    b=sEW0jEtBXG3OqN+uMNTOB97hIMvy3knmi2GY2oad5jFf1+MNODw8gHu/8rR+gAQMZZ
    fnnlp5ZbSTO8AaNRUAwk00HcUDXymRyBLKXs9bno5NsdvE1Ix52sjfb6Q/zNq/QiSS7E
    5rNtfqRnWlCzZWksrFGAv2iqrdGrOIPjfLxIZsd1ro0g+m1gNUNkNSrddG10SDydBUjn
    J+Jri+zRazE2DmWFsSrJ0Nt0IQX0BuRUKRAqm1Wui3IeEY+ioa8AVgowRlmXNA2KBX2A
    Ygeqk3YUGHZ6DTqTx/4b/7mNexn+UjuA6jjGKTc5IlMcKWJIQZoamveOJwtOAUwWFDDL
    pDXg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoauycprg5uef7cgCEpy7sPc="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id Y03eaey4KEQHQD6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 20 May 2022 16:26:17 +0200 (CEST)
From:   Thore Sommer <public@thson.de>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com,
        nramas@linux.microsoft.com
Cc:     linux-integrity@vger.kernel.org, Thore Sommer <public@thson.de>
Subject: [PATCH 2/3] dm verity: add support for IMA target update event
Date:   Fri, 20 May 2022 16:26:04 +0200
Message-Id: <20220520142605.270625-3-public@thson.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220520142605.270625-1-public@thson.de>
References: <20220520142605.270625-1-public@thson.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On first corruption the verity targets triggers a "dm_target_update" event.
This allows other systems to detect the corruption via IMA instead of
manually querying the table. The corruption cannot be detected using the
other IMA measurements because "dm_table_load" only measures the table
content during target creation. Using the new "dm_target_update" remeasures
the target table entries during runtime.

The event is only triggered if the target was not corrupted before because
verity_handle_err(..) is still called when the target is corrupted and the
IMA log should only contain an entry when the table changed.

Signed-off-by: Thore Sommer <public@thson.de>
---
 - v1: rewrite check to not use an extra variable

 drivers/md/dm-verity-target.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 80133aae0db3..5133c2274057 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -16,6 +16,7 @@
 #include "dm-verity.h"
 #include "dm-verity-fec.h"
 #include "dm-verity-verify-sig.h"
+#include "dm-ima.h"
 #include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/scatterlist.h>
@@ -219,8 +220,13 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	const char *type_str = "";
 	struct mapped_device *md = dm_table_get_md(v->ti->table);
 
-	/* Corruption should be visible in device status in all modes */
-	v->hash_failed = 1;
+	/* Only change and measure change if not already corrupted */
+	if (!v->hash_failed) {
+		/* Corruption should be visible in device status in all modes */
+		v->hash_failed = 1;
+		/* After the state has changed remeasure target table */
+		dm_ima_measure_on_target_update(v->ti);
+	}
 
 	if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS)
 		goto out;
-- 
2.36.0

