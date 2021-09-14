Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4134C40B9CB
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhINVQf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:16:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52882 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230332AbhINVQd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxRgk007081;
        Tue, 14 Sep 2021 21:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Qe5VXpKX0s9y9o6FNvA7liSiyZSTkEmNO2QX5ulgJBo=;
 b=tTO8l7jVoVBALqoEipLYDCfSsvqNplke21yn3YMKfZiDZosiAvepv6jKoCQY4gQDXzRn
 nTKElhq+mOD30l6y6KgE7aR3kSGytqetCC/I5LfdSbivqXy4RFM6m8fionT0b6Lp+SKH
 F/Ttn08/3DPjuPqIXpo/HaagfopdadXE9Dqhj+9IxF4ZpFkvoNoGfwigLu5nGpl/TfDB
 XESeUr7yocYNGQNa54KPU0fiiuf7YaxQxnZAZCKKJYLbKZRRuApU+xdwMu5rsQCdRqxD
 PrxVOcKci9+i2PSRSb4z7l1tMGdfm+MWT1E0nJRw0PkxafVbWAACsPrGniYz11zeOQW6 +Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Qe5VXpKX0s9y9o6FNvA7liSiyZSTkEmNO2QX5ulgJBo=;
 b=CuUWhABZaB6yuZPtB7pqRMIBJMoUovZIiZrQzTJLYkAGmfblIsQ81UZ9JGADYedKH6fb
 FxA+1nVlPZ9UQWW3sKfdHCKZrRIDuuws9o0xiWLXxHvMi7GM1PPDxEruPGq7S7ktdoCQ
 hjvvkBh2u0E5taxI+/EBKBQAaF5zAwjljKWrF5yKmDV96oGq/xxvvdv/QJgABdz9Ty8c
 ItcI+mNJ7Z4Ml/4zuHVLtt21MGaGzQ2efczdVNQFrZBvV3EcLdXR4ImsqSx03uwTlNuX
 dZO1k8CGJ4qmS61BhFE1xfR5Gij8UEJfuTTgQlE1zE8PzxRpHH4Ry4ZQ1mK6WSYQpZQy yA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p4f2xkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELBAmx178895;
        Tue, 14 Sep 2021 21:14:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3b0hjvqw8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jagjCNZDSwoExtMwCVDgzkqXKkRaxJGiIfmG05gsUNqrI1JdxyIryEsMyVso88btkOaHMQdiuCrbUyExtvy2/zjjSnQIVzNrbxOqnheo6JBuEu9pqX3yzxuuvm30cZe/ePzmtMc2cvTDZLOIXmbKPD/iXoh2cXUA8hIECMuyU9vsq9lPNgq4IbegBK3wFLE+F8PMFTQrrNIsV4cqMpjKLM0H3II4VipwEOmMfD4kKcPJJnrdl80C2J3O42vIhlW6SKPOpnsv+UXUlSz2ibkTuVbkHJbRwwLy2XKWgPJz5LpSjBy1aarwFkd8wwAyIjUo2Pg2YqTpHivPO5V9ZHpxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Qe5VXpKX0s9y9o6FNvA7liSiyZSTkEmNO2QX5ulgJBo=;
 b=Vr67U9m+hCalRtrQmIuHK/g9nTpD687gWM19ZYMeWamxpX/b4cSIGKWwmPn1dDCBiEMhv61duE0CeQUdf0BCPG15gLV8zYJ9N5c+O8xC7Tcoghi/4J1DvaS4lRhD3pJq3MhT8L3+wr+wm606eZBtSLLWr2oLIDvWlBNNHV9Zd3uZx2cnnUE9ZbobyWpZKRk5XpPE52HqviXXPBCOO9BXmw0KBawoEncyBgu2O8nUv7iGXoS8AR5dAMq3GAsNkV0pWK0K2zmsJFoPWe3Mmxgrqhnzswg6kEV7LiqOs6mpvntM6Ix8p9mXkkUfsxvo39w/4FE0oASpE3qsU5xJYZ+dmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe5VXpKX0s9y9o6FNvA7liSiyZSTkEmNO2QX5ulgJBo=;
 b=kB8K1opzWFtcVf2MtrP+wyLOYONQbmF/pdsdMOUeOjERYA2UURVm/f0aDfrxnl5CO6hP+iuLWNUzl8YJSDkxm/hD3VXj5+rGvMMenI+TvebjDVLUIavTPXmu5yvWfDYTzarURg7I9WyBVrP3jHrg+KE67oBXPVcl49aGnYDV97E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:14:38 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:14:38 +0000
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
Subject: [PATCH v6 01/13] integrity: Introduce a Linux keyring called machine
Date:   Tue, 14 Sep 2021 17:14:04 -0400
Message-Id: <20210914211416.34096-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:14:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad60cbb1-75d4-4b50-d0be-08d977c4a8b0
X-MS-TrafficTypeDiagnostic: CH0PR10MB4908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4908B74C6826492D7AED809287DA9@CH0PR10MB4908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7GWLk2IuvneOmVAwhKy5hf3Cxnx3N5yiodAZO5zageYrSRtUBYuJNKqMuHMuc3w0gwkLfNc3KdzKnfZn8j8h8PjxUGbuvkcQoMuwf56plTfM2kpJ9sriwsY3WpS+DS50ckVrBDgeoCizYlM00ui8ZuuQXFV84l5dF6FnV49N0oKf9d29q1NOU3t9z3LV/0snr7EUeM73q74JXHijtRI82KS914wpZHqYNpOECvPUAXE5++1288T+6997XnfnZg4EJ2xfDK3Frr2PoeqwKAufh/zk7V/xMf5AIHySGEBmDGLhmA70Xuyfo6T83LOToAJZtwRv2SNAObiF0nwfjVWWQ2u1Q8K101pSxSchJ8s2Dd1sGByzVHv38WmGlY+8aTKUBp0iBQFFmN6FhOvZ8oargESsfcHIT7lY6EH/CG0/CjFkQfYycTdw4xnoy7ThSNVP5v3jVkheDJ2Oq5luoQE9cc2LUIjX+iTeWg+1TNNkKfruY5QMzR+GcnUr9uP4qifRsIgAGMJ9+0EjT/0tn1m+RHDmGK5pAkktMCEGhL//eRhltYv4ZGQm1dN8Nw4p78RH87iWJdFLkmDyj/NHX72Xw+uWMgsNLr2M+G2pru/BF9PzGXjCIzbYdxAhDiiNt/8Dhi0FE9yVNXvPr9nWiidFZjyt5+yc9XsGyySCP1l8n431dZjP7VSibZLUqx3TAmc4/KWEJZNV3dksScwbWbeqWUSkgWUcpuVD2Jld3sQsUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6486002)(4326008)(6666004)(2906002)(44832011)(7416002)(36756003)(66556008)(2616005)(8936002)(66946007)(52116002)(921005)(956004)(478600001)(86362001)(38100700002)(107886003)(38350700002)(26005)(83380400001)(1076003)(8676002)(66476007)(7696005)(5660300002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gM3yJwImSIDVorBydJKA8/VHJvyJ2pYmnKnheDUuqBAb8kbEDgL1SXnG1bdX?=
 =?us-ascii?Q?NXJBS90xI1QWauFsILPIE3zvlVl7ysPdkhQBegNkrxPURpCShZ2gEVm9eSDv?=
 =?us-ascii?Q?p1K1syoli/O98ckuexztxvQ2IDc+R/kuMGSt/mENs5nEO9fUPnkueVI1niSR?=
 =?us-ascii?Q?sDd836pqqhpARH3udd3654AWCl9c4Z9moRfmuLm/lLBMH9sHxR2W/TxZHjqt?=
 =?us-ascii?Q?NqGxo+cOfxddNM1VCc1m0JV7dL68eWaw7v/tZXg/+3JRjEngopDc7sCDI1rO?=
 =?us-ascii?Q?jRF+RFjgPeRuJFR3602lwFo7wuvVT53matK/B0QaHXcARdh6mWFOp2wHosIk?=
 =?us-ascii?Q?dfEpz9u8vsWArhTUpJ+rUfgw9LmTlvSWoM2XXHkCfQ3isrB6GcZ9/5mreu5L?=
 =?us-ascii?Q?Uw74TZH2gFGDLD6gPz3ejPlV3D/bnti+ZEd1AIUnCntvzfrr/WW7nSHZuFQi?=
 =?us-ascii?Q?K7lR/oJvduQeqKLC0g6k2x2geIuyamK2aedjsPHJoHJRI04EqgjzHyyW++ki?=
 =?us-ascii?Q?aKGGbcWkMI66md5iaHa6bXV70TDpo1RvJp9xbKJZUFNef9ktvSntSe/e7JnE?=
 =?us-ascii?Q?3/qABmYAA6e9hyBqlSr3PqBVyIu3ZBFzHwwyZAuzdYvMquTKSUQPSPSDB/Xa?=
 =?us-ascii?Q?bCQxhcUPXcoXFwx8vFhXQeZoHKUGae4lKQCUN1Yaaou9ROHeGCuPThASn7a5?=
 =?us-ascii?Q?f8aHIOBwSwmqgtom4Wy43XVu/Pievueg8zkIZVe3BKtNnuJfqUDXq7Qf7uar?=
 =?us-ascii?Q?ucgLOtaWbMJTK0D07q11o2N1AYKfojG/9smv+x/RstEeJrmIYTvvMolWlEDR?=
 =?us-ascii?Q?/JhP+cT90854H4qUrlBIB16vPWYBSmL43e8IWb/xGPEQUA7x+XiZxrRrxTPt?=
 =?us-ascii?Q?U45rx+qzkoy1yV8k7knidAuWdd21qZFBUyovJv9Wp/GeVeFbn19DrpDIA352?=
 =?us-ascii?Q?2h/ZeVy+D8HESkGuKXeeY6jOTzWXwg5KU3Bz1ZJQAwMeEXpftNUWnbfgjIpf?=
 =?us-ascii?Q?NfKJkHl21AkK7lxf6xWmu5cc28atJz4/byV05ZdzPZkCvKUG6rAfZs701GU/?=
 =?us-ascii?Q?iSuiCSx7QgB79dfVJ7YUd8dUKfQbDnl3HVCO0ZE40WKp+jtofNSKaBPEpNfV?=
 =?us-ascii?Q?bjrrIWe9XtbfJYHiv+HW6TYsoewD8Uzt2jkCg/EBZKVxf8eMb+f4V10PHWMV?=
 =?us-ascii?Q?AmVmy2xSgDzWdqxVqmfank65kyQye1k1Og0Iv9O1y1AF6FFEHxth/oco1UMI?=
 =?us-ascii?Q?mrGTJLJLGdPficGPoKLbcrLhYXZGGuRGC4zeAi8LNKNk0Q4YI0zQ+7PnAztB?=
 =?us-ascii?Q?iI990dBWu0iwAZNPD1BrzvYo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad60cbb1-75d4-4b50-d0be-08d977c4a8b0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:14:37.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctEteMhs4v94HMVV6mSmHRgbAs3RzP2Z3HTfEFTp/Rm5mTAk5a+rE89ihEiUVMBbpjbUJbIeNjU6zywsG4ssDDvamXEsuGJnq0fWiy6bGLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-GUID: AfUcMEhIt3DEIPt74CkaEwLn9ZgAAHeN
