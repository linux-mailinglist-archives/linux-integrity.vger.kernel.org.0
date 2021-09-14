Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8578340B9E4
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhINVQs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:16:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57934 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234522AbhINVQg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:36 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxNDm017542;
        Tue, 14 Sep 2021 21:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZT2ryMVaMnisTxnwGd/XS1k2DKC1kA3fDk1YULss4uY=;
 b=xHRJpMBmwSY/8HE1qZEwOydOAy/4RhMoITxHc2jibWNPKzV8C1aIkrkBHn5nzSfswN8f
 BW+z/TQZJYiUjjHAtqNQHgeLDKw8mxwhbTMCDr4wXK1iz+kiLZXNpNhNwWU7+RiERDdH
 xEJqHNQFs5EtXv0Bbolc3rWI6b7kLz5eHNNHX95iWUQ4Q0Zg9B4G+U9o3EU4MY2r9p8X
 6/CLDvRiKNCztxRT1FtDMQTP6WXeJiU+kRrHDqbtGgoxoFDhNkSdS4zOPlfikQaIQvYi
 CdFHRsblb9p/HK1nSIwWBVNE0lkEAcfG14Hrg6N5AzZw47R5F3dRdVuYO6KuP+rCBGNa fQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ZT2ryMVaMnisTxnwGd/XS1k2DKC1kA3fDk1YULss4uY=;
 b=ODif9Eb0ds+N2r1x192hPUyPBDaBjc9DPZy4ak4aywRI53qTAXW+aNBSR/ywdxNfCDrS
 kUqsV99Vw7KxuCw4jvjil/93CF5+eyuwlGB72DouJZIrQ410xz3oXwk8EHpupaaGGSZK
 ovDd9LsxZoAI1eE+bkh22TvJysotlYGeVU5NpTVACbBjJjWfSurl0c6oz1y0mzt4jb19
 s50lEgdtWTOziyjhFOWYtqQN7mcZgFYOfZD6cRRDg40KPyOQAd6biFKILUc3AP0m7Y/F
 N/aEkwl+wGe2sCJYk796YyGrYsjgUize9XLHMNlwoQEho1VYBhmH4wQ4CKCIfywVz7r6 LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p8taxja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:15:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELBARl178879;
        Tue, 14 Sep 2021 21:14:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 3b0hjvqwgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM//vfBWS99iRuIoNdWz0LtPBqOWOq6MNUT7Panz5S5DCv3QrpI3lFd3BdcS6Ic7WlBEgu6llUaTBAfyUR2JXuwbdRtvC+d41KHI9OfvuyL5jRNpxJI3CNfKYJW/e7G/ebUy63TYj/38Pr01oNgUsDY6zhNOkQpk92w+gvSAVYku95TAj8btO4XiN0patg3MMvjnzO73xskZfQUAUeOkpGF1677dGvAWPXRu/G3SB79SyvvZKMIuWNVrH/T3KrDr2GsQShh9YKRPB+UzxeH5ImBGXISP2KIUBStf9iCo5GHWlQs5hGG0hBxVFVGPlT730GqlFpUBxiSUSx/kP9MXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZT2ryMVaMnisTxnwGd/XS1k2DKC1kA3fDk1YULss4uY=;
 b=c94Lq/R71flcJhJC5c6EEXjt7JNWuBEIJ3VxD17vmzKWBu8CupJTzHb7Yn41hRCAzgcSf/IX30XaYyVxp7uYFOUTDdF+3VQZKostwiXKt8fplSn8TEs+HVQwmbv5OC5LjKh8Uys6L+dwwWMUOj9kSVmI3RbaMsH6Y1N9+4APaBXvpppjNc1zJN+ppo0G6kO/Y/HYxW9PyLv7bNCW8fgm8kptjfsQLCwGX459hr9WLHjkLwf19x9rNGFTzvagHkc9t88HlP9akYVcTU/k/QpnXME0DoBMl5egiEAZMdR0iKhrBY1eTQgTksFGYZXrfkjtjAt1NeJ9L9cNpiHOM80y3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT2ryMVaMnisTxnwGd/XS1k2DKC1kA3fDk1YULss4uY=;
 b=RYmoy254uqjHkPaKAH9lMsaVDTHeVV1JDoWwkjT7DXgltnskWiTbyOwgoIzsrlj7cD7yOf7dLUpeG0zWNhxnMzKx/rBnLK1bAiAAN+jd98tj1BZeMi8tdIvuYLnsqO8CGDBFdh5QtdCtiS3SSIHr5+i+zGUU/tIzvyw5kVwsJ0s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3784.namprd10.prod.outlook.com (2603:10b6:610:3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:14:57 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:14:57 +0000
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
Subject: [PATCH v6 08/13] KEYS: Introduce link restriction for machine keys
Date:   Tue, 14 Sep 2021 17:14:11 -0400
Message-Id: <20210914211416.34096-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:14:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 163ab24a-e8ad-4ad2-c32c-08d977c4b429
X-MS-TrafficTypeDiagnostic: CH2PR10MB3784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB37848F59636FD7C9ACE19C1787DA9@CH2PR10MB3784.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sh6emwf4Kq99kYekOYqfO8LT5DdB8MGnhoMNn8BA/ANvQ+oudzB9uet6Cm23ZCy8Zg7Fn71vzmi/q4HXlWRJ89NCnj4QEGXNceDRmJZ/d3bUanc3PAPBM1FMO3wopGp3V+75svbOwp11yVEv9gTZjGqiJJryTQbXxyOSs69qtUl8Jns/myvVEJ4vR0LIlS7SB2kVp2TNsA26c/Cq29TgSKCjzzTlsYEN+pwm1JZy1qR2VqB/gAigQFnkn2zZ0rZvuv20UcCva2f8kB7xdvhuWbKz1ZZhDU7aqK5eIYYzCmGIOVj0CDOxxOWwZye+xc/JxbwJE2hpEZBLbL+E+brnbHYfVTtl4EMuaD1wXNAdfKdiIYc+8HLN2FLNFcz6rIaU/xehISXw5dpxRLlr4Zv9+z3Q+ZaWPy6hxPh6oJ0nCWTAWGikaGiJ0oquxJwFGaLQ6Skn8xdZfmncQwVgmVjHa5RBxETQKYFEBNrfFEJReusZrgwfdvNtiw800KRh5DGXUBPvwoGdmXLD0MOUoc8rQeXG2SQewXwOLToXKUOJs1JvtzyoF1H9+BKjRcsKO+dQlEktQmiJ0cG/1MOUfQamjBX/mZCf34z92Z1qKKb5YgIy5GYwoWy2OsFCNOddfjoQlQb37eo3roodH9M6vBxJuuPs5jsrULDed2fO/TxTStOS8VAoIrKuGKnQ86HwjtaZbHg48pKQ/ZOCk5aKu4hVPmg2XiKenDeZkJ+RKYKJ3R0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(136003)(366004)(346002)(107886003)(4326008)(2906002)(2616005)(86362001)(6486002)(956004)(44832011)(6666004)(478600001)(36756003)(7696005)(52116002)(316002)(921005)(1076003)(66476007)(66946007)(7416002)(66556008)(26005)(186003)(8676002)(38350700002)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tSrY5YzW6BFSQg4I6dHPiBXmV8ZFzH7qFEJGxG6Ef31U+APFdJmZUv1qM+8X?=
 =?us-ascii?Q?bDzsZpD6uj43DJa9Abzh86p8t7tjKQF9DGqcDlXoW4fEHR9oNRYk1phFSqXL?=
 =?us-ascii?Q?HkU4sTivSZOgpf/CsFBb+Bw0f96BsPLDzmRY85e7TMEKp6zBKwEjMsaV6ZeN?=
 =?us-ascii?Q?QtZwda8WVMKYa10JbibRS3fktz9BUcoyU7suZYamu/MWQNVTIEpOZ1J54iPh?=
 =?us-ascii?Q?0hzzeDdhD41LwMi+OxaxokNvajHu0fKXNjp5nl4Ei62FfdexemK8/ASJuiLF?=
 =?us-ascii?Q?QtghC2EmLc7InF0TT45GukyG9n7uvv61MI3ki5dhTBrTg1aGHMEfB95D3fmW?=
 =?us-ascii?Q?2X122wt8s4mq1FwYGjroiHw7Zy3IN7AY9+HEupvAQsaOWqnZ4BaCIdFRJmTM?=
 =?us-ascii?Q?3CjH0BCxa8B0a3wnxgu9V/5yirHkzEbmwXpHd6bXRKxlDvyUv712SGrp5rjc?=
 =?us-ascii?Q?7cY7GXTJoULBdaKuVKx/MuqHKCri6ZIw9RruaKjeUpHnsPIzuhyPkBH4VFJC?=
 =?us-ascii?Q?vLkiFs87Rr5WDceOFeroxp2isJd03lYQUFpObdf5t9daW1oIvq5gihJU0q/Y?=
 =?us-ascii?Q?1agScS12Gj0RJy33HUq7NFA04Or43kxQgyFl4DGSgfBI9u8r0JuBQ67EJKAh?=
 =?us-ascii?Q?4nL5DRlJEVyQduh4ZHyw3f79iKoxmKT5a1FiDurqzameMMn4vWgHGIGypDHO?=
 =?us-ascii?Q?n2OTEkLCAsG2F3U4ldX4HU07+pTRN+ov6dHHAuNxkv3XAuNgNjBl5/b5/3Ak?=
 =?us-ascii?Q?LjDyrOBM46sZD0yT+E/RStuS5gmhHYjxfgYf1ELIWut7r2kLgl6zp9Gi/sJr?=
 =?us-ascii?Q?3WLpVpcztUv3nzYC/Rm0nw5lpopzDxio+tx0wi8NUy71nWPIpUzlFuxMVi2a?=
 =?us-ascii?Q?v2fRUUZP+j/KG8KVrqb2mDP1KkNUXWstsVTq2jUYab3vAQKoK9rYhPmVIivx?=
 =?us-ascii?Q?HxoIys2KQDVflw7YVNxWUtAzYTx/bhbM+kPKxZAvgiYdGUYn2aHMjgh3gr2G?=
 =?us-ascii?Q?T0PIMCI3D88p0OM3l5J2ShgLfcLkXurY9H2cP9EHT4ajVoOT5MwhIhCG1yf0?=
 =?us-ascii?Q?4dXW94hxXDIijNuBTHblo2DaVonTZIc9xURQmyC7AlSEZ5xivHKNue6JqC6s?=
 =?us-ascii?Q?UOyIwe9pModBcgsNpqZ42vhpJKZuMSR5WeKT36ppYsSzySXGs8vet5ojIzR7?=
 =?us-ascii?Q?deXkvzdZnqukzfArKldIufaSTG0XCT6HVWRG6/ekzwJKXru3l3cUhpsVIfXg?=
 =?us-ascii?Q?HJ2tbVyPo6cB82JQSn4CTWjcgSR5kIUt7fWv24aJGZTMkFpnehkDwcwhXWSr?=
 =?us-ascii?Q?Wh48RdwaudMpLlO5JZsmEXT4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163ab24a-e8ad-4ad2-c32c-08d977c4b429
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:14:57.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9afW/9VU3U6zN2FmkZemxBFdc3Kk2c2Ho/l6KWQtABCB0FCLsiqutgKnUKwibRGzQfgQeWI4WyiWgQsZTqdsomtsBTw9IBXWgC6B+JYoiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3784
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-GUID: FcAALjC3PLgtyUnOyQLoDVwSRj9KNxUq
X-Proofpoint-ORIG-GUID: FcAALjC3PLgtyUnOyQLoDVwSRj9KNxUq
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce a new link restriction that includes the trusted builtin,
secondary and machine keys. The restriction is based on the key to be
added being vouched for by a key in any of these three keyrings.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3: Initial version
v4: moved code under CONFIG_INTEGRITY_MOK_KEYRING
v5: Rename to machine keyring
v6: Change subject name (suggested by Mimi)
    Rename restrict_link_by_builtin_secondary_and_ca_trusted
      to restrict_link_by_builtin_secondary_and_machine (suggested by
      Mimi)
---
 certs/system_keyring.c        | 23 +++++++++++++++++++++++
 include/keys/system_keyring.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index bc7e44fc82c2..71a00add9805 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -99,6 +99,29 @@ void __init set_machine_trusted_keys(struct key *keyring)
 {
 	machine_trusted_keys = keyring;
 }
+
+/**
+ * restrict_link_by_builtin_secondary_and_machine
+ *
+ * Restrict the addition of keys into a keyring based on the key-to-be-added
+ * being vouched for by a key in either the built-in, the secondary, or
+ * the machine keyrings.
+ */
+int restrict_link_by_builtin_secondary_and_machine(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key)
+{
+	if (machine_trusted_keys && type == &key_type_keyring &&
+	    dest_keyring == secondary_trusted_keys &&
+	    payload == &machine_trusted_keys->payload)
+		/* Allow the machine keyring to be added to the secondary */
+		return 0;
+
+	return restrict_link_by_builtin_and_secondary_trusted(dest_keyring, type,
+							      payload, restrict_key);
+}
 #endif
 
 /*
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 98c9b10cdc17..2419a735420f 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -39,8 +39,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #endif
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+extern int restrict_link_by_builtin_secondary_and_machine(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key);
 extern void __init set_machine_trusted_keys(struct key *keyring);
 #else
+#define restrict_link_by_builtin_secondary_and_machine restrict_link_by_builtin_trusted
 static inline void __init set_machine_trusted_keys(struct key *keyring)
 {
 }
-- 
2.18.4

