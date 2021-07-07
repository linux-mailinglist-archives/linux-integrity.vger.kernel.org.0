Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF23BE105
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhGGCr5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:47:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60666 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhGGCrx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672aK8d015829;
        Wed, 7 Jul 2021 02:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=YpggEFtvAPAAGMDIHbav61y9dIX1TvkDnvtZP9SGZYU=;
 b=O+66iPmyGHm4Z8DebrU1wwAU84G7HHoi+I53FIBDRNIo/OMxc+VanFYq/g2ot2Dh8VQg
 UDQOV5pDZzJAyGXItQetU4QNIhaXTaRBsal5uDgBJq/whAFbAqP9b0aSzla/g38DkFDP
 Bh/I2yAHETR46yemywZwMi6lIiR6rHg90oYqlwt7gQv0lEUupdWryrnxJUv1BroN4en/
 O1Za+e2iTb4Pf9gxn/VpLz9CF9C6hw2BXiENOvubLjpqEOrZi7IOD4YOk1RIlMJDHLVb
 ie6TSKp53gtN4Hv4v1y5oGnY9reifS7zQ8N7gr+LqTFU7rk4vt5CI/a2DluWNwWh+fLB SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m27hb64y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672aI1i007653;
        Wed, 7 Jul 2021 02:44:35 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by aserp3020.oracle.com with ESMTP id 39jfq9phb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqKI+Iw4fjTFcxli9qncmwaB/gTzSVLrr4W7yEbsY6z7+hmMrTRLQwUuH5bIA62bATnqwvftTbDFCEHRwjUTBZYxtGLV6/m/t9BUf/Z5uGhWyMM1VJc7jbjNjMX/NBszwhpqVSp4EzfouYcUkhlCNLrxK28RzJKmAnyX4O7/FyblkEowDT/F/n2rssDaQejZTtNuV3rKXfxDGWLje5MvImF1Lu1gwaojBCPZVryqCfDdAj+qE2UWBMrGjwOdEIkx18b81KJ0G0O6SNDRijFl2s6S7uOjAMTlCF2P+O1qGqi2h6vr4bhs9gxc1lsW8gFjYsv7u7zZ3kjFrsO+1hFNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpggEFtvAPAAGMDIHbav61y9dIX1TvkDnvtZP9SGZYU=;
 b=DmLFAJ5iV2FCMD8a5L6gyFXELzWKV+J6WoGhQ8WjHdgcBU1T8APOokciKG/mD7dzGCEE5LGwD/HDysJnDVz8fqQSFVpm1JnRGG6LMBF2ddZ0WWtxwxCkk06ar5JLZ0jCmgJ4OsRFvCd+d5F0oQSZxifKSCWN2JiBmJRhl4FOaHjGecV7eLuiJ1aweYfWQ2KUTJZLhk2Op4DFhsRlGCdPBO9FLllpnJjOI4avFiDbUYjljU/7mfxSveFeXONI8QhwHKtlfWYUTVNVc1zE/SststrLdJOk8bJ71Pm5mvbd2nWtJFIlDBMe3Mp2OWFmM5ziXJleJkHe9ru8AidJ6Rw9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpggEFtvAPAAGMDIHbav61y9dIX1TvkDnvtZP9SGZYU=;
 b=H8BwpeYQiLZoDY2q2vUtttXHVWFAzHSrVWlcSZDK7nEBBU/MAPVcGGIsFEdUNa1mdLwwe54LbdfVKP2p+HAh32gxGe/IcvY3YXN0/pRtlViKGa8ik/xiRgFDL4gU3llBJyqdWCPMPbHKtAQLs9XeyRO2vlATVZ85pXnddKAV1Uk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Wed, 7 Jul
 2021 02:44:32 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:32 +0000
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
Subject: [PATCH RFC 04/12] integrity: add integrity_destroy_keyring
Date:   Tue,  6 Jul 2021 22:43:55 -0400
Message-Id: <20210707024403.1083977-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78a6d3a6-b2fb-428d-f4d7-08d940f1265c
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB386348AE8302931ECF80B7AC871A9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOAZKg8LBH4Km7h5gfbew+ztjwZF0bgl3T6Ab2vDaEERGwuLnMj0PykhPfK6TTxy0GPcv6OYv679LMvRI+ZluLuePzDVtAoEq2KU3dYM0s5GjuUkXrAinV6LNvmguXRzpM+ILItF51fv0e6zWzOQB3vnn3LqIut6IScaGrzuHXJs5Kn9M8FfY7xWBfS+RqotRVbnA2K8RyDE0Nb2oPxGJUmwojvS2hSMiKT48W1QecNqu5t4clP0r1nY1SU8oibO6PaEEE+xvYRv+R1dVlxeMr7q3B/dRL6ztcJAK/ozBDO3xDjX52r/26joBcv6M0ArQCgEiVuBuYOzbx4ROl7DhaojDO1iy2l9W53NKOON1Vo+Yei3OI0tFtxlAlmPykOEHcD0PTbM6kBfZtHDSFOC4n0Akwoil3I9MieNMiAoJg1qbAeFrCNwrznQpaEvfnZHee/nqD1GJq8NpzSFkHJwtUEtWg20cG6ohoxHdZRYIBeRi/bBDpY9WyGFDmmdCpnU+UB6i1BvwvD98UadVpKPnUOCdKot+oDnTNgHZDgrni1Upt9yGpGrhiXqByR9uWeB8PJVq2EOXXcX74mtDWYXAemQ1qby+DCM2/5gfc9ARzT7kKAxXwz/bPE9spS5ZFt0jvmpiR/bDR9z86Vih/IDbg98xdSum2LpaNbUbp7g8yntrycph+xuMEMdJ0HJ99xhECf+UZ8HHG6TWJsU5wVuLRZmyBaZyrVnsmiEWEuvPFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(921005)(107886003)(6486002)(7696005)(316002)(66946007)(1076003)(44832011)(86362001)(38350700002)(6666004)(36756003)(83380400001)(186003)(4326008)(956004)(26005)(7416002)(8676002)(52116002)(2906002)(38100700002)(2616005)(8936002)(66476007)(5660300002)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WkLpWR9Xf5EHcDxIK4COKbuNd8XN6iTWiQnpBgbuqhWztiHgrB/dZryK/ECp?=
 =?us-ascii?Q?sXNG0YiVugG2uV45EJRFXvG1hbjm2BYpH80J5SqTYykDViNJmm0m17XTKyNk?=
 =?us-ascii?Q?34q8YT9XZCjH/OSUEQlAOtPeeFCwU86odoo6jWw4cfQcl4LkdNnWt2sAW4nl?=
 =?us-ascii?Q?i4J/nB1yg8MyWrOeGN+EQRltckAwpXxR3qfmskxxrVi5KZB7oY/sc65gQAhv?=
 =?us-ascii?Q?QYDawItubomgE2up11Ri1iKchKSa6wzzYZOUzi4G+1XzsFe4910bESsA3tAr?=
 =?us-ascii?Q?zup0Q+YADhYby6YDzsiu47CpVpUn9eo4yK7IxQlgpiLU2yX+GqtSQ4qhGrTu?=
 =?us-ascii?Q?iJ1/HCQLiK76/mr8J1Pibz8foIMxOk3gDMJFvfcLmyXvkYDmml945ns4WHuy?=
 =?us-ascii?Q?kIOFbQDmOZKUz9EolYWvoVSM+F+2BOyRoG/iI0W8btanUwVbwwSFZ/0zLQOq?=
 =?us-ascii?Q?xi0Ceh9OyFC1GBuFS2a9+lVQ92qOqKdbjPfuFjdXVWEYZP1c3zOI/nGuklFZ?=
 =?us-ascii?Q?Y8CGYcTP5ylg9Fj+1NnarhuRAIBv2R6BT/YF0jIBsXyNFRomj0UJqeqKX/vX?=
 =?us-ascii?Q?tfORiBOggpIgHuXqaaV2yE/seZIGK4TI7i9gHxbr5KyjTv2zj0TQv3VD7Rfu?=
 =?us-ascii?Q?TcVKrkEdvjC2u7Mh4AHSeRtAJFi2D7E2h1tbJEobxPbsxQ0vMajFnok3ztBJ?=
 =?us-ascii?Q?O4aVFJzpeaqxQlHR9iKoiYonJKxBEzH1kw1xnxK+/ESKF3YouXxZKjg4BWOp?=
 =?us-ascii?Q?mNoWYIPYUKh4gT3MhLih6XcL0o39wz8NzVgVCSVgGxMJtoGRAk+tgcBHoCYn?=
 =?us-ascii?Q?3MeloR0n6u4KPUQxL0n7IY05KJmvzMFcu90LJ3TeXC2zUgDppc3PFRooX8BZ?=
 =?us-ascii?Q?RDQqGa6lt90Jf+C6cLcrSou/8beO4bwBzujS0z37qJ/rHGGtfKBuA3E4VPMU?=
 =?us-ascii?Q?k1oOFOvjhkeY3WyC4uw99iAMyg/4LubW8EZQvNQBOxPbjFRCLnFz2ysOa2gv?=
 =?us-ascii?Q?F/OaTIpWcdmJn7N3JsiA2QIj4V2DtYC1ykwUAJE6GmoNRmn8ZL7VisC1MzKS?=
 =?us-ascii?Q?EwF/JfHjI8ua401ba0yu/syA59ffEYxLXO8TbZA0ZkXvHETTIrmP1HHRqhh1?=
 =?us-ascii?Q?yd2550QttCtaTOsaGp5ys7ZvgVut9NTfYlEchS4qsocQ11CEZlgZ36ZYCOie?=
 =?us-ascii?Q?K2MvE7InJjO2wCG6ifliooURxzI3NuoSshaY+6RUqAxvOwi1jXmJt1/ollwB?=
 =?us-ascii?Q?zLiatKan1O7cEhfKumBZg8+V5DesXL12ektjrZXV1oatN3Vdyi0TiNeJsOY2?=
 =?us-ascii?Q?CRencJT1flfU8ZGi7m4q+A19?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a6d3a6-b2fb-428d-f4d7-08d940f1265c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:32.6957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /s0vCg5hHsRfrVYe4JKeayTgAOuPhn5NmTNzkEcYsPBi1FvleHkvEiqTCN2/nRrExyVGHR7IpFvw8QVYway6vMyillnEDVFycS/rCV1j7xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070012
