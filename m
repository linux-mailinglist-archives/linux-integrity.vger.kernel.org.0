Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABA519FC99
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2020 20:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDFSLA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Apr 2020 14:11:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56174 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgDFSK7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Apr 2020 14:10:59 -0400
Received: from dede-linux.corp.microsoft.com (unknown [131.107.147.242])
        by linux.microsoft.com (Postfix) with ESMTPSA id 05B3920A0862;
        Mon,  6 Apr 2020 11:10:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05B3920A0862
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586196658;
        bh=P9n7+UpIgC9iVSLYj1Fo2stDBpEmg08YMF+B1Mh0GN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdzJen7hc8uzAbd+gCKpLe0qR3INlSq96pCVUvp5rY+QgSwrsiLoAuKinnhfNPLFF
         zAv4HJ6oSpYYOuDaYu3i8IIHkyE9TARy8rGl41sSS/FxYIxJakh2Do7nL84wcUNkXZ
         HGJK9cZGwRI4mi8hf+BS32JUcYtUEFbBEH4yhUIw=
From:   deven.desai@linux.microsoft.com
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com
Subject: [RESEND PATCH 06/11] dm-verity: add bdev_setsecurity hook for dm-verity signature
Date:   Mon,  6 Apr 2020 11:10:40 -0700
Message-Id: <20200406181045.1024164-7-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
References: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
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
index 475668c69dbc..6bd49aa48186 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -624,4 +624,6 @@ static inline unsigned long to_bytes(sector_t n)
 	return (n << SECTOR_SHIFT);
 }
 
+#define DM_VERITY_SIGNATURE_SEC_NAME DM_NAME	".verity-sig"
+
 #endif	/* _LINUX_DEVICE_MAPPER_H */
-- 
2.26.0

