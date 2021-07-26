Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370A53D6551
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhGZQei (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25816 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241043AbhGZQdz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:33:55 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHAhoa029721;
        Mon, 26 Jul 2021 17:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=YBc6uvaj8rzXN3T8X+MdC5O/paqVTYb2tSnKsOjb1+c=;
 b=HySsgwsAzuQGeU8wIJvojls6Flwy8dZbdbgb7azaYgw+TIrPkHfE6KyCUd8QNYDRtHSr
 /r1apJeGgiGbt743FEA/iCp5/f86MRPgWrzrZkhlJYLhdOPShLQOGduS24Am1swZ5sCz
 s3XTyU8gkgbSb+pNA1RYoXILsEHz65HwZrfbtwxefNKtSGwni7lulBwpCA/9Fmy1QaUK
 /wgAc73KGQMoPS7HgkKQr7T0qRGpdCV6eYfGc5OFObu5xVNBpfNBY3P2KzgwumlDycCQ
 wHaxaJaUkLJ2XEaxLSpsvhSHkEpd1pwwvJXgG3uUiiDKs4qeV9vIhUzQ8BRNq6QRuEpS CA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=YBc6uvaj8rzXN3T8X+MdC5O/paqVTYb2tSnKsOjb1+c=;
 b=sm2hPACZiV92uYZ9lAs6A6fHVfKqIDQM1JDbvxCbTuXrjMiipQTi6jv+kKl+Fxcjpzvm
 D7XAcyrlWSJetS9rVApdvKK+zMhGAeaJkqc4mNm+8ZzLQLgaMYQFqQj1Kj1a5jHqQuAI
 p7Tmlem+x5091gPXDT2Cgt5FqFZYeab3JgA5IewCM6ajzYCdkHq0GYiq2+qCtSwqqV9R
 hU2lft83eoL1qlaAV3sl7dtYxODCLdB6KB6Dw40WgJJd7hqCq4HBtwajA3QZYYUKz2c3
 BY/KgnHdoy9omFDgGLK8yiJA0O5FqeFxivJ/gel4S2sBfoebAnm7ifQwPseaL3Qfw6/i Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1cmb22mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHAifx005220;
        Mon, 26 Jul 2021 17:13:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3020.oracle.com with ESMTP id 3a0vmtcvm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFbEMfc6k6d427jowBlw/Nf1ByWCASEcU0H3BlWZOG8XXxgwpiQeir6KGttpFNBDgLByV49QYQCu3RH6aT6EyHo2l1VYZqUntvuRQvYlM01p+noAHBJYvpu5MtVvO7K+AxgEEbEa4AFBvQEoUWRuWzi1sW11JzD8L1PjpRqGFYGuV0+H45DM1o/Yl2lpYzRs6MqKjoh3MMIe20fFlZ36cB0LNqM7W6DzQaYi0/gdGqKSIJB4mbScvrUtr0sB/gtTpausP0MP7vG+i9pdzcUdWsKOs3HXQkr5vNAjQtq5LUmzTY+wWPVZnxylVv5gZnAxsFJb5gajTPO2YkKfK5802A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBc6uvaj8rzXN3T8X+MdC5O/paqVTYb2tSnKsOjb1+c=;
 b=jTKl4alXCaTgc8N4EdiX69XpOwWkZGeiKvgWqfXaGHlKLx6e5vDZDhNTGQBmAjos0xofjieUWuzDxTcKDzv6i2FY29vFq2n8DYHWH0tB+6IroKwk5oG0PCQadOuYByTpTE1Ut1T12xAW7BK9Dzpv6sPfI7ss94N17/KgKGjK0VH/oBqWSObtmYNkp8elttb+eGzhzT6t7TqgZfCEmHrMpehqA84h9yLrdf/3WQMPcZ+dWilwumc2h49dDsIG+5tGl9y5lhoG7S8pYm2MSj4rj2J7IowIC/c5gjxaMqHsoQKdC7/f16hodoXAte7I1pKGesN0urXSMgFoMTLoCALijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBc6uvaj8rzXN3T8X+MdC5O/paqVTYb2tSnKsOjb1+c=;
 b=AXR5O2MjnmmOlsjBRRDno+1sIDFK2yPpfwX/1YTdaFdaCGQbMSQxhrR8bQT5FpCmbmIjsi72IMF15mfOOUpSqXkiS3Tuuhrcogs9ksbCoINyACIc5wFge6XntczXOdH+Tpf160bmt1XNRSJUexQuevZZR6RLP+gX6Wm3CfFVtFc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:13:53 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:13:53 +0000
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
Subject: [PATCH RFC v2 07/12] integrity: add new keyring handler for mok keys
Date:   Mon, 26 Jul 2021 13:13:14 -0400
Message-Id: <20210726171319.3133879-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:13:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e30fc90-8b85-49c9-59fa-08d95058be96
X-MS-TrafficTypeDiagnostic: CH0PR10MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB521127884D86268D60DD3A7787E89@CH0PR10MB5211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4j2hE7J0NYJ2K7apruLJytgkUrE8raIkwgtgNkkJ3bdfTzENKa9MFOdXf+kjzx364qGg2VQJDaLDMUI4IqbnCt49lhO5hQEdjy/NU39lWZB7XUgf3WM88Ywz4vV+bpN9aq3/xdEpHW/eOkGKlgAf9s1Z561BUv9RpRfugjV0vD2FTY2gHu2b2H8iJ5D3MF6bUlLcjoMCEnAH+XTxdtCEs7NBIq6oGh60Wrq2//sCVSh/dKFW1OkI/l8cEt5VJsKmn6nRjB9PgH3vtPfZVJGepBT2S8qYgtxipTsvMW7qbho9nf4WqowdOORevpBHm7YDru7RNFNPUnisYcvV68+nExGuKmyDY/7tGzhJ3BYtAweMjbzFaVBpvp0GbNZJWROQk72kmz8VnvYf8VufdlW6eOfR414QFd/EuSRGw+4ynfl3mzXCg8O0d22h+BQTE21SffBJTZIO6vWC/nh8M6xQV7mGdltWphWCMmBNMWpHkK+VECeQvQDjm4YKMGUDYzGHfSuhHCQZ2Ohy+oRUqRcGuAs8ji4gIRfq+GYkHj1N4HKl3sWS753eKZez+bMyQsSiWsaYByraE9gZkfm9Xcdi+UCv71//ZmDTDiR8wYEIwjcQ2uP3DrWI5m1BNXjSslb7YbkBgck6S1x52Chv86MUkCS/IqBNTbtjDCv0ij7DQTrf2tbdEISsTPIcmL5+E0rJm1MuXVa8G8FwoijKP20V1LzocMVNr4YxKX8HuxQIst0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(1076003)(2616005)(7416002)(52116002)(7696005)(44832011)(478600001)(36756003)(66946007)(38100700002)(38350700002)(186003)(921005)(956004)(8936002)(2906002)(26005)(86362001)(8676002)(5660300002)(6666004)(4326008)(66556008)(66476007)(6486002)(83380400001)(316002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QilQWe5F8/DPAxGQSQkPNYrY2M2fVMGDInFHQQgltPPsdxh6NwYrdKF1DbjQ?=
 =?us-ascii?Q?aQNzQhQopAMaNsechQnmlr8xAqHdwnpP1sIxIKwXy0pGRRDnaljudXasu2gV?=
 =?us-ascii?Q?gQV/ZhJg/Wl5Ffc04R3uBVKuU4wBphVIc7CICVI8N/8pNRWx8Z9EWBRexMGv?=
 =?us-ascii?Q?y5HM/yBf6Iz+4YHzMzC4y2nVmQ1VNoPuD8Bn5BKm9XtWSrycxfAxnYqYYH5w?=
 =?us-ascii?Q?K7bbXcAWpEnh3fotTsK3HHPNeUyKBL8otjHDtFAXKpftLP5y7Kwyawrs4A6g?=
 =?us-ascii?Q?enk1x3hGMW2PTwFdzD/tf1wfSldgrSDvRVQuc2deknw4A5+p/gTWAcZVQSH4?=
 =?us-ascii?Q?B2ub0qyu3kXvsHFUoCNSzrnKHSHAhT4/lAn8G307CqYw+vuJfDcHuv8mmbAJ?=
 =?us-ascii?Q?NoDG1Wd7NcjA6lifQQO/ZH+qfLxv72ZSgOazIiaW1YsMMayv8PeF4MGq9iCV?=
 =?us-ascii?Q?Z79SXkidbmCNtYD62BMvS399T5mRNtD2dIYy+2l7+F4TJYo592DERVglduv7?=
 =?us-ascii?Q?bUEOPhW6Yzgvn6k6ud+RunoCKbXS+opo3juqfnig88BOoSyykJAoyF7vO7am?=
 =?us-ascii?Q?5BZQfMx/dBR8IcVwPkAb729zfbbK/VXBy+cELygj/jDtdcP+tQYieNbVY57u?=
 =?us-ascii?Q?wB6GVO5iZaNgxVfBVRsfnZb2OoVdXu6oC4gVJlq/pO2YvIyNBBVw+TS62H7T?=
 =?us-ascii?Q?nswIQe/GEkeRvxAE6yDocfI59ai8yRhMCsrlrkqG/SJHswFYwaRGM3Si2XJB?=
 =?us-ascii?Q?H7l+4xEWyNmd5k9tithz9BuBd038x7KYso5wgLNsWtgXIO85uwIlQOXgIHBf?=
 =?us-ascii?Q?y4ZesUZ6jt6lQ4S+vCqpEFYjDXJ145C0dlrAmfUC5KcL4kMGU6qnWag/cZ5D?=
 =?us-ascii?Q?fV3AsRLabaTLBS0JZ2Q18//0GPrjjThv9Ae9ASVP/uxKF6hVTnyTF+eSK4ph?=
 =?us-ascii?Q?yWwZtMtYZwfvoWbZGfStPLilPbZo56AyP4k0RxNrzI7Oy6Dwv7NCiu9nldrj?=
 =?us-ascii?Q?U/pPa+XHs+egpusHppPSvKCaB/wgc/Ju+V+Bk7Rll0liA0zGHvmvIljUr+UG?=
 =?us-ascii?Q?t89N/1kPqox+XhorHypa97EqfZVb/rofsnys0+9h6MXPxACwS8iSNTN5tKRR?=
 =?us-ascii?Q?lb6ro5iQ9o7eRHsEPmGJgvtlBnfEG2HeNRc5CgG+s+Stw5PViV0uc4ebR0Q5?=
 =?us-ascii?Q?oniL8f5V4J3RgVLUoDERWIkHxz08gUXvtHTD/O2hVm4P9i/b4Sl8ukBSXIjm?=
 =?us-ascii?Q?yPg37rMbD78zbyQ+zHCShdeQCREycaT006+MXu+xt3kSEisjSlj6v3YnkZIP?=
 =?us-ascii?Q?1OdB3ZypbhNa1pIRb55Zywsz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e30fc90-8b85-49c9-59fa-08d95058be96
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:13:53.6545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPvCF/w4WjrBnE3n1RktUtref3qQyClplXZmSu7/f4MMDhyDPnK6oPDeuNfmZqhTrazWV57LUYIAvF/6nh4MXht9BB25F8cSMfWNXcucCHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: ZesyQwlWtflNNC0QERFzXowfQqvnhLLv
X-Proofpoint-ORIG-GUID: ZesyQwlWtflNNC0QERFzXowfQqvnhLLv
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
v2: Unmodified from v1
---
 .../integrity/platform_certs/keyring_handler.c  | 17 ++++++++++++++++-
 .../integrity/platform_certs/keyring_handler.h  |  5 +++++
 security/integrity/platform_certs/load_uefi.c   |  4 ++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 5604bd57c990..1e15b65abc9f 100644
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
+		if (trust_moklist())
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