X-Proofpoint-ORIG-GUID: dO-djTem9x3AGNBNlzsjFF1J7T2sxu83
X-Proofpoint-GUID: dO-djTem9x3AGNBNlzsjFF1J7T2sxu83
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Not all kernel keyrings need to survive past boot. Add a destroy
function to remove a keyring no longer needed.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/digsig.c    | 8 ++++++++
 security/integrity/integrity.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 3b06a01bd0fd..a8436c6b93ec 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -145,6 +145,14 @@ int __init integrity_init_keyring(const unsigned int id)
 	return __integrity_init_keyring(id, perm, restriction);
 }
 
+void __init integrity_destroy_keyring(const unsigned int id)
+{
+	if (id >= INTEGRITY_KEYRING_MAX)
+		return;
+	key_put(keyring[id]);
+	keyring[id] = NULL;
+}
+
 static int __init integrity_add_key(const unsigned int id, const void *data,
 				    off_t size, key_perm_t perm)
 {
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..f801b2076f01 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -164,6 +164,7 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 int integrity_modsig_verify(unsigned int id, const struct modsig *modsig);
 
 int __init integrity_init_keyring(const unsigned int id);
+void __init integrity_destroy_keyring(const unsigned int id);
 int __init integrity_load_x509(const unsigned int id, const char *path);
 int __init integrity_load_cert(const unsigned int id, const char *source,
 			       const void *data, size_t len, key_perm_t perm);
@@ -187,6 +188,10 @@ static inline int integrity_init_keyring(const unsigned int id)
 	return 0;
 }
 
+static inline void __init integrity_destroy_keyring(const unsigned int id)
+{
+}
+
 static inline int __init integrity_load_cert(const unsigned int id,
 					     const char *source,
 					     const void *data, size_t len,
-- 
2.18.4

