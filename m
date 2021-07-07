Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DACC3BE0F9
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGGCrx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:47:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59838 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhGGCrw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:52 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672aKj7004673;
        Wed, 7 Jul 2021 02:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=zHV6mIOdL0wBvrgQOW8vMNFAB8zdE3I/osIowexbogU=;
 b=nW4aK3GUP382Wr3b5VoGn/3JiX+UF1jdEJ8cNrpydfTxiQ0k3pjVuDmlArXOdec2rQjC
 a3Rp19tKNE3rZD8jyPu1yij7K/I9g7D2vn7gr7qpYkmHbU7W1v6CDCNeQnDEhBqtJsiL
 7/ZIV6rZhTIu25PEhsGmyAGFXDvM52J2yp+RnvEJkh/ZPAg9bTmweKL06Bvei6ZahD39
 CgOvK51AhsclrYvYxFbAsWoxKUw9bjtI9fsU5I3v7UruHFZs3WPu37eVlqAvVcco7hfh
 xJzccyvWrjWAKHP0oL3N2fQWDPO77X8LTaitXQbEby0dIiOFc2YvHEzKXbxrmqJ43C3M sA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m3mhb2ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672aUVJ193064;
        Wed, 7 Jul 2021 02:44:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 39jdxjaahd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUInn5ecEygorVzm2KJQ3Q5v78w3n9Y7EIBMf2VaEy2TC63UkP1qULQC0Zbs+HFMR7GoBs3wVUdcc0tb2hN5brCcdkcOgVjnVT0gcXZKEq7XEdByFBMoVRqAzh74ScWmOcJ/fmmiNi8q+qzl+COoQ4iX9HWlTeYN+InjZatJZA0KFe6DavenUKKrsropHDlQn81SgnXbWcTPrFCeG9ks0QWz9SvzITxmfyal7JZlecLSQPih744FmApjrJlc0KEqa5uWOUnV8U0q43Psnk8J/QlsRYXEKfU2UxgXP4H/SagRlm7CfuhpkLJuZb2hszbnwuXO4Bw9LJmI6/gKMRJROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHV6mIOdL0wBvrgQOW8vMNFAB8zdE3I/osIowexbogU=;
 b=UjC8N7KU/SlAn9a0ZlLF4h6s57Putqk3x9W8/ZkzZrPiwoqhuW9L3+cRhRRmu3yx6y/pm1wzPgkCF+43flDLyyF90smHt5TcHLfOybkpVfmGVc8a1wPIHhESeNH7Tr6M/HtEwjZdNFsb9UEJxuWpqhgT33+6Xhke0IU3o89JWCotSXLK9Gvp/JZwcNZ4mnKXnNIdPAEXG8nN2bhLb9mSHxHfBcaTdKgN3VFyveFr14V8shMUkXdudDHIXUkfZvE5N5IERcXx4fMx31nzveREV1a+0K0J8LXmUXEFrVoDT00749GbvCVdnYHnB81GKtnPrByh3HXDEy18v0WvK0votg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHV6mIOdL0wBvrgQOW8vMNFAB8zdE3I/osIowexbogU=;
 b=arPQO0jL0TqLUk/9LWtm3AFzvEU6qiSb1JHt8J8pqDDf9LJbWeMexVcGMaI5lfkyfNnfmcDVOjQP6JkdOLecig52b0q0tzt+HR/NNhW7CAHOw6ZyGGrHqho6PR2xeRIaT/8/z932UlijDahxsYmZSlTgYrbh/ofqLEzMpFNKs2A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Wed, 7 Jul
 2021 02:44:28 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:28 +0000
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
Subject: [PATCH RFC 02/12] KEYS: Allow unrestricted keys to be moved to the secondary keyring
Date:   Tue,  6 Jul 2021 22:43:53 -0400
Message-Id: <20210707024403.1083977-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4f55a56-db4a-481d-500b-08d940f123c9
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3863936205222E0FBD685D37871A9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SByp2sc3Pk6id8t38p8I6eeu0TsN+OgIvSQ+ZN71f5FBnO32jb75ZBcroMxSVG7MMGoGSnxxQN0YXkintDgh76d6lGSUpxw/1OAWYtTaCQ8kObeDswEQZz4xhF+uX9o03/ZQ4FS9iuHsDrWFG+tATKT0JXEks6lckt5glEv67WfCoUr6dZZ6/9Ksdox8H6LuKyqjHy8Sx25V4Z9iNzMoges34xxVqpABVqVVj6d85o21XDo7oaAKZ9Z9DVhgDZ425QVYf+Zy49i/frWse+b1RKY69PDf0Av8uTxt31r9NSd3tVuShn7vWojbniPPbS9d60nM3wNyGevGx6VUg00XfWihy6g/t25nsJHIgJarpeb03VpcjZq42Y1P9XDxXSMq4LnHZZ1QkxD4OhIHu0csaDxw9EEZ9N3SQWQgBagwd8kF52T8YXtYn9n1hLOSS0CQMM3j8Qzg6/mX+hXPCPUtc2M0ft78H3TPdFlRTdQNF2+aFEjJtGy0S6OBTB5VOMadJ4Ymbd5xdj02oUDCDBTnvDYAkFtFYQJVcre0hk7Zi8J0EocZv5AuNV+voU1EoOWEmA+mhQBSaWEaBoilpQu90/Cvgkc+brxHO28TNZBsLY4fEbbPwiqqmYl11QDPvTuBDsr/WxaY56IIVKwOG2MtUFthIYGZVOgB4XtlmCVAk6Tgs21b/WfzaFq1hkbl3nsHLBUFXbZOEKE06oWcoFNQEPfQBBDT/kUfydUIUH5YEyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(921005)(107886003)(6486002)(7696005)(316002)(66946007)(1076003)(44832011)(86362001)(38350700002)(6666004)(36756003)(83380400001)(186003)(4326008)(956004)(26005)(7416002)(8676002)(52116002)(2906002)(38100700002)(2616005)(8936002)(66476007)(5660300002)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qzKPd+2GL7/0APMSH4Z/DojXVOamHwErvRtggDgmBPb/jSW2eBFQaUjzhG+7?=
 =?us-ascii?Q?chEUMpAVf3nLC4MRn/ZYp/1B3fIggw2CYtRRmKWudsxsM/U/3Jl6ZfO+FuOv?=
 =?us-ascii?Q?Fz+7sdT1Ycf0uj653ETeeIHMgHLCCv5TIbwRNHHHLjoM0cCpcWWKACdPkFMv?=
 =?us-ascii?Q?bC9sCPnZ9LWF0sOqV9305lqvOW4AwJUI/XIpFfQg+CCnnQxWorNh9L1NEVdd?=
 =?us-ascii?Q?o6JznpnzkYbNsc0Wh8iZ//Td7X9xxAE2U2+R8E4YXmbYh9gy2QavFAnUu2OW?=
 =?us-ascii?Q?f1yzxwGDCHRvrHjvoVlbRiC4+c+CFF8xGZe1BKO5PIL87bNeyBY0sW0rzS9l?=
 =?us-ascii?Q?qS6BehYzrusT1Jds+Gk1jB7qkTy7eO2ypLcPEIw6nz9vsLv0of0Fwiv6tMTt?=
 =?us-ascii?Q?Q9Nn/HFnuJJ/cF/bxdnnZTk/GjoOY3zbGRYbo90XXEPcSmU7RPye31BowK4g?=
 =?us-ascii?Q?aqA19+6Y50f0tC0OgKTsnFo9j4bYXASg+wKiDM90yp790Pd5HD9C12oozx3a?=
 =?us-ascii?Q?CBHEq2bS7cUjXePXGrhjLjH5zpgtQ/9HsraiJyLM3Sl/YEfy9KPj0lWaSB2Z?=
 =?us-ascii?Q?scDZ2q9O8eGN2io4NIuGlR6sRbXxxsaXb7+APwNG2gCMsNZStMNmNwNWS0pF?=
 =?us-ascii?Q?kSe3W9y/Q+b9Idqdt90SM/y8oM/QbfY7/hh1YBdTx5oZq4PK4FvzYX+o5Jdb?=
 =?us-ascii?Q?tsZIxOiQP+ntITMEJBibBgq+EEGqoa6mgBPX41R53DpiUiuU+Byd1OBZhuLb?=
 =?us-ascii?Q?yqb1vwnO0F1sH15WVZaHVFcWEejUmkk5Dyk210Mlue9Tv/S0sATHJ6c5IODS?=
 =?us-ascii?Q?2bUsa3uqDaSg4v72NbGWBoNIA04FcEMIBiSXy2u7d3oj1ZvZ+8DniftqoekV?=
 =?us-ascii?Q?DijGHqhD2Fd9Q8lwLwVMfnrP8iK3icggriHkntEXQ3ZZTl15GZtUsAk8GbPo?=
 =?us-ascii?Q?72/IqCR/PMPoUOI9Lz82joQzt2SLeXKMa4xghpHRLfi8gEoXltxWQp6GD46b?=
 =?us-ascii?Q?AjEWZ54ntQd+JSDSVy47GHDQh2RK+3Nk8KoaMgI59nc/s8nWwR+6BwWPwCij?=
 =?us-ascii?Q?baBEXW8eef7LxOOj76FXIKkSJoE4cf/TzkbWhp0KDFl9LPUsS9z4kJ/jrfQ3?=
 =?us-ascii?Q?BuSQsZ6bNtR80MK2gkv/W2jPui1dyI4JceWa4pe1t772gq6bQmv2ffA0wSJT?=
 =?us-ascii?Q?YloGFQe/3EESTfPrWy2BphSlO7cad+yfnXmKdSS/Gb8AhcF9vPGhDJOTA3RG?=
 =?us-ascii?Q?YT0pVEV5pkY5hLA1kQKvETBK4X+DH6amLznUc56IWcB2M1pqNeZtoqG0xikR?=
 =?us-ascii?Q?ypIPn+8wY6wawzndpaUkHdps?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f55a56-db4a-481d-500b-08d940f123c9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:28.3328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcHN3yTIp/gpZDt5NY8/dm+YNEG/mFc3p7Ry9xSqVSLsdXW3fVTuYXSpxxV74T7xUZ1sgfcZhxL0gBHF5Dl5lcrWF4OxKaMykJegednsCDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070012
