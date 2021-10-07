Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3175425CFD
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Oct 2021 22:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhJGUNZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Oct 2021 16:13:25 -0400
Received: from mail-dm3nam07on2041.outbound.protection.outlook.com ([40.107.95.41]:63393
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232821AbhJGUNY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Oct 2021 16:13:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwOtNE6vzgfceBnaUWDiRQxa7fEF1R/NqetAPfgkM2bgtFulbv2E3vR3aVQaMheMauBsO9vrGvbNGSbNXSlcGszwqPeKr8BwsI4Zqx9xXHZjA7IQJnLfRO6Kgv32ybDa1BcLAGOzJVAb3bfB4kfEOk/aJ4B5ad/slJXqKec05HYYwJf/rvUUnjBblE/GCO9EK16n6s8xtGUa8QeiRMwgnCVPVI7ktxH3JBHcjfhsAWobzMCr+dPx+QcVJWiiQ4cfiizKjWW+VfjKDIOcqmu5mQFZRRmEimUQ4tiGbOJPgJU4gFSxobhfcdFTWa8gWcT7vuNl9AD0v2kix2rjSo1cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrGSAqYQC7ZQgb0cDETj5vGMfteOCxZLwlNhDGBoiOo=;
 b=bCYPmGFBkOqR31i8lYFQzT+adGm3YUK0D6Ctl94/KP1eMpEjfUkC7MWZa3CGC1bUKsIj3oBQpSpFCJ1dL/TA9TOkYkUu25i1240xBPBO3HoPtdkDCwAIS1ZIkUCdiK09/fEeZCvD994jFTAUW6wbQzGVEcNrtsaX8bKSCSj4+E0BR9ZvefCLqHTonjwkeyWja+M4aejvcIhPQuw5RlukGqr8pB77ksx4c7UXfYrgl59AlIxjzNa36E81y7gXytCDXUz4us9hk/VJM6h7KQlLshbJvNCPfJVX55elcvmm15P6GdkztK6GIdG1ipu591tzJ9Td2Ve6C33CXZ0HqQRXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrGSAqYQC7ZQgb0cDETj5vGMfteOCxZLwlNhDGBoiOo=;
 b=xGDRmZXedvEk4J9wDpwpGZz/uQWmRqpt796KKY+RkE94PH20fsO46wXm7mSJ3L8cb6cpI2GXVpT8hEzV+WA9N2PPOPdbjYscaJuPTeukQb3onz40PHkRhJYPQoCeZt3/ndyRh/BNj+1dCP3mZwXd+9tWG1z1XWCb8Ef1aWd6W1M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MWHPR0701MB3722.namprd07.prod.outlook.com (2603:10b6:301:7e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Thu, 7 Oct
 2021 20:11:28 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4566.022; Thu, 7 Oct 2021
 20:11:28 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Alex Henrie <alexh@vpitech.com>
Subject: [PATCH v3 1/2] ima: fix uid code style problems
Date:   Thu,  7 Oct 2021 14:03:01 -0600
Message-Id: <20211007200302.187892-1-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::15) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by BY5PR16CA0002.namprd16.prod.outlook.com (2603:10b6:a03:1a0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 20:11:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7925efc4-41dd-4d47-6be8-08d989cea58a
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0701MB372248678AC225147302ECF2B8B19@MWHPR0701MB3722.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pyvzYvAF0RU4XTDQ/M2xkmpQ6hzBgNV+qUEGE1sJnKv2mHktoB2vAyz37d4tlVJg89eMZoCZmlBUBkEspzP/LDP6WCmDcuJvp/aNcjmPzAatyg7/GP+WIirGbEtQH0IWlEAsZhvQL+0Q4If9X6IqPsgwyP3JuBCrnhvt4hhQXm+jVpAF9cX/HYmi18UY1SqQVqdqPlOz+vft0ylJ5sQBk76PdhDvp6fYTv4bOmvzEDMDfGp11X0QIHlE52SPK3hx4ojoBHwiZbXa7AsrmxqpM4+pejnoBeiUYiLwBN55Iq3tKS/PxiAy14e8PN4FATlJ7z3NSJjUFzBgprZggDkvSffVWmotxNdC+CK0KEnod/7k936YGTtnEeKXK4IZDdjp+ND2giWmB78hLJuC0BpYMbom+Lu8bzWXNjmRmhMsiDLIRptY9KxLEPDThkhGYixOeCe0lII6+hSxsVje+H0d30a8GkvBZZoKi7If2hJV33rgawrFOjigktH2uwPlE3JYSEoXH7NfsI+5ND6HLQNBgo+mdmlNDj2riwQIik60li1nSPrH3neujsu7IEUYewqOU9s4f7+Ag8qAFBX+N5Im6k4gmNvO6Ty1F8tKipefXluea7gzOemT2aqhDniy3jWCzGwndpqxNmLbulegN7tiajkDXEq0hjEPtBfdHzz8OfFUUq/qSR4MoDBblDxHYlAtV+fLYg/DE4F7aQiUaDj/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39840400004)(366004)(346002)(376002)(8676002)(38100700002)(66476007)(38350700002)(66556008)(83380400001)(66946007)(186003)(26005)(36756003)(508600001)(956004)(316002)(2616005)(6666004)(86362001)(7696005)(52116002)(5660300002)(1076003)(107886003)(6486002)(2906002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NqEP8xDgYt3M2QESHr1WdJDbZF7PefUlMSTipcOVJffLLDWxbtVZBzbocvLE?=
 =?us-ascii?Q?k0liv52YzXJbjePTm362wlHOB3ihL9exA/DF6cHKs/CA2R2W6GvCodiKUPov?=
 =?us-ascii?Q?B2KKtDe+7MUf7L7OQeydowlcS9sjv7tLeeFMga5PUMO8dgg7/IB+WqR/Z6+/?=
 =?us-ascii?Q?M9+jvjRoLGZfghH7nFRSgpS89n3DoQQSTkpsAvX8LrzFk4BP3TWj/mYg4jtw?=
 =?us-ascii?Q?D0+GIvvlF4h02LaoUXIyLAqmfQ98H0b3285TTZYn5fZWwBbGYniqzRskikGU?=
 =?us-ascii?Q?Pv53xLfS+aCJ5vDz1EJCHQVTQFzuBOydqLuqtgQhToBz5mMaD7hULahuexEX?=
 =?us-ascii?Q?tMrnAHU4k7NwvQFAbE9iQWL6MMss6L0t1uhd3VFP+VxnYDEpDrgFi3+pbRc6?=
 =?us-ascii?Q?/rfjmc0ulwTwrdEXeqHohMAdeEAFC+bhwVtqonmROpAVYl0lAsuz4VCRklVj?=
 =?us-ascii?Q?1uzwXo6RHIqF4s3VEnyLpaAixyA/Hqi696FBgtxDipCYiGSX7qb9nuHDC++M?=
 =?us-ascii?Q?Cl3cOwuxsJug99EJby8WY3WOE1FjbNrrhL1r3kYrIiCif60fEhwP9q2SbsiV?=
 =?us-ascii?Q?Nw8FaWou+P78uUgtWQWXZc8A4Ewpz8cAX8XiP5lHfEb6aq1/LuTqAx0roHFJ?=
 =?us-ascii?Q?89oPDz/uLEg5rmSFD5t4FNsBsPItl3nk/3INom+GVZQDgEdPOKz7nNm6oHgE?=
 =?us-ascii?Q?DS4xEATc0itcALQGiN5kmxPU58uSPMblSVM6QepZmmR5jMrGNNn/XrN6v4Bd?=
 =?us-ascii?Q?vbrGb8403FpnQ6p+JiAzZ712iXIWJn7JscmKC65KBNuzySblIV2hoMRwgokk?=
 =?us-ascii?Q?QSs4TEBCt9K1YWBzg86jb9IJFf7Or9KGlp+WiM+rJL2c1wJe+JHJZc9dXF4g?=
 =?us-ascii?Q?8yxxdTEHNL1ynGU4V+qO4E+RZcnLbyg6bx2zYcbpLh5kQDpnlSUkT5tltM7f?=
 =?us-ascii?Q?SOrtEiouyf2MSSYVvbYyBuNihuHFn/wcdfSy/Q/c78aI1Q4Riu8/XsvnusNh?=
 =?us-ascii?Q?0f7HB9RrUj/++JNOTSs93dNSUH9TC41aUMpDkgo1gZ/+yyKQuXjFsPFOII6e?=
 =?us-ascii?Q?OmLQBh2iaBu96+Rt8k9C8McWFuOSWq1iC1i2aQOx95YNSgXNBcbqDI2mxmph?=
 =?us-ascii?Q?anfaeaDgRdL0gYvSE3cG77gaN+sxmKdrlavaO9/918wtmaQUU95WV9W61bui?=
 =?us-ascii?Q?+HpRVdtZDrBuO5gcWKcSN5/qPN4j27XdiV3qDcWb3HHMYUcSwYuScFqOiSx7?=
 =?us-ascii?Q?IS537RRBGG/HRPHkrNlXfCdmgciS2BqNwvlDiozzXujuFl7KmbmdsVZXgOlx?=
 =?us-ascii?Q?DGZpiXL2LsfcpYTqt1mfrHhj?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7925efc4-41dd-4d47-6be8-08d989cea58a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 20:11:28.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfC2nY7A0LCkWkIiddT5v2u2Ht4L1251M1iDwfTp4GtmnZHV5N28MLKffcPl3SB6nvE2q3YAVB9uiJTBh9jfGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3722
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

scripts/checkpatch.pl wants function arguments to have names, and Mimi
prefers to keep the line length in functions to 80 characters or less.

Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
v3: New patch
---
 security/integrity/ima/ima_policy.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 87b9b71cb820..29741eaa0ed8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -79,8 +79,8 @@ struct ima_rule_entry {
 	uuid_t fsuuid;
 	kuid_t uid;
 	kuid_t fowner;
-	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
-	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
+	bool (*uid_op)(kuid_t cred_uid, kuid_t rule_uid);    /* Handlers for operators       */
+	bool (*fowner_op)(kuid_t cred_uid, kuid_t rule_uid); /* uid_eq(), uid_gt(), uid_lt() */
 	int pcr;
 	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
 	struct {
@@ -1546,8 +1546,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->fowner = make_kuid(current_user_ns(), (uid_t)lnum);
-				if (!uid_valid(entry->fowner) || (((uid_t)lnum) != lnum))
+				entry->fowner = make_kuid(current_user_ns(),
+							  (uid_t)lnum);
+				if (!uid_valid(entry->fowner) ||
+				    (((uid_t)lnum) != lnum))
 					result = -EINVAL;
 				else
 					entry->flags |= IMA_FOWNER;
-- 
2.33.0

