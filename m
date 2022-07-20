Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B83757BB8F
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jul 2022 18:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiGTQkt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jul 2022 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiGTQks (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jul 2022 12:40:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312B94F670;
        Wed, 20 Jul 2022 09:40:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KGd30F002272;
        Wed, 20 Jul 2022 16:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=JaAQdAyUOUmMUGEY9RCEzxDP5HmwwfJUkqV23Tdr7jA=;
 b=2mIdFn+e1loPzYo1W2F0yJtssLm+RosnViF1BrY5GR+0n264rhisvz9iXX7rbbrP3qmZ
 gVvf3xL5B5eOgfyqfZztCCBFNzy3tM2XIV2OH+LyENXoS8Whx2htgKgyX7EmrOrMa1E6
 CoqkwjO8xmX3IJQc+DszY37JXtv3WDr4qFHv1SJjZkAAbxn6h7t7gB735oQLZFATM+PY
 /IN3+vZFlUDE0+0KeagWeRDBO2eY3tTZYbUhs6OZmPgHWsuKJVP9+nCOZAb84euiTHxj
 1uXgX07umHcJqGVnxsaRkxsQ57dggrGzDiir/0v4jx6U+bX6E/W2ZKlG1AEhzMUYj2ag Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxsa4tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 16:40:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26KF8sr4009872;
        Wed, 20 Jul 2022 16:40:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ghjpdy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 16:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG4jOoQWi2m6gd2w9iGfSq3CPZsC0lDhppRPJFEF3uGZJ83yGWqSJd302A+CEluH1UeStkrOzXUBvr52so0mWqeFSz1tjM/PV8Ke8HBr2MR4RLmaXn4/0NId4glW9QrkDyHofJxFqs58ME6WeGrR0raC1zGWSZlxJKem7dqgecnbbNnRY+/Oi948QjId2ZvzT63xBmHz0DVejxxINnj6nv6CFtHq1bvTyK1xSmTjfJ9eGO14ls8WaC6YTouSlNLefLv8vI+OLCy1vlavtxwbR0TlJDMUNAVNQk1NtnhCbbZLNxsz3ax7wr1vx9Uun38c0jXYT6epaW8T+CtsUdQHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaAQdAyUOUmMUGEY9RCEzxDP5HmwwfJUkqV23Tdr7jA=;
 b=DbqDzFoGQChBrr5ZdhM9TPkz249GfjobdHVulfCgQhI/S7wCw+iOM5HhD5aAXBmnphppdrCXeuATXz6I2viUyF1aOLK+CarzVxchXqANmIq23fAHj/tOZyedgmeqvHUqj5NeKoy5v9NKdOcG3MgKhk/OAjIMQxKD+UjP0ZmZftXqa4h+DUAwf0oXWCJmxjTgwztP9rlz3hiMl65A/iuflSYEPoHMvzUlcWJNJe1kpavECG3+skyfwUUty5mGCKXqvavzI78SplYBrAD14kOL2D/62YuqjFYJch7SX5g+0LCsptT7IDpfq4+x/dec61ZugbG28lVK9dRN18rTeJTboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaAQdAyUOUmMUGEY9RCEzxDP5HmwwfJUkqV23Tdr7jA=;
 b=kHkZqsx9IPBWx2CkIxzw4WzfmmEgVG3KdRlRrkxDs7Rk4eprKObsOq0qpOQIyellgWAytIF3FOll9Iq7kAUKU37oZyOruD/GBb/j6geL9XYCOaaIYivgmT07jAIbEXfLfVVFfCOS60EQaDXpLHkWaHZiqO7TRTd/61KpJImCeuQ=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BLAPR10MB5169.namprd10.prod.outlook.com (2603:10b6:208:331::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 16:40:39 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::21ce:9dc9:abc2:dd08]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::21ce:9dc9:abc2:dd08%5]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:40:39 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.haxby@oracle.com,
        eric.snowberg@oracle.com