X-Proofpoint-ORIG-GUID: AfUcMEhIt3DEIPt74CkaEwLn9ZgAAHeN
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Many UEFI Linux distributions boot using shim.  The UEFI shim provides
what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
Boot DB and MOK keys to validate the next step in the boot chain.  The
MOK facility can be used to import user generated keys.  These keys can
be used to sign an end-users development kernel build.  When Linux
boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
.platform keyring.

Define a new Linux keyring called machine.  This keyring shall contain just
MOK CA keys and not the remaining keys in the platform keyring. This new
machine keyring will be used in follow on patches.  Unlike keys in the
platform keyring, keys contained in the machine keyring will be trusted
within the kernel if the end-user has chosen to do so.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed destory keyring code
v3: Unmodified from v2
v4: Add Kconfig, merged in "integrity: add add_to_mok_keyring" 
v5: Rename to machine keyring
v6: Depend on EFI in kconfig  (suggested by Mimi)
    Test to see if ".platform" keyring is configured in
      add_to_machine_keyring (suggested by Mimi)
---
 security/integrity/Kconfig                    | 12 ++++++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   |  1 +
 security/integrity/integrity.h                | 12 +++++-
 .../platform_certs/machine_keyring.c          | 42 +++++++++++++++++++
 5 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/platform_certs/machine_keyring.c

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 71f0177e8716..5e9b3de46900 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -62,6 +62,18 @@ config INTEGRITY_PLATFORM_KEYRING
          provided by the platform for verifying the kexec'ed kerned image
          and, possibly, the initramfs signature.
 
