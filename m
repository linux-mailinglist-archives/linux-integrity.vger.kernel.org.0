Return-Path: <linux-integrity+bounces-9490-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMtVAsAj/mmunAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9490-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:56:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 883F34FA47B
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C15BA303988D
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2026 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB08D423A66;
	Fri,  8 May 2026 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKrb0dUE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693E274FDF;
	Fri,  8 May 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262894; cv=none; b=d5PbtjToPIsNSiRWcSYQbMGo82ep7wPSDF3NkxrPwMQh9/QYgamHU3InjXwCPxplwG6i6GYFDhky/BeeU8iXYdzDlll/h/3dvAXKg6UYAXtDnHj9lghzK/eyp53tbzZMxEYakE2QJJFRyFGkZC1tc5dijRW0xnyjTe975GxDBzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262894; c=relaxed/simple;
	bh=VfeMzXxIblsKxvlWKcJteZkeQp7sM+pCydv1aje8okc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ib0GCqOG/izrxkYQ/Fk6n4KAr0ZnQt4NtTEUIgP/oHpFuCQoWnPpRTbA4GCxSZIw0BSoVIUNMnSG4Wmxlpadphu4dZWs5efE75yN2ygk1aBHZCqO5VhSyEuu69ZKOhK41BYL7rVQI59iPC1E/eIxVuZyT6RQZE11ENnw0UAmaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKrb0dUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642DDC2BCF4;
	Fri,  8 May 2026 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262893;
	bh=VfeMzXxIblsKxvlWKcJteZkeQp7sM+pCydv1aje8okc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cKrb0dUEWFnriGehqYSX4zQQL9iWfQmtv8wNfJ9dbay2K3d3Ok0Om1aHk0H4g8hWv
	 tUYHMEBVI9ReomR4aPTTa0GXp5t/Rx7T+nH67Eit4m2PyHZS7gc8Ay1oVbN1KrStbf
	 i4WycSaOVP373FqPSZo4NFou7OZbOcsiWXuMVb4/DsH/+wqLHW8plnWrzd3KQqOXJQ
	 58rniNWNyais+DTMdfjAh55smCxHH1OUdXRGiXfyjSJa4e/Pj22HsQ1WFSrHCX+Wgq
	 JFKqljIM1d/aQ0lguLEUm5h+n585HfrTKIQpE3q7UiG1BdQVpywWv+NwTi5JSMizdh
	 HR/A5mOYtAYKA==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Fri, 08 May 2026 18:54:17 +0100
Subject: [PATCH 3/4] firmware: arm_ffa: Set the core device as FF-A device
 parent
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-b4-ffa_plat_dev-v1-3-c5a30f8cf7b8@kernel.org>
References: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
In-Reply-To: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 883F34FA47B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9490-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Pass a parent device into ffa_device_register() and use the synthetic
arm-ffa platform device as the parent for each registered FF-A device.

This keeps the enumerated FF-A partition devices anchored below the FF-A
core device in the driver model, matching the platform-driver conversion
of the core transport.

Suggested-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/firmware/arm_ffa/bus.c    | 3 ++-
 drivers/firmware/arm_ffa/driver.c | 5 +++--
 include/linux/arm_ffa.h           | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 9576862d89c4..e05fe0b6049c 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -190,7 +190,7 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
 
 struct ffa_device *
 ffa_device_register(const struct ffa_partition_info *part_info,
-		    const struct ffa_ops *ops)
+		    const struct ffa_ops *ops, struct device *parent)
 {
 	int id, ret;
 	struct device *dev;
@@ -210,6 +210,7 @@ ffa_device_register(const struct ffa_partition_info *part_info,
 	}
 
 	dev = &ffa_dev->dev;
+	dev->parent = parent;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
 	dev->dma_mask = &dev->coherent_dma_mask;
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 97ecdb5dac09..e9d7dc71c06d 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1688,7 +1688,7 @@ static int ffa_setup_host_partition(int vm_id)
 	int ret;
 
 	buf.id = vm_id;
-	ffa_dev = ffa_device_register(&buf, &ffa_drv_ops);
+	ffa_dev = ffa_device_register(&buf, &ffa_drv_ops, &ffa_pdev->dev);
 	if (!ffa_dev) {
 		pr_err("%s: failed to register host partition ID 0x%x\n",
 		       __func__, vm_id);
@@ -1758,7 +1758,8 @@ static int ffa_setup_partitions(void)
 		 * provides UUID here for each partition as part of the
 		 * discovery API and the same is passed.
 		 */
-		ffa_dev = ffa_device_register(tpbuf, &ffa_drv_ops);
+		ffa_dev = ffa_device_register(tpbuf, &ffa_drv_ops,
+					      &ffa_pdev->dev);
 		if (!ffa_dev) {
 			pr_err("%s: failed to register partition ID 0x%x\n",
 			       __func__, tpbuf->id);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 81e603839c4a..17eca3dfc59e 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -173,7 +173,7 @@ struct ffa_partition_info;
 #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
 struct ffa_device *
 ffa_device_register(const struct ffa_partition_info *part_info,
-		    const struct ffa_ops *ops);
+		    const struct ffa_ops *ops, struct device *parent);
 void ffa_device_unregister(struct ffa_device *ffa_dev);
 int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
 			const char *mod_name);
@@ -184,7 +184,7 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev);
 #else
 static inline struct ffa_device *
 ffa_device_register(const struct ffa_partition_info *part_info,
-		    const struct ffa_ops *ops)
+		    const struct ffa_ops *ops, struct device *parent)
 {
 	return NULL;
 }

-- 
2.43.0


