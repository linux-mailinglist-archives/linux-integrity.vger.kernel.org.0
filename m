Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C9540BA02
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhINVRd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:17:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62928 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234608AbhINVQi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:38 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxODe017559;
        Tue, 14 Sep 2021 21:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BrLNCus9LxI+mv1uvpxdUQb2xTGx2tIIKJFBUsy243g=;
 b=ip14YJ8bIr2cmOHT7Yfm3m0OVXzf/colPs1FL4dq/wdSVLkjPGCXL8OVNqBKBAj6BkYq
 +OPE8hcAr/cY3Fo0aSidUnHmYfGJlXWM5mgp7P0v8pmdNqNVkjzzW0euDXssBdCCk2mY
 RTC6r8jkXCNBQHsb8neL7Y47/LcEoC+0YW19HuBIswhgYT78sdqLtIS+T7V+IJLTSRAU
 W+ubsPl7IsOBEukyqV/XAF8aiTyAUwLMnhg0HFKEgyqj11S3JgpVsSA5hbcCkpGymPCl
 D476TirIPb8esVk0ddEote5bfQS/WYj4WHRCLSloORVP48/ByPKsK9frGUK/x9VhmLzJ kw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=BrLNCus9LxI+mv1uvpxdUQb2xTGx2tIIKJFBUsy243g=;
 b=yWfZ5lF3O8KDQimQklJxcC4o6a8DwkJqu25DsfrLZLc4xZ4myAJLzLrjoVApB9Tzhx5I
 z+eEDRSQG65gDSkh9/Nd3EcoWU7SQMNdjIzgROlbDWr/lgAaKbJQ/NCCkLlA8lY9LpBC
 NHPMeyZmbVk7AuI7rNdOCi6pfXt7UAz2ETdUfgjJ5FQ+DMua3Du8E4QKcOsBTQ4cYnQU
 1UBEBjhhDYQfIXQ8dbxnNfoVoRSN1srZCzIAPyWgU4rCGyjMkP/jAFsNuQfEOCQ41+5I
 Sjk4m9obi0HnDnszsqhU6k6eFDoj+NI+GMVbnVQQJ75kihCite4NxqnnMo1RCO0KSNC+ xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p8taxje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:15:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELAXHs054981;
        Tue, 14 Sep 2021 21:15:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 3b0jgdpk3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:15:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1KIAuoRTAcRqr+QyUij6ztygl7iLeUFkafrJPni3MEPKd4purTEkn5AsJfaVAr0IpJW9y66BBG3ZxXPLfWmVmtYCnkOeN3NHrVBtOnrWO1MIxsdsZ5XLk/JGCa/0OkGBMr1H7rR2xtH3UDFHwduhuQp9nY/CEm+cvHKA4dH+eTQISa54xZhmiIm6f5Y7fOmSKEWRZeYCVvZzzvn3ft1SDqU8lf5cfec1pwU0SGM1AVfrLUPrFZoceA3qOE8wC0sS0BmhNGiLBDFSsD6zgc+OPd1Tsye6tH9hRUnTkVx5t07zza0pvTmJEMCRk0lfWTScOVtoY/Rnk8IJ4sACYh1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BrLNCus9LxI+mv1uvpxdUQb2xTGx2tIIKJFBUsy243g=;
 b=hE4eQ5WjrXrzlCUUfAK9gmlQ18HC/ntFh95bOVaDyJ79vFaLiyMksjLrWr9YC/O+oCjyhtNxIv4LoxQo2xqhdTEljXB+GaemwWjtmY+Xb83oazReljSxj1jOvrh8g4PIjDHdcc+8rcc+GOE4Cs8TXe6FwQfbBdp6rbOeuPS3WkAF6POviS7pfQxwsV7w1rQxYo1PBW47lw0ycnokQYUMc7ACW+8jt4PffQwEfvN83lq+FgD5vx0UrqaBsmf54vakwWZWq3vO/bWwuZw0mG6CVwl16baZ0JU+OzjOMFl4XD8YrureDwNahjcLHFnfyOaFl8H3s8x2MlzqB7v/Srsr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrLNCus9LxI+mv1uvpxdUQb2xTGx2tIIKJFBUsy243g=;
 b=kITWmtXJxpXAiG9b8u5X4skWVXASA8hZcdkmuF26aFvEY4AHL20zz9bW/IuMgo5LY2h/gU8j2v8WSt+aTj7tLgNU7IWjbJtIrsvs4gWDpUy3ff8Zz64SkCbRiHb5HXiy1mcz2CknXcuZE6yBzqIcyvA1J7CAz5tBs/lEHR2F86U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3784.namprd10.prod.outlook.com (2603:10b6:610:3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:15:00 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:15:00 +0000
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
Subject: [PATCH v6 09/13] KEYS: integrity: change link restriction to trust the machine keyring
Date:   Tue, 14 Sep 2021 17:14:12 -0400
Message-Id: <20210914211416.34096-10-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:14:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8460312f-6359-4946-3db0-08d977c4b5bf
X-MS-TrafficTypeDiagnostic: CH2PR10MB3784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3784063FA81851BBF9036AA687DA9@CH2PR10MB3784.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JU4a6yWIFMSQoj7h4m+5mgQ9loImXe1VnU02ObYD80XwbV/XP8xkyUO3PSkU7VE7vt/pBi+lRXNqVVmbtdewlJimkRKZzf3yQKQVeOgYUypEliv9rdshq7aaPxN15i6v+4Pv5SoqGHldHtAS828noP1hWumxCj0a4K/2P843tTtDkWD16umw2h3Z28acQoOWlH0rjQDAnlohhLDUf2mey2jMX/ozJ7v5Z2N10UYFHRwTgldTX8PqIWUi0bP5Vz5rTscZCEj2k00fk8GIJ5VvPD1wxm5+hK3uB3X6HXMvQ1d9maEBGtpt9sFoGrPU3DB/rrONBK7O8y6EnnRO8PX2p1KkU9TA+t9UUa0UwTpy1XVfi7w5mtmRPmjmu8zKsqIUhjtJa88RXyXR5PbVPs1S860JlKe0QtWtPGA7e5uA+zJIziUQGpAK3T9+NmXL2PCN8bKUTEwPdz/cv0Zgx/v+zDGa/AVvoZnqjKue4Pe6rmBp1iS1X8ST1uG0zcjvZTmQ8sekP9y80jB31tqOBcgiBnD22qSU5lCiXnYAP0QnkcIvsTe0asX1buLy4cRYkXZ5QCvKauzo6M/qWGRmA1LhBzmEcFAn05EUSBlNbGjSBGqwtuFxLx9YJBvL0nTJRIwypLx3OA1unWo3qHCujzL9GM0qYztgXrnwpfGtQd6++XOS+9Tn0Wt221zyaYscdOYKlssuPnFx1FudKosJ8Lh970MChSMtTxgwjBeuqavna3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(136003)(366004)(346002)(83380400001)(107886003)(4326008)(2906002)(2616005)(86362001)(6486002)(956004)(44832011)(6666004)(478600001)(36756003)(7696005)(52116002)(316002)(921005)(1076003)(66476007)(66946007)(7416002)(66556008)(26005)(186003)(8676002)(38350700002)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Euok4VLUrayl9f3ZiQ5m/XbUlZO7zlj/gVsRAEQ3jM9NrjuhObjbUYGh9RsJ?=
 =?us-ascii?Q?UTTuHXv8dy1RQWtDUYbPJasjaP2CWqhmicfw4hsUGsbbIoKW4JlZUu9DxRVb?=
 =?us-ascii?Q?UzxGfPyQm5GzN0+xkcLutKtHIEQKvtAGopARZba6d972ip75ILBKm17rcjaL?=
 =?us-ascii?Q?tkbN8SNwit9w4EyjMayf0ouqvgbRHgNjMO0Ur4AOFjTZEeqZxwu4GXyCNNlG?=
 =?us-ascii?Q?884YywXCzj3rW3fGLcy8GGLeNAUzPUCBftwv6FqTyM9ADzJJs5SDtpqqZw+4?=
 =?us-ascii?Q?V/C4pP6igCkgVyBCKQOqK7iwUr3RH3xe1gmx3gGeSpWmxA836HCaK43ZyBdA?=
 =?us-ascii?Q?HLqz1WEEpkxetV+OQHeZaSdGk3THBW40hbtG9HS27ahOwD2wSWLr7b85vlya?=
 =?us-ascii?Q?Jyg6ljs6vY8wdFDfXDBB2mbDZQwhwIajwEaKmv8nVCoDwW0oaRq1SRkSTNrw?=
 =?us-ascii?Q?0o2ICt0GRonR24J+/vHtkpDUflngmSqaQo63ByVuSz+xEKTerDcnqhELUki6?=
 =?us-ascii?Q?+y+Ng6VN6hlwn1s9H+l8XKQdj/wUhdgD7NQVCwAtdBvEneZh0hYmX8eYiDXL?=
 =?us-ascii?Q?o7UqXekY+uEcMwFUAnSVxBf2ZT6LPLRl7LnlQXmKllE8DdUV/gkO2CbLQmYC?=
 =?us-ascii?Q?rB6Tzx//yK6+mrVOeEfzfQ+DIHWdhMoQFcJe1sQhb0rjlonQC1sI1BNo6VgQ?=
 =?us-ascii?Q?rQMiXBBmitWxbionKIRbJMcBTcpjgHIDspuGFOYRjtEuGxmZlvGbADkNRh1u?=
 =?us-ascii?Q?OENKvF00DSdRAuT+wi5j2dBdEtN/CIgs07pQmBRWwwyGQDMmcZ8Jqm1UMtyk?=
 =?us-ascii?Q?mAaHP0re3c772Whos5CgnUPxI8eMgjB4rcoV0OZ3/JdQgBROggA5HrRFZh3x?=
 =?us-ascii?Q?aTcSsgGsSZokhXjBPSkH+bAmiNeipA32DzdGa2nNh6U9BTDNvhrpJqy+DZCC?=
 =?us-ascii?Q?ItZRaBxFfYGqUMRjfTJJCxBs5cMAZH2eogJ+Q2NQenFMHPIHlOnJ4fNk0WuN?=
 =?us-ascii?Q?ZQKA+6DUhqk8/UXq2MYlT9fqtYZnPQR3xJM4Jq+0OYfhRo2LNZqFPP6/uMg1?=
 =?us-ascii?Q?Br0QcovDxnmOTak5wD/rtQDp7dTYRtC+CjBq7e1iC75LX3y6+EoigkxmFR1Z?=
 =?us-ascii?Q?4XHRMOjKk13D/+XWDi5itjVdbS2NXt8BdxwFfKcuXbcksZAnasb3r2Clykjq?=
 =?us-ascii?Q?HiUuYxLcPVTGBsF67j7yP7rG1wXlS6BsVH+hSFFsuxhI+18O1ih6w4kXHpyF?=
 =?us-ascii?Q?UEOsiiF6wFTi+A9CGWJzmYN9tB+qlgEteIc1A52WgXKZiVyG5ilmRCCmHk+o?=
 =?us-ascii?Q?fDq8VylnwrGuFhqd8wSsmiyn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8460312f-6359-4946-3db0-08d977c4b5bf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:14:59.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrugU1fVY/091oIXblJ+vBMp9d+Fe30kp05ZiKkmhIgWSvUZ6us6/YH0u1/6O2+a5T+WxmxWS5qB7M/kcLkEhhlXvf7vY5NznWCpW676joc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3784
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140123
X-Proofpoint-GUID: TfYsBjLc0gSfAD9AW1P-0IQVHNbrUF6t
X-Proofpoint-ORIG-GUID: TfYsBjLc0gSfAD9AW1P-0IQVHNbrUF6t
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the introduction of the machine keyring, the end-user may choose to
trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
trust them, the .machine keyring will contain these keys.  If not, the
machine keyring will always be empty.  Update the restriction check to
allow the secondary trusted keyring and ima keyring to also trust
machine keys.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v4: Initial version (consolidated two previous patches)
v5: Rename to machine keyring
v6: Account for restriction being renamed earlier
---
 certs/system_keyring.c      | 5 ++++-
 security/integrity/digsig.c | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 71a00add9805..ba732856ebd0 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -89,7 +89,10 @@ static __init struct key_restriction *get_secondary_restriction(void)
 	if (!restriction)
 		panic("Can't allocate secondary trusted keyring restriction\n");
 
-	restriction->check = restrict_link_by_builtin_and_secondary_trusted;
+	if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+		restriction->check = restrict_link_by_builtin_secondary_and_machine;
+	else
+		restriction->check = restrict_link_by_builtin_and_secondary_trusted;
 
 	return restriction;
 }
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e7dfc55a7c55..74f73f7cc4fe 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,7 +34,11 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+#define restrict_link_to_ima restrict_link_by_builtin_secondary_and_machine
+#else
 #define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
+#endif
 #else
 #define restrict_link_to_ima restrict_link_by_builtin_trusted
 #endif
-- 
2.18.4

