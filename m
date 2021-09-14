Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2040B9DF
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhINVQv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:16:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58208 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234524AbhINVQg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxZV9025999;
        Tue, 14 Sep 2021 21:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=G08I8vxFY8p4pmLHQZKwPUoN1TqrvrDJyza060cmXIg=;
 b=g6x3JZortoJ4lXQ+TzpdcpRVFjCBxXQvn/SToAgGpHcxfkpPdKWcZgZWFvXxh+r8nW7U
 lJOQ2m5iD7KhOuzaG8bxyKdKNEo0DPfk2/aO1Gtgid4Du17hhW6gqrB/GR8sh0tC2pbt
 EdojwHz4Ea9J9tgF4E5CIgG0KmcYJa1tFqxggvnPOQ+YecYleqNH4c8RT5G7mJV02cen
 W4Yvsw0TtBsDUe/T0dQbkhPO6aWPiDYRP3BmQQlzRy1Z3h3Z6gaAUc+UqVy3PQMAHJmx
 G/NyjvOUqP9GrqVfUIUAQKmEeCQASy06aZZ3QtehXRCsjGTYp6OezR7ZOpq/T0gkkhVs mg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=G08I8vxFY8p4pmLHQZKwPUoN1TqrvrDJyza060cmXIg=;
 b=C0ltxTovQd3sjEP/JGEpPrMqSKH3ZA+d/nysZuqOWPLhM6FuV1lQ1iB7P9bm83PJpuQg
 qFA1bSb+QlsD0gr4m1RlnrBrNsqfgHSlRKnIPcj6UxGoloCLeto4mXVMYJ+eLMoyv6rV
 oS0J8e6UrNKLBDCnK3G7aqOxdtXvOZDjCx5pllj7+fd6TS6JVtuad6bd1r7cs1xsdxyh
 iIlwtOtysk+X0UYZx/M55svWvKAVgDasnnQRvlrWIrxDOlyVIlzyqIOV0pM8dmeuhh9s
 0C6Xyf/KHQZSFTOmKcaOHHck0xbltM267tfVLelzOeJCpv7B0yheRVpvRDYM6eZpTMS7 bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2j4sbcy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELAXOE054934;
        Tue, 14 Sep 2021 21:14:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 3b0jgdpk0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMkBHLsjpfuozyqf5KG/Bh4DuDBUCAdZmmYSjZFXD1ii8xxLENCgk1Cj/NkG8KpRTWVwQx3gX/aMexDym6B85zaiv2BTLpCpPt3Jg5GJKhMYjh2/o2B9zWY5xwRWMEjLoU0VKACuxy6tophfsrhFosU/moL8tViYd00v0dfWMIh0kw7dhcbBeARvNpGE4ZW3Eih0Y7dgDUlzBpxRbh4Hz0izWflmgX/jEOw4vCu4122LMe50yqH0c/BDZHk+0LElBtWdA4ud4PQcza59KnccZgi+NN0SPj09ribRw6pz7JSDRSEJ1B2xhX83oTyypPtgWkSDX1y/4ItZyHlAqRNsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G08I8vxFY8p4pmLHQZKwPUoN1TqrvrDJyza060cmXIg=;
 b=KsPyCztUKrZwi3sc5FfTPwR3mVf6cBsHliQ9gTBSWqJpMdBfMxv1Hoj3rSWmCqUjOdMQKObzspoR5TqM53ttNfJAhd2Sm0wcw3vsZmQ6lTaSuJ+tVzsiDg0C0Uh3sx6IhXirSM7a6zmcTLOiN7E1LDF1m63hkoMqt2yqRcnrJocalr8Js6U5bc5yriUzMAn/QfHsP+Giu22iTbKe8NIXKV/1k1pJZDDGmydaApraIha4NRV2wOs4rLwqPe+PGYxPHsS6ZcuvvP+DezUjizd/WM+QhbSK5XmTpe9sWhFCtqPnobt2xz678C36DQsDNaBDP7PJfYN78rLoiuy7pMesOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G08I8vxFY8p4pmLHQZKwPUoN1TqrvrDJyza060cmXIg=;
 b=u2x7/681HO6grNyMxdmgeRh9oDx+Ovc4JXsDhon2TCZl8S55oPu+iZLCinXWbWKQPVgHx8KIemGWwTSYXPMrmbNSimDA8xxGSzUxgcDQVUZTGZfWcCU7KaCmdOIXSQtv8n9XOVtESMmcSrEe1Qn3BuZy68HqKi1WZi+luruaggU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:14:49 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:14:49 +0000
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
Subject: [PATCH v6 05/13] integrity: add new keyring handler for mok keys
Date:   Tue, 14 Sep 2021 17:14:08 -0400
Message-Id: <20210914211416.34096-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:14:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b546c13d-bb10-495c-4f46-08d977c4af4c
X-MS-TrafficTypeDiagnostic: CH0PR10MB4908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB490877B3DF476CEC8FD7DDA887DA9@CH0PR10MB4908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2o24KZKf4CSp++ciR6mDFDafKvuI/nXAda0uy2MZd8e+LprJuK3L7OiViiieuOHVW4GElC56s+0aNF6oudh2ezFPkSI4yGcre9+b/IF1xbcZf57PYvz2YGei1WgoXohbB1J3E0lUXemNkATEovs6fO1JFvVJreCmziZitb63KTKDeSkKf8YSXnhaypg0p0klAcpp4zES6XoG9htuxnQJpQGnE4sRj0jzyTks61x2dbhcc8al9+r9hS9meNd1vLPtxUvSvCdiDVFjbxOhw5YSwFPOJD/UyB4q5vymEjEQGZF87r6TT6kGrAGYiR29KuoDEWFsYCI78CVGBEvS5bCw1YFTpwdQKpCO0FggckfAlE6rU9ADF1C5L9A7x9ofQOXPfCfUVkdegPmawxlapVkUpgsiqX7Lh7i0TT7n92YtgnBhs1vf8B9MSi48bXEEz2NUZjTTOdWcuXRbqYYSaGafG4Ry7bJeSzNuWQI2SNk/Fcx6C1nB5HULNJ247rHcaeAKACPwWsG6hLXAH0tPK6o+pLDaVCb9ZUVPMJlN+YewHaRACHZ4ujv0o+Oe+ZGLDi4zz2vBSV/lo4QOBGGLbgwcjbVHBHDYsSX/npFRH/BbvdtNfgvjkcWIU9m6N8KqO+7wBqAXaxMLJJqfsSdQq1x86Tmhh8xIfSaOetow0BmegsKRftjIwnhDivoeemQpfq5WJI0ZYMFSpg2s48v/c0AxxhK17m8S6orh/UZcY4xTa0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6486002)(4326008)(6666004)(2906002)(44832011)(7416002)(36756003)(66556008)(2616005)(8936002)(66946007)(52116002)(921005)(956004)(478600001)(86362001)(38100700002)(107886003)(38350700002)(26005)(83380400001)(1076003)(8676002)(66476007)(7696005)(5660300002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kClWp9CuxIT6IwMiX7JbHzF/WcgLcJR1I+FadzybEJ4GnGsFdLbESaX/l1wH?=
 =?us-ascii?Q?6OSr+jAiD3Fg5S9INN49LFiiAbRr9nCepEKYovWguSnvvCt5bYKguXO1QWe2?=
 =?us-ascii?Q?HMc53xM5s4mZCEvSLkhs+C2ii+aeA30WLwzGYfnbMt7KrYvthFjRdQj8/8Or?=
 =?us-ascii?Q?WxejkwGJ+WeVGhirhc/wInhv2kA693NTbv3ewnhuJHJRRPnBp+TFmgmgJJd8?=
 =?us-ascii?Q?LZm17zC0eF9RyXL3QPu/9SmLFaZeybhiS4A9GPZe63utnHZuWgAzznUgJQdT?=
 =?us-ascii?Q?l1Y7+WeUfBTp0DZ1AazigQilwueLhb6F7CEwIjxPpZeYG05Yg8EAYJcWQjoD?=
 =?us-ascii?Q?90PYeri5CCYFwcfNaUuFbwS3YwzLxwwW1saIg2QUyEhV6bgINZbDQclsF0LF?=
 =?us-ascii?Q?9rjruRHlYHu8ltaYnhsPrVVZXT32Kcf00SPp3uGLSfQR3cwbL9Vsd/p3E9V8?=
 =?us-ascii?Q?n/UGOZHZUaBLUHd6ZF0w8PLvSUQ/XtEBNWMZNtYqaHzA+nUVDD7azpX1c+Mr?=
 =?us-ascii?Q?7wicCBRoHBEY1MdfJhz+hNCUOXDaXIeqCx34usU0HQZhg6y0T0ZglyehB9Z4?=
 =?us-ascii?Q?3MZXYBRMYUror7EzTpwEZKiItrFXP0h/QvDSaP0k6yCuxx0X5aHwQH+uEphm?=
 =?us-ascii?Q?BRZtcZkA0AENmJxvjKQKtqTiYnFCFADvnOzzSix/ZFN2Gn3c7DzxTakRox1/?=
 =?us-ascii?Q?rmCPyP5vln/M4b6QKrd75KowErU+wB0kvujHr0tFduNUfVELjmQGL2JaZi19?=
 =?us-ascii?Q?FACSNnd30lJ46DzldG2BwC7WFCVodXj3r61iHPxUhxPu0nfc04fhyiyagHtq?=
 =?us-ascii?Q?NIIZtWJaBTFzvYUX4PYDc+jXvlsOoXcxt8A/3yGZuitITR7oxs4ugRTcZiIq?=
 =?us-ascii?Q?GuqkAYPClVDTOZxAnBlyj5dxroIQ/VNX1UMIeSiwGnY3PUejepH4qxdGrYrO?=
 =?us-ascii?Q?VB1nPg2RaRkl+7gPFMGhTzN2jJG7Ph2+UbBG0Cn4m3jtrcM+LK0DQkRtsP5n?=
 =?us-ascii?Q?dqrIpuuace0EskcPwty/HuYba7CdDq3qhf8GTScIVRdmVYP+VImVlsVVcMSJ?=
 =?us-ascii?Q?JTLBzgyBP+oTRiolkbB5k6xoDyKpF/vvY9di0uTZXLE72OunMtoI3tbvUviA?=
 =?us-ascii?Q?VoIYkHr+g8lrCjKRaRqvsEWqW4K/tEmTTER0Ofyc4i60lHQeR81p3dKjwYEJ?=
 =?us-ascii?Q?jzOlVmW0Ok8KOGXZKN0JZg/fFCYWlPa6pgkACHhEfSITn3Wlx1kF62dUJGcR?=
 =?us-ascii?Q?HUHow1NcI6w2GpK9mbidtlYgVe1a6uyaKswJ5YuExRbfTDWxXf4vkWg9bSfm?=
 =?us-ascii?Q?YqtAE6qjyYwe7Y6taqoR4NDA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b546c13d-bb10-495c-4f46-08d977c4af4c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:14:48.9876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QNAF+dUVhQP/MxUjnDjyz0iQYVNvizNspggPAPl2wwPRWfL1QPsyUMHKizhBtrcH9hUD7CIK5WLO0CcQ3GIrRjCqpn2YEVyDKReZza4+o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140123
X-Proofpoint-ORIG-GUID: Pju297uP-W8eqjYgIgSJ5Tyck8VSHmp-
X-Proofpoint-GUID: Pju297uP-W8eqjYgIgSJ5Tyck8VSHmp-
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
v6: Unmodified from v5
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

