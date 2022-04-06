Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CD44F5D27
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiDFMEK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiDFMCu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 08:02:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2372435BC0;
        Tue,  5 Apr 2022 18:54:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235KPK5t012575;
        Wed, 6 Apr 2022 01:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=SxX0UPruCNSzfcVtv4TDsStS5bBn7z7zG7P2demI2Cs=;
 b=ZtDONmn8lV2OaRalTm2Vr0hP2VGTfKmWM5fqIxwRuorUQPodKkSYdB98Z8VegQSoaQ7x
 tVBCDv5/LPrKgiq3vCiBcYQ0sDSWl/MCUwQ/as17uM52ZydHSZR9WcuYV5szkkIr+GDL
 j3rdC5CdSdfmzLl9Ss4VS0ANkTSTJPT7eT/FuC+MJiCadIEFr3UgcTocMe8ky0rpoEcq
 p+hghglLplHZWq6Pp0awqal8kKRWsPz4D8guc9r0mnP8hPHnY+9evAbEbR+M5slo71ZZ
 juJo6LEMaRLV7GvJaq+k7yIO/Uc9eKu3T6H2pqEpXp/GenTBzgi63LzgRCb1+1GthPlY nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcfdkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:53:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2361ogWE018012;
        Wed, 6 Apr 2022 01:53:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx43rv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:53:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+Fj5vdqHCIyuH0cIaN0FL/P/roLIpSGSNdjK+6+ydDwUuyjHXRKS2RxC8OLe7wrtJq4HyC1wp+GhTuIjDVZ+0suwog4WUP7MrJE8QtESe+yrSOtdC5ow3gYROIgk7VgDiyZnBqvhCzDQecgRcm3np9NigjDgpKl4il5IFFm2D5ZEHNJOc6sGOUamauVLhtkQLNvGC8jqDLAjARb3BPmm5Aw5/M5tsLWOOdVGYZ9cyiE3D3csp8SUHEmaIWaTET0ztPp0yEZ5idMnVSai09uORe4go3ZBm/7+DcSkfh9rQqa/v7hG4vC6vwprp2DVcGfEr4aEtlXiyzxFH/spLU6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxX0UPruCNSzfcVtv4TDsStS5bBn7z7zG7P2demI2Cs=;
 b=hG/QxbM2sU19MKZE7RAkW7WyePi9T33EmFBlaSYAZ9KTxx/CIH6gzVeBEIFBW/na3hPyjD8gZf78uh+6+4u8iTpGyq9DTmq5VpJVf+JtmOYGQVaADPHTzZJPaBWg47eh43Vys8DKZfY98Gxtc98u/B613+IoShxV2eZC/tzhffAnoRumzkQhmr0IcvSmiq2+aWvGA/t0UQSeXP6dMZBkuoPIa6os/+f6xHWoBs43yHwQNtCtPVZo+CR3w5FkvG0c7MdaQVI9fcKaqiskYtQbN/uJ63woPXLlxkQW6SWw+siDIBw5l/98O7maRKXipBx5ucb6eirjYRvavj1bWl/4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxX0UPruCNSzfcVtv4TDsStS5bBn7z7zG7P2demI2Cs=;
 b=I2xPXXQzgBJ5hBGgqD6z1F+GSMHBC6SeSjP8BfwfliBdbLzH2FvVVZG5p3b7iqUtJnYj+mznLiDN/opQ8aJ5hhW6bjjFQSYyAWg1PZi/3g9fNBXGRNQtsY0HPzCGfaa6aRDJp4rG7jMVI6jik5I1tith3vU68osa+8LtMPBJ2IU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 01:53:49 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:53:49 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        eric.snowberg@oracle.com, pvorel@suse.cz, tiwai@suse.de,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 0/7] Add CA enforcement keyring restrictions
