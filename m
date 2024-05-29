Return-Path: <linux-integrity+bounces-2702-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9E8D3E3C
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 20:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D872DB250E0
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ABE15D5A8;
	Wed, 29 May 2024 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="XuBNdmhh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2093.outbound.protection.outlook.com [40.107.21.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF911C0DF1
	for <linux-integrity@vger.kernel.org>; Wed, 29 May 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006728; cv=fail; b=ikzm+gxIoHwx65qpq8S1dopxfeF3NfDsVJ7opmCgZ187y9UliFKji4NCu9MmbYYoexDIuVF68VcdVVkjFNumgEc7HNNqhxV9n4tIXIMqlAwgrcT8M9OJCC+qMnTh5WAtpkKek96txj1RoSd+5vaH2GGo+qMA59chSsSnEC9Jo2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006728; c=relaxed/simple;
	bh=sdBKJLKQ0kaisG0BqI2PWVrKXE80RkTyzqn9kt4bces=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PN/lLmRnyXsQ0xI2O6Gj4XTj8LpQBMUOnzFm+SJxh+zvWXnhNEiF0nBuILKzIFarEp65xYPCS737ApsMXvA5V+5wAlbwBqELlmzdjt/zRzgjbbMLNVygSF95ZOUgy17/fz0t8Ilv+Ti+kJE7FvVNaR0zI5pDtDBLEwyOVA2wsao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=XuBNdmhh; arc=fail smtp.client-ip=40.107.21.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRMe/QwSsAKG0kgOyiht7e/pd3kCp/MEXMyi4r3j3c5AOQzwoh4XUbl+Z+fW43E9K/rTwMfgnIlXWW+b8uHJwYRutOKr3IdesHWy/d/ZpjL/VreBpGj4INcgYyJyQHfgDioQg3WCDPkrK/0CJGVkqsElwsOK8pn14YSjUuZJUGZvHOw7ff6kj9H1k2bkwP3pwsBRPkMlvPNnrkTlRc9O7EWYFY1x/z6VJTXJ0MiJM0EgHL/qaRQqwt8ooClhBbnWyeUxfV6uOJqgtHGe5SS/wGi9n2JEMWazcb3sg8n3yC//sXBPTgQkC2hYhNZ0djceXyh07Qi1F95Is27b1QP+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiwxW+93UNUBp5G/BWtGl5BQjoMp3x55k6o05EWEVtU=;
 b=A4r/7Y3Bp7ZNGvMQ5/lUiXkJxW3yZzK+Ggc6iSW/rrfj0MH3RB0zq2mM+hbxxM0grspDEPlWbzbSgcAxu1Io/w13Hs8k8VF+vcZlOUDOZiwb27zWq98dvMo7TjZkoXXAecOCxblUBeI11AfRP3rozz0x5MmU1tSB3QlDEOUe/PJdqwuLDKex57hwbzEQhMehNr9uGXxtqmgRZ+Aum6EZb+aEQCjuQMV/N1K44aV0wwHFEghIKO6AmkU4E/WCKaWz//z/tgXttQ06NbL7Q9XhqWN742d4O1ww3Cqi3j3eYhBM8+5bdju1Jk5KM01QB6sr6U0EUUiPx/rnyUj/1rIvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiwxW+93UNUBp5G/BWtGl5BQjoMp3x55k6o05EWEVtU=;
 b=XuBNdmhhuAk9QzFwUlZC9eC4Oc7ByfTY+z7B9CErOd8HW1HZxTuL1rUBfAK5pOnFHuhGvgWVv67udyk/Pe7ahspidSbqEWuS6Tq6ik89oVfGWgBAoLP/0qwO8ToeifV6Swv0LAa6HQlppkHoAKYh7+Ev00gYBxVU5PdKsthZu2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by AS2PR05MB10847.eurprd05.prod.outlook.com (2603:10a6:20b:62e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 18:18:40 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 18:18:40 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH] ima: fix wrong zero-assignment during securityfs dentry remove
