Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762983F9980
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245127AbhH0NV7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:21:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23118 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231492AbhH0NV6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:21:58 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RALmsK015051;
        Fri, 27 Aug 2021 13:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=L7gypYGtph9ns61b3nol/EKGhu+qMVQmD50UClf4NnM=;
 b=qTETkGSMbygefuBQwui/nTC7KJHjhtO2AYsM2F31X6bpik3jvDWbScaUu0RUrB4iDW0J
 RqJI6PMQb1me+3vQufx2FHoKyn1zqrWjiNsVPeJ20sleX8SHHMW3KXW0OYaVmoIV8Nny
 AB/tDDbXM+6LmuycxmT4dFFPkgCXxevUKGNIIIVksTkXvhpO0XXaKqMfgVP4w/Qz6M0Y
 Sh+xg1UDRCNOW6Zs5njTiLiHPQB9OXpqC9O1nmiJqg38DN76f75FBLY+rIcCgFsQqGUg
 DkD9sf9XXz2rgSb/vict88Rz4itLNFwDI1hKoT2YMu/LkFj9gj8rJ8fSYosUNWpH0JCu UA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=L7gypYGtph9ns61b3nol/EKGhu+qMVQmD50UClf4NnM=;
 b=w5uB3hbj/WzYimBnremmoravMuIQIHYKpB1fQ94Ya+oyaJebsSdj16CWGO6ht8TNRK4L
 kH8SXiH+lsIQr6/fSy+fo3z0PwwdW/1mLzdiU3mw4nz8TipR61y/N928YhSCJfsXyAWI
 FuVeH2IPBTKgGBSE3C1TyKGqTpUZdkh+PiT0JXZtEq/6n+pdHy0+G6y/GEb7g1rlUgPw
 307hezhHmECedzh5YOq6BlPkmzhGh6Ec+d11VCpljVKFuSFgpitjHOHlZFk+HKXY0kod
 7xNlyOqxoYLu/F+9sI366n+y7Dyw1e2q7tpEl0tm8QXMUz3T1oXRtQiXbWFNp+uM4Koc KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4xv3gxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RDBY2r007529;
        Fri, 27 Aug 2021 13:20:47 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by aserp3030.oracle.com with ESMTP id 3ajqhmjm83-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO7t2h8p0MYhZukJANrDNTIblded997Vqd8hbgIM2copTPD5ajfZ/aP/1BUo074ttcW8I6SUsaF+jxSEWwxwh60PKvP+ZW4eOPyU9DCgb6BiJTBZEY92rFRdxb5W/dsdgrsiSgaCB9NMa+r+UFFieepxPOyijKx50AY18znmTElii/It0VgCUAlh1E+duZeK7VIfvVdMy7ZBrLmF9WxvNsFgfRL5KLZMXyjNHbqzBNeQ/w0vMcMpv0Hxh+qFjg9B8n/OFKGmdzVqtMz2Flrho20r+slWsn+88JU8SOSylBFlM9iPCkDnyDGk+KfgG5Q9qdSLzHicNPoFKr0vF0M3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7gypYGtph9ns61b3nol/EKGhu+qMVQmD50UClf4NnM=;
 b=M9mYRxn5QyAPgqdr57lmsqI3GuycSBuhu0sn+O6dmZIzwncNaFEA/xAhuuyrhBiToDHTybQhx4A7IhCILZDwHXeVb4VRE40qap1tI7vWyPlvKNiJMkKV5rgxlFspNgdD1xw5un3ZX1qAF9DE/pFY9NdwRCMmTQLKny3NhkCp/Lo8eycz1J0D37S+UGJWkVpl3gE7cz+Oq3vVcuixijLx7bZyfFipRMfbkqmXFeaFue5WI2v8xKyEDluyB72gmJogkehG+vs4CbmIXKmNHCT4D0WWN5ejMbejl9x7LM5WIqtg229AncVe6pySw8isqncD/G45505kwIZucNZpY7RZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7gypYGtph9ns61b3nol/EKGhu+qMVQmD50UClf4NnM=;
 b=qWXxHVZ1Gqn/L5ZE4PKPRBalOKNnbtw4BrjNXQBTDvDaPZ/10LDVWjvp9tkReZR8GtDhiWwrkQ7csSbzsslkypUvol3V5Tv7sYUhv7PHsRlzBBKWKDY7uEDxwa9h0YkYo1R/2gBHx8gLqQAA+FyJsLpEO2zlujhdIEwRe7DQUYI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3237.namprd10.prod.outlook.com (2603:10b6:a03:153::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 13:20:45 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:45 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 05/14] x86: Secure Launch Kconfig
