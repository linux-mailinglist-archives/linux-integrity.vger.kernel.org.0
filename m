Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7B13ACFFD
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Jun 2021 18:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhFRQKM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Jun 2021 12:10:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22104 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233033AbhFRQJw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jun 2021 12:09:52 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IG0vxw005150;
        Fri, 18 Jun 2021 16:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=XrGHIaHHaXwLYu2CFXEuXnO6cEoUo0eTbOP7lAlnnPs=;
 b=i0Hx9dkvEXG1437lli4MHh55wuXe0lEfa476URaec+mbPU5rf9Cte8RH3BxXk7mv2sqb
 gLtBlCgBYiQGLCNiBc/uK5SljeUaEzgrnedMur3BXLZLCMrC5FTVSzjCv4jSc76xFQQ3
 QUBxDkbA4iBDQ4Q30jJ/+tW2v5qCgaR9GevqoWwxh0Pe1Cjb+X1RLQfXwSdOQLE1cT3m
 cMyiuhsBfjzztubiu2WrRSVRWebfzJFsiLh8JKSoBuZpdm/CqYAZP/ES72T/vaJPKEQr
 Ngt8a6/A8hxK1I6LP6ASklUPa3T2nukkFi2sYxLitQJxguP0OQDh4JG1ubcLXQEsIPNb yA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 397mptmbhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IG1c0X154948;
        Fri, 18 Jun 2021 16:06:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 396wayyuy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:55 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15IG6sAF167646;
        Fri, 18 Jun 2021 16:06:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 396wayyuxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:54 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15IG6keu018472;
        Fri, 18 Jun 2021 16:06:46 GMT
Received: from lateralus.us.oracle.com (/10.149.232.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jun 2021 16:06:46 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH v2 02/12] x86: Secure Launch Kconfig
Date:   Fri, 18 Jun 2021 12:12:47 -0400
Message-Id: <1624032777-7013-3-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-GUID: LsQH5TrBIUCZUqniYzId3TotAvVgrspv
X-Proofpoint-ORIG-GUID: LsQH5TrBIUCZUqniYzId3TotAvVgrspv
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Initial bits to bring in Secure Launch functionality. Add Kconfig
options for compiling in/out the Secure Launch code.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/Kconfig | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b..65d69f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1989,6 +1989,38 @@ config EFI_MIXED
 
 	   If unsure, say N.
 
+config SECURE_LAUNCH
+	bool "Secure Launch support"
+	default n
+	depends on X86_64 && X86_X2APIC
+	help
+	   The Secure Launch feature allows a kernel to be loaded
+	   directly through an Intel TXT measured launch. Intel TXT
+	   establishes a Dynamic Root of Trust for Measurement (DRTM)
+	   where the CPU measures the kernel image. This feature then
+	   continues the measurement chain over kernel configuration
+	   information and init images.
+
+config SECURE_LAUNCH_ALT_PCR19
+	bool "Secure Launch Alternate PCR 19 usage"
+	default n
+	depends on SECURE_LAUNCH
+	help
+	   In the post ACM environment, Secure Launch by default measures
+	   configuration information into PCR18. This feature allows finer
+	   control over measurements by moving configuration measurements
+	   into PCR19.
+
+config SECURE_LAUNCH_ALT_PCR20
+	bool "Secure Launch Alternate PCR 20 usage"
+	default n
+	depends on SECURE_LAUNCH
+	help
+	   In the post ACM environment, Secure Launch by default measures
+	   image data like any external initrd into PCR17. This feature
+	   allows finer control over measurements by moving image measurements
+	   into PCR20.
+
 source "kernel/Kconfig.hz"
 
 config KEXEC
-- 
1.8.3.1

