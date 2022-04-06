Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ADE4F57F2
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 10:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344320AbiDFI14 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 04:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiDFIZx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 04:25:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8843A67C;
        Tue,  5 Apr 2022 18:54:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235NhHn4006418;
        Wed, 6 Apr 2022 01:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=K5BUsp2UTk6loh0sMFaW0AUvuaEJlajn4DrSvHCIW1c=;
 b=D5Duthtyg52v19DwGKb8qfrcoWJA1YripZLS9Yyc8VFjzCr+A1qswDqHjQtKqOshQDdZ
 iRq8c6CO51obyLC3SvJ0sZ9N+l8nwYa/UQX7jzN5AB0s2NCtkpHH3yB/hkiWtnAfpROJ
 UW2LdxRghoKE6hYfkClm5N36kWGMSFuJqfO+EuDzgI2zznEC2H7kHfWahiuKWtJZh4OG
 wwjzKzmmMHtPSmmGvTQ0acK2jBDn7ERzrwJjZVhrGteoJpTinRN2NhVZYrzGCg6uF9Sr
 E7qQy/z7Q7D4fBbzjWdIto/d+Zv/esPh1CLqsmAhOIbmz/05laHiNa50szsGBNx24IgB DA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31fmd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:54:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2361orv1036988;
        Wed, 6 Apr 2022 01:54:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx43f0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:54:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPNlUhOj1QY3PXbA2ProDCiyenoewFYbOTK3iPjPoBNFQjfD0NjUKrAT70pQkPhgzBgwIrUtM673q9r+VjdNcD0+6y49UKZ6zOeCL8nJ7Ukn9ztW11Y0WrBkY69MYOoEaDkwQMeXWYFeSJWf0b6/lAZVj8miY4vTnBV0M/ZAmM55aJFaqnZho5KUoh2ifFNtxYRbdS55WKbTGKcS/KSNWDmUobsTJgypytjQG0fqg2BjykvS86TM9fHH+IePxzug/r25v9POGXFoQICo4vB5kt4QgYdentJ1tv6ATWhKyhKgrtRXXpp3nw+i12cT2/52qDMm+m4nxUdQy6x3Nbn+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5BUsp2UTk6loh0sMFaW0AUvuaEJlajn4DrSvHCIW1c=;
 b=fqZKhSQnFTNJI4FVxj0L2qSLTHbKge+EoT/1TKxnLWbUAIlS/JFOgnBN8e9fJ98g2iXRg/RGo8Hf6TPl665REEFKPTYXW3XvmbcIRNQPXdEdk+aUqARB6qcgcEejzPSKQvENuIjMuQoUeZ0vCmwoSfFK12bubGdB4ouyUg2YWY85HAL66ps+HoSsFhHpZ9wmF5xmewU68CgKTNfb+aXTZ5f+MxM3CaMg1u8tTV3IqHg4WkPvDouGT3ozKzemQEp+FeCBWhUne9+yW83/WbyOW9wd1O5Hq+AQqzQA8tk3cmC+Hfzxi7WUTlndK4dOdTJ/g9lHFyVcsRaz4bg3EgN6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5BUsp2UTk6loh0sMFaW0AUvuaEJlajn4DrSvHCIW1c=;
 b=XQKvuvu68i5yFjBDeG17hPW+qDhwvZ5wlfQDOiXWlvdGel/XGefSPvL4QeDGFqD8bs8/8wz8tNMV+fiOd/cS+974fAWYUFh2P2JKla+oZ5FRVuKgrLud9OWeL0gfJi85c2Do//19rDKb2YYio3fyULq1NsH92tMuFzVDmbOWsKo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 01:54:06 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:54:06 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        eric.snowberg@oracle.com, pvorel@suse.cz, tiwai@suse.de,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 7/7] integrity: Use root of trust signature restriction
