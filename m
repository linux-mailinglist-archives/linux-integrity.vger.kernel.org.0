Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F603BE127
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhGGCsK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:48:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64698 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230123AbhGGCr6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:58 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672aKj8004673;
        Wed, 7 Jul 2021 02:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=AcJ5Vm/PFZfAwSMjIejgKMjx+s/HnRr7by4aEdvqO2c=;
 b=j3uIHIvS26hGHBcaRK9gGYTOFBtKqhROvd5pV51jGHT0WbcLCxcq1iX+99BpmRQNCSpi
 Q1m0ijtsr2XzKpYnHJ5Gvt5ZOrADKtF80QJWY+E0cATrV0fZJYUbmV083okIjeqZz+mi
 PP9DdoJZxDXVZpHORvucrMD7fLlA3TWFVv4vziwajsCojMttC+c4DXpI/9/axnPoP+RZ
 WSBl+mX+ylFebH4EiTpUX7GRp2qDSe/SeUziMc1jNbpREjVdvJljnHhtNV/uOlgD7OXg
 eJLXuErdntTRZJWmG2Q7gBX9e/+ed64fwI1Eh0B/TATuJVsBHSq60I+UPkp/sj4jmizz Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m3mhb2uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672aIHs007624;
        Wed, 7 Jul 2021 02:44:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by aserp3020.oracle.com with ESMTP id 39jfq9phdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2ZDBDa/QeP4jWiln2UNfF7DQpb1vGlaEjaiqFEcVRRFvzcGxN97thdt2/Wo6oC4grJJVcyz11FpqecY17NoVhL1NZERuwNSCUupdKLfQhVKWjjNgiiYuv7TJYHKxUK6ewkxUYscrRfjGlBniCXCabDutuBWaI+RHKJVPmYjGRvhMU7TzwMHdty8BFMNwLLfQdQfdqw6PDS+xYa+gwUAJJvrp+23YQiITT51FHOkILSOfoYBLGkjqxNsyuc+3Ycifcmkf46h/uVTgw2mwqjpCXX7TrTJ+3L7YY9uZubBy2MVqdAgyg5d0NDKz2ZwiahAWOgTn+2amWNJBA3ByUq3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcJ5Vm/PFZfAwSMjIejgKMjx+s/HnRr7by4aEdvqO2c=;
 b=U+aWggSX0bl649EPagMZULRB7SYU0GDg4LaZRLhRGcjqgWFVrJHGjHge/baZeOVswYagd/VPk/prnT4r2dHUou2mOv7clKdv0t1rCe8lin4FSpr4Ag5GyIWsnHjoxrE7xliOBnsEPSTj3a17Nj31zWeThtdrFeRIOWsRUNqEb8G4ljmSeU/rAzOczZOozlNDgaBy4hDP8fYqhLrpATsu4crETI1qdYs7HjKgQF0lQq2LM7wiuSwS4VW8SYEkFiC8JimzEH+DCO3AkPW/MiAG2+902pDq6/iN9I/TdBPtbUdKs7ZLDyo2sAB2rMTKiiShlSlAfQs3+z8IYBF15j60+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcJ5Vm/PFZfAwSMjIejgKMjx+s/HnRr7by4aEdvqO2c=;
 b=btr2BWwu/UKWS/sof6dldTrp+PdG0jZdnmR6h6zGJA/BO7HUQlhoLR6HBBZWclSw7/4+cfmGWS7TG/iO3i6ddpaxO7ihRTqoT7m3gcrPQG7VYtyKZQyY8qC6vkMfOymOot1oGCuVt/fyYLgub9cufesja4qAnkYeQCO2bY+bdOE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Wed, 7 Jul
 2021 02:44:39 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:39 +0000
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
Subject: [PATCH RFC 07/12] integrity: add add_to_mok_keyring
Date:   Tue,  6 Jul 2021 22:43:58 -0400
Message-Id: <20210707024403.1083977-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e59a91c6-577a-4970-00b6-08d940f12a31
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB38631E8EAAE7E4A53ECF0AD1871A9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEtfjukE3sVZBk8DX9ZEVDdNoMbDdoi9cma3naJPR8YAd8QghrYzACOr26Rl4+ZO+gIy+XoYcjAYpEynQKH3+x2ZYCoJBTHHdvOs0Zn74NOfw+cqHPpTsQYbhA5Ojrd1pqokFEYL2j3S1HAkPT2i4czg4tNPUm91kOJcsx3pEv76rpD6Oq3f/+5Wu09FiCX4ptmyiXmGNuPH2b40gszWe/chuGemUrofA3vkR8RIehIUtIJZEyotJ1wPZeRNgeKf6KIWbbLLT87p8BGqGXZ/O2RoDfgC9RlhJIBCxOWRT2Em7LdYqA4Q81ZIOkeL7i4zxyQdN/9iLDmKkZpektIhoNMKlUfxdkD8F9aIwqjrY//J3brXQ0qWN1uu6oSA5CtyDH4k+gDC6xAB0fCdM40rcPzE2U+trkeL2GwefXVjNQh31eImgAJKfAwQy5/gjAS3469+QU2HoRSZ16U5BMkrY2nPZKchHMp+BncCIa+V3E5p724U5XrvogHVJv7J5l6EB1EviBSNFvtZlRCbmka4FcogKLstBXYoXuqosD1rgaEJFuGG31Eqw0xYrWgmNluCZ596WdsWzfkEvNGUQY6yp+c0pG/1D2IpRv0NheHAhHK3+Aw3c4av1nyLUHlDOPggVsC+hrpX+o9aMjMPCTGZD25xbzZLCrERS5AWuKR+z5UsopHRaqYhFgSdEfUeYnn/WQ8uF3pHoW/imeiq2EeLPUQyEtryui8xSZNUW++Vdqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(921005)(107886003)(6486002)(7696005)(316002)(66946007)(1076003)(44832011)(86362001)(38350700002)(6666004)(36756003)(83380400001)(186003)(4326008)(956004)(26005)(7416002)(8676002)(52116002)(2906002)(38100700002)(2616005)(8936002)(66476007)(5660300002)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?61Pf4O40z2xKnEO1LjhNbkfUIvUoYqyFWA9yq6vSSwXV+hsKITAukaU3veDY?=
 =?us-ascii?Q?Lkxsx64dpfAllku2mDDUBU16S7bqT7fnK0Frtb0WyiMpIZrHLEOApeNhrcB/?=
 =?us-ascii?Q?YdgGNe3DU3m6q7WFC5KAqC47EwU0WUmLPkiLU+hql5KScMpYoKEyNfRSAo0R?=
 =?us-ascii?Q?yjgUcMDZIBpphBbqwfKJcECC48KcEVkU7JNiCxmpEmuKDIZET1V01u8FM6HQ?=
 =?us-ascii?Q?yA72cdmve0VHAUsG3l4I2hrniwG/rZL0X76LweE2ku42BbILRMfnZzyYiyNZ?=
 =?us-ascii?Q?C7qbtIRSumMJXJSRwPjDc/A36WtFlO2C9ZkpgkrC8/apjhNf+njLcbhYCEWe?=
 =?us-ascii?Q?h2PvML27apwN1z4qHX/mB99SvBSdN7OSd1wiCNpKnUXz7RI9ItSMXPwwgilq?=
 =?us-ascii?Q?WYC1+Fn3JZw96cncyk19Hs66GCNT4by2BSHLNkZDDavVs+DcQkfF3R6xF4Mz?=
 =?us-ascii?Q?ajHIttER8eQTHOxciNlds8ziz+CffD/JG0sgKElAkoAgOS8vAN7ucMKLTz5Y?=
 =?us-ascii?Q?jib0jWE5Xh9+rJB0Jk/Uk7/RyJ2kV5Ua+eC8TtdOCOMkmf9BifPfTrwoz0hS?=
 =?us-ascii?Q?361ewcWChMHiQu2iKBpDAxhcz/ldTyXaodvoCJpLUfkHGUqh2ssLCIZz5/zw?=
 =?us-ascii?Q?owPX2Q5cTqtGrfnpwNnV5ixw1JAeML/Y2W1xkLIk+7FMMqSs+UWlIk69YrYf?=
 =?us-ascii?Q?T4PHJQYi16QUN7bu3a1nxTS7NvRPkpv7WL9Na8JjNBJt2FCUzahBZWxWi5qF?=
 =?us-ascii?Q?ecc5/CvMzgVfWPJNowqKVNz6cNpMAYBBFufs2lAkCjkyTKOEDDQt6YpsjeDW?=
 =?us-ascii?Q?CAYNwmdto7rh2aEyRrOlKJO1cNXG8m0z2aOta7+BUqclLfJwnzP0JJ1K41Ca?=
 =?us-ascii?Q?niJItmcNpb7eNyTz86+fR5xmJId9W6eympj+ne2fVD0lGoBy9CWK17BgcDFu?=
 =?us-ascii?Q?E+4U/qEUMw2fXlKcnSVIyIWrUoJP+SCIXZ6T0Y0XXMsb/B2MCnDtur/KXaZ5?=
 =?us-ascii?Q?Dj6NVTHx06PCLOcTWfJt1nEe2+QYOrrHmWgy1IYqlOkpVfRsYRnRHzyRSkqB?=
 =?us-ascii?Q?nzr66TW6SSWQLsWYmq+TlCm/cY7u8epaHINw1OfscyJQAEFY72dbmbG1+GAu?=
 =?us-ascii?Q?kHo0r9+i/G8oU8rN9Ljh4w+sPFlrPK93nT62b63IyPk/ICbnLqzn4xtTmQbX?=
 =?us-ascii?Q?cGQ1FawrThUH+fg8+7IjMXbecA8Uh0oCzxi/ey2XA9OJ6HHFLEp85B4fq8/g?=
 =?us-ascii?Q?1R4mkADqFPE8TVGYzPTgFPyow3dhaeDwIfBML8U8s9fBrBnKf0f3SA1MJPGn?=
 =?us-ascii?Q?TKBtoPW3qFmPFJzo70SEHgaL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59a91c6-577a-4970-00b6-08d940f12a31
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:39.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLNXBKUvFIypRQbH4M69DgGGEQu4i2PSJz/pahxvUYIHltu+qgqMLtONxhnENQIijLfaISS/Jj6opo72mab3Sz98NlOsMB3ZKv+NbKcGfPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070012
X-Proofpoint-GUID: sV4X-iYLqK-M82kNBRj1rJKkqvj-Maw6
X-Proofpoint-ORIG-GUID: sV4X-iYLqK-M82kNBRj1rJKkqvj-Maw6
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add the ability to load MOK keys to the mok keyring. If the permssions
do not allow the key to be added to the MOK keyring this is not an
error, add it to the platform keyring instead.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/integrity.h                |  4 ++++
 .../integrity/platform_certs/mok_keyring.c    | 21 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 5126c80bd0d4..68720fa6454f 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -284,6 +284,7 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 void __init add_to_platform_keyring(const char *source, const void *data,
 				    size_t len);
 void __init destroy_mok_keyring(void);
