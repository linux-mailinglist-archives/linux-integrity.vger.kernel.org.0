Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4212E402C70
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245589AbhIGQDh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:03:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57922 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234331AbhIGQD1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187Ed19P026809;
        Tue, 7 Sep 2021 16:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=GMTlFF5w4nL529MxPunFlIVGqlzK1TEOovl35Sayv3o=;
 b=N+6pZUew49DDZ8hrjbSzS9xs6nxoLtNsUGgW7v24bpfCfsfoXgpP6EKB/PpjOrR+teXh
 Ht0vHZgluwcVyGzyc/ebp1iti8RJshtTzDomptLeFKDeETZrfxxEV9RwTkeecXFIVIMt
 cpwA/l8iGjGieRuQ0KSKpYnOuJsk4WjXByThsuSk3wTaqpiuIxZX5S4GM1AMpvYGysnd
 tRFRRiwkqO7u7Vr8POeUOIpCRzw6Xkj+jjGerQthqP1yWpBWIAJvKydmxXMUoPs5v8lw
 T4mBxos9cvIDFvVaIQoejeA1mqyNWtP5YlvizxKWpqCP05n3Cv8XW4ovTc97Sni0qLr0 2w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=GMTlFF5w4nL529MxPunFlIVGqlzK1TEOovl35Sayv3o=;
 b=LvXv89fJphzXENUtYKDXQMY/F+tSo+DPiN0AOe20Cq58q+SqXlkwqNkmT5QngDT+7OWB
 RwfN/wOUFxHQkP8Bx0yt/Cv73rIXidJ7yNvqUl/VbSGqbO17RXCn9ScRfAbnYuzy/8Mj
 1WfYKXcbOTVXv9sDbt5Mhn5VWu5Z/dGYZzPP2EsczbVp3jSzMh2TEAbhP8uHnVmOMmVA
 H2H7Yb6S9Ht89WkU35IDCC6AZIUc/rKWl82h1bV4hHibVHm6GxqOdEnarzeewo7zYFUt
 RXFE+58rSSsvf76pyj7F4eVGzredkHT5fwfP044A/wWEjlzQ4oQRsEl4r9TjQ+tfmTtU 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq29jga5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G01dV185488;
        Tue, 7 Sep 2021 16:01:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3020.oracle.com with ESMTP id 3av0m4t516-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6L1j0xzSWIxTBdi+uzdiWIFjbQITqAiksczM5h/HMsm9I96Bm4gEQNhBhdjtzxFXnVXAxoGZSWc0f/x+UX9IQUN/xnSCp9L1NmBJ9Mw59iBfQyt9EYpN0krrgl2GAVcd4YVIaAJH996P6jEaRihgKA5IanV18R+qkQOleV7laWiY/WHa8sqNz7crSRV4K1z+YTK7F/ykI5r7lfTEglhUpYW8pvrLSpNEtdaQAqwYmcQfEMHPZrnWgTiDD+uPGQRZugYQpBfqj45nF6xRqvNXeGvajo6JTMi8W6YE5j/1N7cyrRrP9MMHaLbKZAvpONn77bJ+gwUWHhtuJtA01me8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GMTlFF5w4nL529MxPunFlIVGqlzK1TEOovl35Sayv3o=;
 b=GEa2eJjklnopNx73dL0ko5HvGb+RygXP9dpvnbyCt0b6hulF8fIT/m0o46+PKsZVQutMwha4/aDHC3yIsLUoGFO9P2CEauXQUwzl2o3N2zaRiwwzWgwJcokURUPDENdXxiDVzoECfWJIwbnHOhsOtvCtLkIYfcdbdqOXB+5M7m0oEbT09/9wXKx/zwIFd+9FmjwakkrqHM4L232phP5xlcvHtkwBronv3RNwxUIJKYhc9naXH1u6hrDpqAdGT67P1tmwNs7ptBtwzdPiSHLfh70uP7qrnX4XZRGXvo3o+cPbFWYbHDeUcDRbS6+GW0lFV24uKO9SO5Ijynr4YzG0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMTlFF5w4nL529MxPunFlIVGqlzK1TEOovl35Sayv3o=;
 b=whert0k2ry5dU3I7oXfD+/L0ZgOP7CWDTTQmgSAvBWBA/PxM7bgQdISVRZIV6iiGaCX6Ap6u7XXC0ZfMJxBfq6DkBiZ8QUR5kIPWTW8Z8sl2GFMeXstDAAXdtUi9dS0NK3A6shB3UdVXrT6l3eO6Ix0u1UVMUTMnJgC/17nsa20=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 16:01:44 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:44 +0000
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
Subject: [PATCH v5 08/12] KEYS: integrity: change link restriction to trust the machine keyring
Date:   Tue,  7 Sep 2021 12:01:06 -0400
Message-Id: <20210907160110.2699645-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 848ffc9c-3b19-4f02-62cc-08d97218c9b7
X-MS-TrafficTypeDiagnostic: CH0PR10MB5004:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5004A1662774514F579BB5CF87D39@CH0PR10MB5004.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFri2EOaxo2piaL0tFACUBMiR/Rgq0t9mbSdA9ecv/IPY3Y1WmTLEJyKDcwyFwFLdZ2jR2GkRPP8Ts2fPGa1MVfSPUo3noSpGSwjxivISxSklAhSO57yaLdiSYt1TfabvVssEzJV16NzRuuW7fIsG6PX+Q6SMrmT5Q9LLBbcD+ZJEwDOVaTN1dON3ZHY5eY69wr19RKro8yrHQ4eqwniurhjVxQRRcfuiZF8uIkzln3fpnfpFlHe+aO14hw6wwq98ae5jWMDXXcSvtArehyNMS8Ae5gsyPGYepLUAoYKDuzvBm+hTegQSaJP4FkJUu6SVgabFHpm3msBbaV6VFNlp0m/8Nq8HeKJrO6IIrnVb6FNld4j82w5CTY5Gn3phUuQnD6RvR5phpaLM+7+ciwtSR4uO7KdlJKazX8k2RHtobHDhGHl2Uz0wUOvIQSeLByzLiM8SazDq2TOdtPLvJ+srtNU95/C4sNcTOsPGIYFK6LOaWMr3iua3kCbfKTnA1JZT8duVQEo32c3hkXb+OD5AP2jI+GfYmxEtUGM2ZA5Sscx/zljO1Soj+gnW/y2ZHA2YyifCJgm4xCN912eTAxMB6i0yEMJqRzK+TiuFzxbJmNiIh9tdJY1/32q39VSqH0jRl6eLAJYMwtWUMTZ4XaHyA9dNHC1+zzizx1OnxI+bzpNNWk9dOiN6q0pUnSLHvr/U4hNdUDxD+6OA6L9Ff/7HaYfBlX1nqr538vH0ZJfAZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(1076003)(66556008)(66946007)(508600001)(66476007)(8676002)(921005)(8936002)(44832011)(5660300002)(186003)(26005)(52116002)(4326008)(7416002)(83380400001)(107886003)(7696005)(36756003)(86362001)(316002)(2906002)(956004)(2616005)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+eMNo6wJDesseUQmKCBklUbqAI2CQC+tIfU8SFG+o2LpHH5uQMZJS9fRiaJX?=
 =?us-ascii?Q?5X+KgjdL0nCOS1YvGjK5PXvJ+885MErJAfj6ohw0EiWpnXXjqjHKceHKV9jy?=
 =?us-ascii?Q?Ux3iJ0TuCrXZSSb6O9/EiZ0pmcdrfa77ZSVwRFkURl3SXST/UQmd0QrYCu8c?=
 =?us-ascii?Q?/+lFI9QfGRY1haWC8evNOFfxjzyYVMHywKkLO2mNLcaFt2VZaM77lMzj3zAe?=
 =?us-ascii?Q?LCl/Aq0F3uYpwssDfyHD0e7sqj/L+vkFu3tqgEYabaoCpDwTEEJZdQU2rcbC?=
 =?us-ascii?Q?BdoGg5QWH8sBxRrOFDktAy4VSYk9kJUIZEDuyZAiZJBvnN1F+FLZfJZJYnXx?=
 =?us-ascii?Q?eYJgLTZEMJtCk1XmjHeCOhnRsWz+uk+YEaxpFmuM4P60tOoLCViNMe7R/prE?=
 =?us-ascii?Q?S4fwwgS4L73tMKBNaBtSoVRo0VCJ1RxyFAloDJQcLxldfUWh5n8xR4mrfE4v?=
 =?us-ascii?Q?DQJs7MEKnWyDN3e5nx8DNUdt2bE4YXfBSrhfctUW4Fgldzb+hOTI6o0raRXc?=
 =?us-ascii?Q?eaeOapHUB4sfrHGoAxpgob5jaPVH8c//a+RlKqI3Q69ERnPG6I2w/kBdht9/?=
 =?us-ascii?Q?iCQ2Abi7fVNCOapWqYtwrZljDA7gIF0d7SXLmcTdALM3kWohm4imrHvigITQ?=
 =?us-ascii?Q?Cv2qKgMJPikIhon49TvY89xvpaKQZw9Dtqk3/zwrSPM0yGHmQTSZpombiPiO?=
 =?us-ascii?Q?SyCdYXqP2onVuw/Ku7PChc3mWpg4DTLku0fFI4oyvgK1BQK39m1YcGMjmx4V?=
 =?us-ascii?Q?WEKCBsd6/xjR4/fJBLeVu2fMT2q2tt8j+w8dkcYibf0H5EvlKTsyOTS5S5D9?=
 =?us-ascii?Q?je758swMg0aCO0xSS8LKugbieQfrVUiAhQcjHIbKZJEnLd+LUt/lHV1sEGYm?=
 =?us-ascii?Q?5wZqGocpF9TcgwnspKFv1aDggEI5NjJrDsC+G0XKmSPb/yMLayugDJ1RT8oO?=
 =?us-ascii?Q?zp5NniNC5yTU3nQkBDnAk3fBZT8J6Nu04KQR2rIt7LZhe2gjhq29weI4te3q?=
 =?us-ascii?Q?r4hRfwZKcywfloUHvTuQj38ydpa89G4tPDniuJBSXZV4MvhC2sCsMIUzvR1E?=
 =?us-ascii?Q?3RYHNEyhRyTHOf33Uqg4rpHx0WQibZ9P0eWeaVJa+lKahB5Va7DvV9/2vqac?=
 =?us-ascii?Q?UBJK9CK5SYRZa7LX1rPyoC2T4dQHyKPh7394lpt2WNqzI67QTciYKpn8Zm2A?=
 =?us-ascii?Q?Wx9TvgJBPXV26RBawTtCtXizDlz+YWK74IpyB8yQAJe2zwJuUeBFENCPd9Jo?=
 =?us-ascii?Q?cp62QhYhZxzMqMRUZCKvwVBWzkz2sJip13bii5Yptuv9hFZw26Zz8dP5ulIv?=
 =?us-ascii?Q?yrFonCDENXthTkI9HzJFZB88?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848ffc9c-3b19-4f02-62cc-08d97218c9b7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:44.7298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoKeNJhn/vZb8mfj4gPXRCYLgVmoQFd5wvhGXHMiaDTwtBMhRQr0qrsZaYfTPrl/9uucg5oMzCIOthYG9Gp6PQ2dfHIAi0o/fz7TPDqEkxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070105
X-Proofpoint-ORIG-GUID: 9n_klbiYELuQlYWBebarMyZlX05gysvy
X-Proofpoint-GUID: 9n_klbiYELuQlYWBebarMyZlX05gysvy
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
---
 certs/system_keyring.c      | 5 ++++-
 security/integrity/digsig.c | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 955bd57815f4..747f0c528fec 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -89,7 +89,10 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 	if (!restriction)
 		panic("Can't allocate secondary trusted keyring restriction\n");
 
-	restriction->check = restrict_link_by_builtin_and_secondary_trusted;
+	if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+		restriction->check = restrict_link_by_builtin_secondary_and_ca_trusted;
+	else
+		restriction->check = restrict_link_by_builtin_and_secondary_trusted;
 
 	return restriction;
 }
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 2b75bbbd9e0e..c3c1939be2f1 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,7 +34,11 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+#define restrict_link_to_ima restrict_link_by_builtin_secondary_and_ca_trusted
+#else
 #define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
+#endif
 #else
 #define restrict_link_to_ima restrict_link_by_builtin_trusted
 #endif
-- 
2.18.4

