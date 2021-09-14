Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C05A40B9D0
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhINVQg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:16:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54142 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231719AbhINVQe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxRcZ007085;
        Tue, 14 Sep 2021 21:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=7cpTIjx2VS0Bbph/qWEC/ejDM2PwR3QZ7F4aTb/QKdI=;
 b=MNNi+PeXF1otXHYscRghKlbdz0/bZe1MwgTI/EQycV3SvU/aYSwjgVX5y8KUEzeaJxys
 LSCJkivJ3IUa1DXG468fmfpXUr0VWRR+AfNO1Q90y4q9FIDlXjeMRvnYEXxbzpr4DqdI
 BFqZPYl3Sktb3VYpIfJbP2UbGeKCNLDlHQLxH1digsJo/C/iRzLMeFKn6wjFAZgPRlKy
 RjCWe1WUAINz6hqNvFz+tN/DBfeBh1GzVyk9BjeRI0jCVkBJdON7LcNC/+/pIPlxz0SB
 NvSoYuz+UtC2lz6y5CjGEn6bF46pgD+yIRDJvB5IVVag/5S7tWF7xfBpIOEmcuv3BCMY uA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=7cpTIjx2VS0Bbph/qWEC/ejDM2PwR3QZ7F4aTb/QKdI=;
 b=NYaU50EeIyJVpdFkA7KHwpzytAi4HmvIVaEnHHUSHLJOtTc812Wn805o68ufE74wlODr
 c1kEQTXaHcOu1vU5Xn1914nMI/T7RwmocqaDUc8Z/cMFi56LjAEC43xfMznXVnOP0t3V
 ahoCx1TKHwZ3OY7yqzhVfMcHOlJn2yPhg8LgeNOTFuR0cCaBfPkLONnG3DphZ2VEv2kQ
 qmtPEHy2AFd2LM8yTnwCwrCRNH6yP+XAhFqjex3K04JPHQ3A7NsIfAhmxSyX14Sg0vvq
 homsDMRkWCbiSas+SNBMPXwbT1QrTZiErf2wnqOJV5Rv3tek0bPc7o4Sovn9xFxRSpOP cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p4f2xma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELAPAv097292;
        Tue, 14 Sep 2021 21:14:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3020.oracle.com with ESMTP id 3b0m96w3kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl3XKGhTHcJqjrMeAA8mgVSO9OA7dV4K64d8BAcZ7mN0qKiRpw83SdgTXWV/sGmqe/BYY0/Y/p+oX6Bd0giEOgkTTfZmik3o6b7LBX8o5cc0KWgd0w82SACoMErkIiK0uS6qdkAkV3k5HqqnMgjUziN6XF/0cu641S0ABFC0zTBRrqVNtAxLQcA2KfwOL3hGB8dVdvjVh3SteVDyJi2bZPabkEQosZKIV7PMpkIlHKSxYyDamMKMBY2V/zj15XaG5puLR4LspgGiwtcKkCzqaf4o9enNqfkDzGY0j2CpXC6zUt56laOidr9S6uLoGF7Tc5/dmgvsFu1OYqz2U8P3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7cpTIjx2VS0Bbph/qWEC/ejDM2PwR3QZ7F4aTb/QKdI=;
 b=j2mB8X9DKCrBbHvcHwLUfb/LD4CVERQstd6jEl03gEVkFzvm6mAVs4/hWumiK3BQAUTla0p9xDXhl/MJqsnrh2pBW31zsyNL6ux1uQs+tDf1+QWHsv4bUTF1a+xXr2+yP+nWMy/8kS0SsxUqRJJ17ShWBJsZNV3cGX2wGnZ6TQ469eiSzffKkSwenPOfsAW3XoqILleuXYZt1zfzYqK/R4dvfFHHZTLu/yq/CLx59Sqx7e+2l9WOpQYIHkI92YiN6cDURmHwMqTJLcWwx7/9mRJ7x+H6Pj0GlvMMhbcBhk0QRaRaxO8xV/OxALh3y9AaVEkxt6MxTAax58pu8Qi7Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cpTIjx2VS0Bbph/qWEC/ejDM2PwR3QZ7F4aTb/QKdI=;
 b=nha6CMY4dPYBs11+rMHhIISCnoRThFPjCUYujGrR3VZpCcPQZ57E1PMfQmUQttlHlTLVjnX5+OQSYVFosvgBaJMvLFMPjJjeSvsKC6eAL02Z6w88xNggyILSflKjeKAsvRRzNyumhj5EGG95BgrsGhX+9DY0veRj4/L/2jLJ5do=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:14:54 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:14:54 +0000
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
Subject: [PATCH v6 07/13] KEYS: add a reference to machine keyring
Date:   Tue, 14 Sep 2021 17:14:10 -0400
Message-Id: <20210914211416.34096-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:14:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ff1afc7-1c46-4110-b9e6-08d977c4b28f
X-MS-TrafficTypeDiagnostic: CH0PR10MB4908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4908BE6272B9D9DED8C024F887DA9@CH0PR10MB4908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfyuTMCBc+AX+Tx+Jea9nfNGjKPBdB+mwEMlcraB2WwHwRBwEoRWhqYnXdl8dKh1qF1Yh8EKBd3O4SO7nMrRdz7m+G+QA1LM3JVlePVBsFsTOU25W9pMRGgkgYFdTCcmViuNymF/IvGNIh7RrfSIr2TpXxQa0BAumzGpF0orXBkGL1Z528zfV5HU+UTS8VGrRM0kapj8UsF+50un62AGthxZs1pQL1mP6K1YLp7Cu1mzz5FM4Eek9WBgLgmagOMbU5R3ouOW8Z9ZtpaH+2mYzY6DtkEjGadtJyHxZiVUJe+vrKimTyURgqCDP812Oo/K8lkamnbtfTWAbr2grf3y/4FfsCc+rJBywlce1543Z2u8u2MriVwXYYzFP4bglnVz+A7aG/lZtq19xvHcVS5v/TlaZD6ZypmcwWh4Ok/tkH4Z26unxHNFHACgMdJ/KTx7kngzxqkHfStz6nDm01aExSyAFwKAocCn9TZjhtM3RDJBsq4ty7iKgqWoHrjy5fVbtTXRB51+9QyThRxLGC9OmFKBT/5lzq1Wb9bcFtsLFzSYtD+B6Y9xMGsa5i8HoTsUHZZpqWoKUqF2dfgsZMv5gIttri1y1ZhTNbBEabB+Tr1ORb3BggnUWnKH/zsGe3aVkVo93yWofWPxDrdtW3KDKAxZnvtuuqL87pZmr6HIwCMfbRzGvE5jriq+/Juqc9yN8VNipRLtHk67bGv54VDUtH0bLQBcRYqEG5f7P209iUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6486002)(4326008)(6666004)(2906002)(44832011)(7416002)(36756003)(66556008)(2616005)(8936002)(66946007)(52116002)(921005)(956004)(478600001)(86362001)(38100700002)(107886003)(38350700002)(26005)(83380400001)(1076003)(8676002)(66476007)(7696005)(5660300002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lxP4jbm7kEiJsuSwQ/N7mdqMrtDyxvqOp7q41/O4QRIOyWFCSo2VSri2RXak?=
 =?us-ascii?Q?YkAB9RSFRE3Zojuus4miJg7rGCs4F/ULqj5GiDQFLgapai8XDtuVsOfgKkMq?=
 =?us-ascii?Q?oVRyKGitNVecVgjtNYAAJYOp4m81gPzQTB1cCzOvW+sH1d1GYDWZhqLRpvrb?=
 =?us-ascii?Q?d+dE8KU6QORd+07p+9rX3XpgEgLwbL29hKh8CivAa74NAbqkTxrLOLokhyuJ?=
 =?us-ascii?Q?7LtqXZWbOgkInJ0eL90Nz1bfur4JMK3B+0LbdP2ps4uL2c2SBa1MV72iHlyC?=
 =?us-ascii?Q?SkXdq3nfQNpi4YMzpdQ0RsyphuXOMJI4fIwO3cMhW6JnH2eD81HRf4GCIp6H?=
 =?us-ascii?Q?irsHoVibSu2Bj4zNkYcBhVhg9tUqrqqGMUUKc1l8/11mksoP8L4JPhH5YOSw?=
 =?us-ascii?Q?afZyN1X0o6qEopteBHp1a+TenOZWL+Exd1nnFx3MCgBrLTcUZcCIZxhWIKrO?=
 =?us-ascii?Q?XJwo8VKsGPusIsdiU+EL0fsT6eO4hMNX32miHeaGPVMAPlkiqT39KQRczVN6?=
 =?us-ascii?Q?K8pDpk5XBUm/Di3DpLoshatKP8Cp5LN9DuOugUXV94s5ELtW0s9CMhKnPVZF?=
 =?us-ascii?Q?0hI6qSd1JkNf91sKIbMpZGe5XX/XCHl1xMyQJpUqh8DFDCbTq3GUyM6k7Ndc?=
 =?us-ascii?Q?UyMwBebgLu7vN9UDEn8ZmvQ5P4uAe53LTNksDTe+CoNGa5BQZEOf6vaRjLXK?=
 =?us-ascii?Q?q84RfcSlX3jiMOU2SVXTOXFBemu9Eh6IcwtNVeW69RruqAPYbjS12P7wc6aS?=
 =?us-ascii?Q?APICbYsttYHtsE0NrLD5yVhX07RNscoRFWlh6R1UkiKITrTffQyucesg2zhs?=
 =?us-ascii?Q?OAtrkBzAu8D/cFVrazH5jKF5G4gMF34kuu/zbKLfnIZtR22XO21KvQT+KVF+?=
 =?us-ascii?Q?LCEGXbVNC/QN/NR2vhtxfWsGuoeR9F/4bm0TwFVZXqiWWqGuhKyxwrdZQlh8?=
 =?us-ascii?Q?jQ0X9isqvInMVQ+YOKmrCaJV21BNul5SiHLAR+JcOea/drhjU+DE7KmL0iCf?=
 =?us-ascii?Q?xGLP9oZdNYYEfzf9MH1T8pWjGBNm1Ylc4wh09R2RIwUC5O0KzNZ7w+u6VxyW?=
 =?us-ascii?Q?oiag6XJhm0PxaO4Kdb1lCNW0Xc0WW1w6+IilrMTr8A0tHfOExPHVfi2Oqhtq?=
 =?us-ascii?Q?YGlyO1rGMbhzHCrRj+ndOioczsc4cdsxcoQ/2LTcICJFFYORsp1JFIDE2DcP?=
 =?us-ascii?Q?ZvJdB/1BUGdv2QvD/rX3A6F+95hA2pXyY5WmsR0s0/gOkUCIaTz4DmSwplAz?=
 =?us-ascii?Q?GJZDTYmcJ3CFrp3l+zkH+mCBAdjpAmCpmfy8EUIrP+nPRpUu5PgRp/5CVNkP?=
 =?us-ascii?Q?+V7ge93n5cwKFDnClWfTgEAc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff1afc7-1c46-4110-b9e6-08d977c4b28f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:14:54.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6755DgvGZON3VxXHE04afGGXDC0tAiLKszGJKUQzMrr1BiwPSW4ll1WkakIceFbj2Il1VH/E+3U9mVsbbNOnG356Aqc30qRnaxE8UtdUy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-GUID: yZ5bpTuo6L9zgb_CZ8CxV29SUeJaqxfQ
X-Proofpoint-ORIG-GUID: yZ5bpTuo6L9zgb_CZ8CxV29SUeJaqxfQ
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Expose the .machine keyring created in integrity code by adding
a reference.  This makes the machine keyring accessible for keyring
restrictions in the future.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: set_mok_trusted_keys only available when secondary is enabled
v4: Moved code under CONFIG_INTEGRITY_MOK_KEYRING
v5: Rename to machine keyring
v6: Unmodified from v5
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 8f1f87579819..bc7e44fc82c2 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -22,6 +22,9 @@ static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
 #endif
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+static struct key *machine_trusted_keys;
+#endif
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 static struct key *platform_trusted_keys;
 #endif
@@ -91,6 +94,12 @@ static __init struct key_restriction *get_secondary_restriction(void)
 	return restriction;
 }
 #endif
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+void __init set_machine_trusted_keys(struct key *keyring)
+{
+	machine_trusted_keys = keyring;
+}
+#endif
 
 /*
  * Create the trusted keyrings
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 6acd3cf13a18..98c9b10cdc17 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -38,6 +38,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
 
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+extern void __init set_machine_trusted_keys(struct key *keyring);
+#else
+static inline void __init set_machine_trusted_keys(struct key *keyring)
+{
+}
+#endif
+
 extern struct pkcs7_message *pkcs7;
 #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
 extern int mark_hash_blacklisted(const char *hash);
-- 
2.18.4

