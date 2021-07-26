Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162CF3D6565
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbhGZQez (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26336 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241046AbhGZQdz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:33:55 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHAZ0j029680;
        Mon, 26 Jul 2021 17:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=H3k8iZ+ZstgTPCj8dUlmi+/L05F8rsLsy8An/AHnn4A=;
 b=VJxfrDUE2G8T7eeRvlWuBi/T7X4G7K0FNT2GzsdOQKKDpdmF2mU+2B9u3IuetvGjvFdz
 5KkKWSVk/mpAGuWL8Q253WgYBKYLodgR0OQlOsNGVFhpKi1lkP36schsufhKQ6W2D//K
 t27etmxWfninn0DAUNBBzUovzIujL5pBSH/jae0+fRBKKrJxZgy9AmS2mPKPHAkk9+Ja
 3l8vh4XhO5XoKwcUaMwQoRsUiZ9QeP1soK+K5xYvfWtCyY/zk3g3PY39WE0r8+N2NuTq
 MXm/TmOP1p1w2BzkaRXFBTGLIbbk9zhfW/iEiNJ0f5j7tatzWUmvQrCFTkp9yUx/kR01 1w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=H3k8iZ+ZstgTPCj8dUlmi+/L05F8rsLsy8An/AHnn4A=;
 b=dQKagH/WmSnHRTefxEFYJwEmXun94cvnpReFeBFjCwcpmFCXbpvGoQUHYNk/T+b5Jen0
 EjNmQczgiPHK68I5eHvCRW/P7mpl5UySvuFE9TxYV4tYAvi4A4/UfE9i2qslRE98v8tI
 dEMueEKUrXA5ViyXtojEOoEvkdeemf++5Q7f5WvEXcFpWA4Gzq74MT34IHmO773yzU7Y
 vR0KxbUT9VodLE/0ejus8LZwWK8Y3iAe9p2HLyogQwy0E5mv4TyMLE6tSC6060hjvAt/
 /HzEGYIe/uqwkt7R7t9a5ppRwkvvk6REUVGqwdOoFhAUi3Fb3tN2NWiveaLH4HzmQ7QJ 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1cmb22k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHAihc005213;
        Mon, 26 Jul 2021 17:13:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 3a0vmtcvb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCCpIbtyStvzrbaLeQtWZ7Tb1niCPOYlbJ/dcwMFO2J6plCuV+2FCDIMryMnRPZZQzwiZIkcwSlc4onjYHvW9WhtLguryfCdcICSItX3bVFF1ziCzKvQcnuTGqHWDGEtAavjFKUf8oVRpup2oYCjKlPDrTcnS9jkQnqMNxzX3E4WSV+UwyHHYPRVZAEopD0sJhsiwlcvp3VV3LbHd9rd93RPgi07/i2bkDTVDO6fBq8nFMgbdGdaEINk8PtVeI3BYjrteXUHyVbca96FW5zNjMc5V9jVpoZZI9HyQ8josq+40hxBwdRZSRQJCJ85zhVVNP6F4hVAjnn3Qe1QLvDw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3k8iZ+ZstgTPCj8dUlmi+/L05F8rsLsy8An/AHnn4A=;
 b=F5Af7OiUOqNuPX2iskdritGxBTbg1IBRLOjS5m6UphDMSymDlG2El9M2izeKutWWCzfiOfroAJE0BYaIKGbBAmCPfDXsS+APhhjw4uLNUWczNi3Aww2BfMxvuDYCTieZN7P4WQGlHrIs9B4iQCbMj77a1pnmXI1GpEqLJaVaaFJGI6tBQdcamTosyX6UTfegk+4GN1t/jnx0qmB4aKof+5UaRBly+kHDG8sjY1nx+/zstUR0hsFutUg257QypFr2zkaPebeWqAfofF/lprnVsGs79K54m6uRcYYaNxalkh0g19TaxnQgpO/AtZISogJH23jbgXAMCs+NePdhQJ062A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3k8iZ+ZstgTPCj8dUlmi+/L05F8rsLsy8An/AHnn4A=;
 b=qjnpwzII5dkRC3FMGdv+s2XXwkHiqnMeT1e6NkyH+XYjCnBOT5V3ihF2VFCQLZVt+giBR+em9rRtFyj3/cjDeyBuvhMsvnfnwLeEDKsLt3hr8ITyQbKr4Uw5Ng7A7Q7cbJqYODtkTS4IUEx3qmg0OKbFj9JGlNGgJ2LFmTU3+yM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:13:39 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:13:39 +0000
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
Subject: [PATCH RFC v2 02/12] KEYS: CA link restriction
Date:   Mon, 26 Jul 2021 13:13:09 -0400
Message-Id: <20210726171319.3133879-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:13:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e04c1087-89d6-477f-e2dc-08d95058b61e
X-MS-TrafficTypeDiagnostic: CH0PR10MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB521131C828E5EA503848702A87E89@CH0PR10MB5211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQad2unGuIAX3v5l7mW2l7c8TYM+FDpOJMrE/Gy9vILuFmboDyrgkk1yfZiK/l8GtvBRFO3FRy6QjtlaKQL+sVhV1CrKgBWXjox8HWM6OHLlEKAWpcvK+iFhWvZLUx8seFTJ8O40r0Xws2kJTzzGy7f57rMAK4e3hxC4Ckp/mpv7mHfiX5+qze4loU2KVZvKmNBETLC1tK8jFfHaYrsxR56LlpomSchzIhpJI51gwon8Dp6mMpWOyn1K5D0T/T/FC1hUuDA5IhOBlzJ5m7NyoI3U+jZkhyG3CDEtpQBeLEH0IUfsCIgiQkFlifhxHOtNTD0A5MsSQkPgMyD9BTnPAlA+MCrE9RCA0ZIS5Gafa+xSma4e7XI5ofkefyTyTPiXVTKtq8SP8mVcH+6pBDGwq55Yai4F7QRo45bxke7zMnRgBTPlD6BkQY5BE/ATyyMzWDTrUt0gnDt3X/Q/SO64+UIDgbw+Lk+/r8d+mGkqF6trPA+SrdakoWkutZWKWMBByyEdjuX81DjLyf0mooIRsg4745LdNtR14jUhqtRjPPqyHymzgARUQ++RRRMDLB0dVtubTsjzCKyqT4GdyUKc0zIQBXiDjHVWcayZWBAMPqBbuOuU5Lb8GPVjr+KOog8SGDFfCkesUx0B+WomLQvO+tzn0joTCnXutGOI4kh8MZutwfvDaLtknCBvfeN1XZKHcTMcCK+Ab9+o1aPMr7wSnvp9U3cNjxd7x4JS5pncyNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(1076003)(2616005)(7416002)(52116002)(7696005)(44832011)(478600001)(36756003)(66946007)(38100700002)(38350700002)(186003)(921005)(956004)(8936002)(2906002)(45080400002)(26005)(86362001)(8676002)(5660300002)(6666004)(4326008)(66556008)(66476007)(6486002)(83380400001)(316002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7h/QBGnU12g65nYIo4MWuhA/KbQu1q7e6hOWhm1MutRD4tNXQb55g0+X1WWc?=
 =?us-ascii?Q?W2Gm8H04/l3vpPNKcjMmTA9whIeRPIAuct2+aXPENqCvNUTiS0pNKyvkt6YN?=
 =?us-ascii?Q?2E+t43yO8Jv2A3zL3SfAXxUS3XOfFR9QLoK/sE93EZtKNbIcA7dCoDTDKA0j?=
 =?us-ascii?Q?Uw12LQrRCmZEcE1hAvVklBsOQAU7GVg1ZdxZEtM4rJ6hO9Fn+HVTvUzU4KEh?=
 =?us-ascii?Q?nM3aQ2W13+DKvmRuz2m2DQWcw8IUgcRLb7cTldID60d/ltwWvxQ0Na5i8qZB?=
 =?us-ascii?Q?hynZSxcuX96+iijVotn1WdMYV6CEp3Ak36U97LSCOMxbQ0oyyT6LJpa68iJc?=
 =?us-ascii?Q?cadQ5npSVbdiBPB2eCE+FXIFAqjemvE4/4bx+H2nHduCddfrTwcpbUyW8X/0?=
 =?us-ascii?Q?nvO9XiWVc75MRk9wXxSfmP/L5+Ub4gH0bvoKkBPj1patd8SPdOw+l4OEkpxT?=
 =?us-ascii?Q?3glDcbl4FIwYIFHcIUSaWimBVZZ87py8DShurzAugt2/kxPuDiinBkzWM4cs?=
 =?us-ascii?Q?4oJDowD6SysH3GpV1IGtI2MAK6M3NkQMVrSPmPjQ2/4k/nhj3a/eAduy/yq3?=
 =?us-ascii?Q?P0katp/2NXgNCFGt1Z5y2j2IutTqn3S5xDAindZi/BQqiW4+Clqs6E++uHo7?=
 =?us-ascii?Q?wTllTS+ZpLIUk2Xqgv1+fzdI6Xjcp0wAROriQt60zj3M6woJQjDl6bs9QWzD?=
 =?us-ascii?Q?tYxOgvW87Pnx9p8yWZFtTzBZZY4bUdKZ2kULIWk8WsmSh9cPX+gnX36Cr0k4?=
 =?us-ascii?Q?IRptI8T89vi4trsMHnSeeIvr97EbH0dytXeMTbF4dHE6L352MoT1czAOQLQR?=
 =?us-ascii?Q?/cKmZYdXP6Csmq+vUmzDDHpBTPqutt1/rFY6TkS5wQ4IfQoQik4YqTEyYgOv?=
 =?us-ascii?Q?rpb33b7QBPQ877m92QxkrvoCz3WtJHj7iRdg8z/rZwzygrtlvJ36+xiBSe10?=
 =?us-ascii?Q?6sae5tHPt412uuf0IiRLx9XAssaPh1KQ80CABV8M8xd2+z/m4ZNS5lpvcRhi?=
 =?us-ascii?Q?sMZxYLnl9DBh3IqgW7zp9kYGblZyFkyXLS9jraTyhp2SIScmgmwuoN7zc0pA?=
 =?us-ascii?Q?645dciiTSgu93WskLTe9XTcCTpl+7mGfZv/YsS1t7ik20xPC/zOBWXFxoZNB?=
 =?us-ascii?Q?1RSKH8shZM+Dde1s8yCG7wu89MG7GhuuBOFBuQYfR7layeGFzvEs4zgOjPIQ?=
 =?us-ascii?Q?hhMD3aT4/DHyjkT7egHcty8keKND2CuoZ5Eld3mMLTRCp9Vhsz69s8Ospj4E?=
 =?us-ascii?Q?SIjW1BTnfnhcanmsUG3OuuRK8DxlYbbl8vuEqns5XhhRVCLUfbynLdx3zBtI?=
 =?us-ascii?Q?I81TsEUZFC9KaR8iJPqQZmGd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04c1087-89d6-477f-e2dc-08d95058b61e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:13:39.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucIAfJxgd0rvAxHd5TEfN7WX8kEuQDlkZbQGY6bDOo+JplCg87l8TSXfC3QZjg1XyK/S6jC8JquJtpYJPd8KHLfzfKs3fMyOUm8NC40C5FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: 1ZrtGkhRFXU8avLinyJyMhx4e1V4sCAj
X-Proofpoint-ORIG-GUID: 1ZrtGkhRFXU8avLinyJyMhx4e1V4sCAj
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a new link restriction.  Restrict the addition of keys in a keyring
based on the key to be added being a CA (self-signed) or by being
vouched for by a key in either the built-in or the secondary trusted
keyrings.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed secondary keyring references
---
 certs/system_keyring.c            | 21 +++++++++++
 crypto/asymmetric_keys/restrict.c | 60 +++++++++++++++++++++++++++++++
 include/crypto/public_key.h       |  5 +++
 include/keys/system_keyring.h     |  6 ++++
 4 files changed, 92 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 692365dee2bd..0a7b16c28a72 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -21,6 +21,9 @@
 static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
+#define system_trusted_keys secondary_trusted_keys
+#else
+#define system_trusted_keys builtin_trusted_keys
 #endif
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 static struct key *platform_trusted_keys;
@@ -45,6 +48,24 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
 					  builtin_trusted_keys);
 }
 
