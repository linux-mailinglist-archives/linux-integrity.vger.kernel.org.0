Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F503E9C41
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhHLCUd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:20:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41590 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233614AbhHLCU2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2Anh2019348;
        Thu, 12 Aug 2021 02:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ExTw+zgFROobW1qu4K930Y6KMWnA4yNcE+RkzrFc/aE=;
 b=hxLLM6k4ATJZ7JOAUu9qoY+8iY0JM+Y9tjsdFvWlaKTGf6xDGWTthu9RqmPdlLeOgRIc
 oVJN0cw8NVFn7PvhUaPuoRKIuzKjDpN2ngARmlEsjlyelzTUXQ2uQgPDJ9bR8sN9SC9h
 L+A+L4jMYT4MOqwqNla30xuqgen1G6aIV2Vkn7wnlljJRhNmklnAIaHbQJESRQzHMRPM
 rbrdaG5v4oAuoWRsNd6b0A11ejfOnwdSkSqpFUL/VqAxaPuIOkKSCEBl/8e010afTBxJ
 x58bJ8PIl63JcNuXGQ2zqEkp1jofVfZSbwpt7H8oz0egJNP8Yiq2NoVv25X4KyoEEZzt dg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ExTw+zgFROobW1qu4K930Y6KMWnA4yNcE+RkzrFc/aE=;
 b=tBHWr02Hh+R4VS1YGtGWZR/AhhF9JBf7or5qjzSp0C2nUQa2c4BhjKfmrgxwnRjwa+Dq
 //XpNvBbylm9KACL+c+dqi0X+zqPjAiulEWf5jeqObi4zsp5vTdIxkl5iw5mLsu0qGrn
 1w4U+BJQHQAVfcSFDCXX71Izn5HXwJ9MB8yxs1Ks3/qGvCQe9paxuCFkEzqVwr2VNXgN
 +LNKO8+bS7oK052z3T1ezbBMrsI5cfpEymx5RmknbeJvoVGUKUqDyxC5Wv7u67MIsKuH
 pGS2hRuPbV65W4tXAyD8V0zpkEPHJkLNCjpX8SrEdkK+SaUH0UjxXeeCKycY1atDg/V8 zA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt44c6h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GeiR083586;
        Thu, 12 Aug 2021 02:19:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3abx3wuf3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4lEzjmrVMUW1+ELyw1xMNMg4PjYrcubNhA1TC76nGJG/VXt8YPr74DWMCKNoy/DZMp+WQsZ1+a3dD1g6xXxo02BikhdHvj459e+XlSrOOy6IFIB0zw/O8vBKQrSzh9WulLo5x7SYaEhaZahh4e/8qz3GbtkUhselARDhWTw3eo/dyxmO4i2eiQy78+Hj5dJrs9MW+azjCJRbWPFhZpD+fPXVbDGFEnbovPoEyz41XgcfLeIRDJLpnP/EwjtRtU98G0FQSZAucgP8ujRfCfPp32GxICvnF27wRziNdpmo+XvX+BVxbo6CpfKdOYK48skR4I1dgu5a4I8I5CyznDXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExTw+zgFROobW1qu4K930Y6KMWnA4yNcE+RkzrFc/aE=;
 b=n3XMSQJtNNJUxYCv8is1Fe5PA4JNobZa+1KEhUfgpCxzIFuKC+BuZcBcNQiKkiRwDJjwTKT7k21UqzeNJykjXMUS7LCq2BKs3AHOIwjju1lyBaOlbi8VmGEiZsY7piJ03DJ0SYoAauFm7cJgZ0Xkn15RXd+elZfA6rsQd0PgBor1JOFMoSJD7emnULmRX9xIJrWmKyQM4E/XswX9YD3fFYU8Dah8fggZjWhbcVKwWUgbTw5Q35wVOckpApTJRyQ0pBERoaAdeLA2J/xjY1H3ougxWAjAEGKwN2ULRXcOEOqDiXcAGiZUaS1buNxWdW5/v344KSDUYpWpKQ1yZ+m8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExTw+zgFROobW1qu4K930Y6KMWnA4yNcE+RkzrFc/aE=;
 b=ahVO1YvnLi9UqCVUUQocXA7rbRwAeMLrTJn5FzTmx7OKYU7iRekA259LqQHT5CTh8plQC99V34qZJ4ADAPm/0pMpqMwzRSrAwslB4DD6SFOCtIuMvRDAe3UgWGIkn7/RxwVFQlF+ZXjj3nSjvE+tN1YdKhTe3SWIKvEBYHYJIpo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3960.namprd10.prod.outlook.com (2603:10b6:610:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 02:19:36 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:36 +0000
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
Subject: [PATCH v3 09/14] KEYS: Introduce link restriction to include builtin, secondary and mok keys
Date:   Wed, 11 Aug 2021 22:18:50 -0400
Message-Id: <20210812021855.3083178-10-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a22d067c-5fdd-4e80-d289-08d95d37a155
X-MS-TrafficTypeDiagnostic: CH2PR10MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB39603BA2E2BD93A76532A4E687F99@CH2PR10MB3960.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roGCUC38FLHWeQWXtVmf2WvQdg183Mj5C3Iwvr5KSaxZ8enne2WClMq4ECu0zRSm//pMZKWT81Lu01js/T+SrBBxmmK41dFL718347zPccBt6X8X1dDB16MUB/MPTGidRtICNJ/rIuKiOxA+aVpOmIl4QM/VGxWBABMbUK44U48m93thQFMTd53JxZjWkNGlPNn5i1S2RkrmLoYohWfpTb6c5wOzLizMAPsPTLwG8p03tyLK7+/Lcysy0326R9mBvvyC8/eSLHsvfR+58vO27I5aeuj4RkXD4W60DRlxDBRf/l6nVZChbggj2+B0SVVvTYPhWw+Swkd2O8BDa+bimaI4+gLO4X+4fhtRrvvWBxWRl3ZNVRhxInlw5SvxvWLNgeWPSAbTl4LNpukctbD6Wiu33PPhH1ajpl6jboH4X49uZmioy7WbDoynZMFTrWCcFTBj0ImqGbxb6DBpaDyCZQ/u19uU+MX1K/y/fb9bcYO/5kC3o9v7xU/PxDKmOifpco/rY2GLRzJUCsSvqh4WcRbT8wyHxbTGS7sW7iLVYxnYAt+EvrpwCR7Qh1c9XWeUfH2O/jVxUKeHJ8HsdDFUJCjKvD39zOtS2K/H6rc0HPe59H806cwK7eBjd3Dmv1ap+gBTExhOl7s0BgU43LIyOZ/i6khMO+iemyuH34rcomBY66MB2zB4MlbsehjZf21ks7toOR13zLRZx5WRv+V8ZNc+mhf/+NHITTL6acS8kLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(7696005)(2616005)(38100700002)(66476007)(956004)(38350700002)(8936002)(6486002)(52116002)(66946007)(2906002)(44832011)(478600001)(316002)(36756003)(26005)(86362001)(4326008)(66556008)(921005)(186003)(8676002)(5660300002)(1076003)(107886003)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q5A7R1knFIUGEreRcMa2P8Wjo7mEmHC7nYwjsQjBYmdXVuOv2ZG2K/cipoer?=
 =?us-ascii?Q?xiWLLepTRz4whQoMhXX5AAphwm81LbSDAM7/OxHLEgIIu7S6eSyUgiPbACtQ?=
 =?us-ascii?Q?MuQYiuxM2pYlfVzdGQJ7Ge7QoN69Tqj66p/+iLb7ounSr5x51tnozl0jodyy?=
 =?us-ascii?Q?+oYmilDlrR5/KavgbJMVYZgsDOOlv6Ad+ESmy3BssuZ+1waEGXmglZ4VTDYh?=
 =?us-ascii?Q?BQ/6UjNHvfdc6GAdAN+1SbqQZ6cDBBtBI2MeWQEZMA6/q3VUzb32Cw243iLO?=
 =?us-ascii?Q?36LzFQExVhqZZmG9o5ZFVSziZb5VU0smNYODv0/4nLpuweVO7GDvk2IL5d9K?=
 =?us-ascii?Q?akQXOayyjysT66yRv6CGl2JVjEHyLutxJ98J51KSfbBO9BAtj/wF93hp6osj?=
 =?us-ascii?Q?P+cGLzrHiC+UHmb4NVQeiifwEF3nNECV0UaeVAPpBEQzjea6AWcVHLYEYD0y?=
 =?us-ascii?Q?iBAgJYDDPjbCNJRHzj0QHUE6s6iSypuZlw9w1rDIJIlHiAcQFMsSjxo4UNQ2?=
 =?us-ascii?Q?ZVj3DwIIpg/PnS/RyEa5g5sUw4tvnjZ8HJJoNVYLeAfhbQOVMnmGOeqOs2+B?=
 =?us-ascii?Q?HD/6VoO5kIxZC31whjDkrsOwJfsCTf3mC8fG2/HNDcBkPyntS/+vYJ4cDwyV?=
 =?us-ascii?Q?W+l1OO3JqbJVP2lxEXtovVyAqKygxUDuyMY213sahokq0gdEQ15l22hOUnIg?=
 =?us-ascii?Q?QA9XFuYg385IaH8D1eUzUNfEkmXsMjsOzHfL1He4tRYto4Pi7Iouv0WVi0DX?=
 =?us-ascii?Q?2XXYITEbyPBVzrHH3f6ihekqy3+4qrIRD89VJu0XFA9rdyV3P4SC0RTvszMi?=
 =?us-ascii?Q?mBDkvkhjGX/CTG4j/tBw51OhHNhCtqCASi/sLHxONE0ke93CFjGPbA/9fBaE?=
 =?us-ascii?Q?iEi9gornDwE2B8fcvbSeEyeyakjo6tTnm+F6C/lGbkAdT4v69clZTyaiPzrp?=
 =?us-ascii?Q?k1kcrkt7G8+6noMImG7OXOvvG0YMTBb+fCYAbVlnwXRxgQCaU2Zh5+Jiee4j?=
 =?us-ascii?Q?Fx7G/4wtvPsmHJARaEZhnHax3qNVl7fVex5m6eMUy/qKXp6DF6+DPMmrKIXs?=
 =?us-ascii?Q?98rQKaGwB3C/iTeIJIr42Bab7pS0STnvxiz80R9KSjjRoPo+UnomrQox89+M?=
 =?us-ascii?Q?Ls45oBEGY4vmVh+FCJL9ZDO0n8ncCmosYmq5hQKgQHqsVMCGuVtXPmCPwlbu?=
 =?us-ascii?Q?/CYKKdOBxheiZ7rKx84X1MeSTtFujdFtB4VcXUpao0WVzfXTmBJcJdWNRZiR?=
 =?us-ascii?Q?AjBBKugpmbdfm3iS9UZszfuTFidwChCuoo5fE2+HiQ4jrBa3H/zgSB+AZ7I9?=
 =?us-ascii?Q?4nNi0cXWF57T39vlcNTxKMc0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22d067c-5fdd-4e80-d289-08d95d37a155
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:36.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 334pX9rBGg+IuUGrQ8YdGR15N6/cxQz7gEMkZ2FVwveXlWpCBmZUtm2hU9qafXgtuA3fEknKiLkqmac+iU5WmTFsA3kNs5Ookp9wN5ejDtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3960
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108120013
X-Proofpoint-ORIG-GUID: TYB8AbZy1RZJ2A5ZXWhTsE_5XrbUWuoz
X-Proofpoint-GUID: TYB8AbZy1RZJ2A5ZXWhTsE_5XrbUWuoz
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce a new link restriction that includes the trusted builtin,
secondary and mok keys. The restriction is based on the key to be added
being vouched for by a key in any of these three keyrings.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3: Initial version
---
 certs/system_keyring.c        | 23 +++++++++++++++++++++++
 include/keys/system_keyring.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 2baf5447b116..cb773e09ea67 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -74,6 +74,29 @@ int restrict_link_by_builtin_and_secondary_trusted(
 					  secondary_trusted_keys);
 }
 
