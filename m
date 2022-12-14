Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620B664C13A
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Dec 2022 01:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiLNAef (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 19:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbiLNAec (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 19:34:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC41DA7B;
        Tue, 13 Dec 2022 16:34:31 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLODap017264;
        Wed, 14 Dec 2022 00:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=mrumaTnfXhBeA55/YMYHLSuxQzeawUOu3+kHqfhJBBA=;
 b=2H5oANFPjQ4pFdyy1hex3MGx5rKUJNE9JT9C9v6RtmER7biLkcOsZ3xeBh+hHa0W3fNB
 q7GbnSEuntJeMDDy4ou4+5gwdzsQg1kmGvLcYU/J1ct0WagGFKOc8VwiKSPf7e9+X71d
 WtrlSfVPLDCXlVHZMHc1sNqax0o7nv6R94J8j/+CJsTaH1IQ0pgoxlgF85mmaT56pozR
 2YANCiqJuWwW5YjoiqYRsh94m0GiJZKZ4PntW0/x0ippt6+LN610wlJNsfJb+KLmlaLr
 CZejCp1s5nU354RR0vNlj1z8PoN8MVS/tBI0zB9FxN3d+tkTxM5Yw7OY63gpuf22AZ4k 0Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyex0p1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BE00O8k037575;
        Wed, 14 Dec 2022 00:34:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyekcq2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cryk2aCyYN/dYWhqHzU+w/pX/HxH5w8Q5UincHAgBe1XQSDOAk3/BuSFVf8z3pNQJuJtsLVg+ixGt8Ra4OVkOpbxYNOdSL/Sxv2YP76kg+lLif9MeUbMkYWfMugy8EyZOWaJsPadj7HVsJQcTF0zD5mVoD9TBpCnEVlmHvQ2zEajK6FJeKUJyRK2fMpaUplmndcEgH0cab15E8Tx9gPdB7Bpx3vjaNzCJPi7ngPSNjb2p42liRAfu0K+HrzR7bJT3G67NzX1ctJ4AqMa17uPaZNT2fWEdQ6EzWlWcCS7bXPkltXg8vQkLLO/NU5myDEef2BIKZvXrtKFKz752RHuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrumaTnfXhBeA55/YMYHLSuxQzeawUOu3+kHqfhJBBA=;
 b=XHQhqeoB1vZYHrdQVcbDreV6yErO7l3ugEgHlIBVMq4PYPyszCUApttAVTp8p3kp6Hny7QLYVEPjoZ1F5t+69pNU0MrXoeKbH18PT8SwHYnnuvs5Jq/fH6GCnu74mF2rHTreANbvHRtbPCIMFsb4aSOtb6uRlIJo3Y75JGFAW8kUc9Pf9JA0SiymualU8xBG01QO4dhXaKWedtmnQTreZronimmoQVKaWwtK+Lar3evo83jI0KCL8g/o7UQK12yB1I61kXghVzq2g+O7jzRMYl4pODMnQQV0Sl5uqQDv4xizwygP0GitJaHsT4mFNoHafBkyjHDYzNtpzO05s3J2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrumaTnfXhBeA55/YMYHLSuxQzeawUOu3+kHqfhJBBA=;
 b=MjgzOzdUx+xdIdggBhmVUcqto63A5Vlot4IpzxHN2UgKb4IwJpvXZh3bvVwHcv1WIeQ8r1ggUw0JjiyV2c6VvgOZB2GbuZI6mBfyJkKSn6j1rsnkpOHPHxzj/PJAykn3bdXOvDRjCfcewZ5s3FM6BqskFVzKdrS4m3+4ieBpx3s=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5223.namprd10.prod.outlook.com (2603:10b6:408:12a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:34:03 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:34:03 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 02/10] KEYS: Add missing function documentation
Date:   Tue, 13 Dec 2022 19:33:53 -0500
Message-Id: <20221214003401.4086781-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221214003401.4086781-1-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:8:54::33) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BN0PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c434b2d-04d7-4561-3d73-08dadd6ae66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pc3bzzQgB+pBGtxKXyesVXqJJb0sy8d0+PleSiJPIbx9Qiwnsec3u/mtBe+1CfXInD4CIZOeKy8cndpWE/powjyBWgrho3wcRCmg2BJvb/YwxrDu53uy50XCbY+9OnMgy0WmeDH3bbERoZ4yFQjPZtBdY31L+AXgPKcSLSKAEyONNDbRI2kmQvdtrWZgiKgQeuasf3HWcIevC5sVueLsqn1GMvo9GR5QH3w4A5bBpRItyFUt7YnUPPw8yHp5b0RZdLxMbJwu2MCz3YSIO91+9Juh2gEuGNhqdGMs7S8Ox+by4nPRedWFkjkyxVsuVTBc6/PWrGrVCH6zKsW9Y48MQmKx7n5ygWX+yAjNyqBWNq0g4QnhRf1eYBshgV3rYbRN5Bnhh2bmA98rxJYxntlR6t9rN/3sbaFTIzS6NHA5o4fceA0rVoIP48sxpOBeCLguBTALjGKvSiraD8SYuUdU7PpL5hnkJglcjFSfCqri9giSsSeGHMy2q1l+1qZD/2ooX0s/C6O5ZQYIfTuHVKIg8b97ew5AiMzNCaa2p3CPMrueAV4w0vViIQVd9ngnkVP0C2IHRHww/VdocqPojX/yhCElTzfLuSRkZMc0kKBqr2Lo4qWP/sFyoGhMwV9k8oheX+EuAwdOc2IkDgRW+3E6Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(41300700001)(38100700002)(86362001)(6486002)(8936002)(478600001)(6666004)(4326008)(66946007)(8676002)(316002)(66556008)(186003)(2906002)(83380400001)(6512007)(66476007)(6506007)(7416002)(1076003)(44832011)(2616005)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jP6V7RphRfupOGw2VZWmuxGmB3fivuyzmDxU5YRFPzlIVSKpAWBJhIJyF4Xu?=
 =?us-ascii?Q?DOpuKIN1x8zN3vNuC+RWrmR7qIJc8sgEgtDJWUDXJdPNYkbeURGLfVpy9gHv?=
 =?us-ascii?Q?lDHTbuxAeYtKxIowB+3wVoj26u0LENv4Icx+96ukaH2p1qMqI6UlTArX0oYS?=
 =?us-ascii?Q?pQK6Lroat2z1kH9A6YkNGwT1yz+0bXU7dAMUVZ7i9dQgNImOn8UqRh4Nflhc?=
 =?us-ascii?Q?RddE/bvPgvfWNb0kQ2YEBhlNeQyj6qigqj8K64up/vaNWs9a4JVFVVV8wJxt?=
 =?us-ascii?Q?6ZX3tm0ZqIMCg+MKzlt3V+tOl/VIT2hmSeO9cyIusLwkm/rmr/02+Wds7T/Y?=
 =?us-ascii?Q?gE/GbuTSHzBvOSgHGOgz50rUSreaJTh6y/kcYGFgsZaboqtjgKXs4tQTKTT2?=
 =?us-ascii?Q?7v5NmPwdZqaiQ6Ohyv24AxloUw1XkrvmUHt9eGMl94CK05VXsGNpFLF18VmS?=
 =?us-ascii?Q?NF1zfkSttUeXZig3dkeWMPb7ZWs+oku0ShFB8dPEk0RtbnyEXUUWUxET9pEE?=
 =?us-ascii?Q?Bnm1cRvTmcrAoI24HvgSAuxQSH7J8sugois13q+uQWgjREgC02nSHRmF8VJy?=
 =?us-ascii?Q?wE18ptnvP+IvYyhKG2Byo5rBMr2WugVSowSZefvuqnQLmI67MEDq90c2pQ1c?=
 =?us-ascii?Q?OrNzqWCE4zkOEJFUFyhzuEUSkNFUjXDxpvQM9KiYRH3qogO4kpt9Lui8822P?=
 =?us-ascii?Q?G12G3NN9vDHFG7OftI974y24TkEVjI1NooyULcBKkYVXkBJwbGJQQpcJ5uFJ?=
 =?us-ascii?Q?SZJQCTqbN87++ZLMgxgzh8gHy12sHry+f+T/PMBE+fH189mKNh3OgnDa4Wk/?=
 =?us-ascii?Q?bNc4c+8J2micX7WAHcYAbMyk6EVzILMFiS5SxHFunukJkFS/a5Y6b4Mxvhho?=
 =?us-ascii?Q?I03+h8oCS7uYWEuRMGEzfFcnIxFOfUcvcYjZGXL0coqdr+XBj7C5soLQwYUI?=
 =?us-ascii?Q?0iYuGmo8fq6fpfH/9UO1HxJ9GiUTyS7BblwcMUGwI4/iwdSa8lmdg/flTxr/?=
 =?us-ascii?Q?y9mu1/Cc0IhptqG7G6bw67TGGAYNInORWntXge7AuuuoFpqGMbaZWtJe6u8F?=
 =?us-ascii?Q?lUDj/iaORscMfa1N213SAZAspWd4s5roEnLp+LU5/TMuzQC8SrtUiE4LOL7/?=
 =?us-ascii?Q?/E8KvqJoon62kEJ3q40W9yNG9k9g7ryKd9Ip/Qr2EuG9WhK/cl8tf3YpBSU1?=
 =?us-ascii?Q?0GkuDM1PQPfaulOWBtJ5e0tnBH83Br75UqmllVHqxZ0GnQLnj6M6CScMJsnA?=
 =?us-ascii?Q?4CueDLo1ZepYMeI2BPUwdmQnCTLZwNtEcW/KYsZtTmGlN7J1UdqMHpsxPvv4?=
 =?us-ascii?Q?BiqURKj1FBZFIVhW8/nmPu1druoPXZ35rMkLs+JQgeK9p86Z4McFV8/FC57b?=
 =?us-ascii?Q?D3rOpqBEPRb1xh/SumUevfStlrJMBwGnV72ePTwLX3nSHdkOpuJDqbfMwmJk?=
 =?us-ascii?Q?uJfnkG6LmkAyIq+4AH8javGxh5EfHPEbR1jwPbHhk7lwQoXjTsdEkLwmpmrQ?=
 =?us-ascii?Q?qZjHsoC/OTaf+RzQ2PxXhll9dScjcd2hqC5tDJS8eZoxQcBjoDgF4+vvhxUK?=
 =?us-ascii?Q?oXrm2eXVZ0mxsrt20Nhf2L4AAN1k988VVN2LrYijdo8F5FRHrLuRUb+xaZjt?=
 =?us-ascii?Q?AU+ohzDdIJeHYIH12kJohIc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c434b2d-04d7-4561-3d73-08dadd6ae66e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:34:03.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80on8DbYQkpmSDgNX1VcKd5hPVjg18EVHxowwb/TaBE2hp33TubO9lxK5knnoGR4wx5YpxGNEAgcgb+KtrZXyjADapWrMs7ekUoJnEBMeOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140002
X-Proofpoint-GUID: LOc5OV0XAzSPzrNQOo6qN40lPlsZ7hm8
X-Proofpoint-ORIG-GUID: LOc5OV0XAzSPzrNQOo6qN40lPlsZ7hm8
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

Fix wrong function name restrict_link_to_builtin_trusted brought by:
commit d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 certs/system_keyring.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 5042cc54fa5e..e531b88bc570 100644
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
@@ -50,7 +54,11 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 /**
  * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
- *   addition by both builtin and secondary keyrings
+ *   addition by both builtin and secondary keyrings.
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

