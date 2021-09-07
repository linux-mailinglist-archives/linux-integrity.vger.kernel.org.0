Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0268402C6A
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245162AbhIGQDg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:03:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55408 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238278AbhIGQD0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:26 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187EjdUM026789;
        Tue, 7 Sep 2021 16:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4RRXq/xu9OMsd4uUgy91ELS6VFg3kMZpRpnjzSYmtDk=;
 b=cQyUhsNRaAu3p+BIQwPoii4aVolR61dt1nEHhRs5FxUS6CjsVYCdlcAVb/Wb/9NEeLco
 PJCZEyCJDg8ax67WtdULpVhkgVa67YU6J1t4Qls93y60CJjEQGvJubcb757L41EGV/Cu
 dA7DlLMwbnzBxnH+5zCfV01VbQkZdTr4ZynPNiD/DHhg+NQkWnh0tMy8EeD9obk1KSmL
 FVXPKA695i3E3s4xHUvWHGHY4XRom7nrf+lUSUFHzogGkJ+CWvspUdruiA0/EK5E3LDS
 cNveI3w2KDRqMIZSBy6NGm1KGcyjawnmytAC507ys/xZ/eFoe4rp28qWzYbwPyAIB3KN Tg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=4RRXq/xu9OMsd4uUgy91ELS6VFg3kMZpRpnjzSYmtDk=;
 b=oM4w1/gr9WLFn3gI22LEyulX6rpXYZhVDudVF0UG3Mb/CE/d4mf6fA1JusIGbqblnv+6
 nHrLgYEfUOC9hkGEYZfJ2/KLNRJ+R2hg7PX91DY7Xlx/D0PIL7jFjlhybQcfiw8X6ZLu
 rsyTg5UoBGsFsPcAWtRp6eXU6u23ntMe2Zm/0BqiiFxkVC++W3CUp5V+VftmA84Q9ef8
 /8x6zJq4iMQBmGyY/qocEOBFtVzgGVHYnTB/DG6Y1++/izjcgUdusxUJk3I0jstkx9xN
 s4d0HfNSCxHJ9wOk2iTGbOJvbXMY31HvjqGGugUxY+pKFuty9BODGs6fr0gh6KoqR/Bk 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq29jgca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G0lBF157517;
        Tue, 7 Sep 2021 16:01:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 3auwwx487u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzGf6d9XA1D3Y7P0VBz9HYOnt6EEN9RI4o4Zu5OMDzuXgoCgRJph1FlQnNmtK/C62Ot5Iq+g/B1Isv98ZO6Fkb+0WurCpdAsplF3HEFajfSwONnvF/PtB6r6ewxzTYgg4vYwblBjo0JR92J0H+dYJmGimrny/hyDefivI+mwjt05eERck5izqRuX3ueJFUeJJrkQgdp/IuHTgCt3QYnAvNIfoyAQb7iZblstGDyW3zqvJlDG3f6inIT+db/mgHsYXGQcr1A7KA/KrX+1HoXEmm5tc+iPjMorgI2KQ4jal5kfce8ULI9dNUYLKxyoFwsplb2fUeyUq+5n7YjT3e5heA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4RRXq/xu9OMsd4uUgy91ELS6VFg3kMZpRpnjzSYmtDk=;
 b=ncJb5i2kg0tZIr85qNjRtwskzBSZySA+Cpbo+FeFzNQ3z13Udyp+UDtCHe9b+rL1LJxQxYEVEcY3Ib14lhJTZqGvb+qN6RRjZJy0aUBZjRNQaoK9VSVB7JF6lhOTER1TVCwNgwm5Rf/yj9dR0ePBnN+s0TVpiQVmUqUcF16hzSLlJmbURqO/Zi95sfgzfDoyhOocPyNs6jIxa6FzwCRwq6ibngiS68tJCi7WoUwZtytpLTafap1Hi4p/imuVQEk7D4inO2RShyr0EsNKkY2LQs3wBbXeCN0dc3orW6uqPUX/ijEykS4sbBqk9IrxUHPAY4RTOg7SF7PiB4kBqeVfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RRXq/xu9OMsd4uUgy91ELS6VFg3kMZpRpnjzSYmtDk=;
 b=h/8cUScCPpR3XDqT+BSXqg6xyquu8kjc2ECrsguLUMrC0Z3udztqZo37yc/XvcuOXPStriCa0iIYtbzo+DKTzpD3uzpSKvI86XJ/+dzCs7d0vNq3Dhqc/dEqcrGoL4tJpypcAThjUwA2Z8zw1wJT1sVhYvS+DpCoAzeubOsKPMs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Tue, 7 Sep
 2021 16:01:50 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:50 +0000
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
Subject: [PATCH v5 10/12] integrity: store reference to machine keyring
Date:   Tue,  7 Sep 2021 12:01:08 -0400
Message-Id: <20210907160110.2699645-11-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d20db01-30ba-4129-3829-08d97218cd47
X-MS-TrafficTypeDiagnostic: CH2PR10MB4200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4200A7993B1316654061691187D39@CH2PR10MB4200.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpsmYrAHUdzlD5zU0SaTfZf1adfzq7G++XNKCiokVXZvMgZ35AmF9+orW9A6vTxjJOGD20Rcodk51cGpVdkLib27qtdsgHFL54jB3BvpKQWUghV8GcANV3aVbuR5ICRu3nHLgqN2Rak77rPKpCTtNnMoST0b+jrBvK2WU+bi65np0j+wqqc6n015Mblt7MinNiJ+3m4+Ng8AYJuex1gbztNuAe1llviDOuUp9sHg54O7etceeRui+It60JDoSVmOjss9GE8Y5ObJfS0vMJaLl2PShLtx79usupcu1WdmFRM5KjSMkGcyF99rwyisksAX9P9kP/z3ecufs4eYmUHt+lgxoNQ4q7xjjZyYYuBLLolqBd9gbW+tg9pzYOiEz0uMqnmzWj1d7JrXQMiJq9n0CnW673V3hK6cFwtg2xw/Nlnw9usQw/xCtHEIlAbY8klX/yx0lJwLq1kld84XTrQ3xd9MdtiDjSBQGLypjHkJkyzoFo3SsduMOoPvRWCriESyjm96ktW6qGG6x5RpPLq8HPagDDQSL4IoAVQPHj0bDGvWwKW3mN8N4UCGT1wi3EH/8SAkRa3uw1AJuoNUF68nKOaUlIp26SprkbI1ZOsSpxsPaQtZ/LJm6XbORZvumqPMw7JJgqi4x/jjClTS30CHPBtuCIXid70ftDo47v3s1I8X3btWYZ7eQsHHwK/N5pkXTMlfx/tSknhIhy6FzMh3BT7DrfXsdQ4c+awYBxtI2QI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(83380400001)(956004)(36756003)(4326008)(8936002)(7696005)(4744005)(38350700002)(52116002)(38100700002)(8676002)(186003)(44832011)(6666004)(2616005)(86362001)(478600001)(66556008)(66946007)(316002)(7416002)(107886003)(66476007)(26005)(921005)(2906002)(5660300002)(6486002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9nlEA5+MzqcnjzeyxGFCTlYLSjZGWT8jCtTT/ENwvFkFDc2GjHldtffOLPRe?=
 =?us-ascii?Q?ouqZytPrHuiPl4TIdA47B5uRAyDEWVZ1Q8bgqXKzB2jE4yoBvVuVWkVYbuCO?=
 =?us-ascii?Q?TdFPV/tew1wOUo91RLF2yeKqBiVT+NoBQs4sgzFpbImZV7L0gwxRo7wJlrOj?=
 =?us-ascii?Q?VhW82tWKH5oU/DcVmgN0r+xTOg9Z4t9oMXJVU//ScN+pS5fPKw3Ep3YytPm4?=
 =?us-ascii?Q?fEXkcucyfloisUHRjDOYoHe12uE4RpT9lvlPwWTQ4gS4Vxtk92k59rtxE3o7?=
 =?us-ascii?Q?8NY66oxaKaG2agPKUqMBOpN7rbaDAhiliBqYPJoTZmI1TLoBwnE5r9aye5Kh?=
 =?us-ascii?Q?ijSFsK1c1YcGp/a8m7q5s38oUQCgFqOPZoS8O7rexHe/6Ant0ivvLm0guSa2?=
 =?us-ascii?Q?cTxH4bTqexFXmWaOx4ifDC7C3e7NWKQgkH/iWlkXfT1iY2SDPOerdlPAileA?=
 =?us-ascii?Q?me8Upxp0KeugyGmzJ37r3z1QR04jYB4nIb8A4Aa96guIoSOcf0ZFEwfFWUit?=
 =?us-ascii?Q?jEuR9/uHHaB1ZPU2CNx2de4f/nr/nY9FT02DYRibNVxpupNjMqaXxW0W9Ozt?=
 =?us-ascii?Q?h5zxlGNQsLIOGtMYynhFA+RstzizUBLrvUyF8/Hq893gaRrfs8/rOTDW3aSr?=
 =?us-ascii?Q?Cp2zpZoEk5zsk0JiJ0Bzjs+iia1H4Ef9x8jGH48Lb52xoWpn06thWayXwhy0?=
 =?us-ascii?Q?RxMfrl+CkdP2RAAH/KKjeZRVYTzVUEkbEN8HlSoct/HuBuQ3vKCPuwOQXmO2?=
 =?us-ascii?Q?wNgZhHSpDsiShFE7gyz2sVgykZYimV+fQwh/ChEF7LUROa2GwKADy/mP8vSM?=
 =?us-ascii?Q?HcQYhZcjRESYaUyCUFkwMM4+V0Q3gcsPsGAmfb8RLsGT/4hXo50j8CVDJeZd?=
 =?us-ascii?Q?YU8kLaiyUODMR+PHKGzsZERNy6X0v98vjF1q7x8YEMsE8yEuvK1hCeeUxoRx?=
 =?us-ascii?Q?0LefmKXxNjm4buiC9JD/jQl+MVaPPEWiXg1quFo6W8/RrLA5Um/phDMgfYMb?=
 =?us-ascii?Q?yXDvlzRpOQ3uYqw6aMgF8Fm6nY+2BXXJiUIBGbBqJEogic3NPDuOeL9Jknwn?=
 =?us-ascii?Q?W7U2bglgjAagopEHOHR382bxZ6lGixBehn5/g/c3GyfcVtb/lkFQhKCr8euG?=
 =?us-ascii?Q?Nbep99y4asdbR8r6URK5iNCLJ9KVg2BxPA1oGbydZ6xM65pzJh9xqLYScE9X?=
 =?us-ascii?Q?bwFHr1nIcUbQcmigjsO99OW5gwoe4o6c3RGbL8orsZ3S2P71G+OvsXhCzYG0?=
 =?us-ascii?Q?c/qqZhF1S1DDKZ/tYtyFyfYr2Ro/p/mBbcTd2YKT3JlvruYMMx8gOdO6N1b7?=
 =?us-ascii?Q?FizfsgBRnrwoE/V5bAMSybEn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d20db01-30ba-4129-3829-08d97218cd47
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:50.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXU45Ri67vkHh5qySve8ZVvB2bctvm4iVIfsHvAYhnzUC2aNB3GDJhJLbc4BeFxVqcM3FHkXyiPg57GzXOPg5G9xcj1eJ8I/JaMZ6PA55hE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4200
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070105
X-Proofpoint-ORIG-GUID: an7kmTm7bTHX2tLtYW25WmikusDD1yzj
X-Proofpoint-GUID: an7kmTm7bTHX2tLtYW25WmikusDD1yzj
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Store a reference to the machine keyring in system keyring code. The
system keyring code needs this to complete the keyring link to
to machine keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: Unmodified from v2
v4: Removed trust_moklist check
v5: Rename to machine keyring
---
 security/integrity/digsig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index c3c1939be2f1..0dce2775f3c2 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -116,6 +116,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
+		if (id == INTEGRITY_KEYRING_MACHINE)
+			set_machine_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
 	}
-- 
2.18.4

