Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB2A645FAC
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 18:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLGRNf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Dec 2022 12:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLGRNe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Dec 2022 12:13:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0745A29;
        Wed,  7 Dec 2022 09:13:32 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7HATiH003855;
        Wed, 7 Dec 2022 17:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ba+u0gbcbdGScWkTXmCq7GRcXOr17wLnvQx93FYNBLE=;
 b=yQ1vWqdZg7EpEp5cADc8g+IYCZmwu3S9FFxK4MDPEzgaGVcfrgR2NXJIuntAUcKOpCSx
 +2kFzIZhSwSJVJtDBgcIedeJvVMH1sIHyYAZJLo5CMUJWuSWPm5RtluLD3D7vpofrC2j
 wZK3NjfTLEU85DCMNUAQstqmjbskZSYc6Wn4azfddrPHS84wkkl6SNyKmyb9eLHazrjP
 V8SQNMGaWIZWq48C23743VEDQ+j7lflkDUjW7zC7zRPVkdChEZxYbVaOEnyBpOdR9Kha
 iHkfgLRqBU1lydf4aCVAyyWpsbR04s1bLHRpH0w389kw6OWQcAQXdIA4FdGywISuLS5c aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mawj6r0bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7FwbQp009733;
        Wed, 7 Dec 2022 17:12:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa69a430-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:12:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GecwC0kkmOJ1UXPCspC3Ih3AgoFoNGCgy5E3IQYmyr1s9nsDLIGrISWQAcRxB3xnPxH5UvO22QaEsplx2JGIpD+uz9L5QYWds0vzjNnMild21AQkZ0sKqgydNIygHpSS0FzWvBD3UODZi+ezKElHN8xiPNljUBbkgWatGL++Cr4Y1TiMygf+cWFgSXK3kN+0fmt7BfHU3qtVN/YW5cgL88dQLIqIC2oSaSLr3ysYKrBq2IBpYU89C/TrsrqN7V9ut6KvCUGBqt3LaD9AlNz2OXylbVlfEv8JQa7kgDgZ/o8gM30vHPrSHDZyyg+z/XmOwGQU7cnv8vfCeWKQGdRTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba+u0gbcbdGScWkTXmCq7GRcXOr17wLnvQx93FYNBLE=;
 b=hfiIAaxRy22cz4ntFD90/2D1xT7Bksgw+W5xdcJZef9VsJPQ2kAjQ++X4s8F6ueQiwO3q18mCEgwQMr32CsBlgM+KF9myFjeCdMtN4OxWisquPEZCK4oTpAwI8ejNic+9kRsGcY1N5zbmFoeBMO2ZhPLPKMR3iklgLY1tPCKNceVs2wwtijvvFWcKhz9BldKZmaJTImBU84ClXdmDuTt52pcwqgH8RpgkzwGWHNWXomHQJ27fm0MVrBlsm3I/R/cLODhL+ErEeHeDs3MAyZCNAT9KGeAVOr6Fl28LdLqKwN0QMFCNovwMWm4yQ6sjGAQNv0u2gmpsCp41P507wcoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba+u0gbcbdGScWkTXmCq7GRcXOr17wLnvQx93FYNBLE=;
 b=kJPIDETAkR4BUfktzATrv1ovvklsqflC8AdeEAfJDa5sdnmUQzZCfedihD5yqB29Tb0PcB90EZeT8LJ4FJbwdkGfLaj40kvbsechuV8nfhaQ5tiot0Y/P5Dk43l02IjHe0il4fJnxIBi6q+5iQEPnbZ4oN7gBar3mKoGbzbISuk=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:12:44 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:12:44 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        bp@suse.de, eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 02/10] KEYS: Add missing function documentation
