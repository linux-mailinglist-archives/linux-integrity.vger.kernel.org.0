Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF253F9986
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbhH0NWM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:22:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26190 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245196AbhH0NWC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:22:02 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RCCJu0015338;
        Fri, 27 Aug 2021 13:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wbARbsBnv0x79gqOC82Uzi6mCnkoaSdr+1qX8j9c4m8=;
 b=fow6/a+8uGF/ojHPy+OSYsKT3/I2XJX9TM3NWEOuVXk0rdBfrTTdm1C3oroLrqCjHO1A
 Iir+PJCoRA3ruAIxVOOHcx7MpB9cu9k8gPCV6S7zPk4SFKXGMWRXK6+mQhdoRdfSHTG0
 bH2R968Eecy+uc8ABMj7ZobnQoYsHoqoJhguZtnwdPYjlZFVQFXQ6RAJdZHDdqphI95A
 VzaINIUj/Kfj/CDYdnt37cRCHZXT+1lNZFE1IQ/uAiqy6NUcGLHecOlV0gUP04HRNFr9
 Wusquh0dMVXWrbgcXSaH1JwLTt+OAMmfSA/RsaukMb5Lp4RtkyTR4Un6SEpGc8ZqDsIJ Jw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wbARbsBnv0x79gqOC82Uzi6mCnkoaSdr+1qX8j9c4m8=;
 b=hIgC65GaJ023Yl0eiA70B4IP6LJ3+9KMEG6NRr0jXAbcGu5bHsq6bfAJK50o4o4N4Xkh
 pbGNY4orX7wlncJ+xA2u+iLWwStsVUIJTa+tnD6CidHzfwWl3E4/ULWs1r98GmggFlnb
 iPgs02f/9+rk1xFYUCtsMNjsvN3IaIQcd5H5OPEOpLL+TJI8K5j+NFcsJ+eDvMg2wLie
 3fUHo373pWnAKkwd6mGhlPAeZFfoAz+E7SuQnZDy55/ZgVKiIHIeHt5bJjOWv3n0ImWj
 kuoKT6R5Z3Hy1uq/UFkRZmUTF4k28X5XzpeTk4iu2g21XWSn2vZ5Z3blGixcIWw4dlgO cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3apvjr0ktu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RD9ouc076983;
        Fri, 27 Aug 2021 13:20:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by userp3030.oracle.com with ESMTP id 3ajpm4pqa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAhkCFk1Uk2q1gvUyLtciTTZHIq8giEZqUWFwQTzy77vOWTkSjPXTFyWK+gQlwMP4CUDGnOx7xxChSK1gGEZZwKZoOXbXPYTRIW+MxLGceJiySbTdKQZCkO68kvC6w0DPxwhmM1xJBpo9Whovy6Mr7jUCHNxkPXjoz52bhfdoCvY9pPuQBTLarV1j/6Kue/Jph6Dh6jvSoUySSuG0ivjDsDv+h9990Swg9NdnUta7J4HgdQfU0foBjoDZmdu51wLwklVUX9jJ2UdrLrBqaMwcpr+dHu7P0uBq+ZAu49qfEyKafrM0pa4LDFcU00IT/J7N8zFMPZMJq0UD9JMgzcyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbARbsBnv0x79gqOC82Uzi6mCnkoaSdr+1qX8j9c4m8=;
 b=VMaGdcFRxYBx7KmeCNGxyP+HgyKcxV0rNH2bwd3pE5tSynN3mrtGHu9G7mZEh/1oC3Qg0K/LYi+yv+p6ozavn2FY2djKye/BHruXa9XxO/UJotdpr7w+nYnftfBETrTyeAbtFVdBFH29FGOlo97pUo5B6nRkv8mc0ZTkmfy11GEecjbbPVzz09nePCs/N3Z4Kz5Nfe2uYWeCxAmcTfDaYTp8qniLihuGMw07zmFBAN1cHP0bRRp6/2j0qS+dsk8MYBX2xgvkuIDXk4mpn6Aymsc2xLkKNbw5aiMgqjEy00H+++42t3nAluG471YVdLnjcyXsfWIO3sWHePrEw9bH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbARbsBnv0x79gqOC82Uzi6mCnkoaSdr+1qX8j9c4m8=;
 b=Z5BcEaGDPB3dcjCt8V6Rk6GSHID1spAwC50OSwkoBTtHU4LmLz4eQc/LS+5s4OG/4l8HphHKGXjPeQbEGAPl9F9wFw/tNyNCAxc88aRwb76PQtwr/ibbQMWJu1ZLuW9kaUS2UB0gPHWyHPLjeB/PIM5mdyjDYsPAWPBv3kd56QI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3237.namprd10.prod.outlook.com (2603:10b6:a03:153::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 13:20:47 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:47 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 06/14] x86: Secure Launch main header file
