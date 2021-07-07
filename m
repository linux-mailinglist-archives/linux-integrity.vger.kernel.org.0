Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E493BE101
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhGGCr4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:47:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60546 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230012AbhGGCrx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672aFEM017231;
        Wed, 7 Jul 2021 02:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=t/9NZdz2FBIvHSF5Bfi6i5QA0uvNa/mdVRacs+bY098=;
 b=twkBVUHpyjHTbcJgPfA5TZwP96HaqoCEdweCGC+OoFZ9DBQhAToJMEyyjAEW+Mhl4BnF
 NotS997jI18CLUkrnfT0FmssKe51xgEqLz1fePODPrnSy70E/Ep42B2CMeeR9cVFJpNG
 wALGL6cwjP8sMdR32akdxQVMrOnn5lmPD/Z97NI681s7vJb3UZE7tZ2Swghm241Vp/Ey
 xcXK1Cgx7KZdNTgk1YxgbML4Gfi1MiIXwcFDTWh60vnMcPQgFIi+1TQC7UJdEDQp0Y62
 sQep5iMyjz+WeMuzC+5LZMb0hHbRbGeCladJdR52S2HoJa8lmTskNlBUVZrDgG4WK3ul fA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kq8ec4yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672aUMK070936;
        Wed, 7 Jul 2021 02:44:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 39k1nw7q2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6j4R6nv12kyKMS6zcX0nlWNxeVnoT3CnCgj+EG4aE53pd3wT+8nVdewGvuAxOjbAc0LafsWwEyhz6w+KEm+It7buGYHWR45lO5Ne8JBaeKe0Ykm4g3tSDPb5PR+CBpP/RzJjY/2nZKWTgvU4wiY821C8zwmUYbF9AmATyUzvON/TYmUF+kTVH4q30wEtqDHS+dhvH3WpqiO2lf43TMLBi6NF9rdVuUAcQUQWyCJwoiPrEOoWU3S4IJz72JzciWOdCwBuxuXmj/tfGTkduS5HhXdWbdXpb2oPEE1C9uWglRY/Sm1el0bon7+bqjoliHvNLZCKQ6S2ET8O1/Yp7G89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/9NZdz2FBIvHSF5Bfi6i5QA0uvNa/mdVRacs+bY098=;
 b=nC0kkU/PJ0aIsRsDJ0lZlc8ZOmYVtsLx6+k7DTL/4K0OCo3uZg/XVqSjNy9kHJ4cvtbAjS5pYBuLKTYIGgynbnkVb4+IINzaWaeG7t1/TU1iZoAFZkOppboyQgjd10gyJ6jhT9lFUJgCDUt8B3/WhBFYJTpIF1JUmkATnehgiXlDnV8gaDxZcJYBSQOEw8uvB0d6zE6bo6tw6/duDfogFHZkYKKC1p1bpXJkuFdGBbcZjHO5tQ7dw6xXzXd4unmk/OGU6AkW9AcmWpgBzzUKJXvAjZn9lfF7YgX63q0u+7/Bn/EtWa+NuSnnoVHgw206Px6m2gQwKlq3MG/K23V21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/9NZdz2FBIvHSF5Bfi6i5QA0uvNa/mdVRacs+bY098=;
 b=LBZz4j+QRW9paohVaJTR2YURB+BjGidN7z1PEityESUwYjom8b8KxBu++9uRYqR4J++NRfOkDKYQaShvubCaeH+q6trOd39VnT3Kd3/VFE59xmXrc+9rAcj0XXeGVzfir4nhi8YiCoLw/S4sX31kGBcTyXX1LKEKjL2f759GSJ4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 02:44:43 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:43 +0000
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
Subject: [PATCH RFC 09/12] integrity: accessor function to get trust_moklist
Date:   Tue,  6 Jul 2021 22:44:00 -0400
Message-Id: <20210707024403.1083977-10-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14cab4d6-af44-40f1-5155-08d940f12cc6
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4166E8E75C9B34CB6C149E1C871A9@CH2PR10MB4166.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kI7eTrBrVzSionxSlWJU9v2zPUMPutCCTLqWuJs94uTLEaH8qVMLWww0CYeD1ObbbkFnp7WODhALWL6OdgVlvyIT4pxb0yt6OM1j/6VLXCPeTx+HBxnUv+gC8URaCKxiaW1SICLiVNAVusC7tiZL3cPbGAVX3x7R8Ccjr775Kh1ZrcAE/fqj1YNWBoRRVOoj/HM4Lbdi1pw7DVrs7xYySHX2EnwkIVhtH6134c25/AsRT7rjQODQYk6Dyvv9WThDi+Bw1bNpNZ2JotYEN9/jg2WZPxd+zjMWrgyFpMBPXk0f0j8gz3qAczTX9P5ig4lscFbwxGSCFI4dm6/Z4w2JGR+ixBVH9xaqyzJ2VPkIr78szUCdc51vsbkknaZ4PXwMQBKV55p1vBKSJ8ABEP/DdvPHxM18Ezxec0qcAxy4oDZxzYIN1tj3z2wDhqu4YAVZplckkbpMtSHpIYmzvbyKjjmAvhTEg/IU8RLNExBimLSGYiWqTgEImD6tzvSvwAIu2UR8uv26rm6b7vrDq25nGeKRQCDwWSoJ5noj8Xc49ALn3uxNf2utWnvpNk1uCkN0k8CWPSf57g1sQSbfh/Ll3j10/3QnYz4mLGXcHkh594d3Kfq2IBEK+fpgDoxwI7+dCnfBO/RBtbbvZHqHHdIJRSSGeaApxbmJlskTBlnXDdhDZX9iZc6fid0VsJfyOh3KfTk8Eq3rwg3Tt0RnehJdqAwfNYsnCIMyQFbxpZlMivM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(36756003)(7416002)(52116002)(2906002)(7696005)(4326008)(44832011)(38100700002)(83380400001)(86362001)(316002)(6486002)(38350700002)(186003)(921005)(6666004)(8936002)(956004)(66476007)(478600001)(66946007)(107886003)(66556008)(8676002)(26005)(5660300002)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hQN5doBiYbco0AG0U1z30nN9VoNXM85w8g8bFE4xBhG8u9iH0qnVJdDljQD3?=
 =?us-ascii?Q?1G8RolIvtF81L94j0cCP2tu97gUCRtHUeY8VfvfxUguQ9vY/UuVQzr6KkLkb?=
 =?us-ascii?Q?oEG7wcyQ+AGLTNzsMykIyQ14pRUhxNPq1XtqMMrT97d48Z9h6hOLym7E+0ND?=
 =?us-ascii?Q?ZDLgKhLgFaln2ujaeH13dMt9HGfOSGKxaQLbEZhnSPVeHvZ5PKd0q+O08E4M?=
 =?us-ascii?Q?nO/eRbc/2OWq72WUzDetL8uJ43qR7xkhd2SxdWfrGGzoT7CDAVMbavXIsGLg?=
 =?us-ascii?Q?fojTX1oO6pZJ7DdG4FWIQeYreCF2Pb63gH7LXTF/NbhIs0dO/F9WWXm83c3H?=
 =?us-ascii?Q?pP3J6+J1tJscg8zhsNLwn1vo8SD9eaGyPKIbXQslt/loaY1J8wS+omPh5XTi?=
 =?us-ascii?Q?bXgEizryfyFYpigqOtgUkVgB2APmFgyYrm0xtMMFjKyhE6A4M6eXWRF40fh0?=
 =?us-ascii?Q?6oSVsUEj5l7Hcug20vp4XVTjOfa1edNEllYxUl4cfV8PuK079eBJBgHhUmDy?=
 =?us-ascii?Q?qJvJVLqB6ApZIn1kJ/oRoALGXbypNaXAKC8CkAQtgm9+6s/0qg7L3L17kayg?=
 =?us-ascii?Q?fGt/LLVWGX9EnMoU7EfSN08DjPUhEvfnsk2Hs0mR7xY5X2IN7C5O7KrsaGPt?=
 =?us-ascii?Q?vpTlfwCHtaVSbB7ZNM3svqPBfosqqXxYg37llmIwXfzRgLSHC3T8sB+9rN1U?=
 =?us-ascii?Q?mLZNcibI/+XgqO9gIJBFg8RCy95i3hiA6VqQtg0G9ahgMPaNm04+nbMeNGah?=
 =?us-ascii?Q?gjRR1hqhNWWJrg8c9Kk3dcTA4rjOMug4uZoI5/yWOO7NekIppa/1Lx0u7OJ2?=
 =?us-ascii?Q?nVsVUF4qgCeY9ziv0AE4JJyzppjSZcIZTgNdqb6WJrcpB2XMf2rkDtrfnRcu?=
 =?us-ascii?Q?E29IeTA84d1j5pBa64P6XKWjCwgiOOzi710sDvkfcg4EzBRoQlsiLLXgFLsy?=
 =?us-ascii?Q?ZkKyN/MUOSs+LiDUhRfX4PTWCtG92NwQIYpLR6nv4Es9GsVkJdqSw7uLMVCW?=
 =?us-ascii?Q?mzwmOAy1dFNrFphPWPfmvqhg9TdlCiJS/d4nBF8giIAxisUQbhd4O8M2ghOS?=
 =?us-ascii?Q?r1tgQgkOCDkurtAonnl8PBt/ed0Q5+yyJujTA9JO2FEt9dj95TTk7JnrYFU1?=
 =?us-ascii?Q?0a9H9Rv4Q0jNXWuekmG9adwtLd9yADiRmIkxtN4U6pylXkjuh++n6F+0HGt/?=
 =?us-ascii?Q?diuW+53+r/4vOgaFr0odlEJgk1wsL6O4bh6XfBY6E2xJwDJk3fwbv41luqIW?=
 =?us-ascii?Q?/AQOdHzR7dsVxQZqRZWF3qnANxPiujX2TOhXXFN4RVNC0Jao/RmmIGvOX8vI?=
 =?us-ascii?Q?r5N3MHuYmkUJsJoycK2bvbtK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cab4d6-af44-40f1-5155-08d940f12cc6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:43.4227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e41ouRDReub3cGX+KvVmiRlVTgiw0CAPso1qbCuwmLn7fXRcH+FovjbzQe4gjGDjAIDh9joBeOxxjsXYGJv3VB0x9A2Ye0csU+Msw4D+qv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070012
