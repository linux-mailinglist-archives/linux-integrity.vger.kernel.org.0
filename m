Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507FB3F0F25
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhHSAWm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:22:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20166 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234294AbhHSAWk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0HWt3029121;
        Thu, 19 Aug 2021 00:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=w7cl9eJNKH/s3LOHkz1AXRNKQo/in367rltduGHTo84=;
 b=FfApzMS5BK5B5g4+vJRs2I6BWCp4r70/KbbgdecX4nJj/GNcPGaBalazomIKpz9D1EBF
 323FmMX6AAz5RLoV8WKDSwa6270qWaOQiZTWJTJieEyUNkJtvqfG4Sv2OllHZQksADCx
 SukCDYlHovD6pF2rYG3AvlrPUiW+c60EXiKRqCXaqVOvjCW4/iE9bj6/A2nsKqgZSBQ2
 SiqPezAeOJ/i0PHDOLTQ2jFceJ+6uas3hR4/JWFgAm5Eku2q8DVEwuMoL1T3/UOMP97b
 zrOZT5T4AiUYf77Cg+bGLHPbDw2lmLLvfVQH+IvABT6cKTQE4kbQefS+AxspAvbtCR4L 9w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=w7cl9eJNKH/s3LOHkz1AXRNKQo/in367rltduGHTo84=;
 b=EIv1KCo+wsYEClJoKillMs8tfHiVpIFqvP+RHU1tDj4tpTk9Uvm+fwnehIrBmFMMPdcV
 BIoLkqojvb9/vb0ngbUchlf5Iy/KwiaPAP1utzvib8Vy24vLsKv6JGcS3+uYzZZnfgvW
 tQWvweQtflQ/FYh/NjoNpdshQILxW+yWw4dU91sRMx+ymAu60gEnwAfOhWzOZKYekx6q
 yNnjd52Sh5afOCPYnoPJxADy1cQKOui5vmuEonfzw+CNJoPkD3pYHsLCOClyvd5smBdr
 pKO0I5pwE9MKUredP6lPaamzvoaGA1O0ISZPFXGBjLr1gjF+HGhD3DsYHlr1pCpoOVd4 Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmhwn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0Ep4Q160248;
        Thu, 19 Aug 2021 00:21:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3020.oracle.com with ESMTP id 3ae5naf91u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5PtkVf7DPUGzd3Rxg1yORDvHQuBENW5660wPjVo63FESbbpZ6m0LADNjJNdkefMy9n6OoQiQluhMfVcTcrdmIVxfw/6AgOunbBDRwSd6CnKQEbXhzCgkiH1OnmcSUyeiF6cXVHToSxuj7kN7cg8WFECt9nFWRvx4an11B3X3AMmfBP7DsutqtofJSYkpNj3sByZMfDAXE39TOissKrSmpsW4ZbhxljgRJgfKwFL3mjIwE78uwIz5ruVjcEBres0N9SomNAvuISFp1ustc2BRdkZqpB03JlsMHbFWakiKcjze6uEn6nfWOmDZQIlLFQg+ln62epa4OZ+ERZ8+INLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7cl9eJNKH/s3LOHkz1AXRNKQo/in367rltduGHTo84=;
 b=NZX+zXJhe5KCiLBv2h/p/1BPwoQ8sYV+fBqbpYyMGpOG5+g235zm+UN34mzL7SbbVSkmDEfEkiAN2Dt7nGaW4T6iV65JVi20+CUIFoiZC+Krk+sZwOEwCKwhRApU4kL7zQSrItaWdyu0eqYtNGkjH57CyA6naPeak/YkqXy1T0LKH8dpkZYCCqWD5N7OnLKSVVRqPZ1EFtC/tyeXK5umcCCM79HxsTWizb+NMciEQL3y1TkaWRYVGNPTQHB0ysf9Y0DNo+NqjJGa0aeXB7/g/9q7Q0O8rQkU3CeKG6KCmx5Cl1ZKAUtjIqXkI4TT6ry8B9wQemt6g5Rr/N2J/aQJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7cl9eJNKH/s3LOHkz1AXRNKQo/in367rltduGHTo84=;
 b=RkMBxefU73IwsVbcmDK9zphL7MWdMVgK9QgBx7ToezyBBi2k9H2y7wIlxuDDRu8wPue4RkCckdKryQ2xN7gpwA4dYsc3FlM7+4IyvLWNDs3Q/Fs+9IrBOqzIbcklpQ4gb+CqvMgdzEhX7GeQUt3u/kLdTpPCKbVLVzNMSbMUssw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:33 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:33 +0000
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
Subject: [PATCH v4 03/12] KEYS: CA link restriction
Date:   Wed, 18 Aug 2021 20:21:00 -0400
Message-Id: <20210819002109.534600-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eff55540-42d5-43b5-dea1-08d962a74c7a
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB51169EFDE79873D0DD0BDF8B87C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fyJeiGRHMSe/t26gYEk8Z2OFZ2pIi4wD4Jyf1LyEtez01PVPrwnz6Q2eIrUTcCOcoPWgo10b4aVpMzEs9DK2+UdRklSjCVE5p2itAo9DKCoqt3wROUPEmQGPrZm0m1aa7jItG+NBTlNxhcGAzgJkavtyEERtz0Binm9cVOj15qyHycddbKof/zw2kaWekztmEiR6ydBOwjKDNLioW71SB9lHwEW7UlVxWWpo+G+Q75ts3Gsix0AXdF2sy8UGt9IQSCjpU0fNzLjxRi1EeI9oDGsLfBAkxweQo1U4oSoHAY7UnUSgJzJ5vWuY3RYwQ/U5QJk5eCqKf6CsZ0XqOA3NNvMpT3h6IPKYjd8/CaUim0k269lw/QChzMXjzhHSTrPKJJ1o/vDuuB4Km6xFk0GJcEwZ/ZHsoX6O6yFNVwpBSBhvSMfI+wTbvjdhaxzO/ARDqWF2RgNvqTveNxCHW1aNYfDCiNc5otdgMA79YFxKm3OPwr1iY07QPLlzE1vcanS4Gn9Pz/TWg0qsUEq5atvDmdmj0qb/3uG3Ndv6JA6Ntoedv0N24ED8VObMkQgKexggS3FIfrlD5IPU6com8mgogeeJpY51y2vtogwvWF/4BN5iqdueQOvj5/Ur94UnSDR2GmCv+njifbs1h+pfQUiNOCNqqV1DU9W1TibQRHMQ4Htzbhm/2hVC5We16gGzE7WX61WrI8qHUAAFp8gnU/F74TjrjgNzdtayOnoQB4Po1zI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(478600001)(6666004)(6486002)(66556008)(66476007)(83380400001)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sDiKRRm6Nq9Ogk3fPM2g9bkxqJkX5r/k290dMfoZ4O2e6NE4fA5466VwDkod?=
 =?us-ascii?Q?ibhQf4y0Cxt1zalQXrwF7kXPHGiwO7abxHzY+qxZ8Sw323GGZXxdPSJvZyG4?=
 =?us-ascii?Q?wF+IXadd2loJdeeZpEqN/axKsGF027JtDSmZ5jGsE0+x7zZ4xQ8AI4hF0jsw?=
 =?us-ascii?Q?J9TcBZELaueJvbzYoy/M+B8S1yd6mOfLPvYYF1Jh+VGWn3fBE88kndNaDO4G?=
 =?us-ascii?Q?rvvctJydzcUFITgI1xRGPM80w93jjDMfp7GhaR8qJBn+LDXMg3r8qwMKhJwq?=
 =?us-ascii?Q?Rxxy0ZWd/IJwq7g9q/1J5k0n+YBO99n+OhbZ8SaAiWYXRIn7t6KHGB6Iz/E+?=
 =?us-ascii?Q?QEwS3DdQ2c3OfFTQKtbn5Gatqfm6FRD91Fa3Qm++8EN5VEjnQyd927RNmW6y?=
 =?us-ascii?Q?sGjXRMaBl5KeO5IhdhyQ+YsrQ4Z4AD+j6baluiAKuRQksI2Avvshn8By0O07?=
 =?us-ascii?Q?6B3wATe2al8F3qMO/I9fdE0fcAryuX1FmNiemKML1M+12aPp7BevdNbH48QO?=
 =?us-ascii?Q?IjG9tVcWmpQA0VDWu+kgFFYJE2wxx9ioZMgn5jd/BjzFEUi1x+byzX74qy6z?=
 =?us-ascii?Q?AXOUA+4rsE4D0hxqXUAskZCCdB5Tl735VoqirSvISCJjq4/KGh0230JP2bRQ?=
 =?us-ascii?Q?+TBdNFvvTO1Zv07mtC8nicrZv7HiY5jN1alBuHumArOx3F8UG5GmJupfnKX6?=
 =?us-ascii?Q?LTLdikpiKGnDh4iynhwFLIvmZRNVZNbthSdax4t+YGDt+CdNSbwmm8B+xjH5?=
 =?us-ascii?Q?c8Gb3yak3XjCHo6t9KAk7xiJSq2fYY8U60O01POJusxms50MsRD491zJq4pO?=
 =?us-ascii?Q?RWMk0WvSPCGxQOlQ9iKru9NP8P23dO/UImURsrkyca5rqcSbrH/qH1jefgD3?=
 =?us-ascii?Q?SKhtiK8iqOh0QPY7yFW274r/LMnpl644+MQM7W6DoX8rvwRcgCQv8h5TIYE2?=
 =?us-ascii?Q?LNOOypHdOiPo0qSMjTNXroupXWXVp68kJL/q4VIQrv/jBFbChkXGWLyRr9ZZ?=
 =?us-ascii?Q?LfSfgcJuFYPuwKa1XUwl5Axt+2lDXbWrkS9gBCOXx6v6rf2/TiQHCe8jfU0l?=
 =?us-ascii?Q?kFXvfiaRDJI/bGtLjXvK7Hu/ptWCOsMKYDzJTeWq5raYj51pnMQV9q+gLNyE?=
 =?us-ascii?Q?C8tce5cI9ng8Svi4F8X8Ao1v1HjWWZqkMM1ihobjZiMo6JHfaypI83QhojiV?=
 =?us-ascii?Q?Eu7D1o/r2XQI6mCtB3ayNjgYf4HR5+RHdhYCXbjGm1rbvO9iUw3GZHa5ke5L?=
 =?us-ascii?Q?/OqRgEn6KYUB9RUNyN/p/UR69O0zXjy8M76Ux2u4XlVwHIe8cybG95qVZjbU?=
 =?us-ascii?Q?g8pqGqQ9g+i730a86ZOmk2DX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff55540-42d5-43b5-dea1-08d962a74c7a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:33.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ez+Ee/rX7gn/TsP9i3kcjLXrNqT9HlHrpXdxFegIlGrC8sNx4FBQH0GRPhFlOnaD7QdiEOJnmsAYdgwa5QH60pAJc+P8nvDrfA77Iij7kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-ORIG-GUID: 8vGGVCdXrCPSKl19UNtRmkXPAAaBDCf_
