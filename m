Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DFB3F9988
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245255AbhH0NWO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:22:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25074 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245186AbhH0NWC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:22:02 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RCCJtu015338;
        Fri, 27 Aug 2021 13:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=pJScYFSSXd48rFQcO4SNhCOzggVxNzAwYUqdt8STBUE=;
 b=rqd9i2IozoipD/s1NOuw87+MbjJ7pYJ4JYsEiLIdRwGfTj1O/G9VSYKDY6bbAihHrsvB
 VHGQ2kPP57+Gtqp7vb1/ORkDOfsM3Vx6hd91YPYQQnuhnI+HjQghyTTLcgKAgtSu+jQh
 QNJpN8x8qpQG5W10CgrlR/lQWg55WnastYwDm0Yxnf/spPD5qEshHZ4QqylARI/gYFJO
 anv3S5Wtc6l4+DedUaprAMBXdMAl5WVIeRpTYFThsCdq6Jam9w7oS0L45B5AO4YfpihZ
 Np47Yl4FWB1Cux9ETh/yoPTKLxRrKBkl6MbrzvLaLt1hNqTp2ZmmuDtFzR/Feg8vMVCV yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=pJScYFSSXd48rFQcO4SNhCOzggVxNzAwYUqdt8STBUE=;
 b=ZKZ4Vpgl/oTxzenm4H3M+WDkh5XZXcrbbsjCkQTkrScNqZeN0OgVrs01/2JosbL0n7Oj
 ldr6UaE4vr3bpckAxYAfMgeDjJ3//zPWwESFuCjUYYnUrmluP4hpakq1PIxGaCnIgV3W
 aZKpfBnzS006UbQ7A74VI/pqDHIvSNQZQAUxMltbzqcUQIQC0sMJ1DVeuP5XYKvAkhVq
 e7HMzG0mew1tYLjCHq1fWZhHoOA81NtH1xqvpjF+gmuQhR+pYbveCE590WqFhFEaV5wo
 7CHI3PctlPEmsrBbDnO3UUF4/+FRDFmtTTKfdLnOA+FO7laVvlmbYdMnXWeqo697NBmV OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3apvjr0ktb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RDBYUS007537;
        Fri, 27 Aug 2021 13:20:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 3ajqhmjm17-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8eVhOO6q8/REYxGWG1pXfZ1s8VIqkEzoiVRNC3CEsEhKR0ohN5HzrRqtjZCT8q+t83jekVNyH9qNCl3QPRmAZAhsW3mvEkKAX5ybGIx2aXHzyEIesrgEqC+wz03IZpEnHjhSXhU3bPXWOY2abmDt8cG7wwh1K9yZ3Vwi43cXZ8GiAosDVUV0h8FM2unst3+8IcIhWcQl0bjxlcqwGwr+I5PctkdFixAHtqBmWKnW8pRfwu7EEsiQ7devK+z+q2FoG1Nyu6jwUvDU51OtVM3eixz7tW+ZEFmxck5AWBowxmJB+WzVj/NERSZWkXrWzF3P8Uew3TscFv3hkij1ApXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJScYFSSXd48rFQcO4SNhCOzggVxNzAwYUqdt8STBUE=;
 b=fgd3AkGsNwYmbU/OeYQveC3/sbgsuVWQv4oQakgZcjoSles+zClHdLNOzclJ/tRZTUE1swuLCHMA6LzYuyQ0wGSEw93CtFtVS04M3b+T4PHqp1t44gWTfdBweov09pbyOPhkHi3057zU1Mz/2JLOgQARjVue9puES80mEou0h3buGe+XABD7Yas03r/4xsS1XZeeJjOI/flvQlWjp4wb8Wq6GiHXTQaSmO88p4811oxdNI/QvflncVSRD3st7SOT+PccL+NuLfYr8uimQXW2OwOsmZVQG9qvJQWyPBjp9omWgosXmNRYKr0jOEc6qxvw7nduIenYfwdfFVZ8sVG9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJScYFSSXd48rFQcO4SNhCOzggVxNzAwYUqdt8STBUE=;
 b=hebzis/EEKayBzcRy9qXArU1D44AO6YPnmziWyTg6Ub5IOI/T+yYx1jFGpc63LfVsP37/rhCttINta6evJLnX09qTC+EKEMUNezOIZriKeNks51VrdBLnngsY9q9NlAoxmrRAgFlK9CyQ1rDts/i3jBZM862MRlTcffASTvHpcg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3621.namprd10.prod.outlook.com (2603:10b6:a03:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 13:20:38 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:38 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 01/14] x86/boot: Fix memremap of setup_indirect structures