+/**
+ * restrict_link_by_system_trusted_or_ca - Restrict keyring
+ *   addition by being a CA or vouched by the system trusted keyrings.
+ *
+ *  Restrict the addition of keys in a keyring based on the key-to-be-added
+ *  being a CA (self signed) or by being vouched for by a key in either
+ *  the built-in or the secondary system keyrings.
+ */
+int restrict_link_by_system_trusted_or_ca(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key)
+{
+	return restrict_link_by_ca(dest_keyring, type, payload,
+				   system_trusted_keys);
+}
+
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 /**
  * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 84cefe3b3585..75e4379226e8 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,66 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	return ret;
 }
 
+/**
+ * restrict_link_by_ca - Restrict additions to a ring of public keys
+ * based on it being a CA
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @trusted: A key or ring of keys that can be used to vouch for the new cert.
+ *
+ * Check if the new certificate is a CA or if they key can be vouched for
+ * by keys already linked in the destination keyring or the trusted
+ * keyring.  If one of those is the signing key or it is self signed, then
+ * mark the new certificate as being ok to link.
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
+	struct key *key;
+	int ret;
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
+	ret = public_key_verify_signature(pkey, sig);
+	if (!ret)
+		return 0;
+
+	if (!trust_keyring)
+		return -ENOKEY;
+
+	key = find_asymmetric_key(trust_keyring,
+				  sig->auth_ids[0], sig->auth_ids[1],
+				  false);
+	if (IS_ERR(key))
+		return -ENOKEY;
+
+	ret = verify_signature(key, sig);
+	key_put(key);
+	return ret;
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
 
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 6acd3cf13a18..2041254d74f4 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -28,6 +28,12 @@ static inline __init int load_module_cert(struct key *keyring)
 
 #endif
 
+extern int restrict_link_by_system_trusted_or_ca(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key);
+
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 extern int restrict_link_by_builtin_and_secondary_trusted(
 	struct key *keyring,
-- 
2.18.4