Date: Wed, 29 May 2024 20:14:34 +0200
Message-Id: <20240529181432.494253-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|AS2PR05MB10847:EE_
X-MS-Office365-Filtering-Correlation-Id: 559e5e50-c780-43af-298b-08dc800bc3fb
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|52116005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cSkstLpY6yDlXlF+0GP8JHEXBe4H1MpSJi5PRqbg5sLvvMUcVBlaPWHUFhK9?=
 =?us-ascii?Q?LBvOPCV4BEEvmFhgSItEBmXQVoDuGUiJ4ieVpczdjrOpoQZEVgHynULLVoiD?=
 =?us-ascii?Q?YB0ZktIp3B6/Vczwy4bjIGJIs0D08oB0XlaFgGOSeu2IkIJDNAyJu83hRtcZ?=
 =?us-ascii?Q?1ETHkRmq5e3RlBoYRjpUlt3zHDX6KPl5EP9ig5eKIX74EaFMEEOjE2nW8/bD?=
 =?us-ascii?Q?qhQP09cDT5QU09o9EHmaKIXMfFD6WCfVaeUPEISP7ATmZT5ziDjDGby+KD83?=
 =?us-ascii?Q?Sevfzi1nALhQK2DlaxIRfA1YAwbX7Y0UVrqj6/AyyT5IIa89v+ibQx9HCgpH?=
 =?us-ascii?Q?JDiG8Gr52bXkLBsk99fuDXZz6Yln+RvJDjAjEW2Boo9RWrB11UNGkyGp6nQu?=
 =?us-ascii?Q?TAntf+Cjfg/UYNfg86/wW2LVO/6eeVDXZW05yx5gpmKXgOHg3QoYygq4Mtor?=
 =?us-ascii?Q?CjNpRvwv/LBXyebqpkkKV+vCS2cFDYsDvRV6yywoZHWYQp7AFEcE3ifYQ0RS?=
 =?us-ascii?Q?5hTEF4CrMfW0P3dM39VGReL5SCH0NQ253XkKxEQLk0vVHlcbU2q890SVOy5d?=
 =?us-ascii?Q?w1Kokk4ljiX36d+77a4K5J9HODfuB8StKEiOaRA2sH4gVIrYnW9i/EKFIuSh?=
 =?us-ascii?Q?ZNcYXo31a9cqZCGQXmPeyRPXbEVvb6/cGoqGaBtt91g1n58h/h30KtxyQHY2?=
 =?us-ascii?Q?+xQrsoDHc156orqEgwOd9UeouUXhXDiFr82v7MVdb1xXzH75PUvtNFJPyUuO?=
 =?us-ascii?Q?fcD6wjotY6xgcOv86HJZMHTY0SkJypCQwcTNDZdS8r2Fbsb5kuvVV1Yzd6VL?=
 =?us-ascii?Q?jNDLrNr5OSOZ1pAjrii3nmYjc1uQqQpG8Y+xlphzwQJZLizaNWIRe7CG7LPr?=
 =?us-ascii?Q?GYciOYkT2neUPXt2rgc8SpEEOAINrOyMHCfNsoo/pZbnqXIInHytrQmbuOdE?=
 =?us-ascii?Q?0r01stgq+ueZz303jK6Nf55z4GwLOx86yvSmuQrGfnZjltFyEz/BWpjjKw7X?=
 =?us-ascii?Q?c5SUQIPJGZH0KcSUramHVN6xf5OWz/jnr5wzJU6W3/RVNoKJ6f/gYQ2x1ano?=
 =?us-ascii?Q?jJIeWbHqRHBs9qlnABPea1ElIyuFUCG6rYoc3pPU/3C/1OFizegixvMXa2YY?=
 =?us-ascii?Q?guy2QPrFuUGNVwGA47VtF8ZnxIhE1MteYtOYqeiKLro0moaQtWP80yfJ6I2k?=
 =?us-ascii?Q?4m70dcmP4Qj0Ey9xQAgkCCG8MeV5FWassQPO0aqceeJ0kULOlncnS7rui8AS?=
 =?us-ascii?Q?X4zo65CK9weF0SXsLf67BpyUwvbjXq58ZhChX3q8Ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y9bgJkd9DLDSxbbK+fPzdQAMfd4TlJOhwthHr6JBlOsAv0gV1lqIZgWClqvI?=
 =?us-ascii?Q?KdmRvlUBuwder0ngae0FUZEKEbiukBdQa34SlFHSBKsaF1v/R796sVr2PRut?=
 =?us-ascii?Q?DnWaKNF1JwMUyiXFLWhCj4B3hTv6qumtVyxwXcWN/P+At5qYczUjUVW01JzW?=
 =?us-ascii?Q?8lI9UQUSmB8Eacr2RCHlhFktWbxmuVZ2GIB/2idWUPAvvI9vrYpiOGsvUonR?=
 =?us-ascii?Q?OShr5B/p9y87tTIFBWazCa19ksz2Ve7vaENIp/DFFmpOLqAoR7SHl5LGE8Pe?=
 =?us-ascii?Q?6hBdkk/kJDGPekDTwMpwFPIVR99D5YfJGRXcQueyvv2eTrccUnyeGmezBa3Z?=
 =?us-ascii?Q?475pk3MTRXCNAkvGfM5YQRoe/M32VsAxYSEehxxohXJtYF+p6DJlDpwTrps/?=
 =?us-ascii?Q?JJW+8nkUEm4/90F/frFUT4PaYZAmCLNJbIfLKPkeBXrvPW3iNJV/oYd+lZOq?=
 =?us-ascii?Q?mmS25pXM8WD4N2jY/yiaWBnOjN0HtpA35aOg4dUfZjklC/VMykbyT6DV7tm6?=
 =?us-ascii?Q?xvsx+DgXPbwJsrzvcVH/QFvgvlY/Gc6o2XSTzSG+48aDl/x3t3FtDnW2+vc4?=
 =?us-ascii?Q?YzwK979RXTaRRKIV04lEnIg7goLmROZfPlz2Ng04pruUTi6sNeDYnDawNSPJ?=
 =?us-ascii?Q?Yu+FzSyuTv+h8cfrFcSdCyHMjyVGCmuOIw7vUIHsbJ4EczAfTBhNmxkq0Lhf?=
 =?us-ascii?Q?6edl/vFegpOMsztU/IpTmo9onOEyqUdNv2ZNwpgG+Rpqr7DKVvc580Kntw32?=
 =?us-ascii?Q?7Ezb+Z5N5uP5HUKuew7GDTsAWEQpZ2ib4xeaBqwppU9EZqHuSaak5nmEmuym?=
 =?us-ascii?Q?Bt+U3L5PcSbYPhBGbYteC0vHwHs2l0Hj8A/CXlEvaTS24+u7UbdH72vVIgFy?=
 =?us-ascii?Q?notEgzdaVZ+GSrbu4DGMmvK/kaWKuPJpgkGXNaNeb99mg0trGFyhkmXcv9ew?=
 =?us-ascii?Q?j55So58thDO7pyIr0BaYPSJxBoQD9s3FzioEbOk5Qxwv+krUCA9csvy+VnTS?=
 =?us-ascii?Q?zXkUCPQJv4mqhcjAG68R7Fj7DqBXDwuI6sfV6OjKCkq4e5cr/8wmFroHWgMN?=
 =?us-ascii?Q?ZiRY9jByd7Kr7118mMFZ8mAuZP64fb6pfpIkgAtAr8ggVL3lDA+p4FuzcrqI?=
 =?us-ascii?Q?k2PbW6JggEyvWRZOisolHKoDOo8wKxsy+8csCgGwGn8I9S/WZRpNRFa5N0xZ?=
 =?us-ascii?Q?17AngBBedHHc7aFt8SqJFUYyPi1AWCMcSedlWePs6ETB6NfmtEQm1dMc1w5V?=
 =?us-ascii?Q?D2JQ8uc9TvPz0rSlo8ge0q3BAnHT9fgLxRRPPicG+lSEl8ocpASoLiL5vJrE?=
 =?us-ascii?Q?AOELB0Uy2Nr06rTMfN9aeB9rNKsa2s/eMYXNObb4Og97yxFQcY1bhdXM1PED?=
 =?us-ascii?Q?hEddJNlwxs209fNV8Kbd/t+mBMe3XmIBK0lJMSFW3MDev8GvlktUzrMTLT26?=
 =?us-ascii?Q?+G6LT1d+bTx4T+0zz4M8kefnn7gdFv8wsZUdJw9Ruho+pD5OKVOMmUdMWpWq?=
 =?us-ascii?Q?EXdHa+sxW2YfWKLkuUe6OXRXLMcjbz0RDfmjL+7HkAJgmlQJZz9QENPd0F5K?=
 =?us-ascii?Q?p4K+Hj8+eeRryAjYlMZwpBLog1r8f36/4El0f6sB56/ouOHnIU/0fECChgWv?=
 =?us-ascii?Q?v1hJnVsZHIZ3R81y4TCbQgPuLMWi82s5WkYpWU1xnrWQirO6wJD95rImVdmg?=
 =?us-ascii?Q?+t7VYw=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 559e5e50-c780-43af-298b-08dc800bc3fb
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:18:40.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeHn0m8brv0vTDWwnJXebygsZMIjZZhY2UY3KP7jdYZGY/UdLra9jLE5Xuw82D05aloTdwOz/6leMHGzuGzyLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR05MB10847

