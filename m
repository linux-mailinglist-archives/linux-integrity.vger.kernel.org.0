Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D684BBCB3
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 16:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiBRP7H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 10:59:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiBRP7G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBC45F241;
        Fri, 18 Feb 2022 07:58:49 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqq86027959;
        Fri, 18 Feb 2022 15:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=r6o5jFI6Ltb4fmqoI8z5A+6mDEsdta7laDJOMbS5xNc=;
 b=L+j44ghuaFdF8+vx8SsNYfDmgU8enQdDM30ZRu3sUC7L4ipn5iMFZ7Y5uo87ty3ZJvNl
 Vp2A5O3XHSB/DvGmshcDPvpEQwXi2LRxg4sB8Hqq3w+gas9iNXlDzI+1uSbN/M9+DM88
 NeL2AMshrA7Hav5R4BqiyC9Y1pDj+2LZJgzI9pR1+iRQ8n34wr+E3XgXyvn/uoCVyo51
 QE9mrte6rjnUlHzg+exG7XRWmfKvGPi1F5J4J9UXk6Tp7njnZ/beQHeeuQzRDIbH+emn
 UxmXv4hRKO83KBevKXJK1aMufN04kfDzdA4+ULFrx5BlrBm1Ej5y6qO1lFsbxM7P7oO6 Mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3e1ypq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFvKhG055304;
        Fri, 18 Feb 2022 15:58:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by userp3030.oracle.com with ESMTP id 3e8nm187rt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKwSqg7HtDftryKZyUgaE692AFH0w14isovLHhy6sLchOFHOxKn2032y0DXG8YvvSymkDaUQbT16mITwpawfYHXmmLz3ErrY2ZI7onoAtJUuyXWUgeTjiGDwWUfsQP/SfRMfzlEKwaQ2sxZ6Jm+SelQgqjMCu8BOpqxuTh7UE6smOmnIAF3HBTmzx0DxBT9vyGw//GPzf+2WoM+PJJ8l5DBSG9a4yWlSRgbLWs1saKr9AEabc2sTvRYYLgrgVrNHvl8XHefs+9mn97xjxpisMFyI5vB0dyLFnAiMnJvZ8KSgv+chLdwW9OT7nzhAsKueUXbmjBN/BXvuSkG6qxwdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6o5jFI6Ltb4fmqoI8z5A+6mDEsdta7laDJOMbS5xNc=;
 b=QGuDOK5g5igyWy4Xz87m6E32CHrAJ22ek7LrKfbCNcyZLs3nVE13Ao2P8YDyvDSfKQm3hRrWWzqPCdr1BG/AfvYCKbN8XIzhYZU3ThP28qeOdGz6J5BG83pDEfpQ9pRS2aUM6wBOlCu8woQY4NnN005XXrfAoEwE+QxTmQwTpARLJrbqUO2ruEyGxfGL1LmlATfVbNI/LWCCT9r5R68TfclIiZuItnmik5Cjxz7IsjZ8WAkAgRwYQ7HwDrx8YVI4FnSCfqnKfuipDNAHsBglKizugBC/gQVh64E2s7Q2sfb5JSJV2qKpUwd0oPl9AvNHdrGYsYDmck1lxw/K6eDfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6o5jFI6Ltb4fmqoI8z5A+6mDEsdta7laDJOMbS5xNc=;
 b=Y4/M7QPGW+h1kOcuRznqoApb0jB3Bhr9YzvW9m9nF9g13q8zi0gOEH00bCgFCQ2xYSOSCPCtewSUaVdTAxjZIm/k+bC0dUv6a69EjODUseFgtSYXK5d6KfUIcekEIjqlC9T4wV3Mz2XpJtxkuaz83dboSjZ7PW/pacV2XO+S1+I=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DS7PR10MB5312.namprd10.prod.outlook.com (2603:10b6:5:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:10 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:10 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 03/12] x86: Secure Launch Kconfig
