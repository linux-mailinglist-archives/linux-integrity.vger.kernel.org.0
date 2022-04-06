Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E374F6563
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 18:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiDFQ3u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 12:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbiDFQ3a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 12:29:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144D5435BDE;
        Tue,  5 Apr 2022 18:54:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235KWY9E012570;
        Wed, 6 Apr 2022 01:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=mqQ2mac3lIqsdluCix4jvAfSWforxK0/etC71ODPy+4=;
 b=FinYnLWuePg4Y7aelsaPNXxGMZfdLGsAL5Q8m1PXHDCemYNPV+ICSFJ2tR1p8YgP/Lay
 DfUVF5ohcvZSWd5uQoccdtJE/CB90gGKUpcv7gx7XDK2+C6GEvHphjEr9tNjKVCNw3ZQ
 JjI3zIg3cdZOeT3BWJPxs6+L66azgpxAz1v/h0vQFcpFUcs6u4ejJT2/jYusQ0PG5BAF
 y73nLJgCYgHAtHPVlb0wUB4rb0q3oDZ766Y58oiOZqbnv9iwSkD8iEiM9Ixlyo28LK51
 54VYcul6qFN1oUY4myBRRD53m+0cz0Svc0nb2wjdddjUe8/MqLkBTwicpHsqqKjgpbia Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcfdm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:54:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2361orv0036988;
        Wed, 6 Apr 2022 01:54:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx43ey3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:54:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXybUJUbnIJfzrl3guiDNpkmm9SzPVswcjuDdba7aeqWQPJxUkJV/K5shmidyNYMk/DgKHL600z0Uas8HUjmaeo2cS8TjY6FPvy74CP52Ij/Z8iA9IzsPzxNMvYniafWzpSmPa5ocWqUc6lMB5kpJpSpUz99gLPacjDVGsVEikXZ40d/1AjrSPxw8ETt74WElEIK104Fm2GAp9Kfkfj1e0Ye3H8GmRqEl3we6Gvi1EnCTvrO2eN6AN+QPH3LcZxVzqxPi6sxfMjlGXtIceoXBzgLMPmrfJ5SQMZllhKQ6wjrjHV2zJMG9SHXQEheSYqqUnOLvOq1raK97ZHic8mwaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqQ2mac3lIqsdluCix4jvAfSWforxK0/etC71ODPy+4=;
 b=huQq3HnNir5VT4JsSIhovqqiwmB/Urbs3ptxc8qBgqMa03WC72c9sn755C/BsBqUGdfzNuHh/i45IemiKIdd6aWUjx4/m4Q5nDqxcCJR+Ds0+yfSLpJTsLovIQY7sbSI5REMGaWAN2lWoeekmsDyhvH+aYZoN+F16Iqgl4z0BWPn3mEz8E72vefZB0hDYIP4b5s55VwIMmBncHWQ/f+nn5P7EttcpEHSNJ3zrOghEYL8/vKZewTzVLuSkVzsgFN917aTfjLoXSpiWu3Pn9DVFxLo9hdeiz94zxhqc4b10Kq9kANLx+ngA887/LUfVrMxOsZpoWAA0OOsSa8/mxJo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqQ2mac3lIqsdluCix4jvAfSWforxK0/etC71ODPy+4=;
 b=epHi1l+IfGZ5rLzt+EoDOAKEtAodYr8G9EXPIIVhHkNvrLSWPvQWA0L3jlT23JGZZO5zT+ftu6yQZYogFKPyvwyaVF88TmpqNBp2atB0mBsX+oXJ/jLPQejms/CPzT2BN/ZP60S4xI8niZrTW+ll/MRrqZxcQc4JlkjWxhmw460=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 01:53:59 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:53:59 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        eric.snowberg@oracle.com, pvorel@suse.cz, tiwai@suse.de,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 4/7] KEYS: Introduce a builtin root of trust key flag
