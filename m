Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6937D3D6563
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhGZQey (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23372 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241035AbhGZQdz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:33:55 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHBpFW008000;
        Mon, 26 Jul 2021 17:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=l0Hc3OrVRdyYubbnPL2AmsyeHp+KLuDWkOWF+PubySQ=;
 b=t58W39eRIcwXw3WKxdXeLBrDXb2mQxwsX2jPni+N073wS1u361xnfwk37IB3Ud7bIBGa
 81cpol2QxoR3EcrDRGQk5Ct6xwjvOmXEs/32itAuoOM1in9IUHTLT83A6Xpee9gXB6XY
 OSKJxwIvLPtjDQsr/yfw57rKgSeMpBkHqrK3GdzUSwcBnswas6gOpq+EAwVRbRLk2C2x
 Ry0kq1wxrVKVi+BD3FZ3DhdQtQpCWWWWzYDVF3kYLaecCwljaV7zTWR1Pwh1JeAoAib+
 9mASqIFYLMdP5TjBpn44NTLT/4OmXGoqgxtAZPTk66Ohyg3Mkiq/ziCUnmuhbANsXpvq 0Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=l0Hc3OrVRdyYubbnPL2AmsyeHp+KLuDWkOWF+PubySQ=;
 b=WWONsCrLpMau67/OJyrKZKtt5pml+ob1DIeOKyq5mxkuiS/SmliKJdf5VQK1tA5CXZNC
 IkoUmEo/JF0vdgqExnzI8zqeW+1A1u1Z3vfvtyYl/TJVup5OkWrp+KJEP2yu+qHxZ7Fo
 L4OaonO5ZqOoSfg9uvXes4SoB+57pQlP19ic3VP5jSoIhzGbVlvlcFVXEPid8gp/eRj7
 I9LzSuxYyaCEfRWl9hv6x2mW6RwXopNjV/YcV1392eg18Xr28Umm6KxH4zQU0VbLHIu7
 vHC7uIhq46PZ6ssyVzwsnrmIRP6QKcMnfJPSHhqFjfbDdLLcuywi+zxtEtwDNbOS6/mS 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1qkqsk1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHAhCH005160;
        Mon, 26 Jul 2021 17:13:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3020.oracle.com with ESMTP id 3a0vmtcv8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn5xVvk/CNqYZdNtz6I5R5TvktUoB8F/BnskmUegk9sRzUqs/abD9Peeg/rtgoz5cQhlc4Ak9+toXaOJy+55y+b+Q4h9IyFbJqBbyw2xDBUFDG9cAiJ/BBlWKcslpJQWcKJ3C5j50dnuVSaOdkXQyF82iHoeA4TR6fcSgvLVt+JCK6nH7huix24ibYTlh/8U0OiGNz7z8Z7soD57m0TBOsqxIEigGZgpQEacPJcA+//XE7RbB4o0/dvM0FvyXHblCs9xEn/TR7FNf5/63QY+ZCEVIqgEQqbl02U9hcz6lnsOj+paxy+zxIW8fz4JAZk0CVa1qyj4yBJNlpfvGUovDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0Hc3OrVRdyYubbnPL2AmsyeHp+KLuDWkOWF+PubySQ=;
 b=QWsuWBIKQFVtsQVrB5gC/CpxwbYk1n4sv4VJv+2DfmOicJzE3zBvs1dNdkWTt1ZpLc4e/dKqxy1LZKIAFxawyRC7HbdY66GKOjwVpaHnwOf2x/ecIPsMoffM0eRUlMXYHSx3ct/Yd0YJ2Dk0OVlW8vD6UF3ZyU7W4jc1UxedZCVVTYpIRsr9+MgBNN4k0F0KLDSwUGc/+xupAtI5F30Ssw1OKReDDQ1RqA4fprWvBW2wDYZhiD6HYtIaqUeBZ+fGMZOXrI2AikiwWoGPNHvtoXjcF0JsDp47tJid8JzENexjxoiMa+4WGGZyqODnW+FLjKnWNf/SDXGfMkRrCCT1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0Hc3OrVRdyYubbnPL2AmsyeHp+KLuDWkOWF+PubySQ=;
 b=UOjiUKvw58cnnVAW8kuC696eK2UFtj6oCOTLHt2JdL5pnRU7xnW6nF3OBoAB34RGaYBQ8ba8qP89R/gduIPaTY/mg1Pyb9euOEkuDLh3nMWCNRn5LJHpKI6meagswTtcXx7RWYRmYWjYGvQcQ6mOLLlponTn3UZ/AySK0wFGeM4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:13:36 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:13:36 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
Subject: [PATCH RFC v2 01/12] integrity: Introduce a Linux keyring for the Machine Owner Key (MOK)
Date:   Mon, 26 Jul 2021 13:13:08 -0400
Message-Id: <20210726171319.3133879-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:13:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef61e13-f484-475a-e569-08d95058b468
X-MS-TrafficTypeDiagnostic: CH0PR10MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB52111C59E63A287C2ECEFFBD87E89@CH0PR10MB5211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbVqZlgc6kdwbnwXiSVNFLiiEIpw3v6qkL99VJtDqumMck5phHb6ufHfhn9YurGORTuhL1l4cTTnzMmJ2a5sAUmM+mBdukdqoSizncF0l+zR1LX4XMgK3XPNjP+zvbKDMDyy5oRR7Qv1VRsqlOwfrSVOQ4U+e1QepSwzADWe9IvQ2rQ1MDjjzleyt9yZx03QcD5/7Jrm5dfESc0Q1PRdl6GpEyEWkGdrOOkjv3nUDiRsUZtMxyBk2A7LX98OqL+mGiQVdMQSajAi8gSyFTqz7jNdO6CUILls6nolRCNH3tH68La/8txQ0guUI6ozkkXcJfMtxDMjHJOkoRm1gj8cOMt3awOfnnUQzR8ySGuc04ZDp0eT2f2O4Ei1DYn5mzI3NAiLQ9w164G3UHFOzaID65u5AyQs0GgG30qTuiOYald/eyaeXpRhKFdIQlFPXwuGNBOGXs+3Dn2WXqj7jDMMRDH3DzGrijum6TH5NiKkpWlOrslOwSThqE9yCkN3KOaKeDAwCp9V+A3NE69w1MFNt+jJ6/06/iCC76pII+Zf64EK4x7WTIJ5qE+QS8wTlqffAxH+rWYUXY5hEPP0vyuH9W6RrokmsgXl6vGHTTZwXbx4uCGWx7tMN3JYb8oQ3WM23prB4PjQdkhGMuRzs7ojgjLV5csuMnfepU7eUxg7w2uqxqLHpHSwG8FVxiNvcR7Zax/ZJlyCyE91Z4y/M/cehyhJgTT8QrE+kAZRax8IRxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(1076003)(2616005)(7416002)(52116002)(7696005)(44832011)(478600001)(36756003)(66946007)(38100700002)(38350700002)(186003)(921005)(956004)(8936002)(2906002)(26005)(86362001)(8676002)(5660300002)(6666004)(4326008)(66556008)(66476007)(6486002)(83380400001)(316002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Tbw6Sv64vd2y6qjKMmC2swNApKqSjlwLZJJoTFw2xKMhByQ37VcJHWeA81/?=
 =?us-ascii?Q?nuTVy1swI1bx995QsHUq2h/FRVvpcn6KCNIWtIhBoCCOaeSDdKgnRiwHD50v?=
 =?us-ascii?Q?D9mk9U3tsAMNbn0cADSehc3FQXYYH4sYRtJPbG/VjyEHaxxynvEuAI7T8Eo/?=
 =?us-ascii?Q?mo7EDzclvSizNmSHqclbuBD04lzJPfrR+Do4KxNttaNIV2odg2oAUSf+mxRT?=
 =?us-ascii?Q?+OAT1HNq7fOSD32XPV7VHZYnnddLOCGnZAg5BwSALTAg6IEScaqHzDr0mBnK?=
 =?us-ascii?Q?k1RfgYWNt3Tzu7TACWKNHO2WrZi3ttN0esIAjXYmBHfCiCYg0JWoaj6LZFH4?=
 =?us-ascii?Q?NavvGuguDwjbElL73WVRBCPNdaJSsA97HiOrsc1QdujXTh/Q8Zbox5hWT3Wb?=
 =?us-ascii?Q?AujvXOMLTv+OU735HshFTgHoK009PbNf/hiE2o/kvCSfd3JYdnYmK8j1qbl/?=
 =?us-ascii?Q?UEUbrd+clUckQPx8LvTg4geY1T83dXf56Crq+lqci5CkG8pA9BrDw1SYjJbM?=
 =?us-ascii?Q?FBh5pJhk8qbR8kIMqUM2T6+jRKnp+TELgT21OBVJ9kiJK9dS12SBv3uBhm3H?=
 =?us-ascii?Q?YFLSD12qsozWVwMpzfWdLO0RPs6NfQYvvpAGBcFiKk77b3sall/GrAa26dQQ?=
 =?us-ascii?Q?e3wBnp9W2+VhAHdhLCKuzo41lnqKmG5n1KG9ez/+QLWBc7Rq3QSd8ny8niZO?=
 =?us-ascii?Q?4ceG5ZEL7ZAX88GFG40Nz5j3gmZcxmJQwfbJZsQfXx0Z4j4Tk4kObH0wRwxQ?=
 =?us-ascii?Q?wG/dQBaJc7geFLrJxgVAY+ynUw8UGBpxUw85l+YzocLvrejkD73WNJXE1keO?=
 =?us-ascii?Q?tf3sViQTA8rQXRhTInKKTdAI24CQggUCG8IVoW0LGm98xZRGT8ZEwkpvIAHP?=
 =?us-ascii?Q?9nX3RB036TcVC8K2Uf7QkNJYtJxs+O8AOf/Qzgda+ZIwJ1lpHDirQxN53DhW?=
 =?us-ascii?Q?/HkAV1goAur+yOfUtVx5oszxJKjPX8mCZvp1RCzSTxDYIuZzA8SRm5kJoy2i?=
 =?us-ascii?Q?0cohBLEv8ETZbWCyj2juZNHj7eMj2CJxJAiHW22GQFBroNqbz44Lbt7PfpPw?=
 =?us-ascii?Q?/NEThbTIACsTvO/JwZCLu6bfhAFWuSBpQmuFisRUj5gUsmNQVurbko/Nb1yw?=
 =?us-ascii?Q?QvtZhygNL+WC72wKYk8RfGSb7jVAghc10VCrBArpMSpjHulrO+OlCkuQ0J7r?=
 =?us-ascii?Q?2vPMko/EfsV0p8OUnql1gzkRTCgewKFfzWg+J8saM826ag/zaWmAL9huwB1w?=
 =?us-ascii?Q?ptKzy0O+WGgVS7eESnG/2lAXMcgTRAMA5/BaPpMliINB2K08iD6VyInC/mpr?=
 =?us-ascii?Q?1a2Ea5m3xPX0vFPR5kWvhBFC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef61e13-f484-475a-e569-08d95058b468
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:13:36.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ug0VIKatbchfKvLEBnBnHdyGX+Z3MPypw4gk3FoESOE3iDMkHRFCjoWEJprBq8V8c5n1oTfLm8YW5bsnNUSg25KGbqBYfCipkhbw4sh4owo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: 1tE7YwvdNHp5MI6B7lPxj2QuUeXQIduk
X-Proofpoint-ORIG-GUID: 1tE7YwvdNHp5MI6B7lPxj2QuUeXQIduk
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Many UEFI Linux distributions boot using shim.  The UEFI shim provides
what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
Boot DB and MOK keys to validate the next step in the boot chain.  The
MOK facility can be used to import user generated keys.  These keys can
be used to sign an end-users development kernel build.  When Linux
boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
.platform keyring.

Add a new Linux keyring called .mok.  This keyring shall contain just
MOK keys and not the remaining keys in the platform keyring. This new
.mok keyring will be used in follow on patches.  Unlike keys in the
platform keyring, keys contained in the .mok keyring will be trusted
within the kernel if the end-user has chosen to do so.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed destory keyring code
---
 security/integrity/Makefile                   |  3 ++-
 security/integrity/digsig.c                   |  1 +
 security/integrity/integrity.h                |  3 ++-
 .../integrity/platform_certs/mok_keyring.c    | 21 +++++++++++++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 security/integrity/platform_certs/mok_keyring.c

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 7ee39d66cf16..8e2e98cba1f6 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -9,7 +9,8 @@ integrity-y := iint.o
 integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
-integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
+integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o \
+						  platform_certs/mok_keyring.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 3b06a01bd0fd..e07334504ef1 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -30,6 +30,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".ima",
 #endif
 	".platform",
+	".mok",
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..e0e17ccba2e6 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -151,7 +151,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
 #define INTEGRITY_KEYRING_PLATFORM	2
-#define INTEGRITY_KEYRING_MAX		3
+#define INTEGRITY_KEYRING_MOK		3
+#define INTEGRITY_KEYRING_MAX		4
 
 extern struct dentry *integrity_dir;
 
diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
new file mode 100644
index 000000000000..b1ee45b77731
--- /dev/null
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MOK keyring routines.
+ *
+ * Copyright (c) 2021, Oracle and/or its affiliates.
+ */
+
+#include "../integrity.h"
+
+static __init int mok_keyring_init(void)
+{
+	int rc;
+
+	rc = integrity_init_keyring(INTEGRITY_KEYRING_MOK);
+	if (rc)
+		return rc;
+
+	pr_notice("MOK Keyring initialized\n");
+	return 0;
+}
+device_initcall(mok_keyring_init);
-- 
2.18.4

