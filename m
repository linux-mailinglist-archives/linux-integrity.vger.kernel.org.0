Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54742402C68
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244800AbhIGQDf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:03:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51244 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237489AbhIGQD0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:26 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187Ecusx020831;
        Tue, 7 Sep 2021 16:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ufz2sfBLbR/UiAzULD7ynfpT7KVfE/uQMgiFsiYiyUo=;
 b=BA4Q/+DZj3BZHJCy7F+ab3Mwzw3NzmwyeEhTKHDlzne09aSEpqFP/zvMeTdAVOF5yCt4
 i95AGO/S70hiPbdJi8d4XYUOYHoTieuYMmiUr4WIvZSeA4bhRB6aO8d3bbwzSW3mXPRd
 Hrap9bS9wzewwVLKBb7dJY6+r1ivjbUcXUpNN9ua6l0+SRczl7QueLlAIMMlAeVmG0Fa
 31po52tfy5dh733txzkeszxb1a+dWTCXDk/SiC7HSwbse8q4N362CWa/v1xd4qmiu+8m
 o5hOw6MoFQcav8gv0s8b2E8GILfkHKspSQxCuztEyemQ0TY0ajRSHmkU75ACi/9rm8oQ Jg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ufz2sfBLbR/UiAzULD7ynfpT7KVfE/uQMgiFsiYiyUo=;
 b=LNC+03yavZxsPdhf1N8Wpz1MpbXvrkOYxfOsWC3PaN1t7GcJRqo51xucOY3e28TbRWdl
 jal7GPyHRJK/pYpHalug0y51mjVboXZc4Duhm6IFfkBHEP4lW607tGQkwxJwuMAXiGzk
 SBtJWk6rgUjaW67Jj8a2sw7tBcHzBmaOrZlnSPsi4aLUnuVvxDmUGATZtKBEOYGS78X0
 7aJu3nNwasnxQPaRIb5B6Qi7hCe8pBGikzpOb5cWmOaAUleH7txvER4eGa2qF3P/Moxc
 L8CX7475ieL34hdCZ7mtIIMgzm1Az7W3C8ENzyZI9F1uvkW1URlTYMbiWSVMkExrTjCi WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awpvnagx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G0GwH134787;
        Tue, 7 Sep 2021 16:01:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3020.oracle.com with ESMTP id 3avqte3d9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrzsDZQ1mE4yuJb5MrWoL6Osvzg2imW5F91rwQVp3XXRKBgHJy6OaxeQUll+id1E7wmtmLia7Hxv2MKBVYr24u6BQq9lxSWjMMuGnuXNNeKJRhBsyCIl+in/5BEUd0mL/+DtvrXuGDQr5Hd4qgfD5B3sX/Yn7wHWtjdPphRcTTfK0k2rKcexuNERg4ayt0WryNHRRW04LoUgmdRY7K3S76NHJK90WeALXZsejKpxh9IeE3mxJAxFxo7/hoI6K38rZDn11zmMYqVT5A1CWjTicI88gT+6QFKH86cYN7F2ttw3CkNtRKFEYp8gaykly9iYh/gw1eWnX5IaTMqAlt4Pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ufz2sfBLbR/UiAzULD7ynfpT7KVfE/uQMgiFsiYiyUo=;
 b=L5fh9WlTXXmI61F6n+R5sQ2MF3Dm1+eugUP07aq2waCwKVM9B3K3Nj3yWRM2I/1TXrRQuo6eSj1O35DpsYQUman04o+OVUxDjx8wm54SzX0fin+wSoYQBwdK0KY0Uniu9MFRQwMBRlQmaNvufHOblzmWt06lcNbQRS6tEUMRtlNmW1+o1R1876UD1D/ye2cBrAwzj49bcWPHMXc3aNi92UfegLTnVcJmHLWZ56n9bCHvTqFBuQy//aTqnN50yXpJW73E1xjjUa3HKJ/haTi7z9eVuympnPyMPmz+e49Uux7HCLBBUaOKe21K5gpxzVjCCT3R6lpV3RoLyiMlJ4SJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufz2sfBLbR/UiAzULD7ynfpT7KVfE/uQMgiFsiYiyUo=;
 b=0H0OdfRuJtiLXlDjHZBweD0Y8r5izgMLhH2zn4ugRWcHmiRgOEA+W6ikx+GDukUoea6EEDOe25pxkEi7ESlOPhGboi6UQdqkwNh5+TO+Sl/QD4ZoCkSRDtucO42MyDOjcIh5rTesBfX/YEnCZHZV0m80kBxZXChzFiKslkI34jc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 16:01:36 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:36 +0000
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
Subject: [PATCH v5 05/12] integrity: add new keyring handler for mok keys
Date:   Tue,  7 Sep 2021 12:01:03 -0400
Message-Id: <20210907160110.2699645-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa575a8c-0930-40e8-1db3-08d97218c557
X-MS-TrafficTypeDiagnostic: CH0PR10MB5004:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5004463284481537E14EF08487D39@CH0PR10MB5004.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyos5pvTwPkRkBNLXTxj4vsdp43RBh96nnEPHk2q4luvgHTw74DVXNpVYZ1vgsS4XlgI+h31G29h44kDxjpzOJuOlhTwJ+87Vi7Xtyr3R75qGAXC5VujR4EC/KqXDcBHZVp+VoHya9Ryon7hrpCFg27gOuUNnlvCNga1uw/5wBC+F33r6ttHoivZ4T4DPNECSp/pBKO5MrKRhja0ZtnncBxAcdBdfomIfSMuX7Bc+uRZR8RfeBYcNFXtzzLRtV+Cy0KQY4+C9HRa5cJXNzom3GJX7xoSrDZW2k7kk54ND05nHh0t631FmhBOw+bN1c6ZCzRF1byFmjA+TAulv1MrpFLP51mwbalZcygoveD7ePKKbMDlRQqCO6Hmv/H5N0wDvHW/FyCEh67ikS0bgWkHo+c36qKos9z6R+0a8GYKXS64++BAb2pYU8YoiuVzMYqBARuoDq3bZvM+k1GBiL9uLZ3Vj8EVCMUzSUuG0dAyNNu48WcJFF2b7MLBlbNkBKg8BoSJymRWfLf1b92pCd0Y1yy9/dkF3fvFawm4+2mDfeAqf6/8YvGuFqbXO7CuS723H1Dl0fBbM+5JiaLgJGb+LjuvdW4t9c4z3iHDvFabPmqSESCMgyPbrMwZI10Ca/vcjPBIUeDWrncs9rk68h56bWoNEjARaSZsdv4rydXYk25zBeBENrMRrj5eOsvjobrvgw1auxnGIuue28I3G7YTCb3+7FvYFPc+XpQA+WmbqB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(1076003)(66556008)(66946007)(508600001)(66476007)(8676002)(921005)(8936002)(44832011)(5660300002)(186003)(26005)(52116002)(4326008)(7416002)(83380400001)(107886003)(7696005)(36756003)(86362001)(316002)(2906002)(956004)(2616005)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G8cVHAgJV/jASY8AQKh80ayhENzCT+s9eDi5KUnwOqckXD2EdTN/+KUDz+DK?=
 =?us-ascii?Q?ZFKyGjSr0/yJUixHLou01DHu9fkCouHVmTZdeK9esc7sFVXtklqk41zu9H0A?=
 =?us-ascii?Q?OExLDPYaioKXF1fZYspW0AENaLNKkaBiPGR0HRlnE0+O/n38MXxIa3RexOfl?=
 =?us-ascii?Q?UXYg6AWiHjvIyedWg9mSkHPphrdZX80/pl7TX10d81aI8cPgggUxQm83Kx0/?=
 =?us-ascii?Q?uowiO/qbnPBFYB6vTYhIWyQ65XL/e+So2me7gp7YVmNiGxexYSMQ31JfJVsM?=
 =?us-ascii?Q?61lORdijDBTy9RLsrrheTlDR8jvYSpogiAAjr2J2qEHsCHqPwIM1dqgMeeCV?=
 =?us-ascii?Q?upm8j5eDM79S1JyhccLHfuHL/oQaJtgDSmRlmKzc+aGAyoTfv4rlLKBufvzo?=
 =?us-ascii?Q?IFDSBR4I5FI5mtOOIpwbi3sePYRIbBTeg0zx5GD/B5y8BtsgJJGcuwt9D1Go?=
 =?us-ascii?Q?ZBNuz7DzxmFzIk/cihbOlurUtw7YMSKLhWdT6BGeI9hVJMLdhWnKhIA6RDhK?=
 =?us-ascii?Q?lm6frpOzfbCkIJYAwv+eCHEUtUcbN/Dy14KWxmnubXRZyCu8w48bVf6Af9VO?=
 =?us-ascii?Q?SuLA4Ijenb6JdR29QMCsyhg0iAxM7z1dFbR6TZr9eGZXrwV6z39uJG0Acdi6?=
 =?us-ascii?Q?axEDZCTk0xldU77KBQa+emCHZXDpo7S/16stv/Hjwf7YT1CPxh+/vujrD1Wi?=
 =?us-ascii?Q?geNrFnwg6YNc1kwgxKM/ic5kWChIX5On9wb6Abk29oIr9P822Qi1RHZRJZBb?=
 =?us-ascii?Q?kfF5AICG/DB2VrMa/ahGxUR5MpEmC5CZSJFrmnot2rErUu+11qHt4xTlj7bq?=
 =?us-ascii?Q?aE2VLXnzgjd3m6XWIIyuEsqMXp+d8kUp5C4KZfbTvX8a/wSQFKv9EeWQ+37W?=
 =?us-ascii?Q?QGt0oSNGc5CxhBGU0yrN/ZwNfS2BWvTN57P1OwJ3xcpE0Ip6/bUWE/1FU7RK?=
 =?us-ascii?Q?NUM5qXP0SBvgBx12QynckbqDqcksHWi34sBJNw/Svu/G+bZV1ye7FSmB4Z1O?=
 =?us-ascii?Q?OXzxMgXM532i06tTF0Y/CTiTW0+B0TILsUf6UVr8M3Olz8Od7nOSIHFYcatV?=
 =?us-ascii?Q?RiILBQ3QZhy+oS4oMfE6TtDxue9qyN8RYwE156nl63Lf9dXKPLYH0wIRmWt+?=
 =?us-ascii?Q?RaqS5KeyQJV359ONoOHZmuBc3ONuJsvhATSPCV7PaKa/IVA/joLczyduhYFc?=
 =?us-ascii?Q?9dA2zenbD07Vc7VqYf8wX0Q5esyXlvu6qSWt1ypbLHBVOygKH/xZ0FMV2bRB?=
 =?us-ascii?Q?KK0ydCSkGQgyatrItguB5+QsrtUBcbffkkaQ1a1zvhtjkeT+iTIBS2ALjmTY?=
 =?us-ascii?Q?n3Wh8Wk0dStC/7sb1jDt1uwv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa575a8c-0930-40e8-1db3-08d97218c557
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:36.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAhPEXIHEBqFLHyjSLKeuoVxPj29MnqKQSgiwnux3Dw6rcIjiAMMzKxjb0JD9bGBtqyjjsCeu0W0ckD4v2SnFRL3ufpvtj/h1/fi1WjyW3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070105
X-Proofpoint-ORIG-GUID: h3UTPDhcE32uAirPM5iiAAgSiiXH4br9
X-Proofpoint-GUID: h3UTPDhcE32uAirPM5iiAAgSiiXH4br9
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently both Secure Boot DB and Machine Owner Keys (MOK) go through
the same keyring handler (get_handler_for_db). With the addition of the
new machine keyring, the end-user may choose to trust MOK keys.