Date:   Wed, 16 Feb 2022 22:54:36 -0500
Message-Id: <1645070085-14255-4-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09e26aa3-f06b-4d7b-c2e4-08d9f2f775fa
X-MS-TrafficTypeDiagnostic: DS7PR10MB5312:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB531256E7F785237D02B1122DE6379@DS7PR10MB5312.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jboPyc8+fQaql9yxSfQl4CbLSlyiJbft8xw1x77JH6LBTDcWcC1c08QFWkOwK17NN/HsTeOmG0GH2HHHJZKLzh5+t006HzbmG0nX5c5AREY3l+iQTnRPgZXq+uyKN/1qGwlLNqoF++P4aF6UcMXdBc5LB5AMx46Edz24Itrz10MtPsuzgYQMYNj+Zk66Nt8Ce6ja3EwxwDMhUomkdRorDNEbhM4XhXwTxbMieYeNNubAmb0htUYMDNHXIcndIBmv3kIWgXWrouD4kiMFsx1f0Tb6fBLawSFxQ2xQSYUEIhB0QqyGwJmyclVCrOIpYj2mhdDkB/6JWFe1ZMJzHSawfmqeGQuk6YmxEnEOvyrJ2KNFn3xuerprEAnhtHpPzOihAZ6Z6OCgKfnuYR68vkkXt5wNWb/F4Nd0f6ja+J72eBDYuwwo1ShzrMy08cWt0pGDLxFAfp95v4k4hkx92NktwUluEpg/YNdor1zOa/LvMfyD+BdjdjPVF8RhpI+5eR/ANDrG1c+C6QcfUyh6z3pURU30bWAgQuJzAoTJGaX5L2/hw6CVRFl03QPy5b4ln9CyF3wzWPufKcpTk+h7k0PmmY7G5HbaqRQ3AdTPTCuetWtLEMz2zJvVB+ylpY1zV+gnQfgzGKk/OoJ1uCtREXqfJrxQqAOGLXnJSu01b2CvrOuKYKQGIMXDx8cgo7igWGA4DJRk/cl/eey8RUQFxNQnWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(26005)(186003)(8676002)(4326008)(38350700002)(38100700002)(66476007)(66946007)(66556008)(508600001)(2616005)(6486002)(316002)(7416002)(36756003)(6666004)(5660300002)(8936002)(2906002)(6512007)(6506007)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D9KU3biqQN/zYw8Q+j/rFpiZegiclc8LTzmsn65FaiNcrOiDbGPZj+QV2b/i?=
 =?us-ascii?Q?Z1PmTS0pBWBNjph23yJcZzcAXF9mpcuTcuegnPA0Z9Honk7l1V1hDR22z6Z5?=
 =?us-ascii?Q?+2dASen2+MjzwezQWGCobY8l0/IZWq6OOJPeKjFUjGUjobBUb/AK3nbPq0P4?=
 =?us-ascii?Q?iju3FuLufo70t1itXbGV+xMsGwq2ozzyrZM3VyPPcrnFGUEhBu49HSGbKHc2?=
 =?us-ascii?Q?qMCW4jXo5ykK/Yh8OTI86M4UQtlAC7DqxjFPKMYffAiNgwiH55IV/VeLKOlO?=
 =?us-ascii?Q?0lwu3qLA5IsQ3SO74OmUmgUNvxzNSGfz1dfkqZb7RlyI4ue/qKl+9D9hO+xs?=
 =?us-ascii?Q?t2Z94guevEr5PX1xLg3lzJ5fZsCFd5Q1rxJXxoOsHwUYSdPEDDsBoHrpeg9j?=
 =?us-ascii?Q?9jbicBsWbc8+Yg5VQWTI0BO7la9kn0EGSnXr3IM6lABdfU33/v1DU2K1lWRs?=
 =?us-ascii?Q?CSgaKxYoF63lcC7uZbyc/GuHgGA0zijWe8G7tL0bDIDf9kEk6lKGDOq8h/ME?=
 =?us-ascii?Q?wsAEbXOuMX/odRNujicTxfIuZtopLc7B7fNziTRM2DURYWV6aGnURKpl9N6Y?=
 =?us-ascii?Q?oSEBsAxncHdbUeUFSuSsrp8RSaQFNaWCXz09FqIT3EwSZbPe/hnNXkWZcAtD?=
 =?us-ascii?Q?Hjylv6kg65Vj4FLq7DMTfdelKsHiX8/IVhkEHViJgrK+zzOsfR1zR3WDQl0p?=
 =?us-ascii?Q?fQDnYoWP00KB3tBLxOOlUtiCbrwHipHHk1ulFSAQnmfaBCi0XeONukjiTFI5?=
 =?us-ascii?Q?CSdZgKqtAyB3nhXT9K8gIBZ3HoMAflL8ifc7N7r0HebsOAK93VfvsXtSi8W3?=
 =?us-ascii?Q?BzM0XaFyFcVV955vX4L6CJGAHIiM87ClzuQ0GXrvmWNPPYsKN01EZ6nvCkqt?=
 =?us-ascii?Q?ue8BXo3yR8kzjXi13N/Gca7dWDTmLgvreP4PwXdrNu8R0axXJIgicqAxzsxx?=
 =?us-ascii?Q?HYENnBK8Q9DUOaWphHO7PORGjJ4IYky27Hr7FybyiSZKrIX/xM9QaEEB4c+S?=
 =?us-ascii?Q?gbHumG+Es8Ttq4rC/x2zLK0O1WYSmzhx0fY5H5zE4tTOmYLfiV9TZ6s53R2C?=
 =?us-ascii?Q?G+xHji9f1/fjK6Mvrkq2Nc+fIANhOuiXNVxx4+MosrQd++pWhMmLKfze2+2T?=
 =?us-ascii?Q?qL4RGnkV9VyqxmTFMuZHzBlOkdu9/e/JD59z5XtXjQjzUYDIzy9I4JklP6sp?=
 =?us-ascii?Q?NjqN/Oum+hCnJgU+chnqZNiyRlsBGzACE2zy1DVmFE14Emhq2ewns1bVnt+L?=
 =?us-ascii?Q?UXmbD5DOA35OENOG1bd4DGA2NHyozN6JYDcUFClRWcww0DXQLr9JNTv7zrzl?=
 =?us-ascii?Q?Rq3L7lQjBCl8CO/AF5rN5nj/tBUQX+NhTSOxIC8ij6pyAjVmPny39KkR17tf?=
 =?us-ascii?Q?HPa622k6FpqF8oyHd8BLkF8emGtvg+ck074gXKKlTys+KBO5KgPsSiBU4gf4?=
 =?us-ascii?Q?NshILdM+KaAOn5cilslFxJzJ4C/H6tN8XGlaXDdVrpTrGOvJUAkiOnZpnavt?=
 =?us-ascii?Q?zzK/zvxT4h55yB/0VHJA92hLBBxkiMLl1wiHQ8SmbKHcM7qSJb1m6DeQleHH?=
 =?us-ascii?Q?vUmhhf4rmqiHJgTvMWI1xCL1jaIUhwNWqOfvyYk2jg5Sr9KZGn4fBncMVsx0?=
 =?us-ascii?Q?roNW5aHDGo6pei9TC91Sfwg+KiSEr2siK9AdkDku4atfgPQ6hQHT3erVLscD?=
 =?us-ascii?Q?HB2Zg7zUJCGMwgmXX7os7qwbA+U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e26aa3-f06b-4d7b-c2e4-08d9f2f775fa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:10.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASRzh8z1WTAuy3yyhKJ58whhLmktEB0WGB1+XbQ3wDfRl/7FAGyFhQbJNuYLA+Mib00hx/ujrPzbFwmqB6R/eOwQAHlDo+HjQADhzewt3HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5312
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180103
X-Proofpoint-ORIG-GUID: AWs28MAe5RJ-Nqphnv1umh1VVXCsKKcx
X-Proofpoint-GUID: AWs28MAe5RJ-Nqphnv1umh1VVXCsKKcx
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Initial bits to bring in Secure Launch functionality. Add Kconfig
options for compiling in/out the Secure Launch code.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/Kconfig | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41..3f69aeb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1983,6 +1983,40 @@ config EFI_MIXED
 
 	   If unsure, say N.
 