Date:   Tue,  5 Apr 2022 21:53:30 -0400
Message-Id: <20220406015337.4000739-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f2469ee-2e8b-499f-91d4-08da17704b2e
X-MS-TrafficTypeDiagnostic: MN2PR10MB4349:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB43498A121753412CD5439A8887E79@MN2PR10MB4349.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKtMmfS4eifG0j4g01hHfBm4WsOvizNkuqBOBM8bPmdE1SvkWOpuy5qEtIiwYAF+kxNB8AM0PnxN9Wxp4kOyN3e4FJadOaQ04NH0jSsj1TiH3nC/8+Mp+jzIWiX6L2+dDG7D4wUANUotqcFahSbmLmiS4UbWIh3UcChVd3iI6W3RIOEE9Hv2zKx1SEueELnr9Mna8Yge1QOXHB/vxxrKIA29rZdixvDIua66TNIxUIwkvQTV9ryt+V1tbSWuB2BhQZLghBsfVwM9z6dJDK40cVaCu7n6aZRceIbzOJUzoZ2JBLV0TEs2ebMZ8NmE9xlpADAD+rtwQS5B2+IqegKJ2luRyBeZ+z9kbiB6accK/KwFibUUkenWPetXQGvh1cg0iLRbsXN1OibEty6wDXY0Zyyr60Njj8I87G8j5V671ofxmI4z6l2o+5X/HMCGOo/vUfY2DScCFVYHizbWDSPg+m+2KCyO2aWnG76V963o8f0M5wNsjl1uKIz8h4ohlwLq7FFhrNMWfxg5AbDuJX233mfLzMpCI7lhq08+CDcSfrnPiDEjjbrF+IpQ82BvtPf2EGysmbMSs5owXAIr1zafweu4F6fMzn1J/d37oDxKUDNmoUSEesrareshQqSW8ut8TuGrVfgKxldrSpIQRin0iMg+t3YMJhqpbXJIJPQSRnCg0HbII+tP3d7MLq9X/5MK3QCOjYBFPpKFbRyUykYVuoE2ktg8WI0hXQ8p2ogEl/uwqPbBfOmq7YFxXJUUhid4YpXA7ReKwRaMY/13ikOB1I2etbHPn7THIqwJCxajTCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8676002)(6486002)(6506007)(6512007)(6666004)(966005)(5660300002)(508600001)(316002)(4326008)(66556008)(1076003)(83380400001)(36756003)(186003)(26005)(44832011)(38350700002)(38100700002)(66946007)(2616005)(86362001)(8936002)(2906002)(7416002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fMf1ajpRaa02eA3/ONvYfPdhva2mLjJpnvYo3QPknWf+iJs8UaU3J+T0A6PG?=
 =?us-ascii?Q?FElyEdyZALFqeGkm9JJuloRpz4ZddRtFYtSk2yeyQ1rq2CTVgy2+EpXSJlIv?=
 =?us-ascii?Q?d+19s3KeTH5c0dDPUjOE4oXvqiHhjN/iYU8G30iiWXy8NKPUmYsGAwc2eGDh?=
 =?us-ascii?Q?u9+iY9g8taoR/ZqH50TpI/n4CzJqtH3SR+O5bxM+TZkuzjWLZsYDeFANPU2M?=
 =?us-ascii?Q?WKtcXkfnBqUraHQFpqf/b5Eo6ToswRVfbbUXHoCM88Ox5KCA2RuqnsLt0Y2C?=
 =?us-ascii?Q?jdTPGfyyuG2YWforlhe8745+jY0iUz4RpLKZnEFCkiiTW0JjEzJdShca1Qhv?=
 =?us-ascii?Q?8LeiAuHLYEZHasrU63lwrdFRWaWSWKTmnnV+4I1XX1OfcgnroqXlPDP4xXER?=
 =?us-ascii?Q?vFey3rI1zoSdpu2prAN+y/i5AyElc1MmVGevh8ahw1EfwVJ6W2HUarFO8Ve6?=
 =?us-ascii?Q?rUEKp7nTHU4eESSckjyeI3lgJmz7b3wcIQh+8EWeReAwUp5m++0WK2SYmjBC?=
 =?us-ascii?Q?ET1XYguddKLZmsEm5zt/4QKGBI/pGwfASqHCX+bCjpdyPKq5YRCgc0TemKFn?=
 =?us-ascii?Q?J0zvxxROciVjWFjuhGxcCRCEpuiaNB3pUtMkMGxsJAl6ZYPqfSczq4YL6wkv?=
 =?us-ascii?Q?wHtwfpyVZwpCFxDQQ1tSibdzsAXZixHY8W2pAlfQDfi+tzJ0i0UtL9wxmmF2?=
 =?us-ascii?Q?L1TIQ07UvFK3p6vAXau2pvQPxSRcT/ersn/3SH+oIpL2b3Uj14wbnD/b3buj?=
 =?us-ascii?Q?K6aeB+u1zBPbAtsNoV0u4jMbPoUt01ahhLIzz0Ee7hwcUuLJPUy6y6BAJksE?=
 =?us-ascii?Q?bIz1lQikf1Q6AO/rl6FQ9gQOdMLAdtfPeN0okg9K8Lqr8PF8+U0hq3aQwCMx?=
 =?us-ascii?Q?gLb0C56yUw0NeDTs468Cg+SQUzQCTNmjDPsohFI0gj2N4sRjS+RKYxju26ye?=
 =?us-ascii?Q?L5AZZHjL01IWn0ls17+tFI4wZqUkuxEaQaYRZH4jV93G9GcYERU5ilhEJUN/?=
 =?us-ascii?Q?Zt3X1K9DTc9WIn/I652Hw4WMhtwZMnORknAWJ9cWwYlhve+nqLffbOwUuJ5m?=
 =?us-ascii?Q?P77DDloswWoUX5GXGxMCih0U1TddA6pVUJr1jGD2WvTojotA0SG1DaxkXT4G?=
 =?us-ascii?Q?xztlfQd+XIw9Kx7K/eZ2uiNludj1l0Y27UIn3BZ+f/N4K1hJkm1xySFnfGlO?=
 =?us-ascii?Q?TU6h3WYgbChWYLy4E8RzqVD3nTy4PxmHG+DVVFOQue+OaTIaQB4zZIzb+mMH?=
 =?us-ascii?Q?kxIV1axyPyYFlnommS4EZ9j3dFLXSdgt/RgQXF3onvcTuif0CNvrpBmV3itN?=
 =?us-ascii?Q?SzXKgUbKDHOHRn4W4PwLKThX6h+U7RxknLW+dyarrk02FY90OMcwaQ91Fg6x?=
 =?us-ascii?Q?WkC3iAnG6Yjtiu+F7Sy2EcL4HQUOf0vj79inWilbCzX4/R5NhcqDl5338upd?=
 =?us-ascii?Q?8K8KQMqzNl43A0IBmDQmN5tOMtlDvk6FrNWhh3RC+f3R0V/gaAUzoaQ0ayVy?=
 =?us-ascii?Q?msgsotEc5saO4tnJbpbDoUuJXiwTTQOO7YIk1J2ho0TQ3phc0OgsVpFhHgMC?=
 =?us-ascii?Q?WuvPP1H1mfeunfFNKHAndjFcq5ZonXZC2NKo1QzmDVIZyBe2ziJywNkTdnK5?=
 =?us-ascii?Q?Wt0kyPtVBf7YdBUTb4fqylyE2KkB73tg2hQev4Ca5SJibepYs/Co3v4vl3fD?=
 =?us-ascii?Q?DLaJCb3aRPGONET0egSIrvSpDG+uRGkLFVvARuAE4ZwLSYv7yfio8QZCEeMt?=
 =?us-ascii?Q?zSkkVJsI1s6no8SqbFTJL/IHUrG+UjQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2469ee-2e8b-499f-91d4-08da17704b2e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 01:53:49.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BGmD+/VYgHJGZRd/120CbOBYGsHdzfgwOlVKBT0rEPoBpLUurZOmnWhis8uaj4X3dWb+SLMq+6K8xZ14QK50mJqR6rEikhhFAMI/KjXnjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_08:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=938 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060004
X-Proofpoint-ORIG-GUID: j9k-xhLQDPR2TzLsu4-FksArfUnJgyp2
X-Proofpoint-GUID: j9k-xhLQDPR2TzLsu4-FksArfUnJgyp2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A key added to the ima keyring must be signed by a key contained within 
either the builtin trusted or secondary trusted keyrings. Currently, there are 
CA restrictions described in IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY,
but these restrictions are not enforced within code. Therefore, keys within 
either the builtin or secondary may not be a CA and could be used to
vouch for an ima key.

The machine keyring can not be used as another trust anchor for adding keys 
to the ima keyring, since CA enforcement does not currently exist [1]. This 
would expand the current integrity gap.

Introduce a new root of trust key flag to close this integrity gap for
all keyrings.  The first key type to use this is X.509.  When a X.509 
certificate is self signed, contains kernCertSign Key Usage and contains 
the CA bit, the new flag is set.  Introduce new keyring restrictions 
that not only validates a key is signed by a key contained within the 
keyring, but also validates the key has the new root of trust key flag 
set.  Use this new restriction for keys added to the ima keyring.  Now 
that we have CA enforcement, allow the machine keyring to be used as another 
trust anchor for the ima keyring.

To recap, all keys that previously loaded into the builtin, secondary or
machine keyring will still load after applying this series.  Keys
contained within these keyrings may carry the root of trust flag. The
ima keyring will use the new root of trust restriction to validate
CA enforcement. Other keyrings that require a root of trust could also 
use this in the future.

[1] https://lore.kernel.org/lkml/2d681148b6ea57241f6a7c518dd331068a5f47b0.camel@linux.ibm.com/

Eric Snowberg (7):
  KEYS: Create static version of public_key_verify_signature
  KEYS: X.509: Parse Basic Constraints for CA
  KEYS: X.509: Parse Key Usage
  KEYS: Introduce a builtin root of trust key flag
  KEYS: Introduce sig restriction that validates root of trust
  KEYS: X.509: Flag Intermediate CA certs as built in
  integrity: Use root of trust signature restriction

 certs/system_keyring.c                    | 18 ++++++++++
 crypto/asymmetric_keys/restrict.c         | 42 +++++++++++++++++++++++
 crypto/asymmetric_keys/x509_cert_parser.c | 29 ++++++++++++++++
 crypto/asymmetric_keys/x509_parser.h      |  2 ++
 crypto/asymmetric_keys/x509_public_key.c  | 12 +++++++
 include/crypto/public_key.h               |  9 +++++
 include/keys/system_keyring.h             | 17 ++++++++-
 include/linux/ima.h                       | 16 +++++++++
 include/linux/key-type.h                  |  3 ++
 include/linux/key.h                       |  2 ++
 security/integrity/Kconfig                |  1 -
 security/integrity/digsig.c               |  4 +--
 security/keys/key.c                       | 13 +++++++
 13 files changed, 164 insertions(+), 4 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.27.0

