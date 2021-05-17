Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB888386D5F
	for <lists+linux-integrity@lfdr.de>; Tue, 18 May 2021 00:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbhEQW77 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 May 2021 18:59:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29180 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238925AbhEQW76 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 May 2021 18:59:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HMpu9C001415;
        Mon, 17 May 2021 22:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=X3EFLaNvYo8QfsbeFJooyEAUPjmIFFwRDgcPtI1a/gw=;
 b=zljxyK+nJQYi4kXzoXzWC4Uxh5cNFufhwiUHMZ8Snngn0kTyf+HCE853bi0V5+1v1cBM
 XSyPEou0TNFB84mU5ohhluYJ+I2j+TzVoYivxugYnJ3fa05lLzTAhEHyW5QlkVkoq25p
 psRM0vvKR079xmgmxqTXYb8eSJt4S9RLu+kilwVdO90SwO29h4zqvuqcHaRanKnGEIWD
 vRJQXDJwSSNlMVi873cz4/xa04+K+1rNQkWzi99SoZqB0ZHgYKYBDLmB8ECsIlVhevMI
 yifc5BatrNZmZwFopl0JmDLnRQ6DqIE2VIELdtXuWgVpnNN70JKTTd0iGjpt+dsIwslQ kw== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kfhwgdcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 22:57:52 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14HMvpId154682;
        Mon, 17 May 2021 22:57:51 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by userp3030.oracle.com with ESMTP id 38j3dtss8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 22:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5KPTX+KxuGxLrhtCGBqHd/5kuWpHdWDY6AeybQy/Sssr9yp2zlR7O1wLdPdHPF3lvBf7PtQV9OLn8QAJN+KNQ2+ztFsVflr7lzevdfHIkaAMVaY7WM7JshWNDh7uvLbz8wsqV3cBnpE6k2EOcXXkApgQDhIr2qnAmsUfKtRn980KkknopajAR8epIkv5EePpVaqL6sntofclBkO7gSzeF+sbduLAfojepo8LYyiY6Hy4bxrbddyuGHEzCp6QdaxYnHai36kBIiCMtTtL2+RMw9P0FBsMnkxHUP40zlHyJxSe6X3xWerojMd7G4wab66xcVTKo0LB7OUorwnunZVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3EFLaNvYo8QfsbeFJooyEAUPjmIFFwRDgcPtI1a/gw=;
 b=CVECunaj5Gwun2kecYX5d+96PQkm32X50u8YDYo4uN84UNyX3iWnGiPO7HHdmsDhbfl2bksyfGOLcuUKsFB5NUfSegAzxOPW9JjSb/1ycjZUmXn6JchnbCfVwVGr3QuLUO5ptZfg67H0KDzvIjfbetuaoXh0RHTQbt4VjRAjBY6Q8PJdAlvBjUZWhnBy6asxzQ8O5wTu0AsPqQU6UCSTrSVLoFIvYreM7ewN5SWacdE6RU+zoMRJ/xeiQ9Ormo8A3D6WjX1mGeUP7YBSOqj+t9+3yE0QgA2eg2vpgF00enUPdjVgKcLy7laO2iT0gp8sR8CfC4FwBA4Q2BeEZvZqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3EFLaNvYo8QfsbeFJooyEAUPjmIFFwRDgcPtI1a/gw=;
 b=bosktPpbZ/yFVGP+T5tjZrLCBiJa+tXyKVAgMqW9i2WPGMXwrM6Try5w8CVoZ4fSnMmFBBIbVHy1lwYkvgK6haU5MuDRr6+49su6XSviyWY3oGbO6NL2tyvazfLe3ixoa2l17S+bYdJVte7K4WYqBLMgXnPTnUoYz4nY2mGsaOw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4328.namprd10.prod.outlook.com (2603:10b6:610:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 22:57:48 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::99fc:aabb:5cff:b177]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::99fc:aabb:5cff:b177%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 22:57:48 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        jmorris@namei.org, jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        torvalds@linux-foundation.org, serge@hallyn.com,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com
