Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD14BBCE7
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 17:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiBRP71 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 10:59:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiBRP7H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6E95EDCD;
        Fri, 18 Feb 2022 07:58:49 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqnVS014538;
        Fri, 18 Feb 2022 15:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ou6W7mvKj0gXLEuJPe+FFmoB8bpiCpvrECdhSVgq3hs=;
 b=aOQGegT42rDiglHZLoe8zAw+M9D+z5PARh10ipFsFECmQst0+V9YHbWPGJnxkdblfexz
 dy+TElozu235UugvX/QB+AfaXUwaUadGaD7H2Gy79uyVUMgLRErfN6czy7DnT6yAeAOk
 ZlUnZosxQhmNkTyHni6ifkQcBLDzB3Szx9udQJGmyLCRttOQ25hVWE9IpTCy/GHm8XG1
 HOxOaed1cUAW8rSoUqNYohnWyr2UVlWI2JFZpkcI47O81AJVyJD4fAWoghOKqY2fm4pL
 W2mT1FGdT6Vmo0Qq/3oIq7AQoc9cNaQW/vtKecx5U+VypN2naXIGMttlYFPMO9N4QDZp uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncb1y1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFuFXi014574;
        Fri, 18 Feb 2022 15:58:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3e8nvvhsu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGr78j5RDCoXViKARYwcmonxhkNJo8MnTfbLjBjJGtkEbuOL4HJCZeeN9pv4C0rMuUF4OSKas/JVbdnlN3wKQ3id0/7v1LAcMtW06r6kXIcnYsLe8D/x6ERKZ0A+OGuZgbNOHwbSjHOXR8pCOArPvsidf+FSgEJM78W291anHUhDPCh/cMd6bJims8KbpsB8L8yV9sO2ksUt5PfPa83SHT+r3ZdzJp6QNgwCjd9G9tRkUsqee9NiyE8VZZ7JkOeliQFqdP7uIB2jKwC4duyicPmWfde7ebKiiKIinrkD5oTvi8ULIkup9J/hbmUnvldKhh4fQ0zsDpgmno5Wf1R4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou6W7mvKj0gXLEuJPe+FFmoB8bpiCpvrECdhSVgq3hs=;
 b=QjlCCNVmtZbRicGXBuj2rSA6DKmMEagCF2KDbO+MvZOMqTSeBO4Dndq/bRqAvLdHl7ZNW7i5l0Hw+T73i2VUdYxmc/CIuBvY1N0+5I2EJtUgqypo53SzKP+pft9JEXk8BHKfOVW3+y14bfKR0jPIdqHPHIYtAyKm5dtXYEFxqpkpHN/oViWBnS9P/gJy1IXjFlzJjVcAiPU8/3Ohh9cuRKLW4To8krVN5ttlmdKDzYocOao9RFpGOTFvm0wbqQ95r21fI9DqL2LWsjkScji27mVLZ52ERpkYg8ZEvuJzzMNf/iE0CL5nHUFJLY4KVGSovTTCv7mIuRyGBeAHwoDcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou6W7mvKj0gXLEuJPe+FFmoB8bpiCpvrECdhSVgq3hs=;
 b=MLyS2wuYkeNf06HQxhppkPZzUlBC9ZdUoyBawazToropaLCcFBE1y2f9UpYf9S5RNu3cuVVd+YWVBMAH0beqUxfi4cnb5ACTcXA5y8JGE7gZ5KgoqxS8ft/pbtgKEXsZXlmP6BL1Z0gyxDJ/OA+Jr0U7/ZjGo9MM7FFC9wtA1BY=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:12 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:12 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 04/12] x86: Secure Launch main header file
