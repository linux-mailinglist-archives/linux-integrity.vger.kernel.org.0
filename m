Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D144BBCD3
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 17:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbiBRP7i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 10:59:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbiBRP71 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D86E275AD3;
        Fri, 18 Feb 2022 07:58:53 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqrab021130;
        Fri, 18 Feb 2022 15:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Gvu6COFtQv+0GXTO3pQsZtlLB6eh+uH+bQ7VfiqatZE=;
 b=zlQikDidY2e1whcAWTyHISj9aLlzg3/y5x0gFyCUw9iknBUCcm4eycZ2oVZo+N86Q4Ba
 aeylvZRGlWNtXT+4rUuybjOQNEc1CFirErWQW7byUgoMRhtvjqImSXppJAB1H1R+IbyL
 XgjhxFlx0nIXziVMsTFGbP+BhMw3erq+vAACH/TorRlW4Bh0Z+EtMsWXnJZJ9+ZVA+Ns
 H6MBCfkR0RT8rQP4HRtqdqc/2Olq3yOFZf4bt4zhuDX8BcKUKxWmo5bT0I5XALGu1ArI
 wkUbMCu8tUYLDQS9MwTq4xdpoTCRNcsUJog2NyTTLRZdhwcn3aWhyBEm1HIFdOy6sdFz Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nkdt234-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFueW7062751;
        Fri, 18 Feb 2022 15:58:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3030.oracle.com with ESMTP id 3e9bre21c1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFhcLrZ2RfBHxWcQy5vzAFaxLeFWF2RR6P4cYwRnJ+edHLFwkEblvhFCsbytfn02P01JbYEozjBmUYz8I4a58aGg8Cj7hkB3F0Dyl25Vz8ya+p2xMGES1uK4A+COBuFjps3D//4ibFg/Pi7asCIp6L8RMfMdTCuGGfslSvc12VwvZ07RuIH5VdDapTHONH32Uj4SWgLbrEBnYXwlq6pjTN+XqngwfvMN1AFB1gmCPBEqzP8rnSxlfatV0Xe2sY6nZ5Cs3n/9FhqG+RjGGfTolf6PISXIuNjGVMauxhPfKDNRvptuNb6akGHoWCl9V4yKPFPpRxpA+gRtL3NRM32ILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gvu6COFtQv+0GXTO3pQsZtlLB6eh+uH+bQ7VfiqatZE=;
 b=JUBFP0/X4NssRZJQsSl90+nQT6o6GZKZdm+GgpQhRZHS+XhAmFj/j5uccw2/pbYRWG2ImhklLHdAuzXgMBP0bDPNmbEi2F7n6n69NPtIUzAaS17dizyDisB4NSnT3H+HbGYhSegLCggAh1awlw2ee+I61DJXFPMUJktj3BFYt+xJGtxaFhsyO1cCvHBmKUhTtCSMcePzu8l7ruPW0H5pQu9J9LBntQ/ntelyYbMwJjEglcTcsAVpn4U7ASRJSIQ2Cv/yDS4qqe8pA6p4QJ+98u7Ot1t90AS2hg8ORRXaRBQYXJYqWwr3S8yAxvljAEMFbKzC4+ApZpnDA0iJth0swQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gvu6COFtQv+0GXTO3pQsZtlLB6eh+uH+bQ7VfiqatZE=;
 b=J1E00VCw7ijsPvUFqKyvmB+Hn9RzbJqTvguN4lSpu97myK7OgILvUnPW7LC0/MtUgtGWeCK1NyiAF9wZzoRM39p7Pt2cufk56eChCHGQJAW1EhHD2DLKboWOZOU8NA4q6V/tPR0m5MJgh/cCPEAVX4XEGnUIqtVfWK28vO3hZPg=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:22 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:22 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 09/12] kexec: Secure Launch kexec SEXIT support
