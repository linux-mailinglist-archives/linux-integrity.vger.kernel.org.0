Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FFA3E9C5B
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhHLCVI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:21:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49994 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233700AbhHLCUf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:35 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2AgKT019120;
        Thu, 12 Aug 2021 02:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LSqA4HZ/3glaDER7difXQuTnnev9KthsCgITY2sg0ok=;
 b=hqDwKEqt+QSR49W9+azloobf1BLxjvEli+ZWslOJj8WRe9mQRe9nd5aqEZJyJnZrFakd
 TClKpltRHuq6eS3YrzR0l8MuX3Kh97lF5eg75IvdcTVWHAacGd3F/GWH1Xd99KkoTNq2
 DRyUM6NgOE7q7BqSi2xMFYRDBFy/q5/TYt/InTGyuu2SpiXuSP7V1zt2dV3MQl1EMgHM
 pCUMa7g4KGZjsV8TWhyLeclG7C84ScN3W6GmLMiXZRMn+OiSA/9UcEIUwCLt+eHt75bE
 jF2VPAbS38io71/MhfyJP+wubk5SsCvkbfR7i9wQ0GSa2C1VZQZdoVyF/9aUYz5BZ2kw sg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=LSqA4HZ/3glaDER7difXQuTnnev9KthsCgITY2sg0ok=;
 b=lM5Vt03ZJ9qT/TsRCgZgDZj1goibga4x0SDnNEsLzUZmruBLGLyOleK45HNKlOhE5w2E
 dlxTHMjjIConWismmAQg+X7tklZcqsEuEpb546aGs088WAfXSMmcRj7bxnlEKdK1ZcnE
 JXbUv0qFEzKrG7TsfEySMBADbdnSBLN+85rNGbATQt1BLq+sp+8tfgapMceDN+11lsJg
 xzK48a/dwJAGKlCpB1Y0Z2OrkpmS2GrBYa9NqxqiAwziORDQbWvISN9aP0Z/nVV/uRGH
 0lCkVtHminhxT99E2a1pR/fNusLAvci11B7YgOWcxL0PgZegpJeD1zs0E8ovt7YWzX47 8w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt44c6gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GG37143063;
        Thu, 12 Aug 2021 02:19:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 3abjw7j7jr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt3AoW0RqO1u0KxeWGQHQIRjjMQzYPEvJUBK207LZByvVH/RQODN7uUIK7RbyXZtBU+ZbB7aKN3q3wMPb1i47ntbVvKUIcprafck1ie6K0rSTW9RaqmYJHrQi5kVo0/a1SfwgYAaYUuY4Ap3MylhHz8ViVnr2RtI/MDWKnSP3bnPRHPO2Xocj3vrm3ojRWzh+kqL5cauukNiM7fGtp2n2/i+VHdLdOmt2vNHpMJx2qephYp1aiKo9uEM1gDrYOgd85wjEZEIxjSh0IMnkMtMsdcg9+Us1Oi8TlyemEeuwZtFqeBYYFBXkupRUCdhPp+9NatEYj64O7vt+ZB5x2cvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSqA4HZ/3glaDER7difXQuTnnev9KthsCgITY2sg0ok=;
 b=eeZyYvl77XR/GZEsajEk+GJcNKl3273Qc8S2TdtFiSK/UHk8yICdGfKLkQiuKcD4IAkfQB7CmZvHUN/hgRDX+imDrFhWWblnK2p8NZB8MdaPHXDoBGSDtLRAFB6iI45U4+e6iJwVEEI3gyQc8uXUz+2pKB7AI77Q+xHLQ8Xgl4aL/6SdhN2G9a57ZYHtO+kLmofpjbUwO0iQM00f4tt0LGYp6QDRVyeezVREG1HuMxrp9q0AcYmC2kuc/JKRobC1x4eGcjLJi3KTGKDXxae3yMTaRkYiyNCL7/5t40sebOdLsqywJXk4vHepM8V4ySiJX2WHrYCChiOJls6jM4KrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSqA4HZ/3glaDER7difXQuTnnev9KthsCgITY2sg0ok=;
 b=P3fI/iH2YQE+CPkboF66dShFXLNL8ZVl7q3huxStSDLcUII7LD+r68i5ERvXvC1sTuHCTvSOjENFi0CLda6qi5captOQR1yVQ8vSQIpwJgiqyLAugBqzskgxFkiZ/EZ0sYAQqX+ZnvV4LD/xJm4P8OdHjj05Fm7lGTePkAOkNfM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4168.namprd10.prod.outlook.com (2603:10b6:610:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 02:19:20 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:20 +0000
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
Subject: [PATCH v3 02/14] KEYS: CA link restriction
Date:   Wed, 11 Aug 2021 22:18:43 -0400
Message-Id: <20210812021855.3083178-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c15262-8971-4269-bc3c-08d95d37979c
X-MS-TrafficTypeDiagnostic: CH2PR10MB4168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB41681B20A0FDDC5C53EA5C8587F99@CH2PR10MB4168.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFgAa5jVCNDSB/lblB59HR2xtcEWTYT5k/b53VtdXnTwmXDWCYJ5q2Y8cujiTVBcsqQ7KtsVpnoqFxIOMrkdjUicKyhiuBCrwUE5+aCq4vqer9vLzLhr9W7AC2G0NjPIeLMCD7ipqOQBblBiqVgky9GFG7QGoGt/DdyR5CMlGu6h5noVrgZUehtOdzhXydGT+r9mtswZcOe6rl9ozfFEByzLaGeli1vbvVKKrJUfWk8VZMauCFN+dqPsRgh/ZFLBpRoDWuhD193LGf6PE6bgqSu4bJ44Z/LRhoX0S/K6GN0GITRb1u5g6Z/IcWs4lIaAInEX93hApgzVD+9wfQnzBm7V1vcdRlANZ+fXX2eoNZKSwnKuv8jrrGvkahUHoD9QB6B6IQR6IQ78WRH7ybvMmIBUfnf4e/pywF9CBgVhD7KLW62kiMrmanSZ/OEppkXpqoFYd93qfHZd3a0FvxTbpa+0aNrIbnQ4vXdJb2pagk4vFu7nlxTaxG0KR30ZVswmHA3Bia9U4pGFtUOVz4Y1MCyiRpVL+AwtBRYPyE3gciAHD/I8LyII7L/I4CEwyZ4gfCSc9MNoE7JAFox+Y8fHcBcajK9TV8nZNVg0s8N8lSo3169kkZ5juy6xwmrKvgcumEDQ92D3LcoJvuMriCueCsly2rrvYPReyr8BCf4hFd+qExT0t2/5c86+FTnnCk13AdsQNkZOUxQ9NX5Z9nNDmaTsjRt+CjDxxN3h5cke9ZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(4326008)(44832011)(38350700002)(38100700002)(316002)(83380400001)(66556008)(36756003)(6666004)(2906002)(66946007)(52116002)(66476007)(921005)(7696005)(8936002)(1076003)(186003)(107886003)(86362001)(26005)(2616005)(5660300002)(478600001)(8676002)(6486002)(956004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tb+eg5lhNf7YEfvMlZhcDtwIXiCq+GB5xgLNgspMpD5e8LrWcwZVdK3rIUSj?=
 =?us-ascii?Q?X3Pi4MWgDjPK07iX/oalf4eMUWJn14McjJK/f55E4lEOxuSaMwir+ieOifKI?=
 =?us-ascii?Q?FRgsPFwBmfyYzk3sqyiX/KSFJDTCSeIvOk5LR2cBmrUKabe8KQsMX8+JnMVu?=
 =?us-ascii?Q?G1JkMGi87JuM44ipxBdlXS3hIQs1/2biwiIpW7dEbyLLTaGZDFzXuY77hBvi?=
 =?us-ascii?Q?EuMwFUw621yYgn9ue/4SnwtnfeQOf7migN7vF/h3Q+A4269sJyPRyeVV8RXa?=
 =?us-ascii?Q?/awsC0ZP2aXqnUMna4EyEAxAgP7+aeSoPn8YRulflhVZ4UykpzMgcTixxwlM?=
 =?us-ascii?Q?gZBT9TjIPeIe15jblbz+NAaBg9oT6D9Wb7Z4PO3JwbedNf7oAeKHWgpNd1GD?=
 =?us-ascii?Q?MwHlh6cfmHMloQlLfDopAcCKkYz8gjsbGN9kYyWtIRzO6IxcCyylTOPEEAaB?=
 =?us-ascii?Q?OeEnh99/oGR1YROrxjk1Kxic+SvB+IcdYSIz2NhKi0vl2W4gGYpGJc/6ScBE?=
 =?us-ascii?Q?gNC3VO7WqL8zwuFc/chXUKQm+ooQhdNrdEskyQhsPbOBHSTO9R08zVIVO1rR?=
 =?us-ascii?Q?PqBc93Sws3jtsvWiSFzUumHrHKj9o8sGZ1eM6eXCyV5gUBx75BQ0jpWHpZYJ?=
 =?us-ascii?Q?2ZxUOXHtAi+QI/5rNWbDwARI1kjDbcD8W7+ckeLTcpQdNulp/4GBDZsKV5Zw?=
 =?us-ascii?Q?QZYz20+D98HFFkcCa/vjoeOsXkQsZxfYlXBUdAeH/s9Tk4q6ou0CzaCyHISu?=
 =?us-ascii?Q?1sQJtIJmXPPeAJBRkMXIOnuhJETbZzaZqjAlmRLeNG1do21yEdwofosNTvv+?=
 =?us-ascii?Q?DXpvaSPGt5H8Ewow7rY5RlkpFY/d1CaWs5/FtrWBywWPiyUkj8j5RXJZK1P5?=
 =?us-ascii?Q?NljsFGBU5Z1yB9BIgHkSZZZL0BKSiEP0si+Mmlz0cSWckvXpi3grNIbODcfG?=
 =?us-ascii?Q?h7s+V+FQIQhG//UKV1U/5d+CrF5/k9xkMhXdo/PNldgUc8KUZ8A0/FDAG9rv?=
 =?us-ascii?Q?UrDU9EJarSWbeeGABqLh4fgXMkFUUhpWGFFn3CbOt9dTrlua985Zmtan+RUd?=
 =?us-ascii?Q?qg7fx+J1Pg+t3PmedMkeACxlakvEGBYF4859wNFwckHpj8IuUe/6RSUn1QM2?=
 =?us-ascii?Q?u2Cf9qyH422BsPlLXhHqhZqy1n88D2/Qg3sTlsjPDnV8mDIxYhQ6RlsutT3o?=
 =?us-ascii?Q?N/aXTnb+YWl1W8C/rUCHcZ/7dL6xJHaq8JGf+XMnHfyzkXbSOVgPO4ZSdVpC?=
 =?us-ascii?Q?hsNhEi7Weg0qORCg4SWqlYNbJoRC1M2kAzZGxX2eixdsuBRUQxWtkfe0Gpvz?=
 =?us-ascii?Q?521mf4E5mJCGsutovgDu8uiw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c15262-8971-4269-bc3c-08d95d37979c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:19.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FwiB5C4X6eG71cw6pj2deP64Hyb5740cuv4O5vnmLanxfvBYNKO5XCQoz8Babs2D9vJKgkNa3se5agxBr0dXZ+eNyEWyEyq+XgpAtHd4sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4168
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-ORIG-GUID: -RCWldmd7_kKjahDWesEQbUonVZlvGU0
X-Proofpoint-GUID: -RCWldmd7_kKjahDWesEQbUonVZlvGU0
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

