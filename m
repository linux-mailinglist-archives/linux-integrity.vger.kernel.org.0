Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C383E9C30
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhHLCU2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:20:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40062 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhHLCU1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:27 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2B9VW031678;
        Thu, 12 Aug 2021 02:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=CBhdRXOFcF9MXz6FTSZY+gFbu2bkXFKvfFXXueJgB/0=;
 b=s7e9QZ76rqUmGN50FMwQQ3oKE34ftnRSD+rtaOlsGsP7UhEAH+16uTjyYIscAuXaCWWr
 ffQKxbKyPrnHIO5gSKisSyweVK/jL0Xkl8H+ep0/3Ez1NbiVuh6C/WRnRm/IXfrYgZbs
 jFpM0x7TQiJYGcXptG1KdbqZvOODiTxrTWZxP2xmp1JfHaSCW9HvSv8F74JqlVUqIKlS
 SRgpnHzM0vSkgp1/qxefl+0bu5kS27b38zoZAYUHPSZMb8SVhmQuTskQKWZoRgBlC/S4
 DjeF02fWWcvUydPA/Gga8mGPhplysGL/ush9f9IaW7ffY2Vl2t3ibmMHMpV+09BYJvuI NQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=CBhdRXOFcF9MXz6FTSZY+gFbu2bkXFKvfFXXueJgB/0=;
 b=0NqFHhasbyO36LmBw+rpdkjIANAD7qP+2mhtpq14AddhHaOPXlGHw4xMOyik0n0fg64v
 me19nWLFOHuU0zponVhRrzk6Kr4Nb4MB49lLr6F9Mqj3V2Tt4bu00ZQVll+U/uLD9zPj
 wxdknO3cPknzNJOY1ERmjOLxg0gN/crzrUZ8+bRKheaFNLSItrFsEh4OrIscBkW0qaZo
 ai7fpAhjmQ1pyDmN4QYiY3v+NUeQlyWbTvRkSCPBL/kUKuMS1E0qcpvnqF153R3zdv7M
 zYSObTClMh3nip7Ye7bDaTMKwFRXcfHdIq1kC8gQ0josry7t7J+0j3C79j3GS70Exguy Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd649v16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GUsO117958;
        Thu, 12 Aug 2021 02:19:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3accrb4sch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVFPS6/ENEoQijPrVfq0jdLMkhp6wmRXebO2o92V+TRyx5jBEJuDiu9Kq6x/MtQ4FNw8UttIsxTHXJSENHCbK352A/slmgs5o8FkyMVGYxTciQiYkxzU4Rj6FgxzSOnfjasXsTWCPuGzDUjKcXb+i6CnNRXiAM0mBuWqUVHLD5Y+Akr8XiuccVCcDCoCEZZUQxgEEJ09e2fIzwFTP6k08O4raVbuL11PkhEzojj1pD9X9shfdanpq7DUQlReGzmosEH3QuA92xyPM1bM6mhExc9FQcbUo+YBN9s5MMAF98hRkbHUn+8U9bFMOk+n7JsUFfFI3dSHeiE6xBO+uNS9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBhdRXOFcF9MXz6FTSZY+gFbu2bkXFKvfFXXueJgB/0=;
 b=CkjVsAkYhCujdkpAqy3N7W6tsNj9hOXMOD5cATCieM9o2lFORm28EpvRj4Tac38BZiShyA8SSwgnh5ScNJNcW0Kt2ydQRTUpuGjYb5CtP53wDrGmPjzeWCiJz85X4lRRwDzZ0nMyL37fD0x7m6lAyxfb82Whgokaicw4hENfBZN+/OnSE/p0rJsgpd6Scu5aEQ0FRgGYNjnhnGl6gCGxG/v62XJ+rcY582GbwRfEKw/2pSbgZa1gjh7WYu1rS7YiObdo4VUvYXfUzbDnw9f7SFnMrjhC/RZiZVgtd9ZLTR5yKfoYbay0aSA2azJpDuYUP9rPOH2nkBrwqbnQyey59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBhdRXOFcF9MXz6FTSZY+gFbu2bkXFKvfFXXueJgB/0=;
 b=ePZ2MBCb1xvhEqZgif9Zs2bZ1rOd7uzMAo4gFZY0G4Q4RumjugEVHeSdQD6fQiv4BpwUUSOapNUE1wsk6lTeHDK45RbpjhM2VSbSdJImR1pttapCacifFwb+DeA9xm99MgPgL8048vqDePCDY5BYG/PyPJ0XWIsIxxmKhS6z0Yg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3960.namprd10.prod.outlook.com (2603:10b6:610:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 02:19:31 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:31 +0000
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
Subject: [PATCH v3 07/14] integrity: add new keyring handler for mok keys
Date:   Wed, 11 Aug 2021 22:18:48 -0400
Message-Id: <20210812021855.3083178-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ca0ced-0ee5-484b-8f4c-08d95d379e2a
X-MS-TrafficTypeDiagnostic: CH2PR10MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB39603235F91B4823F0E798D987F99@CH2PR10MB3960.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SHN/pxN2ALJ0aPOWlpqMscukFtaQa+I4ZMd9R2fMg5maSY3pivUXaBuY4sS6hnxzVS2qpQcywAwbQVlD2Je7NPxJ1TN2F4+L2fo0mWCjSmw55YORp32fM7qf6dal76FStDhxePQNjWwZeRymCe7V0cXpFbBhtO8DLQeziPERIxk5QuV0FFbSCZDM+gtepfjHfzp+xi1yl3N9Yk+BxaHl3yxboTOWsylbxy2AenhM4MUFecKYT4rk/uqx3S2N5FY0fQb4EZdXjqoHAMmaZe7O2vAfODNEJ0+HoP0YR4EwZy6GGjcqOLMVwdzZ1EWBvP7aZuKHE9BvdcgohxFE+TOV/U/v7ptyfW+Sf0OseaeBdzPrv17415rmKqtHrP/GdVXlaCxwMthYmg/bfXxPMKZ8iMnAJ5hD9IJT5tc0SWvEO9TMffyAtRhhmAhm5cj8wD0NpGyvzkKAH9spbTKa5WunnrKCVL1RJQTYM1r42CrwsaDHg/dt474IMp/x/MxQpQHOC8wh6Ubs7BPogW8ed5PwX4qK6osahxJqTQ5Hx3UYqkaathHmmZTKU1Eu5NRgs6Ajd+IOceH/SczYDqkpazUCwq22dT0+hNmZ0B+KaikjMPtLughLCnYCnOZZTo3t7xw7cZt3EUtdZsj6rtq4p1KN5X4mA/EMe0MtrQhYNMYpsElc5v+Aqvnn7OdqflbNUDZD1SvQv7zx0r2JfEGKWrs+f9R0LA6UBFM/uxyHUa+N3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(7696005)(2616005)(38100700002)(66476007)(956004)(38350700002)(8936002)(6486002)(52116002)(66946007)(2906002)(44832011)(478600001)(316002)(36756003)(26005)(86362001)(4326008)(66556008)(921005)(83380400001)(186003)(8676002)(5660300002)(1076003)(107886003)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RasQ0DXTPgpVbq22IEMnaPe3+oQJPqHfIcQAXHM8TKHJVt0/EQ/frhnVT2yK?=
 =?us-ascii?Q?dVTleJyYJ2ZacWxGCHOnX87XaR9w7RvzZQfrtQlxhHdROz0ku9pz1HQh7dR1?=
 =?us-ascii?Q?EGw9BGJ9S2hlMwjvpdQ5PHBb9+tuZenJORUL65pkDln0o85Ux8BExwp7rRGA?=
 =?us-ascii?Q?t/KEHYMetRWUQmO2wt60xJ8sF8Ea14TDp7ppP21EmChwnAWH9qCXql8wz/We?=
 =?us-ascii?Q?eLe1oO/N/lImYY4VfnXn5bbCs3AzYsQF0biMC57/hxJkoazAN/8I07FLyf/p?=
 =?us-ascii?Q?xdM+GjkM4WdrIc9rP2h/iZs9VFGkp6jOK3KRsOZn2q+a4P7ULPUMLsy1EBXq?=
 =?us-ascii?Q?srDnvPUjGY5lWzLaYiK7B6YDkvpkOjGhXdBEN+F84ZlpCOpd+RhJjFWTtsCH?=
 =?us-ascii?Q?ZO3HAtQnzPMbjQ1uFqun3JrfUwkblXEIJXkPq1Y/+OZdKkeg+wwUem+t0zua?=
 =?us-ascii?Q?9uXkiwVES3pQSCbTUJTMLxnVHZUzWOxDxe34pFi15IGzsjP7fFwgFYmqiCQy?=
 =?us-ascii?Q?jHVYRvVJaks0nLK0f4+ff5T8nCp/mvF9lPm0BPnzvUzP6VwR0wkJ0KHjKKL/?=
 =?us-ascii?Q?TfAW+xr6vDAu+42x8OuC5v1IoAmqe7x34ymRUPnCeEKnzX3XnZ3f0ggUpKqy?=
 =?us-ascii?Q?yVWLqkguTAac0eNQTG9dGyl3/HDO6pDnZDyNBFXsI8u3SJ8NZYRYoD6yXMD8?=
 =?us-ascii?Q?DnE/GMToP957EtBkblY//3N5UgSXiAPPt22o0uAIVtjuY+18s/E5SF5zQkmN?=
 =?us-ascii?Q?iWA2DqAsoVpm3f8d8+4JBfHDm4HtDx5/1RFNyYBjFqTnLw8kOIuXBPj+1p2b?=
 =?us-ascii?Q?q3fuSP43soDTZE0/qSlfxlC4agTAvX5/jyAhFhINprFDiiRxCGrgHX7lusmV?=
 =?us-ascii?Q?AxAtQX8wtKZUhgI+pXP1KoOOK+CrZ+IfLgEGIPNXhF7/AMAJcat5womMqkf6?=
 =?us-ascii?Q?FPztqsCYVfvq9fOgsJAW1hO81ESFsLOYPznigXdHq3QD1HVql7xCGuYf+o78?=
 =?us-ascii?Q?fkJLq3h19GSPFzXQfk04XjIBnPPwl/68sQ3VAYRievfKsXN0e62xPG39McS/?=
 =?us-ascii?Q?rVhUaTLaW6OyKbZseFFexY1bMfiY+56q6bkTS6iottYBukCt5MP645qOhXC6?=
 =?us-ascii?Q?GME/ZzsnbR/NPmxKgpdxoF9jeOOaO5iF0vAZerNiGYGuXvqgPJNLvBe4FQOL?=
 =?us-ascii?Q?ISOgq1RstYWicYv85D/5yxXpEHQouRHuDlZ21FnJWXlMLcR5sW/qbVMh+Ylk?=
 =?us-ascii?Q?0Z9hAbpe+jndQZo+EsDSc423mrLn/vVGOUaaUPaQE+Qdvi86duv+F0OcGSgW?=
 =?us-ascii?Q?oKt7tkrAPV8OYF2nbYuHlQEo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ca0ced-0ee5-484b-8f4c-08d95d379e2a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:30.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDEBfe5R8CZG/+UYoLcKqPNXdoGPxm2viwfJiJkdnPymvWBjxxqPUSPjQenwuH+9Ld64sVJQPtepPz/79XT6mut+o1EDALjWKm9vuYPGZ90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3960
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-GUID: ZnNq4OPLptfoVw2PvgWNLyHsTbmubt8K
X-Proofpoint-ORIG-GUID: ZnNq4OPLptfoVw2PvgWNLyHsTbmubt8K
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
---
 .../integrity/platform_certs/keyring_handler.c  | 17 ++++++++++++++++-
 .../integrity/platform_certs/keyring_handler.h  |  5 +++++
 security/integrity/platform_certs/load_uefi.c   |  4 ++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 5604bd57c990..b6daeb1e3de5 100644
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
+		if (IS_ENABLED(CONFIG_SECONDARY_TRUSTED_KEYRING) && trust_moklist())
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