Date:   Tue,  5 Apr 2022 21:53:37 -0400
Message-Id: <20220406015337.4000739-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406015337.4000739-1-eric.snowberg@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c81338bb-f92d-4eff-20ec-08da17705525
X-MS-TrafficTypeDiagnostic: MN2PR10MB4349:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4349AD7303AEC953B398177987E79@MN2PR10MB4349.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SulmLpo+6kGF13hoyedHvv451TMmnduH7JrAklDtImf/MeruejcdW+xp45ljMNVLVkY1Qu9h5IpurSReJZ6U28WXohEtDzG6G5HubvXOwV8MKqxG3FiBwKF5Y9nV3EOyoVIfJ16MjRrcfZn0o8VWxYFFW+gX0IfcHVPMYESbnNucEV1rJduGqxOqp9rV9f2Qkm+rL9CFJMwyoP4RPhjL/GAcjXpFPCUVwE5snL9d+988spuAqLFSVYJHJsnqjOVcnPLgusYMIhMzM20Yp75pJCSODx7h1MElRKwCeoO21F94+pnB/afHVWubTbhh5vgtweQgmN5sIovSmyTkcneuWPQOSOhDoeW6KAoS5I0pwECP9qplIZiPnnk7HtdZ3sYwBtluqbESXojUXZfB0Ul0Tj7HoniOBPG8fnFswdwgiDFxgt9Jwlnrsh54c9nHBSzTa08RpTkuOpnWRoZ5A9xrFCJWPYbqVHzolCH0Nrw3ALZjVVX3WlgX9sj8V5s6E7dtl0NytgVjMnGWzADYrS/u6vkQUqqw/qyoQhbC8dl2iipLeDJhN7mjMXzAtCXXJVSsMaWLd5xHXMLjw+QZr5BLTfIUvnIcndRdyZJOvbP2jhifxhmsvWHgqVNPUXFfz8dxsChIR9M9kvRf4CPxmPpW085btqh/3hasQhHC8lK2Wz/2IgdmMJj7q/1xBuLram7zdou2PBrbhNzVDbSo/PDqlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8676002)(6486002)(6506007)(6512007)(6666004)(5660300002)(508600001)(316002)(4326008)(66556008)(1076003)(83380400001)(36756003)(186003)(26005)(44832011)(38350700002)(38100700002)(66946007)(2616005)(86362001)(8936002)(2906002)(7416002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bxpDFUz0wTLFQdN55G6vRlCAVnLXBmuDMRL8vW2Tv33kJmpBPyObhXW3Cd26?=
 =?us-ascii?Q?bGgf1GPUnaQeaQK5Z1G8lQlqW53zIwMQBy2qIryavXkl9q33jLgLbnhnvHSm?=
 =?us-ascii?Q?w/xE1+EXybLBLoQLvK+ZzyXgI4cimS/ylWJbRsZ5d7rFCPdO0I3hRFaoxVC4?=
 =?us-ascii?Q?yatBCNSofY83ZU9Erx5/zHj8R5jz9limklIEefqHWDhCbAnTc439iZWBEGMm?=
 =?us-ascii?Q?BGELDEBmuzVc1ClHPmpM4MCiPBy94STne7M6LUWPuR5OR8OfytVrCaGm18/f?=
 =?us-ascii?Q?ZXjqb2Eam/gFYKR1rLUSZifBpdRln/fDbhwLRsJLryeAWzvi/iZfHqoK+wZ4?=
 =?us-ascii?Q?M07R+xkN6i/bkyuGybztBCIZlaJgPW/ALSsnGpdtB3qFlE5bd5k9f58g4sok?=
 =?us-ascii?Q?xebrXVW6uPVI01FPkcdjuyT7ELi7O8jd7rDKqH/N4W+ABUOt/SuCApAhThZN?=
 =?us-ascii?Q?76UPeHOT6VgutAW9Yh6a3UxbW+zUZoEwIS1Qq3Ps+9s/Eb2rGXe8KIr9zMXc?=
 =?us-ascii?Q?tJsc9YZr6Igj4SQDBM8YzDOGr3k5luN7O5lUmoQO7EaX4yToRF86iERicluC?=
 =?us-ascii?Q?yqwCzOmONOJsWTuSBV8DYrVCh+qu+cmW5OlubksOA8x7fFt5QZAf6621Oa5u?=
 =?us-ascii?Q?q1iO5V7ypOWDnfkdz2NFf7fkoAdq+slS7xE0wRpMEteHtpjcCVcMPq+GWIgN?=
 =?us-ascii?Q?t5iZS7yK8VppLxZj/0WTo0Kct994SCxmiTnCfSE3+BiN0fi5B47TwBKKf1oq?=
 =?us-ascii?Q?pzJZ4c0cxqk6eUmI3OU/6TkPVepTVvZbKSi3nXsdaoQf9S70o2oCibnSX99S?=
 =?us-ascii?Q?ETc7/+7tqXiWr4g8e97GBemc/BKjSF53f4tHf7NlRud1AmcqzEEfn8Bbu/eS?=
 =?us-ascii?Q?3xTdNkZ7D92bYPZ3GOJbrwibwx8Bnm3NI5Jc4lZsf9Ezgt5ZC4tvE17FgNHm?=
 =?us-ascii?Q?Di/zJESxkApyFOGIbbidb36RWVDB5UuM8nE6YgNE3EEO9rsvLTbVjFSvo9lk?=
 =?us-ascii?Q?XxU7nKj2fT8MdHSByrgZg/AWLzvH83OoQ2vRZn7KmMMYhLFkp6wBCQflI94Q?=
 =?us-ascii?Q?cZ9sedWcWe18Xr9xJjotYW0ThXhR3ASTSTjgU3AUVtEMcOmKFY1Zbq4jyPZv?=
 =?us-ascii?Q?unvnAif9O75cvPbs8usVPatqJNsFlU9aeHonQqeSivgFMGZKo6Frg19T16RB?=
 =?us-ascii?Q?+yoLvnA09MuHRGQUufSOKhesCmRMNgnBib4PjXlWQyAGHvRkcUWsQ3OBzbla?=
 =?us-ascii?Q?S8poDI9yUlPC1XbVT3qxGHgTIqQ0Y+2WVp3g7KzFyM0hzCo5pc6jWFo444YV?=
 =?us-ascii?Q?7i157y0pWVXF3QRbAtYiusVNpAZRr3ZmT+Vazzlxr6WKzH7RMCtWcgU9lEMP?=
 =?us-ascii?Q?iwN5SShbqa6pyHtpK2w7lP6BdnXybhK4PCnfa7V3JnlHQ2FlooBi9YLT8lwf?=
 =?us-ascii?Q?PzsjcoUlyqV4jA0XHH7ij5CtzWe92j6FMM6gb7m1dosd/Rd3zZwMZrXeA+T1?=
 =?us-ascii?Q?3XZhNiO1gK/0FyuCmJ8m0SLHo+UpbIPbZg4RNKKb3lomdYy5R4Qe42rkirU2?=
 =?us-ascii?Q?ObLiXpWDjiadglyOaWok/L6eYUi1QinZl4eksrmnMrvKf+7T/IW1RmqxYLJX?=
 =?us-ascii?Q?egE2bZuBrO6dprkYqWFgcx/AZWhCxIl3/2vTB4FTB+vdZI9dzytCaMDX14zp?=
 =?us-ascii?Q?+q1npckO14xGXjcHD/T5bfSpEOKlaNXVOnQkNLM5py9BTKIhRpWLAhz1RHeV?=
 =?us-ascii?Q?mYvMbWmwP/R308F9ewWrNPYu6qRUVZ4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81338bb-f92d-4eff-20ec-08da17705525
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 01:54:06.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulyK8rGWqtDSZR3JgBvf4AHVhvcQnOBLdMofMHYyy85RwL5evBvTzB7hJBVq6vdmnElsgdf1W/NQlSjF+A+x3Lq/QyNoao1KEJ0ncPxv1hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_08:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060004
X-Proofpoint-GUID: jPDfwZ2a9lKHnFk0tyWrYYmYw8AqKcNL
X-Proofpoint-ORIG-GUID: jPDfwZ2a9lKHnFk0tyWrYYmYw8AqKcNL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys added to the IMA keyring must be vouched for by keys contained
within the builtin or secondary keyrings.  These keys must also be self
signed, have the CA bit set and have the kernCertSign KeyUsage bit set.
Or they could be validated by a properly formed intermediate CA.
Currently these restrictions are not enforced. Use the new
restrict_link_by_rot_builtin_and_secondary_trusted and
restrict_link_by_rot_builtin_trusted to enforce the missing
CA restrictions when adding keys to the IMA keyring. With the
CA restrictions enforced, allow the machine keyring to be
enabled with IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/Kconfig  | 1 -
 security/integrity/digsig.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 599429f99f99..14cc3c767270 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -68,7 +68,6 @@ config INTEGRITY_MACHINE_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
 	depends on SYSTEM_BLACKLIST_KEYRING
 	depends on LOAD_UEFI_KEYS
-	depends on !IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	help
 	 If set, provide a keyring to which Machine Owner Keys (MOK) may
 	 be added. This keyring shall contain just MOK keys.  Unlike keys
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index c8c8a4a4e7a0..cfde2ea9c55b 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,9 +34,9 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
-#define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
+#define restrict_link_to_ima restrict_link_by_rot_builtin_and_secondary_trusted
 #else
-#define restrict_link_to_ima restrict_link_by_builtin_trusted
+#define restrict_link_to_ima restrict_link_by_rot_builtin_trusted
 #endif
 
 static struct key *integrity_keyring_from_id(const unsigned int id)
-- 
2.27.0

