Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9BB3D6567
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbhGZQe5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26272 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241044AbhGZQdz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:33:55 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHBo33007955;
        Mon, 26 Jul 2021 17:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ArJ8Js8eXO4MaNN3anffJYD7fPrtR2nkQGmjyxPvpF4=;
 b=gtImzQq3SlUsJRziEYoWrjLUeERyLNhhRYw7dpSQqaFvYa3W9vDnuvvqWD6BH0xh32/v
 +hCCNEJzddKj2KbYuuwOcFq1h68PiGrm63HmxkI/EMP8PRzxP2tzYZblZXlVkjeXqmBC
 Kac12TbayNMEQ45P+jqDyY1/KLwjqTIwXOQ/SJpxJbRGl6NwveQLFeEqjsiP7z36XJLj
 0odEzDDhk92qd0zBt5eX8ChbEqXKSbPWZ7+iHv6HrMf0UOT7f3rCc6gNdiloTbwBwGjo
 /BtY82OKv0pRNn1N4BzTc23UCO5t3y2mRCpRc0oPZ6L3e5esjywEqnxC65+iaDG3Nw4D 8w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ArJ8Js8eXO4MaNN3anffJYD7fPrtR2nkQGmjyxPvpF4=;
 b=Sf7FQwTuUTAWeJagJ17zjb0SEHV+gbvVklrDDqRqHwvKpS+0Aqd5Yf5YJJdXNE28VseS
 LQ0Vj1CMUMozuwHrr+g73P+zmRl6ETQzIDrTJerEXLeNASqDRjr0H/ITCHjJtAI2e4G1
 v7iTFjHbiG5BkYNd2Ow6BNdfKUO39h90hNLF/73bR4Tzt6Tq+nsDe7BfpF09TUuyWUFT
 L6+SmAYSVYnLfNMPrKSon3s3mUxBH8ZVjDSnyqWoYzCZELKupbg6L8O77PqpBVnNQR1u
 BGj5SeMRjRGBVAlmVmydMrwoF4lGcEE3vvNu6y6wWq3CPLcQWZ7Zj+6hwbJJi9iKAPc7 Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1qkqsk3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:14:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHBdED043758;
        Mon, 26 Jul 2021 17:14:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3a08wewx0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ceini4Kem/7TCD+HyIT+3uuqiLiOnXinPX2oqXQ2PTUgDBUP5y6E1NLIZMqX7hvY/HRvc8NjZ5jCg0o1vbA31SMSk/QD1UL5X+HkNlzcchVk+xOje84jDRYO3MNRWOfCC9Vuuulc20mc5tfTzO41KyKMkcBYeAa/Eg3XbrkabHhOez7ye89/PaYqlXOlhNdM2Hf8H1tIRt0Bb+I3ayL4gNgsCvYHVwxrIM2o6gPkEe7lEJrVs9w3MAftQ/IPRcOeTrVoFzPl/WTeD/LPO8OBQiEB4Ji6KPF2emrJsSghtGEQWO8hWUQRezfLfUT1q1xcQib/ynCc6RjO/XEqrm1LOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArJ8Js8eXO4MaNN3anffJYD7fPrtR2nkQGmjyxPvpF4=;
 b=ZGgrlYalSbqyaGHFMsERiV5GWi+TqSPh9Wy3t1TbVzHjxy7yqLpJBhRTbelXkid/8TMgRzBs5P+RamvyTIFf8Y+NCFpOf/ilN3a3/fb+Uge0dQRpetvd2hhuqTUTPfgfuR42xeVgmERb3XV2C09O8vkALbV1KHR11vcMrFt86yieyF5sbJOecXdhnsdkwJS4jPuXN4C9he5fnZUcohfyLUNT3/x5688tOAjgIUl0X8QwXMzKfbcYDrSw9zHkbOQE8bI5PCpsviXfKHRKIZTWwHtSeYp6sig9euCmPJJHkH8Tlj6SFVwP9a16yoNR5mUEieFutXrjeLgAuTclGRf1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArJ8Js8eXO4MaNN3anffJYD7fPrtR2nkQGmjyxPvpF4=;
 b=I/6ltUIC7q2zXnR2W4OpT02813XeIE1Z3wkdkvM2cVrypq7TdrC1ZNfZ4KJaNeBaXVth3c5qXDNAsX2FC3xgewio9RdTtAKEngI0S52ZC/Ebab1IILdTOXiNaTaMDHGan96yG0dNlsgkl8q1YiEvA8rdyKtZSxeg+F4Kf5/s++I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:13:59 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:13:59 +0000
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
Subject: [PATCH RFC v2 09/12] KEYS: add a reference to mok keyring
Date:   Mon, 26 Jul 2021 13:13:16 -0400
Message-Id: <20210726171319.3133879-10-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:13:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14d8a7f9-ea8a-46fb-bfac-08d95058c1ff
X-MS-TrafficTypeDiagnostic: CH0PR10MB5019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5019EF2B1F506AF2349C3C8D87E89@CH0PR10MB5019.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqhlRa7mU9XY41YWlu2HkhH+D0hWXeZhn9R59/DpGiwpWkKh03Z4ghRJHXggJiB8qhd+ugrM+g4KYT1qZyXUzpIpPwN0KX30H0pXWTkqS+iQsi4XrAy54YDKrDvWzO/A5MlDt63zM58aGY0Yd21vqg1NxUPfzASbnD0TrU04BynjbdESSlV2s4Kxu8+UwEzRdEys32PFaK3wq7I7ORXd1ySct4P6uIkA+cSjJLpwi0UQYQmxutWEq9rwRmD8qXt+nXkqzkPGHPEguaCawCT6NI0qp3Ivr2WdqT6KZIpo/eyRSQPjJunMdn7fNY2/lcHPg5PME7+0xx6jECT7gsu7YKVxgCW9H/q+M6bWIp6Un2XkLgOWtVQVNluXZW59RiWrEftMW6TB/5aFzgjIyBxn6HiGsQo6Fqqtsn4EgDhfQiGXRplfZCcH12Rq+2h50iRRaLZxcnN86yemWPUPn174hj4Tm1i9yQYIbKHWIe4nUFdVub4ZAH1gudp9jztFvbscg2muMtvWrcvTy5th8kXO/KrE2k4Flw8RIiowDRMDD4T7/EOY5otV/4e3ayVP+06qVl6avRKC4U3QKMY4iHLpZ8PH1S9Gc/0YkB5f8/BQVmERfRdrgHXu4cAVRAKqxzBR4koBuuSdvZCSGRAj9IQXKj+Tg3pgt2dmW2QmFVe5n6bUzb+b9lN+DH1WDCsuu+aMfqMxeAQ8ENYeXabI1KegjsufKt09I0/xh3ik4LOHfTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(66946007)(508600001)(8676002)(186003)(2906002)(1076003)(4326008)(7416002)(316002)(956004)(5660300002)(2616005)(8936002)(107886003)(66476007)(6486002)(66556008)(83380400001)(38100700002)(6666004)(86362001)(921005)(7696005)(44832011)(38350700002)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MsnjLdRcl8itLJzx3DwuaHRcnRtmobkvH1xOO90KPfVy2zCWgqAE+Tl3bqQV?=
 =?us-ascii?Q?d193OpHvcdGLWP5QQNgPkL6WIy8i9yFFyPdSKdxBbImdH61OKNU4mDy0GgXB?=
 =?us-ascii?Q?bbjdEYQ0pakGtIgH18kIw8BUtX8lxysSTRIvH3onjz3//na2c9HTDRy9wa+E?=
 =?us-ascii?Q?Oix0cZTV1maMRBxwzJRV+nsSHeruJynuNvmy/sF7/iU939AH5x8+RQ/+7Ifv?=
 =?us-ascii?Q?8xbX96ZEgax3tDNCI8AjTjQqDGD/otcMbtLqpJMTgZ2Qyc6NumGPh5OxrCMl?=
 =?us-ascii?Q?YmuJJiJIZ1Et+wTi1gzx2pCb2vsJthZwU7F+szm/KVJ/92GlPnv8V/7pYsrq?=
 =?us-ascii?Q?Nrb2p/8sp+x5scWdMAQo/eOi2Bw8JlRI3p8Jn51EhRyz+qUYnK3dv9PsF5BV?=
 =?us-ascii?Q?DzJAFV0/ajk3jREYMdgddcHuvyeIywVGx+zGd66zOH5xMADB9co5lKlMlTNQ?=
 =?us-ascii?Q?ThyHh3GqfoYl86JhVXkdEb9BJk5VB/yxR+ON2auD3CyjcAeeNm+RN4a8l2Id?=
 =?us-ascii?Q?1uvOjEgaO1eKiGDxA4UwbaMATVastcl3rycKbKgFZT4aERYoQ6xCNhjS3L92?=
 =?us-ascii?Q?g+a7qDTlWuXj7UqsKdf3aRJzyd2Hnzc8xWW9NRC56sSanHlfo50hTo+C2X8h?=
 =?us-ascii?Q?Jj2xnrpSVrPsy5CygSV+26mXN6uZGGxKHFzgVcGWfKrRdSWbW6uO+Jc0u9tz?=
 =?us-ascii?Q?DFL8s1Zo8nUdEP0VP6DgFsynbIJ8JKmTW06N+Utqi/JOdsZo1oKSf0hNBcSv?=
 =?us-ascii?Q?Ven8kRQI7h6cij3Jf1DjsJKbCFwnJkKWPhK7Q8o5kQvLzmWn6PY+92Sd0nzK?=
 =?us-ascii?Q?TgcwouZntR+s+cHMy09YwV0ra/jxcpEqsikcOWrlmB/RqyDznbruA3x+pIyb?=
 =?us-ascii?Q?6jz/3kLdvfHZIAJkLigdeOoH7ZUcvreONuxdztWJo9Hk2hMwuEoOUAgHobdw?=
 =?us-ascii?Q?Q7LjjoaVTAp5HaMo4U0S8OlEbtp7OaftjBXouqb8Are8nv5BpHnLX4d8HJu0?=
 =?us-ascii?Q?CHSVdZcUxjWOrFG7/XiEsEqzMWW/u6Vty0pxbF6O6ARMOUCDJXE9F6/VXG3k?=
 =?us-ascii?Q?53jrW9C72JWjqdM1ld1i1vjjlFCH0W940L1zieNJ1uY87E8qPAwJ2u5Tw/lP?=
 =?us-ascii?Q?HrOyf2uccCpfm29bGMvXU1jdk8jz6WY7+YA8l8Imosdfs4cIwIPVcLQL3tYN?=
 =?us-ascii?Q?Jkhs37gsWe9Ug2UzzOc4QgxOYswlrnMsL4PJl4S6KU2XhP+LhhE2JdkmzlEM?=
 =?us-ascii?Q?gJnSyUoW0yK5ARyWI3dhES2qaa0seE9lwrZXzOBvpM6o4aBXcmGqoBHISo5m?=
 =?us-ascii?Q?YOvCOTJ01C0crRsKAjk+0VCM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d8a7f9-ea8a-46fb-bfac-08d95058c1ff
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:13:59.3645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFjssuiurGB7ERfqfkmKZm/Vd4VQ7uFMl7hfXDHZir3vALul4XJFaYqXyFHP2iA9k1wCgFrq/icj+1FHJ5+IiQHwl9wyp3dPpIskSBFu7+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: v-TVcDafSUTF2YNYqYvRuV7GtK5ZgHSz
X-Proofpoint-ORIG-GUID: v-TVcDafSUTF2YNYqYvRuV7GtK5ZgHSz
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Expose the .mok keyring created in integrity code by adding
a reference.  This makes the mok keyring accessible for keyring
restrictions in the future.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
---
 certs/system_keyring.c        | 5 +++++
 include/keys/system_keyring.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 0a7b16c28a72..dcaf74102ab2 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -27,6 +27,7 @@ static struct key *secondary_trusted_keys;
 #endif
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 static struct key *platform_trusted_keys;
+static struct key *mok_trusted_keys;
 #endif
 
 extern __initconst const u8 system_certificate_list[];
@@ -317,4 +318,8 @@ void __init set_platform_trusted_keys(struct key *keyring)
 {
 	platform_trusted_keys = keyring;
 }
+void __init set_mok_trusted_keys(struct key *keyring)
+{
+	mok_trusted_keys = keyring;
+}
 #endif
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 2041254d74f4..1adf78ddc035 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -94,10 +94,14 @@ static inline struct key *get_ima_blacklist_keyring(void)
 #if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING) && \
 	defined(CONFIG_SYSTEM_TRUSTED_KEYRING)
 extern void __init set_platform_trusted_keys(struct key *keyring);
+extern void __init set_mok_trusted_keys(struct key *keyring);
 #else
 static inline void set_platform_trusted_keys(struct key *keyring)
 {
 }
+static void __init set_mok_trusted_keys(struct key *keyring)
+{
+}
 #endif
 
 #endif /* _KEYS_SYSTEM_KEYRING_H */
-- 
2.18.4