Date:   Wed,  7 Dec 2022 12:12:30 -0500
Message-Id: <20221207171238.2945307-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221207171238.2945307-1-eric.snowberg@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: e92b6910-e9cb-4858-a916-08dad876415d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Sn2zFUao8NEhLxllNk2n3iCjCa3zbeaOms2wrl2MrZzcbG5zFaUFNCyfi+aC8EIeKB8LRAxYwPYwERjYPh4+aZv3hSsdqlhrhJ+HvozpybP+lNC4/l4bx9XeXcJJuxa3lhQorsoenzirqmtVVtUVgqyQ6SAbvnry7tfXlD0Q1Nc1TmpfZxcJzIhFCGp4CdIG1Wea12GlYp3pTvzVlWL3L/xWcXdeWieDgd53hD1FfbXCFLwG1dlVwRib7XOVDdrlmB2ACQ5MDJyQ5swoBMZtGmcgyqp5jcHwSX8e8zASDRZCSzAi+uS3PMF+Je2VkQ5IbpP+YFSnApqC9Bx7JPQM4QoRalbNR6PsFcoW/I7kwNv4/kiyk0ud7+zT6wXz7Joa+f548TjuLs5lrLFA9QHWnwvmyT0s7alDaVkWwt/23GYYbJm7FUv4PS+AepbgfW9VbAIzZbVj8j79u0eCTBxA0TUxxq+bWv00XWJAXsA/VjkGLO5LFtuUN1Gv7+LlDWGBc5FSdPxcVR4nIH5j1gYKzQ4dZ2kE/N4Wf9zHKcehdvaiq5haQEO7fE1sA+C4FuWua9jszR7XkLqDyDriPJ89DKPCDrXYUHPfBGeYFXAV7H2rP3Di573mqfpBnlQ9Lhk0tg2pxA9o7ZPAiZ51adjRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(86362001)(186003)(2616005)(1076003)(8676002)(5660300002)(66476007)(4326008)(66556008)(36756003)(41300700001)(83380400001)(478600001)(6486002)(6512007)(6666004)(6506007)(316002)(66946007)(2906002)(7416002)(38100700002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s9KZVafvUgvnV/b4kc8aTSDNn+EzVt3yNlg9sLeLwnuTS+1V/t0Leil5NZoG?=
 =?us-ascii?Q?JM9ahrz8/F8F1LvCJB/ltUw+vAfSuyOHvJ2mRqCVEJnq3L1XvsAzK/X5AzYm?=
 =?us-ascii?Q?xCUuNjCxOutaq386/eC2qSpcxQbnxhJZ4KYzXSYM8HP9KSaU/k6kUYzYPqXe?=
 =?us-ascii?Q?L5jpK5W7Q1OIIUeG+zt3xOWyVSAQToc3Sx+1ILj3hdIPoouui9UY0P/FbI1C?=
 =?us-ascii?Q?kZXxxcUNNBiMw55lRPxCqPausdlcY+p2n7id3vWjaQSM4B4rzF7pg1TvfjMM?=
 =?us-ascii?Q?rrPXbI0VLnUso341SO4QJnEIVv/VncU8Pz6EqXUwLvsFJZV65X1XSR939HNf?=
 =?us-ascii?Q?6THaOXluj/HUrRMuS7W4UfrDsLg9TjHajNyh5rQpr2+xF79TJK9IeJXtiohG?=
 =?us-ascii?Q?aHErlOC/F8ccmT+5R9FIiQGI+8BlzvlN2ez4kiA2tTkzPTgiWWQZDKwR2VDY?=
 =?us-ascii?Q?VjT/4xXhPwUzgJG004uxQzvOEZdxFzmIxGHCGA+/RDgG27lsynnrjaeiuhn9?=
 =?us-ascii?Q?XmDpPcdT4n0fsey8E19LH7JzrY6FCRGG7TrzYSYrZygXI1sk3A3eFp2NE7jK?=
 =?us-ascii?Q?AR/HoA1nR9RRONfOagTTHJDlfl0GYZ2t/vCbaS28xLlZl49TxctgTDvxqRol?=
 =?us-ascii?Q?AMhoSNFhyy77gApyXzDkMqzqOUrQtNX3BH8BQk1ScV10hUMjpQZpKM1ip+S+?=
 =?us-ascii?Q?5idlpZSCxgO9mRGp1ujTp+dZHkGW0OMMvkKn4n7jyKHLECJtPgtxFRKnpgO6?=
 =?us-ascii?Q?FhqmmOlleB9P0kvdLkB9E/MXZC5Yrout2XL5c4uGoDWDjNbnO6gTMGyA3rVL?=
 =?us-ascii?Q?X9XqwFiG2ltlV9FuGqTd0+qUfLG8Njy7JOFEwfs1midDp+ScZvpWMQTl0y9I?=
 =?us-ascii?Q?r3uZmgVsGGYkmw1ObXWE6vTzLkAEe88DJ5sTJqWK2S7ptaZJfOd7m+E6umSm?=
 =?us-ascii?Q?3IBIeqkfU5as0VByuE32PzndtOYDhF2LUntW0N21GQdgsh7ibTPwjK/PCJUJ?=
 =?us-ascii?Q?aw0dDlIJQ1KqwAezUmOtd+eCR0LqFNXtE+HPrgTzrB7I6hcfNXjhK6JyDzvv?=
 =?us-ascii?Q?ZD9anK2QZkN2of/9FpVt5mNBwlxd8C8E9yGW8GKeRPB8ZZw1BrXLwghtUBiw?=
 =?us-ascii?Q?TZGq5sPNxc8FyDO4xqXNMjGDHUTyocvbVqgYYYQMu7a/4jEB+xQKGlRvYhXp?=
 =?us-ascii?Q?5CnUewiVnz4AyFBrYQyI49JzeMZrRb3bb1BIdauGX0ZYgFli185wNCWcnNP7?=
 =?us-ascii?Q?hkucHy4UAsep3hmc8B/DtWr3bZW1z6lvgaSbjoQD2BvdaewOXo4O5S5KTO0z?=
 =?us-ascii?Q?PZVJpVF9CkTNf3qXQaCwqxR4q9MaDuYZCkr3b9WS2jzetS+LyrXnFDU5ilOT?=
 =?us-ascii?Q?YRwKA2wpctPIZqpPksL83GTlVIORnnt/KbZwdd7vdRqI5vw423xoTqasfGhH?=
 =?us-ascii?Q?KsIZ5liO21FYMfzmlkyLZ5I0spdPxr/Z0K2OebaXmYW+CfEpcCoLLCC3tHQH?=
 =?us-ascii?Q?/Xd7uPGu9iSUjqPftVe/oYbcLA64MeYvMoibPuA138SDq2V5fJfo3xPEcKIc?=
 =?us-ascii?Q?EyPsdEw1HsNFUaCF7ksXfYUj03LYnNbeZX3l+9BRVr6HfbHamVgCMWlEvoUf?=
 =?us-ascii?Q?EJ1akvhRcmldO/YaabyjgBI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92b6910-e9cb-4858-a916-08dad876415d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:12:44.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRxNUJ/4W/0PaImZSjZThgwPenv5TjnNf7IwyuXwAKTqLBzaBhdaUU5oavQuq1Ff+8viu49Yz0BM2duV4O5U+kX9KYGm4INYzd9gmn05c88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070150
X-Proofpoint-GUID: TZMJXBMj5RoaNWkorOTnKHJNiPOq5ykg
X-Proofpoint-ORIG-GUID: TZMJXBMj5RoaNWkorOTnKHJNiPOq5ykg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Compiling with 'W=1' results in warnings that 'Function parameter or member
not described'

Add the missing parameters for
restrict_link_by_builtin_and_secondary_trusted and
restrict_link_to_builtin_trusted.

Use /* instead of /** for get_builtin_and_secondary_restriction, since
it is a static function.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 5042cc54fa5e..250148298690 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -33,7 +33,11 @@ extern __initconst const unsigned long system_certificate_list_size;
 extern __initconst const unsigned long module_cert_size;
 
 /**
- * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
+ * restrict_link_by_builtin_trusted - Restrict keyring addition by built in CA
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @restriction_key: A ring of keys that can be used to vouch for the new cert.
  *
  * Restrict the addition of keys into a keyring based on the key-to-be-added
  * being vouched for by a key in the built in system keyring.
@@ -51,6 +55,10 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
 /**
  * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
  *   addition by both builtin and secondary keyrings
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @restrict_key: A ring of keys that can be used to vouch for the new cert.
  *
  * Restrict the addition of keys into a keyring based on the key-to-be-added
  * being vouched for by a key in either the built-in or the secondary system
@@ -75,7 +83,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
 					  secondary_trusted_keys);
 }
 
-/**
+/*
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
  */
-- 
2.27.0

