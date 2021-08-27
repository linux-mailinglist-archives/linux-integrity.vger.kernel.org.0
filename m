Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9FD3F997A
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbhH0NWG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:22:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28646 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245167AbhH0NWB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:22:01 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RA60N9020751;
        Fri, 27 Aug 2021 13:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JrmrYv+4itrNkuyJVx9owj6FchfSRMm8+sp7P2G5ya8=;
 b=PnIysyTZ+4Xg555PEAG5JcHegv4YxCUqFymU2MmB9obhWoarusQR7Zef1mWVaNsanrNk
 hJPi4BTgbxzOLOOtY+61LKPbo9mU4DNZl29Y9NzjS6532XlU6QY4hoBW59fuaaM56LII
 NOOFLfAFoI99ChNuAFxoIyJFP5tNkv9L9heFnVZg3c8G0u7Wjo6rJ/v5QTQaMoZZRoEM
 bIJm9GVJ+xYmAIwCJM8tXq3uxrts4R+0AjYNl5XRd18eCdJj+2NI3CDwbI0RM4F1gTmH
 29tNcjEjN3j5jJgEh39KRbgDPGonkehAHQskneSDbHdEup10Q4yITFLLtZIhU2piTSo/ /A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=JrmrYv+4itrNkuyJVx9owj6FchfSRMm8+sp7P2G5ya8=;
 b=KKehDOrauj/UVs1h+DikboJFjeXa0+aIhqFxQioA4TfOYD6dlRP+V3u6y+S37tq09LUM
 rU8O+lKjPjmk4iOJVdugQdF++IQ6RrelPx46CdXoFMFcSFLDAM5wPXf1XYoaFWPX/D17
 /9uirC8nOqOYHXlEaWWOOTKoELtYkeVCUk/uvminqqxkEq/2c6vLaOxXXDygXn6Vx+fC
 aWowyTJNYptqWCcAKfmA6Mk8fClJMOv+NfCh05czyppZ9jRFs6s4XLz9vETc2WXSotvD
 6gRgGaOAqe4hMyAG9nPbnlf9VzMab2Gc8l+tsIOhvRfLb3CExazzgMGRehy2NgMUZ55N 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4ekuncg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RD9nxL076969;
        Fri, 27 Aug 2021 13:20:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by userp3030.oracle.com with ESMTP id 3ajpm4pqdq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9bd8SH8nNpzj/fS0T3MQ+grl16sG2PxBzhwHq4dOOKydy1jyChi9txvlH4QyEMwhCm7OSz7dh36RKFC4fSP0RcKYfVS+FZWIIVaJbIVKlB/D4+5W1Kl78ZHdDw8m9vDTnAzSMxmZR+a8kz18Tgyvbt2Wmy+wlxn3zVYIU+0x8ufXqMhAli66YOcnXrzMknbxHNcuT1o0bmnhM81CFivgNyLLRaHBJnQ0mbXRUxT0x+rNlnP9X9mMWy001K3IJzHIX+WfCje+LocQU0a5vHtNK+pF2MjpLu09iF0QkKAwMs7dtLsSBt7IsUTOALkvkOW1B4eDzsYlylNglBKbRoR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrmrYv+4itrNkuyJVx9owj6FchfSRMm8+sp7P2G5ya8=;
 b=L4mN3ToDGIo6NvYBpNPh2vQtYh2VXnVhGRTc3tdJqfQ4bow8puIyug6yqEZP6/Fr9Mfv84V+rjJPyy7da99afw/L0c0AN+w1gjfz7tUlHghKLMNbXrtWH32n1mIshx62oGiNp5Mo+vIgi0X2GuDbacvAwzHoaJ/pt6A+TYEqPPdGo8KX8DOUEV86cR2z7w3HT5T6G5hnS/v2QCAG7/fvwzue1RdGbD+EMHN2RUR62m07Wk/KSQbOQfVaIsddkMIz9WnTVn8f0h13olXVu16gw3XE4Sdho6eWrKtv15U/2ovGxvTFadMnd4gDJVIbk+T19TjrcMOt8r6u9RkL7S9OnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrmrYv+4itrNkuyJVx9owj6FchfSRMm8+sp7P2G5ya8=;
 b=xjOEwlUyI4dIvUNSpW0CQC3aerLlZGdlB4Kt0Krd2/2DOh//THxju41vNSPiEEgzReTlge0o2s65qCO+0jx3Ey92fboBlUAvrz3AlI+xQQNcJpNbKG3Dr0ceY542s3nqPen8ZcktUz3hlfp+V15cPRpCn2y1V2jRqtCHYFk+Wio=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3237.namprd10.prod.outlook.com (2603:10b6:a03:153::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 13:20:57 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:57 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 12/14] reboot: Secure Launch SEXIT support on reboot paths