X-Proofpoint-GUID: NG63G9Q4TQQM4Qz2RIm2cz838Jqzt2ME
X-Proofpoint-ORIG-GUID: NG63G9Q4TQQM4Qz2RIm2cz838Jqzt2ME
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow keys to be moved into the secondary keyring without checking its
trust chain.  This is available only during kernel initialization.

This will allow keys in the MOK list to be added during boot.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c        | 25 +++++++++++++++++++++++++
 include/keys/system_keyring.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 692365dee2bd..f02bc5832684 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -90,6 +90,31 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 
 	return restriction;
 }
+
+/**
+ * move_to_trusted_secondary_keyring - Move to the secondary trusted
+ * keyring with no validation.
+ * @key: The key to add to the secondary trusted keyring
+ * @from_keyring: The keyring containing the key to move from
+ *
+ * Move key to the secondary keyring without checking its trust chain.  This
+ * is available only during kernel initialization.
+ */
+__init int move_to_trusted_secondary_keyring(struct key *key, struct key *from_keyring)
+{
+	int ret;
+
+	ret = key_move(key, from_keyring, secondary_trusted_keys,
+		       KEY_ALLOC_BYPASS_RESTRICTION);
+
+	if (ret)
+		pr_err("Problem loading X.509 certificate %d\n", ret);
+	else
+		pr_notice("Loaded X.509 cert '%s' linked to secondary sys keyring\n",
+			  key->description);
+
+	return ret;
+}
 #endif
 
 /*
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 6acd3cf13a18..f40837026d6d 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -34,8 +34,15 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 	const struct key_type *type,
 	const union key_payload *payload,
 	struct key *restriction_key);
+extern __init int move_to_trusted_secondary_keyring(struct key *key,
+						    struct key *from_keyring);
 #else
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
+static inline __init int move_to_trusted_secondary_keyring(struct key *key,
+							   struct key *from_keyring)
+{
+	return -EKEYREVOKED;
+}
 #endif
 
 extern struct pkcs7_message *pkcs7;
-- 
2.18.4