Date:   Fri, 27 Aug 2021 09:28:28 -0400
Message-Id: <1630070917-9896-6-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da999d0c-40e9-4f96-1925-08d9695d7a1a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3237C22D8901532590C065FBE6C89@BYAPR10MB3237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTSQmy7LKH1sDxSD1370gwvcL7WqNnANc0BM+U8+QmkDK01fiEjewG9UNUeHm+Mehy2/jQUV0jKFGS6vm7Qot5vfZDTcQxqq0g1VHWjWyfi2C8aQPTXAo7FomEyFoZa+t6tYtce6kk4uLeyEfijHxPWdZjmvl7d3JXgv1xlctOMzsJnWmqnt7VozPGg+Gd/KXjbYtpNz/Xd3YIb5iez5+fOWtVJNjIl3HVPnqWkHZMP7xwQJMGXbXP35/qNqPL4BOPl6m1cQVqVcbWGkkwPbXwIoX8GrU9Y+IuzEY/UXT5izygwIJxKsV4t2EMk0I+M9uFIPjObgdZtaPgSF+za94fqge0XfEVkyvIju9ZXXCYD+ARaL14Hynvd4OgahsuxgrYjROn68P4q1WaXp664MJxzB3s3oU6eB5tbXngQ7ubW7vpbIih94YxrcKhJQbl/Jqy2/e55jbjfPlelIBWLbU0kBVn94ABIIxjrKqhPPBgYy9F0fae256hqdkCnDKT/1qMOgB5wp7wYAXIT7ezBB5Z2qDpQn/ZVWmucoAPabhjwfsY4pSlEHV7MMpikPHL/frdkpbl/K6KN/n4WM/7bG/n8UshsZA4/8rkH6QE0oPbQRMP3i9+cPuGMn7EbhjWzYZsFQaSl2rhq9emz+t7A/eLYcrN0Z6qEUhCBhkAv2nRchYeJnT95sIdaOdhHxsHPku4CRW8/sc66qKQVDv7piPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(956004)(44832011)(2616005)(2906002)(52116002)(26005)(7696005)(478600001)(38350700002)(38100700002)(6486002)(36756003)(186003)(6666004)(86362001)(8936002)(8676002)(316002)(66946007)(66556008)(4326008)(66476007)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sudBSG5BOtDBhnIkERFF8UCjXebHN7QaFM/8h8HngkWxmuNzvIfSfaEy0YIE?=
 =?us-ascii?Q?upgP7LLc6LvbC8FWgvdtQCvtpieP6aS5dDtRVpm98xNlQ6xk24ssrZLFgdx9?=
 =?us-ascii?Q?SxlA53ZFTTmBJhNDInsVQ9m3FDWv/T0eW0woiVFoUXf5yL5vUo5wDQa5Jf/Q?=
 =?us-ascii?Q?ETEHNyzxknMgVaNzNHWuwGFmrPzcIgnIy86+QcF45GIQfWG7OOw0LjDHkS6/?=
 =?us-ascii?Q?5TnSKQsey3J/FtJjg09TKROs+lSD+cIBXa1KRk95KZJepD9nQevVEDEYogzj?=
 =?us-ascii?Q?086JuW+3Y5GGLVVPFI2HnTekm2lLJQ2EkFG9Oo4fHP9LODRnaX7JdLsjwOyI?=
 =?us-ascii?Q?EcSwzt8PhiNHLTzdDlSiXS7d9cVbV7sOL+W/VNtcjD/Xg/t+7e2Vo+4jMr/g?=
 =?us-ascii?Q?ECkVl403sDc0bJlTpilmBPl3YmZnNMwK8KrnQIAOx/gDrEYFm9uo3nEkTiCx?=
 =?us-ascii?Q?zc59OxyscLt/UEtCP79QF+sMg/P2SAIpMPSTx04i6G1MP+Q9l9GmfA6Ch136?=
 =?us-ascii?Q?1MeR3HnVPMaCcdOK99WSe8wjwuLNmSxLJfc9SVwri8mM0ECwis4n3odHRJZc?=
 =?us-ascii?Q?OR6p+XEQxsAkeFWlG2fYAXjDDgIKRnISi3mDkbOQnN2TnIiQczQhxtt/Ugee?=
 =?us-ascii?Q?Dew8FyB7NFFLo1/VFrDqnDg2SpGGi4NFAxmMuO3XgYIXg5iFGnR9skTPlRk4?=
 =?us-ascii?Q?ONwMi8gf3/aBX397TmqZKQsvMsceJH/rrU9iy5XHzF0UPGxSFU3DNrXk+y6g?=
 =?us-ascii?Q?dUCN4sSTxBCS0dIeUE7izbMkg4PIBznXDj2DbeJUIYZrfnt3iJbQENpaNO3J?=
 =?us-ascii?Q?SjahoLJkcxn4JMDWftu3z/trMwxaubrT3lz6PpHx4WHl9mIBmtwP0N1U4AP3?=
 =?us-ascii?Q?jG87gv+s9TXgmFYkgC90mGd692PQ8sogtSTy3JHekrotjx5Mn1Tmi3zrVjTz?=
 =?us-ascii?Q?CQnL02rpHj8VZwU5+H+BJ+VqYd3YhOZRaFA9olNflO07+e8KneH0zQ/rC/uX?=
 =?us-ascii?Q?PITdexW5g5tYtwpK026q9Of5c4yf0+oTyrN7U6etaBQPluSBTEKy25fHcThi?=
 =?us-ascii?Q?uuemlUh2dRhAOez1rWqDxCHYp2bfJg72/KMH7O2YmPlqFG0gvwB9rOUV4eIl?=
 =?us-ascii?Q?SfdhT7+2tIbsIJUcgp4d76kcp9FuN9UmHvpxkf79wE2JwLl/mGesJNyZPzC0?=
 =?us-ascii?Q?EvPrWfWeFP+DcxVRRG++oLcPs3XjlyC1mBgsfhAM1XfkW+qBL/NTaUemcAUY?=
 =?us-ascii?Q?+GCHCpZHZqJtuLgI4BMz78pHv6meZzvKzrmZIJG5LXrXg1LJIcGFVg6D8y/4?=
 =?us-ascii?Q?jKTaRCT1PUNi7P2K63FErclA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da999d0c-40e9-4f96-1925-08d9695d7a1a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:45.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qt3XvhOzEq0a/K813u5NwwoZ/vl8UjpfZNEsX6Ki7YkK5YWW14X62i7i7TiYmrF92LcxBVjNOrOwjuoZnDbm4AyKKvYt9pXxIig4aXFk98o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3237
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-ORIG-GUID: QmqgXVzcnpKUIv8btvnB6nEQVQbScd6R
X-Proofpoint-GUID: QmqgXVzcnpKUIv8btvnB6nEQVQbScd6R
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