Date:   Fri, 27 Aug 2021 09:28:29 -0400
Message-Id: <1630070917-9896-7-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 347e2a2c-beda-4fad-af9d-08d9695d7b22
X-MS-TrafficTypeDiagnostic: BYAPR10MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB323759C016C615975B4594CFE6C89@BYAPR10MB3237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CjDf79BEzuIr3bGxGyQGWWm+9t1RBWBBuPAWp/eFUXaq8soeV8k8kDV7hOtiqGTsPbG9Cw1clJjYxJ0NZEdI9j7U1Ex2EF/oz6z/iAHWJKja2heLDNQCIzmjnTZudW66BL05NxVRxivJffVpVkar+WbuUezbuAV72TYl954uC1C7PUwg4VVHr6Q/amlPUtZFg2JvMK/G6ZBQmi2PK+uJN3GD55MEnSxRwDeO8i9EJwv3rMYL1q2T95FlcgRYi5yDB+coF+yDaykRVjBVbiZ8oUOxfQauKt9m3RG5m8BAv62/7k35MSvIl/TiZqndh7WNkJOjRckBd6bb1L7WuZFqWg4IJ/EPUVQw0r8T+7wMSAZObvW40e+tGY5sCuiwD4Y5FmmPkdyGCCnkdtIJv9tw+2jc3NyqtEIKVMrHFYyj2BVhVqzdgaqYZYw1pafhntKT4EQRxCMuGWiVjc4kfwdlfdqlBJSp3y3f7GgKz8hVk1wYxr0ixRf5b7im8B8tpj4+OyHfx/MRIgXMyU9kLXcvc+v5OwneDf3k1FqqfrfXu60/0vEPlMz3kXSUQw+LL5ePg0saaUe6m6Gfb5xDcWnL15x/0VPl1LzAb8yYURAFX4Hl2GxF/HsrEzagg6E5hDw/jZ4q+HZG5eMUIc1kOWPMBY4jN24FOjUSbwaFcz/ONq2wz4p+eJ36w4y3bniElYQtp7cUSiUe0/a0zUCxCDDug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(956004)(44832011)(2616005)(30864003)(2906002)(52116002)(26005)(7696005)(478600001)(38350700002)(38100700002)(6486002)(36756003)(186003)(83380400001)(6666004)(86362001)(8936002)(8676002)(316002)(66946007)(66556008)(4326008)(66476007)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUFKS1dQWUgrZERVUkFwS2NpRWdpYlo1SExKenNIRzhwOUFLVnlhMEo3Rmxm?=
 =?utf-8?B?TlZkcHQzNDVKd0hZT0lKL3hzUFcrMThvbWE3dDdDeXBtQnR0Y2ZXa1RFYmRY?=
 =?utf-8?B?SEFGTjlxK1oyOFFmNFQ2WUFNdGlXVjd3NlhPd0ExaDJ3OElLbEI0UnFGd081?=
 =?utf-8?B?KzA5V3Z2dzg2UXh2ZFQ0MGlHUi9VVUFmeURtSW40VmoxOWNoSXhkWnpIWVBZ?=
 =?utf-8?B?RXhlbUdoUkFTZHZxY2g1TE1pSHFZb21xaSswemdUOVVOZng0NVJ1NmtvaVlZ?=
 =?utf-8?B?Wkh2QTdBSjNLUzNIbm5GUGxIRCtsdTg5aDY3cFRYZTY2eHFaS2hZQURRUjcx?=
 =?utf-8?B?QURLVlF2MkdrQVBUaS9MdGZ6V05CZ0VZL0NVcXBuMUJuNUpWbHRIYnA1LzdD?=
 =?utf-8?B?MlVFNjZHRjVPTktxQ3lRbWlXNGxKU2VvZUwxZS9yV2ZtcFovQlRINjVVek5n?=
 =?utf-8?B?SUpVOGV3dkdVZm9DekRlUGxCbW5CVEtMckhvSjdrV3dxdXcrWENKVXdVN2xn?=
 =?utf-8?B?MS9nZHA2blRxK0MzVXZ2ZnB1TjgzdGtiSitPRmpBd1RISUZYZ29VTlNQZnI0?=
 =?utf-8?B?TVJ5K2NWd3V6MkEwVzNYaUJrNHI4OUVNdStRYkd2RFN3Y1dRODdFSkZ4Nk9Z?=
 =?utf-8?B?RnozaTlQalArdS9VaUR3djczY1l6M01QY1N1T0p4aSszZ0RUTzAwM0hGbXVZ?=
 =?utf-8?B?ZWZiV3JrRm9jUlowanZPRksxR2V5U2hXL1VrY3pQbEpLMWRuMDVzQjA0VjR2?=
 =?utf-8?B?Q2V5V2lDd1dNZDFGWjltTm0yT1FFMHpnOUpNTlNRUlcvaThpQThYN01wQ1BG?=
 =?utf-8?B?MGVza0MzUC94aW80QVArUitYbGc0Ymd5NnlBMGJZQndXKzdEM3hTN0hYYU9N?=
 =?utf-8?B?T0pHSVp6WWRMTXd2U0NEei9yYUR6cE80SVdQV3FROHdvSjJlbjJQZDF3Y1Rl?=
 =?utf-8?B?Z2tDeXdNTS95eGJpb2JFNkFBVmhTd3hOcXpKa2lBbEJQVW15OGhnd3JENTNC?=
 =?utf-8?B?VGhpektmZVJDNUNCa2w3VGtRTGhDV0NTV2l1RG1JZWQvWGN6MUNWM0JpZ1d5?=
 =?utf-8?B?QTM3MDE1SU5JekF3WlZSMjJYa09yTy8rSFlsOFdjSlFNZU9pdmpyeTFwVXJj?=
 =?utf-8?B?TmlDdTMzWTNvMFlab3JMVzZDN0JGZUxrd05RdERuREYxNEtSakZsZkZBM2R1?=
 =?utf-8?B?NzZwQTkwcVNaRDlvR2lwR08xSEVRdTRCOEZUMEJxR0cxR0ZNTG8xdTZVWGIw?=
 =?utf-8?B?aUZNN0tqakVCZExONFdHVmRRSmtHYU40anFQcFhYb3pDN3pVTEp0bGhqa1BB?=
 =?utf-8?B?bjZXT3RocHBzSHJGVmRtZm14aUx6QitYcmlvQzRWdmFMM01Wb3BxM2VpYXla?=
 =?utf-8?B?b0krQy8vbVRTenFyUXFuWGp1b0VTL1RMZ1pIWjBCOWUzd3pITndaRjlqUFhQ?=
 =?utf-8?B?UEJONVlhYnRoMjRVdTBkZzQxOW94ZWNXMmFhd2lVY3orOHpKcXpjeWVYd2JZ?=
 =?utf-8?B?aHhlOWR5L0plMENhUERWc2c3QjZNWi9lRElscllnbkk4cy9IK0ZiYWJzYnVF?=
 =?utf-8?B?ZXlZZm41WjZUVExoN3Z5a2xZYjQyNzk0allJVnNVcTNBRFpoeXMzREg1Y095?=
 =?utf-8?B?eFRlUWJUdXFZTWg2bWdqZHhKcGMvc1crczVjcWVaTnBSZEJrVnFHVENuUExv?=
 =?utf-8?B?UEJmNkdXVWNxMk00WlZJS0YySm9jcmlQdzB3bENMakRNcTc5ZEt3YzhEV2dB?=
 =?utf-8?Q?iyHxFoffMWB9aCcQGBUQ0LsgUvglTp6El4ZyXoy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347e2a2c-beda-4fad-af9d-08d9695d7b22
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:46.9900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK4DSw9p1UNRkbbuJMoEmfUZLheTV1Fij0+75XkxHLjL+uDruwldGMPQBKWQtsg/jxV+YUEdsLipQTyKrwJ4GMrktq8k/qX/nlLmcwGNR4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3237
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-GUID: tuWC_Rq9DvL0g4WnQDB91iQT8BFWMr0D
X-Proofpoint-ORIG-GUID: tuWC_Rq9DvL0g4WnQDB91iQT8BFWMr0D
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce the main Secure Launch header file used in the early SL stub
and the early setup code.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 include/linux/slaunch.h | 532 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 532 insertions(+)
 create mode 100644 include/linux/slaunch.h