+config SECURE_LAUNCH
+	bool "Secure Launch support"
+	default n
+	depends on X86_64 && X86_X2APIC
+	help
+	   The Secure Launch feature allows a kernel to be loaded
+	   directly through an Intel TXT measured launch. Intel TXT
+	   establishes a Dynamic Root of Trust for Measurement (DRTM)
+	   where the CPU measures the kernel image. This feature then
+	   continues the measurement chain over kernel configuration
+	   information and init images.
+
+config SECURE_LAUNCH_ALT_DLME_AUTHORITY
+	bool "Secure Launch Alternate DLME Authority PCR"
+	default n
+	depends on SECURE_LAUNCH
+	help
+	   As the DLME environment, Secure Launch by default measures
+	   the configuration information as the DLME Authority into
+	   PCR18. This feature allows separating these measurements
+	   into the TCG DRTM specification PCR (PCR.DLME_AUTHORITY),
+	   PCR19.
+
+config SECURE_LAUNCH_ALT_DLME_DETAIL
+	bool "Secure Launch Alternate DLME Detail PCR"
+	default n
+	depends on SECURE_LAUNCH
+	help
+	   As the DLME environment, Secure Launch by default measures
+	   the image data like any external initrd as a DRTM Detail
+	   into PCR17. This feature allows separating these
+	   measurements into the Secure Launch's Detail PCR
+	   (PCR.DLME_DETAIL), PCR20.
+
 source "kernel/Kconfig.hz"
 
 config KEXEC
-- 
1.8.3.1

