Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EA3402CB7
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbhIGQPx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:15:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24942 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244135AbhIGQPw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:15:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187Ee9ob008807;
        Tue, 7 Sep 2021 16:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hMPUwoX0ykLZrhq7XURW+yr/hh4P3nN+bw++rJGsIwo=;
 b=ygegpuqDVyXsrrvBHWAhffmws4Ao64JyyU3zcI6Wvx5U4XlVP8DPg/Z8OREKr+lQnvag
 494fGLUVYLlLaCTNS9FlzwSaQ4IhVfq14rRi4iuNFIeSuIVSQPXbHw6gBzjJ8RdrHjht
 kASz8iJ3ltH0BfM61cTwb8UKJh+w/FRVvRSj/Db9pSQCtysnJUIRQxabe4tmk+yBfxnW
 0PIgci9NZ31CUpnYBVCyhqwdjbvO2p8D08ebu96ye46XTikYUZ6SAS6Yy+vBZBJBos+w
 scDP0ur14w5256EvMH8tut0E1lk7c6cl0cqcwovH6c0mEcme+Sr9Bm+PHArssh7IkEbl dg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=hMPUwoX0ykLZrhq7XURW+yr/hh4P3nN+bw++rJGsIwo=;
 b=ctlYJrc6JaolEztsdhBjkxIXGPHalTHhuQR9nNSvqOHqZoXarfnPKD0MnOBV0n+vOcQf
 jxYeRRShYfR5pKqWVRE6meruwn6wpmwzSZZhmoCdXV0zihxAfzCeQxHITSg/CKZbNjrc
 c0D+8f0JepfI2R7nCkxvnOGbNhIY84K5Puj2aIb9dl1Krvy3SXfsPzfJGPlb+plIpM0S
 SpiYKR9T8i+yKao6OZwNN54P2GxiJFH+g/b3DnW177269215vjzwHGfRKkYsD/fO5KwL
 roW4WKi0zYOE20CK74dyHZ2Lic0l4SBfQAyGLXvOuBbsKw84KLpaSgqOfZxbT4r/r7Lf 4A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awpwktnab-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:14:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G01j0185384;
        Tue, 7 Sep 2021 16:01:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by aserp3020.oracle.com with ESMTP id 3av0m4t5g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd5wP4DHaM6g8akmx5kP+NJmyR5+L8Kc7ACfpbdtp4kadJqRKfrVR9aRHZjQWtctx3PZiA2YXwnSXYcLMhQ36kFwuyvGqMbAckaIUjdTXCmAItOJxsoC9U4kYQYzwidpgMtnxJBoldw6m0ewuKB9bOAHDLTyfVNkzbbV+6qNTNSs6hHaa/kT2Bq/K6J4Yvu9SBusyQbJA3tuvE7j7PWA6t/evYybNziOA4ii6fnqvtva0y04/HPfZQL6ugxT8U4hn5hrvIvIXPcmKTGTiC7xkFRiOfbmXprgPfZFO1yRZJrZkJhEBHDdOzrmp+panZzLqMLgAsfTQJ5g1CwmK1Mzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hMPUwoX0ykLZrhq7XURW+yr/hh4P3nN+bw++rJGsIwo=;
 b=hbJViqlh8I64mWbe21qfOswia6DjrjGD9UsaCJIiSRldttey2lojiu8BotxH/rkG9fUpKZ4X7rxmv7dvAtt2BN44CcwsEXAndplr+qVQedAcsRFn+PtGfMNn41XHXD/Vm0tPg2PZ3Tl9VeVcoS2RNVQbAa6S/DCmak6JyKo/M4OI/uO9UY0vKj7H1r8FihJFxt+ZhdcqJVXCx9sTkZb6rJUmgg/paXcryAn3YukLlXAVpnYDsysF2KljJQ9cxkls+qruB+jOK+qdsm6INZonpRrhYpxyn8z6BTqqlQg0CmRrnCtHyE2XLQx6lfMp/NhS7at5oBQFvkAqt71GXJ324w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMPUwoX0ykLZrhq7XURW+yr/hh4P3nN+bw++rJGsIwo=;
 b=dQUoCt2wYgDbw6SnrURh/CbYwf6iw0kMO8BrUGL2WnR+jSfRggmUj736DTPryfJspb4fDdGrw7udw+8o52akDL6nJ05Xtnv3RMqy7FleRXuZlAFflX45NP0g7Eivyzm/ElcM2m2QeadSTWz4NSh6coUxaDNoLe0m1hAtVvX5ptg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Tue, 7 Sep
 2021 16:01:54 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:54 +0000
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
Subject: [PATCH v5 12/12] integrity: Only use machine keyring when uefi_check_trust_mok_keys is true
Date:   Tue,  7 Sep 2021 12:01:10 -0400
Message-Id: <20210907160110.2699645-13-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4ced778-c969-49d2-4437-08d97218d022
X-MS-TrafficTypeDiagnostic: CH2PR10MB4200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4200089D728CDD614C2E830F87D39@CH2PR10MB4200.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOJeZ67gDZJUJIcxCITImu6bIMBjS9C0Jx1oOvJwlvp4FPsWiu46AQTVlZbfN94/q7AjAbu8mAPMm3F7EJ7P2mFwBYwUAutLpEzo4MIKY+RgoaGZ9uoh7Xe+QOGO91Bf2ipS407JGIXHqQ8in91TtsH2vPI4W9fKIHrgtL5lMfa9tmlMpTbQlC71GLjNVaiu2IlfGpYogAPRUHkhr3LN45gphi0VYzvfhwo0tEGAxP288fz4f+0kboEucUlpEDaQYNLR6ApQAm7/DLrAXS9P1sJO46qfmFJLR7rKANCvz2drj8z8/O8zi20vqxIqtDNpZSobFLXhFvCEZ+Chf846Jn5P3+JHVxbH9Cfns1NmFLoPdZHuPTmVnW8WStMTRshOonbbyG/+3ZUkZniJRtApijALJnWokklwuIfgXOrq0Uu7lt/f89En63ApvSbd1EYnpx1xU4p27+wbNke/jjrf64kmINBeriMkApyciESG+hgQ8q4JyEcR6Dp0WSSy0UzE00SXlsB6WSCr9Wl+30c0DK/rxsRclVpfuIiwpGExQazOYsLp0B73xSTOs5pNP9PGuYpPlGNbA2pIx7KcDM6C1K7BjbVEqLD9QHyKwKpZbW1y7jV8F1cGTSXGBfAmpgMJ155MeExh2ZF3wNyJVwTV8BKeJjRtPKfwCF73lx96aZRrSvBDC61rT/SfIDzDsDfBKk2eariP9ZBmc6vhce+donVE5jDl0Ui3hoVRXWVhfiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(83380400001)(956004)(36756003)(4326008)(8936002)(7696005)(38350700002)(52116002)(38100700002)(8676002)(186003)(44832011)(6666004)(2616005)(86362001)(478600001)(66556008)(66946007)(316002)(7416002)(107886003)(66476007)(26005)(921005)(2906002)(5660300002)(6486002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MlIq1fDmGggITCZBVxqBpO4S+5/B9/PwfhZUwehi6dSt6KpcKDKOgsn2zxJm?=
 =?us-ascii?Q?t1EGlevGOCiFd6C+bmh/DZjp+BCSReRxi+yz/qjbau3dIANZ96o2eoSPyJNp?=
 =?us-ascii?Q?dPRIV2iFdg+HltAGTev4gIyRAJ2MlDB7XrUj6vKK65v71yo2VniDMtXj6ADX?=
 =?us-ascii?Q?O7WtqsMEo1DXdaRIxyN6atlvu+19iV7DfrNa3Ds2kyi3BHKcNexj+BGizp9f?=
 =?us-ascii?Q?2HUBuAmOdmhhveScQNpkp7s4c7d1IMjPeEovHZZ90aFB/7ltxwTSF1E5bx1b?=
 =?us-ascii?Q?Pit1WqgYt+ch5VyCsxgiU9tIj8rebZeS1Hm0Ye8kYdT8CprETAAKVkWMXQfA?=
 =?us-ascii?Q?JsNkKb8ox8asNiicSZs/iAnO7oh3rI8b0dXQYb99RJHA/wB0I5KL11dVlX6J?=
 =?us-ascii?Q?eLxmElcNeQyXB87xMGY2t+jacJG26i7l1+Z9tWeHL3LMGNnEYvgf6cV+WJJS?=
 =?us-ascii?Q?0TRkVa5ScqXgn5bRy3+zCD0BboZ0t2xDxG+kcQAJesPlyETMMpZ1VbXHLrtp?=
 =?us-ascii?Q?X0lTUlHmkffSF1AQnsFIsU49/A1k0+1iiVR4LbsRB7dmX+AEUm9rt588O+0K?=
 =?us-ascii?Q?O4SdS2RH5iKOWG+YBauRqED1Ax6LYwJ6hVIpApRIpjD3EmSyYHdB/WgK8Voi?=
 =?us-ascii?Q?QGnd2g094YZ3ACM7PINfXA5O7fm5I8OgzLFwDoGwuvveYP+KVYB6nRmUPh2T?=
 =?us-ascii?Q?PIn1dTVltGE/vh3vid+V9/LMnsv7ljJdUo3StdCg+iwEx5V7/5M7XKCg9fnO?=
 =?us-ascii?Q?djyo81/KDLPxkdLRFK20HHLe11oQ1WqhODM6Tzn//oIoTg7HlE2lHuHWTdo1?=
 =?us-ascii?Q?zw4VZpukJl3gvCNofdIb0aP37q4eBqu8gnxtgRdlnsmUZ55H7lCC6GSC8Zhy?=
 =?us-ascii?Q?qMIaE99aQkz16n8cbF/eJlha6d3i4wrH2/u1+ze6u9gYFXOpVElxHNZgOZVX?=
 =?us-ascii?Q?qCRIn3qPuX8YrEOW4MPBOs6Z7r87hZ0oM9XBTKwpsslz5r5YTOP6mmYyjV4V?=
 =?us-ascii?Q?tmudNI6QsqS0hlkCZMW2YrjknvAgIJm/sCfWKd/CP5JcnQsmB2cBILHko+Q8?=
 =?us-ascii?Q?020BolMOSOwa9RF1b7/S91MNcaqSQaZUM9IPdcIyfTCdZq0uoWTrqLApVUQv?=
 =?us-ascii?Q?APkK6htpTzeQB4y2P9DRD7JFXxEsBJHvySl5bH8JZQyizettaAj/k7PCMuUF?=
 =?us-ascii?Q?pcKg6Q7ADjqn70wWXCswetHWe8VT6qwy477TpJ6o9Lk5OZmyGOhrtxnhi0p5?=
 =?us-ascii?Q?zMtz23iSTKO8e7nOBG7t8Ft+knuI6PpqDJLHs4dskz+/VjJF35PHdQ7rXvo4?=
 =?us-ascii?Q?aVl53gUmZal3u+35pdaXDmIj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ced778-c969-49d2-4437-08d97218d022
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:54.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KSR5A1hg/j3tgHGkldykJVVGGw96gcDg3GEpcFCApid97B5t+Gd4S3PwNpVnXop8k0e40OUW+Zoq4kv2gxf3ulnWh2XDeyeN2wRY6k49Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4200
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070105
X-Proofpoint-GUID: vJo4onQKQjk1zU-yJwPC0Z0jcV0BSPyw
X-Proofpoint-ORIG-GUID: vJo4onQKQjk1zU-yJwPC0Z0jcV0BSPyw
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
---
 security/integrity/digsig.c                      |  2 +-
 security/integrity/integrity.h                   |  5 +++++
 .../integrity/platform_certs/keyring_handler.c   |  2 +-
 .../integrity/platform_certs/machine_keyring.c   | 16 ++++++++++++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 0dce2775f3c2..d495c4e49240 100644
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
index 635ab2b9e289..eaef1efdb261 100644
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

