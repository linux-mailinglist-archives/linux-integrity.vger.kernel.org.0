Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2163440B9E9
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhINVQz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:16:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62266 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234885AbhINVQr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxjqP032082;
        Tue, 14 Sep 2021 21:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=gOtTkD9wTLJfVbRo4U2uC2+7hY4WwTWmc5PDwn0UAAs=;
 b=aELpaANRwBguyUVdmZdPXKvwvEQPGOJro25K+swA1BKlaGQqAswfxsfskEDosLHHgwWy
 c2zdGs+g6Z8Rp2jF6+rZLIJH/GYOmAFp3GLc5Q7eZyWwXGCdELJU0q4qTIpoyLAhXPO3
 aoGtTkoW+JmTwkE5IZ2SKqPo+LMDCXqQKGarlXRNDMPWaPSxdHfCrxIFIlvyzE9F9J8l
 nNf4EhUCC5rtMJ0flON+y7YXZCMCcoVvtsEPqIfCR2yTjS7o58cwc8phwISYaCYOrwne
 E/rDHvnBCopMhkyLXlnoB58TGxAtWkloF1ddPcwueJ8Feyb8R3bw1Tel3aga0dwulc8i Pg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=gOtTkD9wTLJfVbRo4U2uC2+7hY4WwTWmc5PDwn0UAAs=;
 b=0Z97l14TuriSPRIY7TP9c5shkm91v2DrI7GEfUtaA36E+UeFJVGvVoM4qiH66DHlMupj
 1T4Atadh68EtMJ46OX0NcmzAZ4QJYuA8Wk4rIgC+6fel8g+FtfpAqfAAJ4ROXc3mOFKk
 4rAGe78OsTzouF6J25st5FrmhyDpQLhD9nN/qb+6+Jntb2WDjiLSE5e9r+XVBarhurE7
 Rc5qXOSEBrbd3/9m8D7xHRzJLdXyPNqYGrNFEjoO5jjIQhRfh39EwEyng6pXXvrXbSIS
 Y0uvVyY4YKjylDwfyghIew2qjGBxHcs0859brMwLRuwGHrYp71wrpuVDE+GyY2RPxvQJ 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p3mk1d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:15:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELB9pK178830;
        Tue, 14 Sep 2021 21:15:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3030.oracle.com with ESMTP id 3b0hjvqwuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:15:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7KS8wRFTYjb+GXqhQhCsAnMs/Cd4vRUrAHCXQrczZEq2QynJ3BScw0zSxF8bjBKMuNPXKjq8SdSJpmzpixpgSMwmGR+CDDbPiN5LgNK4WCPe9jocSLKTzq1Dt/AL/ypTIj6FfpM0d0IIvxoa7EaxNmsqNlWLTez1/M6gntf9kBsKtzmxtvJcxT4C10FFZ9C/MLQ3DXBiw6RUE5kBntNzTlazTh07e8sVsunzaOgGpGVBQZjiDhIR6gxpb90xxD6PL4jO3+vxRvHKUyDxMdRsavvD0W2pOSMT4DUoa2YV7a7VGmsGuDjTS/WS6S8NL3UIz3egzp09lnWpNI6OJb51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gOtTkD9wTLJfVbRo4U2uC2+7hY4WwTWmc5PDwn0UAAs=;
 b=huIsIXiywOZjEnNbM7oXZpeTm+sFgPyISfMc0Yvhp2J3JRWx+qiRT+qaXhzUpNj4H27Fnhr0Jhv0Ag1c1+Fs32tl0bmfaxRaS3eFoXGMKj12DWCKExseo+37V2FKjoIamwdU4fYnMvSGhkltdrQ3m1/nakx+18u+2BhXYw9T5A73eMk7ZGUkSr678zF52DwjRnMEuE/yV6C5+joqFvLSlATEIgf11wD2Hbzu2Em7//SQc01UNlGeyU9SuH9ZA2jaWTmCyeZ50uvoMUQansGygjAlq3Isw/uh8tknMgew5YY0/XfBbczqBotZHtNyRy1Y5lyqvhdjt3FEgD3ad7sFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOtTkD9wTLJfVbRo4U2uC2+7hY4WwTWmc5PDwn0UAAs=;
 b=G/j+F9xGKe6qzGx6nzSuRiDoS7kc8K0AzEXGVwm/jyYBCyDg8JhECkI1t9raWSAOeMJ+iNeqdTVqZOzchYBGe+qvR9YO4Vv89eDjsE5hk+oDTetkecvOtAQp1/B62cSVutjr0LU3S+1qmC4WOhqa5n4PetGx96MnNcs0NOyyYko=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3784.namprd10.prod.outlook.com (2603:10b6:610:3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:15:08 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:15:08 +0000
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
Subject: [PATCH v6 12/13] integrity: Trust MOK keys if MokListTrustedRT found
Date:   Tue, 14 Sep 2021 17:14:15 -0400
Message-Id: <20210914211416.34096-13-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:15:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 112e6b4b-f532-4655-4233-08d977c4bad1
X-MS-TrafficTypeDiagnostic: CH2PR10MB3784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB378462E10316C5A4A0638BF587DA9@CH2PR10MB3784.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znj+MLRu7LGETSB2+KPT+Ug5rvWwWxi91hFSpXUOzBFLm+VhZYnhTcxMka9Y5HUWwgSpPoeY8fXTqqfQnyXGAGlZeAFPQlSEx+JD4x1iblzMUCvLHCt452xeZPm8IzW5xAo2ZAVVNMfrDG+LXYs/VGNBY3fnOA0xqc2rFDygKWD+FII+JfJ2TmjKbdIY/yHao8yoY8lpP4o3aFkmuoPgeDojDmknMSpe0kmY56atnkZkwXZuR0AbhLrM+PUmIHnsI11ZChvly4VpAU8Wyg4+/enCMx68jl7vgaELW6U1pP6zh5wfuJh974pkI0yPLy129zrjlOVlUIidmlMEKLeJsYeGA35pc9pDq8Tq3/8k5L015YUo9eqKNrKYWtTRne/+EBatxxeulWAUz+GFZdcXY4ssDUOOoBaw8d/VNJAqESwc9/1HamGb32TX/mhihyhfW/4cs+Ufa2yE/Sk5zleRP94J3EKHPDghm49V17NofWlULJQilB7J06sb2eBlDAej3n+vdq/UqC9DHJWNk7rr4jClG8/D51ps2nXcRpWEEImWKH3EQK6r5sDwSx5k47fc21yhF9+fMTu+u/ZVxAHoPyg+0AR2OvFmWDaxPOFNvKzL0preH6mVU8KltO0RkSVGN6crHgbEKu1ef+38SGXQ+vPQBpMkgfRJc8+mpS6BdrPuSTZZork0f9dMjBvDNLX1qU1ge5TFPnIkhuXt1M0qAe0XEjtQLkIZwKsoxxsnglg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(136003)(366004)(346002)(83380400001)(107886003)(4326008)(2906002)(2616005)(86362001)(6486002)(956004)(44832011)(6666004)(478600001)(36756003)(7696005)(52116002)(316002)(921005)(1076003)(66476007)(66946007)(7416002)(66556008)(26005)(186003)(8676002)(38350700002)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dP485k7DY14CE1zFJYvCGduJDh2bGNeTrOlSxhZ812VIBgoBUgYZQUqy+ihW?=
 =?us-ascii?Q?nD2YP7EPoLrJ4W1TBYGWZOvYsuyORYtFMgB+JIPb6LfzutGWjosx5X6XRgGF?=
 =?us-ascii?Q?0SBDDkHpIJXDxdS3ftOpNl0sPrLdOpl+HCgAm+Yiy9YpPwTqtkwSEj7agjee?=
 =?us-ascii?Q?CR9E0OTfIr6SasZ50k/1Vdg/3DlHkuP7EYag5Ecv6Ze40YuT109W/QeAnN5P?=
 =?us-ascii?Q?CghgWBRJ1EgW4l8QY1KHL3rVL/92Q/nUYF2uJPxHEs6+VyjCKqar4ZR3mVlB?=
 =?us-ascii?Q?QYwvHPCksHRS/4ixslAgKU2+omDiQXhXA63S3MKSBGUqXUOAgeNfr2Pj6EB4?=
 =?us-ascii?Q?H2y7gqhnq/BRAJ32hhtlxvvCeQBPEvUTkosDLy3lQIiHU2IXE8FeG0kn6qG/?=
 =?us-ascii?Q?OAk40xIaJjOTnQCQERxbB/SBSKm+gBJ63m5SDJlq2Xcc5Njtgua7TaTg7aA8?=
 =?us-ascii?Q?liWaWeKOYbvy1e9tJNyxXFnKiGnP5wmxaGejZVtQMikauSnJ7iWFTZZNtftO?=
 =?us-ascii?Q?wba/qMa0FoiGOfBClG8m5Xevc3ejbAa2IrI8GTa+VECqlM4/O4xiwj5Py67e?=
 =?us-ascii?Q?0nutoKE8oCD9xhxKZKsqODjpW9+REYMG5K3X5RNRaStTqvDtJ9pMczg677ga?=
 =?us-ascii?Q?He7KglweIWrEtG/6oQDKikG5/IcMFJjR2wgUQdHSrxkbGOMWOhHIE2HQrmbc?=
 =?us-ascii?Q?0DPxMoF8LZOn+kztukeDOjoMX6pcLXBXUw+iikdj7GrJdOn6Vzr2lDPeNrdB?=
 =?us-ascii?Q?qwFbxOOR7C3PQoajdCsp2A3koFevDxcAJmFZITZ22dn04XPbKYnu22y8G8Hh?=
 =?us-ascii?Q?V1Nr1fikICZth3cOvZD+IkoPauMud42Bblu5AWwcRq6UDu0xYIiJoRXkNFVl?=
 =?us-ascii?Q?msuM1gWg7hi3KJfBnjSiluPHIydgGrSlJtUf/ccX+wEkjUXtJjYY9cDeMDT+?=
 =?us-ascii?Q?mThJtAMfwFoZVhjqIR+Lxrj00x9cypOrmfWIuN5kWi7DhqcASxn2GBfuhHys?=
 =?us-ascii?Q?KY/vsGSS6kXp1UcIH/utj5cMeLYRUXP5dzw4Mc6nte6A/JuIqHHPnjEcEIV+?=
 =?us-ascii?Q?wt30nphK6a3xo586MQDz/t/zs65p/bSSb4LoOP+HnYX6ysfQSPZO0BG46lvK?=
 =?us-ascii?Q?GmIePBIkTOUfvRihuc3WrtqxR5lQZORtb0AXOwUC4k+15fAuukob3uCeKYmv?=
 =?us-ascii?Q?Wg2L2Eexg8oj7IO7JOUGt49E/sju/bX+fjVphGcLisGjeIfxZTJ8e6NAQ4Jr?=
 =?us-ascii?Q?PNWjlvtRrxKaQvsYs3e1QG0aGYyaQA1DH8Yoa7uiQBp/FMC+6tsws7FJL/fK?=
 =?us-ascii?Q?E5zIGjNX70uUIIz1N5+eMsmb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112e6b4b-f532-4655-4233-08d977c4bad1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:15:08.3457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEODi7/RCbP8Kjwxhm73jBEhxpGQ6UW9DFpF954ylBRRocyjxST7cJyWnspk3yvHjEPmqfpGX0i/Bi9WNsEr7I0ambMGrhI9OAS/xptlhpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3784
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-GUID: gPyJioanZBi6gbqlBlVfkNjt_SoC73Ff
X-Proofpoint-ORIG-GUID: gPyJioanZBi6gbqlBlVfkNjt_SoC73Ff
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A new Machine Owner Key (MOK) variable called MokListTrustedRT has been
introduced in shim. When this UEFI variable is set, it indicates the
end-user has made the decision themself that they wish to trust MOK keys
within the Linux trust boundary.  It is not an error if this variable
does not exist. If it does not exist, the MOK keys should not be trusted
within the kernel.

MOK variables are mirrored from Boot Services to Runtime Services.  When
shim sees the new MokTML BS variable, it will create a new variable
(before Exit Boot Services is called) called MokListTrustedRT without
EFI_VARIABLE_NON_VOLATILE set.  Following Exit Boot Services, UEFI
variables can only be set and created with SetVariable if both
EFI_VARIABLE_RUNTIME_ACCESS & EFI_VARIABLE_NON_VOLATILE are set.
Therefore, this can not be defeated by simply creating a
MokListTrustedRT variable from Linux, the existence of
EFI_VARIABLE_NON_VOLATILE will cause uefi_check_trust_machine_keys to
return false.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed mok_keyring_trust_setup function
v4: Unmodified from v2
v5: Rename to machine keyring
v6: Unmodified from v5
---
 .../platform_certs/machine_keyring.c          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index ea2ac2f9f2b5..68b8f2d449dc 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2021, Oracle and/or its affiliates.
  */
 
+#include <linux/efi.h>
 #include "../integrity.h"
 
 static __init int machine_keyring_init(void)
@@ -40,3 +41,29 @@ void __init add_to_machine_keyring(const char *source, const void *data, size_t
 	if (rc)
 		pr_info("Error adding keys to machine keyring %s\n", source);
 }
+
+/*
+ * Try to load the MokListTrustedRT UEFI variable to see if we should trust
+ * the mok keys within the kernel. It is not an error if this variable
+ * does not exist.  If it does not exist, mok keys should not be trusted
+ * within the machine keyring.
+ */
+static __init bool uefi_check_trust_mok_keys(void)
+{
+	efi_status_t status;
+	unsigned int mtrust = 0;
+	unsigned long size = sizeof(mtrust);
+	efi_guid_t guid = EFI_SHIM_LOCK_GUID;
+	u32 attr;
+
+	status = efi.get_variable(L"MokListTrustedRT", &guid, &attr, &size, &mtrust);
+
+	/*
+	 * The EFI_VARIABLE_NON_VOLATILE check is to verify MokListTrustedRT
+	 * was set thru shim mirrioring and not by a user from the host os.
+	 * According to the UEFI spec, once EBS is performed, SetVariable()
+	 * will succeed only when both EFI_VARIABLE_RUNTIME_ACCESS &
+	 * EFI_VARIABLE_NON_VOLATILE are set.
+	 */
+	return (status == EFI_SUCCESS && (!(attr & EFI_VARIABLE_NON_VOLATILE)));
+}
-- 
2.18.4