+/**
+ * restrict_link_by_builtin_secondary_and_ca_trusted
+ *
+ * Restrict the addition of keys into a keyring based on the key-to-be-added
+ * being vouched for by a key in either the built-in, the secondary, or
+ * the mok keyrings.
+ */
+int restrict_link_by_builtin_secondary_and_ca_trusted(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key)
+{
+	if (mok_trusted_keys && type == &key_type_keyring &&
+	    dest_keyring == secondary_trusted_keys &&
+	    payload == &mok_trusted_keys->payload)
+		/* Allow the mok keyring to be added to the secondary */
+		return 0;
+
+	return restrict_link_by_builtin_and_secondary_trusted(dest_keyring, type,
+							      payload, restrict_key);
+}
+
 /**
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 4fe9cca58685..c9fcbfada567 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -34,9 +34,15 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 	const struct key_type *type,
 	const union key_payload *payload,
 	struct key *restriction_key);
+extern int restrict_link_by_builtin_secondary_and_ca_trusted(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key);
 extern void __init set_mok_trusted_keys(struct key *keyring);
 #else
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
+#define restrict_link_by_builtin_secondary_and_ca_trusted restrict_link_by_builtin_trusted
 static inline void __init set_mok_trusted_keys(struct key *keyring)
 {
 }
-- 
2.18.4

