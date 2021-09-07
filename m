Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FE7402C60
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbhIGQDd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:03:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43290 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234105AbhIGQDW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:22 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187EfWEM026869;
        Tue, 7 Sep 2021 16:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=omenrnPyFJzuQboJ4WQa5weKYz62J1YI2OE3yir5u24=;
 b=rY/uT/BRjMDWr88SRvweL4kILWzxYZOHOB8VFQIEOkx3DzbWL57FXzESBWdUepLSvImL
 ZDeBstJglcPbHkU8ZMU6WfycxcYUNMJXgtqYsODrLL1//0SgaAkems7/WSOHjFtfzFoK
 JXT9GOton1QbSXw0FYKZWM9LNCW+z0MGf30XSjbuLGQBgQB43+M2KachAhEISKgZtmO5
 p8L9TFQNECUU5LvZoIXFCQeskA/on7pYFXXKh4Na5jON/Insj/6CMMVQJKBa3fbDFyvx
 J8Rx/qmFLLEmDO73LPJAjxzxEXrnFillNxvzpTFfsZGPIKg9N1AdH76P8g1OMsJbjn9j Pg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=omenrnPyFJzuQboJ4WQa5weKYz62J1YI2OE3yir5u24=;
 b=qvnJwZ2Y+nQW8LHEwvNXjXY/a9op4wYEndAhE9nkneOzF6ptuY0ynQ29KjJ7fr/61vZ2
 pNSpVNCR/LYtfgp0uJSNtKw841+wypw4gtm6EVdHFgczvuREDJBJQk9AcYD4/4yqzPUQ
 zX3tDOaxqNEC8IHgNECyBIQUu+y1zSKC4tqqvzYKKp+S+CYpvYun/XbOuaaaSUXYKk0N
 9TCeFGSh65sLqJ214/iCxySdC3oGJ+c4XQ+o4X48tWHnIoiG07ChVVIW/Xl3oOJM7Tnf
 09r3k6l1+s66RWy+WuoX1d1hQXNcs4Z5MT0cvOi2nIfvjhaFNJyiSB2WMtQj84+dUaOQ 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq29jg1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G0nCD157575;
        Tue, 7 Sep 2021 16:01:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 3auwwx4744-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOaM80Y00Od6ZCmv+S9zW4DRl6pHL4ynAcpMvOaynIeMNi6kVqy+ochhsFhXMDIgevMDQOGKu9LDkMZmtrJHPxOC0sp4Wu0KKAdHWV+fDLJ295l/zhplH5JkiN/uRWPxN194HTDt22duCQZ1NYSE/fw2Czfhs7KPDhTUaugU5IrDpVWNmn1i/f9k0H0r75HARuJMhUPRrW5plFPIF5nnBaJnHnY2ApcR5I+H2oE8PIWgCiAq/9hEr1pT10OTIXTS4aOKIww00MBxP0YmL8lxEoBBhlR2RqjnytNQoLch13mshDoVlpAkW2r0telwD8IL1El4y/tmz7ZULXStuNtCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=omenrnPyFJzuQboJ4WQa5weKYz62J1YI2OE3yir5u24=;
 b=i1NXGAOSNU6GypJhJEajgFSIiFbzDdCU4WpkPIkJajpNp6HqyQEinvpy29uU4EiMmQ4D9GVDBnh4fdb+yCHjv4NWUE6xBv2DAcA0nC0+R15BC67x2cYj8RR+hCURPLcORNGTnVYkDO0WMIKiAGzkPJ04QclLFggE/Kv8CvySrWhEoVyN4WEW4l1wCYT7b1h3zfLp5kVEn7n1XpXgHZCFNV6l9Jza/fHGNXk2trn1OeItdKdTkDAhQZbaeh+YvVfrxw2hnvOm6bquiNDhSM27J54VblTwKjcsauEhicrq+FBNIRSI1uN2f3QDhiSz8ATNNUXHmrQ5/wIiEDP7EB7sgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omenrnPyFJzuQboJ4WQa5weKYz62J1YI2OE3yir5u24=;
 b=YV0dmFnnfgFblI5hCmnvH9FikVyO6mhp317vicmdNavLZkn+48IbPKcq683ojtWsHntGtQ9vYEDlBhWonUogO9e9GdY5xKN9pIQO30uXWvZYikGtxk/BN/7dZGu+HUjpzYj13zv9wnVNEYt2bh6cbl5PmWrQavj5xzdewzamXZo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 16:01:32 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:32 +0000
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
Subject: [PATCH v5 03/12] KEYS: CA link restriction
Date:   Tue,  7 Sep 2021 12:01:01 -0400
Message-Id: <20210907160110.2699645-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 955692e5-70c7-4993-46cc-08d97218c29c
X-MS-TrafficTypeDiagnostic: CH0PR10MB5004:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5004E843B5B91F728C7FD82587D39@CH0PR10MB5004.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2oyBnaENnsk6Jr4xgUuI+2odtrfV5HmUqN0g46eB1twYxi1FYDnGiIfrQqEN+pdaIRVrlkYRmZBMFiOUFwbttVHXXpspaqVYbtYNw9z4EMmRD8LOR2jiITDPZUhhxvZN4SzIEQkbei8EgYguYSMEYC3eBbDEfSik7ntqXLJlZt81Vc/EmGTb8HkXdvmWm+KmHCduwDvqlonh5beAlnjjkDPE01WVaeSCN4A+neaGmGgmAKj3kAoZm102SkuPdZTlLJdKsAVc2mXi+2S9se9qe+pMr5Gbb1bS4+DcAyvajf4FOCxfwc2LmbNiIvZ+Ew3ybQfurpQkvs5tYSL12H0khoGFwPih30+jJiRCBGIirpmDM93bEbBzkoyC/YnB3Wm9G/5g58Q+bCCeCszYA8ZZdhJi+c3bTk7I8fcWOwfWNsyQfppzNBlYGKA9YHc+KcG0iR1hKZ41I6PgdaYpL2V1xR12fPq+ZxMz9jyw6xVFWVEnFJED59DEvWphc7MK01nFqqQsHNZXQWVIyleO0Ff1tG2YsMfnJ8PrepfwnFn2WQwnkj/jFNB+AUThnQjdlSciv4PQmLd4n1r0ZqW9+DYNbHDgT4YhZ7/EQBYL/Q7kyEMBpqDIAFPjRS5WRkpSO6BiTR0v6ajMPvoRo585s62omqC46aw11cJ8lDOcymhO21nGLWc1MmKt5c0Pfzt+8HNoyQAINaw/16VmFS1KHB8LEldr0C3MZFPuB6WJSa/vQns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(1076003)(66556008)(66946007)(508600001)(66476007)(8676002)(921005)(8936002)(44832011)(5660300002)(186003)(26005)(52116002)(4326008)(7416002)(83380400001)(107886003)(7696005)(36756003)(86362001)(316002)(2906002)(956004)(2616005)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qKBgfiHmz2ZAdTQ+WCO7vhnZxHAX16EbdgNxrH28Xn8sLKmLqyLgLGwdTnEp?=
 =?us-ascii?Q?bDL2wqTUxS69+vChO3QjOr+t33ZbIjZg+S1SX/uMl50f8Z176v4oCMr+EN+P?=
 =?us-ascii?Q?5Sv9vI47dZ/Vhxt3chzkaDDQ7b/gpzD0g4Vw5EsV6Scki1ln+hH/NsuTLv/k?=
 =?us-ascii?Q?0EjDWI97S1gLjFdZvx8f40cDv99+1h7dh5NpnvfijaivzqQw0fDu82ncktkI?=
 =?us-ascii?Q?CRH1twd5TPUED2JTt8/0RpavLEW/hY/h5n7FE50PDKKAE0Xo/KsE2Vzteh8D?=
 =?us-ascii?Q?YEC4pZD1ACQfR8kN95ddj1P4hRaie6TmuURikf6EtBGsBOjblsXjx2Z/6yeT?=
 =?us-ascii?Q?3pNgHZwRz04ZDMreE5xDXKJTBIssoc9eN2hMwwid6eUz8QctoBTHUa0b02uO?=
 =?us-ascii?Q?lOPT0nXETrw9Pho8h/nqcPUuvcNaF9pLkDGM+Im9X0ph8IrRjaEqD+aQSINr?=
 =?us-ascii?Q?ApNxm957HWNG0Ams82CnkIuujM2TDs98/07w/ToQ8EMIAbvn24JwKtIyjvqv?=
 =?us-ascii?Q?qHxtqBOEfW4jBYriFmhtLyGiDvfMMRo91FxFlLBLfWI4g+Llk7IKc64SPe8f?=
 =?us-ascii?Q?pVMB54YpIy9JA01bRuWT3A2Y6tAO5MJNxWExSivd8rWeM/WPcI1+1nSjXM90?=
 =?us-ascii?Q?F9LGkAXr8HmjbmJxdnBO52x4kz9ZDpSffWgBB8xjJYZdeKB1Qd/Va/mGC399?=
 =?us-ascii?Q?vjCqEnh4WchSDWSyuYY5k2ZHTk4HKE5sf8Z/m6oUejMWcZRn09/YE/a2iQOl?=
 =?us-ascii?Q?ldtTMP/3ryP4UKmFmiXPFC50jXRHnpmwjkRUJSKYW8ub3bFg2kUIChu4IjWp?=
 =?us-ascii?Q?/GTAj2o5vIW6zk/Zg+TbMIsvZ2bKLp/7p2yQQK0snhJZvrzTXQpVeaZ8PzBh?=
 =?us-ascii?Q?afiN9mFH9gWXDfAoiS0e9S+Bfh68ryEIrBiqP6aHjxpXJ7gCCP9wDGfYsL6p?=
 =?us-ascii?Q?6m9yEB4QYGgHM9+Z8krZvuyzo2yOBbUaWLQ3rtGzPPagB+THSAVGKKWKiAXc?=
 =?us-ascii?Q?Ai0dnXlYI47sMgzVOTiONC5VsqEbwcFt4wVNvid55Z64UgWwPJHJISQiqntt?=
 =?us-ascii?Q?3OpT+vv/y/6dFHo5PnnJodRN82knPJCuyyeL2nFwh0xjPT9eO2BS/cU7Zb9+?=
 =?us-ascii?Q?mdFfop9x/n6kGMgmh9AMCiXJC/kZETJLdUHxOITkIDHWetdOruLEWjGYnRrm?=
 =?us-ascii?Q?qc5+mOnnn7whjtANvVyz8or2cc7w6lxJjIXwgyzZKY+rySSjq3lxbABmSppe?=
 =?us-ascii?Q?KaSQyqo/d17nbckj4IE3YwOzDZagnA8KALOpHrUcJrU4zBgYF+wyeHPmbgpl?=
 =?us-ascii?Q?Eu3csAs2mAP4H5RXk24DhNJu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955692e5-70c7-4993-46cc-08d97218c29c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:32.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaNAOGqJuXkfuctgpKZ27ovMEFeek7CHl8+UbCUPv7+D3fjkdApEoaqgVCBznyefjfBzipkXHXLm8mAiLIgZ46TjmWqfeUsnRBXv59w+hlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070105
X-Proofpoint-ORIG-GUID: yfEk3tI65pfSErNx9UQmWvqt6AxVjphE
X-Proofpoint-GUID: yfEk3tI65pfSErNx9UQmWvqt6AxVjphE
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
v5: Unmodified from v3
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

