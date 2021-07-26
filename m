Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84B43D655A
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbhGZQep (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44618 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241131AbhGZQeF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:34:05 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHAZ14029680;
        Mon, 26 Jul 2021 17:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hc6NAJ+mx3y4y5mytwM7rS18oWRfVslqx6Sv8e96WOw=;
 b=rp0XgBwBdc8zhB1TzLJB+JSmIIH+JtQ5z1iw688tEPZKDQID+w/3rDh/88+TxVzA+uxw
 4AzdO8uCAx/t28iqD6wmRAYgEXBRYPoaNClpj/FqMXUTGmzZRKGu8+3S8QISAKgjLOlP
 lLpA44XIthaThSwIb3ZYo3XmFugvB+N72EYrl+1wGNLT6PYKbyzrsyqLq/pD5KOMMoKE
 NKwjLA2cT4FZosOeINhvZp58iC/y+MTTXY90C7GUc7yUKudMck2Jn0baBG/RNfV8A53W
 BJigsesLTN4V0nJ56kDsRCl2ELnG0ye9kUMBelF4GDhQXoHhrR0sqdBVHoGw447nCQ6F Bg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=hc6NAJ+mx3y4y5mytwM7rS18oWRfVslqx6Sv8e96WOw=;
 b=yY0gILg98V99D09cGkQ05priAmKf3QEloxHJrFcxhCiV2rIjiCszTE07iCXUFKRLaQyo
 4W5jaw5HvBAys55x1nyE1dPhznwBWovCbM3+d68hengdpWD/BS6KprSbTzwfr1PDKM6E
 AC8uXBqKhVbYh0tStlvaywENmQ7pKG2G/dElhVc0mxzqcKJmkOWaQiXC+XCSDB5a7wHf
 rjSAiJgO5UHwMBzIWB93KzGZfkh8WrqPoy8MSyPWlSU3jNQkljn8H0Wlx8GfJhP5m2sr
 WomZW85LyPpqukogcFwv56/pUl/mq7gyUQODtEZiBn8FURp2nzPeV4PCKdmoT1cpGzqg nA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1cmb22nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:14:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHBP0Y160169;
        Mon, 26 Jul 2021 17:14:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 3a0n2gcpqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:14:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeB/00VpjXdqqpa7y6C6MOo4xzV6VzMlNAcWlbLX8k7vqDcHQ8e8xm0LIdTk3Y7fPB9UNDil9eGSZwW14jjMO7+UU52rTy5+2fObHK21AhNO7rruqeXW3x5O9VGBtkznAs7C6mLVyZUYRnN1wU72bZs1RQUo7SFyBGxLkABHtzxDXaM9D6HrcyZhDw7KZdnzBdE/8DFwJKuQpTG+36XzflnM04fKS4aVrA1gvpwSRbHyDUmebcSDVXfTTGzX0ozVmdRhJId0kVGLrtNpEHuHd381oxY8vTrCLcK/n+p5JiSGijgX3S3x41ASJRXJJpTA/vgbaZVQa/baVUD9orpRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc6NAJ+mx3y4y5mytwM7rS18oWRfVslqx6Sv8e96WOw=;
 b=dRXn2EZn6TUDiqw/GKs9uol83IfeKkbMLm3SyTqDwPFW7Yc36ZOELjU1C4GKe26OwVe/P9xTHcvBOPRnRRq2jXGirM1S0mRA9/Cfw6A0YY2j4LOMgIlPwaiU8gob/mjjnTuRyDtJXV21+278CTXHpXa+tv8axKMX3mma1d8y7B17d7EjGWiXw0YI5uROYVnuLni3tVhDr+ccQPj0P162G7WQ+dfYwSC35XVlrnh9bMvzFY5h+QsKUKAeIgbH4vKv+Gthi51XVqWrJmUcPfkshIHC2wh16d8m7nyhOzu2PCsKy0sfZ+fYe5MrgRcYHUdIxzmYb8VhLX8nuiGhnqRpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc6NAJ+mx3y4y5mytwM7rS18oWRfVslqx6Sv8e96WOw=;
 b=aOTeOMXAbTQ3Y9sNe+e8uIX+QYOGrr6XloaABhZXDlvFXlxbOKmREH0flbNxe6CKhkufmlhbq2tHQW0XTUtY7HD/KYF3GbYNzYmM/2/fSPi3u1n+w0xLVSX7KFZ+qzREH48KXFTDPJhDuWV6UwQcJ7kq2zuH8tiTXlcYAdHhmak=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:14:08 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:14:08 +0000
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
Subject: [PATCH RFC v2 12/12] integrity: store reference to mok keyring
Date:   Mon, 26 Jul 2021 13:13:19 -0400
Message-Id: <20210726171319.3133879-13-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:14:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fdd029d-e686-44b4-d8e3-08d95058c72f
X-MS-TrafficTypeDiagnostic: CH0PR10MB5019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB501905A16E38E0D223B50C2B87E89@CH0PR10MB5019.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5HkTeIpED0zfrNbh4pWkoRw2FZ8qVSXpVrsQmgEq3KEQ4mEvb8NC4X25Vs3H3z3DPstHJ8D6kr2cT23XtB3OqnXtkhZz0OQZTtpzlcy+SgCaf1Qr901QLx1qPC16ffK7JJtxvLKDYvbYjigmzpzR6TBeTUrYkQWyEGF/LIxy28awh9VKLH9hW2D4Kww7+GEWwMu3TwKI9saEDvaIOuKX+t5QgG3fdxRvfI0m+8k9MvRuS021ShseNy8yGYCW0GePSGNIk1+DHpN6g/8QBT0FFdl7ew/qzpA7MrKkqlcRRd9UHOdQSZ0/FW2/Fzgtf5/UxQmlCi3mTt89ksRZtGNexAzXNgsicBPuGfsQX+Fw626SdK+5ievMEmuOyR0FWxGRzPsUgR7M+LAD1jB1AVGNUAjsa3x1vT1KdByjQburUNGONw6YKaPGQ1ge0qpMB3Yp07X43vPMKDCzsqVXHAswPJBAw8PYAbLtPyW8Cn0U+iCDlc0BqZJt/Bc8jIWtXU3XPeOGdL9h+++TJ3cB7088tKuvC/FZJz41JQVvz0VAt1Fx7i2kOYYUd1+xE3gyPIahTiX3MJ7TugHitgK83QtP6jTjMOSZwJXNDH+i3VfMO1/CvfkRwUDUEwBLjC9/vyXzEmniqKIP2XE8b7JVTEbQHzLRD6foXffumn1rqMdr+aSkPAPlfMvZYGVIz2Wwq/mF0U1oVb/PV28jwlCfvk7cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(66946007)(508600001)(8676002)(186003)(2906002)(4744005)(1076003)(4326008)(7416002)(316002)(956004)(5660300002)(2616005)(8936002)(107886003)(66476007)(6486002)(66556008)(83380400001)(38100700002)(6666004)(86362001)(921005)(7696005)(44832011)(38350700002)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7jAoWjPsab0vcZsDbV5FJmQNVxLRoYWMSOa6OiyozVVZ4xBEqsN0bxWAJmGf?=
 =?us-ascii?Q?0/FuPHNH9Mf+bDloxziBIPWjSnd31Ek7cIAkO4X94OK5OXcvgZckZN9OEu/d?=
 =?us-ascii?Q?TL5cwmPSYcHa2OVda96HSMwWekmZO1HxARMkToqhbug0RMWIto3xg5Y+4s48?=
 =?us-ascii?Q?6E+oG+DHpZRhpJasojn5/xmdH0pZHo5NDhBjBojpX/gnAydqJ67/931t9w4n?=
 =?us-ascii?Q?GQlFHaHhRJgMkRUuESpkNBbHTaRIUygBa26T3jJ2u249GiVaNkELt0DVO/v0?=
 =?us-ascii?Q?b4qGKRugbjU0qSlzzlM5nOwS1wDge7N1eNMx1Squ2ADxESVNugkmO+DHwXQJ?=
 =?us-ascii?Q?3lMO3e0knS7/5Mo3lOmeL0ELWly9/lK6HVp2ySiwmYzo18AVb/E3uKFzCPUU?=
 =?us-ascii?Q?xyIQNWUf+Nj22WQFiHwQqDAMh81bbp5KJCAkORX4E4dpRHALaFDDMUllV7Wj?=
 =?us-ascii?Q?6kZQHcv4WHv3L9WuB3S9YKrfnML41xU5JKWpSE7PKx5CSCbsfObEdBB7DqtK?=
 =?us-ascii?Q?cWLiBDXCNQf8b7hAPRjdtMwwW9P7IoZQgfq34VKwviyyU9/mX+10Yy7vYzRC?=
 =?us-ascii?Q?cc9oopwSO9G1efb9nESYpXV5WqnXXKOh8sTFJXmcD7R5nC+goAXUFnJIhpGF?=
 =?us-ascii?Q?jSkuqKSwzpkS1byqxKTYB5HliLITGuNtPzrw8Enrp5r4bggJGxVJI56TWIXH?=
 =?us-ascii?Q?AHLHrCv/hejYOA4IaZQI5XsICUsNNGOHiDk5NKKBnmvevvXgxMJQeHPgD5R1?=
 =?us-ascii?Q?R2qgf6sGNijhBz1XruaIUaMlBQ+ecy3tgMrQ3FU/BBw88P1hoHL0kgXiRPH5?=
 =?us-ascii?Q?Q8frQ/sOLYKlcBY8KCFBoP8zshqT3dl30wxIvUQEXKyRhEtMBKT1VtKOFEsX?=
 =?us-ascii?Q?MYhBMRHfH1VRhFQlYql7rpuPv028SEF7XpuWb/M0Y+7KnKbtcEO16tlmwaY8?=
 =?us-ascii?Q?aIHqRe+60v4wMR8pFp4tdnwnNAgwMX6Oy/pw10myYFy6tAZTJgMp1hFkgmCo?=
 =?us-ascii?Q?m7H8ujb0U4LSi5XUztMYytAoQ7jraHBv07RyyR4wSWhPzQNDt+QuwERvqwPW?=
 =?us-ascii?Q?bCZZ2hiE78sqN8hg7u5nqJYfyrTaP0b+iZAipGRKYnKZUo4tg+I6OMHzYc6W?=
 =?us-ascii?Q?b/K+oHNHNss4wxEJIwUSGT9MjI/XU8HRL+LqwoSq3JjDEejA6Jf2eLf9PEdk?=
 =?us-ascii?Q?e8I6Pa2EiiAeX+PEeRb9y48moE1ZiRxtm7+gEUqfXz+BA6SO/hrtmG1MN866?=
 =?us-ascii?Q?FcUs0IB6s4PKDG5gSSCWyN+Q8oliwEM8VZdbuJq9fCfAoIYWu8oxmDw7Wd5V?=
 =?us-ascii?Q?tLASgwh6NpnqLRYWR+JiJL0l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdd029d-e686-44b4-d8e3-08d95058c72f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:14:08.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDydVXtCzuOn1myMZD2XrOIB6pDjK0t5tuCFyeTN6zJFj3IAlFyuZHlYqlirkhT/lP8CfxUlIotwKdlXvIZXr/ZzLmiZAbTFdWTXK+x43Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: EG8YooxYCUP8gnNpcdahNNxloRop7g5k
X-Proofpoint-ORIG-GUID: EG8YooxYCUP8gnNpcdahNNxloRop7g5k
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Store a reference to the mok keyring in system keyring code. The
reference is only set when trust_moklist is true.  This prevents the mok
keyring from linking to either the builtin or secondary trusted keyrings
with an empty mok list.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
---
 security/integrity/digsig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 3a12cc85b528..cf13f4c56517 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -112,6 +112,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
+		if (id == INTEGRITY_KEYRING_MOK && trust_moklist())
+			set_mok_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
 	}
-- 
2.18.4

