Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0C2774AC
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Sep 2020 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgIXPA2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Sep 2020 11:00:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57810 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgIXPA2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Sep 2020 11:00:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OExGKU057807;
        Thu, 24 Sep 2020 15:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=13WiYyuHylIHc8b1AvafzrXZ3VZ7lUwT8kAQzpDo+aw=;
 b=rrLFfCwGt5vfQPO5UdVtqNplwrSDc9m2VMX3H6bzqsDHY65IPQy0z8KC+A+pKcWKvSsP
 1OO1N3aFtGDCNwi+N+NOe3csElclXxUIzyyHQhA4ZRu/bzVbDgrlpyxDksjmmG/iKHu3
 JYfv0cdqfhXFgsOLcwsTGM+teyX4yG0//iUDm2i/MIoif6i+rHzgi/OWPbMSkDI3O93K
 ZiMNloK2NcnqBTG5MCzjF6r60TFFUchb4H1k9zVl6iqnQ/NikbQT/xg2uKJYqLMwBjuu
 vM+zpmqcNEp+FDI3bTG/k7VSAcN+U65qrxi948MAWfY5v1PpGt6hHyTKjeQjtk46vkkw AQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33q5rgq5k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 15:00:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEuTx5126380;
        Thu, 24 Sep 2020 14:58:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33nujr18a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 14:58:12 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OEw8fd022539;
        Thu, 24 Sep 2020 14:58:08 GMT
Received: from disposition.us.oracle.com (/10.152.32.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 07:58:08 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH 01/13] x86: Secure Launch Kconfig
Date:   Thu, 24 Sep 2020 10:58:29 -0400
Message-Id: <1600959521-24158-2-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Initial bits to bring in Secure Launch functionality. Add Kconfig
options for compiling in/out the Secure Launch code.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/Kconfig | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac6..8957981 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1968,6 +1968,42 @@ config EFI_MIXED
 
 	   If unsure, say N.
 
+config SECURE_LAUNCH
+	bool "Secure Launch support"
+	default n
+	depends on X86_64
+	help
+	   The Secure Launch feature allows a kernel to be loaded
+	   directly through an Intel TXT measured launch. Intel TXT
+	   establishes a Dynamic Root of Trust for Measurement (DRTM)
+	   where the CPU measures the kernel image. This feature then
+	   continues the measurement chain over kernel configuration
+	   information and init images.
+
+choice
+	prompt "Select Secure Launch Algorithm for TPM2"
+	depends on SECURE_LAUNCH
+
+config SECURE_LAUNCH_SHA1
+	bool "Secure Launch TPM1 SHA1"
+	help
+	   When using Secure Launch and TPM1 is present, use SHA1 hash
+	   algorithm for measurements.
+
+config SECURE_LAUNCH_SHA256
+	bool "Secure Launch TPM2 SHA256"
+	help
+	   When using Secure Launch and TPM2 is present, use SHA256 hash
+	   algorithm for measurements.
+
+config SECURE_LAUNCH_SHA512
+	bool "Secure Launch TPM2 SHA512"
+	help
+	   When using Secure Launch and TPM2 is present, use SHA512 hash
+	   algorithm for measurements.
+
+endchoice
+
 config SECCOMP
 	def_bool y
 	prompt "Enable seccomp to safely compute untrusted bytecode"
-- 
1.8.3.1

