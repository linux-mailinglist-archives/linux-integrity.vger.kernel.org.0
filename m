Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773DE40B9D4
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhINVQi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:16:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55318 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234125AbhINVQe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:34 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxaSX026025;
        Tue, 14 Sep 2021 21:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=j8G9XshxXuQ3z4G0CyxnUr/kN8yyH553hc7Hx+LArAI=;
 b=jpWaOmHEjpNuu8kvkJkzkO855FkiYiW1HN8w+SJ0Ib8idQD2fcy0oRH1YpQ8xLDtvehW
 zTR1CkcMzv17uGvr5sZaoX+kkhqQ4kwWVzv6BshKzifrgsZAP/1g2DpoFuiqGjNzBvkg
 65vBS+cIQ6FQy8mI7WX7pcxe/weE2yu+fK9sGKfJDJcHGLa6xPeu1nu+0uD5A97YsKPi
 fuYV0MQMt3/uMUHUPRq3qShKYtAnIlXgm/Sjnxv+Q0sm6KjFvJaWejTi9vnxOSgIIdLX
 CnGb+GR820q89JWLzUzkRss9horOowehA/rZplaQ2muwY49NtmSYsS5jKJKX1BH31jVk Cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=j8G9XshxXuQ3z4G0CyxnUr/kN8yyH553hc7Hx+LArAI=;
 b=Uz61wiMWbC1iJVcCmGA0zJlN9eDc5yWplqmWfBGdXAFVgtOrl4uDfaskD9gHDlyaIX2X
 Xm3BXYTExTSOLGeGHLLVwuvzpTrSP+AYV+F4atajRFznmPxDlvmvAe6az+5D8RwK8WKp
 SoqZ8eh6vRjR1eULMfOQyiF7ZebEyRttafKqKAFD9CfSgoKTFK6DhY2vY6liMWcf/1hn
 8kbNB6vjWxgLRakOKkP/SYRfE3qWe3HX9Qvxn07XlZBnD0yRSPNG68pxKCSCH4Suo527
 Ig/nEeKDFfZgR/S5UH1bzONhifCVbnL+wQz+MNUkySAkoMe2jWJjumwMcnqCfdWuD5NJ Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2j4sbcy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELBB0A179027;
        Tue, 14 Sep 2021 21:14:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3b0hjvqwd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drokJ/T9YrDKXBlP3qbEGdQ5O2dZBp63uqtjUJ/4CqZrLXaes+L+qMDjfWj6U7eEa8aMMZ1mvFERHzfIQ/i8/UFL6p2fFIZDRBZDI/TcSGESHtPOW+2w6rDXJlOxJDaqPnS5f9Cxi3eEcvqpwR0dAKLJNmrFihXzlAvmNTcFi/E9jqMOqlNfvN4yvEp3y768yQB8cHmlo3oQ5HM31j9XK9rR5vdhdsTFBLAmrZc1CQGnzs41MFUFEA6fu6gl0rR5uNYhaJUnJjqU12udDQn8V+sWerd1Qjsu26CbPwqyRsshR2eWBCHsqtb64HEH7nTHkqMmeSqWvfSR9maLNMM4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=j8G9XshxXuQ3z4G0CyxnUr/kN8yyH553hc7Hx+LArAI=;
 b=JgyHbAxLk3ePGNM1Rj/F0OpW4YeHo3OZia9+Aub2zhdsAHELL7KwSJ+nQFP/Tb1V+4WC4iliyK5bUYQT0LrriC6UDza7y7OdnXKf8TXrWxOmS46HgCJQwJ1Pb3mBl6HLcQe+srNSaWBNFjPG7BoR6pyHSHPw2Ol2CKMvL7qGn9gY0B28GKlR/oztuTJzRsq33ejhOgd40eJAaJXxGD/UZN5ms8EBJRPEHP9FWPtZSBpbFZ8CY8Q38hZZ+R8mI8F3p6l1iULOZHrmm7DLdlg8gTZalUsyON5buPbEST7Kdhrkh1ce+ZAjBj+vHOCEz/mMSMBsZkZYvx6fcEbrI9dKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8G9XshxXuQ3z4G0CyxnUr/kN8yyH553hc7Hx+LArAI=;
 b=XopFC4gMtjv6pBk/Sr9t7M4+K3ebfeGLBwEsJGMevXGldJHRXRm8o5lDt74QYM15qEezJhglo69jsOcgMtOVDj0s4V/TBPu83YhF7cyRgLYs17ZL9jahoehjREzHK6Z+IqhFbAQITutnV/aP4BFHYhZ0KesKg9xanBM4PUu6/98=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:14:43 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:14:43 +0000
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
Subject: [PATCH v6 03/13] KEYS: CA link restriction
Date:   Tue, 14 Sep 2021 17:14:06 -0400
Message-Id: <20210914211416.34096-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:14:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf4ac5e2-c7bc-4158-22aa-08d977c4ac14
X-MS-TrafficTypeDiagnostic: CH0PR10MB4908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB49087100F50C93880327A7FA87DA9@CH0PR10MB4908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKSRkQqLfDEUhDjx82n/W+M85R0By1hxdFSnzVAC0+OYb6ITKyi5woZinYqwvMdmkZDz7t3Co91WpfKrHk0510dx7lMiQWNlVMEI2Zu8SPY1SaJOJEN6gU42YECgH0tpMJu90tdkqUch1zxeiufGVEsH2D04BCTWuKHZFCFviz7p7zkjqPbmGJjUkdLrJI1GJ4ZNf/ZTCJ7uwg+RKmzoFZd/P6ftga4ChVsUGe19fIZv4ECyqZE45fJ2a4rHrvz9ORK0K2CGvlKdr+AiBOVm0djjlU5Sl56JPk/zxXU6aDrYvZ1Cxur8EC8QzE0FAgj/Mv0MwTxZV6Ighjtfl8AUzOPQuOXFLztL2xJmbn4T4rK9pwXwPXegmejjmtcqfkEzW3QkR5uUjAPCAa4HeLAiPrva0c/yFtgy5Rmq2eiIcqCULXCKQ/n+Y47XK6GJMPdBPRNxGqNeeKcReAQi4Xf/E2T1FGDwrij9Igim8/DwG3H+CBr1sbHJ1I04DhljbKgre6xU8pS+6eC9Xw5NTYvL+e3V3h7C2l7hTIOCbnWa9oxcF7lkSSZCCu39XK2RPBXJkKXF34K46DdPMw1PLcggcJeaCcO5TXN4ujTRHaFXCjQut/x6x3YOqwciCvNFdWL7fN2sMtGnoK13AncTFlEft6kOFrhnREoJaqrBt/8Y0LSHkW3104jH8/YkWrMBh5rL938L5HK6JDaHIelPMeOSsTJ7AK4Ks2HMcLbs4oDz+HU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6486002)(4326008)(6666004)(2906002)(44832011)(7416002)(36756003)(66556008)(2616005)(8936002)(66946007)(52116002)(921005)(956004)(478600001)(86362001)(38100700002)(107886003)(38350700002)(26005)(83380400001)(1076003)(8676002)(66476007)(7696005)(5660300002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v2fWhr0U7wQCRHc3nN6Jd/qiTO0v/XoCPYGGhLNcZhYiolEvN6cL4Q7lsEFR?=
 =?us-ascii?Q?YVFimOdgHjn9IwXK490n0HsmouMu8sr/NuWr+JwMsEcTC3CUwHDy5C4oQoOw?=
 =?us-ascii?Q?d+71kcCx7AOlUMQsBwUH19bCQffIOH9TLI6Gn/8vUsGQv48/b4dcAhN27pQp?=
 =?us-ascii?Q?IGFuKegb6YP9LZ5t+J632hUiC5EAY+uXaCQ13Ol7m1VFSXj1w2bZ195Q/FEc?=
 =?us-ascii?Q?Dw7e6hqK9ZHjhE6wvsG1RV8ksmu4t591577M3fGdnzK/FV9gYTUj+7L5P5m3?=
 =?us-ascii?Q?VdeEVhnqTHzrZaLfZ6dgG3yqVyDC02u4n2iWrTpYf1KGmCED2b9mvbSb6yG2?=
 =?us-ascii?Q?9Fefu6z7VpYhd3k5qA+WnVBRCci7uFLj3dCMib0ms1fKkpp1REAk1YYeoQ7u?=
 =?us-ascii?Q?JU/LxQuEf2jUJgx8ACsf7KtfGH6SHkMG1VrwyE8rI3/ylg7idYvqt3UujHVk?=
 =?us-ascii?Q?QUC92WLp5rbfnIfslE88zSi2a0W9Ez2adiEZtYEZKFrg4qxAHWOkZ68Kecuw?=
 =?us-ascii?Q?j2r/LdcRegb0TqJ6UqbyP6NHt0gUEzmhckISd7g+tOTHwQgcjLhMdV2FmY2i?=
 =?us-ascii?Q?1X4dX0LpHvfWk+xfnNvIEjkY7ICH7NIJ8JeVa/zPhNxwqYoP+uM+U3Eb7GWo?=
 =?us-ascii?Q?rJYpL4abUWbbj2SAJFUFlLfFJ2PUrn5IU9L99FshaId0OUtIBEUnQ/pCAVzf?=
 =?us-ascii?Q?jN1G0WxOb3uizhXB59UxARpQuDLi99oDGFm+D6TCkuPUmXmjF4ykSqdmQS42?=
 =?us-ascii?Q?sxi/b/qn5LbKMdhd3fdP9Ws0uXVTOTkGEjStfQYMf3+Fbq3kZZe3VMzgDm45?=
 =?us-ascii?Q?xWdcWxk9dmEzsmU8wFdciuw64P4+mHqylFNL0SAYFQxwoLMuwQrsY/Ie43SE?=
 =?us-ascii?Q?ovQyG56/HlDuleD8AzB4/hlC8QOwKRc/k9a9u7J2tCl/yqeLYg2WL3I7M2Ug?=
 =?us-ascii?Q?ln0TfSrKqb/5bShAHHagXI4cweGw+CgzQn1ra52LK1jV2XpDa3Z45f3D4tIJ?=
 =?us-ascii?Q?nHoj0mZ8o9WkDJfcyg2A1sFGncF6bM4pcXUy5wxXiKil4jeqBzYwiIRBM4mE?=
 =?us-ascii?Q?kTczI7XQ6GEg5htP89pA2KobQjxxrURe+SAmuA24ExiP+iCqY0WWFuN9XjTV?=
 =?us-ascii?Q?gPdk/lkgeNVIluhMBR/rO/1tJjtmkbcDFfQVNHwmnsGmCUjqaDD498NMjCNN?=
 =?us-ascii?Q?fVUBirHuJgpQAT4uhtHy0pNQ8MqexejJ/liFp91MIpSSOSSaIt0SQ0HW2LJl?=
 =?us-ascii?Q?HbwpifwvbC9RbsUIHlxNI2ksUfCm1Zs4mxzkeq4ejI59eVJpimPOB1CGPLD9?=
 =?us-ascii?Q?4cDWzqglIuCVAUDoD7pv3w9t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4ac5e2-c7bc-4158-22aa-08d977c4ac14
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:14:43.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giEDYuFllANQT6mdOD5jdi97XRwL8GunSR3z1DBcqPPBmvrgBPPg1IyRcidgP1uQjj1oeOWmR9E5AQTTYLOKMB6d35y+bNtJJW7z805cFyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-ORIG-GUID: 0_D7h4TWHhAq9_FPTIHAF6Pxs9uf5z7K
X-Proofpoint-GUID: 0_D7h4TWHhAq9_FPTIHAF6Pxs9uf5z7K
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
v6: Unmodified from v3
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
index f603325c0c30..3ef299e2b008 100644
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

