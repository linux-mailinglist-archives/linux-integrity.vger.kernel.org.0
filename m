Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6C33A3588
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 23:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFJVLs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 17:11:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60502 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhFJVLq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 17:11:46 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 98D9E20B83C5;
        Thu, 10 Jun 2021 14:09:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98D9E20B83C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623359389;
        bh=lofS09cFjt2gMLe3PpZAwsHKE9enmufslzb5/Qk49r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5LRhHGeOaWqip/OdRQwzhPYX+Fba41bSqDR3CR8xxHAcGrVc/UcPGj7Di/vRIJsT
         dz0bcbo5ON++ZiJRfnd8MCCnu56/On2wuod7yaJj+VL0Vl4NvgwkURkQxAl6s40rF1
         URjrvPZonWxuyacZhncmic5ddEdxxLol2ZWv6z+w=
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
Subject: [PATCH v4 4/8] optee: Clear stale cache entries during initialization
Date:   Thu, 10 Jun 2021 16:09:09 -0500
Message-Id: <20210610210913.536081-5-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The shm cache could contain invalid addresses if
optee_disable_shm_cache() was not called from the .shutdown hook of the
previous kernel before a kexec. These addresses could be unmapped or
they could point to mapped but unintended locations in memory.

Clear the shared memory cache, while being careful to not translate the
addresses returned from OPTEE_SMC_DISABLE_SHM_CACHE, during driver
initialization. Once all pre-cache shm objects are removed, proceed with
enabling the cache so that we know that we can handle cached shm objects
with confidence later in the .shutdown hook.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/tee/optee/call.c          | 11 ++++++++++-
 drivers/tee/optee/core.c          | 13 +++++++++++--
 drivers/tee/optee/optee_private.h |  2 +-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 6e6eb836e9b6..5dcba6105ed7 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -419,8 +419,10 @@ void optee_enable_shm_cache(struct optee *optee)
  * optee_disable_shm_cache() - Disables caching of some shared memory allocation
  *			      in OP-TEE
  * @optee:	main service struct
+ * @is_mapped:	true if the cached shared memory addresses were mapped by this
+ *		kernel, are safe to dereference, and should be freed
  */
-void optee_disable_shm_cache(struct optee *optee)
+void optee_disable_shm_cache(struct optee *optee, bool is_mapped)
 {
 	struct optee_call_waiter w;
 
@@ -439,6 +441,13 @@ void optee_disable_shm_cache(struct optee *optee)
 		if (res.result.status == OPTEE_SMC_RETURN_OK) {
 			struct tee_shm *shm;
 
+			/*
+			 * Shared memory references that were not mapped by
+			 * this kernel must be ignored to prevent a crash.
+			 */
+			if (!is_mapped)
+				continue;
+
 			shm = reg_pair_to_ptr(res.result.shm_upper32,
 					      res.result.shm_lower32);
 			tee_shm_free(shm);
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 0987074d7ed0..6974e1104bd4 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -589,7 +589,7 @@ static int optee_remove(struct platform_device *pdev)
 	 * reference counters and also avoid wild pointers in secure world
 	 * into the old shared memory range.
 	 */
-	optee_disable_shm_cache(optee);
+	optee_disable_shm_cache(optee, true);
 
 	/*
 	 * The two devices have to be unregistered before we can free the
@@ -619,7 +619,7 @@ static int optee_remove(struct platform_device *pdev)
  */
 static void optee_shutdown(struct platform_device *pdev)
 {
-	optee_disable_shm_cache(platform_get_drvdata(pdev));
+	optee_disable_shm_cache(platform_get_drvdata(pdev), true);
 }
 
 static int optee_probe(struct platform_device *pdev)
@@ -716,6 +716,15 @@ static int optee_probe(struct platform_device *pdev)
 	optee->memremaped_shm = memremaped_shm;
 	optee->pool = pool;
 
+	/*
+	 * Ensure that there are no pre-existing shm objects before enabling
+	 * the shm cache so that there's no chance of receiving an invalid
+	 * address during shutdown. This could occur, for example, if we're
+	 * kexec booting from an older kernel that did not properly cleanup the
+	 * shm cache.
+	 */
+	optee_disable_shm_cache(optee, false);
+
 	optee_enable_shm_cache(optee);
 
 	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index e25b216a14ef..16d8c82213e7 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -158,7 +158,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
 
 void optee_enable_shm_cache(struct optee *optee);
-void optee_disable_shm_cache(struct optee *optee);
+void optee_disable_shm_cache(struct optee *optee, bool is_mapped);
 
 int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 		       struct page **pages, size_t num_pages,
-- 
2.25.1