Date:   Fri, 27 Aug 2021 09:28:35 -0400
Message-Id: <1630070917-9896-13-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a51f7ad-7c76-459a-de1e-08d9695d812e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3237CC8FF809DB8AB5FCB12AE6C89@BYAPR10MB3237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWDjBC/d5lyXaGq7h6lL0IEXULjSkeiKXYHoZQgFzxmmEAREoT3WvyLTsBWrQpGePiQKkuJ6e/iaOkDKrkAC4AfmvhacM81cxS0mqfQ3maQHqThK+pq7dPppDdXvKOhpKRT0efxYheLE1slr79aoRPOsTOzhh2qZsjGwJCvuXxu+veb4egMDKNnp0KIR1+NjVNBwQfJ4fTpvQJxIYnSKSCHc70bDMny76TZARj89QnDE3NmKigqSeYWmnDBtKobXu6rNIYvuBzuNsWW7IPAliHND+GSN6RgNcd3452XGyIuW6faB2/XBfBxCxwdqgtVjm+TLveePuCYMZJ73YUg3dd4JU4b6nLjfbhe8kRjEaSswVoznahSsOzYRTxhWY9mrnTkIfh7O5+AC3W7L1GYqJGugBANOBf12nuznwTUTawkaNji+hbWPHcAF3pIuuv09XBPcwLQym8gNzU4ho/U7BqU/rImjMK1xFskXOFOQ/G3bVBoBzba0mpq77Ym8bvh2j4UJaOeg/rrN5+02jUghe+qFI6A0YjFPaM0MFcZoKYEwgWOT+sslRXMAxdL34F7VEZ++jlhDgTqZtvKODrBEToLhMzVD388TDuYqvpxwa4n8jKumkGGNlG7FfTmNPcmbf0WXWkN8P+qSUmSLJKFQNjxM9vC3uY1bcpTydioMxiqcpjS+CfnGNy31j3nVxwy/wnNGBlGxg2R5aipm3BaiBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(956004)(44832011)(2616005)(2906002)(52116002)(26005)(7696005)(478600001)(38350700002)(38100700002)(6486002)(36756003)(186003)(6666004)(86362001)(8936002)(8676002)(316002)(66946007)(66556008)(4326008)(66476007)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TuDye1fP2a/25cQxBXbyjud3AozLHU6dgk8ZnRPM7SHwUXE19QW/W38a+y8P?=
 =?us-ascii?Q?r141dt0rUSVRyyB5jlZKPKYw1oSojWAOHMWBgwhPH5D57Bz03/NrnnKC3URH?=
 =?us-ascii?Q?e9EcMhMH6Yoq+dkWtGTY9BqSRuhq9sEpP58hVeoG+u7L5sISe8+AsmzWGyLc?=
 =?us-ascii?Q?4MwrCWToxc/CtQdJWO0o5QF4SugLziKIRKGtn0S0NehtTCXBAE3+F6M8jDr+?=
 =?us-ascii?Q?FIiYJDPcCZDirQHUfaEL9rZNbisddWdwLuLLNv+cwx8Gi8kXlE0K+jG/J1uC?=
 =?us-ascii?Q?2y4oC4uncbRiaHuqTIUrO2n7ei/0+zFQCpP/Bv6IcZUegtoa1ho2qE1+9ceN?=
 =?us-ascii?Q?QnaSvf2P27a4W/MjCrMFkpUM1y/EjUgwuLg2POvSARN1bkZmCgzXMPnwn8VG?=
 =?us-ascii?Q?Qxk7OuN/Gp8A3MAUpOyZGljdE6qB++bUJyq6tN2e/VbFIZaMxOHo8pmZqse8?=
 =?us-ascii?Q?lSPhLxblfSAXVTQGtNUsIr1X03foxMmdvamWdoWldAltvzyjprlMnu1NOgEi?=
 =?us-ascii?Q?b3R/cRv0gF7/hHyLlGF7DzfjvYhkMwpNysp1GDqH584OVnEQ9oxIJIKaXqku?=
 =?us-ascii?Q?dQDUilUQUuYkVSGV5x6XDfDVrvDJoIfBZT136IRT7GKFHeeTj/wdkl5cMXPk?=
 =?us-ascii?Q?FJh/z71r9R3ej7JmQuZ9fQ1jV8TbKJceDbJAqP6YiQh6qDpOE+qJ6KMcHvnS?=
 =?us-ascii?Q?5xFWivhkz3+fS7R0tq/st6WsEhQk+x1YGTgn6XClgVgrWpZpeZOFBCXHmBnf?=
 =?us-ascii?Q?wDlG1Madr2QSErBLIvDsIHO/xmi7VlwtzAf8PNsfMPtdNczBTShDpneOm85+?=
 =?us-ascii?Q?TgGu7OQZISImOU1s3fuD7sE2pD+oE31GcIwvBhWwJ85HSnGWL9CRFzOKuGgn?=
 =?us-ascii?Q?5R2eKCtCaIePwm8DFpE++a1Sin+AryS5dDf1Md2VGGrLb1is32jt6Wby5iG1?=
 =?us-ascii?Q?9SAZDuQhiC7urOi6LX9/fjcInkWuTo8fC37raVW0pQ77IQ836Xjbsi4iQWqh?=
 =?us-ascii?Q?E/9bZjJyw7CI6E4pwYTOhYs5dw74yaBQEAYXjMXWDoZxBOn5Hmf1rddF7PpL?=
 =?us-ascii?Q?/T1nKDn7huYqP6kH87GLEbQD5y5LeRHi9MCNMjcdkjP/nmJHI/rmqJ+HuyoP?=
 =?us-ascii?Q?tPpXpIDwC/QY2nUhVzG8qq04TLwLh9OUFWOWHs5saV2gRDW9yLP5WwceV6wA?=
 =?us-ascii?Q?f8Ha4jNaLKVTf8N43nZrsm5bcq4+rSSG18PIv1+wkJSvSPQLuF1uOY7D8QPs?=
 =?us-ascii?Q?qGavZi36QNUzhne4qAAkW614wrk0Mf+X/im/x6sLMNGXQICTNOyTiLFHmjmA?=
 =?us-ascii?Q?6NzdgV34KnPTCt0eQ5JjkdO/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a51f7ad-7c76-459a-de1e-08d9695d812e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:57.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgmH8LzRW8OjJ/OL/sljIT0DRoqcjE5uu1KxpcEdXmw0N28FrGRXppB+NNDGzxMBkg5kv+Y9fDBCrL2wyAGvrCeooO2LiIqoLB3Y+rlf4So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3237
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-GUID: XOFqQTLDcIwPfpSoPgy08_Ufy4FS9ETo
X-Proofpoint-ORIG-GUID: XOFqQTLDcIwPfpSoPgy08_Ufy4FS9ETo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If the MLE kernel is being powered off, rebooted or halted,
then SEXIT must be called. Note that the SEXIT GETSEC leaf
can only be called after a machine_shutdown() has been done on
these paths. The machine_shutdown() is not called on a few paths
like when poweroff action does not have a poweroff callback (into
ACPI code) or when an emergency reset is done. In these cases,
just the TXT registers are finalized but SEXIT is skipped.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/reboot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index ebfb911..fe9d8cc 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
+#include <linux/slaunch.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -731,6 +732,7 @@ static void native_machine_restart(char *__unused)
 
 	if (!reboot_force)
 		machine_shutdown();
+	slaunch_finalize(!reboot_force);
 	__machine_emergency_restart(0);
 }
 
@@ -741,6 +743,9 @@ static void native_machine_halt(void)
 
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 
+	/* SEXIT done after machine_shutdown() to meet TXT requirements */
+	slaunch_finalize(1);
+
 	stop_this_cpu(NULL);
 }
 
@@ -749,8 +754,12 @@ static void native_machine_power_off(void)
 	if (pm_power_off) {
 		if (!reboot_force)
 			machine_shutdown();
+		slaunch_finalize(!reboot_force);
 		pm_power_off();
+	} else {
+		slaunch_finalize(0);
 	}
+
 	/* A fallback in case there is no PM info available */
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 }
@@ -778,6 +787,7 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+	slaunch_finalize(0);
 	__machine_emergency_restart(1);
 }
 
-- 
1.8.3.1