+config INTEGRITY_MACHINE_KEYRING
+	bool "Provide a keyring to which CA Machine Owner Keys may be added"
+	depends on SECONDARY_TRUSTED_KEYRING
+	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on SYSTEM_BLACKLIST_KEYRING
+	depends on EFI
+	help
+	 If set, provide a keyring to which CA Machine Owner Keys (MOK) may
+	 be added. This keyring shall contain just CA MOK keys.  Unlike keys
+	 in the platform keyring, keys contained in the .machine keyring will
+	 be trusted within the kernel.
+
 config LOAD_UEFI_KEYS
        depends on INTEGRITY_PLATFORM_KEYRING
        depends on EFI
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 7ee39d66cf16..d0ffe37dc1d6 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -10,6 +10,7 @@ integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
 integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
+integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 3b06a01bd0fd..8c315be8ad99 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -30,6 +30,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".ima",
 #endif
 	".platform",
+	".machine",
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..730771eececd 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -151,7 +151,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
 #define INTEGRITY_KEYRING_PLATFORM	2
-#define INTEGRITY_KEYRING_MAX		3
+#define INTEGRITY_KEYRING_MACHINE	3
+#define INTEGRITY_KEYRING_MAX		4
 
 extern struct dentry *integrity_dir;
 
