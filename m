Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB573F0F37
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhHSAWx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:22:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65062 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234824AbhHSAWm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0GV4h021872;
        Thu, 19 Aug 2021 00:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4p1O2wfwy44YLrEzHdTBOqjhV/cFUxgl83N6w8GqY+0=;
 b=wkkBz03ciFx09zKO6tUHF+PWCGQ9Gaj+Vbm9uaKdeFeD4NZTBrep7g7XvyPl4am2YXAG
 eSupa0WPK/AFAf9vkuXYEPD28rUVDfEs6qdxQrjYf8PJS3lXIXHGiPzm61vGoeJ+OKLJ
 Qkug4iy38UMKwn1TFBXMgP2TQnZPjKUXijECIwNrCaYC8EZGeImGnEZz4nFquD25r+TP
 9/W6KPO07SH8GjAMldmdojvO3ATKdxX3UNjEYk9ArrDCvJHAiVNK8bKWRXRxApz2TNbi
 lS5UH940WZSpNE2z8gfUtqKwGJTdrEjOtIszxTvbpOZHwgt1NnAh3kc/PAqGBLZUgNdT qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=4p1O2wfwy44YLrEzHdTBOqjhV/cFUxgl83N6w8GqY+0=;
 b=f/+lFzAQRu4wFqNS5fX5lhXs5brerTAnPWjUDQWEPnJPyeSXXila6VE096x8ChklEH0r
 gUjBOSm8pMEGaIcJZJh5pWgkrJX1NNH8oGK5JXIUWVL38iJj6He57cbG759weLqunLSI
 nKJk6hvtm5FuYl50sbaIeDUXUccvvGLs8dd3dOAPjijm+ZhY1O2GOlRx99gz3HjpYZH6
 FeyS2GkqGM+sDo3u48Ak03iKNQI63trdI3uihLTg4MaN8lbYVaG1sAvXixPm+aB4Hc0W
 s7NZb1MQI1dKBODrfzsl25vcrhFxLMPp48cCjj1YBatRq38wA/DvC3c5E9UJkqjselhG jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24jghf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0F9Zf040622;
        Thu, 19 Aug 2021 00:21:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3ae2y3947c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFtaqjXgvzDO1pGnBjovAc4btZqjQwhbFngBpeCC9K4CPiU1UznywX/cGAeBVvxAXMzgL8lYXMTdeoND3JFLQDAf6oaGCM0D9PtmYM2Z7CvKMte2/FNlDzARaV7M+duXWor6uUxsRqI4DZffN/6w4vp/BVDy6JwVhU5c1xgftMkH+IrIL2afhA4vg/J4sWxGMBzdaJyy0sxfULzc8jNROXZ7OcU/pwjeyHRCFuxECYwZHI/vh6C1FNdRCgLyJlXfhIHVlLFEbtyfCgPERpX5Z8UtjjkcUbJg5aW4MqD3cta155fGmCX1XEGLIG6wrt7303/cHS/Cpe5hCAi90uN7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p1O2wfwy44YLrEzHdTBOqjhV/cFUxgl83N6w8GqY+0=;
 b=FeWHC8wGLgL7wT7o3vbbGIb7Lve52Xjzn7lMiK9hqmC5wdUXqUtij7hkHTkEppn90xtmyiqFPcn7yRwp2l1ypnSULMqq91/5cjBUgcc02HUAiDqz2BjZfpWOe9mF0n3C8fYhZsjP23oNiLLVJven0T94cJ9M/nSy61ym84QKVaMZD+5DQj2xPVJB9FKRR9m8VLw1fJa4mYZGhyc4fgKZXxvwQpYHUSZWYv2IP5mMGxz6WSNmT6fcgrMRo61BaLg8DP1QJK3sP7gxODwHg49ytf3JHE4S4zJjGbFgGqk1l1NCXaWTW+BGADzQVtJ2BMRQ6MGjqCTvzb6/pC5t7Q5o5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p1O2wfwy44YLrEzHdTBOqjhV/cFUxgl83N6w8GqY+0=;
 b=vzTTX9IpsI4muje7jVm46T1Crw50BX3HCgVoW0m5G7p3LhIRQY1l27td8PCcMd8sZme4aeOBJKdSvogwHlIP7g207QeHVXGS/tMWDi0AY6JoCSnd7FaJqSZHlsTM585sV+Y3RO+vitqUI+7KEgUUEI6/Zm30igGNHFvaZ/rmDP4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:28 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:28 +0000
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
Subject: [PATCH v4 01/12] integrity: Introduce a Linux keyring for the Machine Owner Key (MOK)
Date:   Wed, 18 Aug 2021 20:20:58 -0400
Message-Id: <20210819002109.534600-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5f61650-4cfa-4914-bb4f-08d962a74939
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5116C94A033FA72FC21CE5C687C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wom9I2+PF6tgpjjECZ/zYAxa6z8D1SrMSNsNHkaU5D4H1P5p4xJcnYqTZwcMO3OWG8lyuNGxzduFQ7eyh92xbUJfjW31+XQLX2JH3R+z+NN4GLQOrqg7edU5DEUSHaTs6uBESjYereqbJTsRlx3CQy2fvaSFiY6oeC3VkndaYyxmAqCY9Y4VzuImmwmcKaExhx4v4PVkkpwJiK4twIYZfZPRkduVidMzEauuLn3V0i9/ZIEM91hIPBexstv/+VSB5dMShxT/fVvXJEyYgoPVw2ORLU/gGEoauxhYg7ufw9UC6vTAfcPtY4NykOwj5hBj7NxL0MvDDwqU9fBhE36WKFwwTiO9JjiJyL6kqbK1yvfpsLO7opRtgo0MatD6wDdDILQ5xiro0sdUZ/Hv3LbM/ZFGUUDEzuQejXViX4MhMGAeJJlOlIsJYHqgcliYbku9w1NMb1E4apxzW+pmMoxTxLaW7MckXrnU+DcBN/zk0E/Zr0YzyfHQb7onrCCcWPJO9poIuieLc+ROSYVHvYKVyO/37Ltto0JMNP+fj/8Wq/BFQ80kw1Uxuu4l7zKbn5BDCRfHIS0dDzNa77dEkB5vfbItSHBkUPSx8mnkAgaY4lI9VU3ThswHqO04kv2Kqm6j/o8jklwtrAN0uxx6sqR6RvAeOkxR3G/aGGEKAdJqquss0Qu9NcV4aBYUf4cBROqrDRT8thMlzHKaQ7pXVofrbFITsi6136Fc1pFeEyGYeXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(478600001)(6666004)(6486002)(66556008)(66476007)(83380400001)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CGoVKQRdyM/i8eFOvWMq6eIeX68gO0fgM4nSl3VL9bPMnlDiUitFY9AadYxA?=
 =?us-ascii?Q?Gs46r88fUfweYdPB0hAlEbhft5mCKhQGyP0mdLIll8xZYJMuPVPpxC63gIEA?=
 =?us-ascii?Q?HbIVSdUPlF2oj0/aJs1u3CS4iR6JP6Mbnq86SAKVnopLhLE2i9e2Ojbws8Ph?=
 =?us-ascii?Q?vZVUL+pdMSUya54x5fEwl520ba8LIm5m9troDOxn988iY8TctPQiGnZxIEf9?=
 =?us-ascii?Q?Y0bPDkgyi+btkLQHb2T6d6tIwf7vZLX0TGyOM9Tzlmzy8Al1ynx7oJlsZ8/T?=
 =?us-ascii?Q?xmHxWrNGaVtstqzDcBiJxA/uiu0trMa4A6HDpiIqNCOK0DOgoVvwQdxDZhgh?=
 =?us-ascii?Q?dBd6A3IucsTS+xElgiL99IJDkjKXUC1RGLv9HOLCdBol5g5AXtPDQGxILNP0?=
 =?us-ascii?Q?qA/NNYOVleWS5SORUj0uuXYy4i0JL2ZXLBJxDCoglAeCeFfzutgpO4sZxhbI?=
 =?us-ascii?Q?duZCwnupyKRajRx8aZdkNjJCeOHcfCBMIFymDsr2kWR+pXMBiJIeor8nNJgn?=
 =?us-ascii?Q?caNTK/Iz7oYPU25f4wI0elSfvRwVZEb8RLQbKWm2DVucQTwBDcOjss8LezVp?=
 =?us-ascii?Q?KxOcDOVGPMyzr/9hqLIhunlW3E3FeukMtL4GfF0r9kOLhmYHU3b34V1oCzfv?=
 =?us-ascii?Q?cy7XbGgolB9XjYy8HYXCixpszeHjbgjLTFN9lbf0H1L9AEuxlRnb+DIm8u6e?=
 =?us-ascii?Q?yjE5gxu0n34M1pka2IDb4tWchIo/Hy1ENRVP824ftrja87n73yfZrRQtdLX+?=
 =?us-ascii?Q?YonR3MUpFX1z+iLz5x+kI3AyIUllmiylEStna3n/qzCzIPQXXFcR2toFrXFu?=
 =?us-ascii?Q?ku3ERo0MPb+7UgoLH81D70Iwf75XHFnvYJ0jCs51vgN9QV5TZyX1uubfpJkR?=
 =?us-ascii?Q?lUuACKIP8RHZ0N/RHqpjfXEUWoklp3xFA51UyZ4wnUc3frBq8FMxKvEfw0W4?=
 =?us-ascii?Q?zbi/JIELZk97pHCXHsr8e+bC9A64ZsGhylC76ka77taEBLsjIVGWiXoXsBNC?=
 =?us-ascii?Q?94bQ3F6Qys4hr60mX9cwOriWX9EvcZudmRxhcG3FSeBGT74JXmL2tkJAM8O/?=
 =?us-ascii?Q?XpZKwPdU2btTXj5DxiY1ec9t7bZuIkcvSkr6IfKJvFRZFyDKtFDC3sNZB51F?=
 =?us-ascii?Q?i60IJ7mMHp7+oKqY5UNBEQnG6eIsWJGmDId558CvcFCzVlTll2GPkujztvht?=
 =?us-ascii?Q?rx/AO5FIPfXvWvhyLo7k7oMKtTmG+pel/2F4E1u4AbHnKNPCsi4w67vO+Sxw?=
 =?us-ascii?Q?ycgLcPBd/bHrwub62F7qHdB0x25y4GFMR+p6ttIrHosAuvLq35c/e0722XSu?=
 =?us-ascii?Q?Ee4rLaLYoQKbTDPMHooZ/f9C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f61650-4cfa-4914-bb4f-08d962a74939
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:27.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUmqqSXf3C2Q46Ig43i3EXDBTkC5DALD9kib3galKHxoj3Hue21fv5KuorVQwj5Nr2lLJPhdyY0HLaPk7uRb7LrMvtKB48zuje0jgjsEMXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-GUID: t801xqDeL2gCeWs4wcBjvkdBlvGestFJ
X-Proofpoint-ORIG-GUID: t801xqDeL2gCeWs4wcBjvkdBlvGestFJ
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
MOK CA keys and not the remaining keys in the platform keyring. This new
.mok keyring will be used in follow on patches.  Unlike keys in the
platform keyring, keys contained in the .mok keyring will be trusted
within the kernel if the end-user has chosen to do so.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed destory keyring code
v3: Unmodified from v2
v4: Add Kconfig, merged in "integrity: add add_to_mok_keyring" 
---
 security/integrity/Kconfig                    | 11 +++++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   |  1 +
 security/integrity/integrity.h                | 12 +++++-
 .../integrity/platform_certs/mok_keyring.c    | 42 +++++++++++++++++++
 5 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/platform_certs/mok_keyring.c

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 71f0177e8716..7a69021e2d42 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -62,6 +62,17 @@ config INTEGRITY_PLATFORM_KEYRING
          provided by the platform for verifying the kexec'ed kerned image
          and, possibly, the initramfs signature.
 
