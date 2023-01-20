Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FAA674E6C
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jan 2023 08:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjATHoH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Jan 2023 02:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjATHnx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Jan 2023 02:43:53 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC85A87291;
        Thu, 19 Jan 2023 23:43:52 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K5nbVk025103;
        Fri, 20 Jan 2023 07:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=E0dq3ETgVtjHnACRGN3zQsVSK1Z5Iyw8g63/v3XZrW4=;
 b=RPfzjDcH4boOZKrdwrVNms+7rDp81wcxe1b+C87zikOwp4KVysemig+GINqnUpAB+3MO
 RB9WoepQkSxwXbjvAoj4TTF0klKBTEgqM2P9rCkuVMGH6vghtTzXrJpZDcd/FXFJsLIg
 CTKKrj0OUC/m1xpcY2vNa3aHlW3Aq2zUW/QaqLFftA7zbs9PD0TVR368pNgWxy3tQu8d
 u2Nxk+KSXVZdeXk3Z2XpuEExek2VnYnPoXaZoQpKYoB6l9CyCqmBJd4L3nCtVLG1+gOh
 XyRWHjf1v8nLOVjchH4t7aSkea8b5SibPJENRClIQRKALaI+0fGlsjyhYj84Vn2Qzh0U VA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7n5b23s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JH5NIr006282;
        Fri, 20 Jan 2023 07:43:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n3knfqpam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30K7haaj22545106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 07:43:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E6F02004D;
        Fri, 20 Jan 2023 07:43:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1460920040;
        Fri, 20 Jan 2023 07:43:36 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jan 2023 07:43:36 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 46B00609BC;
        Fri, 20 Jan 2023 18:43:30 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com, joel@jms.id.au
Subject: [PATCH v4 19/24] powerpc/pseries: Turn PSERIES_PLPKS into a hidden option
Date:   Fri, 20 Jan 2023 18:43:01 +1100
Message-Id: <20230120074306.1326298-20-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120074306.1326298-1-ajd@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VQTAVo_UNEWs_W_3PmJ9Eq9LSd5YwJ9R
X-Proofpoint-ORIG-GUID: VQTAVo_UNEWs_W_3PmJ9Eq9LSd5YwJ9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_04,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=784
 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It seems a bit unnecessary for the PLPKS code to have a user-visible
config option when it doesn't do anything on its own, and there's existing
options for enabling Secure Boot-related features.

It should be enabled by PPC_SECURE_BOOT, which will eventually be what
uses PLPKS to populate keyrings.

However, we can't get of the separate option completely, because it will
also be used for SED Opal purposes.

Change PSERIES_PLPKS into a hidden option, which is selected by
PPC_SECURE_BOOT.

Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>

---

v3: New patch
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/platforms/pseries/Kconfig | 11 +----------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b8c4ac56bddc..d4ed46101bec 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1029,6 +1029,7 @@ config PPC_SECURE_BOOT
 	depends on PPC_POWERNV || PPC_PSERIES
 	depends on IMA_ARCH_POLICY
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
+	select PSERIES_PLPKS if PPC_PSERIES
 	help
 	  Systems with firmware secure boot enabled need to define security
 	  policies to extend secure boot to the OS. This config allows a user
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index a3b4d99567cb..82b6f993be0f 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -151,16 +151,7 @@ config IBMEBUS
 
 config PSERIES_PLPKS
 	depends on PPC_PSERIES
-	bool "Support for the Platform Key Storage"
-	help
-	  PowerVM provides an isolated Platform Keystore(PKS) storage
-	  allocation for each LPAR with individually managed access
-	  controls to store sensitive information securely. It can be
-	  used to store asymmetric public keys or secrets as required
-	  by different usecases. Select this config to enable
-	  operating system interface to hypervisor to access this space.
-
-	  If unsure, select N.
+	bool
 
 config PAPR_SCM
 	depends on PPC_PSERIES && MEMORY_HOTPLUG && LIBNVDIMM
-- 
2.39.0