Date:   Wed, 16 Feb 2022 22:54:37 -0500
Message-Id: <1645070085-14255-5-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38d5128b-384d-4d7d-1131-08d9f2f77733
X-MS-TrafficTypeDiagnostic: BY5PR10MB4226:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4226678D47A2BCCFEB1084AEE6379@BY5PR10MB4226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNWf0sRcJWFEy59uhZ50H/lTlHtHdBDVRLItKs53mfQ08QIAmOztv4m16X6GuehhNLq6cgRLVDPGNH+QjOLZg7wqtiG5sg5r9pKtvvzYWOSN5odMbJkqjb2wrxTlD9XzSUwIIFLm/jeQALWsSW8M4R2fttvjNOS7dYVnPB9xJhyMpa/PptHi9FvIgPPvy3xy+BX/EJ1sDJDhaiNH+Gk7/pIXQK3ZWgAC2lK7nAtOrMdQjBMGTiKNtpIyY4Hvj2A2x/GdEBKpRvAbMeGzjyC6SpEaFCSUCB8sOPLz17abs90dvnBAxuG+fdD4W78SYg5NtMmvAINApVSWNRnUA//++UY6rJcexXbxfGf9lSWOD2Y+MXS6eF5xZXSGGhO/q6W9tJZ60w0aOh4EmZfTFTQUBG3l5kPq9tQj+7MiESMeDA25qNwtZH6oEVVSzdM9r7PS2wJQSbOg5V7hPvWTsC9u7am/Waem8RI5WUBdFMn0A6DLrXsrq/rCO9RGtLatrZ2ID5/fwLH+QIHsEp8jY82jI/yMyVdBWArxyEEMtfX0NPpHP2GGsow4fMdAfyOgBl+ZVFSEAv3k6IB8kZzczdQLdBQ+HVDY1h3ork34bm3459Il9JM7I4OtkJv85iobqFhjwaYltYH5nyvLjqBME2lpay8NwBeeb142P846muQo/b8366xKhWuUsaqMCqlfdPwK3IMxhxrye+ATer9pIMkdfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(44832011)(86362001)(5660300002)(36756003)(6666004)(7416002)(6486002)(52116002)(8936002)(83380400001)(66946007)(66476007)(316002)(2616005)(66556008)(6512007)(38350700002)(38100700002)(186003)(4326008)(30864003)(8676002)(508600001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ZFMWE3bi9zRjBRRWJvL2VrcktYbHF0WUZhSmFWVWEyNzB2cFJDTzZ1VHlr?=
 =?utf-8?B?OU12R2tLZG94a3RrNlh2ZGdRZHg5N0tUMllVL2R4S041aHVQZDkrT3BrdzdK?=
 =?utf-8?B?aVV1MGt5RkhHVlpHd2dvWW1yNGhIRjNaTzZMaGc3aEI1Z2o3aCtXdk5aS2Z6?=
 =?utf-8?B?UXdRd1RwQW9yMHhzYjhEbENXUzIyemUvRFEvcXhYS3RsajFZQkZVa2dBdXlo?=
 =?utf-8?B?c1Q2UC9CYU80bytUQ0V3RkJ0QlVpdWlpMWhxODJYUzFqR0V3bWZQcUwrRXVX?=
 =?utf-8?B?bWthcUtieE9EVkNwcGRiUThnY2xvS2FaK3hlSWJMUmFSdU40TUdPaVVGQUsv?=
 =?utf-8?B?L2tWTDZpQXZOTHJjSUNqZjRueElMVTVYSkg1UWtuNGZKeTBEeUt3T1c0NUNX?=
 =?utf-8?B?dWJjTnlxb3RvL01kNkJFc0UrM1k5OG5oOVoxdG0vKy9kekdnUGVwdHJJY3lB?=
 =?utf-8?B?bTJ5bVdwOEF0eldRdS9nQmlUSGdCcVNWVzJSVlR4c2QvUXgwbXYzRFZjMjdh?=
 =?utf-8?B?TzV0TUNXK05xaEZadWtiMUVmYTd4bzZjOElwYzBGMXFoUjlBdEE2d09TK25Z?=
 =?utf-8?B?TG1hcm5qb2h4NzhkRmZXa0xQbzZQVXdCcG1tbVZic28wMkZNL1ozdFA1Rmdu?=
 =?utf-8?B?RzlMRFFoZ2Q0aXNLV2RZOEN5MG40T1l1NCtFVm5TVWVkUERqa0w3cVk1N2di?=
 =?utf-8?B?RjVCNTQ3bG9mUHN5TnZFd2FLU3NWcGRxVzFPWVk5dDA0R1lwdTdRWGl1WDFh?=
 =?utf-8?B?ZWc0SmxML01WeVA1OTJSZjJHYS9POVRMa2ZkMXJQUGFrNVVsSlh3SFVPWDZs?=
 =?utf-8?B?aWp5Q3A1eWhGNFFVbFRoMXVQSjhReE05cC81Yy8rM1lQSVBESS9ZVER6OFRN?=
 =?utf-8?B?RnhWV0FDSEk2ckhqaDB5Y0I1dWFZd1ZPdVJ5OVFnR0ZmUDgzZWYvdHlJUm5D?=
 =?utf-8?B?eTZQSXM3aTBhdFZ6MjhqTlB5blB0WFduOEwvbHVyanZEQ2Raa3Ztb0UwcUtL?=
 =?utf-8?B?eHpZQ3c2QXpweUp6dUFtOGdHQlhKSnRaazZZaE4rNWhUN3EyZThzZHkrWmVP?=
 =?utf-8?B?bXB3cHljK2pPeERvMEpRNmVNMGMvS0F3Ullodlg2ekVVR2RuMDFJdmw4Tlkv?=
 =?utf-8?B?Uy9XSkFxSzJoQ1VTa3FEYi9zVjNnS3lndXlYZUdlSngrc3pXUHlEZFJ4SGRq?=
 =?utf-8?B?QmFJemNYbEJKNUhja2c2SzFmMWdadjhMVUgzUVI3Mm5NdjJSbWFRbkhLK1pQ?=
 =?utf-8?B?UWFmQlJZaWNKNDlFbnQxdHE5R3lIRXpNTXlVb1lObnNCam1qa21FN0Z0bm1Z?=
 =?utf-8?B?bUJDQnk3V0lpcTlmUmFaVktkUGtEN0xWTGVkQmszVkdaL1hxUXREbHU2dUth?=
 =?utf-8?B?bWpNMDAxQ05yLy83dXN1K09ZQXIrcFdqTEl4UzVWOWxpelVDb3pkWVhyMGdr?=
 =?utf-8?B?RERteXgvZVYzQjVVNXlwcWFJcm9ITUhLOEdKSnVTVm00RzhnclFPQVhjZmhB?=
 =?utf-8?B?cTU5a3B5bTgxTFNVUjFFTFAxVmExSktHYi80OWN6eFBRa3h0N2ZuTFNqVGFR?=
 =?utf-8?B?RmVSaVF1NEp5Ykh3ZWd5UjBEZjZtQnVpektWSXBTV3haTU9ETWRUTEVyLzI2?=
 =?utf-8?B?a0U5b3p6cktENHVKWjhUQ2hZY3U3aXJSMXFqVTZYaEZ5WnQ2OVh5eW1WSkxx?=
 =?utf-8?B?cndySW5uTVR6THJVOTlmWGx3TjRCMGVYZkh6VWx5QnYrdWJSRHZBaHB1aERo?=
 =?utf-8?B?LzBTdHJhUC9wWmU5YVNmcGFmUHNlMU1DcFRSd2RLWHppR3FyY3NsWFVRMmJr?=
 =?utf-8?B?cThkTjhhR2tXb3VxNkNjcHM3S2Rwbko1ZGFYTi9Pc3RUTU02ZHlxaVF2T0ts?=
 =?utf-8?B?VEVsV3FtL0FMQm9xRjZ4WTZ5aGowSzZ1djhTVUxKbmJZaUQwSGs2aHZ1Qk1T?=
 =?utf-8?B?S2t0dmRmaHhOdjZ0eDhMUnVXVzdMQS9aenhabjFuZEpiV1VIQURsY09wS0t5?=
 =?utf-8?B?UXgyUDZaV01MOXowMlV2cFRaRFdSbDhmUXlvU2VHcXNYeDJ3S0RZQWFqckQv?=
 =?utf-8?B?UkV4UGsxRno3UWZhY0RNcTFrWlhIcytZU2pYaGZ6ekpXK1ZpejdYM0dnWjcv?=
 =?utf-8?B?YnVyQjQ3NXE1bGZHeFdpYVJ3WU5lZmRKUFVJdndUbDUxeUMyckdrUmtRZ0xY?=
 =?utf-8?B?UTBTTjFlVkVFdFlmR1JWK2duMWpYMjJBWlJySEJWNXd6dzFFc2dTdUVheUEr?=
 =?utf-8?Q?bfNG+6N5ChJxn2Du5faMDvC4w1111x7wZHEYDQoc8o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d5128b-384d-4d7d-1131-08d9f2f77733
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:12.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bBnExu+djhxS+NIllXS6aucIvJMCygFKm3wygdxVbzvEM1E6N4tFZGPmKMlk+Hy/TRBxN822WWm9Toc+vsAzBgoJaa6cE1YNUmWC6blEOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180103
X-Proofpoint-ORIG-GUID: I3aU1R7SsbLbKn5BTx-7ocrg2CzENpUD
X-Proofpoint-GUID: I3aU1R7SsbLbKn5BTx-7ocrg2CzENpUD
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 00000000..87ab663
--- /dev/null
+++ b/include/linux/slaunch.h
@@ -0,0 +1,532 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Main Secure Launch header file.
+ *
+ * Copyright (c) 2022, Oracle and/or its affiliates.
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
+#define SL_DEF_DLME_DETAIL_PCR17	17
+#define SL_DEF_DLME_AUTHORITY_PCR18	18
+#define SL_ALT_DLME_AUTHORITY_PCR19	19
+#define SL_ALT_DLME_DETAIL_PCR20	20
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

