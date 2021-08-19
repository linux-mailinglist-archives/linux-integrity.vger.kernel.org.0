Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1EB3F0F2F
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhHSAWq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:22:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63190 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234404AbhHSAWk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0GIxj021777;
        Thu, 19 Aug 2021 00:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=wT10KcOVp+oYX6Qz9muM+t3vr4NXfzSU1Xt4wfjK9+Q=;
 b=dJsNJw1vMjg8ELuvnGiKaxpsABpx/G3DYy7XnF2YfBBZtftF3Oho8h9+7IUmADdX3SAa
 ygzOfIXC1md8i0af+9G08HqiyeKyp+CzifHax8pyOIVW7o4zFZhQ5ZGa2dOcQ6Q9c9A4
 sIys8DTiim25pXFDxK21L001gWzVBl7eU6nvI2UHIJ+TAHHWBgm97Y8lTAlntVpor9o4
 Vsa/xLUIHhPj/JSbtkii57hEjlNGI7J6+Ydx6tSMKSI+GC8IS58RKLyrbgwtK4T18Ozb
 VpE7jHq1fu0FB1J0XhzXytYovZtCE1gLIp3KDeTk1G37rwoiYcjO2hBjRC23xsGDQTg1 6A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=wT10KcOVp+oYX6Qz9muM+t3vr4NXfzSU1Xt4wfjK9+Q=;
 b=VZJnf76EzAiwG1VteH+SGIP1D79UrcFKf3zzcc/RceYK3GfuevAGmfRrva+9on2Euh9u
 CWLiFAzSANndHPapZ2GJMp2wRR8+c5yix4kDTus9dP8ZbmWmZ1ePRRcb6icXMl+UVW9R
 kOmgRyoQ0J4KcN4IRxzJ2ZB0gvb6bXhc6aEqW3v1ZZh6przBgJWrfFMhIvrOZGFDUYI5
 jYZji+xNE7vLL0KPKdrC5c5pcnrsUdsPJunZ8xku/vS9mho/LeXn7Fzf8YJdth7DGcue
 p+OTu09JYM1JagDa1BiPJmTHrpy4FT3R2jqxUwuDe+D9gNKWdJTu9rHtJgPwVTgdpR/a OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24jghq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0Eq3a160347;
        Thu, 19 Aug 2021 00:21:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3020.oracle.com with ESMTP id 3ae5naf93q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STxbrlbMEw+9iP2nuuUPMRNW1tsCAIfAXVrCgGTl5v7UJ7rn9NewZXl3M6EVDZ5gkEctciqcpFhD4/eUvXfw3DXvk1H8Lf2z5F1Z1wsQd8WsB/nm6Wjj11Cv0DkaHiYB/13SW0J2N0wV/L8LB1hP5xpfvx1e8pcFcx9/QY9QK7Sp8yFhDNziQnaqfO/Jd55aUf5Yxv5WGlE4t6YYrwYn7DXJlVD1MY2H8NTSA8SrGquqzB0LeTy24TI5IbRQbRc8OcMYVTJWfAHhehnRYMQBXODRxyymKpXgGozwUezBD4VPkSbJgb5XTehOXRbRPDXNg9BuRcuuP3f8pB3CR+eQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT10KcOVp+oYX6Qz9muM+t3vr4NXfzSU1Xt4wfjK9+Q=;
 b=Duuxtpo3UzqdI5J5mhrHce6/emov0JBRHYiCKKxRPAFmNSS7hpiNi2P7tjECyA75Lx8LuMcVddjvEKLbPHPixdkJvq96C5v3k1SxTJkbUwN8CtYKIEmW2rDonCjn+xkL666uyUECm9pUtXz1AqiRGkHGCKmH1U0VK2sal9hJxMjq2lFVpwCnWWPYX4xpUvY0r55QDz8GjAHvku7CqXp2TuGQDhiQaIEURVrvI2vb+ndS/jVI2pNUiDzhGnEZcX2zV9KzOnUK2QLf5TywbWZsuUbRG4CqLy8Uk0BUDW9SevWhhNWRGYOj8wwvxTPZ6XY1TwmdZIHudJ5YnmK9+5TZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT10KcOVp+oYX6Qz9muM+t3vr4NXfzSU1Xt4wfjK9+Q=;
 b=iDvl8Piw7MbwYyfAzQfk9CLyt4W4HoJGNl+WWhNykYybUUAj3suJ4tL8LraXojGUBTkMBljl5FrJTplSsUje3EKtZrV4Y4JPDSfe5u4W9QhqD54VpoZfZJxOaTd88/44vSbAQxSlFrkmuhd4ZJjOviZepKvHHFksyzmiZBwvfj8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:39 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:39 +0000
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
Subject: [PATCH v4 05/12] integrity: add new keyring handler for mok keys
Date:   Wed, 18 Aug 2021 20:21:02 -0400
Message-Id: <20210819002109.534600-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d1358ad-13bb-460c-dc16-08d962a74fd3
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB511610D1C30B3D432A0AAF4187C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPVvrQEOTpKfJVKmrDZb8o9dAFl2cZOS5ZROk89o6FXdAYVVsIUzOtwmwVQ9NBPJXUuH44iMBeiALPv3bJe8ABXNZM/mC1Bvxo4c7pYge9+0k9LJ8UexF09FVZSDFT1HBq1f6nlVzMieaZbtQlhnp872V505Pz3xVx//GzRdpWF9XSO9WX4Bwyzvi2JB/UkKTjVWMwQqkIpC4+PZHPbUezPLl8EF6ZvRr/lkOKwhwBAfW2K8/NWvfwzkGv0v9LqlKqWxwPedxcCXy3VchtFlOXV511CMe1drE8gHsa8I2j/XpUe4jMfvDhofseZDasNYh/VZ60kSd1tyozWwYVynUs573iX4oMhv0uFVwk2ABmcRY8DHXhRZp4pSaRnqvLJCtNco8edIxYwwhFX7rUcoVAUnA6T/qRyxUYtpBXKABxQVajlem0ZbyUa03I+E1qE1rcgDyMiF8yJksVC5eHcE03F+vjcSgttwuws+2K4bCGOB5RkP1IKl+hFWcpNjCQ4K29LZEkAT/lvGoVtyixYVGbWDEFwpzUCffd7zTvBiQWbNV5ZCemVeVBjNN4FRqLmFUJv/f+Gzrk+9zNGktfvbV0sBWnQ6drXkhnBTbD7d65Y4fWsHUh/p6AE8Wru7Ff+twJ8lKvnFsogDQ1xyPlE5vd9JhO832NXdYEwuoYePIHFcHffAzO+d+gYpThW8eytGlPJ8H3G/Y39eoXHnpQIt8XweR4NF3wx5NmUCFyXBQDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(478600001)(6666004)(6486002)(66556008)(66476007)(83380400001)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PO3Pg94hCnoaRY1hGzfhJlAURpIU5lnM/uDpYDUWQ3bYtQYNGtc1/PXr4dZl?=
 =?us-ascii?Q?oVtFmndP3/swimA5eghxMmeiEBavu/x8pGvtxaI8FZdo7bRJGXGJUoh1Xq6r?=
 =?us-ascii?Q?prlHTLj0rk9vCePrXN7Az/usu6aL7NoDMTGzALZ3CL0wzPCBlb4LO8eLiwa1?=
 =?us-ascii?Q?X/0FeuCe5CBUp5AWMivFJ85rgTI8OYkT0kMe+xYr+fgHF94afPD2u2XSt0xI?=
 =?us-ascii?Q?XNbMRzVgCYnF9eyXXizsqV359QZ+0d9ZbFChyb9Smg+gCv/JHIMzxXqx74ua?=
 =?us-ascii?Q?AsbrEzrna7UOALNU1oPuUyFva9+96nQG4iSzqjhtLg5KmO7uYobTdxAlewZ1?=
 =?us-ascii?Q?vEJAj1+CSaYNJrMD4WpYFoA57H/AUTP71qGQe8+nj3Zx7BOpq2/bVphnxhbq?=
 =?us-ascii?Q?gfnorOZpIGCD/24luyvkVkIkLVSp7PNKfxNoDNqZMem4Hj+7w1M7IXO9s2+s?=
 =?us-ascii?Q?zSLzHwCDj9k9aYjFOtKkH1ZfxpEy1peFVr2MkNx8WQEjrkakedMNTJ/UHQLe?=
 =?us-ascii?Q?jh/q/u6CWGfnF18jyE0XON7c/ZYNXkJA39N9fgU009LLHbwZsngK+LAUDk6G?=
 =?us-ascii?Q?QLiMP5teU0JhYtCMooRyT8fOUQgPdTZ5I+F016mAmrER0vObEqmQnuqQK9Kh?=
 =?us-ascii?Q?VrTBVxDnHXaOrr/6AnQ1OZOn4ldHA+xIU2UDWL24uXq8rCUXris9x7TT7zbr?=
 =?us-ascii?Q?a3OdZtZRiv/iLQFSy4UQlZg2vj/dzV4lYoI50LWba3m5gKxYltRbPhT/OeYo?=
 =?us-ascii?Q?spNpkW1SUUc0cobTge3cJTTUCQX1TXHoblvo/jrlnk/MUrF5M6vsWWkeTNUZ?=
 =?us-ascii?Q?r7CWxtYHmbIG4eDEdDRiU9+JNAHgfyAWk2qkNA9rQ5y+IZA8oq9Xzn59gPlc?=
 =?us-ascii?Q?cxHI+wARZeY+efJP6+Qtg8YsA/iKcioELGj8kcIcjgMqa7JMuY1eKbvqVsON?=
 =?us-ascii?Q?Ql0VSzWw6q0cG1j9lJi6lBVA6eKlld8A7vkr2+TkC7Ma1cBckvEcOgPNqkjI?=
 =?us-ascii?Q?1y5gQUE3dnE2IWHOb9yN3++VpbASTmgq1APMFwsetAbD8ywQRX0oZou7M3h7?=
 =?us-ascii?Q?H6f/yTFcGu+IgqJ6/eHvbBQBOajaA+D5BQRBuakhxZPn8uAQc6WdU3WL72TU?=
 =?us-ascii?Q?RDe+a7/loTvgmdYwTuRNs3ZFWTv4/XWTmkK8SNMSlCb/JGMaj+oL4B6brlA/?=
 =?us-ascii?Q?/ZSTq4dvRaaAGRUtnUfZc9Q0w80ngldw9ZAaf8grWzCQUewSbynaf5NUxzbj?=
 =?us-ascii?Q?caAvs7hrXAL6A0ZvzC8MMtbQJnnM5Ahvl/HVFG2rLUAdGQ4HLPucxEjkWtEz?=
 =?us-ascii?Q?6NbtWtWlvnNLqR7a41ymd4XX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1358ad-13bb-460c-dc16-08d962a74fd3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:39.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMAPsJIZSjcDlpYydHZKyZ/arcaCljcZ4UZxUnxIPbHS7O0JHmSt9R/cCJnFOuz04hQUX79afjpouky5Tno2jkeACst0GPaNbs6PSBogJxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-GUID: V11UY-fmiDQNflO9-LUJNjTKFUZc7Nlh
X-Proofpoint-ORIG-GUID: V11UY-fmiDQNflO9-LUJNjTKFUZc7Nlh
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently both Secure Boot DB and Machine Owner Keys (MOK) go through
the same keyring handler (get_handler_for_db). With the addition of the
new mok keyring, the end-user may choose to trust MOK keys.

Introduce a new keyring handler specific for mok keys.  If mok keys are
trusted by the end-user, use the new keyring handler instead.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v3: Only change the keyring handler if the secondary is enabled
v4: Removed trust_moklist check
---
 .../integrity/platform_certs/keyring_handler.c  | 17 ++++++++++++++++-
 .../integrity/platform_certs/keyring_handler.h  |  5 +++++
 security/integrity/platform_certs/load_uefi.c   |  4 ++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 5604bd57c990..fc4ad85d9223 100644
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
+		if (IS_ENABLED(CONFIG_INTEGRITY_MOK_KEYRING))
+			return add_to_mok_keyring;
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