Introduce a new keyring handler specific for MOK keys.  If MOK keys are
trusted by the end-user, use the new keyring handler instead.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v3: Only change the keyring handler if the secondary is enabled
v4: Removed trust_moklist check
v5: Rename to machine keyring
---
 .../integrity/platform_certs/keyring_handler.c  | 17 ++++++++++++++++-
 .../integrity/platform_certs/keyring_handler.h  |  5 +++++
 security/integrity/platform_certs/load_uefi.c   |  4 ++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 5604bd57c990..445d413aec74 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -66,7 +66,7 @@ static __init void uefi_revocation_list_x509(const char *source,
 
 /*
  * Return the appropriate handler for particular signature list types found in
- * the UEFI db and MokListRT tables.
+ * the UEFI db tables.
  */
 __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 {
@@ -75,6 +75,21 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 	return 0;
 }
 
+/*
+ * Return the appropriate handler for particular signature list types found in
+ * the MokListRT tables.
+ */
+__init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
+		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+			return add_to_machine_keyring;
+		else
+			return add_to_platform_keyring;
+	}
+	return 0;
+}
+
 /*
  * Return the appropriate handler for particular signature list types found in
  * the UEFI dbx and MokListXRT tables.
diff --git a/security/integrity/platform_certs/keyring_handler.h b/security/integrity/platform_certs/keyring_handler.h
index 2462bfa08fe3..284558f30411 100644
--- a/security/integrity/platform_certs/keyring_handler.h
+++ b/security/integrity/platform_certs/keyring_handler.h
@@ -24,6 +24,11 @@ void blacklist_binary(const char *source, const void *data, size_t len);
  */
 efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type);
 
+/*
+ * Return the handler for particular signature list types found in the mok.
+ */
+efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
+
 /*
  * Return the handler for particular signature list types found in the dbx.
  */
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index f290f78c3f30..c1bfd1cd7cc3 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -94,7 +94,7 @@ static int __init load_moklist_certs(void)
 		rc = parse_efi_signature_list("UEFI:MokListRT (MOKvar table)",
 					      mokvar_entry->data,
 					      mokvar_entry->data_size,
-					      get_handler_for_db);
+					      get_handler_for_mok);
 		/* All done if that worked. */
 		if (!rc)
 			return rc;
@@ -109,7 +109,7 @@ static int __init load_moklist_certs(void)
 	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
 	if (mok) {
 		rc = parse_efi_signature_list("UEFI:MokListRT",
-					      mok, moksize, get_handler_for_db);
+					      mok, moksize, get_handler_for_mok);
 		kfree(mok);
 		if (rc)
 			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
-- 
2.18.4

