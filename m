Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0730F402C51
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhIGQDW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:03:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39438 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230094AbhIGQDV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:21 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187Ed192026809;
        Tue, 7 Sep 2021 16:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=99RmF61xiwN70SP8Y2RqWevSANjcjpX0/lMaTQ2DO+g=;
 b=HmB7Vik1DffP97QUiScfpoEXUhyt9zWeyZ4KyLnAQu8UTXtlI+S6WpkPUSZWFlXGM6m+
 CwOJy05qDLf+es3cAqZQkAeQvP2x20di1DIkYk3f6+qqwdplqaYnt0FU+yt/EUvAXGdA
 eNP9YUUd+DH/WEzBybAAVSwDXfvAp9u43JV7wEW1QVCMfnh3ZmeYacczW5xj4zlgt1gb
 bdCZYePopnnm/CNQve4ORSouYIaaTrIk6HVpDZsYY5Jrrv/Jg/VMIisajQl5C79aQpLg
 P585J4bJKCMwyr0XOU6EdHeQ/SKl0iBb+ibuufKySl7G9KPb4Eyg45zPkwU2GRCzZqSw ng== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=99RmF61xiwN70SP8Y2RqWevSANjcjpX0/lMaTQ2DO+g=;
 b=GYfM7CZ3VtaOiTSdaEytSXCwMPUFyTY1S7V+w+ZD7PKzXOGnKWPdE+32Avzzcccl/v71
 zNQDRefVjI/Ra0I7TToGqHN2VPcHI4L4V2h3Aj5X+2EXqIL5DxJm3M1nSNo4cGx+8ua7
 s1hlm3zsICec5kdvLmjq8Y8OP3P4+pDXlRSCRx1qU+1n6yEjcOqvPRoGhKbxBHqwEg2M
 zSX1s0M2o6lhwo40LHSxE56/Ta/OhMOu/trgA9RsjdO+oI3NCNNPufSTn6QV/pYx7JBm
 XMXUwkeJHrhYQZrPue0U74QHBUtp0CrJxYN7qPmXCuNl6YciEA0TtcKnNgH9efT1JAjH xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq29jg3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G02GG185804;
        Tue, 7 Sep 2021 16:01:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3020.oracle.com with ESMTP id 3av0m4t4kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUkVhQz1UfW0WgYrvYkO4ktYCCtrbGn260QZko5B2jKXOE13b1dSz2R7zufcYYdqbD/qKfQ+prvG/HcMJSdj1p4SyXqfoqFpzinlGXa6oOsEfF6wYWTBS7LqVYhks6O+ZC+spQxc5A0PXYgfkFRqBoVxxV2tDhW+f98QE/pKiYqT9ZqlzTNgaIdjLCnjuQPdbx4GV+vmhbRz90k4wbjy3E+qYIBS3jlGoNWrEWjRgo/s1gFTDO+VV0l1BWeta/QAkXgVHneuF5UJVQOH5grdsGmynJ0OvJ2ZnnkIDZyqcZVdtCcqBViBkXQd1chRHxq5ivLe+clE/3TvdYlMlvTxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=99RmF61xiwN70SP8Y2RqWevSANjcjpX0/lMaTQ2DO+g=;
 b=WPquwQhAGJhT90aE99ZOePeNQoDeaBNLkOnkjSdMrwP9HJbag0INafpcD2S2mq9EzhIDqNT8Qrsy/Xj5MWaZ2JeCg/Y5A2PRwk09wPeZ7ZbOUNXQW+parRm9fIcXnKqBhxnxHK25a+Rng7SdMX7BW9L5Q5ajGCQ85hpa7T4bOXzynEhWv2p6ceo+CxjzKTyqcZ3NbQEZRjlNKtYQx5DQWAPmwXtUEgP4D9pyh0bHsFYnQyKz/n9j/X16JPshLvOqOv+fE2K5Mzn/q2pUXzhAuKL6XtZasIxNidEIBXXQJY593l1g2oo856Gfwk3svuVFZHkfvesWmgarRc7A23fpSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99RmF61xiwN70SP8Y2RqWevSANjcjpX0/lMaTQ2DO+g=;
 b=KyF2hCcKkb+5JUwBX1/ahE+XdmVc7B6nIGGdfpFScNeeSYJ5XWF9WNVOQvEF/+6EzWegBryROO6B6D/ITnXaXxbl8Iin7w03KVuK0z2cnxAxMFm1HEBWMhHbfNKeo5q6a8UkP/rqaH1OY7yn4wbp9dbUtjU/lfMV9lFrQtR82Gw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 16:01:34 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:34 +0000
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
Subject: [PATCH v5 04/12] integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
Date:   Tue,  7 Sep 2021 12:01:02 -0400
Message-Id: <20210907160110.2699645-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a2e6cfc-0bec-4988-1a18-08d97218c3fe
X-MS-TrafficTypeDiagnostic: CH0PR10MB5004:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5004C0225DCE392286DB041387D39@CH0PR10MB5004.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYH5pbIaF5Mb0r9wBPnLGZgfube+F32rl4vAnEV/OkkydUeaCYoLXEwNhpeS/Fa1A7BcZHjobcMtUYRGyFxzeLNckA2vi7OeNMfXnROwu+tb4hwVEA4zYQWkAdzJ1t8Nf7CIYhL1vEV+nBfXTIuyVhjBRhVQBW5JxGAyFzwt1l+t4/MlL+SrlU+z6DB/o5usey7NNDy7YwqsKUhYbqU0ZRxYwlepQKvTgYomUMvSLxUPeDRmqtLQGAHdr06pTcpCp8SRyhlCrfKQa8K0NKy1istcMf8eOSz5wJgasxy0xfnZ3SKxEzzfo2+KyrV9NA8k6qZzGqTM/ClPxrfVvabyPDmb3yfy024R+Kme2FTzytC9Ibl3nW9eELEhLFT7bBDQ+xIIkxO129JnL0dUXQ9/7FMApWbrxcbYSPvpdAkyGHY0/hHUscsbaMokI/9AZknyncUYrjrUpTHt8QTQIImP9jwpo/sQoKdqdewYN6nFtlqtVzgUylLC6/VLFqa8uBkdBHC2l5uECQ3I5GbzDMa1d2hdDcKuXbFiJQ7ys3+F9Jyorgr7yEB418MYQoYu4ZowjvRev/GqWwiaHja/bGMBmA5W0BWlOjU0WDYCH74icu0wRgmBN1XFG6IRh3P7PPxhhn6lbJnSIjSyFr+KzatIbsZB2tvnyNn71A9fsKuOtYMa54B5g+SfQEFNBEOFlpO/B4v3StQ7JlXafoJJT4ToH7j0wiDof9rXi5uQSQ/9ruU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(1076003)(66556008)(66946007)(508600001)(66476007)(8676002)(921005)(8936002)(44832011)(5660300002)(186003)(26005)(52116002)(4326008)(7416002)(83380400001)(107886003)(7696005)(36756003)(86362001)(316002)(2906002)(956004)(2616005)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IyfT//brq4EhfaNJZoy0UTutYzn4FvguGjcux3H9oi8hgwFsEoBu0q9Gf6yY?=
 =?us-ascii?Q?fryJDUIqWmckl9mcns1maoCeO9+QF7SXFJg5J3SwpBCuzTJYKO6kkCSZAcDU?=
 =?us-ascii?Q?kIg8aORo/MsUiVGQNbiwBloRld/pYGEXie/xFfv2tJoNOVcgpNBIYh4WuxvU?=
 =?us-ascii?Q?7+FyOX+9SJtv467wvto0+6sEYI/tfOrSU3fOnmca2cgCH746xN6lwZ5eUv/q?=
 =?us-ascii?Q?6X/crMy2YRAreVyQOZvJgiIaxqZF3FOe1VjbljKRY+mZC/Q94gHUFXmwLHyV?=
 =?us-ascii?Q?+mZp5kIpiK9a1smdtZyrPhhbJ3FaftfHXpeXGAjS37uLuqQD3wltg7aqIB/R?=
 =?us-ascii?Q?79pTIBYG9+9mgasKNAhoeTx+xaGEYV/Enh0r5xreAKX4arGZwVA/Y+1EmKaI?=
 =?us-ascii?Q?9zMXY7hHVskOOExo8mxdDEEETErNDjyfBSLj35Rc3irWNJFLmzEZXvqpFDIW?=
 =?us-ascii?Q?jGaRDsHoCso+gUtk0clsUiSBVd/ihTuqeqen6XIoTsZvP5wrRn+qXMylWNDm?=
 =?us-ascii?Q?CBcmkKIMp37yLPx5lfiOGOXvKO3lIT19r/3Z2Vkyj2LlNAKBJKt49kNwCu71?=
 =?us-ascii?Q?3lISDNXI2SiE+c9OKTUOJPXkBVEVnnxN9+d+bO8m2ku7SqT0mmRqYUKPDr7u?=
 =?us-ascii?Q?5bQLK1OCotf9irKhafHKd5K0sIOidD9ugFrU9NMZTn/AOB5fGbxqPK/NHWnt?=
 =?us-ascii?Q?3vfscRWcuhjiDzkQlrHuIbW89znSkTmaeaHOp4iDMme/JDdJIYVlLsqfYz1E?=
 =?us-ascii?Q?emZsydHpXZ5M3yXAwCIyeNloMrQCCi5rM6mA6PNUw3K3mpfI+X22DAxaFzCY?=
 =?us-ascii?Q?euJwWWFpKL6U+i9pMEl3DqQPSHC2XsHOv+xH/Tb9VI3rpWE/iAOvau0AzIgT?=
 =?us-ascii?Q?PVGWi2um9C7599W5c1dTdk9dJetlrdZM6gtRP1u3Swbtj+NXZK2cqBEM5Yp1?=
 =?us-ascii?Q?m437u0NmB4jlbYV6JPo16XMExO06E7Z4joFHDSG8ZHTNcpV49B03VrVpkkVO?=
 =?us-ascii?Q?AMRJW72iJCjSDN02TDJVyNdOhRbjmIrucB/GRq/SeZsBaVe+YyOWZ0rW9psA?=
 =?us-ascii?Q?WSDEQZ8Pvc3qVL7oHbPdzrv1dPxh+w5Um2ZWubSuhGnuLtoGKpmnKfU4rwNw?=
 =?us-ascii?Q?19ocGyADuzpUcbCVjDqE7YaLjkxCQLjnk40zj66vlTMcluZAoPvAvYqVtRyd?=
 =?us-ascii?Q?uZC1JEMpvHf20dtlb1qkIYSZKSgcMw6vpB2JoMDp/fg0Y8L8uT6uv87kNQyK?=
 =?us-ascii?Q?vizT8h1jHGT1al1vYcnPinaj0SMquO8qkaCJLzjBB/uWMqxIUFenq7TyociR?=
 =?us-ascii?Q?Ql4lgTCrwc11igjr9kdBF5DA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2e6cfc-0bec-4988-1a18-08d97218c3fe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:34.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVvG/85/wgny6UG1uu8swgwyCvpAUz4j4V4WOYKcZNdgIrxTwHVfRwpl5XVE3SWJH84B5IhvV7QeKyraeU40r3w5aBv2oNhOS3WH891wzRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070105