Date:   Fri, 27 Aug 2021 09:28:24 -0400
Message-Id: <1630070917-9896-2-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41eef716-7bd2-4273-85a5-08d9695d75cb
X-MS-TrafficTypeDiagnostic: BYAPR10MB3621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3621CBA074BECDF24F427722E6C89@BYAPR10MB3621.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCO0W+3Jq8kpIPYRnuVfGke8X5NWG22UZKAGffokxcu7ScfnH8F9MvP0SDu1Yp7msJ9iAckTKDZvtbq4SzYX7XrhVeUlh/Z8KhS7BCPc9+M292yKlXU+ETOdOS0rEa0qKFDWdi2OCkV0xpXbdNLZVvS8RZSl6839SVaMcb4Bh2TeTD0GmmaiMHiLYR4VHMI3XPakZwbAgo4DwDBZ7N6cuobTVzB2eCnaV5krRCmvwnicC3SkgiwHVxDYsl1GnWtBg5wwNQJexytuimnwE/Tp1i7xRIiZa9laxLtsoF95kC5TEzys+ZUb0O6PVbdkqWQZQnlxxX3jE/piMo+6dAVH7Ifdqe5oGaPUWsUT8563pgabq5aVKlhYMWAPFDUaEeUvKw7oU3yoMyRVc0V8iaK3PWftPyuq9EYLyUrc4I1cNPdcEKK91BDTJVQzbXl2kNtW1CyTD3C+Xst7mBhMjFmJaxx/hIel3Mo8fH2MYGZ8//DoipGqMZA9uaOQPPdguq2v3q8XwZovpnaUY9KlavQSy1/A0o3u4UTy/9UT0iNqQy3FLRODtXx+/v59t3gjIkmyNAr8CGeghIW1WOPmYGxE32RXwjJMN95ohaB4M1yCzkqQHDQhQDLO416s7/1i1PzxF5b3fKZy/UqoisuaLvjcdRr8+0DFSQnBIL1j7tmUAM4ltNKJ6aNC5XF292GJxgp/B/AZiW3ODK6aNmFfCmIQdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(44832011)(316002)(86362001)(186003)(36756003)(83380400001)(7416002)(5660300002)(478600001)(6486002)(38100700002)(52116002)(7696005)(4326008)(38350700002)(8936002)(8676002)(6666004)(66556008)(2906002)(2616005)(956004)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dEwIULASFFIe1q3HlHEVxrDpBs8VLOLAGyg60acNUArulT+gLsRa1m+onWp4?=
 =?us-ascii?Q?xBcG6iFUArJocNLQturQALcmtyOGqwfWwWDwi1gT9P1TQpMfiu2UdHQDO/Al?=
 =?us-ascii?Q?rTvbk5jXtFFHRkQtIVoALfQwTTdmmOAvNlsCElrCkmaBjM2kO5m9x+bhE62U?=
 =?us-ascii?Q?8gXUyKZUiPA+7sgVJMk5C6RWH53V1d2oQVxXMT6h54LzIlqyGnbSBghlTw10?=
 =?us-ascii?Q?oNFnCzy/1PbQWnZVoSMwEMVMbW3SmNy6bCioZmayXHXgcDZ87I5K3tLD4TPh?=
 =?us-ascii?Q?QrnX0BQu2pvyLc8sHKVkzpoYRGFp4pNqorv745XaZyTlv1FwBXaWltWs1Axl?=
 =?us-ascii?Q?/dRAofKWyhDYsTJHdR6aKUPKlaedbVxTrMFpEwXDLT//6/EE9fmPgQQZ+4s6?=
 =?us-ascii?Q?cYiyOYDItaCs5Xe3BJy2xiML8nFEm/HQ7uJNryHQqivfrFN1uk7nmPmy4w4Z?=
 =?us-ascii?Q?CWZsFX+JstDOmdkAlROaa4SnJ2CovHJNWDDBXhLq0LgwGHwSRfPtPwRFSgdD?=
 =?us-ascii?Q?D5sfBoaxDcVVbbnZJWRu+wt4fGqGvRBxMhrlXqPFo9/dTrVLZ0+imyXD+JcA?=
 =?us-ascii?Q?+G8uInWxyeMYQkUmerHH/HvwEU9fdCRUDXsbtoVfl5RIww9txs1xNOqKPnWl?=
 =?us-ascii?Q?KOeMaSKjmiqlXvNSx8EJDcpkph/kYGtoPN+xdpaahOn6KUzUbG6H2yBAEk4A?=
 =?us-ascii?Q?Tn1RkJ+Bs/rVhFEVbwZcoiSi9bvbZCT308IAoaemZfHeTgu9GBbKTGJaL8hA?=
 =?us-ascii?Q?0eExLLAf5gpxJqcDfWY84zlYTYJqJme1anr5rMgFbz/GKaw4ZhWWfdZCKmA3?=
 =?us-ascii?Q?S9uf+vy4SfQLh1OfzeLp87bIjRB94/Rl5Rx2rf1ubgn7Hkm3+z5M9WpzAVZx?=
 =?us-ascii?Q?Kt3m29T/1vRjBSOdjfceX9SMEV4EesTQNFW/Y5BikbemjWs92lfyxctn2cRR?=
 =?us-ascii?Q?ZYWfhB21rYp0AP13Xr4id5j2Epevzoa8bANDgr/A/IiLAXsfP/CxKtW5F9pO?=
 =?us-ascii?Q?dp9YX3N04LsnPRI3GQRhf8bK5l0NdZknLGP5FtmrczamDKllxHJq7VbTSAWg?=
 =?us-ascii?Q?qYZlDE6q7bfABmcMY80TZVFi6vHmpVo/UzoJZhFyg3mGj98AUTWTMsH+lNRK?=
 =?us-ascii?Q?4FZGB0ZhbMq+QfzzEtZPscgc9cOVy/Z3zT4tt4sTmYBv0Lz6gcRhp/BcDhgc?=
 =?us-ascii?Q?cC26ZGnYadZJqszAdyfRXxdoNGAztGgU3T2f9JUAPbBC1IxYRpg7CH+I8Vsc?=
 =?us-ascii?Q?B3Omxnjckc88ZwYn0dcp+9VbZ9DpxF27mqY6t2CZJn/XMAoGx0mkP0x+strJ?=
 =?us-ascii?Q?SndEm3zuiRbxG3FMwbsb3/sk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41eef716-7bd2-4273-85a5-08d9695d75cb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:38.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWf8jLVBHI3UeYGG05beZk5Z5OtMM/hHhk13AUdA5eRLfmDJ4ZizjEze9XiveHOcOhZQNFW0vYzhIKkQ3QwNZ/EeNjFYvdLORN0tH/MiC2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3621
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-GUID: SiC7RZdrY63723bWudWmqcDwK6QoFQCn
X-Proofpoint-ORIG-GUID: SiC7RZdrY63723bWudWmqcDwK6QoFQCn
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

