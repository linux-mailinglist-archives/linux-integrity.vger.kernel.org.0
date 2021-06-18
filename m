Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD53ACFDF
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Jun 2021 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhFRQJd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Jun 2021 12:09:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52776 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231834AbhFRQJc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jun 2021 12:09:32 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IG26av010929;
        Fri, 18 Jun 2021 16:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=2j4DFmaqTg7mJII5mjXL3wo0zAK/9f6Mm+ri23jZ0dk=;
 b=Uz9Z6JJQ8ROB/Vco+gOwLn4gXHx/W6iZAg2KPPYebakmWrLiFNrgYj2mnFHC/4/6tYgi
 FyrvMEgO1WqPdJcL8+MkT7PLmw1jwAiWLhEKSHOOD7uaKIolhayMPd5n8vyuKnH60Q/l
 xkp2PsjOLjcVxMenCA1pllqKzZ8KyEP3kqCSXcynRnXdjBjNgxFKKPPUg3J5PMEFALD3
 g6tSa/tTZnJDPdA7IlBO6H6E/9iTqu84Yz7RkahXri9mYiz7sTOx7z7ZVf1TDE6HohDZ
 mBTgqC+Zk3yj6LMaHYNs5k2lBjLwfLUAzsuEuQIslZ5dQ9GI7ylsq/jnajA1hXxlmK/3 gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 398xmp00cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IG1Pvn108711;
        Fri, 18 Jun 2021 16:06:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 396wawv2rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:58 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15IG3fFt114314;
        Fri, 18 Jun 2021 16:06:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 396wawv2q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:58 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15IG6tHa021864;
        Fri, 18 Jun 2021 16:06:55 GMT
Received: from lateralus.us.oracle.com (/10.149.232.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jun 2021 16:06:55 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH v2 12/12] iommu: Do not allow IOMMU passthrough with Secure Launch
Date:   Fri, 18 Jun 2021 12:12:57 -0400
Message-Id: <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-ORIG-GUID: 2dcc9vhgXW8othlKgr_oTBs9RkM_O--n
X-Proofpoint-GUID: 2dcc9vhgXW8othlKgr_oTBs9RkM_O--n
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IOMMU should always be set to default translated type after
the PMRs are disabled to protect the MLE from DMA.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/iommu/intel/iommu.c | 5 +++++
 drivers/iommu/iommu.c       | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284..4f0256d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -41,6 +41,7 @@
 #include <linux/dma-direct.h>
 #include <linux/crash_dump.h>
 #include <linux/numa.h>
+#include <linux/slaunch.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -2877,6 +2878,10 @@ static bool device_is_rmrr_locked(struct device *dev)
  */
 static int device_def_domain_type(struct device *dev)
 {
+	/* Do not allow identity domain when Secure Launch is configured */
+	if (slaunch_get_flags() & SL_FLAG_ACTIVE)
+		return IOMMU_DOMAIN_DMA;
+
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d..d49b7dd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
+#include <linux/slaunch.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -2761,7 +2762,10 @@ void iommu_set_default_passthrough(bool cmd_line)
 {
 	if (cmd_line)
 		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
-	iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
+
+	/* Do not allow identity domain when Secure Launch is configured */
+	if (!(slaunch_get_flags() & SL_FLAG_ACTIVE))
+		iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
 }
 
 void iommu_set_default_translated(bool cmd_line)
-- 
1.8.3.1

