Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1D83E49DF
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhHIQcA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:32:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5752 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232887AbhHIQbt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:49 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GCKSv013022;
        Mon, 9 Aug 2021 16:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=3y2hwlVXyCwkUCsu64t+jatx24TvUnXBKSvm68yyz4k=;
 b=PZzwr0Pi995hbZBB/iuuS4j9Br1+7WyFXFecMzxuuiEX0w7mDK9IE3L/K4046iSCPSEl
 nWh9iRYG93FRAGQECgC+LtOUCAIyCPj1/si7GSwSNU1bt7jrQYnYBjLXp04YF+poVmUR
 2OM1IamQnUFKGb+mW03GKjQqNkSejdrTzv0jE1zmDu7x9aVX41bOpEklR3QV1CwuNd/c
 1kUifY96yHApfw5AEKprfy9vPk8elt6SwTgzBnyLOA8vRH7Y++zW6v6Y/Nd+Kohs9TP7
 ugPD4IDwKel7/tNF2rGmNXP5HMnY3cGqAynpUiuMTqddbW+J6I67s1zLEeV5civq6Wab JA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=3y2hwlVXyCwkUCsu64t+jatx24TvUnXBKSvm68yyz4k=;
 b=cEhe7+CSk3NkcO3U6XNbAM4MOnxfyyZSBGe33IAFeYpY70eV3I2dGZkEA39ADzia+wNY
 VnfiKBXONBbExnWX0bUD/UnXaLbHxnh8Db2CssgZBqnFbXumMxacuXGmo+4El24S1R0x
 vdVITiIie4b47EYcWZPWYvLuSdIlQBKVdBkPtHbxsXnBpjN2gH48ytZ3qlYtptQ8gtfS
 Pa/pjSOFffqDg4jlKGiCl7AFTIIntPmKHZKshhZl9r7v5BDB1Lt3uYk5iMWuF5uKqotr
 xgbBW3Bdz5TuR9DpvDq7ZoKeMHpd1BLqc8B4viEi1i+468CYREZ6bp5FKItbTDleaZHD 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17ds2fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUeF7066407;
        Mon, 9 Aug 2021 16:31:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3a9vv3860c-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7pjfgwC2yIRyMUwwO5SrqPDkhEMpcdY+eLyoKX6WTSBzTjKcb3pr7QIF6tCoFUmyeBnahFUQ+A1rFQ1Z7GNofpeFM/R9dQ2WREqmSX4k/ZDZWzA5IClipWMsPsvOUlk8bFv0A63qQsu3qCUoHpAzBTn6nMCLcwCaLRcW5UWo1lpmaemhWUepmU9x6lXaf+u7haraiSq1mOCeM1mUlk6znnSmj9olfKSSTx/wqoGRTI6K5n+u6p3dTSqmGHmGptFppNoP9pceEvJ7rM19TEp9cMidmQbq+zzbdXHF+deSs8U5ILk5Y/IVkcpKHvBeEdZe7TT2TalvH2ieIweux8Fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y2hwlVXyCwkUCsu64t+jatx24TvUnXBKSvm68yyz4k=;
 b=kfQ5tYQLx68uXPiDDZug8o/+HBXQ7G2xf0YcmvlpXwBgH+D867iUzapA8LRsCGqtTLah0J5n1KEa6IjiDlHmdZ+NvH7094AOiV6siM1/HklulmxopXP+dLAZcaOGhifVpgMvUHTLmpMIiUnF1p3luTM1RQYRr9hZIIbdiL4VyikZWK8GInJyWIn2CE7dsoBgHZtiNJro+M/H3YdYXWZwnFe/CFnWseQMM/NSGIEdvVS5qsNGGNriYBAcrXt6APaPcVhOgYZB6NUIZDKF/KrHHesap9l8ojZVH2A3ijF3GGyby50Pyf0D4eYvOfvxzWDk2xl4gf017Hs+vws/Bupc2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y2hwlVXyCwkUCsu64t+jatx24TvUnXBKSvm68yyz4k=;
 b=pGyCwUnCk5kxXjVuVM5CJ65dY3ESqY7/nmRVJjKdVxmXF413zpDm52T3FFEYZ6PCoQgfIMh4jxX+pH2phvu0Pycat/H1ppJp+BrNigajiYKtGB5LHdEAEd2D9AxKiLibKPdLolBsDGumNAzRneQru8iMPPhp8h13nwrlquy1DP8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB3939.namprd10.prod.outlook.com (2603:10b6:a03:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 16:30:59 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:30:59 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 11/14] kexec: Secure Launch kexec SEXIT support