X-Proofpoint-GUID: WloLYm9LKETXjbV733TeDSigNq3Yfj2B
X-Proofpoint-ORIG-GUID: WloLYm9LKETXjbV733TeDSigNq3Yfj2B
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add an accessor function to see if the mok list should be trusted.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/integrity.h                  | 5 +++++
 security/integrity/platform_certs/mok_keyring.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 68720fa6454f..a5f7af825f9b 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -285,6 +285,7 @@ void __init add_to_platform_keyring(const char *source, const void *data,
 				    size_t len);
 void __init destroy_mok_keyring(void);
 void __init add_to_mok_keyring(const char *source, const void *data, size_t len);
+bool __init trust_moklist(void);
 #else
 static inline void __init add_to_platform_keyring(const char *source,
 						  const void *data, size_t len)
@@ -296,4 +297,8 @@ static inline void __init destroy_mok_keyring(void)
 void __init add_to_mok_keyring(const char *source, const void *data, size_t len)
 {
 }
+static inline bool __init trust_moklist(void)
+{
+	return false;
+}
 #endif
diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
index a5644a8a834c..7d23772a1135 100644
--- a/security/integrity/platform_certs/mok_keyring.c
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -83,3 +83,8 @@ static __init int mok_keyring_trust_setup(void)
 }
 
 late_initcall(mok_keyring_trust_setup);
+
+bool __init trust_moklist(void)
+{
+	return trust_mok;
+}
-- 
2.18.4