+config INTEGRITY_MOK_KEYRING
+	bool "Provide a keyring to which CA Machine Owner Keys may be added"
+	depends on SECONDARY_TRUSTED_KEYRING
+	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on SYSTEM_BLACKLIST_KEYRING
+	help
+	 If set, provide a keyring to which CA Machine Owner Keys (MOK) may
+	 be added. This keyring shall contain just CA MOK keys.  Unlike keys
+	 in the platform keyring, keys contained in the .mok keyring will be
+	 trusted within the kernel.
+
 config LOAD_UEFI_KEYS
        depends on INTEGRITY_PLATFORM_KEYRING
        depends on EFI
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 7ee39d66cf16..e3f4588a069c 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -10,6 +10,7 @@ integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
 integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
+integrity-$(CONFIG_INTEGRITY_MOK_KEYRING) += platform_certs/mok_keyring.o
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
index 547425c20e11..be56ba49dc19 100644
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
 
@@ -283,3 +284,12 @@ static inline void __init add_to_platform_keyring(const char *source,
 {
 }
 #endif
+
+#ifdef CONFIG_INTEGRITY_MOK_KEYRING
+void __init add_to_mok_keyring(const char *source, const void *data, size_t len);
+#else
+static inline void __init add_to_mok_keyring(const char *source,
+					     const void *data, size_t len)
+{
+}
+#endif
diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
new file mode 100644
index 000000000000..bcd9ac78ce3b
--- /dev/null
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -0,0 +1,42 @@
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
+
+void __init add_to_mok_keyring(const char *source, const void *data, size_t len)
+{
+	key_perm_t perm;
+	int rc;
+
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
+	rc = integrity_load_cert(INTEGRITY_KEYRING_MOK, source, data, len, perm);
+
+	/*
+	 * Some MOKList keys may not pass the mok keyring restrictions.
+	 * If the restriction check does not pass and the platform keyring
+	 * is configured, try to add it into that keyring instead.
+	 */
+	if (rc)
+		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
+					 data, len, perm);
+
+	if (rc)
+		pr_info("Error adding keys to mok keyring %s\n", source);
+}
-- 
2.18.4