Subject: [RFC PATCH 1/3] keys: Add ability to trust the platform keyring
Date:   Mon, 17 May 2021 18:57:12 -0400
Message-Id: <20210517225714.498032-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210517225714.498032-1-eric.snowberg@oracle.com>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-Originating-IP: [148.87.23.5]
X-ClientProxiedBy: SN6PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:805:ca::36) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SN6PR16CA0059.namprd16.prod.outlook.com (2603:10b6:805:ca::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 22:57:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54bb2b3b-edcd-4c26-0372-08d919873136
X-MS-TrafficTypeDiagnostic: CH2PR10MB4328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB43282A4266C5139DB84E9159872D9@CH2PR10MB4328.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAewt9ICMRqTRM4ivndaatqjxEOmKwNp00tyPW5RUfxkMAq8w0yDBZo6cjzVlDAkeWGJYfCqJDJV42RhvLyPvgY1kgnZoHWDbEsco9/BNkrgbACZM0P/YqvQzPUTEuwaGLPbB46dD37fKi4dh+3VPDZe0Dgm6go824G+9rWDx81FERuLQw0IdKp7cGG1fV9kXcBBs2BCA4SVLdNHd0PPIK/W1sqq4IKvqjFBMdmv3yu50SzRphS16HEU6vAtBEf9Gff+MdgAPl2C6nwJCj+ASN3weM1TyzMkIeR1up04mBsA+9yM6JUuhIe/crsjd3fxd4cfhTHUmqfj4DxFiujidJYvA3bC6X0oy71ABt/MjbKhQJ77y6nGr+0dU0s6Kc573X9HxcvEX60VWj5Ij+Mw4S3GO+lyWBTfG8/Mw5ACwo8GAPeM4GZ9ZixsMTxUsz+QctkMarP9YvX07nqBYQxxGnp2HaVDt9La1kaRb5gMA08HqZUAJSAu1owhUef7rnMsFH22O7B0G4RVFd70NJOXUZOEpF28QPZ0NJ5gc3QZ4MLuyTAgY0QCIi4W/WE4hWAx33Bo3J+fiQ18cRnlCeVNTtaTeMDUyeJ6705QOyfVTnsutdozwY8j2+cVpaQx4Ch36porcqHH9pfo1xzIKSy6bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(52116002)(7696005)(66476007)(5660300002)(66556008)(316002)(36756003)(66946007)(86362001)(6666004)(8936002)(6486002)(38100700002)(2906002)(44832011)(38350700002)(26005)(186003)(4326008)(83380400001)(8676002)(1076003)(956004)(7416002)(2616005)(16526019)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6r29TcQW3LHBGPZs9OX7jl8553RWcrobxwDKv4cRmvN9d/jwTsrMBJm+MEIw?=
 =?us-ascii?Q?iqkjdq/4/rN8rueaXBBA1P47nc6s74uEU+QB1AcC3PgEik8W5u+a2P+1s+2W?=
 =?us-ascii?Q?e6ZvCrTxoSv8QmMFuU4bTXTgiFI+Lrbvf8UFFKxGm+cIGMN0Zhe2nFtDyPzK?=
 =?us-ascii?Q?9xOQZF3KPg0duljlMKP3zofgYjZ9LmG3bhoYJ07J59/1nlsjFc3U3IIEdXKZ?=
 =?us-ascii?Q?9LStIcjBhkH+58OOUkvM44KTEieRQ9ARY7bqR+Ub1RqRgKgLk5CcWaW+pzmw?=
 =?us-ascii?Q?6sWrt9MeJCiBM+gZg7kEZMb6IFbKmn3TXELCVapqn8x/jsPlba3J8vrzUMEm?=
 =?us-ascii?Q?+Pl/NKz+5LcNJN40XzAo+B+K6VrFRPFvFHka+gRgcEhnXVPMysZNQAVKPvle?=
 =?us-ascii?Q?RpqGdXb7kRvxZUqQXC2rdO45EPTjXuYbefzZk1OQtaHsezmAFTdw+PVbF5XN?=
 =?us-ascii?Q?zh34gsP9n897PEe+UaFiPklLDI7WCXpgOh0zGPevzEzEH2YjSwnz9eJcgaAF?=
 =?us-ascii?Q?m74qZjhGNVHNuj/J1cGHvqejucjLqOqi8WIJzPgB4VNKOr8SqtY6iRW8TiOr?=
 =?us-ascii?Q?DU9fZuwGzOYe0MZPC4dihlvv08iFPa1dJ/RE7iQjYmH02XD25UfpCU7yPDl0?=
 =?us-ascii?Q?uJNItrgFh5tBmrYm4spl73BCzz5buWQW9GdAES95obHrk0epKl5vamxrbvku?=
 =?us-ascii?Q?dpQRSjDCk1f5qyCI4jxNDEhVJ5BzjQ8OAj4/+l0halnuUfEO9EGh3q5+X3c4?=
 =?us-ascii?Q?iLjZ/BNAaMWTJQDOTQ9Z3tD1WjkwkMXGn61JTryM50MZNSbd9wRAbse6Yk0Z?=
 =?us-ascii?Q?JUR+/4SZpN4aslfSRSNsVSVZCMgQCdK57nyCtVrBD7qZsIWCfdOGRIwWq8hl?=
 =?us-ascii?Q?ZU1AKYbB63Fng3jLg4I68yghWsB4mPKh7EbTJnonsdCqms76KPykzygLRi76?=
 =?us-ascii?Q?VCuWGdLJvmwE+yvoA7m0UvTpqPL99U2v+6siLtJgeTs+JhDiCccJ/BMQzy1I?=
 =?us-ascii?Q?xBzsCMfKzf5LXdiDzEO7PXABhbGrwvp/aiD+OWVQWvnXrSc6XRW7mytXNntk?=
 =?us-ascii?Q?LNKTHbvubFmTv0MgQ1cMJiY1TGxcIo9002hYcDy0DquwmoH41GC4vHwI+siq?=
 =?us-ascii?Q?ZaHvS3MSLiOKYth+xngA+lrSjHoBVZgix306tEs4OBRlyBJpdfi4MmBJfaUX?=
 =?us-ascii?Q?VNgDVWmq8lwKur4EqfqSvNdzbwelGudySAeQr4SIwcT01rxy+8raSzdsNWgc?=
 =?us-ascii?Q?inGix9pmmKGgEODxXg+G2a3gkbTdZukhKza7P4WCZZZH3Wbcru6OaINpIcax?=
 =?us-ascii?Q?QGMwO55VS/VKY4EGJ59vowxx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bb2b3b-edcd-4c26-0372-08d919873136
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 22:57:48.8091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4OIpW1Ypx+hbUzcAaewbD+ADTaXp0lWypDD+2cst4nUcBLK67eSCI2YukEyHCZEcOGTaYbnCS08HzWXpKeMWv2JOiIKCpW7fGb6XpLAGxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4328
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170162
X-Proofpoint-GUID: OXTfydTxz0CR-lxSkZdtOyM1gtw7WYYj
X-Proofpoint-ORIG-GUID: OXTfydTxz0CR-lxSkZdtOyM1gtw7WYYj
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add the ability to allow the secondary_trusted keyring to trust
keys in the platform keyring. This is done by doing a key_link
of the platform_trusted_keys to the secondary_trusted_keys.
After they are linked, the platform_trusted_keys can be used for
validation instead of the secondary_trusted_keys if the user
chooses. This functionality will be used in a follow on patch.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c        | 19 ++++++++++++++++++-
 include/keys/system_keyring.h | 10 ++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 4b693da488f1..471eb13e3cca 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -23,6 +23,7 @@ static struct key *secondary_trusted_keys;
 #endif
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 static struct key *platform_trusted_keys;
+bool  secondary_trusts_platform;
 #endif
 
 extern __initconst const u8 system_certificate_list[];
@@ -67,6 +68,10 @@ int restrict_link_by_builtin_and_secondary_trusted(
 		/* Allow the builtin keyring to be added to the secondary */
 		return 0;
 
+	if (IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING) && secondary_trusts_platform)
+		return restrict_link_by_signature(dest_keyring, type, payload,
+						  platform_trusted_keys);
+
 	return restrict_link_by_signature(dest_keyring, type, payload,
 					  secondary_trusted_keys);
 }
