Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4ED40B9ED
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhINVQ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:16:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4474 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234989AbhINVQv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxjqR032082;
        Tue, 14 Sep 2021 21:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=IzlyzUN0VKQWEn2KJDwO+ww1xVfp+yJZPwUWf8ijzFM=;
 b=pKQSS3FEUr4HAh1gWPqC618Bq5UD8yDCMVVzsvpWLes8RhF9I1L3eSp5DZApKXcUaHS9
 x3Cy9wmxVNIn3Awrl7okHgLRpbvMfL3ofS6/uIUpWUsO5xkmjt40EuHsVk6bqMES9fAO
 khOXRlRxXZOgyCQIzgQ8WYA5DGxRmh0CpSzJX2LeioeKa34EOq5cj1gEZBhhX8dw8GeM
 toEk6nu61iYW2n46fTmRWPJ3++jyfQCVPsYkPUv+s6TbGApudEqp5YZPJzbwCluIUojt
 qhlqJJLcM6KcgfhVe39aq8pgeKFa1k6wH8HvTIH/dXhmDOXsFgdK2fHtNEBaYNYobHv9 eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=IzlyzUN0VKQWEn2KJDwO+ww1xVfp+yJZPwUWf8ijzFM=;
 b=KyraUoNlDNlqeotg2S+Iq9uhj6t4nMq4hPpd1djEH7Z+D5WvZNMsdkJIW/wuN4uY3+UW
 rgCIHLGTl/s5UFUOKjs7nibuy1+StoawhneNHBgDBpsm2+0vlJ7QxfsN5QzoyayDNXtB
 C5mYpnzjvdH6T+Es6wzlzY85QCVaS7VcPno2UR87V5CZPEK5QOrE1905rEGdootw96vI
 9gc3EFdLLf2JUptOarX7ZbQjxCaG3zxR7LeUd22ShrzOlnP0SCtOpoRib0goo1HTWwDo
 0QFGbB4ATFNL2ZV2U1o3fWly9D0IFBMJMDN9G47hLZyKUPGRDA2idQB91H4heKsikGum 5A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p3mk1df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:15:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELBADK178849;
        Tue, 14 Sep 2021 21:15:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3030.oracle.com with ESMTP id 3b0hjvqwx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:15:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WV4YfIw6xH8lFeqEOwxRFqK5zul8/LaveFAV6+NBetv+1Qz2RIfcp/3csZ+BFCoK2Dkxvl8gPkjkoJT0VVJTkLgkdUu3Gt0QfvPu1iqX243RjOg52q4mqr31RygApzETzB9gmaJJAS8x5DYtDXCA1DaX8sWQ10PDGT/BtzGe+EloYrwEZb8opOiFx3oH06jzTHuLegX/CZMSCJP7VEGGQ0F38pzS0TbDhOWoAaBMPv6kbb2TFKFP+jJM2N7cnz+GvaROBLWDfZY+OpEZU9lxJw/OBAD4mCOHgDxjqBQL6IySjPvRhuWsbclBZ1NjF7z2pQjbsFXWMlVqhJLyPKYV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IzlyzUN0VKQWEn2KJDwO+ww1xVfp+yJZPwUWf8ijzFM=;
 b=VZ7/PYny+iwZ7YeIZ7rrPzpLu+T/Uw1aQWXMM7sj6JEa1OQo0pYvpQDDJ5Mk5AiCsxVhAvlX9DzpmP4zhBlpeKwYHZUt1KCb0lcVWiFe5uyr2XRiGH5Cw0/uLfiMrvveVQqqAen+qf3/Qd1aGgPobscMnqILy2ydhUiSUN0/SnIUYxf5plzi5XJ2e0K8YTFpuH4uY+fN0EKjNGWCilBjinpizrTQcivHSYyKBsK+K8VeSUAXQYlzwWCT9hJscWaFplaaTIr2k2YqpjzkixCI5YDJRgQjgQPaQB0DCqdJvURA3KM9XwOthQO3lJyMEydkSyJieo2f4ZqzDrQRktZBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzlyzUN0VKQWEn2KJDwO+ww1xVfp+yJZPwUWf8ijzFM=;
 b=srQ/Lg+gTabE8geFZSde6mT4hDq2sTq1ivDx6ediOTXFizrW134/V3cIrWlQ4tgEo4rHFiULo2nFhussXXMU2cAOi8/K3Qok7FEvdRoD4gkrY7LBSKyRug8LmBaFCw3LsXyLwUktTqokuxx7OB1j8WZ9c6TvrqllaBPGQfp/Anc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 21:15:11 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:15:11 +0000
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
Subject: [PATCH v6 13/13] integrity: Only use machine keyring when uefi_check_trust_mok_keys is true
Date:   Tue, 14 Sep 2021 17:14:16 -0400
Message-Id: <20210914211416.34096-14-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:15:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f57700b-8929-4748-14c6-08d977c4bc76
X-MS-TrafficTypeDiagnostic: CH0PR10MB5036:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5036B15BB2D1B83A00A5088487DA9@CH0PR10MB5036.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogtXgSg9hsJa3+jBiE+p30QQ79L8I4C2fcR4wERQ3ujOhGBlcbG3DbIc4pN0/qvasShLMQv1eP3ZyzKAyh3gusEGyYezrvCNI4OuqbMvi1I5HUyRtYZ9BO76KHsPWY7EFNrS6d6MwUZkXJgx8jTNhRCEmQdzC4+P3AQ63eygBaqMIRQSIRxoQoRFGbBSwhz/MI5Auuy1FAVHFA89Ajk3FmrBHiJHPWM51xbPtaS2eGxWrzQtMnaUDMb0Ep9J/Ndz6GQ+H7tAEjL0O2UABQKCLJDU2hje3Nq6RD5dGC0W8ZMRbejGr4sU5gEY7YuNDIJpI6Rn85C20+TYQxad8a7jqHp4XDQSGK3PI76W2aAuQiWtPEjPjzyh2C6ihlKfi5V5ZlfWIJXlcmLBAmGkhTOm/5hvXMmG0aD9+ieTikT6m2FFT7fvi/m7q4sq/JzNfWHHDIG85K9uZqExg2XpdKIVoCcr3tLqma/Mhi7UHuTpI+WRTu+2EbuBYyE/p7rGk5kf9VNF0vUGjCGgGAcQD1edyCxlACt5GPzS0Dd4vsHofSZD+eR+PvpuF6X625opBTECHeolyDCo9lTgaIK1mRf6uy4dalHJlmKhlgcfbwNiaKQbjdn9sXmCmTaiPVZbXeckjmcaSfNZZLeyxTUCuHkOaWyDwvXsY6Iiybe+WJIP/7gwZAwBYxzB93eJp6qL7dNqbxefhFO5MOqzF8sRoF78L63aMR3AAPoM2KuMZpTbfEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(376002)(346002)(4326008)(2906002)(38100700002)(107886003)(1076003)(66946007)(7696005)(316002)(26005)(956004)(36756003)(44832011)(7416002)(38350700002)(186003)(8936002)(83380400001)(8676002)(66556008)(66476007)(52116002)(6666004)(478600001)(6486002)(5660300002)(921005)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GwJjTB8EHo5L61MUKNmzY6CXcQDP6Z2QkF7MS4ZuiCfUWZDFffno+xHEJCJ2?=
 =?us-ascii?Q?UY5qexfswd2BhyUF+vb02B32X1EKHKoA2MU+Kd01tylgSjGMmFLbv/tU7xiR?=
 =?us-ascii?Q?euvQUlxtLFMRLRs4qF9uOILJvGqTjBFwwadTV/fQA4UlDsNdt5BCtyXvZ490?=
 =?us-ascii?Q?eJ1rbu69mjRtjM57ym7iKqWIoT+vJaoJhobALwfDkASu9TAQcFP86dEfnjiR?=
 =?us-ascii?Q?2RiQK4mTVkMQI2MqBqPV2R75tZqzBKBKVpF0zj3VCkuETrSUN7Lm9MFwlRl9?=
 =?us-ascii?Q?O3YJMEW8yaf3Od/uXViSad2Y6H48cKV6UxXpoEo/gSv23SWsivsxC6xSzpoL?=
 =?us-ascii?Q?S41np09InIWka5n/y3x5Xjq5fXTG7bu47wjJI+gH4wRN8geYvURZOex1u2D/?=
 =?us-ascii?Q?r/ABPoGpfqltjvc54nG0Jj8WRPpx/TPcH7HYHX37j/wQOolWUjhiEl3bApmU?=
 =?us-ascii?Q?TyDr0mcxxFG2c4yU3pXz19DW7XTdFnbvr5YdUy4HdYjlYca+/uLe7hyZhqmw?=
 =?us-ascii?Q?H0/n8+nNwX90o1TOnBQrQ17N78PGkXBai2SyFxHD3o2WO0bLfeQy9OuWXwtf?=
 =?us-ascii?Q?Zoko6BljFk4uZsrTm6k1m5EPFzC7vgktKnPEnqNhffDhvXbu0jwrlnUHOWoV?=
 =?us-ascii?Q?Zi7yqIgLCYpdpqxm074LeDhL/Qqm2jXzSaU3eey/hkophr18kPbogfSuJTAH?=
 =?us-ascii?Q?Rqa7aNhKG45iy5te5xt7tgO4+Oe2z2+2IEhpTSLWQkjODYoDQz0UyW+RmNYE?=
 =?us-ascii?Q?bgJ9gyDPuFuDHVYpZCFQFCvzAWQs96iaGSlGZ48ZXrM3SzG1L5AJN6b0Q8w3?=
 =?us-ascii?Q?2anoZ+R2SZ3JeAZMO+jQ3rSnIviRDzHhLPSqXWQKd+cBZE5HdWRc7Ih9S3+6?=
 =?us-ascii?Q?BB83gu235RV9Vi847GGsXXEzJ3Ebr9gIqov/2xUsZ/cWOWfF4oionUnAeBAw?=
 =?us-ascii?Q?tJRgJX7nY1nhVXPTSAHKzjvPlHGqak66IdX1XjQC+OOCcOtR19DRYBpEq7au?=
 =?us-ascii?Q?UZyDCYnIRTnAMgUQ8v5wLT/u8V3GxPp0VccEPncn0a9AW49/CeefQ4bpCQn/?=
 =?us-ascii?Q?6dzuf3ZegRsGQth4UMAB/tQfHTF5fhTtYC3g21kfSVTl9usTnls/N6ujaJpW?=
 =?us-ascii?Q?cgWPzcNdvWsSVBp8/r8TLkkaU2efooNWvafuTEs047oaeySvv5bLtGVGNEW+?=
 =?us-ascii?Q?pTCLzh3BQldGQlzmuSNbgQwnx9BWVUazh+r4GxhZXe3eifek+RsL5bijrSmu?=
 =?us-ascii?Q?7a8UGwQZ+vM4JZkGWUIBf0JeOQo6Z1H4UnrMzDvEQfymL4RiH3DfI6o8abXF?=
 =?us-ascii?Q?sRwGiZv1i/VVU9PCrgZsMl9p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f57700b-8929-4748-14c6-08d977c4bc76
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:15:11.0787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTbq3SYesvWwD0JFpUUf3Ih2tHLS7AOrk8n4d814xMRO9W0u0x2jIcmSWAolrq4Nn7vBNuhxFoS2iq344ov3vSUfa2KTEfW9HvQltxDe3iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-GUID: mxss-Hrd7icsoAFFQCOAAKKTZz_8gDRu
X-Proofpoint-ORIG-GUID: mxss-Hrd7icsoAFFQCOAAKKTZz_8gDRu
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the introduction of uefi_check_trust_mok_keys, it signifies the end-
user wants to trust the machine keyring as trusted keys.  If they have
chosen to trust the machine keyring, load the qualifying keys into it
during boot, then link it to the secondary keyring .  If the user has not
chosen to trust the machine keyring, it will be empty and not linked to
the secondary keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v4: Initial version
v5: Rename to machine keyring
v6: Unmodified from v5
---
 security/integrity/digsig.c                      |  2 +-
 security/integrity/integrity.h                   |  5 +++++
 .../integrity/platform_certs/keyring_handler.c   |  2 +-
 .../integrity/platform_certs/machine_keyring.c   | 16 ++++++++++++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 109b58840d45..1de09c7b5f93 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -116,7 +116,7 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