@@ -283,3 +284,12 @@ static inline void __init add_to_platform_keyring(const char *source,
 {
 }
 #endif
+
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
+#else
+static inline void __init add_to_machine_keyring(const char *source,
+						  const void *data, size_t len)
+{
+}
+#endif
diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
new file mode 100644
index 000000000000..ea2ac2f9f2b5
--- /dev/null
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Machine keyring routines.
+ *
+ * Copyright (c) 2021, Oracle and/or its affiliates.
+ */
+
+#include "../integrity.h"
+
+static __init int machine_keyring_init(void)
+{
+	int rc;
+
+	rc = integrity_init_keyring(INTEGRITY_KEYRING_MACHINE);
+	if (rc)
+		return rc;
+
+	pr_notice("Machine keyring initialized\n");
+	return 0;
+}
+device_initcall(machine_keyring_init);
+
+void __init add_to_machine_keyring(const char *source, const void *data, size_t len)
+{
+	key_perm_t perm;
+	int rc;
+
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
+	rc = integrity_load_cert(INTEGRITY_KEYRING_MACHINE, source, data, len, perm);
+
+	/*
+	 * Some MOKList keys may not pass the machine keyring restrictions.
+	 * If the restriction check does not pass and the platform keyring
+	 * is configured, try to add it into that keyring instead.
+	 */
+	if (rc && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
+					 data, len, perm);
+
+	if (rc)
+		pr_info("Error adding keys to machine keyring %s\n", source);
+}
-- 
2.18.4

