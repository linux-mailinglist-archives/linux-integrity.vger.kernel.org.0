Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC993ACFD7
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Jun 2021 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFRQJa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Jun 2021 12:09:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46102 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230070AbhFRQJ3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jun 2021 12:09:29 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IG27Js010934;
        Fri, 18 Jun 2021 16:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=we5x6i6or0UtI+IFyCZJ4GEZz7awYd5LaE4KffUi3kA=;
 b=wzPdyvJYpNLUWUEcClqwJ1ETrEmQbTfhCIApKBgtCkx6BYaiNAqhjgZ33PAtO7nA1UHt
 lcy0SM7YA4JDnSAgOLHTh5Aup0aZhbzt8lVVI6ECN9rCSKtQR/dCyaEWP02YFqyH7Czz
 R93T3AscueybG8OSdnE3wLQYdc620Mt6LwWpT3CT99B1yYsSEZRZsroodkr/OTF0TlNX
 ZskQ7lzcCd8ymKHRCrE86ECNp6jfl4GHuLgGRfqrmXS+vZlKs71Z+gJ+I17ETlyVapxJ
 00GKpxi35ioLnqysGC1uZvUahq4ufEOM+f330sL6qqWYBlLyV+jbQKkmfp1gPHp/krxE bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 398xmp00cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IG1cGV154953;
        Fri, 18 Jun 2021 16:06:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 396wayyuyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:56 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15IG6tQm167692;
        Fri, 18 Jun 2021 16:06:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 396wayyuy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15IG6sJt011912;
        Fri, 18 Jun 2021 16:06:54 GMT
Received: from lateralus.us.oracle.com (/10.149.232.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jun 2021 16:06:54 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH v2 11/12] tpm: Allow locality 2 to be set when initializing the TPM for Secure Launch
Date:   Fri, 18 Jun 2021 12:12:56 -0400
Message-Id: <1624032777-7013-12-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-ORIG-GUID: 3QE6YemacE6rjZKXJ8FKbmN6Zt9KHWF3
X-Proofpoint-GUID: 3QE6YemacE6rjZKXJ8FKbmN6Zt9KHWF3
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The Secure Launch MLE environment uses PCRs that are only accessible from
the DRTM locality 2. By default the TPM drivers always initialize the
locality to 0. When a Secure Launch is in progress, initialize the
locality to 2.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-chip.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb..48b9351 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -23,6 +23,7 @@
 #include <linux/major.h>
 #include <linux/tpm_eventlog.h>
 #include <linux/hw_random.h>
+#include <linux/slaunch.h>
 #include "tpm.h"
 
 DEFINE_IDR(dev_nums_idr);
@@ -34,12 +35,20 @@
 
 static int tpm_request_locality(struct tpm_chip *chip)
 {
-	int rc;
+	int rc, locality;
 
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	if (slaunch_get_flags() & SL_FLAG_ACTIVE) {
+		dev_dbg(&chip->dev, "setting TPM locality to 2 for MLE\n");
+		locality = 2;
+	} else {
+		dev_dbg(&chip->dev, "setting TPM locality to 0\n");
+		locality = 0;
+	}
+
+	rc = chip->ops->request_locality(chip, locality);
 	if (rc < 0)
 		return rc;
 
-- 
1.8.3.1

