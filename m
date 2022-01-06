Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C95486B64
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jan 2022 21:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbiAFUqw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jan 2022 15:46:52 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:42037 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243955AbiAFUqw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jan 2022 15:46:52 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jan 2022 15:46:51 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641501293;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=61pR4jAdZW4XQ5RuZHGn9RtUYwUUzJ367g+BugGTFn8=;
    b=Fz4YgoWWOQizO0TxkYtAHRK82JTQ3pMn6qhYZh6rY1Q+Fvun7KUTYqErDFbiylZjdu
    HjVcmm5kfRlClbdAIP9IHJjVb9oJ7FA6Jqjb4NS9cPAAyLKM84vtGAiJZfDZH1D6FWwq
    sTcHgzCxVFrBq5Xx5b47me5rYSxYYLqdQC1Lv8TO8UeuFP18OoU8ybnGuChDgE2o/3oP
    0xKcNQLyK7zN0Pip0/JRlnnCLgA79uVI/av2pFCrjSPA9qveUNCLy8JNHblND8kWHK6r
    kttdk8ApfngJR5cxrL+aAUu3FpY+dDwhj26NcV2vxQ7XKiumjyeOAPsR2ZonNl9zFCe1
    A0WA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoauycprg5uef7cgCEpy7sPc="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.37.6 DYNA|AUTH)
    with ESMTPSA id k3f463y06KYr05g
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Jan 2022 21:34:53 +0100 (CET)
From:   Thore Sommer <public@thson.de>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        Thore Sommer <public@thson.de>
Subject: [RFC PATCH 2/3] dm verity: add support for IMA target update event
Date:   Thu,  6 Jan 2022 21:34:35 +0100
Message-Id: <20220106203436.281629-3-public@thson.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106203436.281629-1-public@thson.de>
References: <20220106203436.281629-1-public@thson.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On first corruption the verity targets triggers a dm_target_update event.
This allows other systems to check using IMA if the state of the device is
still trustworthy via remote attestation.

Signed-off-by: Thore Sommer <public@thson.de>
---
 drivers/md/dm-verity-target.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 80133aae0db3..09696e25bf1c 100644
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
@@ -218,10 +219,15 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	char *envp[] = { verity_env, NULL };
 	const char *type_str = "";
 	struct mapped_device *md = dm_table_get_md(v->ti->table);
+	int old_hash_failed = v->hash_failed;
 
 	/* Corruption should be visible in device status in all modes */
 	v->hash_failed = 1;
 
+	/* Only remeasure on first failure */
+	if (!old_hash_failed)
+		dm_ima_measure_on_target_update(v->ti);
+
 	if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS)
 		goto out;
 
-- 
2.34.1

