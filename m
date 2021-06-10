Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F23A3581
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 23:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFJVLq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 17:11:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60418 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhFJVLl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 17:11:41 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id A6E9120B7178;
        Thu, 10 Jun 2021 14:09:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6E9120B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623359384;
        bh=uVgZoRO1aKnahUqyjDPzyphebgzUacysdZ2smy7vuKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjX04TsCT6Z9+aOGs0t4/zJ6XPuhW1muqh2cI/PW8VrAvXURzeTSoIjMpnqhrzZOb
         E/K1XPRxBdhyQ+MDJE8KarvEvA8PQXdzCF8br/WB8fC7tWqbxBgowaSehYqchn4aA2
         UPoZgcynC2lD2eVK3tfgc34Xt50jzEitiV1mfx0k=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>
Cc:     Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] optee: Fix memory leak when failing to register shm pages
Date:   Thu, 10 Jun 2021 16:09:06 -0500
Message-Id: <20210610210913.536081-2-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Free the previously allocated pages when we encounter an error condition
while attempting to register the pages with the secure world.

Fixes: a249dd200d03 ("tee: optee: Fix dynamic shm pool allocations")
Fixes: 5a769f6ff439 ("optee: Fix multi page dynamic shm pool alloc")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/tee/optee/shm_pool.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index d767eebf30bd..da06ce9b9313 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -32,8 +32,10 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 		struct page **pages;
 
 		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
-		if (!pages)
-			return -ENOMEM;
+		if (!pages) {
+			rc = -ENOMEM;
+			goto err;
+		}
 
 		for (i = 0; i < nr_pages; i++) {
 			pages[i] = page;
@@ -44,8 +46,14 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 		rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
 					(unsigned long)shm->kaddr);
 		kfree(pages);
+		if (rc)
+			goto err;
 	}
 
+	return 0;
+
+err:
+	__free_pages(page, order);
 	return rc;
 }
 
-- 
2.25.1

