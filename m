Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB83D3E9C58
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhHLCVD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:21:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43030 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233635AbhHLCUb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:31 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2B8Ql031617;
        Thu, 12 Aug 2021 02:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=S0h161gp7WeG3MSzEHzB55cOa3TDtfaJLyXOrfOMe8U=;
 b=jX7Zm0hPVGHWfaPgSYJg8s6GnS9lpUNyFKY6DxT6xWLhiBVpu97dZMAKg4v2uq7GFyXr
 90w2YQwypP01PiISvnDq+DD0LjBAM+9E3/NjB5v3rcSUvxZGXK5W4/uUepoyRM2/HJhO
 VlshLl83N9vTo+r2Dgrv1FebvPCOVDxG3vGYneQIa/PKzONZUZwwzc0K3p+kMbDEx4tW
 t7SEqsW9rgJ0PWCyGuetJ4hpJ+mQav58ilRqLuELU0lJUnJ+WYx6kdykDA0HenWeXoKr
 +CZ5P1pyQFYgDgoTrqsR18gv+m2nfbU+KJkZIqEzPiNnc6+C3dkYgYzJ/Pu2n4Xe6uqN +A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=S0h161gp7WeG3MSzEHzB55cOa3TDtfaJLyXOrfOMe8U=;
 b=v9e5d4xU35mTSaby+ecUx3j5EuKksw3LXwrhZQdC3q7HMTUQnE2psCxZQkHZkpO+TQAE
 a+1j4E0JoEz24M08enmiubcwt0TTRM/85xwSwuKoO7Df8tLbemH8MkeAD5guNhXpYOqS
 cLANgdSIZAn3UzSYzqrikVInjo+ZB5NWU5bYKMKXy7MgQpGT0m/DSiR976xf4pLhV6NP
 hTWgPqndL7c6byid9KjtczlDvAMXdM+paa+hmh0SdjmA039qFSjIYoZ5mWlUhLfF3Z2A
 HZJ7B2RAQRpZIDAE0CErj3tQDIBVsliPNbee8dv4/XX2kJBjq1SDJtQ7SInXXwWsnY9R Iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd649v1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GL6d045017;
        Thu, 12 Aug 2021 02:19:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 3aa3xw9n37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pasqg7tjqdh8i0RF8B4PN8/SDJjcKwaXLgUUrY2tst+EEf1+TIlqYl7I15aGNMsXZrDi3El/YRHzpTIZESPJPJaFK+zgDazoaodL9hQN1TvBnwVfz2lNCmh07PHqAhOfmeYlkL1P4JH1AEcYv2YAQ2s8NHJy0lxxSXZpVihfygXb0BWQveMaR0CNzJITwLrOpA/JSS9YeQS1W52Ho+6WaEsuvgaB+6wcM/yXNB3eb2btv8RsAruvw11BSN2KIi4yg74ppU1HECr5qi8G4UpyMJwKjqjsecv6arAY2jOpbVg41PD7zN6VBxdxXla0ZgLgPZU3cbGGId0wnaPToxz3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0h161gp7WeG3MSzEHzB55cOa3TDtfaJLyXOrfOMe8U=;
 b=JwExITZCgm7OZNxKTSr5rrGiWrx4KRhYQ71RaK7vnE5ZYG69WUEcOQIIfcG9pWzlIAY3n37e4RxWf/PWKKXdXPAp68LHZ8FQKKuOVVW6BrNTZwBtOFA9NbCTxLCBOtfYAFCLB7UotUDPcRgz0AfRZBzq95SpeQ+IwHiT+dEWvMvHB7TYfEmta1X/Plt0UxPCkbuIsiAIztEA/iHfO0/zBKC/UjLeihn+pP/q3kDL6sF9ajL3PS1SR7v67rLhLzHtfDxuNi0hxIbasXYSv0/L8Z6ZKvww11FqCL20VQzh4ds61W26OCVj8GncbLkkSksTdwup6xcwcPY0xnyOY1xWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0h161gp7WeG3MSzEHzB55cOa3TDtfaJLyXOrfOMe8U=;
 b=LDzk9Aj7jCq5WN977sVOQ2Rc8KiuTrOPdcP53s95EJ6VVzTGteMd2Jiuzq6qs1G2zeZgMdUc1n5yhxpO8EXrbWVzZJ1mwiCpyBurMqO26ZXjcAYQ/V8kkwjY+z0vO1BUpMEUb4UuoL62WjFlwg80mkhk8NSiKL3oIAD/6U0ldtE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3960.namprd10.prod.outlook.com (2603:10b6:610:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 02:19:39 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:39 +0000
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
Subject: [PATCH v3 10/14] KEYS: change link restriction for secondary to also trust mok
Date:   Wed, 11 Aug 2021 22:18:51 -0400
Message-Id: <20210812021855.3083178-11-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0424774b-f111-4b23-4ac1-08d95d37a2fe
X-MS-TrafficTypeDiagnostic: CH2PR10MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3960B63F5B1853A9204C6C1287F99@CH2PR10MB3960.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrJA7zdGM0TgvEkYV6WssIDIwcJTbXLrkiXe8/FfywmFSxPzOrSJDf9d2KtQx4pacM4Has+6WxJXL2A3OzAGpSy40JyAc2su+POaQYeDJ2BCAPbKP+aLKpOYu0Pz3ECYVLFoQOND4Zr4WKsIpqEwBNX+017PIrWVyN/3W7Yy4fc0ez4xfMGd/2t/eOSLMn+jx5osRpCQXXKIs5HEz5BArydYkN6uuYGNSk6t1yQEaW2HY2WzuGW0/OIJZhLYber6BgI/nWLm2qaw135B+lLTN6Bcaabpo/UJy1I7dWxCDR/ZqWEJyzQydokKmAfVZE/YHwU0dOsKYSgqopp+MvNI9XxwB7vgVZgbAXiGwW3Cp69mSKKdiUlwBfibZLdLSfzBxkMJq3K1F3wbqucrjfawI+bA0iABwYbJcLHkGYHqA0hvWX2DZgnEPuJxBccIhjXN+iqGN4wxw9qGKAh5z4uliif4peOWBtGlhx74w9toPZ2JUt+htsTCBqZQfuASD9iledRjTGQgGDh29gu+heki6UvxRSGcT6Xm67uGZ/AL0BsgO0zRyD1mmkOdPvuF8o85jIcrgbBd8pBewDoYSfNq1H2OHLy7chAG+K8ycAkB/zoHgraN+lqtaA7bu618QgQzxCIEr+RSlM00uWL6lQUoam9JBR8rl/cqO57JifVE2ncHqWoCb4eKql0J7spVzDxhu7DTja6e4K3C60QJZMCCKucnUS4COSR7SswR7cLYwsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(7696005)(2616005)(38100700002)(66476007)(956004)(38350700002)(8936002)(6486002)(52116002)(66946007)(2906002)(44832011)(478600001)(316002)(36756003)(26005)(86362001)(4326008)(66556008)(921005)(83380400001)(186003)(8676002)(5660300002)(1076003)(107886003)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gr+81CZ53PUc3YklgnrnFf6wIIBuuU86ac5pj1SeijAxVjr3rdUxeKNenJAP?=
 =?us-ascii?Q?ugne8ZURXm3iBlAJUXQy5onR4ynGiYPOZJB8lRameXlugYYnuYTgFYcZFYEn?=
 =?us-ascii?Q?CPGUgoCmVl+lmgmxG42dHMpMizO3QV8Nx3EJo0MNMGFR4ttAIcgVEdV/bv8s?=
 =?us-ascii?Q?Cy3Cc4C+PV9dmvBHBLgXRjZJBqi3itLKk7DbP+yCi2Z3LOIOuunKEBEme4JW?=
 =?us-ascii?Q?b5azBnUSRFLjCa08Wsc8bOT9pJ1xY1cTYK/dhL/0gjp4zTibsOgFhMTvvzJN?=
 =?us-ascii?Q?hJIbRRZyfA9VLoYocrlW7nSZr4ePfwPb1FW96b6ZObG6aqxxE3QDuwudcTL/?=
 =?us-ascii?Q?qIkb3H6nFGNXIEu/R5wzMFkGqU1xxV/iNrWHX84lS8ZrcO07gAd9E8likk3p?=
 =?us-ascii?Q?tcYgUE60cjWqylbxcsFP7ajPSG7DUvXTvQEjtD9ud6NKaqmu6SpQ9K9VOy2H?=
 =?us-ascii?Q?iz+pSXVrKeQp451MH7ahgdwhaZyYkzxHEuX4dGQ3hJVygeIQlhs+4M6BHx3j?=
 =?us-ascii?Q?ryFw46rHBf9Nr83NgpzK3JakIfCiRFNp5LpgYIQz8184eTC4JYRXdPBnEpTD?=
 =?us-ascii?Q?dOUfQY3xyQmnRLRNsGzKhsCy1bHPnnZoqQ0JETqAP0U21u5rakLx1GXuwl0d?=
 =?us-ascii?Q?/nhOXzqSoEaXJKP8qGxzyyDL9Qaq2D0G0ueKS8McHw9+kwdt10X3QaFC86R5?=
 =?us-ascii?Q?kzwrfT9RXuPPfxcII0/LN10cQxdERt8JwwlXraNdmJi2qq9WQgMIaWlLlyPZ?=
 =?us-ascii?Q?R4amWCdmlrAsA3udrS3LM1A7tr3sxgpbp/M76tCjjADv5X2C58+h+GF9fbxW?=
 =?us-ascii?Q?Y2GW21k+e5JTvgjgtzEK+6X0+rQf0HCcDpyCiL/ukEaoN1yJqzRY+piqYTFb?=
 =?us-ascii?Q?DgIO4NwqIKC+Y9EYe6dxruOJ3x4q0taGOz8DkDpJkHk6u+PCFyS+dtqu09Q3?=
 =?us-ascii?Q?TGao7tJjKJfQOG6QvHbHCNbIL5WFxcuWqQZJYDkJZywOLt4S85tnibNraZnD?=
 =?us-ascii?Q?tqKpmClteHoSOgVcF0i781p0Qs6A3BYl2AasRkOXegdXrOM0utsgss7x3+Ma?=
 =?us-ascii?Q?Y+D8KsbEU2EMzGUglWDeI8CiPoJxBoEf1fumZkXa3wsNM3XwTxvqXWUJbn6E?=
 =?us-ascii?Q?10AjMduiij4d+kMlBgQ7LSD3LAoNdzJQFn/mBDFXA86V6ZiIoLi/KOczdd4R?=
 =?us-ascii?Q?ugkDTUoRkFBYkTEMT4ivT6L6CDF5Wutbea3ws0lirsZw5QiytStMh5UBnZb/?=
 =?us-ascii?Q?PItkIwWsRzSfg+rcmaTI03bDscziCBksohxdTeW8W8nE4GK6NzgIFGLBSp9M?=
 =?us-ascii?Q?0bIDNUH0txuNn9SMn7h0aQ/o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0424774b-f111-4b23-4ac1-08d95d37a2fe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:39.0626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zhng8PDTaq0kwiybDyA38Z8SMfXMKQ9J102RUH6fYuVwWPdfUp7dbfY8V7c/vmOkk8QJuUlhhFOHav1vRjTpQTE7vw7XfxUo4pZZroRzlPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3960
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-GUID: n0SAhQJN03Lf2BtcECvmmfot-HbgnfCM
X-Proofpoint-ORIG-GUID: n0SAhQJN03Lf2BtcECvmmfot-HbgnfCM
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the introduction of the mok keyring, the end-user may choose to
trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
trust them, the .mok keyring will contain these keys.  If not, the mok
keyring will always be empty.  Update the restriction check to allow the
secondary trusted keyring to also trust mok keys.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3: Initial version
---
 certs/system_keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index cb773e09ea67..8cc19a1ff051 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -110,7 +110,7 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 	if (!restriction)
 		panic("Can't allocate secondary trusted keyring restriction\n");
 
-	restriction->check = restrict_link_by_builtin_and_secondary_trusted;
+	restriction->check = restrict_link_by_builtin_secondary_and_ca_trusted;
 
 	return restriction;
 }
-- 
2.18.4