Date:   Tue,  5 Apr 2022 21:53:34 -0400
Message-Id: <20220406015337.4000739-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406015337.4000739-1-eric.snowberg@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c303eb0e-cd0e-4a0e-e987-08da1770516b
X-MS-TrafficTypeDiagnostic: MN2PR10MB4349:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB43497DB368B152185503D90E87E79@MN2PR10MB4349.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/NQPDmTHrfB+MLfuJq0TMmLUSBpwR2L6T+T48QaOgUwJc6qTjkuhmYMpv9jKDUAAU2NGGDTThWA7sX6fmXunuY0Ys6BxFcZnYRKGMRVCpcSVRRpcBH9CBDJ7+/6UPFz1596B+WPS1NEVuUEF/yZMm3fz/2M5e76Majyv7K9TDAlGX9pGpIFFjkSj/sl7porvG7Kt3c/aS6P3GnfJXRldn6K3CWaarRIdWhJJRmCODXiwb+nv29cF4elSMdSKXuiBTKWPL2nTv6M1ej92RT77K9gNpxtxXdsTbr3doXJnHenICCyfy//Om+G4O2BpMR01ImeF3dkQJQq3gv5jxZB+Q0PnuIu+efbtbdaqJp4ISYCXsFPhwYcaLLykWUPKYZuA85N+9jEEpB5nBeiGfHTJ48IEMPZNyGfqrc7yobx4ULIXVHsZypf4Nd8Y1M7yW4vynP8Muy32JCexurGTPS16vhkg8hsjNlAxSvQ5rMtC9GfODmnlZ1wd1KXKF+ewxvV3rB0POrrsZ4UPlrkZXhRcnBmwVzYUTm2UoUC/Jupq1EiGnI6qCoVqOD9iSlVs4LaxAdLwOIkUFZcvqYaJuwW51UrCU7QUjx4rIBZwNSOC/jaGm7TiFnSH3YO1aEOPgfLmL8Swlus5NZQ20CDk8UeGEVZ6VF99RunnBl48NvKjPZq4g7Pu+nuU9fDyzirS0YikvLF2f+MDtp3GuA2dJpUlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8676002)(6486002)(6506007)(6512007)(6666004)(5660300002)(508600001)(316002)(4326008)(66556008)(1076003)(83380400001)(36756003)(186003)(26005)(44832011)(38350700002)(38100700002)(66946007)(2616005)(86362001)(8936002)(2906002)(7416002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M1BJJ7YmTL0rj2fPfUuR8QuxLLwTKpY29W7tCiXOKMI71JnWAkT/zEGzPYxB?=
 =?us-ascii?Q?2Qlr0g0jy75MfipKOnyS21EqoyD3wMSJFmL8jaelQUIGOj0oRLWPd0ukQaF2?=
 =?us-ascii?Q?a+tWWz/s872P5CiOakY8FXS696sf071tb/tVWYls/BovRgKdoCNOt/8gta2o?=
 =?us-ascii?Q?8yZv0JuyHw4NlnAWp4AAVSGmPPWbdIdTVu4hX78HOPhxQ5etT4S+1ShvbZHx?=
 =?us-ascii?Q?8VcSqotPqyRM6sk8jyoxx+aiQrRrNK1rpibNl+uHqCKpPyzUReti/+fFiJ3I?=
 =?us-ascii?Q?KzZsJDDpG69Nv1E7NnjkkSkjuwX/+ldgRZFnZ8+ru/fzjJWSKwcYlr7gykfU?=
 =?us-ascii?Q?0TTtzBjuPIISN6tDAtDmn1BQHJ8jrxX2GHxNcyeYKSeOIVCTW8NYRFbvshav?=
 =?us-ascii?Q?UNZq5PfNYA+9K6wYs7tOfFBbsQX73xAxutPYiVapy2xwv2TSD/QeXywt+Avn?=
 =?us-ascii?Q?IgsUZFaV8gdydqZxLbLGT1HjXOe0fvR10qMBgkN3N37f0+Bij0D1NgJxCUqv?=
 =?us-ascii?Q?4UmfnYzPTQ4sJa/lhHFXj5W71zhS+iwrIDezC/HU6c2Wuq3HTm9OV5P3A/Mu?=
 =?us-ascii?Q?KcnKbJ/ezPKBAFe6LnaCe8I65A9qYfJr/mh7El6tJRVjeQdooN/UpoG/HZ4G?=
 =?us-ascii?Q?j6WAVrRkFDDxmAVwKiFTHAtAnSCvm3kFBEHBLMouyBCf3OND/MnQAIqN9XOF?=
 =?us-ascii?Q?gBcqxDg/BUEH6BQXGHVXAr3ZCZOYRiUoAiSUj5sAutA/20sbxhRN7fTTLe0k?=
 =?us-ascii?Q?8zckpQPfuNryVZPR+2VPEn/AHWza07OA/HKL6mZicw1OyLTorpUUqEtGz5pj?=
 =?us-ascii?Q?Ht2TjKpvdFVjV8xbyqxCvppLGWUQO3KhrHB3fFnAlDkdyHsR0tLOBkRXdunz?=
 =?us-ascii?Q?VKbwzFI5QrMguPbpGblGc4Pr5HKITjqUmh1axDtFxCRRY6Zpe+Kti2UFDfXw?=
 =?us-ascii?Q?2Um/LVnpVZsRX00689tLp8ng4ES6DP+WYn3asppm6MI6po0mhTl09pqiQdyJ?=
 =?us-ascii?Q?jRtW2RfIChKJSQHevsg4J4UnibE5pSNAOAC72lUBp1mf4wNCnaxqb8sHe3ap?=
 =?us-ascii?Q?ALwMgJcatvN+j4ObLvFRRPgxZ/VfeAbxnaeTZ7DCaPaFULLSZc+qeuV3Os/G?=
 =?us-ascii?Q?kmO2SCEsGQSlwMRpH5BPVQD0Wz09paOnySFSvNgpSu4dkplV3GeSNx2PuK9J?=
 =?us-ascii?Q?6exFfKVoPwj8lvGa4/5BeMbsM0yoeE/MwJL4NGNUm5PMEQYXyjaRENQ1RP5W?=
 =?us-ascii?Q?S28Tk9CEOWOhJTEF/qqXNts/6os514TGfRYhAdWY+ulqwLNrbBj/Kkkgk1fg?=
 =?us-ascii?Q?e3lDexoSVdcavG91Ns4y/P0arD3f/laDDhsrYLoaFkXOjs/kNSAKDb+PZpOR?=
 =?us-ascii?Q?u33LGvMR3oVI3jFXMG3HMW4+Vfh8Yl0YB8Xs4eJXq+/4Cxya2+zCP/uANVoT?=
 =?us-ascii?Q?sGTxbdRAgBJV6kbltRQNfSxfLFtrNuZTyJlXL/32nNhaRopfsU835SBR5m/B?=
 =?us-ascii?Q?QlJM54VUWPMBRYa5QwoYFuM74rhMKuqV4Rs8XZupscrcEYdwZItCKALgLQpq?=
 =?us-ascii?Q?pUnlSt6H50DxA2apRCYhprDkxNEss3ghjifqc8fyFo+CrMm4R0dl/G2vVfg6?=
 =?us-ascii?Q?aAoEJ5eCucS6wbXIjHNLABUF6Cml40kVXUzp5VjMAIhd509t4XwQkvUW7brc?=
 =?us-ascii?Q?gIxZYDZZ1Vfy0Fx2pSwvQ398ngWKB74ANseSFebaZQhvd1JKJLxciZPRDSvc?=
 =?us-ascii?Q?4dDUtbrERfmRAhGfzhYhmNNXO8Q0UvM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c303eb0e-cd0e-4a0e-e987-08da1770516b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 01:53:59.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLJL38Fy2cdEwV222QAPx+XlYRhQKsM99u/Tj5AW7b5V9M6eg6bIJcCJJe4G2/F0oxX6n8kQPddosAaPBG9ogA9NdMewD0CprPfcfw2lxT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_08:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060004