As documented, the setup_indirect structure is nested inside
the setup_data structures in the setup_data list. The code currently
accesses the fields inside the setup_indirect structure but only
the sizeof(struct setup_data) is being memremapped. No crash
occured but this is just due to how the area is remapped under the
covers.

The fix is to properly memremap both the setup_data and setup_indirect
structures in these cases before accessing them.

Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/e820.c     | 31 ++++++++++++++++---------
 arch/x86/kernel/kdebugfs.c | 32 +++++++++++++++++++-------
 arch/x86/kernel/ksysfs.c   | 56 ++++++++++++++++++++++++++++++++++++----------
 arch/x86/kernel/setup.c    | 23 +++++++++++++------
 arch/x86/mm/ioremap.c      | 13 +++++++----
 5 files changed, 113 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f..e023950 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -996,7 +996,8 @@ static int __init parse_memmap_opt(char *str)
 void __init e820__reserve_setup_data(void)
 {
 	struct setup_data *data;
-	u64 pa_data;
+	u64 pa_data, pa_next;
+	u32 len;
 
 	pa_data = boot_params.hdr.setup_data;
 	if (!pa_data)
@@ -1004,6 +1005,9 @@ void __init e820__reserve_setup_data(void)
 
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
+		len = sizeof(*data);
+		pa_next = data->next;
+
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		/*
@@ -1015,18 +1019,23 @@ void __init e820__reserve_setup_data(void)
 						 sizeof(*data) + data->len,
 						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			e820__range_update(((struct setup_indirect *)data->data)->addr,
-					   ((struct setup_indirect *)data->data)->len,
-					   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-			e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
-						 ((struct setup_indirect *)data->data)->len,
-						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+		if (data->type == SETUP_INDIRECT) {
+			len += data->len;
+			early_memunmap(data, sizeof(*data));
+			data = early_memremap(pa_data, len);
+
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+				e820__range_update(((struct setup_indirect *)data->data)->addr,
+						   ((struct setup_indirect *)data->data)->len,
+						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+				e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
+							 ((struct setup_indirect *)data->data)->len,
+							 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+			}
 		}
 
-		pa_data = data->next;
-		early_memunmap(data, sizeof(*data));
+		pa_data = pa_next;
+		early_memunmap(data, len);
 	}
 
 	e820__update_table(e820_table);
diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
index 64b6da9..e5c72d8 100644
--- a/arch/x86/kernel/kdebugfs.c
+++ b/arch/x86/kernel/kdebugfs.c
@@ -92,7 +92,8 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 	struct setup_data *data;
 	int error;
 	struct dentry *d;
-	u64 pa_data;
+	u64 pa_data, pa_next;
+	u32 len;
 	int no = 0;
 
 	d = debugfs_create_dir("setup_data", parent);
@@ -112,12 +113,27 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 			error = -ENOMEM;
 			goto err_dir;
 		}
-
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			node->paddr = ((struct setup_indirect *)data->data)->addr;
-			node->type  = ((struct setup_indirect *)data->data)->type;
-			node->len   = ((struct setup_indirect *)data->data)->len;
+		pa_next = data->next;
+
+		if (data->type == SETUP_INDIRECT) {
+			len = sizeof(*data) + data->len;
+			memunmap(data);
+			data = memremap(pa_data, len, MEMREMAP_WB);
+			if (!data) {
+				kfree(node);
+				error = -ENOMEM;
+				goto err_dir;
+			}
+
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+				node->paddr = ((struct setup_indirect *)data->data)->addr;
+				node->type  = ((struct setup_indirect *)data->data)->type;
+				node->len   = ((struct setup_indirect *)data->data)->len;
+			} else {
+				node->paddr = pa_data;
+				node->type  = data->type;
+				node->len   = data->len;
+			}
 		} else {
 			node->paddr = pa_data;
 			node->type  = data->type;
@@ -125,7 +141,7 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 		}
 
 		create_setup_data_node(d, no, node);
-		pa_data = data->next;
+		pa_data = pa_next;
 
 		memunmap(data);
 		no++;
diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
index d0a1912..4cef401 100644
--- a/arch/x86/kernel/ksysfs.c
+++ b/arch/x86/kernel/ksysfs.c
@@ -93,24 +93,35 @@ static int __init get_setup_data_size(int nr, size_t *size)
 {
 	int i = 0;
 	struct setup_data *data;
-	u64 pa_data = boot_params.hdr.setup_data;
+	u64 pa_data = boot_params.hdr.setup_data, pa_next;
+	u32 len;
 
 	while (pa_data) {
 		data = memremap(pa_data, sizeof(*data), MEMREMAP_WB);
 		if (!data)
 			return -ENOMEM;
+		pa_next = data->next;
+
 		if (nr == i) {
-			if (data->type == SETUP_INDIRECT &&
-			    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
-				*size = ((struct setup_indirect *)data->data)->len;
-			else
+			if (data->type == SETUP_INDIRECT) {
+				len = sizeof(*data) + data->len;
+				memunmap(data);
+				data = memremap(pa_data, len, MEMREMAP_WB);
+				if (!data)
+					return -ENOMEM;
+
+			    	if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
+					*size = ((struct setup_indirect *)data->data)->len;
+				else
+					*size = data->len;
+			} else
 				*size = data->len;
 
 			memunmap(data);
 			return 0;
 		}
 
-		pa_data = data->next;
+		pa_data = pa_next;
 		memunmap(data);
 		i++;
 	}
@@ -122,6 +133,7 @@ static ssize_t type_show(struct kobject *kobj,
 {
 	int nr, ret;
 	u64 paddr;
+	u32 len;
 	struct setup_data *data;
 
 	ret = kobj_to_setup_data_nr(kobj, &nr);
@@ -135,9 +147,14 @@ static ssize_t type_show(struct kobject *kobj,
 	if (!data)
 		return -ENOMEM;
 
-	if (data->type == SETUP_INDIRECT)
+	if (data->type == SETUP_INDIRECT) {
+		len = sizeof(*data) + data->len;
+		memunmap(data);
+		data = memremap(paddr, len, MEMREMAP_WB);
+		if (!data)
+			return -ENOMEM;
 		ret = sprintf(buf, "0x%x\n", ((struct setup_indirect *)data->data)->type);
-	else
+	} else
 		ret = sprintf(buf, "0x%x\n", data->type);
 	memunmap(data);
 	return ret;
@@ -165,10 +182,25 @@ static ssize_t setup_data_data_read(struct file *fp,
 	if (!data)
 		return -ENOMEM;
 
-	if (data->type == SETUP_INDIRECT &&
-	    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-		paddr = ((struct setup_indirect *)data->data)->addr;
-		len = ((struct setup_indirect *)data->data)->len;
+	if (data->type == SETUP_INDIRECT) {
+		len = sizeof(*data) + data->len;
+		memunmap(data);
+		data = memremap(paddr, len, MEMREMAP_WB);
+		if (!data)
+			return -ENOMEM;
+
+		if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+			paddr = ((struct setup_indirect *)data->data)->addr;
+			len = ((struct setup_indirect *)data->data)->len;
+		} else {
+			/*
+			 * Even though this is technically undefined, return
+			 * the data as though it is a normal setup_data struct.
+			 * This will at least allow it to be inspected.
+			 */
+			paddr += sizeof(*data);
+			len = data->len;
+		}
 	} else {
 		paddr += sizeof(*data);
 		len = data->len;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bff3a78..055a834 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -368,20 +368,29 @@ static void __init parse_setup_data(void)
 static void __init memblock_x86_reserve_range_setup_data(void)
 {
 	struct setup_data *data;
-	u64 pa_data;
+	u64 pa_data, pa_next;
+	u32 len;
 
 	pa_data = boot_params.hdr.setup_data;
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
+		len = sizeof(*data);
+		pa_next = data->next;
+
 		memblock_reserve(pa_data, sizeof(*data) + data->len);
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
-			memblock_reserve(((struct setup_indirect *)data->data)->addr,
-					 ((struct setup_indirect *)data->data)->len);
+		if (data->type == SETUP_INDIRECT) {
+			len += data->len;
+			early_memunmap(data, sizeof(*data));
+			data = early_memremap(pa_data, len);
 
-		pa_data = data->next;
-		early_memunmap(data, sizeof(*data));
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
+				memblock_reserve(((struct setup_indirect *)data->data)->addr,
+						 ((struct setup_indirect *)data->data)->len);
+		}
+
+		pa_data = pa_next;
+		early_memunmap(data, len);
 	}
 }
 
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 60ade7d..ab74e4f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -635,10 +635,15 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 			return true;
 		}
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			paddr = ((struct setup_indirect *)data->data)->addr;
-			len = ((struct setup_indirect *)data->data)->len;
+		if (data->type == SETUP_INDIRECT) {
+			memunmap(data);
+			data = memremap(paddr, sizeof(*data) + len,
+					MEMREMAP_WB | MEMREMAP_DEC);
+
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+				paddr = ((struct setup_indirect *)data->data)->addr;
+				len = ((struct setup_indirect *)data->data)->len;
+			}
 		}
 
 		memunmap(data);
-- 
1.8.3.1

