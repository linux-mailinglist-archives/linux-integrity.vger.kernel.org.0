Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E25402C8A
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbhIGQFX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:05:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29152 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343702AbhIGQDk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:40 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187EjXsx015634;
        Tue, 7 Sep 2021 16:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=/bL5L2QfTiQvQG9tQdISkb4NkQePDVJI1ArUkmtKVYI=;
 b=ljAhzluoXybPr2HsOmCEkJHOZkhm/iSpGSC3z2OLfYCYx6Nf+6Obx5kxd3mOuc4r6965
 H3MxIm7XGQBq7uDUgwxsalAZavD9HZCXsE/rrMiNpjT0KNK7sF1h+UpKHvZjGrKLgl6L
 IqabNWRnDi3P8Y0/4w2pyyAzmz17SWHRSL6+NaIOjtc6Cs1eqG/9J8gb3IUjDo+9XIUV
 CTM0R3HtKAOWw5DjgaCiBtxXKTuP9CgZndDf4LgqVlb+OLa/jFBJyuErWcJZ0NpC/nfr
 fXuVZABLmizhh0nfc9M8uVpLKbemTXwDfaGbpKHV4tS4o5Y6wS/qLa0haRuQ85UnDzeC yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=/bL5L2QfTiQvQG9tQdISkb4NkQePDVJI1ArUkmtKVYI=;
 b=sNjjNsUBSupEuB7s4oYuo9Juw3jmyICpeyMsphiP+QX6MYCGEzm6PdbMD8XQCysfCnaM
 6pzlBLFHS1q6GiM32tn6zcLCesfBMKojhihb4VtXonGfXcpl0sfXb/EmAXXsT2jAO3Q0
 oVobf/GQ7z0AmD/iU3omcA3fSYMYNICZDUxdJo35MK5mytIwuT8eCFIt9QDDVQ+KSxy2
 J26dRKgDlT6yaUlFmmuGW8ZvQp+dofgaHOtqx1QvtacFcH3HDnXXTT7xk83e5m+g5Fww
 bqyfqAGnEHs1Z20yrHQsHEDlZsTqZD9c8V+EKueW6F111YNoQ+LfcAGc9ieuiMhKI9Mz TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq18ae0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G0nCC157575;
        Tue, 7 Sep 2021 16:01:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 3auwwx4744-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqZRSW5K1zg2KTRYHTXEFR9G+9JRJOtU6uy1bq6Ffrk5MEKyWTlh3sdEdZeG3zi/5jaoOs1B5Q9wg0mwuPX727V6Qn/p8eov9JWIPOOltbNU0rD2tdd3/Pz4OGAnB8kOdjytG+QbMfFn3dWxeMBGW+ZOO1UfoWY3FGzeKWZXLVuTpCo4JA7HUJW73xfxmdVqsMCoBrEjYa8NiFJEBmtrrFwCB7s565Hp1qMwoE/0SYSWRJPGitlEInpaRSTiIV6CJGJWp61/pxh0vRWzAaEztKdjfeIbfuMzhA02puKeK+MkuY4pYW6hFps1HVkHwzFVO+vWULGkY3cPiNzrboEOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/bL5L2QfTiQvQG9tQdISkb4NkQePDVJI1ArUkmtKVYI=;
 b=MYMew7jorX3HrHFXksVFuv6DOAFpaVJBvekzN49aBFu04uG9AY15CiO9r9Q80PEhUyngiimwTSxGmGEKzRFoVNRRD92R9zF2iJBehVbJqUmomJCWcNW2LtnVYOUENu368cYJRzr3opRwk5L1FkZdQYXA6lXiZj+v+U1TDC5fYqXZZu1Qre4EpNfukup+D8BgP8e0zW0c1r5rPrvBLhVrqjUSj2Nuhq4jKjB5/rx8KbdUcjrkw7DKKaVXuyf8Pvpo67OR1I3kCf/RQD/uvFGc0vpV6rUhQYoFpkC3iw+TS42JI7sCE+/tEp5FL/jg5c7s4zLBfYzFhS7dDRV6rsRpOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bL5L2QfTiQvQG9tQdISkb4NkQePDVJI1ArUkmtKVYI=;
 b=Xo/XiB1IljZNuaS0GT779Pd6+HXoAC26FIvCGgr3+oBYjJhUDV2ucm42wl201Et8jiaWVYvnVtSA4ZCKlUnPLKIb4uYBACHELoM9mL3Gqfv+MfmVsoZMqNbCDpCDTkiZE6pXvPmStY+om1qTwhlU6y8UZJoLk+hhbwgHj5rMD2M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 16:01:30 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:30 +0000
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
Subject: [PATCH v5 02/12] integrity: Do not allow machine keyring updates following init
Date:   Tue,  7 Sep 2021 12:01:00 -0400
Message-Id: <20210907160110.2699645-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b375e3cb-52d4-49ef-2836-08d97218c127
X-MS-TrafficTypeDiagnostic: CH0PR10MB5004:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB500450619779DE1ACB6BA36C87D39@CH0PR10MB5004.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvIV9l5JRZKKJeaw19M0DeC0b+IYsKgVYHtILLpE+B4m5T8Cj9FkSjPms1F/S22FqWEFEXicRg9bhFX1G7U/HADm17ig97Q59pkzDlBvGIVhcn4FTY9bWIYl8kw5kTb4Hi9+QID54d8imftaMvHl5Qd4CO1JLK3kpBq90tdd5aB3/GeXpyXWno0NvAbrUbjX565b0htu5Wm/YPC9wCt3pOqnCmaMukzlfkIJfOF3eA19wNC7vVbV77EXV9cFjs3rWMmZyZmaHNZhj9g0tRmCDESURsXpDT1EYqg85O/1G4QjqgcqnPIR+QtWPdAfnnkjyWNrpB7C9zIP9Hiuityp0EPuXR9PakRiDhTSibV/mzV5lhVXMlC66jH5GwQgLR05mnroF2kZk9BPCzdvF0LOKZlSl4Mv0N868HPGC+7JqB2IC+jkvmH3x76CbvKqAHw+q5pbVAHtC/7ivMoCRtuSDHl6iZHP3U10sCVVzH82Ls+gDCKQ1VX/xzW1PPf1SzPuH8TCrrPwlfphez/2Mi3ZZNaBZt/yLMe/acBj3+lFKuTAZgeIDNos51/qZi9IlTkeOqsaBByakrZbx5cyIKrn2v9SQm0NI7murTzR21CvME5HnYY7UCzGXpd9XwTvteMtfQo35yqjFTQuyrVkpBAL0JXZ+zzbLIzhdsdvv3fs19d2GF7nYDuw7Buxy+6In4vxaZS6B+aeJoaeqm0W20fhhqQTON6e9+Xh0ryPxVtUAoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(1076003)(66556008)(66946007)(508600001)(66476007)(8676002)(921005)(8936002)(44832011)(15650500001)(5660300002)(186003)(26005)(52116002)(4326008)(7416002)(83380400001)(107886003)(7696005)(36756003)(86362001)(316002)(2906002)(4744005)(956004)(2616005)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6vyBe06jV0qNPUFhF5qiIyIDRdUR4KumJSsJ8hzrclf2oCElIIfLBqIUknD5?=
 =?us-ascii?Q?aIqrFf5Z3icL0QGGPYvWWCAC4h+Yy9NvN8TOJ9frgfpLxLIwqG4kaOf7MGsr?=
 =?us-ascii?Q?9xv+qcBnHvhCB4PleUJUsNI/80mC2sZPWH3eXE84Y+rhh39IcpJExOCSWUn+?=
 =?us-ascii?Q?QOiyWfB/j8mw2lqEBpjdUZwkCd4FxN23HrhHF4nR2F591TH4x3AKQjBHO9eo?=
 =?us-ascii?Q?2Ncf55lJeL7C+ToXTkY+6MJibwdn2zxrYoFqV9bBNtxhJUC45m+HobqU0Tr3?=
 =?us-ascii?Q?25JLW7G3UhED/2FFSjlFGDZ9+0yyv4QJ2QSW37ik3Fe1Wm689JldXo8k9m7F?=
 =?us-ascii?Q?sm3MWwVUskfI7tGFthr6l2DfBJRYjKs2nYONWjljkdztH64ZQ/DQt2f7FkZw?=
 =?us-ascii?Q?R7+tlX8DzFCzF2Uklwp3ffOGV4C2KfqK9BTTvu7gK3Ngux2F56W33WyOXCN0?=
 =?us-ascii?Q?x8X3Im1l8K4zddLtO8F9r2/ht5rudml5T7adABvNoJTC0QNRGZObjffkbP3R?=
 =?us-ascii?Q?yTblFWRZrmd6dbTgdVV/oNFcziXyU2UJOPdVCVHl1mV9lnkWunDb62pjXn+R?=
 =?us-ascii?Q?O26KBr9v7+GM0Iop06VqeHrKH4tj3V7YW67ZMw7VzoiYn5xtFLXtLFihgAoP?=
 =?us-ascii?Q?HiW+7APUS9+qZ9qh6WHHemiQx+/CiXy+/W5gTeYwpyOE1j8Gadohyrn1dywE?=
 =?us-ascii?Q?Cnbxkyx6Dg2bwFK0Ua78GhF0Ro2LzoImPkuFTisdLd6GG+fGQ83zmlVbksn3?=
 =?us-ascii?Q?p+IOnFTf9aFmagsZRejvSr+nJO+hvlYsKsbYxtut2LxfAqP3+hUXzmRIwvP9?=
 =?us-ascii?Q?3vl3dmCmXjBdbNTmSQkOeLtFou9NmMFPFxz0nMg/e3ZJdWWfeqHxQ+WqI10F?=
 =?us-ascii?Q?Nj3FCBzNJtLxtrGHHmLKkClFtcbD1gdZNABAjk/DupKNTAMfwI6MCZKVApZV?=
 =?us-ascii?Q?vYs/jcWopgCEh//QnhPuAaJ0rQQ+SpT3jSHrilJgtIygckXmj8dWqkttnjpt?=
 =?us-ascii?Q?Mj+AkPIGRwtQEDkVoF99A0Bu8JLIXT1UII+1ALmumxqHMso3trIE6XNBLi8R?=
 =?us-ascii?Q?dkdEpQQEoiWOQ4LcVH07H5CiB7q+Jjv/YO/RZ9YxRJJkSeoMezi4YWd3xA2c?=
 =?us-ascii?Q?/brjhuc7umMAamvnpoY8s9CzR8aEH0XO8Qay5krWSAwpr0vmoZjl4md8520F?=
 =?us-ascii?Q?yT+mw8TATslIn2e3E5M7RTnpX2vo/Q16bzKEE6uV1yblBhrEdtr3GKHNxR1n?=
 =?us-ascii?Q?fd2aN0ewsA5/8XJs032nZXjwcp//dmqvcmgG+QRr4CPsVcAqXzCQd6IKGHAN?=
 =?us-ascii?Q?S/mOFGz1CIK2InoLMOdu+2z7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b375e3cb-52d4-49ef-2836-08d97218c127
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:29.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8OGxQZ8ty4FMMmBuHe/nngC0+s3oRK2weo3PhKHeli/e2afE5Xx3owpIJ5vn1FYQIa0qP31VHvfH7A0HVx+Xr4asgJ/VRphQBR6NmyOgJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070105
X-Proofpoint-GUID: fX-FW3fAQhOMOVkidufE3Dh6z-PZE8TU
X-Proofpoint-ORIG-GUID: fX-FW3fAQhOMOVkidufE3Dh6z-PZE8TU
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
---
 security/integrity/digsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 8c315be8ad99..5a75ac2c4dbe 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -140,7 +140,8 @@ int __init integrity_init_keyring(const unsigned int id)
 		return -ENOMEM;
 
 	restriction->check = restrict_link_to_ima;
-	perm |= KEY_USR_WRITE;
+	if (id != INTEGRITY_KEYRING_MACHINE)
+		perm |= KEY_USR_WRITE;
 
 out:
 	return __integrity_init_keyring(id, perm, restriction);
-- 
2.18.4