X-Proofpoint-GUID: 8vGGVCdXrCPSKl19UNtRmkXPAAaBDCf_
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a new link restriction.  Restrict the addition of keys in a keyring
based on the key to be added being a CA (self-signed).

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed secondary keyring references
v3: Removed restrict_link_by_system_trusted_or_ca
    Simplify restrict_link_by_ca - only see if the key is a CA
    Did not add __init in front of restrict_link_by_ca in case
      restriction could be resued in the future
v4: Unmodified from v3
---
 crypto/asymmetric_keys/restrict.c | 40 +++++++++++++++++++++++++++++++
 include/crypto/public_key.h       |  5 ++++
 2 files changed, 45 insertions(+)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 84cefe3b3585..9ae43d3f862b 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,46 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	return ret;
 }
 
+/**
+ * restrict_link_by_ca - Restrict additions to a ring of CA keys
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @trusted: Unused.
+ *
+ * Check if the new certificate is a CA. If it is a CA, then mark the new
+ * certificate as being ok to link.
+ *
+ * Returns 0 if the new certificate was accepted, -ENOKEY if we could not find
+ * a matching parent certificate in the trusted list.  -ENOPKG if the signature
+ * uses unsupported crypto, or some other error if there is a matching
+ * certificate  but the signature check cannot be performed.
+ */
+int restrict_link_by_ca(struct key *dest_keyring,
+			const struct key_type *type,
+			const union key_payload *payload,
+			struct key *trust_keyring)
+{
+	const struct public_key_signature *sig;
+	const struct public_key *pkey;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
+
+	if (!sig->auth_ids[0] && !sig->auth_ids[1])
+		return -ENOKEY;
+
+	pkey = payload->data[asym_crypto];
+	if (!pkey)
+		return -ENOPKG;
+
+	return public_key_verify_signature(pkey, sig);
+}
+
 static bool match_either_id(const struct asymmetric_key_ids *pair,
 			    const struct asymmetric_key_id *single)
 {
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 47accec68cb0..545af1ea57de 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -71,6 +71,11 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
 						 const union key_payload *payload,
 						 struct key *trusted);
 
+extern int restrict_link_by_ca(struct key *dest_keyring,
+			       const struct key_type *type,
+			       const union key_payload *payload,
+			       struct key *trust_keyring);
+
 extern int query_asymmetric_key(const struct kernel_pkey_params *,
 				struct kernel_pkey_query *);
 
-- 
2.18.4

