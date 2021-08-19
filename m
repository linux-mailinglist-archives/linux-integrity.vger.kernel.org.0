Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360C33F0F28
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhHSAWn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:22:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63462 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234613AbhHSAWk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0GHdt021771;
        Thu, 19 Aug 2021 00:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=n2pBSxgYa6jeHvx1d8x3ULkkZ8Ct+nWMSHeQyv0xkcA=;
 b=NXt92w3xcx60d6APpBpT//HmRpUbt+gX5De8aYsPbwgBuABVwtp1s/uH6w8FVQQIAmIF
 aG4h4l+YQ5x1cf8aQEzfyuukpo4DAviugE0g7sODZh/3jd0oNYrGbsBkILu6n2BraHba
 O6BHtFCaBQMtQbm1E4RNoiEUVZS4+tZCRXovdk9kRBt6O9PzA9f5XXUBSQBRGoHQgu6v
 SmEElvv40DrK429mx29og2ORe6U9dqboSdxV9g7HQPBaYP93eGcjJSr8UXAHAG5K6au4
 /Ti5SgiGeaJP7HoKN7uOjx7pVecdTbuOA+H0tgNDaHbArBx+EZ6cWU6+8ZCit1dUIuu8 GA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=n2pBSxgYa6jeHvx1d8x3ULkkZ8Ct+nWMSHeQyv0xkcA=;
 b=u8zFfXZtKFrUBLxFvLp532986isZ9Lry3fREAJ1pP1dwXC+JWiDulUgYsdKxSAm08g4R
 Kl0/4r2gX1I/NPbKjhPF8ibFUNH1tcST88Bl4qehpVC2tj8GJTPzy8/LsvT39Kv/nzJZ
 yB7JS0ZFTKVJ5L4dgfTLVSpl5CElyAvXku0TCbMelj8hrmp5RsdhbE9pY855CrSVUwds
 H/YG+P8DLnkMjGgMjSP8q/EnKRUrTRjr+mCJ3UIh2zQnWaapXLuHhYMwNaNFcghJQzXJ
 uAlJkDye8Hd1K4lB5A0xNsy5KaYViGJ8Je6x9npuQlbPItfL+avIuiqnQ4PfmGHo5xpp cQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24jghs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0F07w007586;
        Thu, 19 Aug 2021 00:21:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3ae3vjf8bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcDaCewK/0b+5toinz2Ub0EucRBs28deV0QgFoau5wwS7FXBdny828V0OmPUaYNTV2UPNtBBMtFCMWpXZ8xP6owM4XYFF40ItAeaNZi5yh+PNzV9OyUNKLILrL58jSHL+ryTVcOz+skYJrzLxh6iCW/NiReUnILpJGL1fzh0JUaD5IjyttxP6M9/TGlKAFaHGy3YCXgb5/GIMbIc+872L3EeaMq9bFcj8N1MRtGlOK4vI5+OmQpp5/WmfkNuyvBHwoKND4xtrOcHFIQW+4hf5oR7u2DroID2gUI6QEJrOE71nT9yCsjV1Hl5L3a8UIBlNx78wd/Q6ugNTEKBVNfBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2pBSxgYa6jeHvx1d8x3ULkkZ8Ct+nWMSHeQyv0xkcA=;
 b=OQL/gEDnNTDPKHGWnBhAyjlI5zFzBKQw801itW/3Xw1FrEf1xq/j9ONAXVVyoFBK70niBVNyk/h3KFn4fpoKxQEAsVr/gen/An+HOV3DhLnxUwgPzoWwCry8kUTkSMHp+Kht7A7m9cuoHPR0wfLja+vOLA7rVYL/JQMCmdtuH6aaSnca5d9cnBneHjAa8sWrD9n4tX50Y2Wj3px74npHLBv98ULgXyz1AO6rv1MyhAUZDKOEu+chiG6GHaZvZ+HTKc6GkxyeS9ndO2i2QV2UBy1IcgQsTO7ERxHA1Q2BlbDYjxqFSZxmGUp1YhMIY47MwOJCLqppdGLzlvEY6zxLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2pBSxgYa6jeHvx1d8x3ULkkZ8Ct+nWMSHeQyv0xkcA=;
 b=nTSlQOdAMZk2T8yvQXm8PRULX9nliIxsnolZCa1eEBeCR31odiEZn+SzxTL7K9MhKBiQurCG4To1dMveLSw/8qAD7XkjEO5bw8xsYIfge+QjmIThAxS/XfW8bo1yZubiod4gybPnXZBKQz4FD4nRdAEtGaR7B8p0qTtU5NFidTw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:42 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:42 +0000
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
        konrad.wilk@oracle.com
