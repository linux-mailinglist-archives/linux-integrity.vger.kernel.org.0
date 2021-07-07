Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385B33BE12B
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhGGCsL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:48:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64340 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230120AbhGGCr6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:58 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672a9Z7004644;
        Wed, 7 Jul 2021 02:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=VGxuXowtbQESZvPNXTxJtfyZD+1TLYu5wqxvVdsFu7o=;
 b=CysHKMbG+OKP/uSvJ9Y3nbENuYsk+4Rjps2ef6KvQL7k0BXRpTEtwim0zDu7VMui7uoi
 1cFxHx4mZrwheSb1c9Ik0uDVCfWxnRxxS5R6tnmqVoCEqdDfVROBiJ9toHmFDX3eBUzE
 zWaQec0RraMXUkZs7MWSdTnDTUmEDv3aPi4S0vauPC7kGeplRAw9o0dn+JhB6KU9DIJU
 ZgSkv2KrQ30OURnUct1AK7G61kHuyUMYBjMsZYqCKFrZdTTARXxjLcWDhmLXtSK3Nf9B
 87PPNYe9i0/t9C7Qoh1DfxD6SY6hqQaxxoD1WGUfYPZv2+2ja8f5GcV4Bf/Qu4M1tUBR 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m3mhb2un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672aUML070936;
        Wed, 7 Jul 2021 02:44:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 39k1nw7q2y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS6QV5D5Ff6OFsT6OUxIRzNRGdV6c/vTiL9e4H4dvmcwxWx/hRqfnf6OFIvp7l+7eTRhCB7KIwcrOslnZmWKK708VZofX9pQioMj41y6znbsz3XUXxYcI56bdYjBWF+2O3om+Wi0h35PcM6ErIlFOTelf1x2OIMDFG3Qy44H6iLiHZtEnJSraUhteWCSxUsPfMPYYxe37dyglSLLJxV2kl+R3EmNCtB42J46ZTfUq1jyV6YCjtv4vKnH1tx6WylO+zjRUyGvo45h23TnVSNuW5rJdz0g/KXMcgL6j/SA6zaG4kdCSBwpmQOACTUzORmhs/jz271exl2zgcEDZcBu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGxuXowtbQESZvPNXTxJtfyZD+1TLYu5wqxvVdsFu7o=;
 b=dPjfic8aYi/ftU3OYy6PEsTEVp74S25TYNttSQAOH0DJ7pQ9NtBGi6Xn3HqblUctwtrrREIyp+p6J/6T+Ih7PBKPMThRnNwrbT4TbB/ypnNA30BBmlohlxi/NauTULxe9wPSia3EMHUhtrp/01lrWGJ6uEHru/bkCd+sN7Dg5trOsYwJzdgvfLcu6WzSPlJ2mpk422CTJ0rNiguhZ/d2Yi439WRCyco+u2lsPr1VNRNyww39DXwXu6Wx6+VJc99g70WYE4gIVTrvegiWv1JGMZf6r2e9pfCRNoG3qgqXN/SJSwBFFlnrSzAws7IsfP9iuR/HFOtgQvgyWyAOx0kGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGxuXowtbQESZvPNXTxJtfyZD+1TLYu5wqxvVdsFu7o=;
 b=MOv66FxahqmC6wljsIOvo1YRscVzKekuVhWua6CYbx21IkxmrjjGTR/iRaRl6Lk7KORf+ZbuH4SgLR8koaO8qQUqObwDRKJOW7VgWDFBOV+qUiSywg7FTWluXwDz7x/2t/i659ccDY6c0qEZCmSC/11k4ZLc47GcrVxcegl6LN8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 02:44:45 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:45 +0000
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
Subject: [PATCH RFC 10/12] integrity: add new keyring handler
Date:   Tue,  6 Jul 2021 22:44:01 -0400
Message-Id: <20210707024403.1083977-11-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5451e1d-cfbc-427a-a243-08d940f12e13
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4166DBAB6DE516D40877B67F871A9@CH2PR10MB4166.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvePDKK00UtEGmnTRvSgl2dhrvG/A+xpY6LE85dV1ri1rd7zyu/P65jF0JfqFoa35zNCCCXJSpm7C+6UFB40x7eUBygRtSDEmMY1iaygGNp34vgbgrplTm7P+QUMF5DK6KGy+hjN6ia07X1eIQNpBvrBTFRPFNLYdA4s+I8XLXzfzod5VfrgD4p97tZ+5YB3V4jz/ZJhYj1H51dIaTPyge3pYKuAcfcVsgXAmKlQEdRabopbLmInvVktCGzjRl/WMtgtebs9fvQnprhdv/BiRvX2Ntk7Gkh7C/KNddy+jIfr87rXIZJvSNy92gS7te1zJnPiSSOG5rFrPxENClFShMHqeOsuq3htzV0KuCpg/l5WAWALJcbHnHJg3nIO+iKpreRnMEISDlw6iEVb0bHh1dTRn0roSMy4eerWJwid60vKZqWv0GizDeULsr3sKza7VmyJmjzg2bM7+DjHKS47RDaq1vTtRgakaTylgBMZFJSqN4yJCKvrcHchQhhj0zx/ZdLjoTVgLxW8tMWmfjz2MA5WwNdYy0Zfy6Mjl1zDWI9nUNkSufGVztaTyRGOMTvDbTPqrZAxTeaIbJCFaR9aUqtFFqGh/1TC5k0udW1H0nZ232KFx6VQW5aAJIKx/LSX/EhdvIhNUf1ifRuivoCR4ZKoMMM/eEnfMrLWnGTAmYoicMe26SoT8QjakB82T5m+bkWxFVx8nBtnSLHJXYJ4ZEzxEiAPt2xKtoyl6uCi8Xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(36756003)(7416002)(52116002)(2906002)(7696005)(4326008)(44832011)(38100700002)(83380400001)(86362001)(316002)(6486002)(38350700002)(186003)(921005)(6666004)(8936002)(956004)(66476007)(478600001)(66946007)(107886003)(66556008)(8676002)(26005)(5660300002)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?utrF0dK81WLeg2nmUlyRWe8h0Mp22PubRD4M1kAQWHnF2ds8mtafRIaim+xx?=
 =?us-ascii?Q?UEuAlSBqksBsUv6GNmYUGYbTDGksIAIGGp087iQdTiADvITfKCblOORvvWFV?=
 =?us-ascii?Q?FZ4OiFQGFuqqxBaT7hXW+FSuU5SWw2tM9z5KD04u/whd+z9vFjcxuDGN9bNF?=
 =?us-ascii?Q?rVZ4e2FSH09zMbwsp3fXpUuJMxgeLvC1XepYN92vWRS4eZgNvBD4BSzHH8F+?=
 =?us-ascii?Q?xwGQWXUbb1e7wERhV8AipEDCv/4qrS0Pm/CKLjqwdPFVzYOt//tu8FlgqOAI?=
 =?us-ascii?Q?aMFN0fUptq7kEOBI/dsNVM2zYJC9cg1BiPNZDEK8KuJH57zCFiFlX0cQYVkS?=
 =?us-ascii?Q?1VkxcFvhwL56SqlaL7IUMd8rVY6684AxcAd0+M6YDH/Ni3YOY1RNDFF6Lowq?=
 =?us-ascii?Q?4z432Q6lR+WKEFCvYXWO4fiSJlX0sP6AmmREHSxtwHGffsuTzgmgkJmLGCtO?=
 =?us-ascii?Q?LRt0WkZRSALc2Rgn5tjtZpcVhVY0pucCsFHd96RDIxhBl1pKZcyftlLcJpJQ?=
 =?us-ascii?Q?SK7FtiQGi2X8SgGX1imPaMYqdw/dYs+fTLL9GuMdJw4xTRLBZsTDkXDDCvEp?=
 =?us-ascii?Q?X84u1VkUi/98QBMw7Vq9UO3FLZSQ7GPbH1weijfSxCR9HhV6T/RkZuCjvjvK?=
 =?us-ascii?Q?t/tDFVWJjJz+vjcnAtx4BFnEN1c/itg4ZNT7b0gaXIgNm6Xr8+Ca8O7AvWd7?=
 =?us-ascii?Q?aBtTnstK3j+h443QAQOSUcWLFxOV7NYLeSaWXsFmddL2cPsr7qHPnpLvur8D?=
 =?us-ascii?Q?6DV96Rz+kHFp1WTTd8WZsak3rdwlm2F6pVckx89ay0bia/rZqcfZAS6DBpZE?=
 =?us-ascii?Q?hX7NuUVTzByTYNBZIC5bU+lVVXJRaldLCDkun65A4Jd7kFDiftVAHR+0PFwC?=
 =?us-ascii?Q?m0Sq7wq2myEava8GAO5lSdz/swjVzhmY35WexfYFIyXRfy7k4pHzG68PT3VG?=
 =?us-ascii?Q?Zu8NL/xTxH6WDnfy5RC5PaQRurCY3XhVmNKYmxNh1pQtWYxL9Te1TPcsQhHr?=
 =?us-ascii?Q?qPwPBxayUiVOti/gFH60D0mkduY8I42zjws63F4L5gXjZFyk7QNOK2Ip06JM?=
 =?us-ascii?Q?Ccfv0uORgBSNSriwVaWA17nYaNNSe0MAoA2sH1U5L7zs0OcWyWiBMSdA33yK?=
 =?us-ascii?Q?VXNYSO37xTqz/WpgDCe2Jrk0pWpKEUTpW4z6LJUlZzWKH4KRXsQPEQu21dN+?=
 =?us-ascii?Q?d/QRtr+dJSWFZqHUod9O+FDkJLphcorDqSEzW8ovlJeJ0P/h6p/e43ld9FG5?=
 =?us-ascii?Q?M97j9EZpLkgY5I2B+MmYC2ZdqdT+erLwtFgrlFpgcHf8sYZO/ohl6zSZUO52?=
 =?us-ascii?Q?PS+FWlGjJuE4RtrRkyULmQ1W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5451e1d-cfbc-427a-a243-08d940f12e13
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:45.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YmJfJivTlQyRImNkGRyepiz9OYtPr58vNN2gQ3yRFNVJr2+/dMnBiXzeAw46nCF+nxodHG7vjDGiCpDSe2a7KT3KDyJyzgEqxv8mAFBDjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070012
X-Proofpoint-GUID: KspeI3saG8Llww8fwGUJg2wr-jmO2a8H
X-Proofpoint-ORIG-GUID: KspeI3saG8Llww8fwGUJg2wr-jmO2a8H
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a new keyring handler for the mok keyring.  If the Secondary trusted
keyring is enabled and the end-user trusts the MOK keys, this new
keyring handler is used.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
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
index 94faa4b32441..f021dd81f080 100644
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