Date:   Wed, 16 Feb 2022 22:54:42 -0500
Message-Id: <1645070085-14255-10-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f79d68e9-70d9-48de-cfe6-08d9f2f77d85
X-MS-TrafficTypeDiagnostic: BY5PR10MB4226:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4226F198373D641572E1215AE6379@BY5PR10MB4226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykui10NGHz+ER+cKbXl4DySCoRZ17s9JdhsW27I7UTKWxwPgi2CdK3DLUpAoZlqNJhXslS+Nzljqts1p/0PQ7a7rtL1nll6yIV1rv29rCOT7akZFUd7Gh3sHVswL0k203pTEzdnK351w8rwcycpSF2A64yMdjjMICs/x4iEyutHSyZ4Ab7Qf+JLtHiV2wI5gOikBnGE+R0bJPgFCVG9XYyGkSXB9rPAwQcfcjVpdR+PgmfD6JGFr/K8EwWOnFLWy8hShcTXYnkUbzVvNTlT+DNOuUBZu8GuWhKO5IPlBUYLiFL147iU0llA8HeZLL2xmRTBKj3ygtJrAdE3LLo736aZqnQrPdoZrXc2c3YMtUR9WYBUnmEROzKzJe+2WHv2B96/OCLWbWQR+pcTZdQixQFWa0ziWFwmcTWx87Ndn62KNcHVI7vVqKpYNwtC62Wo2TFv6QbUMDukwmMH1LomHrRHD+ws2VG82KIS72BzKOXC/2Q3WB2nvvUJm67iADRJ4wieWfa6gLmuyEX9eqQ/qlmn5bQ++UjvHNQsoxULrTcNIyefFtf1vGlEogTNCKWK2rAGH4tTWnyy+g9WHI5h50BzZsQm9Cj61x5BLKjRvvlPy97QKNEk1UZSU1TCtDONnG/q7EG4IJKqqfyYfiYp31QKg8SmYrrHa8pz1MGz3mTFqIMauQJ6tm0ZdHTmcvxgXIcGDRAYR8hvtvFyfE04jjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(44832011)(86362001)(5660300002)(36756003)(6666004)(7416002)(6486002)(52116002)(8936002)(83380400001)(66946007)(66476007)(316002)(2616005)(66556008)(6512007)(38350700002)(38100700002)(186003)(4326008)(8676002)(508600001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?282jUxvOzJmt++1qRmswgEN2bic/VwuQk91pyJQ80x/P8PgSdZnMDED51mM4?=
 =?us-ascii?Q?VbMQj3XfEVfATGElxb4ab4aer6aIz/jeBIAusggvgi6gX+pPvnmKhW0OpE0C?=
 =?us-ascii?Q?7zLJp0ySCibR6hC3vXeSB9BVRRUp4wLB43Cz/K6ywEX2PMCYiC/PnuerRzxs?=
 =?us-ascii?Q?exq55xBgkrBV6BK6EZboXaL7DXjXa+Zt3ZkK8b4uG8HODT+adpfmqF55I96q?=
 =?us-ascii?Q?cioG9VmvuEHI3HIqmlgIMf/ntnlVHEtkCceqpqZneURcdlll7ixjC3u38LHd?=
 =?us-ascii?Q?6rvEXqrhvIHII1x2niaEEH817th4XCRiXD0MCDI/626/5p1sn8gmXdscNOIh?=
 =?us-ascii?Q?vEX5kcCjtKzbO6rfJoP6828k3KfPkmD5m5zLQIEebGRvPOidazYlN0HNhp82?=
 =?us-ascii?Q?05rnoH48gqX/aAG7AeAofYk9Jxt8cVjbMwxTDH77FuKRqvkvHKveZOAVbZn0?=
 =?us-ascii?Q?mOG6YL1I9Uczay9j06rMX5he6DNu/H163cOflEpcR8jsToCXQXLlcm0IPb3W?=
 =?us-ascii?Q?VqfhY+u2lX6OMK6MRq5f43BaUT3VkJYy+hvCn6RnmzWbmCIuopa3lym+3s7l?=
 =?us-ascii?Q?43owRX4O7r7KESTY39cjF18k5hvcoxf22lfeoYer96Qc+Pa8+oSr26wRjxKK?=
 =?us-ascii?Q?tAva6+XJUA0Gbv6NFELPGQjBXmh0jJ4rQAYWFYMniW/1Gahr12XOlkGMra3a?=
 =?us-ascii?Q?uzwTkcXtizsAYtCqFAvxn+icU84sIm21hWb6VVOvOhxhkNXLLk6UIlPk266F?=
 =?us-ascii?Q?3NMsaT4Tnanx/k2LHcZjJSNny5w1CmMdhPIctCcPlHnQkm1EZr3v6UcxHdNp?=
 =?us-ascii?Q?nxrXABcRpQK0pYwsFwgMBDfMkmvCzIz0/xhJP9I+WW+OhTnxRsPI/4GmMhTI?=
 =?us-ascii?Q?Qlod3SwAKZdf/ahH6rSqX8NL0EGSiIXNXwHE5sUVG9FB9Q8akryx18QTiOxZ?=
 =?us-ascii?Q?ksH2B9tFnxtkRZ1OmOCvbDRMvnEJg1zmUNxx6njLK4ZBOFh2vX0+nsCpROSn?=
 =?us-ascii?Q?PcBn7aiDabzkMWowe9yOpg+xayqouRO17x+NtBVyDsv3aJ8nFP8VYsIherQT?=
 =?us-ascii?Q?yHQWmnWgbsqsWj0bCW5wj08jMxT+lMBon+qlr+ZSQP+StMghDpSIrjf8Lc41?=
 =?us-ascii?Q?0EANuBPyrnvhPGqp2Yhpu5JcK+N/2VLiLWU2NtqTydhdfxs8BSyB+gM8hFyx?=
 =?us-ascii?Q?ugb4zliUcvXI49AfN70WKiK8vuAk3vXhdHNQqWGLtGYHuMpZjmWMxFZOMHiK?=
 =?us-ascii?Q?CneZnsfFKM+aCOBEN0tquRZ/JDkAbhTXdBFqbZbP1pik5kS5BrYO2HzS+eXK?=
 =?us-ascii?Q?P/WANt6BJMS/Rve0gQ6CTXQdCgln4Zqfm6ZEyAlt8r569zsOK0PBSK1zEBBc?=
 =?us-ascii?Q?Gnu2ezWBBvUewx/rLmbofbusq5ZKWHIh7u3+4kPDUvsti83DFql04q5GUTod?=
 =?us-ascii?Q?mHNpGoO6Dbqb9xonuzP+iTwdKbPFxoP3C6eTh4dfdtdxqs0oVOo9kwDy836n?=
 =?us-ascii?Q?4iWIU9mGNAYCZOtxd1vmk6FuJ24x69qbws6gtlTJXdCz7l2r67hcdCiOaS9O?=
 =?us-ascii?Q?v7IBHmjtGkJxl++RHfWrOjqeB8qPsTjoREALUMQNQa5uS8fa9ZZ3ZW30m73U?=
 =?us-ascii?Q?yNa5RKR2PPXHhG5NvQo9q4fhE2dFXqmv8kvozs/lDgGf8zdz38b8jcy1INxS?=
 =?us-ascii?Q?Rt5dPiMWcI7a830mc86a9po/YV8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79d68e9-70d9-48de-cfe6-08d9f2f77d85
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:22.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jg3nomqn9N8UCxmSdSfT5LJYueb8zvG186D69z8uRic+lUtyrR5ExB6xLpCWHGXf3zSpbXZMtiAnREyrIHDQ/ZA4JX/+zfR7cHAc1ud7qlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180103
X-Proofpoint-ORIG-GUID: c7cMLpprpCbQ_rIWke1iBUG_3KpJ0bfE
X-Proofpoint-GUID: c7cMLpprpCbQ_rIWke1iBUG_3KpJ0bfE
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prior to running the next kernel via kexec, the Secure Launch code
closes down private SMX resources and does an SEXIT. This allows the
next kernel to start normally without any issues starting the APs etc.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/slaunch.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c       |  4 +++
 2 files changed, 73 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index ef6ef08..d3ea491 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -465,3 +465,72 @@ void __init slaunch_setup_txt(void)
 
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
+	u64 one = TXT_REGVALUE_ONE, val;
+	void __iomem *config;
+
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
+	    (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
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
+	pr_emerg("TXT clear secrets bit and unlock memory complete.\n");
+
+	if (!do_sexit)
+		return;
+
+	if (smp_processor_id() != 0)
+		panic("Error TXT SEXIT must be called on CPU 0\n");
+
+	/* Disable SMX mode */
+	cr4_set_bits(X86_CR4_SMXE);
+
+	/* Do the SEXIT SMX operation */
+	smx_getsec_sexit();
+
+	pr_info("TXT SEXIT complete.\n");
+}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f7..cb67bfb 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -39,6 +39,7 @@
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
+#include <linux/slaunch.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1178,6 +1179,9 @@ int kernel_kexec(void)
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