Subject: [PATCH v4 06/12] KEYS: add a reference to mok keyring
Date:   Wed, 18 Aug 2021 20:21:03 -0400
Message-Id: <20210819002109.534600-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28294694-38e9-4285-199c-08d962a75176
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5116E66A170C9CF16030CB7A87C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3LCxSrBlfS4F8aqrl6JguduHgOmRQytmSRnxxb5ba+HS/Ypnrne6ZQuoFEXlOCO/EQWLVRvoNW3vmYNb1z/1fA0LosgKrQgeQKNpJWXvvTYrRDt8K3+ATKTqQWEFxO/7RxXG9B/FLu8JHneY8TYU4Gu3uqUg7JRD9Y7uCkLFVqvuI+9b3XuwCb1oqT12Jftzs2VGqWDYzESis8j6FEyeHCP+QC6IgKhFBwRYIxNJTIXQR9DYlGeVXv9m4h8GAALEnlNksURIyHuNnySFKYfG9YHpyQXXeRK7SAd3NKAWTrRjoLkUkVKjVBHeZ48iAB+N/VZ3oxrP1sQnHoaTW7OEtrtWKszdvsagJ7nQRoxRTsyDFjer00Mz9Is6Jg74Nv00bybJCsXtNnuzMc9AT+uWuWExpqxdikVH1lMJPHI0yhtJCD+IxIVQ9PPLIdYGTT+00FnXLh0ylISWYM7knsu49esJpgTCrmX2J0S/zRgoseN3irlHthyhzLEwl+vCgi21veO2G21ARScplO0PaXFTRf4mbGYB7ny8ZaFt6zCq2tyRvankNe/pWnnzg1eLYo+rNQHJ+RDZWX87VMJGilxGph7703YvycSjqpI/f2Ox87BqGDWtU2LeTYiMqMZcDU54JJu57Ga+EGisqODB7zCo53F0GrIC4oz+0QfZ5pISJaB6RIDuaRqOD91maGHLbGY5aG0Ehkdk30PKedpth7bZ2VLbV0edBbzqeTNAwmAP1VQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(478600001)(6666004)(6486002)(66556008)(66476007)(83380400001)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lQvWfEDvqNWq3XDzyIoiQ+skLT5Vg1T7T4lK+JX02RK0Ol/dMYHhaJoE3dEu?=
 =?us-ascii?Q?lqOfSQqEl/tqoiB8tGrwmuDwI3TwuNVIdmbqeKLQsNzIu1iD8ZDDAL5eMF2c?=
 =?us-ascii?Q?CEwDEaBeVurQCa2CArx30k5tKbjVqugBrlwY96Rkepk9hem5Kilh/HuUvkyR?=
 =?us-ascii?Q?qwLo/0ZQH6hmZRqhKbu52aY/GwN63KfFh5aZOB/G5CymhYzG5dnR45P7irAF?=
 =?us-ascii?Q?IDjhbt1VxWHqcahV7/jewQPPCoBVL+DrSv5IRn+v9RguH4lH1QBaU2hjfUtK?=
 =?us-ascii?Q?xIjOMe0b2cTH6pg0QK/v2+LxdX7hdvnGob8UbbdCxaijgoCprGf56k0YLMmR?=
 =?us-ascii?Q?flaEmpLjx/ZbF9CWim7ILDRxvBPGGXvSQiP5D5bYFne6Mu5C/pRM6dKgUNNL?=
 =?us-ascii?Q?RNqMPJrr3AuwQsraYL5asG6sqqJ49dgGR2V6h2HtCHVTrXb0CPXbFXq0BcqB?=
 =?us-ascii?Q?B6ortqhKv250ST8gChJVyRBtQy1eC1+ETQWis5OkSTuJ08OkdRZUmnYS6MDK?=
 =?us-ascii?Q?OS1dk1/SWxNUJV06vlcXL45NvAxCNCdxbQU9nn3fnafCLc2lsrw162zOXuGx?=
 =?us-ascii?Q?rJBVj/N0yW6VmrZ/U64Ri0poCn4e8Gr4vuN66S93xs0TIgBkAwoMlveUXrUV?=
 =?us-ascii?Q?ujb+BkEMYqPV2Xagz/wmGZXuQF7g/cYcnuSKq2Q71F8a2uobgmVJuuQgimW1?=
 =?us-ascii?Q?et2rI1ua8iTposD9k5FYLHumHeHFDLnhvgTIUPXIN2ucZp6aPmMzhEI6TGrk?=
 =?us-ascii?Q?qVdGA6RW0uzy3Lu2OiEpgi9XRg93cXHbM4q7Jj6f0Cii3MDDZRpcvpTrXf8C?=
 =?us-ascii?Q?uffTR6Gkq2Lzp4wRWK8oz4qI8FpBrLmtXPrNnfTK8T8eDHmaOwLDYSZg5jDJ?=
 =?us-ascii?Q?3ELqEdWx58v2AvVVvtJ3jXC8Ynupkdr0auJILFkF8UOl8RY0IB0cqVLGX+yq?=
 =?us-ascii?Q?N+h1FPbxYqxcBd0fwUSAQX8ooM0TP5DcMMD0Y+kY1ixh/SkRnecdcP9FnnKx?=
 =?us-ascii?Q?VcvIaSN36yxZ4sjUxDLsN1Iwo40sfwqtjPnQJLM0tDL443ON24NN3bYa2uwi?=
 =?us-ascii?Q?yTmF5C+suenx26mnZQ6gMZwTGc9JfmbhRwVNqN2yiHe/eAulDGcDiZieiXJ1?=
 =?us-ascii?Q?fW+ixxAanJ96T1r8au0YW93xOq1pK5jRRcBEasBuIqyH1yxw8DFIwjTkYkCr?=
 =?us-ascii?Q?No+gNKGGaQlWJqC6GbtToChkJ02FSoKj+FcGJ+iPQv7fXWzqujpcDF1lPUsS?=
 =?us-ascii?Q?f+BVqNsd/8xVASmbGpGF3ELyBbGbvYsIXcanpCDg/xOkH3Yw0Pe74vW/GkaR?=
 =?us-ascii?Q?jcHxS7D9Jp1JhWQWXTZmfJpI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28294694-38e9-4285-199c-08d962a75176
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:41.8805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov4DucADwmDYW/hF8q8eTf86/G4JfyREOaFA41zI8le6wbiMmkpv7AnVrLENDhrtHe3+hI7jLAMeJPQBpzsqeox1iOZYcuv1QmkIgLRh0oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-GUID: 0Ix4MZGrVnvKg3Vwrg6TztfOTEi3PHj7
X-Proofpoint-ORIG-GUID: 0Ix4MZGrVnvKg3Vwrg6TztfOTEi3PHj7
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Expose the .mok keyring created in integrity code by adding
a reference.  This makes the mok keyring accessible for keyring
restrictions in the future.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: set_mok_trusted_keys only available when secondary is enabled
v4: Moved code under CONFIG_INTEGRITY_MOK_KEYRING
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 692365dee2bd..94af3fe107b4 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -22,6 +22,9 @@ static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
 #endif
+#ifdef CONFIG_INTEGRITY_MOK_KEYRING
+static struct key *mok_trusted_keys;
+#endif
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 static struct key *platform_trusted_keys;
 #endif
@@ -91,6 +94,12 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 	return restriction;
 }
 #endif
+#ifdef CONFIG_INTEGRITY_MOK_KEYRING
+void __init set_mok_trusted_keys(struct key *keyring)
+{
+	mok_trusted_keys = keyring;
+}
+#endif
 
 /*
  * Create the trusted keyrings
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 6acd3cf13a18..059e32e36b3a 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -38,6 +38,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
 
+#ifdef CONFIG_INTEGRITY_MOK_KEYRING
+extern void __init set_mok_trusted_keys(struct key *keyring);
+#else
+static inline void __init set_mok_trusted_keys(struct key *keyring)
+{
+}
+#endif
+
 extern struct pkcs7_message *pkcs7;
 #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
 extern int mark_hash_blacklisted(const char *hash);
-- 
2.18.4

