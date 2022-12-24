Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EDF655ABF
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Dec 2022 17:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiLXQjC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 24 Dec 2022 11:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiLXQjB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 24 Dec 2022 11:39:01 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2104.outbound.protection.outlook.com [40.107.6.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7E9108C
        for <linux-integrity@vger.kernel.org>; Sat, 24 Dec 2022 08:38:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUDvIAJkFVJxBAwOvbRqHvz5FiQpEPkGYUPSSHSk/aLbX1RH6Gzq5y6B0bsr3+13aEJucJ7amn20zcWrA+TnxtKfvJRo1r53wDgnSC2nWxBQguS0taW0rgxZ/m7dLFva97R/+wohB4IKvIxtppcWOmQG49KIvooWr7PZ33OmYuySVbT5O+nOBFr2alWoHLQiSCDCVaLICWA8CoWzFdzXxBhrKk07eKH87eyrK/iKbAUXSk/D+SyNBTLnWvMp1WISTmbTRzJujYUy8RIDHLUMdxDwN7niVgJP541RXutUhWHuYzs7olweds4OEspZAzUrvTPZV7ue6HFB3q9Zh9MFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCz/SB935HS4KenwmKrQUYjcKll6gDUC7W4WgQv37sI=;
 b=laHEu400sIbIA7M6YN0pQXt0GMbfC8dHofN+a206NnE334hnKbWhEd8S7bdw5GOuDj9z3/wICKDUOZ9ZKKqRmpYVbLr6HqyhnahF54oyJgI4jOLZxOHtlQpeQBh3dmkhZloV8gsJTNvWOwq1/NAXSb9e6TU7cSHsBV/nkHsuhes5ezfPyLzuvm+654VYU+MDG6sW4rBrpmkjW3w5H1rTZjUpJAU9rtZIfCcw9zyTd4AGoAVRycURyRcTZc/smUuZyT8TnSyTbzRGOWfk9pfc6z2xWDToDijQniWkkU0mc9MkxvLYAWsTci8fFhCh9NAZgTlEoC5ZqkTBje9cfb60sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCz/SB935HS4KenwmKrQUYjcKll6gDUC7W4WgQv37sI=;
 b=C8cTipnAUHgeDX9+JxEQTAJJUP/IRBFb46srbMElnaDkLRV9uqSdbJCiCFB/We4WAPdhUFo38Xklev5xRuch7dLrA5oZyuuquQZEKZKwQ6fH1foIChvxQ8Ej14sl52pn9qAq889UFnFEaV+UnMuqLTdgSkPj7XaG7UkyfuyuaAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from HE1PR0502MB3612.eurprd05.prod.outlook.com (2603:10a6:7:80::22)
 by PR3PR05MB7532.eurprd05.prod.outlook.com (2603:10a6:102:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Sat, 24 Dec
 2022 16:38:56 +0000
Received: from HE1PR0502MB3612.eurprd05.prod.outlook.com
 ([fe80::1b06:8ff7:72d4:6ef0]) by HE1PR0502MB3612.eurprd05.prod.outlook.com
 ([fe80::1b06:8ff7:72d4:6ef0%4]) with mapi id 15.20.5944.013; Sat, 24 Dec 2022
 16:38:56 +0000
From:   Enrico Bravi <enrico.bravi@polito.it>
To:     linux-integrity@vger.kernel.org
Cc:     roberto.sassu@huawei.com, zohar@linux.ibm.com,
        Enrico Bravi <enrico.bravi@polito.it>,
        Silvia Sisinni <silvia.sisinni@polito.it>
Subject: [RFC][PATCH 2/2] ima: created new ima template ima-cgpath for Kubernates' pods attestation
Date:   Sat, 24 Dec 2022 17:28:31 +0100
Message-Id: <20221224162830.21554-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0115.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::12) To HE1PR0502MB3612.eurprd05.prod.outlook.com
 (2603:10a6:7:80::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3612:EE_|PR3PR05MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 888d6b6c-06a9-473b-d621-08dae5cd599b
X-POLITOEOL-test: CGP-Message-politoit
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/v4NJX0bOsg9U5hq7LaqRv9yhd9x3Gt31tnfs0aFGYP/fu8947aUwGt4iX6L5FRK1DvNV8jn5urQHDNZ2RLPTww0SsiAzCDKsEY1E7jIAMVfRIx6DS5Mebq9BNK9nW2Z5EjaH4Ny34YeHGrfpRQ19/LnQGw32v/l9EmivT+N3LIMGUGQWfgfXGAZhCyk2L6Zgu5MleD++K6bnfrYNtCL2rlkEB331FrHNyhZ6pooFm5/+X02ETu+WRoVXqxZZUFENV/ZEhzKKbygcYvgxpQjE58z63B4jT88LNtMsl4hFsxC1sQdL8H3oszi6nJfVw6/rxt8wG6R0+TEGmlkNJA2VD1G8MnawRNyohI4uI1pxuAljHDamFpxJnVmWojz3rZvOybT57LPnZ4SWtWRibNPnlOC+pAKMETC2NwgIuDOyxY/WfWY2N+/8EvY2LrxO7Uo0qpoZNVnw5g7mEycKhZ9QvBtlLEZQLzhI7Fkr6H8zvwihLBs4JjhSIP6unBQyWkN1TbtlYV951DiAADfEu+UeQ9LCqcczPnSoMg3OfqLQhNjNSHA3YTwIXwRQHdjR3A1T7PQqIfdWIyGm+b6hP/nQlJU+bWl7yWp8cSo8Hv9TgPK2ikHWwH4cjk34PANpZOrw7+5O44Q26CmtMMykXtWugPH8UKFOAVdDdQlzvq0AlPzRNU2PaBZGUJ3A0YGvdovorQZkCdgLSEcbVqRIf2ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0502MB3612.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(83380400001)(38350700002)(38100700002)(316002)(8676002)(86362001)(66946007)(41300700001)(66476007)(786003)(6916009)(4326008)(66556008)(54906003)(41320700001)(5660300002)(8936002)(44832011)(2906002)(186003)(26005)(6512007)(1076003)(6506007)(6486002)(2616005)(52116002)(107886003)(6666004)(478600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BbJ0T6A4qIzpZalgzsQ+9ykYWsYL9mm8O2rA8AWEZfsycr4IiOUlXmEl2uUR?=
 =?us-ascii?Q?x+RaouMS/+lVcQ1kv+0aAO6q6pKcHZ0pBL/VHfIwex/YQZpW75iAwY37QRw5?=
 =?us-ascii?Q?Awh8k9U7Rv/AyyH5n3nc4TIeBPw1y9UliiWjbGk65OY2PQk8f9mTICFegDKH?=
 =?us-ascii?Q?uddASzDEt48V7vD9/vMnFySnqA9ZRPz+tpITcfQ0N9BSoVNa7EnNTpyqPLmb?=
 =?us-ascii?Q?qafHHdvTnyAwWqUMzg/llSpXNzKNMguvd5J2UW/sDNl36hdjzNYVybxheTVr?=
 =?us-ascii?Q?u1ALZvC7K6dby1iqOz0s3Nl6AmbgH7H7w72Blc+l2xXfe+8ePQ7xoaW+L2By?=
 =?us-ascii?Q?eyTwOGJtA5GvROKewkyP4AC88OLzdeDhvZY01jC9H+YbXcP6ihmZaj90cTwA?=
 =?us-ascii?Q?duoC2wQ042bdyG3QAF7bypK7R9Xzfws5pdB6B9R9scYveUyFBZse88FQL7SY?=
 =?us-ascii?Q?yHa+7dszxeeGb4rhjMPlRaJJCNU2EkMsK2Gbdwk3Ui2mR50WTtdNYIJYsve7?=
 =?us-ascii?Q?RZnUAH4gFy7XhLZcVqp2AsOXQOFFW1Z+iyhFZKnsYjrseqpGf4E9f8gSEMaa?=
 =?us-ascii?Q?QN1jAglHXDc8gBz9VTGWJnyg9Up7jrdPDkDar9B0zHw705anD3COsJNvSTI7?=
 =?us-ascii?Q?+KYSLB3CiyLSWtOdUnkjmUfWv8/xxBM6yzAQjNq4bXLdqzIyyp8QkaCs5a3g?=
 =?us-ascii?Q?6t1/rugeAiMvezSdAY+Ga1iyp4szzdeRm/WFZsiRE7jK/AacGEhCfGKF9i4V?=
 =?us-ascii?Q?N0np9PZ+MIfbwkBuwaG5Le0W9UFbevPOOWqwnMfCyHm2v10RJ1GribEOJRuB?=
 =?us-ascii?Q?Zgfrct0PtvuRaXZZ535vbg1oZc/yuhH0Y3Lx/HqMDcHDD+RHRZST34bA3W5U?=
 =?us-ascii?Q?2u5AXIUs1ZqKjk/36/ioKRXm/2xYuJ1oFfrqbyPLGzUfMpNvEkcLTStQLDm0?=
 =?us-ascii?Q?qZvlOPYB59E2g9V92rkB0MzdUA28Eez6AT+dXJLTAj7LcjNaP7kXqZWttmpq?=
 =?us-ascii?Q?c5oiHDwF93djkgwmNz8ROC4LoRLk4isWICpbWHHaOuSzkn7eo1rn+uZvNPtP?=
 =?us-ascii?Q?e8y029+IF9OvtU80MOkXt8DGbpwcfceLyqTAAqkA7fzznCgq8mr2sIdwNMA5?=
 =?us-ascii?Q?G9Dt+D5aNiGkmVD1/YvjGmThQrqa3EiUCZT7OihdldgMfnSqYADZ5aBiBukg?=
 =?us-ascii?Q?0Te83d5WysHeRMgjbEOHJpWk/kCVyVxP7jjLBj4u83Qen+/i74B7Xd+ZjG2V?=
 =?us-ascii?Q?eqkeETfjVFz6SxguoLReMgz0AYZ/iDR0oHnXEdeMXsvWUiaM3EtPkMfqGJur?=
 =?us-ascii?Q?0o1mwMTtcdueis5DOBBMj9PfyYK7K98I9+NzVAnBXMeGq4yZm7DcNWzEar/6?=
 =?us-ascii?Q?EBcCo//QgOmxAY3BKTHHHVYGbdOYQGds4PI90XO6YA0T94pjhkvGYJl/a6Vt?=
 =?us-ascii?Q?5zAMk63JQI24cnuelYbec65X9Kjkff8kK23f/mZb06dlhrbtTnF+HBMso5E+?=
 =?us-ascii?Q?PursGTFPfdqXlv5TFpgndVdQh0XgU7y62X0mE1nr27WKfE37ShJ0P4NlhfHU?=
 =?us-ascii?Q?scQQKF6IY958jYgQ8xsJNyLPrhMa80xA0mOSgmS0?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 888d6b6c-06a9-473b-d621-08dae5cd599b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0502MB3612.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2022 16:38:56.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iftWjFIQbPVDcf3q/AZwTAXEVKw7diI6d/ZQ4aC9sBw285DOnj6kIzT4D7N3PbbLb4AeaMxhBW/uVRA5Qzz2wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR05MB7532
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch depends on patch "created new ima template ima-dep-cgn for
OCI containers attestation".
Created a new ima template ima-cgpath (dep|cg-path|d-ng|n-ng) based on a
new ima template field:
	- cgpath: subsys_id=1 cgroup complete path (cgroup_path()) of
		  the process that generated a specific measurement event.
		  In the case of containerized processes created by Kubernetes
		  this field contains both the identifier of the container in
		  which the process runs, and the identifier of the pod to which
		  the container belongs.

This template permits to separately attest the host system and the Kubernetes' pods
running on it. In this way the verifier will be able to communicate the pod ID, in
case of compromission, to Kubernetes in order to reschedule it.

Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 security/integrity/ima/Kconfig            |  3 +++
 security/integrity/ima/ima_template.c     |  3 +++
 security/integrity/ima/ima_template_lib.c | 31 +++++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  2 ++
 4 files changed, 39 insertions(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index b85b2c757812..abbe3c554276 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -78,6 +78,8 @@ choice
 		bool "ima-sig"
 	config IMA_DEP_CGN_TEMPLATE
 		bool "ima-dep-cgn"
+	config IMA_CGPATH_TEMPLATE
+		bool "ima-cgpath"
 endchoice
 
 config IMA_DEFAULT_TEMPLATE
@@ -86,6 +88,7 @@ config IMA_DEFAULT_TEMPLATE
 	default "ima-ng" if IMA_NG_TEMPLATE
 	default "ima-sig" if IMA_SIG_TEMPLATE
 	default "ima-dep-cgn" if IMA_DEP_CGN_TEMPLATE
+	default "ima-cgpath" if IMA_CGPATH_TEMPLATE
 
 choice
 	prompt "Default integrity hash algorithm"
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 0862a5e8efc4..301d14e4c650 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -27,6 +27,7 @@ static struct ima_template_desc builtin_templates[] = {
 	{.name = "evm-sig",
 	 .fmt = "d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode"},
 	{.name = "ima-dep-cgn", .fmt = "dep|cgn|d-ng|n-ng"},
+	{.name = "ima-cgpath", .fmt = "dep|cg-path|d-ng|n-ng"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
 
@@ -74,6 +75,8 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_string},
 	{.field_id = "dep", .field_init = ima_eventdep_init,
 	 .field_show = ima_show_template_string},
+	{.field_id = "cg-path", .field_init = ima_eventcg_path_init,
+	 .field_show = ima_show_template_string},
 };
 
 /*
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index d8bb91b2e73c..bbedb29c3051 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -838,3 +838,34 @@ int ima_eventdep_init(struct ima_event_data *event_data,
 
 	return rc;
 }
+
+/*
+ * ima_eventcg_path_init - include the current task's subsys_id=1 cgroup path as part of the
+ * template data
+ */
+int ima_eventcg_path_init(struct ima_event_data *event_data,
+				struct ima_field_data *field_data)
+{
+	char *cgroup_path_str = NULL;
+	struct cgroup *cgroup = NULL;
+	int rc = 0;
+
+	cgroup_path_str = kmalloc(PATH_MAX, GFP_KERNEL);
+
+	if (!cgroup_path_str)
+		return -ENOMEM;
+
+	cgroup = task_cgroup(current, 1);
+	if (!cgroup)
+		goto out;
+
+	rc = cgroup_path(cgroup, cgroup_path_str, PATH_MAX);
+	if (!rc)
+		goto out;
+
+	rc = ima_write_template_field_data(cgroup_path_str, strlen(cgroup_path_str), DATA_FMT_STRING, field_data);
+	kfree(cgroup_path_str);
+	return rc;
+out:
+	return ima_write_template_field_data("-", 1, DATA_FMT_STRING, field_data);
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index e5b1166d7ca4..7d58c34ca639 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -70,4 +70,6 @@ int ima_eventcgn_init(struct ima_event_data *event_data,
 			struct ima_field_data *field_data);
 int ima_eventdep_init(struct ima_event_data *event_data,
 			struct ima_field_data *field_data);
+int ima_eventcg_path_init(struct ima_event_data *event_data,
+				struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.25.1