Subject: [PATCH v2 1/1] lockdown: Fix kexec lockdown bypass with ima policy
Date:   Wed, 20 Jul 2022 12:40:27 -0400
Message-Id: <20220720164027.3697950-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220720164027.3697950-1-eric.snowberg@oracle.com>
References: <20220720164027.3697950-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:806:6f::32) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 621d7545-00b4-4fe1-3352-08da6a6e9437
X-MS-TrafficTypeDiagnostic: BLAPR10MB5169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8hPr+kGwsKjDFceHQ2xUrk7CLokmquTxkk9C/gdXfnU6SuUQg0hn9GWmzSdWqNOYHhNymdmMMUlnly/KwZotCYLQs3Svvq3fPevaySqvoErZ1+oVyVLQA2MdfTWdrYAtjvi5lCmy5cVA//SP7M9egDbTWdWsziRTQ8YKtrr/Bci4jGOLWxaQTV90u6SThBZCbMOda+NJ4NAdLy3+WDllB5Xbrt7pI+c58X36pirNBb1F9Jk6Ud2PBfl1/o70X5SPhgdBKJWU4YL7JxE925jt0VCVXdWGTb59l0YpzN6Zbn5fH65psW1l7BJN17PlXD5AmnC1D3GKbNpfTiMzmVPhtc4QsC3ZnwFdFsBXrSkKBCkadckkIVJbYnbNwWSguclFQLtodlleXb+KHZshBx5iAKhN/mYfJBT82FBS2flj6GBCsSrY2wBPrFJXpJe04OG2tstU7QimF77HlWZf/2dHskK1SIleHO5D2h9ktioDeJkRU7Nu5Cd0iVceserkOOOhRvuIPfKya+FhTBfoqbfe8+b7P7XhO730WamSGfi0tYeIf+oeEdoMb3Ftf+xcbSwYJfmoMjH/FoM0kGwKf5B6+IJn5tZ+vbSiR6UZtD39qY4IYt21RgtuKa+qc3V4F4B+GsU2YUCI2L7MpcVPyOGCWhWB6LbbyhCk4GaYbjHuBExfgBB3xC16Er3VcwzapwhR+M2hmMqp8FOK7AAfM39yy+V2sIU1Q2kb2WH1KgCHNOtwLP0nKAIs1ZpgxicHlk8vJZzv2jvw3H6fRJy+j8UOl9109kcsVSefhPpJynFbj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(366004)(376002)(39860400002)(38350700002)(107886003)(1076003)(83380400001)(2616005)(186003)(44832011)(316002)(66946007)(66556008)(66476007)(38100700002)(8676002)(4326008)(6916009)(36756003)(86362001)(6506007)(26005)(52116002)(6512007)(8936002)(5660300002)(478600001)(2906002)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPH/npc3un43ucUHbUMNe9TQpkOSmOUrhmJuJsF4V6sD1Nxk7j+CPWh4m+w7?=
 =?us-ascii?Q?fLxYmP5b4pEMASl7PA2XDN+LCRcSlsT5xhy8pNuNfEgNDxM/i2zSjAOC88uQ?=
 =?us-ascii?Q?FPq+08Ns7Z4370HjKQdMZExFjoXQiM/B4dHPFwVVXKyD6XovdEUQ3QkfXEx+?=
 =?us-ascii?Q?L3uK9+S7K9E4NZuJBC/rrz8jr0x+FzII2delhmE45PKavc4q6sxzCW61nuXd?=
 =?us-ascii?Q?nfZmMoCaDhgDLZdTja84I0Q44+ZevR2VqkHFe3W2f0TNBmohU4cpG6fkfk0S?=
 =?us-ascii?Q?xf0rmfI4UmrGKXifNiQe+wc9T35DX/GdU8JtTTfKeBQC2dXw3VYyF2257Bkj?=
 =?us-ascii?Q?Wtkg5DbnJGsdQY4ngySD+WWk31hnGpNXZeU8EecNME17Lw3oq8ynYAiwfeLp?=
 =?us-ascii?Q?jmABvXc2SARAFf2wI5dy10rZCSwCSNQxliAkEyiOxe5lXjz5+qGOv+iyaaDz?=
 =?us-ascii?Q?ssOjpINM+unGL9cxLlYLaWCQYcqFfq0oe6yGC0+344H+wQgAKOxXlSoCWF1U?=
 =?us-ascii?Q?RyQkh599r5vtZHEyui0Q8LmuAYkc62DuavSq8FEHj+FPQGFMsR/poyrdur8x?=
 =?us-ascii?Q?bsnGzszXUdN47OcHesvjpopKJZhHOB+CaAQ9BmolnugYipx3BKq5Zl0iI4Zb?=
 =?us-ascii?Q?mZdWHsZ6OUTfO5mjtkYT7XN7maXUyH/rH6dJejJu862etwqsvo4UsRyFTi1k?=
 =?us-ascii?Q?51mJrXALjk4bqQHFgcXKw1gDeq5zdE/7o/niv4TCcbq0DjrwUl8zdoeJXJtC?=
 =?us-ascii?Q?hq3yiX8YsD2u050y3oxxp19L0YqNCczOyrbABK5KwHAC3xL03soUG0rKlr4J?=
 =?us-ascii?Q?PmfJHnK5H7L7L+UQ7XQFnOo2fnw7gAJZVV3nT+lsomIAfWTyxFYrGL8ejl/w?=
 =?us-ascii?Q?18H6kQ1J9XDbti5Uqeo1lv7gy16cWIbA8orcXWeOtPqUJ/nraDVbW12pG9xP?=
 =?us-ascii?Q?pwnncLVu2qcbqWlSOsXcShQn1PeTFV9Y6Q5zbf8WrBCNoIpVKiPzDcRC7TRg?=
 =?us-ascii?Q?iOrqoy36JguzIWOTOIGe7oKv0NYkft8Z7CckMa4uUTW5Re8TUZLb9P++NFpK?=
 =?us-ascii?Q?+NJMnUtSrVUpzB7CIQQjZ6IOkjiBkDsEGp36ErSWZj1dDNFLOMr+0XDkiH4w?=
 =?us-ascii?Q?DTwDhoxOMefcJpKjR8kt3PfHFMtVP/OzXqUcFyfEoWlF0zEhUhuf1ph4ohgg?=
 =?us-ascii?Q?fez0uuRnNCNjWeZl8YEhQ9x/mrZnUbJpydLy75XqSVodZ7DacAg1JWvOMUpi?=
 =?us-ascii?Q?1qpUxzcPGfm2ClE6Nf2KlkJanNOx/wLsLC2nXPWJHbi6Vk7nDPAzu1Ew69Dh?=
 =?us-ascii?Q?H8rGK0amnDIPb9pLumpWOwArubJogHkA1lyctAN3xOB7HvYLL+9zBHGN2bAE?=
 =?us-ascii?Q?2AZ285zWYBC0aK7jYfaaxfXRpKmyd8denKvrsFVKqOlCHOtAFK3IFec9GEgY?=
 =?us-ascii?Q?jCmv5/1RItvAR/XSA0ui27G+XbeAPdpBDswVkG55cgSLyz8P4Ipzg/BM5nn/?=
 =?us-ascii?Q?OyPPeZTHC4980o/z7gD+T39ySuzUCEIEGIP5YwHbcOZWUJrHlppqWSHoavhk?=
 =?us-ascii?Q?ifkN8cEV87isP8z5qXadE0VfjYObQVPNur9bj5dQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621d7545-00b4-4fe1-3352-08da6a6e9437
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 16:40:39.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omuO+wkDaeK35o8C8hi5+XCHBf+FYTsYBpm/PMLGCDsHHw88B/oDGuczB9PdjLvJUWwePGNbMyFhUvDha0BXCH4jjjQP2XBhJC0d1QjillE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_10,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200068
X-Proofpoint-GUID: sAR9DCMggMz7I5bBdejwaBwmm0w4eyy1
X-Proofpoint-ORIG-GUID: sAR9DCMggMz7I5bBdejwaBwmm0w4eyy1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The lockdown LSM is primarily used in conjunction with UEFI Secure Boot.
This LSM may also be used on machines without UEFI.  It can also be enabled
when UEFI Secure Boot is disabled. One of lockdown's features is to prevent
kexec from loading untrusted kernels. Lockdown can be enabled through a
bootparam or after the kernel has booted through securityfs.

