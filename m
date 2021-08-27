Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347323F9979
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245201AbhH0NWD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:22:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25944 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245082AbhH0NV7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:21:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RA2VEc020754;
        Fri, 27 Aug 2021 13:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=3y2hwlVXyCwkUCsu64t+jatx24TvUnXBKSvm68yyz4k=;
 b=Mj6SLaZPAgqpMluo90txSCcgpF/4KK4zRwpcgPjOVD/WlsZbRtklZmQYqhCWwa/hqd94
 gQp2croIQ27OWzFutem8citUhTnfIXs2WO8TeKjPvs2IMCcOvOcpRt+KRYnWtr4npYs4
 HsilsCwB4OureOHK70674fFPpAnfu1pdae1yLhx3yYayCpicKqR8K4zjCJ1mEyMDT2LM
 QMlJaM02x4mf3bMnycwiv9KfNuih+LLUjLssmgoRqbMiYx40QnqdGxrSjFUoQgKms5Sz
 L8e32cxlMunAODLywQxWbBIK9bQbcvrIHkUyQ1tgB/K6xDt6geJHevhhsiHPk5gWJQok nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=3y2hwlVXyCwkUCsu64t+jatx24TvUnXBKSvm68yyz4k=;
 b=seAmAU3zqOE0FzzftJyCM2ZtOmJ/Sl7rcKdl7WN3g9pezUkuYLt0jIRz9dkmKcTxVvz+
 fMvvV/dqzNtn1Egej+UNKZTQKSFstovDdQOZI2M1VK2IkVx/fzknjblADvH885e8rYzc
 aoSI9wMo0LfAgzQ5NurWwJGhoVvRLqHfTI6abLrBbhtKdp/Z6havmn0j8Nz3NAXgwJh6
 LW1hifeRyZ9pcORFGX1QaT1/ih6L5qwIUCPbesbpa3wuthYPfdZEtwpOFn5hpmNWIHnH
 inFk7UzTSKPi8dm+oPBD4xnHic7XwdZa3BoWHFbeBsbCsJ1Wz4MY6NjeYFIEiNPjZYQV SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4ekunce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RD9nxJ076969;
        Fri, 27 Aug 2021 13:20:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by userp3030.oracle.com with ESMTP id 3ajpm4pqdq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=embcUBvqJQGAmF2rLLb2Vm0kMfVD/tTV285kLpofJrVuppzSxx5H+oWSp68whj25xVRf5mOsoPnurM4v/ZOAmywDBPUo1vfC6dNGPIspMXSbEKxIuX07V2D5PxnnW0vIfgKFWBE7Bhp8O9vlZDIr5AyfBiV8a4i9XECIouA+qO+WhhFu4onjjw34+1DQRU91V8DfkmG0VCplS+8F/Yn2jiNPkB5ozeddyUyW4tyn/OZ9MGOcmGDu7+yQW1CVHjZzMI0eErt200CYOCc5GN9a/kmC0qAZ0uo/jVf6Qy2nLZ0FDYH0cG3e7qsKZKiWpztQzmKfLoipJbDDd8730w0CXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y2hwlVXyCwkUCsu64t+jatx24TvUnXBKSvm68yyz4k=;
 b=hopiV64nDMcJYhvhE5QZAxx2AMhjPQZZt7AIeoIF8HymcXixENkddxhufs1tDwhZhkkg5izOO4liuVF/1XadwIUe8cQ2xgkCAxKWlg2uQl5x1bP1334OrQY0m249yOLiAeUw92GPEk5MEO1mGUTkxcMqbWi9EKSbyBH/+a/YTnb4cHokKexioNcI2UkqW6mKZ6U9o+kQ5BOLtIgU+gq8bo+DuV2OYzKRxQA8Hpa0hOXiGD9PrkaR5PmfmJGKiPGkhfsTs5wQkZWUDu/qNd3oEvlW414RpV3k8nRcgneQF7JA1Vwq+vwlfzwbCkv6vl+aUfEEckSqyJh/huQFwbR1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y2hwlVXyCwkUCsu64t+jatx24TvUnXBKSvm68yyz4k=;
 b=w8ueBO8jVVpkI2HEq7sGCaItu9SdpgMldU5mpHdIgtKPELq8KajA+Aj1ycyP6mxuQgM19ek7v/vDHKGQSYy0conY+YhCHZXbA9hz2AsTGlflRn23hDfHRKJSH+G/G9BEdaReIoeqeYfhDrBA/fAdmwwzX47xc14VF5uV155ZH1g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3237.namprd10.prod.outlook.com (2603:10b6:a03:153::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 13:20:55 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:55 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 11/14] kexec: Secure Launch kexec SEXIT support