diff --git a/include/linux/slaunch.h b/include/linux/slaunch.h
new file mode 100644
index 0000000..c125b67
--- /dev/null
+++ b/include/linux/slaunch.h
@@ -0,0 +1,532 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Main Secure Launch header file.
+ *
+ * Copyright (c) 2021, Oracle and/or its affiliates.
+ */
+
+#ifndef _LINUX_SLAUNCH_H
+#define _LINUX_SLAUNCH_H
+
+/*
+ * Secure Launch Defined State Flags
+ */
+#define SL_FLAG_ACTIVE		0x00000001
+#define SL_FLAG_ARCH_SKINIT	0x00000002
+#define SL_FLAG_ARCH_TXT	0x00000004
+
+/*
+ * Secure Launch CPU Type
+ */
+#define SL_CPU_AMD	1
+#define SL_CPU_INTEL	2
+
+#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
+
+#define __SL32_CS	0x0008
+#define __SL32_DS	0x0010
+
+/*
+ * Intel Safer Mode Extensions (SMX)
+ *
+ * Intel SMX provides a programming interface to establish a Measured Launched
+ * Environment (MLE). The measurement and protection mechanisms supported by the
+ * capabilities of an Intel Trusted Execution Technology (TXT) platform. SMX is
+ * the processor’s programming interface in an Intel TXT platform.
+ *
+ * See Intel SDM Volume 2 - 6.1 "Safer Mode Extensions Reference"
+ */
+
+/*
+ * SMX GETSEC Leaf Functions
+ */
+#define SMX_X86_GETSEC_SEXIT	5
+#define SMX_X86_GETSEC_SMCTRL	7
+#define SMX_X86_GETSEC_WAKEUP	8
+
+/*
+ * Intel Trusted Execution Technology MMIO Registers Banks
+ */
+#define TXT_PUB_CONFIG_REGS_BASE	0xfed30000
+#define TXT_PRIV_CONFIG_REGS_BASE	0xfed20000
+#define TXT_NR_CONFIG_PAGES     ((TXT_PUB_CONFIG_REGS_BASE - \
+				  TXT_PRIV_CONFIG_REGS_BASE) >> PAGE_SHIFT)
+
+/*
+ * Intel Trusted Execution Technology (TXT) Registers
+ */
+#define TXT_CR_STS			0x0000
+#define TXT_CR_ESTS			0x0008
+#define TXT_CR_ERRORCODE		0x0030
+#define TXT_CR_CMD_RESET		0x0038
+#define TXT_CR_CMD_CLOSE_PRIVATE	0x0048
+#define TXT_CR_DIDVID			0x0110
+#define TXT_CR_VER_EMIF			0x0200
+#define TXT_CR_CMD_UNLOCK_MEM_CONFIG	0x0218
+#define TXT_CR_SINIT_BASE		0x0270
+#define TXT_CR_SINIT_SIZE		0x0278
+#define TXT_CR_MLE_JOIN			0x0290
+#define TXT_CR_HEAP_BASE		0x0300
+#define TXT_CR_HEAP_SIZE		0x0308
+#define TXT_CR_SCRATCHPAD		0x0378
+#define TXT_CR_CMD_OPEN_LOCALITY1	0x0380
+#define TXT_CR_CMD_CLOSE_LOCALITY1	0x0388
+#define TXT_CR_CMD_OPEN_LOCALITY2	0x0390
+#define TXT_CR_CMD_CLOSE_LOCALITY2	0x0398
+#define TXT_CR_CMD_SECRETS		0x08e0
+#define TXT_CR_CMD_NO_SECRETS		0x08e8
+#define TXT_CR_E2STS			0x08f0
+
+/* TXT default register value */
+#define TXT_REGVALUE_ONE		0x1ULL
+
+/* TXTCR_STS status bits */
+#define TXT_SENTER_DONE_STS		(1<<0)
+#define TXT_SEXIT_DONE_STS		(1<<1)
+
+/*
+ * SINIT/MLE Capabilities Field Bit Definitions
+ */
+#define TXT_SINIT_MLE_CAP_WAKE_GETSEC	0
+#define TXT_SINIT_MLE_CAP_WAKE_MONITOR	1
+
+/*
+ * OS/MLE Secure Launch Specific Definitions
+ */
+#define TXT_OS_MLE_STRUCT_VERSION	1
+#define TXT_OS_MLE_MAX_VARIABLE_MTRRS	32
+
+/*
+ * TXT Heap Table Enumeration
+ */
+#define TXT_BIOS_DATA_TABLE		1
+#define TXT_OS_MLE_DATA_TABLE		2
+#define TXT_OS_SINIT_DATA_TABLE		3
+#define TXT_SINIT_MLE_DATA_TABLE	4
+#define TXT_SINIT_TABLE_MAX		TXT_SINIT_MLE_DATA_TABLE
+
+/*
+ * Secure Launch Defined Error Codes used in MLE-initiated TXT resets.
+ *
+ * TXT Specification
+ * Appendix I ACM Error Codes
+ */
+#define SL_ERROR_GENERIC		0xc0008001
+#define SL_ERROR_TPM_INIT		0xc0008002
+#define SL_ERROR_TPM_INVALID_LOG20	0xc0008003
+#define SL_ERROR_TPM_LOGGING_FAILED	0xc0008004
+#define SL_ERROR_REGION_STRADDLE_4GB	0xc0008005
+#define SL_ERROR_TPM_EXTEND		0xc0008006
+#define SL_ERROR_MTRR_INV_VCNT		0xc0008007
+#define SL_ERROR_MTRR_INV_DEF_TYPE	0xc0008008
+#define SL_ERROR_MTRR_INV_BASE		0xc0008009
+#define SL_ERROR_MTRR_INV_MASK		0xc000800a
+#define SL_ERROR_MSR_INV_MISC_EN	0xc000800b
+#define SL_ERROR_INV_AP_INTERRUPT	0xc000800c
+#define SL_ERROR_INTEGER_OVERFLOW	0xc000800d
+#define SL_ERROR_HEAP_WALK		0xc000800e
+#define SL_ERROR_HEAP_MAP		0xc000800f
+#define SL_ERROR_REGION_ABOVE_4GB	0xc0008010
+#define SL_ERROR_HEAP_INVALID_DMAR	0xc0008011
+#define SL_ERROR_HEAP_DMAR_SIZE		0xc0008012
+#define SL_ERROR_HEAP_DMAR_MAP		0xc0008013
+#define SL_ERROR_HI_PMR_BASE		0xc0008014
+#define SL_ERROR_HI_PMR_SIZE		0xc0008015
+#define SL_ERROR_LO_PMR_BASE		0xc0008016
+#define SL_ERROR_LO_PMR_MLE		0xc0008017
+#define SL_ERROR_INITRD_TOO_BIG		0xc0008018
+#define SL_ERROR_HEAP_ZERO_OFFSET	0xc0008019
+#define SL_ERROR_WAKE_BLOCK_TOO_SMALL	0xc000801a
+#define SL_ERROR_MLE_BUFFER_OVERLAP	0xc000801b
+#define SL_ERROR_BUFFER_BEYOND_PMR	0xc000801c
+#define SL_ERROR_OS_SINIT_BAD_VERSION	0xc000801d
+#define SL_ERROR_EVENTLOG_MAP		0xc000801e
+#define SL_ERROR_TPM_NUMBER_ALGS	0xc000801f
+#define SL_ERROR_TPM_UNKNOWN_DIGEST	0xc0008020
+#define SL_ERROR_TPM_INVALID_EVENT	0xc0008021
+
+/*
+ * Secure Launch Defined Limits
+ */
+#define TXT_MAX_CPUS		512
+#define TXT_BOOT_STACK_SIZE	24
+
+/*
+ * Secure Launch event log entry type. The TXT specification defines the
+ * base event value as 0x400 for DRTM values.
+ */
+#define TXT_EVTYPE_BASE			0x400
+#define TXT_EVTYPE_SLAUNCH		(TXT_EVTYPE_BASE + 0x102)
+#define TXT_EVTYPE_SLAUNCH_START	(TXT_EVTYPE_BASE + 0x103)
+#define TXT_EVTYPE_SLAUNCH_END		(TXT_EVTYPE_BASE + 0x104)
+
+/*
+ * Measured Launch PCRs
+ */
+#define SL_DEF_IMAGE_PCR17	17 /* TCG Details PCR */
+#define SL_DEF_CONFIG_PCR18	18 /* TCG Authorities PCR */
+#define SL_ALT_CONFIG_PCR19	19
+#define SL_ALT_IMAGE_PCR20	20
+
+/*
+ * MLE scratch area offsets
+ */
+#define SL_SCRATCH_AP_EBX		0
+#define SL_SCRATCH_AP_JMP_OFFSET	4
+#define SL_SCRATCH_AP_PAUSE		8
+
+#ifndef __ASSEMBLY__
+
+#include <linux/io.h>
+#include <linux/tpm.h>
+#include <linux/tpm_eventlog.h>
+
+/*
+ * Secure Launch AP wakeup information fetched in SMP boot code.
+ */
+struct sl_ap_wake_info {
+	u32 ap_wake_block;
+	u32 ap_wake_block_size;
+	u32 ap_jmp_offset;
+};
+
+/*
+ * TXT heap extended data elements.
+ */
+struct txt_heap_ext_data_element {
+	u32 type;
+	u32 size;
+	/* Data */
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_END			0
+
+struct txt_heap_end_element {
+	u32 type;
+	u32 size;
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_TPM_EVENT_LOG_PTR		5
+
+struct txt_heap_event_log_element {
+	u64 event_log_phys_addr;
+} __packed;
+
+#define TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1	8
+
+struct txt_heap_event_log_pointer2_1_element {
+	u64 phys_addr;
+	u32 allocated_event_container_size;
+	u32 first_record_offset;
+	u32 next_record_offset;
+} __packed;
+
+/*
+ * Secure Launch defined MTRR saving structures
+ */
+struct txt_mtrr_pair {
+	u64 mtrr_physbase;
+	u64 mtrr_physmask;
+} __packed;
+
+struct txt_mtrr_state {
+	u64 default_mem_type;
+	u64 mtrr_vcnt;
+	struct txt_mtrr_pair mtrr_pair[TXT_OS_MLE_MAX_VARIABLE_MTRRS];
+} __packed;
+
+/*
+ * Secure Launch defined OS/MLE TXT Heap table
+ */
+struct txt_os_mle_data {
+	u32 version;
+	u32 boot_params_addr;
+	u64 saved_misc_enable_msr;
+	struct txt_mtrr_state saved_bsp_mtrrs;
+	u32 ap_wake_block;
+	u32 ap_wake_block_size;
+	u64 evtlog_addr;
+	u32 evtlog_size;
+	u8 mle_scratch[64];
+} __packed;
+
+/*
+ * TXT specification defined BIOS data TXT Heap table
+ */
+struct txt_bios_data {
+	u32 version; /* Currently 5 for TPM 1.2 and 6 for TPM 2.0 */
+	u32 bios_sinit_size;
+	u64 reserved1;
+	u64 reserved2;
+	u32 num_logical_procs;
+	/* Versions >= 5 with updates in version 6 */
+	u32 sinit_flags;
+	u32 mle_flags;
+	/* Versions >= 4 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT specification defined OS/SINIT TXT Heap table
+ */
+struct txt_os_sinit_data {
+	u32 version; /* Currently 6 for TPM 1.2 and 7 for TPM 2.0 */
+	u32 flags;
+	u64 mle_ptab;
+	u64 mle_size;
+	u64 mle_hdr_base;
+	u64 vtd_pmr_lo_base;
+	u64 vtd_pmr_lo_size;
+	u64 vtd_pmr_hi_base;
+	u64 vtd_pmr_hi_size;
+	u64 lcp_po_base;
+	u64 lcp_po_size;
+	u32 capabilities;
+	/* Version = 5 */
+	u64 efi_rsdt_ptr;
+	/* Versions >= 6 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT specification defined SINIT/MLE TXT Heap table
+ */
+struct txt_sinit_mle_data {
+	u32 version;             /* Current values are 6 through 9 */
+	/* Versions <= 8 */
+	u8 bios_acm_id[20];
+	u32 edx_senter_flags;
+	u64 mseg_valid;
+	u8 sinit_hash[20];
+	u8 mle_hash[20];
+	u8 stm_hash[20];
+	u8 lcp_policy_hash[20];
+	u32 lcp_policy_control;
+	/* Versions >= 7 */
+	u32 rlp_wakeup_addr;
+	u32 reserved;
+	u32 num_of_sinit_mdrs;
+	u32 sinit_mdrs_table_offset;
+	u32 sinit_vtd_dmar_table_size;
+	u32 sinit_vtd_dmar_table_offset;
+	/* Versions >= 8 */
+	u32 processor_scrtm_status;
+	/* Versions >= 9 */
+	/* Ext Data Elements */
+} __packed;
+
+/*
+ * TXT data reporting structure for memory types
+ */
+struct txt_sinit_memory_descriptor_record {
+	u64 address;
+	u64 length;
+	u8 type;
+	u8 reserved[7];
+} __packed;
+
+/*
+ * TXT data structure used by a responsive local processor (RLP) to start
+ * execution in response to a GETSEC[WAKEUP].
+ */
+struct smx_rlp_mle_join {
+	u32 rlp_gdt_limit;
+	u32 rlp_gdt_base;
+	u32 rlp_seg_sel;     /* cs (ds, es, ss are seg_sel+8) */
+	u32 rlp_entry_point; /* phys addr */
+} __packed;
+
+/*
+ * TPM event log structures defined in both the TXT specification and
+ * the TCG documentation.
+ */
+#define TPM12_EVTLOG_SIGNATURE "TXT Event Container"
+
+struct tpm12_event_log_header {
+	char signature[20];
+	char reserved[12];
+	u8 container_ver_major;
+	u8 container_ver_minor;
+	u8 pcr_event_ver_major;
+	u8 pcr_event_ver_minor;
+	u32 container_size;
+	u32 pcr_events_offset;
+	u32 next_event_offset;
+	/* PCREvents[] */
+} __packed;
+
+/*
+ * Functions to extract data from the Intel TXT Heap Memory. The layout
+ * of the heap is as follows:
+ *  +----------------------------+
+ *  | Size Bios Data table (u64) |
+ *  +----------------------------+
+ *  | Bios Data table            |
+ *  +----------------------------+
+ *  | Size OS MLE table (u64)    |
+ *  +----------------------------+
+ *  | OS MLE table               |
+ *  +--------------------------- +
+ *  | Size OS SINIT table (u64)  |
+ *  +----------------------------+
+ *  | OS SINIT table             |
+ *  +----------------------------+
+ *  | Size SINIT MLE table (u64) |
+ *  +----------------------------+
+ *  | SINIT MLE table            |
+ *  +----------------------------+
+ *
+ *  NOTE: the table size fields include the 8 byte size field itself.
+ */
+static inline u64 txt_bios_data_size(void *heap)
+{
+	return *((u64 *)heap);
+}
+
+static inline void *txt_bios_data_start(void *heap)
+{
+	return heap + sizeof(u64);
+}
+
+static inline u64 txt_os_mle_data_size(void *heap)
+{
+	return *((u64 *)(heap + txt_bios_data_size(heap)));
+}
+
+static inline void *txt_os_mle_data_start(void *heap)
+{
+	return heap + txt_bios_data_size(heap) + sizeof(u64);
+}
+
+static inline u64 txt_os_sinit_data_size(void *heap)
+{
+	return *((u64 *)(heap + txt_bios_data_size(heap) +
+			txt_os_mle_data_size(heap)));
+}
+
+static inline void *txt_os_sinit_data_start(void *heap)
+{
+	return heap + txt_bios_data_size(heap) +
+		txt_os_mle_data_size(heap) + sizeof(u64);
+}
+
+static inline u64 txt_sinit_mle_data_size(void *heap)
+{
+	return *((u64 *)(heap + txt_bios_data_size(heap) +
+			txt_os_mle_data_size(heap) +
+			txt_os_sinit_data_size(heap)));
+}
+
+static inline void *txt_sinit_mle_data_start(void *heap)
+{
+	return heap + txt_bios_data_size(heap) +
+		txt_os_mle_data_size(heap) +
+		txt_sinit_mle_data_size(heap) + sizeof(u64);
+}
+
+/*
+ * TPM event logging functions.
+ */
+static inline struct txt_heap_event_log_pointer2_1_element*
+tpm20_find_log2_1_element(struct txt_os_sinit_data *os_sinit_data)
+{
+	struct txt_heap_ext_data_element *ext_elem;
+
+	/* The extended element array as at the end of this table */
+	ext_elem = (struct txt_heap_ext_data_element *)
+		((u8 *)os_sinit_data + sizeof(struct txt_os_sinit_data));
+
+	while (ext_elem->type != TXT_HEAP_EXTDATA_TYPE_END) {
+		if (ext_elem->type ==
+		    TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1) {
+			return (struct txt_heap_event_log_pointer2_1_element *)
+				((u8 *)ext_elem +
+					sizeof(struct txt_heap_ext_data_element));
+		}
+		ext_elem =
+			(struct txt_heap_ext_data_element *)
+			((u8 *)ext_elem + ext_elem->size);
+	}
+
+	return NULL;
+}
+
+static inline int tpm12_log_event(void *evtlog_base, u32 evtlog_size,
+				  u32 event_size, void *event)
+{
+	struct tpm12_event_log_header *evtlog =
+		(struct tpm12_event_log_header *)evtlog_base;
+
+	if (memcmp(evtlog->signature, TPM12_EVTLOG_SIGNATURE,
+		   sizeof(TPM12_EVTLOG_SIGNATURE)))
+		return -EINVAL;
+
+	if (evtlog->container_size > evtlog_size)
+		return -EINVAL;
+
+	if (evtlog->next_event_offset + event_size > evtlog->container_size)
+		return -E2BIG;
+
+	memcpy(evtlog_base + evtlog->next_event_offset, event, event_size);
+	evtlog->next_event_offset += event_size;
+
+	return 0;
+}
+
+static inline int tpm20_log_event(struct txt_heap_event_log_pointer2_1_element *elem,
+				  void *evtlog_base, u32 evtlog_size,
+				  u32 event_size, void *event)
+{
+	struct tcg_pcr_event *header =
+		(struct tcg_pcr_event *)evtlog_base;
+
+	/* Has to be at least big enough for the signature */
+	if (header->event_size < sizeof(TCG_SPECID_SIG))
+		return -EINVAL;
+
+	if (memcmp((u8 *)header + sizeof(struct tcg_pcr_event),
+		   TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
+		return -EINVAL;
+
+	if (elem->allocated_event_container_size > evtlog_size)
+		return -EINVAL;
+
+	if (elem->next_record_offset + event_size >
+	    elem->allocated_event_container_size)
+		return -E2BIG;
+
+	memcpy(evtlog_base + elem->next_record_offset, event, event_size);
+	elem->next_record_offset += event_size;
+
+	return 0;
+}
+
+/*
+ * External functions avalailable in compressed kernel.
+ */
+extern u32 slaunch_get_cpu_type(void);
+
+/*
+ * External functions avalailable in mainline kernel.
+ */
+extern void slaunch_setup_txt(void);
+extern u32 slaunch_get_flags(void);
+extern struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
+extern struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
+extern void __noreturn slaunch_txt_reset(void __iomem *txt,
+					 const char *msg, u64 error);
+extern void slaunch_finalize(int do_sexit);
+
+#endif /* !__ASSEMBLY */
+
+#else
+
+#define slaunch_get_cpu_type()		0
+#define slaunch_setup_txt()		do { } while (0)
+#define slaunch_get_flags()		0
+#define slaunch_get_dmar_table(d)	(d)
+#define slaunch_finalize(d)		do { } while (0)
+
+#endif /* !IS_ENABLED(CONFIG_SECURE_LAUNCH) */
+
+#endif /* _LINUX_SLAUNCH_H */
-- 
1.8.3.1