X-Proofpoint-ORIG-GUID: ZZjSI025ueIaGdHmhHnx6Fdztx_d4xra
X-Proofpoint-GUID: ZZjSI025ueIaGdHmhHnx6Fdztx_d4xra
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some subsystems are interested in knowing if keys within a keyring could
be used as a foundation of a root of trust.  Introduce a new builtin root
of trust key flag.

The first type of key to use this is X.509.  When a X.509 certificate
is self signed, has the kernCertSign Key Usage set and contains the
CA bit set this new flag is set.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_public_key.c | 2 ++
 include/linux/key-type.h                 | 2 ++
 include/linux/key.h                      | 2 ++
 security/keys/key.c                      | 8 ++++++++
 4 files changed, 14 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 91a4ad50dea2..7290e765f46b 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -215,6 +215,8 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 	prep->payload.data[asym_auth] = cert->sig;
 	prep->description = desc;
 	prep->quotalen = 100;
+	if (cert->is_kcs_set && cert->self_signed && cert->is_root_ca)
+		prep->payload_flags |= KEY_ALLOC_ROT;
 
 	/* We've finished with the certificate */
 	cert->pub = NULL;
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 7d985a1dfe4a..ed0aaad3849b 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -36,6 +36,8 @@ struct key_preparsed_payload {
 	size_t		datalen;	/* Raw datalen */
 	size_t		quotalen;	/* Quota length for proposed payload */
 	time64_t	expiry;		/* Expiry time of key */
+	unsigned int	payload_flags;  /* Proposed payload flags */
+#define KEY_ALLOC_ROT	0x0001		/* Proposed Root of Trust (ROT) key */
 } __randomize_layout;
 
 typedef int (*request_key_actor_t)(struct key *auth_key, void *aux);
