Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222B6713E1
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jan 2023 07:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjARGY1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 01:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjARGWO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 01:22:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6354DE39;
        Tue, 17 Jan 2023 22:11:27 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I5MNdw007599;
        Wed, 18 Jan 2023 06:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=E0dq3ETgVtjHnACRGN3zQsVSK1Z5Iyw8g63/v3XZrW4=;
 b=VSOqmk05kYdsOLhoHUGsW9399GZevHRlsU4Pd+AScDqjcQ5HpRp05FS7kdwkV4s8Y5wf
 9oQeYs7jb6JDRRot6bnE6BEx7J5psH5l+O45R5Kaj+mKGXsQboT8FKCVNVLCoTmjV526
 hkLrV35tz100//lXT4cMQlZn8XMHRnUlCxwICvmLorXqRI7p3XI/8lh1iW2F13716Ll1
 z/x0nKSUDPp1mPteUlUUdDcSGt8jD9KnsJN0ntKV6YRijQ2aPveT0MP+O6q7FJw1oVuM
 c6K1lwfnboDo3RWYzYmHYmKS53vsOKdiEnr3LpIunUJNiZrXqTGh3E06+/moIRS7mZCI 0Q== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n63tk9abk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:19 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HAZrN3028803;
        Wed, 18 Jan 2023 06:11:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n3m16bh3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I6BES214942540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 06:11:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B729A20043;
        Wed, 18 Jan 2023 06:11:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CE2A20040;
        Wed, 18 Jan 2023 06:11:14 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 06:11:14 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 89AF4609BC;
        Wed, 18 Jan 2023 17:11:08 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com
Subject: [PATCH v3 19/24] powerpc/pseries: Turn PSERIES_PLPKS into a hidden option
Date:   Wed, 18 Jan 2023 17:10:44 +1100
Message-Id: <20230118061049.1006141-20-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061049.1006141-1-ajd@linux.ibm.com>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5kK0W0JAPrzucMCOg-J59ZU-HiBeon_7
X-Proofpoint-GUID: 5kK0W0JAPrzucMCOg-J59ZU-HiBeon_7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=781 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