-		if (id == INTEGRITY_KEYRING_MACHINE)
+		if (id == INTEGRITY_KEYRING_MACHINE && trust_moklist())
 			set_machine_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 730771eececd..2e214c761158 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -287,9 +287,14 @@ static inline void __init add_to_platform_keyring(const char *source,
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
 void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
+bool __init trust_moklist(void);
 #else
 static inline void __init add_to_machine_keyring(const char *source,
 						  const void *data, size_t len)
 {
 }
+static inline bool __init trust_moklist(void)
+{
+	return false;
+}
 #endif
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 445d413aec74..d78dd66fb048 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -82,7 +82,7 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
 __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
 {
 	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
-		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
+		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && trust_moklist())
 			return add_to_machine_keyring;
 		else
 			return add_to_platform_keyring;
diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index 68b8f2d449dc..7b413dacade8 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -8,6 +8,8 @@
 #include <linux/efi.h>
 #include "../integrity.h"
 
+bool trust_mok;
+
 static __init int machine_keyring_init(void)
 {
 	int rc;
@@ -67,3 +69,17 @@ static __init bool uefi_check_trust_mok_keys(void)
 	 */
 	return (status == EFI_SUCCESS && (!(attr & EFI_VARIABLE_NON_VOLATILE)));
 }
+
+bool __init trust_moklist(void)
+{
+	static bool initialized;
+
+	if (!initialized) {
+		initialized = true;
+
+		if (uefi_check_trust_mok_keys())
+			trust_mok = true;
+	}
+
+	return trust_mok;
+}
-- 
2.18.4