X-Proofpoint-ORIG-GUID: kDXo-ig1ZXN0_pIdmjsi1LTXEUj6YUoS
X-Proofpoint-GUID: kDXo-ig1ZXN0_pIdmjsi1LTXEUj6YUoS
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Set the restriction check for INTEGRITY_KEYRING_MACHINE keys to
restrict_link_by_ca.  This will only allow CA keys into the machine
keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Added !IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING check so mok
    keyring gets created even when it isn't enabled
v3: Rename restrict_link_by_system_trusted_or_ca to restrict_link_by_ca
v4: removed unnecessary restriction->check set
v5: Rename to machine keyring
---
 security/integrity/digsig.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 5a75ac2c4dbe..2b75bbbd9e0e 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -132,14 +132,18 @@ int __init integrity_init_keyring(const unsigned int id)
 		goto out;
 	}
 
-	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
+	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) && id != INTEGRITY_KEYRING_MACHINE)
 		return 0;
 
 	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
 	if (!restriction)
 		return -ENOMEM;
 
-	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MACHINE)
+		restriction->check = restrict_link_by_ca;
+	else
+		restriction->check = restrict_link_to_ima;
+
 	if (id != INTEGRITY_KEYRING_MACHINE)
 		perm |= KEY_USR_WRITE;
 
-- 
2.18.4

