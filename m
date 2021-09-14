Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD0840B9EF
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhINVQx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:16:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43052 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234572AbhINVQh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxhaN032058;
        Tue, 14 Sep 2021 21:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hn8O3/aY4KyB48dt0iaqSV1eA5wBgjSoh2yBKjnOEFs=;
 b=zoOntOw7YldhUgc/GroFICN64sYi54Dl7jMP1KFh55lqtRkK0RSOPOJgwPcvspg1olAh
 BNbRNMBiagsEXnh/C0sSuHGs4dHwWO0BDFB5zHPP+gyU93n7esU8XJJ5e3FnHltLofpi
 DBAxvKDY4S1qzWH6eMrs/R2wixeF77CI6xvFyhwAvb6OCDH5Vfe19DyRwa2Vmjy+9pkJ
 9UmVGPdTxooTHvMVKkCSgpVo3Z3GtrdJapARt7hdaNxtgQOUKL93rvFBnJA7IHCR5YQz
 eGIZp0Z+sdVqr5M91wqeZi4/YeH0vnLK3hXK3dBlHO6r2RvW6lgIg0SJrH+WS6IIr0xC AQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=hn8O3/aY4KyB48dt0iaqSV1eA5wBgjSoh2yBKjnOEFs=;
 b=ue9iEi7qUjF4m4Ad5a5jYVITKslceRfulbahWSTfpJ9wXFRAMBLm8XvOQCVRgz3bYcJ/
 08GupX+omlfuc2lBHfuD4k81ohfTkqYuAusUuaUa+9D9Ff5YxldF6TmowUtku6n0IGqo
 ziAg1dPc+Bkgg0mDRlbx/BCk8Mjc3pqJDpIgm5n+NjG4K5+mhW/j+Vv9HZZH52fl4njo
 +X6FY0ESfD68rqn1jjT/So0+ek10mEzhNVp/w+2Ux1+D4NFNH+qO6B5VIX+d5pmikPvA
 pJLl+L6TStr9kfTYpQeBAKCA4BHQM0poRGoKmeCJbCN/CNCLndp66Kl0TlcKx9UxVh/p DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p3mk1c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EL9UMs196479;
        Tue, 14 Sep 2021 21:14:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 3b167sp7k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoW1O46KSoR1lXq90Vx0LwIPHojJWnpJa7j+vcufuSMEzAiNgba7Obida/wEoH3IoLRhqdC4ST7FO06e7HTGRQwx72ylK4HZjfMRzLGByCqrZZzKMN4GQSHLP7nsBjrVEVXcKubj9IUialnhoTkGF+vFjel108kStVEPxHatt59ZqLD21xZyw/xLSSQ0ZGuvPKz4YhZA95MIpLoJCRpgPKknG6cXDhFfSwqqfz6br+VfDaBSaMPjyHoUJWB91kSQ5jTHKcgfgK7IYIERCZHMwFibZxP+jYZ3N7N2zEuv1O4/R8AbGwELt+j/TszzCvuClC9yoUHMvkdLqXJc3TtM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hn8O3/aY4KyB48dt0iaqSV1eA5wBgjSoh2yBKjnOEFs=;
 b=Veb8ZZNqHNSftQe2IvMSCNjwuBOe9t5NtgBui2RUiza3w9ZhbeQyWx+MF4s3HV54LUaLl6imsrwiVTu5suhESjuCSukIersMHZ9j8F6hc8D3yJ+dIK784cpyq/m2A20u0R8AkArQBOWbd2M+pOGhMGvqHX3K2ORHLmhFvdDYW+dWH0sYJAOKan0jXetL6W566pEtJKmNWqgUNy5o1gdPhAUUhUUhYxhEDjYT6yPmUENazDLcTx/jJzlUySTwyapkpXudT9gDjSiTPgs2sr4X5kjK2Gk+CKfdQfDi0QZfJXyAgXxZXskXO0rrZX941r5rSjIKxXVBbnDYDA5kD93vuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn8O3/aY4KyB48dt0iaqSV1eA5wBgjSoh2yBKjnOEFs=;
 b=P4ff0hoERsJZwvUP3AhBR+iM6jE21bRE6ApKmR1aHonLKFMf0pBTwR5E98c4Do8eI2Y86Xg/7zvy4t1RcxYF4UwHQBlEMtQKYKP/HhuSMSj963OMs8ofWlquyqVTfQlEoBuH8bc225Bllm7D+6DcGgeIGkas3BBuz0vyN9RfNXg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:14:46 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:14:46 +0000
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
Subject: [PATCH v6 04/13] integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
Date:   Tue, 14 Sep 2021 17:14:07 -0400
Message-Id: <20210914211416.34096-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:14:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 391fe8a0-9b05-4a11-1249-08d977c4adb6
X-MS-TrafficTypeDiagnostic: CH0PR10MB4908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4908B19019F644D7DD95ACE087DA9@CH0PR10MB4908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWukFXKh5/h+6xMW3frji1i/HRkpJ7kCkExRMnpNKhSBwLk8KF69uSMp4zGG8vGpWu3dMPWaJDcKpO8BGvfGJbjSdjL0khU9P2py4NCdU1AVIMC6F7pI2nonxrRtxiXpkT0bWNZw2YAofIlvaS18tqozds2sdyTetp/9v1UwF53taUrLDM6bs88mx5DWBmtRUoeLw5ZNlxOFfGAlpMVVL8HrkQss+jqG60ock3xfGsz3N0/15HOvYfmg///rQGoTOfEj61qRsqRlTpx+ipNWtYNucMcGDOdjGZutGPF9jCWWAc5EaryclP+/Wzh8qCImSsjncWFj7d+b1ka3ng/HmNvSePW96h2xVbLjGfc0zjqe3DAfhf1++0evU0DOGWNOyCSyYO3moIDqU0o3xiN8AVn6Rt+6hbsTvnUAASOeOTe5qlPc1Fn3+1jVMz0nJFreNVa9fkjYcQ0/PFUlNZSfcguba9vPLiHdQl6DS7lv+WB6mjXXGbEI+D+Ja4fQeSnSE524BXsnqUDMpUzV7ormHdOMf1wLtbhBc5YuJNRwsi9d8ZEgahwMhErDg9O55qWQbOm2QcZ8KEfm2G11x7AdFkIYMXAwlHtEaBUA5pc8gXKeIQREaVh0R+DMKrC7nwLhjCDWJqYNHLrhUe9eDGsMNhRr3sOJ0YnPHMBQ7Ydc1l7DfhTgJEsJclqahpCqydOeG6wwpy8tXKiq6JqD9lCNFOWL3cyn7GV3ccer409Wl88=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6486002)(4326008)(6666004)(2906002)(44832011)(7416002)(36756003)(66556008)(2616005)(8936002)(66946007)(52116002)(921005)(956004)(478600001)(86362001)(38100700002)(107886003)(38350700002)(26005)(83380400001)(1076003)(8676002)(66476007)(7696005)(5660300002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jYXbSgfwpEH2zs2pFzcdavKgR8II17m3BZSeutNtb5xN+8NxkMMSfCIM+AXb?=
 =?us-ascii?Q?+LI0bbXE7dsfz5iXk6J+r+8R5OcczzzWGs8J7OGIaZ1TznScPfsJmYssgg2x?=
 =?us-ascii?Q?m37Pf8Fgk+u5ypovswnH8+weNm57bf9lOMd6PB+sqJh5OSek87LZQg5Os67Q?=
 =?us-ascii?Q?gDCoUtyzNP/p/aP61Wx+4FBv60fAiQGxko77rmSzpldgr50gbP+n4rFpct4r?=
 =?us-ascii?Q?wGAqC8Y9rfHLeEyeZNNM9WqVYI4xgLzplbx2srh4Z28AuIP7eZQ/QeC/IR7K?=
 =?us-ascii?Q?DWFEt3iYo6foPBg2Co67p22kuRZRbkmnHvHrwumCtOPDy19HS+D+uTSLsfCl?=
 =?us-ascii?Q?+61AI5Cbsrv+XlqkFWZkKTZR+fhTltsWZw37lPpg/sy/Y1WR1ZPwFkvnuzd0?=
 =?us-ascii?Q?btpczoopUG7YwzC6jf70uwFHND/aYk4HaWrAUQpkqjQBCzGSVZ52NMSC6s8U?=
 =?us-ascii?Q?B26gZgWZGSs/cz9lDNGY0yeL+hgBk49sUIROnDxntjH4HXDhiintP/1zk3GZ?=
 =?us-ascii?Q?ZWkKeh6ZftuHait+OFinfRACRAdhqBYFi+goDugbmqHdjtS2G4/yqLJtBAU7?=
 =?us-ascii?Q?OMSeKwejH4kICLU2GXHH0ofy3K5S2wwj8PZWw6gzOcL5PG/xGlQ/FHdmBAP/?=
 =?us-ascii?Q?p+1KXmGIxipmM2BiKWETGKYtBdZ+TfHUMrosBkc4fTattXcOOPvbVlB4P/iD?=
 =?us-ascii?Q?xE85fZAbTx6PDlluFwQDzsMwHp5fOVEFofFBGuRabb5bGPxTae1U4zUexjNP?=
 =?us-ascii?Q?TUM8uv0B6500Y3wo+7MwaZQRf2FLD8py2qxMv+6R92nUETuC/dxIo+9emyCS?=
 =?us-ascii?Q?W1FrMpNfaLcb9R10qkmjWtDkw8SFcljnUkDD1aWZgYwwxDNXPl1SwdLFN0NX?=
 =?us-ascii?Q?JvmIbQbUnPA/xNVWK2R8SD4jccoo+E4CZUnVNcPO+2LHdWMTo4iKCBpPaBnA?=
 =?us-ascii?Q?DSafAwyYKt2sqmJPctUd7vWj/sY3qK1RKlYSQ4I+cH+ATn2X6o72jU3j5kny?=
 =?us-ascii?Q?babddEAKmHIWdAd1PXIdyqDnLmVg7/be6kDduOaCZ8PyZMhaEkp+OIV7z9V1?=
 =?us-ascii?Q?UuoL5gV1DmzuJlwAq0z0r98dV5zpwa5yQvrn26VP+PezIKrh2ZdM8Cd0Vqq3?=
 =?us-ascii?Q?P/B04hmU3ViIJjUbeoDCmcNvA27u3qMKiU3HrhFxGlLNJ/J8Cc2NBE03PitJ?=
 =?us-ascii?Q?CscC79DRlU9Y8xNOZ32fu9R8FmXSLQz+oNHQjvA2dRcgdG0Jk+5WgtW0NIvg?=
 =?us-ascii?Q?zMdB248XIvP25K8tfjyW8iEZNqXbsl/wT2KloJS0b+/Eo691KjRN50ZMHlpJ?=
 =?us-ascii?Q?Sa/vn6kJVQcH3/4zebQLrzx1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391fe8a0-9b05-4a11-1249-08d977c4adb6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:14:46.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avvrmOahfExnVJTFtlrrQA+XSwHpZz5VMIP3u7sPJLxWXUSCZu2TnMJbs2oMeizNiK7sCun8TD4dGxy9fimlYqRsfafrlgPZMyJRd9ptTlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-GUID: Sou-9bSDhlmoNvKwxhwYM3FqfgHEnQ0D
X-Proofpoint-ORIG-GUID: Sou-9bSDhlmoNvKwxhwYM3FqfgHEnQ0D
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
v6: split line over 80 char (suggested by Mimi)
---
 security/integrity/digsig.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 910fe29a5037..e7dfc55a7c55 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -132,14 +132,18 @@ int __init integrity_init_keyring(const unsigned int id)
 		goto out;
 	}
 
-	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
+	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) &&
+	    id != INTEGRITY_KEYRING_MACHINE)
 		return 0;
 
 	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
 	if (!restriction)
 		return -ENOMEM;
 
-	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MACHINE)
+		restriction->check = restrict_link_by_ca;
+	else
+		restriction->check = restrict_link_to_ima;
 
 	/*
 	 * No additional keys shall be allowed to load into the machine
-- 
2.18.4