If IMA appraisal is used with the "ima_appraise=log" boot param,
lockdown can be defeated with kexec on any machine when Secure Boot is
disabled or unavailable. IMA prevents setting "ima_appraise=log"
from the boot param when Secure Boot is enabled, but this does not cover
cases where lockdown is used without Secure Boot.

To defeat lockdown, boot without Secure Boot and add ima_appraise=log
to the kernel command line; then:

$ echo "integrity" > /sys/kernel/security/lockdown
$ echo "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig" > \
  /sys/kernel/security/ima/policy
$ kexec -ls unsigned-kernel

Add a call to verify ima appraisal is set to "enforce" whenever lockdown
is enabled. This fixes CVE-2022-21505.

Cc: stable@vger.kernel.org
Fixes: 29d3c1c8dfe7 ("kexec: Allow kexec_file() with appropriate IMA policy when locked down")
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: John Haxby <john.haxby@oracle.com>
---
 security/integrity/ima/ima_policy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 73917413365b..a8802b8da946 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -2247,6 +2247,10 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	if (id >= READING_MAX_ID)
 		return false;
 
+	if (id == READING_KEXEC_IMAGE && !(ima_appraise & IMA_APPRAISE_ENFORCE)
+	    && security_locked_down(LOCKDOWN_KEXEC))
+		return false;
+
 	func = read_idmap[id] ?: FILE_CHECK;
 
 	rcu_read_lock();
-- 
2.27.0

