Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6B640B9D7
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhINVQn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:16:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56020 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234376AbhINVQf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxNDi017542;
        Tue, 14 Sep 2021 21:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Wd4dl4111WWQdtKtBHjoIV7EgY6c1gxrQVwQbd3jMig=;
 b=R9cLD7su5xPVv3LdmLSmEG4UckvM6VReAEcpdBz7d6qDBSQs+LHedr7JVOntHVW9fpdJ
 batqdMIH1QtwhLI+FuD4NeprKpHTV5opqb5m5ONQmUmf2xqLC09+petOMXloUKdLQQrw
 XvSmUOoWO1MzQNTdPQqYmeWm/CC00jPo4OBNVLBP7bu2VJJsfzF8mQa45ahkYqZ2xl30
 RRgs03/0/V1Aok0n40hE3V3Wcvq2P5hQ1Pi4BIM8MzzAaIiaWmRaMrCMVEWzWh4hOZrW
 dGotWHmeNQhTXhyqF9/YKHZeJN0fcelDJc1TlKIXT2VRXsK68COFamJmhIHIE6UQtvjC Qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Wd4dl4111WWQdtKtBHjoIV7EgY6c1gxrQVwQbd3jMig=;
 b=NXyE7bkW24B67bj/DGk9FgFM4ICD8iQYItXgcA4Taj5oTMqscFqaH5GQltw0SwQtHZ4y
 3YdqI2vzToEYoodeM2zNty9PNUpVJf1hLJ5i2sClKVoPmoKb5/pznxyh4GjPLwLqq+d0
 eZDRj+H1BsqwdvILmEsBIyGU3lKHQPBUoHMW98OyDV4UUwPJycXIEo1OJVHgdEhBQjlm
 45czZ7HKKBRIW3bPS/ZIusA5odqGOsFH31Zp43PfwS1dzWrsTjeGk+ZS64VXq/hzsOPt
 sdZzliRVL1Zx6MHWvsx0ZGP0RzKFX9GVkyMia6nn0TrXUdw5yAgK+FJo6eNU86sw+VkI 6w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p8taxhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELB91F178826;
        Tue, 14 Sep 2021 21:14:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3b0hjvqwb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYVVoY4u5cA91STg90j9H++nZP8ndjJT2AFPgkuP6r5ZGm0ZB/7Z6UaJEjcdLTIilNsvcF4FeWX0FWz3BbzZMj6j7czrr4CI4dRL8ikuSU1sLYaGDwRkTr3Saoy1f+qQazTczwEfC09/jLHr/m/L+jCKi4ckDiDvQq51BP0ZHIPb/szfqHYtdORlzRDyQsNs8YcE3lrgDoWfV83NY9b3lLWwIbPVSTOx6SBtae4PBVrnjFrPJpYE4oYy5BrKlIKZXol+Ik3OMY7z5tiDlnjSiZm3/tt80m7y0m1blFjo+Hakv+M83RYowR4f5UIrxjpvWT0/4Omxg42yHOzlLxXBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Wd4dl4111WWQdtKtBHjoIV7EgY6c1gxrQVwQbd3jMig=;
 b=Nekc7cZ7PLIpBOnzg/du9bSQea9gVN+nTOQzLgt0x6C8KureSKhpy19WOcwQ/OUh2jhoRzcurnb3RO9OWo8Ocyxgx89fTM3LppqpL6e4LCe6M9iET9J2EaHZ7pBWjz+zYOsrBg9jVUGhD4mEiHL6K3bDMsBTWOYH91MbPBjQDjG8GCZUHfKCXhS1oimMO88CFxRvRGcjpoKhq2Wqosg5l+ZjRIwNEYCcbiyhSyK5MnwY02UmA38KseI7ujmByO16BYaw2WBjY964RqHDkU+Sz61htbWwFjYrhtp+Fyx0TwyD5ZLMOAdeughuM9m5Gmn6zzcFhpiY3M9eOkWpDfTuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd4dl4111WWQdtKtBHjoIV7EgY6c1gxrQVwQbd3jMig=;
 b=QhlG6/qxsOjWKFfB1O9B8Pt3WxxkcqpDsCQBXierbgga/xO5oKfzGGXh0ljaaHZytA8mhNXV+p5gVghmiAJSX4SyU2WMQAMB7oQpL/fvJ/Nk/xK7RDw8K2eiyvbrQxeflp0HqAl993YQEpJvUpOhmQ7IKrg0sGzJo8MWWw+cgrA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:14:41 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:14:41 +0000
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
Subject: [PATCH v6 02/13] integrity: Do not allow machine keyring updates following init
Date:   Tue, 14 Sep 2021 17:14:05 -0400
Message-Id: <20210914211416.34096-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:14:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed82174b-68fd-44ad-8d9b-08d977c4aa6e
X-MS-TrafficTypeDiagnostic: CH0PR10MB4908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4908DD6C47CA50256B8EA53C87DA9@CH0PR10MB4908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BacXOCferyP3DYGzVC4mJ4c/3aj8rBp+jgBu4YyoDit8ksEkzsoFHtFtI7VIgdr/07TtvTZE6BNhvTVOzZDhAdrWxCA+n8GHSDpnITcy5g6RWiZZZ8jiUWvTIjoBrMvocxV7U/tWY6j5GVfLVzdOSiXUWiihsaKitcg1U7Z25gmjb9I+gY8swjh+4U2BzJKpNLgs8XwQ2Yq37x6hh8yVKP5opK9juJdeanaTx9OcCz2np+9KuauI8LpE0VpUgjCFFDiEdjIb6MRdAat1AsR2pYuKLzIC5GE8gi2mMkhOtzHdvi79MpVnEfN9Bx7KGjxI9abkXeNse6HN8c5VVXBVgudP549qhLyd/Ea/Zpbh+tUPvQm9SrrInjTjOM3PkJLbrSn2hP15D16eCIPvM1hySdhWsiZliglNjG26DxwrZLAvGy396NxbmtA1CAwUdqRzDcQxAGBmCwO3RtRmAXeoWvH3l9oEt3u5wLZnTjUgCoaEucXAUAyvkHNIYvLeqitB2UpDIlagvZCpFRSR+GhFRzNBficidL9lwkZsM7c6l8iLvy+vO4af4es+hNavkbH9VP5cUq2NoyP+pKLBkRJwA3ItSP/gEjTEuH4cpzvWH5pG1oyvvwiCxl+KFnnyqTT6Sc5Nbv/EXkgKSXFVzt1cOhph0w2U5di7crKLWvG4VMd8koJ+FXay0jmfhWbkERIa2qn4DoFj5r5p9vkUNstFYY2N17dZ64IRtmmFdWW50tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6486002)(15650500001)(4326008)(6666004)(2906002)(44832011)(7416002)(36756003)(66556008)(4744005)(2616005)(8936002)(66946007)(52116002)(921005)(956004)(478600001)(86362001)(38100700002)(107886003)(38350700002)(26005)(83380400001)(1076003)(8676002)(66476007)(7696005)(5660300002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bS3ererbAEgFj7M40ypo4Nk6ElqCvZkUyFVMKlbJXFUN2UAOniOsvYcwGYj1?=
 =?us-ascii?Q?fngcTxbCL4VpuSBwEL1wS33IcLT2eqMg5LQwW8ZF3F+AG0Vl4L0noVGJN4vI?=
 =?us-ascii?Q?rOYGC9dMTDZcp4fCOCO9XQ9osleDHhKJOqhYdReUYpN7TM+aw/zwxX3svr+H?=
 =?us-ascii?Q?vLaMSmDWU1FxcHuEWB4gfsfvG9z8GoEp2PIM3hnt9BIGE9x5jimQBugELG/I?=
 =?us-ascii?Q?2Kait4ZQznCFC/oe1mvtCI59pQZgoW0QZGtx9MUS0Appd8o5X87xFdEdCKj/?=
 =?us-ascii?Q?SJeQmtiJDedVJP3FtPIIwF7gLljga5GI/UFIiDj62z9h86HGER5EoHmqWDuw?=
 =?us-ascii?Q?EVyMIgLUTNWY3S7PFic3Cikm0XjlsoKCacGs3jcytjT3hRr93Z6I0PguwdoF?=
 =?us-ascii?Q?qftApzq/ty5fzRadSuhdBlyvJivRS+aXdbMz7EwPlsYsSaoaXUNqrSGT2vw3?=
 =?us-ascii?Q?gHQae1XlAw72YmTtOY0Vh9Av+SjV6jJTFiQQ/g80qgxu5QaDp3PB5t40mnR0?=
 =?us-ascii?Q?u0VkGNNNTRUG3IZUSylMSuK7lSN4JPb/i1SB5jxMirZpZZGBzvq8XAX4Lryf?=
 =?us-ascii?Q?xEV+zZqbaVcAmhSFn7oLPqHKkSzWi182oAJOgQ/Au9OdN9K81fnlq5KoF8pB?=
 =?us-ascii?Q?htj0cTBJuaMio8XmQuD1uHPR4+4vxSailsd7ocL3DLrV+SZX0NxkEUf8SjtF?=
 =?us-ascii?Q?EAVbCC+NMfsN8eSh2lwqD4qa67MjwoI/Aozs+mGVt1AXEywDy9wIR5RcG3Nu?=
 =?us-ascii?Q?SL3Iqy5MaFY3gZNYZaAAOedAL2c778XzGAtigWwNkJxLRwP8hZ80tKor6S96?=
 =?us-ascii?Q?0JTOMOo27Wz6rB2TSyK1VAt5qP11yzR1YkMPU7xFYDqOTa7s9R5g3VvTI7Vj?=
 =?us-ascii?Q?Rt88AXpos5/gYspb1I6/8raAGbYo4KZLa2KfwNybtk6I1nkjCT2/frTsUMPX?=
 =?us-ascii?Q?smJVTF6vVtJoRTkUcIcXxZVvS+EXSX6/DerLTLteFVcpd+HocEix9RZyvSaf?=
 =?us-ascii?Q?9/iFYQBWnKLV5eLvNWZvra+0hZJAB+ayVQ8LwTOQFkz4+Rxtjminw93mD0AR?=
 =?us-ascii?Q?ucBUmlUdRxaFCC+lyMVZ6kWXkVZNctpjK/39r+m/hYohRRo5LZnf/poJjCZM?=
 =?us-ascii?Q?dF3vH+o6fX1dJzwAWw1Iq3s2AzFQDIeAt2iNGnDNx7ve+7VeoPUDXDkZpBDR?=
 =?us-ascii?Q?PZNgkzlevOUDvU6dwOoqm9dGJj5IDKtHFOgmwoX38KuN4SmhLfb4c5V6lSDL?=
 =?us-ascii?Q?WoGt2YzLOcjcIj3+L7JyIPXbmIaJEekjTBCsZsEg58z1Y/lVxLGY50U1EIH2?=
 =?us-ascii?Q?ONMKGNk6Rv0PdF2/cJO8qiae?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed82174b-68fd-44ad-8d9b-08d977c4aa6e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:14:40.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hevGY1jknksQtA4yxy0yRs03350R6jHU3p7mkqffYM9OyiPRO4GKB4ibMbE1FsPwpQUErWWFEhyBr1Ixi9d7DgjopdNXD3RBx39zkTOlLlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-GUID: OAjOxhxcwQHrB3jt7tbERmbehz7SX38K
X-Proofpoint-ORIG-GUID: OAjOxhxcwQHrB3jt7tbERmbehz7SX38K
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The machine keyring is setup during init.  No additional keys should be
allowed to be added afterwards.  Leave the permission as read only.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v4: Unmodified from v2
v5: Rename to machine keyring
v6: Add additional comment (suggested by Jarkko)
---
 security/integrity/digsig.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 8c315be8ad99..910fe29a5037 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -140,7 +140,13 @@ int __init integrity_init_keyring(const unsigned int id)
 		return -ENOMEM;
 
 	restriction->check = restrict_link_to_ima;
-	perm |= KEY_USR_WRITE;
+
+	/*
+	 * No additional keys shall be allowed to load into the machine
+	 * keyring following init
+	 */
+	if (id != INTEGRITY_KEYRING_MACHINE)
+		perm |= KEY_USR_WRITE;
 
 out:
 	return __integrity_init_keyring(id, perm, restriction);
-- 
2.18.4

