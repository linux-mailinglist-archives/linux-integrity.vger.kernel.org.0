Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F113E49F7
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhHIQcO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:32:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8618 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233204AbhHIQcA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:32:00 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GCXsp017710;
        Mon, 9 Aug 2021 16:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wbARbsBnv0x79gqOC82Uzi6mCnkoaSdr+1qX8j9c4m8=;
 b=lFnqAQGBy3gPN9lcUx+1/4pNQ+8jP1IZj/Edo4lU0ofeQ5irun2u7KgnWJPGf/rx+9QA
 ZXKi7Wxq/zOelHvMZTGbDU7ALg5PTWSjheKfDZ/o+46VEHb9gGgoE9RKRbuP8ykb1F+G
 K4OUWNrPKa8RGNlteKMVuqul/DrLAaDK6Znemdy3XdZv7lJ6ou1uB/gd1hgeHVwz9GFH
 yiASK4rrDHgFWXT/lp/eU3ZjIu1FoDynsS/EIXCll8Gaclccmi4wUAvDps9vz13gB7gZ
 onTbCN/NCLPWBe5uyafCuu9+YfenNxn4fhaTrkpA0sD/+aAN8uvfwpcvEInHDpImvMkO 3A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wbARbsBnv0x79gqOC82Uzi6mCnkoaSdr+1qX8j9c4m8=;
 b=Ikwt4cjABt2n7NIrEEB+Izd0Z+gbL/QGy9RuiBxyUCjmipAoZgJ0PYJJs7lqe13X7qeE
 E/RUC/1BIIhYjyVpyYqvyIvCrUkD+X0UvLvypQ24B9mGUBiydWVNwJnWSCbtPlslU8cv
 dq3GeuN4rMn2ZBVnCvLH33aCo9r/c6DCY8mYUHnUmWxo998AnaS/NUJkMxIOBvdnnLKP
 HIMW2znQgklnPSjCiQnQbbOLedZsizZc6tCYaoWoz6OGOPmqmoyXy/pQzRgLbxVXlOH+
 91EMn5JU8sBO8kywdBPpCYu4Q99HiS/a4Ql3q0DWqcTXtsePMiJo5v8+EgG2ok0lY2WM 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab01r98m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUmIg180824;
        Mon, 9 Aug 2021 16:31:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 3aa8qrm6pp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM48ah20R3kJ7wL4wPzAGYToxoMJE4z785OoR/pSzOaIcAHD55PSJiG8kl1fqHTV3VLtrRPo2hT8A/EG2Lojlq9dkNO7FV3JgYoW7/FqTv8VMvug/hVptqRJhDQ++gBj25ucXDjORhgaf4IOb3piLtLUoXRpNXD2gCJm7zrwGVcLrdSfiXvUrQRFKBrrlLQ7lTiLum+SE2i1Q9lwsVg7nVdwqNZOzoUBHd5IdLGz9yahe4SxeXSswYlan+SissNoVicr0AqrNTKOSuC5ieFlicq0nDNFIOH2k23ftyHAnBlgENbzv+4RIHn/Qjoo9VJIi/8Jv+PBQ9inC81UwCFnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbARbsBnv0x79gqOC82Uzi6mCnkoaSdr+1qX8j9c4m8=;
 b=P/7U2HI32d6SLubIK0uEi+hGPvwMAzF1IW7NTZQDNiPCCVytEKSyeRhTPDtgt14M6aLJzhHb22F3jrwpg0ej6k/cj/ahcp/n8dyNi/pCxSPxhQk7XD4fOnjm5HL3KngQ8Di0VOJvaEyGyWaR9WpM8uXp9745O7SjcvqYp1BG/FSpJZOs4ukIzhZnsH7v8/tC0pKbOC0fzzQD4Lmfon10J76dwYH5k5nuONsN6/VEQVlZyfr4XNsuj3HQTVsyv39EI3s5G/OlEGYfadYDwdddCPU4D0T/IoRv+6OOgo0o1qwDbtsxxPyn2de6qrFHYoGqPUicSOUZ5BTIEkP7wvJn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbARbsBnv0x79gqOC82Uzi6mCnkoaSdr+1qX8j9c4m8=;
 b=JQf/juDFlewlOt2cX1Drr5kVo8m2TA2+WLefd2hmLApbSqA3o6ZUVXBxTMNdL/gTDqT85qhHQvqILK3jp42iR2EcantCkdDaHI5HoWz6HzMrs6uX0vHNboCrjIPb33JsqTf0H05lCU4w0wvmNspUq5Z9uu9VX7dKcBeiMG/wWPA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB2631.namprd10.prod.outlook.com (2603:10b6:a02:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 16:30:50 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:30:50 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 06/14] x86: Secure Launch main header file