Date:   Mon,  9 Aug 2021 12:38:53 -0400
Message-Id: <1628527136-2478-12-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:30:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ca9f452-0625-403c-04cf-08d95b531224
X-MS-TrafficTypeDiagnostic: BY5PR10MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB39390E4A43D104BAF4B93705E6F69@BY5PR10MB3939.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYRSVw8OZnVM/Vfr1yV7RvOssTxz+WmmugtMNNvI7nvNnKK+6Z0LJtQipUSENk2Ibtln5xcbFZU71uJdN53DoCp+9PiPmr2qY9mRxQqZEujkMUy4PuSZniOQTgfJZ0qgbQdfd5wJIlqf3BYNgRyFk+KSdiq7ICurczWj/9RpPozV+UyXeuJjjvx7ZBYMyAp3ZJvtr+Q0Iitc+1BFYMG7uWsRiNz2NR+t8knJdYs7q3RbeOnlSdTVwKq15ItBptBEpIb+TRf5+X14yidWzdtgZare6oT/ISWrDaJzJlfIyjJAapsPxNk55aAwjlrcg5wjpxzILmIK/+ytNRDlcCbUxfVuHA+2+LzhXULSAHAZjcNpnWVV4NmPwEP8XAEtMShW26sAto8RylqguVDHeUOEwvefg4wSFHD9cCe8jVnIQumiykKlJfDsDrWEx4hqHwfnSY3gYHA7G1Min8mwJOOLU8/D8REUvsUTL/PksFHbMjelA8aZlG1MnNtP7aq7+Oy4w2adymLufdmMFeUPk4agEr6p5pq8h4yD+ONi+kPi5oNIkRB+Zgyh9nHUMm6EI1DD2UAOmgtGygX7xYNWcLJtAlfLP/20yd2tQH+oAjwymF9LDLHRbC+PfHslpsog11yoU71HHlv4P4KZWt02s5CDHRF/H3Th9R++8h7j44OjTfcFhg24hQ05puz0OUw3WRLy1vlL6uTeL2ZkA035NH+YgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(136003)(366004)(38350700002)(478600001)(86362001)(316002)(38100700002)(52116002)(4326008)(7696005)(7416002)(2906002)(6666004)(8936002)(83380400001)(6486002)(186003)(5660300002)(8676002)(26005)(44832011)(2616005)(66946007)(66476007)(66556008)(956004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6E1BWjwE19uLhCe6zLW1c6BnQrR2Lp5GQIYyHzhrg83CsMdSBhKR4XoEga7B?=
 =?us-ascii?Q?lVyvlwkyo0A0neIn+incnrZwAg7dBR//EcT0ux4kF5afA5eiOAh1gLrBskPt?=
 =?us-ascii?Q?o61uGZGkviJoKTL5Phz63NqVCw2w0uXmFH8RPI5s14rlCfjmR48rvIp+HQHG?=
 =?us-ascii?Q?Psmn4YLzChdwi6POp7XaoJournr8mMVUd/OmYFbHpe+09K4nhJoTtJDVZHKg?=
 =?us-ascii?Q?PRy6FTtiVHq9Kw9OldTg4xhQO/iHBnPF94+w9ciW1OY4e6eH3Zqx8wfv+SOq?=
 =?us-ascii?Q?1RAIAzt0OOK/lH7RVZfxOl8vdnr4uklY5ljXkOLvdpZ0ey0lNWDXbb5bbHwT?=
 =?us-ascii?Q?qiLLLC8DehHeMJg8EW4XH88hNkXgsoU7JP4wDJwNnk9qshZNNXgyPy1KO2f9?=
 =?us-ascii?Q?S/XF8z1Ur8cxQnqxOe8yHMLpYxSrkzhgcx7lF7w9MShhKOCoHCH8FLIDtVaV?=
 =?us-ascii?Q?vqn8AMl3Jz7fbJvLfSqG4q1t1Bl3ZMuRHyVG3mCECGfVl31+14PuoAUKAP9o?=
 =?us-ascii?Q?WWAiq1DNN3XWodbq2rKv3ro5S/VV0N36zwkEen+2Hkuj17dhTjk44/xG3X0c?=
 =?us-ascii?Q?pvegCTAHomB9qWYuYqhv/i+CE5TEoRxJ2SzecvI8z8oJJUnzImgKqaKCJBXk?=
 =?us-ascii?Q?8Lrhl2DxT0NjtyW1lwFlcdeSyqGXUZiaRp3Fbpq+oUb3lRvBu2RWRhwcFSZa?=
 =?us-ascii?Q?vqM2birTAVUzET47EdiR5KpydPc6Yo5Y71F+OGCcPd9SpuuQZaTPx36yCBF0?=
 =?us-ascii?Q?aR3CO/4pxyQzZ9+CFPX1K4Bfe5w2LMFWFned600WEsnO3bORnU+a72tfoTe3?=
 =?us-ascii?Q?+G/HiclIcJv+v+hyVe2cxNxl/BGEWNqgbyOusYWeKa5f87JuU309m+ZCCt2g?=
 =?us-ascii?Q?A6CInSAKYZj17BBHSCty4ltNNwNcDcDhKSccd4sKzCsfhstV7mMd8lmeLsqc?=
 =?us-ascii?Q?vqd6PT44EeAcN1uHLUPZoCvAuGxcsHapa4bKerirl7PVyUyd5ej1LqqUn9tJ?=
 =?us-ascii?Q?sQQvC9iRBNwOHIsfK7r9OlKy3sPhIFw/rCjlPCaGrVq9tD47C3+NoPldqXat?=
 =?us-ascii?Q?i6ZXFQdTLgwW/962XzJrS11LLPisp/7+xEN0bKu20x0gl7PYCEYkXDSM3zqk?=
 =?us-ascii?Q?iY3E7Xvja0icjhki6EHY0oSy5oMgCAL881+UgQnVLgEecYKLhWM2JpFkac0W?=
 =?us-ascii?Q?u9qWFOfIlZkQMVz2DnBBn97wK9oKJ09TPXHoB9ppbqOQPtzpH0ih9xaCouGR?=
 =?us-ascii?Q?DDV+a64Osk/SR4wAjmDRDmPXOPIPRIWuiqq4NdPRFscIXbXbjDXjr6sYIn39?=
 =?us-ascii?Q?i/G8d9eiTmO72HnibGw7n5oE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca9f452-0625-403c-04cf-08d95b531224
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:30:59.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gv83BIcT34f0IMn24xmJMGCdsZft1WXOYBHBjWNCG/fzFOCTI9NH+UCAZNAy+N8VM8ORd2fl6A+MS2KmH85IKGuYjFabdra+e/Nl6KacK8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3939
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-GUID: y8vnnf-VMICdsczTpiWr0UdW6CKsPoIU
X-Proofpoint-ORIG-GUID: y8vnnf-VMICdsczTpiWr0UdW6CKsPoIU
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