+void __init add_to_mok_keyring(const char *source, const void *data, size_t len);
 #else
 static inline void __init add_to_platform_keyring(const char *source,
 						  const void *data, size_t len)
@@ -292,4 +293,7 @@ static inline void __init add_to_platform_keyring(const char *source,
 static inline void __init destroy_mok_keyring(void)
 {
 }
+void __init add_to_mok_keyring(const char *source, const void *data, size_t len)
+{
+}
 #endif
diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
index 666fa355996d..a5644a8a834c 100644
--- a/security/integrity/platform_certs/mok_keyring.c
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -28,6 +28,27 @@ void __init destroy_mok_keyring(void)
 	return integrity_destroy_keyring(INTEGRITY_KEYRING_MOK);
 }
 
+void __init add_to_mok_keyring(const char *source, const void *data, size_t len)
+{
+	key_perm_t perm;
+	int rc;
+
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
+	rc = integrity_load_cert(INTEGRITY_KEYRING_MOK, source, data, len, perm);
+
+	/*
+	 * If the mok keyring restrictions prevented the cert from loading,
+	 * this is not an error.  Just load it into the platform keyring
+	 * instead.
+	 */
+	if (rc)
+		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
+					 data, len, perm);
+
+	if (rc)
+		pr_info("Error adding keys to mok keyring %s\n", source);
+}
+
 /*
  * Try to load the MokListTrustedRT UEFI variable to see if we should trust
  * the mok keys within the kernel. It is not an error if this variable
-- 
2.18.4