In case of error during ima_fs_init() all the dentry already created
are removed. {ascii, binary}_securityfs_measurement_lists are freed
calling for each array the remove_securityfs_measurement_lists(). This
function, at the end, assigns to zero the securityfs_measurement_list_count.
This causes during the second call of remove_securityfs_measurement_lists()
to leave the dentry of the array pending, not removing them correctly,
because the securityfs_measurement_list_count is already zero.

Move the securityfs_measurement_list_count = 0 after the two
remove_securityfs_measurement_lists() calls to correctly remove all the
dentry already allocated.

Fixes: 9fa8e7625008 ("ima: add crypto agility support for template-hash algorithm")
Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 security/integrity/ima/ima_fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index abdd22007ed8..e4a79a9b2d58 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -427,8 +427,6 @@ static void __init remove_securityfs_measurement_lists(struct dentry **lists)
 
 		kfree(lists);
 	}
-
-	securityfs_measurement_list_count = 0;
 }
 
 static int __init create_securityfs_measurement_lists(void)
@@ -625,6 +623,7 @@ int __init ima_fs_init(void)
 	securityfs_remove(binary_runtime_measurements);
 	remove_securityfs_measurement_lists(ascii_securityfs_measurement_lists);
 	remove_securityfs_measurement_lists(binary_securityfs_measurement_lists);
+	securityfs_measurement_list_count = 0;
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);

base-commit: e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc
-- 
2.34.1