Date:   Fri, 27 Aug 2021 09:28:34 -0400
Message-Id: <1630070917-9896-12-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b763bbd-5f22-4c64-7701-08d9695d802b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB323712B8F7541DF92F933B1EE6C89@BYAPR10MB3237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KADy/+0lObOIhxu6H49w4+eeyBMiq8VxtVxsV/r/WgStdrFLJwEKMnuofY9Fb8Eea7Gmvf7wJXqiMV3siT2UIZVOBkgzlxf7NbjfzXKjZayWQsP0c3VOTBfJfxAr8x0z9OuQr4hxtjXIz+DdmNLexlCAr5CziYGnZbg5Gi0lr/nWH0IRiEzF9HN/s/PqC5ktwfxjF+PlUgTXBO/D9pdRVSlpboFnBPo2wXp08YbCDvX6WXaln9GyXOdWpLZQWBJnSsys9dO698o7j8M2JWrRgDAxM8jAbRzkHwT//ZWH2Q5/Azs2rHLlMEdLSq5j1BS21QdjLM1D5Jg8ikfldMi5AmWmrzIwB1lSqEiFwVx4f5FzueKnft7fQp//iDdOKMt2I8gjAzkfuu6V4h0r6Y5jYpderktQToMVNg4PlkG4x90hHHgWsHmt69riMRlG9YZZPcrh65REJLw7bojGgo/1pMW+N5FVSZgSlY3ibJGBiMM+hwjI6tYyJ0hq+76y2EKyJDuY1rhx0m/GSOd1ujFLG/PKnw/qBt/nGVhv7sW4Wv7TlGHd3bhl7wM2Pum6cw90EHjWJZjF0HKQ138EZxgJzGJC3dFnJwREqLZrlMaXavkKJu+8hKZiN68WeZD+vhAs0Dffc8P9ifC2YVscR02YHrSDnJrfK75n/NPpLFc6p8XsllOELdQhdqazNpmoqHS01NClA5wAgk9160UXkdJguQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(956004)(44832011)(2616005)(2906002)(52116002)(26005)(7696005)(478600001)(38350700002)(38100700002)(6486002)(36756003)(186003)(83380400001)(6666004)(86362001)(8936002)(8676002)(316002)(66946007)(66556008)(4326008)(66476007)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PDlEbimDgYiBNAGNoW6Gr5mRh/Ex/9v8XflNEA2Tq9DWeRYZfq+/Y84N8tnY?=
 =?us-ascii?Q?9EYy/zGggdu8epPez0NDpQ48MrUKEqfMpGioCcHh9SrsGA14KQMsGmC6hLgm?=
 =?us-ascii?Q?DteykmBzF6pyTeYPTjO6GxW5Z1tktrzsQmacbweUiDeL3Dqoo2QrIC0tCGxX?=
 =?us-ascii?Q?nvB72HGuu8tXx5WJWiCWB705Auvd0L4yiIFWkVc1pfb5pmtKie1cB7k898Sv?=
 =?us-ascii?Q?pqXEgaBA3Bo2WwyHAyuyN7B1JzCp8APirIAGrEdN5mVzsE3ds+R+rv8+U2vo?=
 =?us-ascii?Q?zvT+MyxN0jFOquiMkKXNkSBGekoy5mYkx0FpRYLpVxUtTo8X8EUH5kKL3lLZ?=
 =?us-ascii?Q?5GqGYJuoHnshwzfcRXqupioR+7d08GCfeU29qvFw6jzolzNk3MQzVtSiSIiX?=
 =?us-ascii?Q?pf3buX5vAf95jKlgLW18iRXISuchoiv2nBzXgo1z8/MhGyuOu8tPCdK+nuGp?=
 =?us-ascii?Q?iemgQPNKr2R4QVcOExxOqeNpO/tRAgVKENL8y1a0oEdkr0I3RDvflPQztf1g?=
 =?us-ascii?Q?IRohW53TIW4FkWlEhT0Je43sMw7NQcNdmd91mIXToMoGPPBCfjhP2VYcjtKy?=
 =?us-ascii?Q?DlVTB+dp5PqV1XZZ5PRw5CR+o2ijC9nOpmlR7u5NPpDbgwOQu/9EWNsPtn+h?=
 =?us-ascii?Q?ojS5XBKQQ2zNx83FASH42SQs+GJOD9DEf7V64glie9skFsueTVKLad2Nd312?=
 =?us-ascii?Q?bDHu2F1gDqXtsfBQh8hQ/So/ENRga1fMuaZMWyYnpwsfR0idiiGB3do0wTnC?=
 =?us-ascii?Q?VEcajSRmrai9UL2BX83SzmrOCECFXgoMQzSWpSuWgqP6hQ3jn1V/+6oUa9/n?=
 =?us-ascii?Q?yUtj9Jk6Ea1obSzPGWAsNr0oW3ZRaQehqPumqO3/JFxou8gjoxjE4h5NSnCc?=
 =?us-ascii?Q?7JgTBFsW4bYyDldx3ugWVsD0xGQ0CpZ0kq1gTGYd5ECuPJQJziofDuhGdtQp?=
 =?us-ascii?Q?gOhOifC7RKfvhLgoCkEte5wxSOFv8R1oYEeEvmxWsu8PMrTpi/81gS3tTVF2?=
 =?us-ascii?Q?MPlW0cDF7QuxO0T2FAAmFb0hXK94SxduqMBW5Kir6DgVISSWkjhK8Dmcfjt4?=
 =?us-ascii?Q?KRRcnp5aotjOD8PmaaaohozS1iM13TQpDCJUZ6lO2xalaO9OyIQkK7BFNFaD?=
 =?us-ascii?Q?YLWk9kFKQq8fdFvjPzJwimKs/VFr6hVjPeINhNtu7e/yQMtQh/6MbVXUghUK?=
 =?us-ascii?Q?fYMCsgWlCtgjbtCR7rsWH62SzMZ50t05A3JW8FMx86xMnNO25LFJ+7OGCbIm?=
 =?us-ascii?Q?Ff8yUWiERWws6Kwq249/PGTl+OxmtBGOhxJUbdu2LapetCEokdz1Ti5yZ1o5?=
 =?us-ascii?Q?B8eor7b00ihQOH7Eqv31dRJP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b763bbd-5f22-4c64-7701-08d9695d802b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:55.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEW8RnwzChflC1br30dcnn3MZKQlkKSRfxaaF2NHO0MbxHDjvFtpj20oSw3yEQYHfE3q7pUYgJMxRp5LyW7vIuvvFPCJIJgrL2M7O0GQ9DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3237
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-GUID: hUd0dv83F_AmsnfDGA1yGWht2-UMLYbx
X-Proofpoint-ORIG-GUID: hUd0dv83F_AmsnfDGA1yGWht2-UMLYbx
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prior to running the next kernel via kexec, the Secure Launch code
closes down private SMX resources and does an SEXIT. This allows the
next kernel to start normally without any issues starting the APs etc.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/slaunch.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c       |  4 +++
 2 files changed, 75 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index f91f0b5..60a193a 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -458,3 +458,74 @@ void __init slaunch_setup_txt(void)
 
 	pr_info("Intel TXT setup complete\n");
 }
