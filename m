Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362D83BE112
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhGGCsC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:48:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62660 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230081AbhGGCr4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:56 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672aK8f015829;
        Wed, 7 Jul 2021 02:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=iuE+tGZbVbAMa5zP1v//f55T29uLk98NDB6zbGPeC/0=;
 b=X8rRucTXFtoUwqPLMTqRdm6oacpfYr5l0ute6tWPE3xs0BNxuV52HGn3NZ6CY56phw0u
 dNO6VoN5xNflcZgQba5j6b5f658awj+Het4lpWqdndG3Cri74U4uzujYUz2QJ9cTAKFF
 aj4BT595BH/UX1JYvPTp+wNyZe7A3S6iBuUizaD+AIc8uF5R28dj4WVATkisp2vN9vcv
 jCO0wG+lLe+asMEqonruucu9ie3+z4bSQ9ztwZux4MPuzB/+ltATePZhS2OIsZRVFKG1
 fkrzD0OtWOQxWxyFf8xyDkV+KLxmpMO0L5dxs5NorA4ESrp/HcMJ/xA8bdMD/WVRXB/l fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m27hb657-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672aTIq192975;
        Wed, 7 Jul 2021 02:44:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3030.oracle.com with ESMTP id 39jdxjaard-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSC7znJw+5BLshEgB3UM3DpIkWH3L8+Tjc2VMiKzzNrnzM0nlCiq1jarRtuFU1DAVpgLFu1iBWfIpEfly9ZWUlIVyxFeyXgn8Gr7zDm1HmViwYqcY/vxX+kuotQhdjBra9p8QRY8Yz29jlpnLXzYaAtYgTqZCXjW42tsPCNA/8ALyetcnBhAgab3GRofHxqpBi2ayzPtgDyMKuejQsqnANJAtRbedFy18NwlJ4SqlHFGPDnpn+2oE7fgJTWgaBqeyaclfpCvjWdENBNsa7uoDrDOHXa/NPXEc1qnhtqHHDx0BOtA2DKxbn4Z4PW1W4jYIO8ehEH3P/9xZ+PV39n36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuE+tGZbVbAMa5zP1v//f55T29uLk98NDB6zbGPeC/0=;
 b=BRDonWi0nxExAuWsOJGqCr8iMilKMEFnirZP93euJkCdY4BeLUVWXPFHo1gGVgGzUVtdnbnZlEbPIL5x6LnIeLL9RHIlg95VcnzGbkAIXqxvyqkntUMzeNrOqSnF0Hp0bYMZ7B5qe8puro88eG33MOGd+tCxodXcR72a3u9WsZ+xjMq8NYtyHBK87AE31hZNopLrBmc3OT0DGCWI/3BLxHG/YDnfe0sDqI17SiXa5WBW/YKCz4jnICthw72w31ynmmg32ZlJr8moJV8KI1/Xb6nEG0TQcA0HgdnkcWuv0eGttX4BqqRhpkGorYnmXHvOuvUl3mO/XFhPLk40GP7lIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuE+tGZbVbAMa5zP1v//f55T29uLk98NDB6zbGPeC/0=;
 b=cI2Awc0bpSStbut417J+PDCzNV+mfMCGT9QpPcPPqz62U8PP9uP13AiVVQaxU9bGFqROdzTAp5ORgW2AGeuM1kzbh+zXnK4Ont3DLGM0NC4VWASdiWkAseXFN6onukLml6YKT3yCEqiI54+J/PT171tihej5EH31gudRwH+msJI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 02:44:50 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:50 +0000
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
Subject: [PATCH RFC 12/12] integrity: Suppress error message for keys added to the mok keyring
Date:   Tue,  6 Jul 2021 22:44:03 -0400
Message-Id: <20210707024403.1083977-13-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3240b108-3afb-41cf-2a01-08d940f130aa
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4166811B531F59DDCBD3D195871A9@CH2PR10MB4166.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WllmmNFP7FydVnruQwBPu6vb9hq57CA7tq8/MHTDZfEQFZX56PX4TlahdANdjEnNdY/i+MyUA5MK3YGPM/9NqZFAGtHYNTq9SbvhjeZJXkMuVX1pWJovR5jbmFBfzit8k+GYMeusRyxL+W2x4vg6u5UOUR8Qdjw49dqjrph4VZkjZjexZ8A/4mcCiVNGuh0Yr/Tl6x/gCrY2zr3KK2i5RRWXy90xPSSHZAvVuxRpHsUqD7rAQNHX39JjeiJGz4Z4SaLMZU/aCf0U1vUXKBL9qHl00fhWgjtEiwr9RJ55nIR5QwOq9/7FIUUNAaAP2KI4rmdBpU/TjEup6ZFFepk9xJSB8nhAXJ4JkmhR3Dl+ZlSS9GuRwCxcItUGluvVF4ntxzcua43krDkj/Sf19m8aB7g8yvSekze2q56n4Kp3TDiR+sNw/Pdzz+g/HOTEUYY+wTxOzOcrg/P/hYti/0n8tEoV3c8PY/CCxGX1yClLmjMbNCofujuZi80Chnpf63Uuai/4paGDg4WF0yoo5rdRnIaHT4O4TYroQ66VJW8DRjSHkHss5068dsCKnH+HI/810m2icb9OTBBDngKUL4Zk5X5xlbbfrIZuSgUpA6t6tgTfwhvAoSWgw+JUvafTb9p7rVTYdlb8POEXvw9AAUSS9iG655w/oR0DlhwfMzBNJnIRvsZFsbXqrQYfoCvsK/vZoV5T3+TPxBY487lL2Hbyxy2NvZluI5l4UrB1mYI+K34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(36756003)(7416002)(52116002)(2906002)(4744005)(15650500001)(7696005)(4326008)(44832011)(38100700002)(83380400001)(86362001)(316002)(6486002)(38350700002)(186003)(921005)(6666004)(8936002)(956004)(66476007)(478600001)(66946007)(107886003)(66556008)(8676002)(26005)(5660300002)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NgRjvr2yUPGSUPGLz7rDbc2IbKLMsTy/bRUHqmWkZjZAYFiwGbRAq7oji5jQ?=
 =?us-ascii?Q?go8lQ2FyPsC4aoRX3EGQ+4PuU9rMFgQ7ZS8skKc5Z98es1N4tl1h+wtHLPv6?=
 =?us-ascii?Q?NxpTsEeg1HEtA3TUkMoIiPXBIpA58beRIi91ifhrH3rt+3fKH26qcr90pXty?=
 =?us-ascii?Q?dttWPwoUYBIp3Skv/XdSvE8yTwoE98Tf4NhzKPg2CUYWqrLyf2Ybkf/a4w5n?=
 =?us-ascii?Q?xiiq9PFAHDx5GN20hy59ww4GzTHkpt4phbcAt/Enp1xH0RnGpBis0UfOlB5X?=
 =?us-ascii?Q?1Ce1V7WP6/n74zP9cBObF34dMS11nR3SXMCA7WlFzM1WCOnMvk1VOp0gxxmH?=
 =?us-ascii?Q?sqdrUXZK0wY5j8S8A2omoYem5Jhs8IwlHK29mFlP6sa8SrHG3vJjVOW3pctj?=
 =?us-ascii?Q?b1yQlqaevBknYacmmO74Od8HHgLxG/B+BHn64puD2Tg5c6BdOzp3qEQ0nLRX?=
 =?us-ascii?Q?A8T5rVdXKbfoynycxBymlI7z/51wGJoQJI2FPSDFCCYfMRxna6//2Q/nAhzf?=
 =?us-ascii?Q?Y4sZ30O83LIlriN0YLKFSEbMxLwHWO1hxFGiW0q4BomzOx7V++l+Hro8Xd6R?=
 =?us-ascii?Q?NJFH/O9lH2K+5OZYUosykYK0bWqeZVJxfm4Zz44t0YIkRv6iEjWAkXH2iBHd?=
 =?us-ascii?Q?r6GeGRiunzx00hgKrmJxjBfwZS39XpJ+vErzSdbMsgCp7S2lpm4cwqtHtymd?=
 =?us-ascii?Q?Xc99B3OR61IOBHahrfC6t9hJrrMOjkv0K8gnpMHe9kltYuFyviRARxXDTQDg?=
 =?us-ascii?Q?gxTm6yOJXutGqazEsYdOayVir2loKFhEiYqR/JrKUcpgz07pzXJfgGS5X7HD?=
 =?us-ascii?Q?wpJKAHzs96QwlFWY0tWnnFFeL8vhO2Djo/NswnxNs6wFu8y+zZtlo2yVHOzS?=
 =?us-ascii?Q?CA2J99n6gUndvkqHWcDCc5hdSHdkTgYcbsR3vx8vg2U7D4evE5HpP+RUIl6A?=
 =?us-ascii?Q?155TeafDY13yOKMfvej6oKO4Jp0bVanQXSpOYhefhkL/DcSHNjkGfAvMnKLy?=
 =?us-ascii?Q?waO0cuqf6O1krFxWMjlUMV28ru5fI0XmhJL0UWSUMk3IhPu8tXJTp4eorvRe?=
 =?us-ascii?Q?iErd4YUwbx+f1nGsRUm2oIqVQg+D4SN7FqImD6xs8Gj30EZOr+scVAihD902?=
 =?us-ascii?Q?WPuuyMqJaIHlQHU/FMSs0RLZbcKXD9fN4lTxksBbMfrms0jid0SJLm5u1Nk4?=
 =?us-ascii?Q?1wrQrd/ZwhRKKu36m/LkvjFbQ+8PedGu01EGhSM5XU9aMs7ZsOn8R5GXaoMa?=
 =?us-ascii?Q?EcAApamklnFD4JWGTKzxsZlsSkucqKMOGhAWvRNjsbFhaXqkDDsnNGZl9V+u?=
 =?us-ascii?Q?t7i/+DAPLaaCvYfxeoP3YMin?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3240b108-3afb-41cf-2a01-08d940f130aa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:49.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2jS1ZB4nq0Vrjnwf+6p7qOokn46Os+CIsaFOHp6X/wHGVYuvwyUf8xIv9MAAIFoYAyDz3rbbKi0YhaU9FsbUNuGkHhqT9rQThM1LkPRZd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070012
X-Proofpoint-ORIG-GUID: JN4QKQ25D4XKEf5PHZjevqtW4Zc1FEIM
X-Proofpoint-GUID: JN4QKQ25D4XKEf5PHZjevqtW4Zc1FEIM
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Suppress the error message for keys added to the mok keyring. If an
error occurs, the key will be added to the platform keyring instead.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/digsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e301cee037bf..50bdf839fa44 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -173,7 +173,8 @@ static int __init integrity_add_key(const unsigned int id, const void *data,
 				   KEY_ALLOC_NOT_IN_QUOTA);
 	if (IS_ERR(key)) {
 		rc = PTR_ERR(key);
-		pr_err("Problem loading X.509 certificate %d\n", rc);
+		if (id != INTEGRITY_KEYRING_MOK)
+			pr_err("Problem loading X.509 certificate %d\n", rc);
 	} else {
 		if (id == INTEGRITY_KEYRING_MOK)
 			rc = move_to_trusted_secondary_keyring(key_ref_to_ptr(key),
-- 
2.18.4

