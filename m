Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA53A3E49EC
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhHIQcF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:32:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6684 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233023AbhHIQbt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GBn5L024019;
        Mon, 9 Aug 2021 16:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=L7gypYGtph9ns61b3nol/EKGhu+qMVQmD50UClf4NnM=;
 b=boH1kw/NhMqHk7GMW+IR2iIdSErOmY8rNdMCF854u4uP2hscYVmZKsRFNVljawNRIdcy
 p91aEFj19X+8r0wdu52gAsOEjj6FsJot4Iiil+j7uKN02oijZQ3+U15l2Imcer25DskQ
 O4Sk66gEMMDbypD9vFpx4KroVUvzltLXi528M/jDQYye33ykveMQ3L/0w4kDZy0Kdmwe
 Mfb1SJ14SED788IY7q7wu6JL7O9jUaDuTLjH90GHnji2it6VHFuBd3nbxUSgI7PPJV4j
 mNvsK+Jtph+pYh9IUUvQEufJLZlM1B5o312R06HVuIoDP57bxgm4n3ytDS19UV+/bKqw VQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=L7gypYGtph9ns61b3nol/EKGhu+qMVQmD50UClf4NnM=;
 b=x+xblVMl1vskeWj0VZ1v4NJJ+TujCD2IHAKKPrbzN/PjYvPeK/nPgv/CbI7lrMYe5bzl
 /kf5ow8SM1hH0dua8SCoYr5iweiqSkwnkwpY6FqKrMenz7IfkL0wROrt+Grm7VGujpbF
 ZAo/D2nTFFuylLoY7QU8EYthb39fkneligKgnGGbJBBNXy1GmNJ6xzKj0i3AJ9Bz9bDc
 9xZmwigV6v22Nox3q5AOLLGZlfGnWsED106iYXXa3QsM0+8wRcz27ZN3yHywjM+8W+l1
 fBohObE/dbEChbTIQAAWa/3Ujl6iTEGAyhCZAx6+sAM39+i3dtTThG+ZS+M0IMbroUTa UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0fsdsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUmIe180824;
        Mon, 9 Aug 2021 16:31:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 3aa8qrm6pp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNWZMGJ5HEhz9kn0Jt5BLYZ2weO1gBfNJoiq+SuYR8dEnMjeoJblaPx/MI3KpJAewGFydtDiPiykGXGm/ZWjYm/JWx4uyVe9QSSZKZ/OVhA8LFTr68oUuTpWSnExVVQ31yG6nK9zNw1ADSyk3ch5G4sJBbKTuqqGRgO91IURcQA1yIyJ7bZ9HEYJReLBwfd75xd72zMd8JvWa0pOdYdf4m34IihCaJLO0ePJPQFN9xuQ6UeLKVcxlxrAmvdbq3onwobxzBuHN0umo2/M6gnQ1K9YuZjggx8PiFS04dsJ9NCaCzHSDukVJpB6QNnLzyFJRWQQTwMD/0OYHCONVg7vHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7gypYGtph9ns61b3nol/EKGhu+qMVQmD50UClf4NnM=;
 b=HfzUq2qLvqSqUvQTygx5hvT7Ga9koQngqu4321HaFBAD2S6emEkZaSwR41NFKeYezZJCJCySy7FLWOFoKE74/tsN2O6yCh9eT7DDwl7ZdDOC/9RaAn5VBfktzSqjBWF/MKtnDGp/M1l2lolM2LXC9xPTb12Lz5KZqiXwVaCvx5QfY8A4bv1JZds+vdvLedq9BrC9zB2F16G6z6SOEcco/vVDsa1+1smgYN2sSJ6drvv59O0bxwgVepbyk7aaGl+ucu4VvSEV2oZIJFQjoz4d0QbBAtu5x6NDgRIRYibzZH7pk2NSpY8f4cFfODEftmJsPc8xKZcFOOJeWLRNIzn+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7gypYGtph9ns61b3nol/EKGhu+qMVQmD50UClf4NnM=;
 b=mSAF1QN39ajf+Eqr3AGKF8QESPeIGeSo62p9zkCNfasebQbNEewxjVcy0Qm1N+VmK1VAAXtaLrxB+eB/f0ZcwmU0+unwKGa50ytRckJq7pWUfkBPf2LFe4JXfucFFGGmJ+UZhY2JgOCMj3Nexns81WV1asiL7dZT1NBp9fyPtfY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB2631.namprd10.prod.outlook.com (2603:10b6:a02:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 16:30:48 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:30:48 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 05/14] x86: Secure Launch Kconfig