@@ -227,7 +232,11 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 		trusted_keys = builtin_trusted_keys;
 	} else if (trusted_keys == VERIFY_USE_SECONDARY_KEYRING) {
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
-		trusted_keys = secondary_trusted_keys;
+		if (IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING) &&
+		   secondary_trusts_platform)
+			trusted_keys = platform_trusted_keys;
+		else
+			trusted_keys = secondary_trusted_keys;
 #else
 		trusted_keys = builtin_trusted_keys;
 #endif
@@ -312,4 +321,12 @@ void __init set_platform_trusted_keys(struct key *keyring)
 {
 	platform_trusted_keys = keyring;
 }
+
+void __init set_trust_platform_keys(void)
+{
+	secondary_trusts_platform = true;
+
+	if (key_link(platform_trusted_keys, secondary_trusted_keys) < 0)
+		panic("Can't link trusted keyrings\n");
+}
 #endif
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index fb8b07daa9d1..ffa5f0173ba8 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -72,4 +72,14 @@ static inline void set_platform_trusted_keys(struct key *keyring)
 }
 #endif
 
+#if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING) && \
+	defined(CONFIG_SYSTEM_TRUSTED_KEYRING) && \
+	defined(CONFIG_SECONDARY_TRUSTED_KEYRING)
+extern void __init set_trust_platform_keys(void);
+#else
+static inline void __init set_trust_platform_keys(void)
+{
+}
+#endif
+
 #endif /* _KEYS_SYSTEM_KEYRING_H */
-- 
2.18.4