diff --git a/include/linux/key.h b/include/linux/key.h
index 7febc4881363..97f6a1f86a27 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -230,6 +230,7 @@ struct key {
 #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
 #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
+#define KEY_FLAG_BUILTIN_ROT	10	/* set if key is a builtin Root of Trust key */
 
 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
@@ -290,6 +291,7 @@ extern struct key *key_alloc(struct key_type *type,
 #define KEY_ALLOC_BYPASS_RESTRICTION	0x0008	/* Override the check on restricted keyrings */
 #define KEY_ALLOC_UID_KEYRING		0x0010	/* allocating a user or user session keyring */
 #define KEY_ALLOC_SET_KEEP		0x0020	/* Set the KEEP flag on the key/keyring */
+#define KEY_ALLOC_BUILT_IN_ROT		0x0040  /* Add builtin root of trust key */
 
 extern void key_revoke(struct key *key);
 extern void key_invalidate(struct key *key);
diff --git a/security/keys/key.c b/security/keys/key.c
index c45afdd1dfbb..732bb837fc51 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -305,6 +305,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 		key->flags |= 1 << KEY_FLAG_UID_KEYRING;
 	if (flags & KEY_ALLOC_SET_KEEP)
 		key->flags |= 1 << KEY_FLAG_KEEP;
+	if (flags & KEY_ALLOC_BUILT_IN_ROT)
+		key->flags |= 1 << KEY_FLAG_BUILTIN_ROT;
 
 #ifdef KEY_DEBUGGING
 	key->magic = KEY_DEBUG_MAGIC;
@@ -929,6 +931,12 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 			perm |= KEY_POS_WRITE;
 	}
 
+	/* Only allow KEY_ALLOC_BUILT_IN_ROT flag to be set by preparser contents */
+	if (prep.payload_flags & KEY_ALLOC_ROT)
+		flags |= KEY_ALLOC_BUILT_IN_ROT;
+	else
+		flags &= ~KEY_ALLOC_BUILT_IN_ROT;
+
 	/* allocate a new key */
 	key = key_alloc(index_key.type, index_key.description,
 			cred->fsuid, cred->fsgid, cred, perm, flags, NULL);
-- 
2.27.0

