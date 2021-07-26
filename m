Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CFC3D654A
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbhGZQeg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23054 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241016AbhGZQdx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:33:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHBn6n007952;
        Mon, 26 Jul 2021 17:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=NmeSW/zO8BVMJZcO+IuH9pOtMzJchYajDu8YD/VIhPE=;
 b=Ts1cXJ9nDa34ditM8Ka2RMpsS/WrIziCMe1GXEpL6EaZYkRcSP/ekZIZiM0kBkbMay4Z
 FpooREvcpeOUFw525Fejyf2uL5PBQMqizOS2oTFg2hFu+G33Z6KwLH0AX9eyiYhhZL9B
 x0wzmMIXOUAz/eNeWbvv+5wlzn710paoMQ7pUbY1XX6syo4jUEavq2wU/s58IneVxcNT
 Grg27cSUOUxBHFsmFP6YGUbqcXINQkSvo5DHNoFXRfKa44MNlIOXteS+9ZHqymJR4h3q
 PmsefvCy0VTMXTP2grVBwXD6iLLnjLka+5xA7iyUsWHlO5y0KQiWNT+sd3YiXcDIIb6P 1A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=NmeSW/zO8BVMJZcO+IuH9pOtMzJchYajDu8YD/VIhPE=;
 b=eWM5kNCLrX3mSWtK9d4Fa8Fvj0/niQ28/UjjszqRfm+gDm84df8d6VIiY9NeJOpomsL4
 jaKpIB5eVLviigecihG4dtRbDIoIHSdR4F2wy3Jxy3TEFxHOnQCvvq7vpBNqY9BdEvxk
 csNfl1u9kaU3wB0j5LQQZW+21Us5kObf7+jaOoAnpLZe1atALXWjCDvzQPPHR+uWlyWM
 GUIzEgUdnwc7NIiSXhCyvXS6Uo4lwSwtPFlYcL/3Gko1rHjCyQmby19nYNEE8k3pPZok
 RlqxvdEeHZdZiuB1AU5e33twq9s6qQ87xgya4Y3djA+Q0UH5enfk7ix+Hf0AG5Eb8KAg uA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1qkqsk20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHBdWS043745;
        Mon, 26 Jul 2021 17:13:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3030.oracle.com with ESMTP id 3a08wewwmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCoF4Atm++nsaGHuMM78BknNRyd1KVMPnJ9GalWEFLX6FqAPpIFNJqZSiYIXBrSH+npoCRsCvrbfBlXrzgNLJLtkLxt/g231D0LzM3yEcSLKsSnQR3acKLEDxq6R7FHxLAwouPyozlOlES4G6zl5bsnnbNu8GIPAXF+hRL6oP6fpVQ/TFfwJC4QsjSG6Rx+TqvhDcSU6h3RCdg+rj6AEptD4osz3ef+26oN+Csm0yqUT856xBBzWmuiVFWQRtYormlfZnFqlgNKBOR4yTAUtqO9XFG/4VTO+j3MtXk4gqUIk81QrmASG7MzKsLIgnertV8VpOUXaDy+hO5FbpcErow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmeSW/zO8BVMJZcO+IuH9pOtMzJchYajDu8YD/VIhPE=;
 b=QBn8OINfPozhT+fI68rmmG4kVyaHppRqcuMOsJB1CM+AZn1geQMhvoM1yYS+odl/bqYnzsQ0VNsdOBEmUQdWrYbFGY+xowKI7/rgWjP/WKsHC0CFDZ5SMQGo9beS9RG7bD0QSFTAjvi3g+cp90iisILrmibujODVSCIUhnoJ5k1s3LeAVvCjxhiqpEj6hb67T1juMEyW2DQC8htD29C7N4ii3XjDc3ZcumNGKMY+XlFluxAGTTFj5zzc44WxzeZzRU6HmrVXK+N9thACh86juRmUQL1IyHG006lJZQUijzhn1O/hEWZQEG+r7f6GIfQxHp+3uBUi0rNu7BwK9VLEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmeSW/zO8BVMJZcO+IuH9pOtMzJchYajDu8YD/VIhPE=;
 b=vWASxXJ+L86+fqXIt+JhrKQAEcEWFCfeiyYW/T8fQTAPb0Dn9RHxo3xz71chlBj2VPNa8+92h5s4HIH+F/wE/y3sDdhLXDI3uvz73ZbxxhILItrZqxQCbVVOh7nKsAyQXryijChCKlbPvbqXvpDKQyZmTWJ7Ulo1kGfwrhk2tqk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:13:45 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:13:45 +0000
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
Subject: [PATCH RFC v2 04/12] integrity: add add_to_mok_keyring
Date:   Mon, 26 Jul 2021 13:13:11 -0400
Message-Id: <20210726171319.3133879-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:13:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c38deaf-2c57-4cf7-58cb-08d95058b989
X-MS-TrafficTypeDiagnostic: CH0PR10MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB52119B0CFA44624BAE22D6C387E89@CH0PR10MB5211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRnbBJt64VTL9iNJdiw8BADy5TdvDK/fKbJ59Oh5JYmO/goOGURmo5Q5CTN/TZD9Phz7iz2uzSoPx78S457vGYCzJwV0c0/L4mIUpmWzUPa70NL/szNbmAarQbz+CSYjeiWAjgWbBvpLdTqXrIG+IfJ2ipCzMG3fmZApAFBSYVLWymEe+7Tk6aqQwfsnthnyiKRfazzFoul/0r/Mux+MbrkAXsw3msn0RA0MVS2vyOZmik5rld8ATthC4Eqsb11OXkYTiZFxkzswBpIn3/sChauS3xgDYEcx3cuL6zadK5+FLffy1kArERbapp/IKwk0y4X60iJP51chnaDOuhcyiLtUZXpgPiZwBqlVRuULm69xuV1Pf+dpp27cjq97EbALt4AYoZvMd+MdpfzNz0Vo2zFOpwFusqDcaGizCM9Fw9hiGnM19BMkqsaKnIUdppQIK4+xC7Bt8lzfZXu/9yCV+PXtFxzmfxQ0mpkR8+l8fYu6je10INCLBnd8aIU6DS61gTqJw8jO6LdfXxwBhRhGk01jah/bixY7txqvFTgGYdAl4aaWVR5HKo0qfl3KV/yHAwPBnjsE/l0o1eBUiqcDaCNrRoWQX4KOiXXFXjFzl/72vbm7tFYsiWjWGRkYUkzZ26HZwP6bSBeofMsqzpqYRH4Cfrk26XPAlmNt7TKljs6O3Mj4U0npIV6abB/zUmfzzIfcD04773bF+DjDokTGyTKUfM3epEfkYXl0OjaHOr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(1076003)(2616005)(7416002)(52116002)(7696005)(44832011)(478600001)(36756003)(66946007)(38100700002)(38350700002)(186003)(921005)(956004)(8936002)(2906002)(26005)(86362001)(8676002)(5660300002)(6666004)(4326008)(66556008)(66476007)(6486002)(83380400001)(316002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Kg42MzF2DRRTyq4YNfEsucHaBZgyxjD9R0WSoLbwMvSenkDA4I4oOLarx98?=
 =?us-ascii?Q?ipZMjuYgJM5tzie3d6KNBkhM82aU2QzxeBUcklvFSgBhJU+yuaCv0FNoSwUF?=
 =?us-ascii?Q?YOGVuf2EM5oWdQCZcqf5kJpPR5TKEwbovmfa70SF6uwxFlrAHkvClXiMojXd?=
 =?us-ascii?Q?QxJkxKIeomCCMUTWsKE7cgXhJFlm/zBvPVbtHRR37PcS/KfSoq4Iqz5jeBO6?=
 =?us-ascii?Q?rqigoY/rphG2NVuWR6EdFqHlkpf4DV6XwrwjJ51xGKyUisfhcJQA9GL5+9Ch?=
 =?us-ascii?Q?gt8Pcs66Ro6Ixp94d7E24E5tw16gwnVRN7fWS6d7cLznT/PQndHVuQrJBLXI?=
 =?us-ascii?Q?z622olIRA/Iix2zLqIgb+X6KlkymyKtTxMMgWTwRFl252fXNPtRBgkjjFzpf?=
 =?us-ascii?Q?XVuGfe1jKewP8A1Lt77FDQE5SnERqi69Zc2U6w6VjQq2cpEk+D4tSimmiVhf?=
 =?us-ascii?Q?Znkh7Bf1Fw4Vzn25dYxmUMkYNuW+CZV0xTQw/hY6Vk6wtemWy7Asq9aIFIW9?=
 =?us-ascii?Q?zg37o4rV0RDKjHftlKRRauF3ZPAWIh8iOKtPCl8D0/anKpAksZrH16yLsqFb?=
 =?us-ascii?Q?8KQDARN9HNLV+SjUk+DZxQUJBaIQkL2mDhr1T6gw2psoQbK21yzvdUmSD8iY?=
 =?us-ascii?Q?XCouhTpHnPZkJlHHNV3lMoHKhWmwYwy/7FxZxHNmuTGJlcfyKBYP/RZ5ykuS?=
 =?us-ascii?Q?loROjzk3c4FUhzDAscLSu36lqjCP5Szwrltp8+dWy+daEmyX31phrFgqrJa9?=
 =?us-ascii?Q?DaCavL0u0HmLyQFmRRBqQnweNtsmSS8e9l5tQ1eQ9CgofPWQXklHEsafKxM6?=
 =?us-ascii?Q?X8KoPlnpaOweFQGaRSbz6PMuOiu2WLKoHJzT1KaeO+U5b0xQCFVsSX5ucAbc?=
 =?us-ascii?Q?i4f+UKAKmaRwh/RskdrEBoB1nmgJsM8d/0DwTDWxxhEjJ6bHDS58+z21L2qQ?=
 =?us-ascii?Q?dB1f+FHLaB66LdsNYNJY0cHHpjuCpPQ+Zl4CjO2da8n/V1NqesXYYnUOC/PY?=
 =?us-ascii?Q?3LVAFXjKttK9FVGsPuwT2Dihp01OIa0kYKiiLLyg2S7Emyhdjy6zfsEHaDJx?=
 =?us-ascii?Q?xuwKaMjAi+uiVk5sTYgn4w9arFlNW9rURbYwcXtF8PM2Erpgf6CPslgdO/4o?=
 =?us-ascii?Q?bQHkVRbHSsPDsB3fM6H5LQcMsz6LumSa6pB8pwYjqZVo0KE4K4coc9WBSLZ0?=
 =?us-ascii?Q?1X+D8rgBTpCLhMAw8hcDVzp95pIspN0s+iC7twfhPLu+AYqI5x78pkat7Qjv?=
 =?us-ascii?Q?6BbBGMovN2mb+qNnSwMaeDPr3dM2YkSwBTocdid1CPjG3QKcjykx9MshRp26?=
 =?us-ascii?Q?AA1GxxK2l+FKsDhIyIeSilpe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c38deaf-2c57-4cf7-58cb-08d95058b989
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:13:45.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtB4BcEMQs+Z5m00Orxcy9dE/CPcxMN6oofa/BeGZJ07228+lyYGVvccahP5icepmLI9qh+rr6QGiadEISfudk2KrQ6+rYSrlHVnCwY6Yi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: 1VI6GjBJFVArkXw1I3EJFJfaGlllDyLE
X-Proofpoint-ORIG-GUID: 1VI6GjBJFVArkXw1I3EJFJfaGlllDyLE
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add the ability to load Machine Owner Key (MOK) keys to the mok keyring.
If the permissions do not allow the key to be added to the mok keyring
this is not an error, add it to the platform keyring instead.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Unmodified from v1
---
 security/integrity/integrity.h                |  4 ++++
 .../integrity/platform_certs/mok_keyring.c    | 21 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index e0e17ccba2e6..60d5c7ba05b2 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -278,9 +278,13 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 void __init add_to_platform_keyring(const char *source, const void *data,
 				    size_t len);
+void __init add_to_mok_keyring(const char *source, const void *data, size_t len);
 #else
 static inline void __init add_to_platform_keyring(const char *source,
 						  const void *data, size_t len)
 {
 }
+void __init add_to_mok_keyring(const char *source, const void *data, size_t len)
+{
+}
 #endif
diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
index fe4f2d336260..f260edac0863 100644
--- a/security/integrity/platform_certs/mok_keyring.c
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -21,6 +21,27 @@ static __init int mok_keyring_init(void)
 }
 device_initcall(mok_keyring_init);
 
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

