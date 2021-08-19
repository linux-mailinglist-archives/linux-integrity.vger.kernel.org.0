Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04CD3F0F2B
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhHSAWp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:22:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20958 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234379AbhHSAWk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:40 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0Hw0K013440;
        Thu, 19 Aug 2021 00:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=pIOViR2EoAM6piKmGaHAzYU+ny3O5zllkU4pL+mSOlw=;
 b=A7qujnASp4N2knKnXBvggcu1f99FRepwtOOGyDe7+I5MdvP8wfWzK051xXfIn3FkeMyb
 zT/hqA7V0msmUeW/GIDXqWfKMNC40wf1I/B8wj8LzVwtq7Q6aRsf0WC2kkXGJ5YDCqVC
 L4ATLdVAaxtGRNrxgNBWguFe5VffMcMl2DBBUm6PhONHoj6ffXJyzpelUjBhd5ExUj9p
 yNRv02opcPf/6OfIr05GDhIk2IOFkeuecUBtz8JfXx5U7+kGuYF4u4+/pUsDqgPWZ3Ey
 JxmOUzje3yG5rV5CGm2H+XE00G3cFwVO4H5Gf6FpfqgpSZeeBGSX0JzDcV0x2FbTCAgy UQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=pIOViR2EoAM6piKmGaHAzYU+ny3O5zllkU4pL+mSOlw=;
 b=VxoLteyc0LMxk0ElpCIOG500MrBxtfZoqNGUub16tpsNVnLVjKMR4k9CGJGCHmn3wTew
 Q+8Fj/qewvUcow8SUmDAdrxx6BveV9Qfto/Z0x67jpo498w3iSJh4tAeYhq1FDkzkky4
 zN6IOL7SkIz+PUTrEtxpfFL+6LsLvhzRpVVepwPHvUqgbKDsRS1FWMQwVDArsWX0XjET
 jG2KDoJ5UhJzX5oOFlclm5RrghFr02LBF1AIQVDWJMS6B7CYEAQiSHgXDQZHG/A5dupl
 6YjC8UcHn5cADM2e8n6cAFhuRZhpOsTMfc7Vv/ITR58PfvoJf3+peGlK8vKez/lu0ock Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agw7t2adu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0F6Fp196129;
        Thu, 19 Aug 2021 00:21:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3020.oracle.com with ESMTP id 3aeqkxan3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKgAhKNl7Y7/PHzksXm93PaVaMX8VQfix/mpOVC1hF6XcL/Xo/aEzYWfPWfUTzKeoA2PP1b0JX4MWQ6YO5wlsmnNv756jP6gwsdbsFSZqz+uz3zb37vZQ85xDMLYjlyTc4eswbq4cKpEvHs7ePHOl1M+RCUrZ6NxXlzwLmjN/A5/kf2g5jqax7FyCs+iF1G3QuJFGtwC6XQsmQ1nDzHLOFU7o6DqQMmSEN6fEc+WzHl+dtCDpU0YkiaO708S7gtu1WF4sdKTxcBLnU28H8KBVJKqWjPWukjO9rmGrsUlQOk3aV1pJ7UA0fIE0KzGaEaomJj6hOcL1Rhprc/i6LZDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIOViR2EoAM6piKmGaHAzYU+ny3O5zllkU4pL+mSOlw=;
 b=SGBt7nCkv1pNXGYVgzjXVYSgSAAS4cSzfdR1sUU6vGyUxJMZR/5ZKg/m3Tlhxt8HIqQmIVC8CAIln5CWyAis+Rn292MYAPvcfdTkw5uMkp5YNNInz1aT0CwOxHdN+uI7IRrGlGsyRT33xBWuGSizIXLIQ9vA19bpia4m5R5Z1t7iVWCdW+24goA82NjW1wxWYszraQfeSqbxhyfN5V8+85XQrKYGwfvqJpboDsp7yqbg2f1ITaWkEYYG7uCk2kn0yF1YWqarlB24Qbsh3iCXqoEAIbziXz1uFPpi/iKiym5x8Uc0PEJgRnVn5WPGBr8lSnMDmL5P8N96E1lvULtNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIOViR2EoAM6piKmGaHAzYU+ny3O5zllkU4pL+mSOlw=;
 b=CqqV17uonii7wKOmcY+pSnwcHDWvIcd2DWkWNooF1CfIbNWenmp3kj1SRHS12dE+oLtpmZxMtpBFUEzzT5++KuNC0hIwyIGEadQHCIzEyrYWYVCuL3STB2fDDRPcAUNA9RCHzZW8aughW+hQdz8GweAkRoj64CJn8dQf8q6UNCM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:44 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:44 +0000
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
Subject: [PATCH v4 07/12] KEYS: Introduce link restriction to include builtin, secondary and mok keys
Date:   Wed, 18 Aug 2021 20:21:04 -0400
Message-Id: <20210819002109.534600-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0883c7b8-5bdd-4799-dc8b-08d962a75325
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5116BB5AE4FD467D8FBE5FB787C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74qFgbNekS0kkecDlL8UI1nDUmD46JGW3G+2Upl3UOmq0A16/bKze3T4ctNZvUe3ZkfUw0UscN7Z0M/ra3mA9mhdvHqc6aqR8w7O8zoyq7CeFlL4T8jcMGgZySMYoUv3BeZRklmd8tYLUkNRY7n9lv8BrxgmRo8qDMCq+xt7uXJ3ZMLzyZH1ZCNUU50hRLXFMQmNz+kPLeomdZqYP6h5yxmX5Ky+O034U2ei0oTMZ2hE2KqtqeXmbxwZCEqsk+uR0xaPSIFCQ1Tvt6yM2QgbMR6FMHJULJ/56utmMd1QZ39BMrWLhvyqCcoIiJEHKi+Yuh4eK7iXkcRx1fDXigeeQPO/1gsKxfdbWLrH2J5LDCz9B22D/5PKhCbeA1PbwgKMf018M1mHDpxC8OPhiJynyS0GTmj0ghR3S60lUYipD6Za0PsB68vpSVx38b1mX8i8nGlGYcwmjXbQuCrWgdHRRf5CXWxKiYNcUvZLnRwAiV8SwvJQ0pRveAQ3oQE8KABiqXczcy0PNMW1QDtdsb3kfccNU2Gx4JnJGGVnWL72uWZ/06nyCCC0gp2YbZmvgpucbw25dz6B1ZsNrQMWkqwyTvTu0r+tVRfdYnkxubgQNOK0CB/Dx3dchj8O0IB9A0p7x3NPd/Cr/r+N9YlGpjX3ERSh9VnABDo0XVLNBv1wAYbJTZ+nFleI0euO1mCD2uKcH2UvRmPLleHDfzXFCFvkGqTh0rLV8bZKCgBrEXKFmEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(478600001)(6666004)(6486002)(66556008)(66476007)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lNhD0DOEn0iY2gm1w0y8jj4S5O7GjijhGDjKQXVBtUDvFSus/NqZTeHgnt0L?=
 =?us-ascii?Q?kzaqb0p+qG+auqW3Ym6/qndrHCjviMFWOtERuvBS3MkXB5BPDpOuWM4yxkO5?=
 =?us-ascii?Q?5NRi7Uh2WV8C2ifyTq6eqHStl6zYnUnTPuO7CQ9RL31gA428zgkQTtMIvtL4?=
 =?us-ascii?Q?gZiHA73x0eXocIznwvc2p3uwXrM4VdmidTc3iGyiUSez3p6spywwiaZdwCU8?=
 =?us-ascii?Q?7XydsWrWDm8tQkep/33LsHu4pb8Vm4SYuotGiHtXeOGgHAM1p8BaMi8aeDXI?=
 =?us-ascii?Q?ikIVBnops3qyHGti5Pq2bt5iBGRN9F3xLJkKDYLMcZdEAhrcdfwhhgVhc+mV?=
 =?us-ascii?Q?nSoaabTeuqG/MII1h0Ck6vX9uTC42/tFjFW3YhRjzriSegRr4tvMyoQ+YuEt?=
 =?us-ascii?Q?ZzqWBTgNLMNO6ehNOI4Oe4122usw+vhXSx4uOH6w3/Q+U3JSufp+dSe/aKwd?=
 =?us-ascii?Q?BjyrojH50xqOvdgOMnlDsQKlOL6sANggEqxSIdkFhyfCtlI4gYOJtalju7yG?=
 =?us-ascii?Q?VAC2eH7VBL5LjV0/BRUZhggR3+o9kmVnmel5R6Mek/LSM9jU8VT091akbhiO?=
 =?us-ascii?Q?z+m5bCwRNr02+8y5lD8CYOF1JuCv7H4MRP1g1+/pJwvTAFMbT10YiWgij49i?=
 =?us-ascii?Q?UqhOptDhWwBNgEh9VsGWORUeB0nshLcLSFCz0voCvJV9gCTG6lZgC89SYmyx?=
 =?us-ascii?Q?BsxXKq4DNtcH0ETicJiV88vHw2ZPvexOmLYpR/DvKo+I5ekC2YkvmfD8jv8j?=
 =?us-ascii?Q?ydQ9LEeM5hESVwLrkIt0m4jiMsGbgwg/tkdWP+CVDxN9dfewQ6XplEPulwem?=
 =?us-ascii?Q?rXe+qzZAdBdbW391xLOI8Yf2ISvGXrqqurrjQ2Bxjh4NNbibPclGOlIpFaa9?=
 =?us-ascii?Q?iBrWRBzHkCDgqNT/+YitM8gJmKz175I2RoN8J4/7vdjkvkhzFzZWNuyfhEYD?=
 =?us-ascii?Q?sTdNu51dKmJN7K2zZCMTDiIBYBlRwpXzkeUtP+uuEXvTRxIJ4G2K1Ly2arjW?=
 =?us-ascii?Q?sBEOQhtuknjKZ8C++lSCtLUsxDc0A3OIfbQWcACd6kckXUZ5NaraGpmt+08P?=
 =?us-ascii?Q?7Co/BNOv377BslpRpwPlnalDzu2bTw7HaaWaSWelWFtZxDVTV1EMd8S+gxMt?=
 =?us-ascii?Q?abH3ugRxN6DS82e3rVvH97qTm/jCnoFzf38N6tLnkey354uTcxNq3hxbdKSr?=
 =?us-ascii?Q?0X0RMRogXzSZazqb27uAbdtN0bDmfqLIWNvyIR46mGlEPSICTwXmXU61Jrrq?=
 =?us-ascii?Q?T1n96mKJ9bl+vPoH9YGGZjniiVfLrhv/8rGbjANaW8igVHQMo9DdzmfJYh+2?=
 =?us-ascii?Q?5xvWP8dD8LE1Y4jSlcNyxUwH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0883c7b8-5bdd-4799-dc8b-08d962a75325
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:44.5717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCfCRv6pn81vZJd1+HRYH1ZeJgUd470TfjAh4LSvCGXUjqmxGYljgf2dgGP5yggH4cE/VzvpH7nGmvIYvdlbQCEh9FADtK3LN4uJRIZK39Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-ORIG-GUID: gudxaGBEViv5wI8w4v5OmBfvwnYBbSLR
X-Proofpoint-GUID: gudxaGBEViv5wI8w4v5OmBfvwnYBbSLR
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
v4: moved code under CONFIG_INTEGRITY_MOK_KEYRING
---
 certs/system_keyring.c        | 23 +++++++++++++++++++++++
 include/keys/system_keyring.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 94af3fe107b4..a75c815a42c8 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -99,6 +99,29 @@ void __init set_mok_trusted_keys(struct key *keyring)
 {
 	mok_trusted_keys = keyring;
 }
+
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
 #endif
 
 /*
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 059e32e36b3a..8cc9606a6cab 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -39,8 +39,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #endif
 
 #ifdef CONFIG_INTEGRITY_MOK_KEYRING
+extern int restrict_link_by_builtin_secondary_and_ca_trusted(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key);
 extern void __init set_mok_trusted_keys(struct key *keyring);
 #else
+#define restrict_link_by_builtin_secondary_and_ca_trusted restrict_link_by_builtin_trusted
 static inline void __init set_mok_trusted_keys(struct key *keyring)
 {
 }
-- 
2.18.4