+
+static inline void smx_getsec_sexit(void)
+{
+	asm volatile (".byte 0x0f,0x37\n"
+		      : : "a" (SMX_X86_GETSEC_SEXIT));
+}
+
+void slaunch_finalize(int do_sexit)
+{
+	void __iomem *config;
+	u64 one = TXT_REGVALUE_ONE, val;
+
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
+	    (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT))
+		return;
+
+	config = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("Error SEXIT failed to ioremap TXT private reqs\n");
+		return;
+	}
+
+	/* Clear secrets bit for SEXIT */
+	memcpy_toio(config + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Unlock memory configurations */
+	memcpy_toio(config + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Close the TXT private register space */
+	memcpy_toio(config + TXT_CR_CMD_CLOSE_PRIVATE, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/*
+	 * Calls to iounmap are not being done because of the state of the
+	 * system this late in the kexec process. Local IRQs are disabled and
+	 * iounmap causes a TLB flush which in turn causes a warning. Leaving
+	 * thse mappings is not an issue since the next kernel is going to
+	 * completely re-setup memory management.
+	 */
+
+	/* Map public registers and do a final read fence */
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("Error SEXIT failed to ioremap TXT public reqs\n");
+		return;
+	}
+
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	pr_emerg("TXT clear secrets bit and unlock memory complete.");
+
+	if (!do_sexit)
+		return;
+
+	if (smp_processor_id() != 0) {
+		pr_emerg("Error TXT SEXIT must be called on CPU 0\n");
+		return;
+	}
+
+	/* Disable SMX mode */
+	cr4_set_bits(X86_CR4_SMXE);
+
+	/* Do the SEXIT SMX operation */
+	smx_getsec_sexit();
+
+	pr_emerg("TXT SEXIT complete.");
+}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4b34a9a..fdf0a27 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -39,6 +39,7 @@
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
+#include <linux/slaunch.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1179,6 +1180,9 @@ int kernel_kexec(void)
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
+
+		/* Finalize TXT registers and do SEXIT */
+		slaunch_finalize(1);
 	}
 
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
-- 
1.8.3.1

