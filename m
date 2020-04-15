Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C61AAE2C
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2020 18:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415921AbgDOQ1g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Apr 2020 12:27:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49188 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415792AbgDOQ0C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Apr 2020 12:26:02 -0400
Received: from dede-linux.corp.microsoft.com (unknown [131.107.147.242])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8C3B120BC5ED;
        Wed, 15 Apr 2020 09:25:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C3B120BC5ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586967957;
        bh=FaexFtinUGsm8rBXc8VWllMcor6Su8B/guvXMx58Nts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hWUxUbYcOPLCchW4WzN1E1ck/xHYVFTYTTgUE3gZjOSy79CBc+wQ6Iu0QoH4o7RHu
         7zeGkQqP84AHmqdX0+ksJJ6awu78f+Ou58vGOJcL12EiRGb+6xu4I/iXbzetwlMZiQ
         C8ZSigFhrCZ6Zk9bmXec+KoZp/V+xxifgqi+Otck=
From:   deven.desai@linux.microsoft.com
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, jannh@google.com
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [RFC PATCH v3 07/12] dm-verity: add bdev_setsecurity hook for dm-verity signature
Date:   Wed, 15 Apr 2020 09:25:45 -0700
Message-Id: <20200415162550.2324-8-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415162550.2324-1-deven.desai@linux.microsoft.com>
References: <20200415162550.2324-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Deven Bowers <deven.desai@linux.microsoft.com>

Add a security hook call to set a security property of a block_device
in dm-verity with the results of a verified, signed root-hash.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 drivers/md/dm-verity-verify-sig.c | 7 +++++++
 include/linux/device-mapper.h     | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
index 27dac8aa2e5a..242e2421d3c8 100644
--- a/drivers/md/dm-verity-verify-sig.c
+++ b/drivers/md/dm-verity-verify-sig.c
@@ -8,7 +8,10 @@
 #include <linux/device-mapper.h>
 #include <linux/verification.h>
 #include <keys/user-type.h>
+#include <linux/security.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include "dm-core.h"
 #include "dm-verity.h"
 #include "dm-verity-verify-sig.h"
 
@@ -182,6 +185,10 @@ int verity_verify_root_hash(const struct dm_verity *v)
 		goto cleanup;
 
 	sig_target->passed = true;
+
+	ret = security_bdev_setsecurity(dm_table_get_md(v->ti->table)->bdev,
+					DM_VERITY_SIGNATURE_SEC_NAME,
+					v->sig->sig, v->sig->sig_size);
 cleanup:
 	kfree(root_hash);
 	return ret;
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index af48d9da3916..61c26443783c 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -627,4 +627,6 @@ static inline unsigned long to_bytes(sector_t n)
 	return (n << SECTOR_SHIFT);
 }
 
+#define DM_VERITY_SIGNATURE_SEC_NAME DM_NAME	".verity-sig"
+
 #endif	/* _LINUX_DEVICE_MAPPER_H */
-- 
2.26.0