Date:   Mon,  9 Aug 2021 12:38:47 -0400
Message-Id: <1628527136-2478-6-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:30:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98b88899-9402-41ad-d8c4-08d95b530b79
X-MS-TrafficTypeDiagnostic: BYAPR10MB2631:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB263107C38D6944F55C63DC6DE6F69@BYAPR10MB2631.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zAHnYnzT4/ZwOQ595Icx8y9wwpNCTtSNGf+XX9WbpOH9jI+gJStXQBeTRA5mRsyO5HAhyIKPIHPW9n3O0YNu9Wj3hGkedQyPNxH3lgWi+UJk68QFOHwx1X4g+30CnBIMkFQU03ZMe8PkVrJ/4sb5KUDpbgglWF7hwICImnG0kqdElE9Ro5wS/LZcc7Kb0gr8pSDvJIbm11onWl3nHZQU0CE2Gc/aZ4EhDhiuJxfwvzaKMw0v5PSgY71Bs2Dsh5bUJSBdt66ojQdyqNp1PvL9N1oKw1soE1UFJQrmx7YmseQP1oHDpEs4EOZtyZ1HrtLZmMhVo4kOjlFznojhmbX7OKR4HgJ0DHto7UN5EMPqiX0CLsKNUIoUer8taRzNaETnD/67yp/J5EVqkU9D2LcAR++MB5VrFXwEqPR+gCN5VGYg0l/2pwxStbNI21DHesXOJcMf6BOdegny6zAshikDmGplLHHdl+MUAhbEt/Ci5aPkpGTw9qFN/FYqSS9e33lKVFfmrD71Ze2ihx9bs+X+OWoNULxEfUOdTWZ9mvJ4sapmMR6WURDT3OFSbf8bB1h0XOARZOcFRiM3Gm0hel+VBQuaFw4LThpf7KLWDuobtisnN4PQNZ2GLdUooIzHPG0RM3xsSGJdjfbS/00/AO1E0zCgV+D/ZunbsLUMfjfkkdtAOyw72Xt9hSE3eTM3xo3xJzLWQ4aXDCFvFfJvSNDnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(4326008)(7416002)(6486002)(36756003)(8936002)(478600001)(26005)(2906002)(7696005)(52116002)(8676002)(186003)(38350700002)(38100700002)(66556008)(66946007)(5660300002)(956004)(66476007)(2616005)(86362001)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+lpVV4viUj3WQmAlUztkhwlwq7paj1bPipL+kVIM8nchDNUAjylIjND7Z2U?=
 =?us-ascii?Q?3biENAVZ/ZIhj52VYZVqeoMPnwa2myWmU1qTnv0u/5X4nvBWCDzUYFhZLPtN?=
 =?us-ascii?Q?zD9VKHxuITsGjtZojiEUgdkz0v49AlNK4D7ppujE1pzmJYmM4TGMDkj3XKUY?=
 =?us-ascii?Q?RE9rO37PR8hsmckFy/iDeIUz48AqsSGN94mBQBQynAObdW4+fh/RbXSKrIeG?=
 =?us-ascii?Q?ZFQS5NjkZImBdbnv1fnig8vBamJWMRHH5FPb/e4298MeDSij8F1jke4ePPZH?=
 =?us-ascii?Q?Xo5p0WcxlCLDs+HzoKk5I2Igr2IPVIgBUQ7FIS3KCSxhdFs6KGndEhl3JMCt?=
 =?us-ascii?Q?mLF81W1NMZb6mL/FqgxP11/SDMwFL2+P/uurwZ30FOOqkRengSdn9/VlGzgd?=
 =?us-ascii?Q?/5NEIYHM6alkrOTzjAIviIKUimyiHtLfl6arqB9ugGc2SVlWTvybZRdSxZlF?=
 =?us-ascii?Q?vqX97+uuM73W9GPNUCUuSNEKBYfYgMzzs9C3jrOONEniQ9VPqRm/5/V18MYr?=
 =?us-ascii?Q?jur/vuODc3Bus9CP3gS6upFlwz3LSE2sweHBXpYrhC1EeCfJ2kx/YpFjUUk/?=
 =?us-ascii?Q?DNFBWZKACWqck/KT5gYQUaVJD/bhI8t2V1CUc8HRfz5bhrLF/qa6jtBYdnW5?=
 =?us-ascii?Q?wO0A4ekfNqVa9NeVg0AqF1sHxhCwVipgDd8qX+7zFvG+fGgcRRoPxI2JuGHU?=
 =?us-ascii?Q?Z2EKVaSfW4huJ3mcA85aGk5bypxhK6SFs4nZ5Qfg9EvefEs5Jek4r6KbhvYR?=
 =?us-ascii?Q?A92B4zBIff0DqpQsRCevP9l4I7aoeb5fer8faZXrY7voWDtiu3OVG4eJEPWW?=
 =?us-ascii?Q?KGmko3nqt7+5BXVOWCy2nVmSqTlhvPJ9CS3djC5jGGi3y0KeU6H4RKFIiSQ1?=
 =?us-ascii?Q?SaMvNuZvja6sxJqPfiKDGbz7K7EKnj96sNyLUm2R8tmmABmEYFliQtNMeTld?=
 =?us-ascii?Q?vMRs0Vty0LAow3rC75+GWsMVj7zjypbACI+V+zJ/kecHSxvVyyXTp3f9rLP5?=
 =?us-ascii?Q?VPMAAGbzLITqD+0vbR7S7TtvUdEz8DeHv03UjTCXA+gXvtyOVu5ylzUjAXpI?=
 =?us-ascii?Q?rPPg3hfAXURT6Adbp4zLNpn9gHQTxQoPaf4nBlj4YaHIj5lRaQ33oA7FtAeW?=
 =?us-ascii?Q?njkIAoaaA9kkg++oNBNAtCqrtEjuGPLyCOidp3chFW4UKPT8aocVQ5ANeHUR?=
 =?us-ascii?Q?mOZPbz5oS5VxpxP0fRso9mOhi0RT7oertK8gIzatze9DL2TG4oHRB6saNyC2?=
 =?us-ascii?Q?q0fL+y9KeyWtWTLJ/uZOXRt+XTFwgUxJPu+K3/QFGVNWROUDEE/P5GMIln6T?=
 =?us-ascii?Q?w64urIbebHTLo2onzVu8zZMJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b88899-9402-41ad-d8c4-08d95b530b79
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:30:48.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbjNyJfT+B65Oc/hOwrdsyYzV1MaQbD+UBbKZ3a9f06lYR4fLfR2H/gWyJAvwYzJaqKV8wDjdFGOwWEJp8H5OBaIO2J7ua+vWZ4hJ3cNLqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2631
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-ORIG-GUID: Eud8rSFtptUsaJJIu8LitoxbrDxivRv7
X-Proofpoint-GUID: Eud8rSFtptUsaJJIu8LitoxbrDxivRv7
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
index 88fb922..b5e25c5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1949,6 +1949,38 @@ config EFI_MIXED
 
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

