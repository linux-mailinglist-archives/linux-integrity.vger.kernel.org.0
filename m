Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB083E9C49
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhHLCUl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:20:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41526 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233555AbhHLCU2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:28 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2B9VU031678;
        Thu, 12 Aug 2021 02:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=gHciKJpVaJme2urkgbJZhf0RezJc3FCdNI0ljZFoXvE=;
 b=PpdoCwu8KxbJQHcJAxCNGu1cHBvf2nalqG4GHTBmUWJ3pQAbwlb+H5WJJAaiYKOyo1zF
 UWebN9t/v7KlIMLpOXo8bPr8piPkx9C8DchsX4DTceRxRnEIsczzSjyhxDq0fQZ7urAy
 19J/x/mwM7ZtkGC98InmQ7usZo/J7B3p/o0eEQYIz1aF9yOFmt+jOW0+CPGX/cwbbFk5
 FEFLjqjYkvTt2bSiGV5+L8ctP5mq+9U6/WYOovJoPaclnU4ubnHSGLmO2SuurZuPLrTg
 AFlDhBmMkgt/4TXg0VPev5TOJeFSu/ZLAZ8Ez7l0WUpwb0KBQCg2eHQ0yFyKBhkf6P/L gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=gHciKJpVaJme2urkgbJZhf0RezJc3FCdNI0ljZFoXvE=;
 b=TOTu7ifD7gM3CDtmG/8f4ggZQwtCx2yF9xtpmy9Fi+xmFRbTlc11cd7r7ai6gZvvJUbO
 +d5X8UcMOYa9gqLjYgpxwbhDE51fB8HDIrvCdTZMP0vkyJtUpdz1Z3iLQCtSNzP2/vR+
 lijK/ugvMP6Y0mucnLM2hdjspJRvY9rr5qbU/aEShkBOvhUS6zaCsGsz7zZciVrXQUV5
 LD9WWzNpP6WLnKlmcbP3n4aPWpkUdcTYEgXUGhfDESCmzoVNFl336JG/r2lVPj20GPbB
 /eI4q19Bmmvv72YUL2yBdxS6gNJKVNZ0WKVldCgNV7uN1f5kiZyp7taWmCarumulp6Bl Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd649v0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GG35143063;
        Thu, 12 Aug 2021 02:19:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 3abjw7j7jr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBiA0MF0TnkiD9JGRNvu/+g1F9mlySmYkhXdHBvGIzvwbxJ7ZJ9mh8c6E3HRFPtjznMl3artIam8LSRGH7//XnKfftcP+KjPnR9JLWoU0ZORTjskavC7qhaN1sZp7EINqS9nZQI011cix1Tu+Q80N5yUL9qwrH6DNTfQMPWOZCfnGoJ3kKYjn1YkLE2Ie4wylmSxS/BGkK42vxXQyUFrOye5xhefPT8+tJGqAONyKVyCp0R/5CRH08WugD6tjDX4lhRHdUlVD5koX4wCmtatku7qlY3LV90Ci01mK3dv08TCzccD0J5Io2eTHidFXyyrfRsP/Infi7SlRTHZZaH6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHciKJpVaJme2urkgbJZhf0RezJc3FCdNI0ljZFoXvE=;
 b=MELzt5y5I7qVxLghpMXg8l08FfcuC4CQZvUMjh3lK5UNiJW96upV4Z9pscXiuOJu4G77HaShb/QLYyfhz2hhrSaJZBlmudbY9MjlW8tLUrUcBTSIBBJfPhkdKFcLAx8lG4sWSP0KqlvkPZOqcntn41v5ojSPGo/oVLRPTuVP9o7/LWq0Ix782SIbC7AcA/0IN1FVM4Et/GscUK9t1l2AalodwdOKIXpZ3Eu8U9mCR49fK6VDqIkc2oBt7rJo0ZKHnPU1GcGomKnIkqWyYVDvjd6vnDZHR4zJ9r37DxUFgpKAqZKdkwLDyR6ygbejWUjh/ODQ9kH/Pyy+BerhXSI1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHciKJpVaJme2urkgbJZhf0RezJc3FCdNI0ljZFoXvE=;
 b=hP9c743F3wg74dTzV7PUGTDJs7HjQeOANSzhKkMcVpZbfbsFKzyj2Hng6ELs0JFi1Y0lXOw9o1aRkGib6nZ86sNm1U9DsDpkpYBZ4EKoU7B65wWzKcAT2ycIXVml/5P5Jz9W28N4BAmcvY/qUawABzKyKWsDVFpUtNqjIjworTI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4168.namprd10.prod.outlook.com (2603:10b6:610:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 02:19:18 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:17 +0000
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
Subject: [PATCH v3 01/14] integrity: Introduce a Linux keyring for the Machine Owner Key (MOK)
Date:   Wed, 11 Aug 2021 22:18:42 -0400
Message-Id: <20210812021855.3083178-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be75fc25-55d1-47fd-c9b9-08d95d37965c
X-MS-TrafficTypeDiagnostic: CH2PR10MB4168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB416857B8E0AD417632CC1BB387F99@CH2PR10MB4168.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBC/ctFDWgzApvb0Xcw7Jqi3vObrkB6nXvXWk5dSxEw5ttbBqqpsLEMzg1MonORHXwApXddZLMEdqy423Poe2dXCORbkLS0lHbn+BphE+/jnwrJvLDWzKLrYIcHbNO3LYsH8sG6b/X2Q5vmaQRmmCrCFCiqHKdF78VF5kwbKVwu/y+6nFAu8NMJ16T33R8FxFIRh78KVgcK1X8FPPtr8TvyKQHCRaCtFLVc5mcPWd4tNq/6V9KNrW65IFhv+GSObZkzMqia/DDzcxZveNvukrInQF0lE8jamXH4JxZZ7bqX7ts7QI+zpZGonheDdKAaFcLDwWujhHMgkDgHqsTWTJQgvNNa12zTMQoU4eXUKbFYNwUgU1/1cqrQX666TrZk7DLZxgViCHKnvePPJn/F1//CKbk3NEn2RWAZFLP1y6Ho+vdrgpZ6jrlxPGg/2HaSyGSM26DZj6OIretxZeJPhq/uwmYgeZdCcIlwhOKwUjBJ3h320CljRej0hzKdjEZD6F93neFJf2eROmJI7RaS3N8CMM7BxWcTB5un5g8vOqcv9lWqYnHXA9xqGhITf3xRBnli6JeIgXnhImJ2RCqIpC/goSPSs2SOAj7aqOA3O2/GuuvyLKrWJh54z2LJgG+qYzcT2nNE+YnbdmVSAFiy6uI8FTX8edGhzp5Oxgpg4hndDjaTzF8Tt3D/F6DaqR9j0BSVcMT4qJQyVhDnVKP3Cc0mKFyLFQk0Ld8xWp3Jozuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(4326008)(44832011)(38350700002)(38100700002)(316002)(83380400001)(66556008)(36756003)(6666004)(2906002)(66946007)(52116002)(66476007)(921005)(7696005)(8936002)(1076003)(186003)(107886003)(86362001)(26005)(2616005)(5660300002)(478600001)(8676002)(6486002)(956004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DkiiBLpyZVrmtLOcVhACDNuLq4f1sOrr65LRmOctyCP5wv+4V+2y4XbGkPkm?=
 =?us-ascii?Q?2TUDDr5t1ZIFqBu0NqWSRq4KHtj7m7AJ9KWAM+gjGArXrrQVfoRUStBSwKuS?=
 =?us-ascii?Q?j/Ykcn5znVkEBtV3swQydmIbrd1eeR+GE1gSql4LioFbkLwDcxKfKtcfG5qv?=
 =?us-ascii?Q?Tj8vxeAD+QlvsU8WSSmYWNBdOuC9PNr4g/hIv4dpA7VzLGxvOZ7q0bjDQy85?=
 =?us-ascii?Q?kVsT5oy5ZD2jkyHnAtwnLADVFZqwcKlYPTU7ldaOETluhu5e42CHCHQip+8X?=
 =?us-ascii?Q?bD/aHZ09ppibQz5N7l3TVqGJuGS1CLUTkj6X/O32U/kjqfDWcKku1+pGDIXP?=
 =?us-ascii?Q?ktaVV0PCSSyf+zhcaMy2zjMRpHJMrI0mIR/ur9PeC6xVYs01bP04TYRZNAtN?=
 =?us-ascii?Q?cDyC2DC+3etcq0Y645Ox63DsIaPWaNUmIi5SfurdlTH8UqGJMb6UYkxwEUc6?=
 =?us-ascii?Q?+A4WUPHXGFu9o2GGjZhkzCr3vyoTMBQqIyQkuif1QoBjauRzUVOe702ybyuA?=
 =?us-ascii?Q?BA1VKeGzoK4udAPY0LYIP2A3Xx+C+qymWDD3sK+ztgQGLQ00pW4a9MEtGCi5?=
 =?us-ascii?Q?KHYhuE7CZEJtRxXu/d4dFjj0zfGs3bFbDZwT8LVnZXOJglfee/oQOxKEYukH?=
 =?us-ascii?Q?dZf4QPicVecGkcYhzuhZCh1LSTiWrpAw4E3VLPy9BWfTHOVIRDjLrp2TpS65?=
 =?us-ascii?Q?jXJf1OvRJDP/LoU6cWaBuucu7RE6arWvgBxwjTIi8aApld7PyVmKrOctji2f?=
 =?us-ascii?Q?Udbh2ARDSEzFNPTTEMIkscKQ+f8CBDEv0iRVKM2bWy7tSW7pyHRU7595ME3q?=
 =?us-ascii?Q?ffMHSt7htRzNIDUERxR3jaFM6Isn21k/LeNFGUkcFZdIXnKP24443UjBQ0zt?=
 =?us-ascii?Q?ppPDpllZGX7tuM+sdEHnnejb1+E9nCeHOCW50WvGYCUxDHut7A822tWcsJGg?=
 =?us-ascii?Q?qckdm8Cv4EIod4ItGy3ZA+H3W72k49wzXBizq5h7RkQwoGyXePGNRHrdU52a?=
 =?us-ascii?Q?NXH0QAS+1XJBuFqXub717O0zgT6W20OnhU0Sd56oGXEJZURyqC/Ah5EOBQNr?=
 =?us-ascii?Q?M//NtXFCSSL2sUn79dVCEb60K0BJmLZQdh1Cwe9Ni4vGXnC16sDIbdw0u2/N?=
 =?us-ascii?Q?EBJnr/5I4XzXXyNconf+TVNJMBq/Qp3tYO6oRqXXl0y5tQbFrcGT0cycyRQd?=
 =?us-ascii?Q?ee9YmnFHaX3jApTQbGbGiX9VBEEapQOAPwNqIis0a1M6i4zV7B3WD1tcj/B6?=
 =?us-ascii?Q?mkxM6P5zUsaPz+caJfC2PXQJrcVKcBaLPJWdNiQiiGkFo9y2mRO6s6ozZgsv?=
 =?us-ascii?Q?/RT8H23sAY1SxWTlcb1rLlZS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be75fc25-55d1-47fd-c9b9-08d95d37965c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:17.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nxl0iQK21dQxmaMFYV14ycoqaJL0ZvEZCGMGdbi2QndXkeRwQ8betdAGETNg6NlTXegqE+D/k/+FL7rarUAvPMfR1EASevb0PY2U9klIkao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4168
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-GUID: _lM56C3r23qCqu2FNgnnPJuaO95MsixW
X-Proofpoint-ORIG-GUID: _lM56C3r23qCqu2FNgnnPJuaO95MsixW
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
v3: Unmodified from v2
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

