Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1644D19FC4D
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2020 19:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgDFR7a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Apr 2020 13:59:30 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51784 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgDFR71 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Apr 2020 13:59:27 -0400
Received: from dede-linux.corp.microsoft.com (unknown [131.107.147.242])
        by linux.microsoft.com (Postfix) with ESMTPSA id 08C8C20A0869;
        Mon,  6 Apr 2020 10:59:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08C8C20A0869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586195965;
        bh=vtS7tZDadPt65wOWMS99/Fu0/Y/o77wsMAmWG3vccKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Anb+ZcpKqEx5X6UGRlLRFsH+SwoEhxlh8lU8V6+QARcVo2Q4tGzDnrv8ZwLKU1nnH
         c8DdYmDxgYCEfeYpSPvyQxbuWJp5iwWVSWfl6TebleWswh6TYhCLpi+K6vS0G0m1sN
         UcY/lF9m2UB8O2YG8p+HvhKeZolN5B4QE+FNbaEg=
From:   deven.desai@linux.microsoft.com
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.org,
        linux-block@vger.kernel.org
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        mdsakib@microsoft.com, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com
Subject: [PATCH 08/11] dm-verity: add bdev_setsecurity hook for root-hash
Date:   Mon,  6 Apr 2020 10:59:16 -0700
Message-Id: <20200406175919.1023205-10-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406175919.1023205-1-deven.desai@linux.microsoft.com>
References: <20200406175919.1023205-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Deven Bowers <deven.desai@linux.microsoft.com>

Add a security hook call to set a security property of a block_device
in dm-verity with the root-hash that was verified to match the merkel-tree.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 drivers/md/dm-verity-target.c | 8 ++++++++
 include/linux/device-mapper.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index c507f3a4e237..225f67ab378d 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -16,8 +16,10 @@
 #include "dm-verity.h"
 #include "dm-verity-fec.h"
 #include "dm-verity-verify-sig.h"
+#include "dm-core.h"
 #include <linux/module.h>
 #include <linux/reboot.h>
+#include <linux/security.h>
 
 #define DM_MSG_PREFIX			"verity"
 
@@ -530,6 +532,12 @@ static int verity_verify_io(struct dm_verity_io *io)
 			return -EIO;
 	}
 
+	r = security_bdev_setsecurity(dm_table_get_md(v->ti->table)->bdev,
+				      DM_VERITY_ROOTHASH_SEC_NAME,
+				      v->root_digest, v->digest_size);
+	if (unlikely(r < 0))
+		return r;
+
 	/*
 	 * At this point, the merkel tree has finished validating.
 	 * if signature was specified, validate the signature here.
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 6bd49aa48186..467db44de194 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -625,5 +625,6 @@ static inline unsigned long to_bytes(sector_t n)
 }
 
 #define DM_VERITY_SIGNATURE_SEC_NAME DM_NAME	".verity-sig"
+#define DM_VERITY_ROOTHASH_SEC_NAME DM_NAME	".verity-rh"
 
 #endif	/* _LINUX_DEVICE_MAPPER_H */
-- 
2.26.0