Date:   Mon,  9 Aug 2021 12:38:48 -0400
Message-Id: <1628527136-2478-7-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:30:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ad0423d-9190-4188-912c-08d95b530c8d
X-MS-TrafficTypeDiagnostic: BYAPR10MB2631:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2631E3D98ECDDF7DA037719EE6F69@BYAPR10MB2631.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wl1bjDlYPHkuxw0jtPPgJ8IpgC30d5nGc3U/jH6ztQf64uSb3kIx5TctjmWAA21kJacL01VPAvusNxzEbWgt5Rt7TW3pF51U+bfsF33gqNTwdfvTsSZXaHk26SWPeBZ1Tze6ENo+Few6y/Tv1+6TPrSWCF5R+M2uLbvqG02c0d930WrPVFfFpnxKSfdnVIyLVUpnEZBC/tlSldNUOOSLA0gubRs3RP9Krp+XBqM+slnA9j5X90dxfjFJ3DtoIGHcVF77nuISAzAfZhbwvgUnB22nMTpoll2X99oHi2STe39TstrNqMzvFh3nX0CF4uj3IVJfvXBM8v6/uxcWN21RMmnaGgDDcpX3bcCsn+2EvsYZs94U2hU/47TrmUqIV4l7mWWoBLv+xMZk/a63DMvLoewJNyiv3qAZFJ5m3Z/QAVZw8dULVQRsk9nA6lnem8KrKjDBzrOXn5aC6jsk7b4fzKUMDYWN/HxfM7xxPPDFuIcR+B0Ri1pjhcUW1yXS/dQCjjSjhVKHzDe1R/lv0Sv4mjBXZbpLV7UQb4TAhC4NylRe3ntYFZcmPKYmfC1TEhvKKm9IvSg8spqG3mbv8bX7s7PHr7tk9yFDIQ2YtlNWtoFAsUBx4VPWMAEuo0fWgD5GRj4HA+V+YTP6D7kkNB1z4n16AYxVZuI5qpAmIgOzZ++bTg3MyKXKhZo3icGJITPCVMsTb/SW2cs6OtL4d95TsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(4326008)(7416002)(6486002)(36756003)(8936002)(478600001)(26005)(2906002)(7696005)(52116002)(8676002)(186003)(38350700002)(38100700002)(66556008)(83380400001)(66946007)(5660300002)(956004)(66476007)(2616005)(30864003)(86362001)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azR3WFllaFIrMnpVZEh2UnZramJQMFZrNXFYU2FhT0k2U0hNVHlvejdGa29t?=
 =?utf-8?B?TVJOMDFYU3o2V3dpQWoxOXRUL3R5UHhZQndSNSs2ZDcveEtoZk9nZkJPcUwv?=
 =?utf-8?B?ZnNPd243NTV5YnNISlR1dkZtZGI4cVVvQVJPVFY4QUpsUGxYdEVNZ1BUNXdW?=
 =?utf-8?B?MzkvSHdBcTUzanZsK3VTTWwzdUVaS3I5YkFTQi9tVWJGZ3BCdndvZ0JFMlZJ?=
 =?utf-8?B?cC9mSVJ4YjRLVEwrTXAzWWpZNTEweUpsTEdmaTRVOEN5UEdITkgrbnYvODIz?=
 =?utf-8?B?RTFTczlQUmVodERuUU8veUR6UWFBZ2dHaUd2eVZieVZIbmo5TEY3Yk1oSkJJ?=
 =?utf-8?B?NGpqV0NCaDdwam8zMkl6ZElJbENxRFBibzIwVzVRYU4yd3hTRWVJb0dmUER3?=
 =?utf-8?B?QWgvelo2c05qdGVCS3JsZERZeFM3SUhCcGVuSTVudTV1c2duMXRJcFVIOGta?=
 =?utf-8?B?dlJ1RHUvcU1UOGs5aW5KR1Vpai9xaTBwRitiMXJBTkdFVWNEU21ub3RLeitP?=
 =?utf-8?B?VVprY09rNllCZVhpVWZqTWNuVDdjUUMxNlZvTVhJMUgyZzZJQ2dmUkcyYitC?=
 =?utf-8?B?Qlh1bDFhaDBXQ1lnMnlvZEhONVRsekxLakhUbFBXV05DbzhhQ3NWSUMxbUo0?=
 =?utf-8?B?ZStQZ3A5QVg4QXVLM00zbVRPM0VSZTNaQWJZaUpIYkYrbTFlQkh0eHhJQ21I?=
 =?utf-8?B?UVUvUUFUeXROckY0UDZ2bGlqWkxYK1RqOHM3dDI1aitVNEpINTFiaURjMW1M?=
 =?utf-8?B?MCt6aEE2WTVMd3ZTMHNPREpYSjB4NmpPUHRlWkUzYjNhNzlTanlYdWo1ZzNV?=
 =?utf-8?B?NzFxNDEreEpzSG9zZm9rL1hYcGRMbkh2akoxQm4yQjAreVlsOXBvU1lJZXZh?=
 =?utf-8?B?b3hZaFd3WExIb3c3dEVBcXp2UHBYL2V2V2ZLVzR3M3o5UkEzcHRVMHpOYXVW?=
 =?utf-8?B?aDdqSUUvb1Q2STNPRit5NWR6bGN0NkFMdVVZWWtWeHluemp1MjRvWjhKdnox?=
 =?utf-8?B?bUF4S0o1a3NMbW4xTm1hRHVTY2pFRnAzRXZmMFVRUVhqTnM4UHVSSm80Rlcr?=
 =?utf-8?B?aTlyYy95ZytVYW56NFhUdzZRQVNTRnFJWE9XWkNNUEVlYWVCTDV2OUx3aThQ?=
 =?utf-8?B?YXZHUWZ6N2lYbWsvVFFWRVRSMUxtb3RvZHNURG9QYzVrSHk3YWNnN1VUdm03?=
 =?utf-8?B?SEV0TzRJUTZFZ1AvdXZGTG9DWFZqRmN1ZTJZTVkvaytZcVJiM2pEbGZtdTJ5?=
 =?utf-8?B?a21LcHduWFRodDJOaE5JSEdPZUNMWUF3bFl2T3dSM0RXRUQ3NzcxVmkvcFpE?=
 =?utf-8?B?ejQxVDBOWjRLUE9pcWsyN2FOVVl5bkVnZVJXZWVNSEdWY1VJd2VVaTRRRk9M?=
 =?utf-8?B?d3RSN1RoY24wRUs1LzV3T1dyNkluN1pDR0Z3a29DRUlIWkxBS1FGUFJiMjY1?=
 =?utf-8?B?WlVuWHduTkdISnJINGdjYzZYU1lRbHBzWGIwQ0V3aE15djdhWFBWbEFyQzR5?=
 =?utf-8?B?MFZUbFZJNEJUbVExeHA2R1lBeVlFdW5DQURHdWUxYUVXY1lqQmNFWXFaVE1K?=
 =?utf-8?B?Q3dQREtoblVDeGp3OUkvdC91anpkU1VZMmRWVnI5eDVFS1g4Z1loTDdhUi81?=
 =?utf-8?B?aTc3OVkrMHlQUG0wOXVSWStrN2xEaVd6elhPQnRnMTNscmM2ZlRGR0NkVkRO?=
 =?utf-8?B?SllmYTJIbzdwUUVWQlkyTzVNZU1BWkdxMkZnT1pwK21SYVVOV3I2OEk3UXJB?=
 =?utf-8?Q?/8Fhbq4xejId7tDbjoxw24CofCNdSOgvKbgzaXE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad0423d-9190-4188-912c-08d95b530c8d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:30:50.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbRn7Ij7WEypvoR/Gz7ZxixnLL4FaExDRFfLEXupYb8zBdHQxNBjE3NPGIAt5AWpHB09lxllO8OFYgz5DgU38lKRqE02B428CkgBkf9T4RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2631
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-ORIG-GUID: bYxsSXbUiw6d-0CSp3zjYrt-zkE3tl4j
X-Proofpoint-GUID: bYxsSXbUiw6d-0CSp3zjYrt-zkE3tl4j
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

