Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6603A3BE10D
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhGGCsA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:48:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61672 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229989AbhGGCry (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672aHGI015804;
        Wed, 7 Jul 2021 02:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=sjwKBquBEgBJoZiIrZeiO2Vo6a9z35hYFhDWstq0C5c=;
 b=mbbL7/dInnHLD+oZ3eGZgs6uBJVa8PYkCCSjvmLBO+wfA9ymiT978wtVBGwmpkTU807Z
 WknbdpaYpqE3NqSErGnS1RWkKzpJT9lF+b1//9Qkg6BNL/aChhuAy7Nmwl2nIS437mar
 YrT/rsAW13J1Fl9ID23wB6RQxtr1UypiNnIohU1GNQAp7QuyDjYxGU1TxtZCjg6lyJKX
 wgzuuKXLNXrPnLZoPd/89P4AsMpnd5b0OE1ljuVhxg+vILo6wThX/c/M1MaPVnjIM3S9
 Jyi01qPyNMOG7V80IMasdi9H0VBTKifj5gifYIED/sPkzm2ias8vRBsU+0pqs4k+myRL PQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m27hb64u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672a75u145022;
        Wed, 7 Jul 2021 02:44:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by userp3030.oracle.com with ESMTP id 39jd12ghun-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzmnwZRru2FfDi6DXiX2FPJtnPSNhXSb2RaQHBJ6LROa27CCX6ekpjj1eHaqD9Oqb/eh5qwkJAUyEjnxstGQpPdBtpS74jx9XbLfvepKDRsHU6JPtvOV7VAfR4bDS65ZsV3mPc6K67+5agdd3bbKXsHPeayD00amPEPNfGKtV7bPzocL2EgE7imb71/x118rGG8g2edFRj+rche/ml+0qlENApCASZ8dx/imt45QLyOavFu6YLTQJ9l3yxZ/299C7gnKU0QnQb02n+ScOoIXe87VJxPMyq69tgKt7D+VaLf0qboER1Ne1DgkIyZuGMHr9gnEFSfN9OcFKbcZOAKkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjwKBquBEgBJoZiIrZeiO2Vo6a9z35hYFhDWstq0C5c=;
 b=DyEcfDqYa17BNn2Lh8VVpsb2M7K+n+hlc+NB8CH4wtH7voKA2yt8iUYVwxttvjdZfKEfzjV2izTBEHN2Sz26dGO9ddBOpzdbobpJqWOjPd41T1OJ8HPIH3fYC90sx8szHJE0a38qXwGEME+vLHe0339XcGR6tyC42iGZCxETEUSmqL26eJgFytVDHEcvFHvayYZix3xBvqJWZwKLMXlKarXsj7lC5emaU29cg3xYDoo8faYYh3Ejufj0VlkL5f/6OO6UmLIAlPgRzes2WJuh09xuq2L7sZ5n4otvsj/SflobmoDqW1G21wsUtJAT4/KW9QXBTmzETHnn2aV0jdSXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjwKBquBEgBJoZiIrZeiO2Vo6a9z35hYFhDWstq0C5c=;
 b=zRbDnwtwtNThkXYEJoyH8ezhS1sJZ/LWqmZrvimUaDg/gmHuikeLQcaM4q2oZiArBhEVkg2PU1nnr2DtTEQkKGGWeBMHMgRwQvFk6Ga6ynivHswLEB6r+ujjF9xLjvFOAt/ZIx+8Izk4xwWBBuS+kqnfUKKurV1YpF0KoVjgqXY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Wed, 7 Jul
 2021 02:44:26 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:26 +0000
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
Subject: [PATCH RFC 01/12] KEYS: Add KEY_ALLOC_BYPASS_RESTRICTION option to key_move
Date:   Tue,  6 Jul 2021 22:43:52 -0400
Message-Id: <20210707024403.1083977-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b24f473-3a23-4efc-90dd-08d940f12279
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3863D2C6DFBDCBB68C0F4FD1871A9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5k6Kk5Ay2KXWDaj1CDuRgQT/Vo3w+05/eoUY/K/z3joq5dGgXDZFb6KnN/7FGdkNaydXrStMJ3YPouONmyWpnglotMUSVhpiOBcH4rt0dU+zeGytKtI9/CqCurDDeYAuPyDF4qG22pM9RrqWhXCjrpZnJufTuAeYrRAycnZhdGJuh6dXRmY8vkXnGI7BdsBSb3UhT7mw51yPXoUAc2tTlveS9TFsUCqOGpT3XhO/2Shn5gRK/wwjfvCYtdDL817pbt8VjbR+ai2zm7XYAslHn7WRhnzqbCaEhCs5MZNsUTvg4PPfSBtfz++yAe1i9fKp4s2hGG1NH0BObsseMLEgrxqqCE4dmuHvFOZZu0wS0ByV19pyc6838O8GTl1j83gyfX29FFvOk+KOmSdgi+/SHzCOWdHGeshqsi6bSftXtc/UzI172/s4CxkskM6+ZYPB58VHmR6OCiEM6iOKNbwO5jPb8KMeXNnM6Hs03UHnPJJju+CdWgeXT0BqEoJLjiBVvqijlLdI1m/A4Ra07VRb6nQvSF7zq1MuqvoR3QxvpTRUMyLZIqja2i9Gg0upbrdf8UGCW4vQ7Fm/sreb0g1E5w+EfAMIg6wnkd+Mlv2XYiQoaA3XkP8i10ZsqT77IBQmTTUN3w3Im0QB4BvgxbdkCCCl1GaSvB6iwAjf8Fxq2NzLVZcyXv4D8Pb3gYA3v5xVMjhcRxlS14INP1HkF5DTJe4SJIdRcm+s/IwYet9s1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(921005)(107886003)(6486002)(7696005)(316002)(66946007)(1076003)(44832011)(86362001)(38350700002)(6666004)(36756003)(83380400001)(186003)(4326008)(956004)(26005)(7416002)(8676002)(52116002)(2906002)(38100700002)(2616005)(8936002)(66476007)(5660300002)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iJf1NBSbo28Ym+2MwDJhhCZrAOKNWiZ1pDVyf0ftvYJaJ4VAk2ejCt7yeX0u?=
 =?us-ascii?Q?t3NnHhDDUzCiK3yOEHiDPPdrLss/IaV6x/V6QWi9s4oBqbOjTh8+SahJkVq3?=
 =?us-ascii?Q?DF9JjIbr9cZ93NVZ6vakSLKsB0ImKhv6aNHvqQnGSGvzxWzyfZa5cHU1Ee6b?=
 =?us-ascii?Q?/07bhRTkEe1dLtyA2HZSg18mt83YC0RQA1SexFkKlX+Y4dR10BHRRizxpF66?=
 =?us-ascii?Q?f7Xn7V2I3HfeLAGdZxHWYIcSzysSq14JC+S8rsShbocE9Bl+jXBbj00CvHXH?=
 =?us-ascii?Q?jo7SSEtcR81JowMrvmy8QjYbKOgef5YsfO+djbdXiMLlLFOqMnvQhxbWCHK7?=
 =?us-ascii?Q?61Nn3STFn1CBk/U1S4KtXMmPqli4rBpDaMGBPyqORaiiZcTcceNUJrSjJNL+?=
 =?us-ascii?Q?Va08peZjklzj7DpCngbBvbrD+dzRJ7kztBZthTG5JdloPr36fTEyy9aAuWCc?=
 =?us-ascii?Q?Bih4rugQx19tGHbpMkHmZRbGj88EquzWKHPqtFBahjc4R8bfHEEbPHrWc6WK?=
 =?us-ascii?Q?tyEyP3Zrfo5G6qoaq5amCL/Bx8V/jQpsSEd3IyxneFZeGwMOBhfL0P2RhNuI?=
 =?us-ascii?Q?n8c410G1EL1bBznTBFAoE8fQ5RD2xJwTWIIeWOm1LNTFodzGFnI/KssBvFou?=
 =?us-ascii?Q?Aewebs09qMSxMI5NpJeNPb76KVJxi4r21G7pbBVL04MWk6yBukwOuVq1t5Fp?=
 =?us-ascii?Q?CYMzfin3jtpzMvtQzfTDo5ycBYSUQLw2GipzE0EMflGffJxwG7qK0dH3nEvm?=
 =?us-ascii?Q?ev0ueDEQ78T/VFy+rEDl3Qp8UGs4+whsdHI/g6EyYxEAxapLBwdu21YOVGjm?=
 =?us-ascii?Q?n4Pd7seqkTZxQiIMSGnuJbBwveTYaiZl7yoCaHryXJk4QOyON3te3X7UYSTC?=
 =?us-ascii?Q?/bxii5mQbZjN+Cgkl5+hLo91MumpeKs7oKUuoe6Xpo6A/F1xe2EuGTFj/cLx?=
 =?us-ascii?Q?Iqo3KARgOYza5tebDIIxxsli+/F9IJkIU/9oRBdiH3ehTMkpVrxZiVJaK7Le?=
 =?us-ascii?Q?eFazAKzuO+Q9itaO0F39bKkNbU3cCfKniRKA/9UQF3Co8IvPzACJH9/tKdZy?=
 =?us-ascii?Q?rHErjA6IdTvtQFKCRQmlir2jcDRX2yywG44rWdZaGcTqmPmmH8sunPNQXlQD?=
 =?us-ascii?Q?OsJFtBClnp1P2riCZolRYR8Q8CnjJgSZY+H1X4icwauow+aLe95mK9j+1C4u?=
 =?us-ascii?Q?Wu6W4qfAKdfREcA0yplNO8QUmjNFhoGhMUMXAe9Ovja6p5fRBOX8kZvmruNK?=
 =?us-ascii?Q?XrtS6Dxo/hAs6dgE4OFyqDOg+9o6YzvI/Vcdh8qcDZ5w9/EzWG9F7wR/ae1C?=
 =?us-ascii?Q?coGc+fLM9MmZG8q1W52toWw1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b24f473-3a23-4efc-90dd-08d940f12279
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:26.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sliigm/184mgftabsdwpGGRvo+kbzThqRVzR5g4u7Jn6RNBK4f70LJy0f1eB2i4r2409XmogmZFb/ZPXQ+ec94Isv7thy0EFsmXj1kl33hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070012
X-Proofpoint-ORIG-GUID: ozIm2wWofO_A-UkL1MLrLx50NRDG3P5H
X-Proofpoint-GUID: ozIm2wWofO_A-UkL1MLrLx50NRDG3P5H
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Callers of key_create_or_update can pass KEY_ALLOC_BYPASS_RESTRICTION to
suppress the restrictions check. Add the same support to key_move to
bypass restrictions on the destination keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/keys/keyring.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5e6a90760753..56ea2b78d2e5 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1585,7 +1585,7 @@ EXPORT_SYMBOL(key_unlink);
  *
  * It is assumed that the caller has checked that it is permitted for a link to
  * be made (the keyring should have Write permission and the key Link
- * permission).
+ * permission). It can be overridden by passing KEY_ALLOC_BYPASS_RESTRICTION.
  */
 int key_move(struct key *key,
 	     struct key *from_keyring,
@@ -1618,9 +1618,11 @@ int key_move(struct key *key,
 	if (to_edit->dead_leaf && (flags & KEYCTL_MOVE_EXCL))
 		goto error;
 
-	ret = __key_link_check_restriction(to_keyring, key);
-	if (ret < 0)
-		goto error;
+	if (!(flags & KEY_ALLOC_BYPASS_RESTRICTION)) {
+		ret = __key_link_check_restriction(to_keyring, key);
+		if (ret < 0)
+			goto error;
+	}
 	ret = __key_link_check_live_key(to_keyring, key);
 	if (ret < 0)
 		goto error;
-- 
2.18.4

