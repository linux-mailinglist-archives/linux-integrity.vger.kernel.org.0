Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D903655AB6
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Dec 2022 17:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiLXQ2X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 24 Dec 2022 11:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiLXQ2W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 24 Dec 2022 11:28:22 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2138.outbound.protection.outlook.com [40.107.7.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B89FB7D7
        for <linux-integrity@vger.kernel.org>; Sat, 24 Dec 2022 08:28:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOu1diWn2KiXTWvr+YTqNQwrdF1puHIZWsc9wgv1ARxq0bqC7IY54/xgNEOeqWBsqM1F+VSN6viqEAqhM+knRFiFiOOKh+hVXDdRJ9QsxwVSa+eIDqFKCgpb2vu0cBLUWUj/kkyjAkR8yBYtS1136W/I9gtB1M4OOHjgmo2FQMBkCAnvW+q7z4dnTHDb8IJFrbhbj1PisI2cAUYPvxn0dWKQ4AjUKh3Y8rsRC0IXsn5QuorT5p7wlDFXp+da5EujPg6AsezM0vFf4w60XFnZ3q8Nfkxon1jrsU2OH4Fl3ZHpT5uMgqmCWRGUoZEtTq0Q61obU6zHXh7SzsZfP2VEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXjf9ekFpceVmmc8zj+BrD75NATQn+3wyN++0nhjbEI=;
 b=erQP5bn25efFleSp1UNxF7ZFboYUffjDdgEVs79iWe+99yq3b64SZIu6IB8wR92erjw1hhP6wo2wVsBWLeb3RxSzaHtMxwpjK4aFiELzUuSzCJK6wYpIl8TTVTPlL/IcNMEJxhVJzIjYKbF4NEk6/8sttKxWeAAnQJ+y9S1NREVEFF5oFX8YkSOrKJE16DRyXzEAFp8VeHMNRIvKwoDT5mtU8NKzpQ3pJmWY/IiWZVn1hot53KcBgBa01+VTRa57XkQRN+uIR0oufbQ9p9oAeb/zATJ7dwmjMTro0tYwx/h8VeTNx46/hESnE5HA3o/jsxXVitjTg7Q54ktqboP+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXjf9ekFpceVmmc8zj+BrD75NATQn+3wyN++0nhjbEI=;
 b=UkdWkbz97VSmTKcOYsUqaUeyViW0F6jJaGbxK7Y3UVa3OpA/70IbWlxtnggF5dcmmQZ/Xaw/LrV3QBtSsdSBbXeSnncslil3VgiFaOuv+hGfE/Lx5mdQSQJ/0AsT1ODuLuzbpcaU8zqvQp3MOEAKT4XRGv7ZnWmCpdF4f9Ip5c8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from HE1PR0502MB3612.eurprd05.prod.outlook.com (2603:10a6:7:80::22)
 by DB3PR0502MB9947.eurprd05.prod.outlook.com (2603:10a6:10:42a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 24 Dec
 2022 16:28:15 +0000
Received: from HE1PR0502MB3612.eurprd05.prod.outlook.com
 ([fe80::1b06:8ff7:72d4:6ef0]) by HE1PR0502MB3612.eurprd05.prod.outlook.com
 ([fe80::1b06:8ff7:72d4:6ef0%4]) with mapi id 15.20.5944.013; Sat, 24 Dec 2022
 16:28:15 +0000
From:   Enrico Bravi <enrico.bravi@polito.it>
To:     linux-integrity@vger.kernel.org
Cc:     roberto.sassu@huawei.com, zohar@linux.ibm.com,
        Enrico Bravi <enrico.bravi@polito.it>,
        Silvia Sisinni <silvia.sisinni@polito.it>
Subject: [RFC][PATCH 1/2] ima: created new ima template ima-dep-cgn for OCI containers attestation
Date:   Sat, 24 Dec 2022 17:09:13 +0100
Message-Id: <20221224160912.17830-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0063.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::7) To HE1PR0502MB3612.eurprd05.prod.outlook.com
 (2603:10a6:7:80::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3612:EE_|DB3PR0502MB9947:EE_
X-MS-Office365-Filtering-Correlation-Id: 26890170-c3e4-49fa-70bb-08dae5cbdba6
X-POLITOEOL-test: CGP-Message-politoit
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DFhjr2Lv4BbqbVP9T/yk/0AkplOVUvayLjYgoL8QediCr18TOJQbKBFCBHJnauv7o6H1pes3SbNJ9Em5lKr1rEpxrRN33SeCRl6tDqwvui9meISFffPpVL8AD1xWgjr582hcA+w91n7OdHg3Qd5843IOfu+cdWHugbiqWFMVbxgbg16TmHpp+0dfxSkOWZa9gCi2gaPTqS8RcLYaauN3Hb39OfSi24ILEM/2K59RMiqhEQ4ylCZcNL25LupbVDzmFAJHVvqz0ZRJqhK+Z4PRuduGiSQpS+DvPkLAm81FxmnoxcQ/InWfFS/p3vTypeSrN5jqoikOn4gUep2bmJCuTFQqudO2Ja11AWLEJQyX8538hyIjwf3lkWRgeoZw1xG0BAjPkO8TrlqGIXLzo4kW+p0Xh327NzKV/9okr2M2NRl+837UNTgo33N08OpR7FT6ojZHXxf+kS31fDDFO6b81vy85kSBMrgQYLB94NP5CSioOeb1ehwRSO/k78AEI0PRGkLHq1o+34rU2x19vX4Hdeg/KpVw8uiDePMZ6Sp7EPAioSMVJgcgr2qRpltsrxzXNweNdpQ4bpmSGihvE+e5yQ/AXO3fKHTi87Vm7Wy1D+SgtXcBgbTHfx1Th+vVuHwanhhT5PXlUMvh3PaO7QWLt3R9ylFXUYpf0kg9qE0DPJSCAcIyFYCJFsT2u1TtOog7aJuTiFhBCAZrujrDv7WKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0502MB3612.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(39850400004)(136003)(451199015)(316002)(41300700001)(66476007)(2906002)(54906003)(86362001)(44832011)(41320700001)(8676002)(5660300002)(66556008)(6916009)(66946007)(4326008)(786003)(8936002)(6506007)(6512007)(186003)(26005)(52116002)(38100700002)(38350700002)(36756003)(107886003)(2616005)(83380400001)(1076003)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GD8wORatbgyiq7wTJLe41CM0xE9ghISDDq583wnSb7Lu5M8qi/oLVtvXNQBD?=
 =?us-ascii?Q?30nWfoMsXATy5UUmmcqPuvRLp4YjQzNaB2lzRxBU/e6kgGKtliv0kxAMEho9?=
 =?us-ascii?Q?JNegasFPEboY0d+YApgnScsJBxTtFsOLaqkv0KKkLePrWtlRQ4WNWNrkIBtO?=
 =?us-ascii?Q?k4koxsaDj25q/8/K42cGtdPrpFDbk8DoHOfB8WLE84xGbdscRx1+ocIhUB9Z?=
 =?us-ascii?Q?U3G5R/4QoCL0pQJGTlz05J7MSki9Pk4fKWi8PZeC6ueVChQ+oNVgczLc0+MZ?=
 =?us-ascii?Q?LXajuUsVEgg9FvAi3vJnxKQ+P9U8WVqnuuPkQjrtHY11eiwkJu2j8rEeI8vr?=
 =?us-ascii?Q?RpRAkdOG19gywd49G34tGZahC80mc5wto2TVjosxtxdVrnUlIN+fWJKmWDKU?=
 =?us-ascii?Q?aBUDqjAxOd1FWhSD1icl9YmNbd4tVhu8DyTQxKdp6Qhhdwj7h/lOrAYlWUn5?=
 =?us-ascii?Q?hEvdHogi4q50utM9+gjPf7Fd4okgB6wvhDNifWWDKCV54vA3QowMPOyAdcy+?=
 =?us-ascii?Q?rOoBfMWU0/srvxyW0p4McP1onMxx4cBw4K0TTslgvjnWGKqjjLkZsOvYhPk5?=
 =?us-ascii?Q?xExnckrijNm5z82vsXX/ciBNspBvOKcgX2Yfl4FAeeNpgBx1e4hUdWSlO6xW?=
 =?us-ascii?Q?OddFcaPt5FvjBipVbbC86ZEiP15zSBD6eTMfj9zGYh1OuoQy9AO3yvOK8yJ6?=
 =?us-ascii?Q?sUPf3vsTlEUBzlT+6eNiKTtyyxbuDLLGfiQcSTH0TOIXe3USjEkRzLtYeaB/?=
 =?us-ascii?Q?x8lw4dc6TATUQMEW5eqVNg4JEVLK9Pq+HXMQDUxyJJU7YuOpR4bl3rrOgNw6?=
 =?us-ascii?Q?PUMc4GCl6VE5DklD/pcdZlGCYUX5P25EFvLxhEl8TQrcuF7oBAC8DGdGEzGC?=
 =?us-ascii?Q?4WLDPz+Mckdjlm1KFMZyeiHJI3ffocJvZITQLz+NE3MHi2BaSP+q9U1URHNW?=
 =?us-ascii?Q?xktFtLv9OKa8sbSNJw2/fgCE3yHAcbZ9jixaxy+Qk1yl99GPpoM/lge1ELfU?=
 =?us-ascii?Q?BaOlnCNRTiVhAGEsx4Iag78Em4flYQs5ftTA8gudZyhBeVWVmMgePIrFHFkq?=
 =?us-ascii?Q?zclHDdlYh38pA/JiVaDtbEOl3A2WbPhcR4ppzZFB80QUpYVurdiUGKJpdQRk?=
 =?us-ascii?Q?gfPSJxIRAJeoweghqBCafKdnYhhWIzDXlObJ2LOTWQgXJUdb0NJPOu9MtIPx?=
 =?us-ascii?Q?8wR+miqe5M6mqyPipRtS7zFH91bKRz2q5Ws/FcYjo84II97CB2wn957kimhn?=
 =?us-ascii?Q?QGs7JRiioy9QEhfObfyukE+YoyE3F1AUNsaB2dO7Rvz2yCImVkgV7e0d4PHN?=
 =?us-ascii?Q?fN1kjNXlPHlG9Tm9AsDM9TdNQMg3snHugtpTSE+qHtIGSIbzUPtf86qnOyc/?=
 =?us-ascii?Q?v0IN057xz9s7MPerP7hHDiwhlr1mZ8tBHOcXPVuplJcl6YPw+ODBUTkZKDMw?=
 =?us-ascii?Q?zS3OeBzpNHPXxF63IMxbU7IW9QmyZ2Ey+USMp5fAII9fQ1+0ZESTEqUsj0X5?=
 =?us-ascii?Q?LSeDjuqtnGSq79y0dMy1tob53vn4noEDKGKDykOZxOgNQbjt5uGpNdhKaZqr?=
 =?us-ascii?Q?btQ2dFCei3B5FDcjoXpGjDQxKwK2Hyc+RPFRy9Ik?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 26890170-c3e4-49fa-70bb-08dae5cbdba6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0502MB3612.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2022 16:28:15.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/ALwUKcyghoEgFgWO0V2JIEpfuipLa1lKoIOMho0l2yeWlpIsZna5Hre/faDuNZxxDcc/NA4kmIlfQxssbHlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB9947
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Created new ima template ima-dep-cgn (dep|cgn|d-ng|n-ng) based on two
new fields:
	- dep: list of dependencies of the process that generated
               the measurement event. It is the concatenation,
               column separated, of the execuatble's paths of all
               ancestors of a specific task.
	       For processes belonging to containers, the dependecies list
	       contains the shim process that manages the container
	       lifecylcle. This ensures that a specifc process is
	       containerized.
        - cgn: the subsys_id=1 cgroup name (cgroup_name()) of the process
               that generated the measurement event.
	       In the case of conainerized processes this field contains the
	       full identifier assigned by the container runtime to the
	       specific container the process is executed in. This allows a
	       verifier to easily identify the the measurements related to a
	       specific container.

This template permits to separately attest the host system and each specific
container.

This patch has been created starting from the master branch of the main tree:
<git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git>

Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 security/integrity/ima/Kconfig            |  3 +
 security/integrity/ima/ima_template.c     |  5 ++
 security/integrity/ima/ima_template_lib.c | 95 +++++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  4 +
 4 files changed, 107 insertions(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 39caeca47444..b85b2c757812 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -76,6 +76,8 @@ choice
 		bool "ima-ng (default)"
 	config IMA_SIG_TEMPLATE
 		bool "ima-sig"
+	config IMA_DEP_CGN_TEMPLATE
+		bool "ima-dep-cgn"
 endchoice
 
 config IMA_DEFAULT_TEMPLATE
@@ -83,6 +85,7 @@ config IMA_DEFAULT_TEMPLATE
 	depends on IMA
 	default "ima-ng" if IMA_NG_TEMPLATE
 	default "ima-sig" if IMA_SIG_TEMPLATE
+	default "ima-dep-cgn" if IMA_DEP_CGN_TEMPLATE
 
 choice
 	prompt "Default integrity hash algorithm"
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 04c49f05cb74..0862a5e8efc4 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -26,6 +26,7 @@ static struct ima_template_desc builtin_templates[] = {
 	{.name = "ima-modsig", .fmt = "d-ng|n-ng|sig|d-modsig|modsig"},
 	{.name = "evm-sig",
 	 .fmt = "d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode"},
+	{.name = "ima-dep-cgn", .fmt = "dep|cgn|d-ng|n-ng"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
 
@@ -69,6 +70,10 @@ static const struct ima_template_field supported_fields[] = {
 	{.field_id = "xattrvalues",
 	 .field_init = ima_eventinodexattrvalues_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "cgn", .field_init = ima_eventcgn_init,
+	 .field_show = ima_show_template_string},
+	{.field_id = "dep", .field_init = ima_eventdep_init,
+	 .field_show = ima_show_template_string},
 };
 
 /*
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 4564faae7d67..d8bb91b2e73c 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -12,6 +12,11 @@
 #include "ima_template_lib.h"
 #include <linux/xattr.h>
 #include <linux/evm.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/cgroup.h>
+#include <uapi/linux/limits.h>
 
 static bool ima_template_hash_algo_allowed(u8 algo)
 {
@@ -743,3 +748,93 @@ int ima_eventinodexattrvalues_init(struct ima_event_data *event_data,
 {
 	return ima_eventinodexattrs_init_common(event_data, field_data, 'v');
 }
+
+/*
+ * ima_eventcgn_init - inclue the current task's subsys_id=1 cgroup name as part of the
+ * template data
+ */
+int ima_eventcgn_init(struct ima_event_data *event_data,
+			struct ima_field_data *field_data)
+{
+	char *cgroup_name_str = NULL;
+	struct cgroup *cgroup = NULL;
+	int rc = 0;
+
+	cgroup_name_str = kmalloc(NAME_MAX, GFP_KERNEL);
+	if (!cgroup_name_str)
+		return -ENOMEM;
+
+	cgroup = task_cgroup(current, 1);
+	if (!cgroup)
+		goto out;
+	rc = cgroup_name(cgroup, cgroup_name_str, NAME_MAX);
+	if (!rc)
+		goto out;
+
+	rc = ima_write_template_field_data(cgroup_name_str, strlen(cgroup_name_str),  DATA_FMT_STRING, field_data);
+
+	kfree(cgroup_name_str);
+
+	return rc;
+out:
+	return ima_write_template_field_data("-", 1, DATA_FMT_STRING, field_data);
+}
+
+/*
+ * ima_eventdep_init - include the executable's path, colon separated, for all the ancestors of the current task as part of the
+ * template data
+ */
+int ima_eventdep_init(struct ima_event_data *event_data,
+			struct ima_field_data *field_data)
+{
+	int count = 0, rc;
+	char *paths_buf = NULL, *pathbuf = NULL;
+	const char *pathname = NULL;
+	char filename[NAME_MAX];
+	struct task_struct *curr_task = NULL;
+	struct file *exe_file = NULL;
+	char comm[TASK_COMM_LEN];
+
+	//get number of ancestors for current task
+	for (curr_task = current; curr_task && curr_task->pid; curr_task = curr_task->real_parent)
+		count++;
+
+	if (curr_task)
+		count++;
+
+	paths_buf = kmalloc(PATH_MAX*count+count-1, GFP_KERNEL);
+	if (!paths_buf)
+		return -ENOMEM;
+
+	paths_buf[0] = '\0';
+	for (curr_task = current; curr_task && curr_task->pid; curr_task = curr_task->real_parent) {
+		exe_file = get_task_exe_file(curr_task);
+		if (!exe_file) {
+			get_task_comm(comm, curr_task);
+			strcat(paths_buf, comm);
+			strcat(paths_buf, ":");
+			continue;
+		}
+
+		pathname = ima_d_path(&exe_file->f_path, &pathbuf, filename);
+
+		strcat(paths_buf, pathname);
+		strcat(paths_buf, ":");
+	}
+	if (curr_task) {
+		exe_file = get_task_exe_file(curr_task);
+		if (!exe_file) {
+			get_task_comm(comm, curr_task);
+			strcat(paths_buf, comm);
+		} else {
+			pathname = ima_d_path(&exe_file->f_path, &pathbuf, filename);
+			strcat(paths_buf, pathname);
+		}
+	}
+
+	rc = ima_write_template_field_data(paths_buf, strlen(paths_buf), DATA_FMT_STRING,  field_data);
+
+	kfree(paths_buf);
+
+	return rc;
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 9f7c335f304f..e5b1166d7ca4 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -66,4 +66,8 @@ int ima_eventinodexattrlengths_init(struct ima_event_data *event_data,
 				    struct ima_field_data *field_data);
 int ima_eventinodexattrvalues_init(struct ima_event_data *event_data,
 				   struct ima_field_data *field_data);
+int ima_eventcgn_init(struct ima_event_data *event_data,
+			struct ima_field_data *field_data);
+int ima_eventdep_init(struct ima_event_data *event_data,
+			struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */

base-commit: 9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
-- 
2.25.1

