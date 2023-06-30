Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43A67440C2
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jun 2023 19:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjF3REM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Jun 2023 13:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjF3RDt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Jun 2023 13:03:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABED448E;
        Fri, 30 Jun 2023 10:03:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UGiViq026956;
        Fri, 30 Jun 2023 17:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=8JzkDI3sHDCA5AX4xETJsUXcl27Cx8n9BQjDvKJKCWU=;
 b=0FQsxwDNkKPaJnx3PG/aoM9ZoO0hgdAhjIuEZOiz2dgVAjvE43CmgO/jus+LWuxaiRkC
 HegFivycC/ksaQUq/1t2Wg02pERN4ry/yGyedDIKHxyNw506raGYALPQvssFx48Vui8X
 eOMpxRX9BwfSbkURO1rwuqLIM5pZC7QZBOUFMt7aPQU1FvrjzYM9ivr+fo/lXJBf9rqk
 qdfS7hUj2p0q5kpJIoiBFfgVTkDfVYHemT5oOBXEfzOH+baBKBPaV5NuGGaIgDswtL2h
 VSYKTAh9IhmhNCzSYmSpgUyeGuj6nMNyM3wSQ4uM6+3N6gOlSR59uWM/GwCf1q+xI95j rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq319phf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 17:01:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UGwke9038173;
        Fri, 30 Jun 2023 17:01:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxfmxk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 17:01:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaEkPAlO0zXS3hI5dTUOk+6pkvBuyFDa6Qo7T94j7EiwAcIBfYwPBVstPcLrIDO0cGcCTrPLs+whiNgPKI2B3fT0Ul4C5dIZkjBKljwTyutC1B1ZyB0Jmyhyzpu/nAmu2AeBBxluICsK+0VEU9S6eG70fOYjahAqIYpdcjuYZRe63MnbxX49BONEtE0L3Jbb8aS/Y3LctTTjdjmGKxa+v6iTm13gVKpV6eokZxikvdLw2DhdjadZJKGQAzsd2cEIHuSXpT1cBXmIYi7mfF+v86EXnN36M1WHADj+Jjdk2nYcrTNxrQITYT0DfnMAo8GKQ4WRqGvTXsGmvgmnkse9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JzkDI3sHDCA5AX4xETJsUXcl27Cx8n9BQjDvKJKCWU=;
 b=gy1QLYrDqpCt0wsV2/3lfI4ohuYOpofi1sfG9LQTwvhRgLvfCCZgAXjvSkrJpD7IOs1BVFZJdUXWlV/O4K1hx/ySOALScLXYw2eTCFqQKkOVHJGGjDiwsFC8DdK0KUlz5tOdBPTZR3s9jCoMmz5VXoSS4XGVQRUhbuthv4xpLxSA0uEA0D8KFEkbEq2xp0JvDex8T+hP8if4OT6WFQD6qa5DX6G9mVwPQngk5fy8tLNh8DdeoS5+TRhEnoH/A22mC+8acyQm82R632Ur7R0Ke9sZb6QqPmyYKgQehTXmh+tU5P632hS8zeQUog/fXOR6Z+Ots0S+2grB9RcHN9RSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JzkDI3sHDCA5AX4xETJsUXcl27Cx8n9BQjDvKJKCWU=;
 b=Ifjbp+4iB1ETQGkHkv6mrZ/s6hQx9o4i3yGoQwVen6HL9WufKQi8l2QJtRo0xFqqG/mbJJC1NYpsYLCYZ76AxH/PwHSsADMdSVaJvksFsTE0s73e8xPQ0Je12+Y5WAl6HlJi2DiXUs51J5EZBr9o817v+2lpOImYsfonz4Zmymo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 17:01:53 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::6fe7:599d:4540:5ec1]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::6fe7:599d:4540:5ec1%4]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 17:01:53 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH] integrity: Always reference the blacklist keyring with apprasial
Date:   Fri, 30 Jun 2023 12:57:12 -0400
Message-Id: <20230630165712.909767-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:806:27::29) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|CY5PR10MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: f339ea44-611e-469b-f6c7-08db798bb448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yORgfG/2jJbETvQTrsSjEj4GGypmCAW8F5qGf7xXGB1rYySpkcxPsgHEdv0+uUTVHO7c63H0lTGK2uaxZwoYuFsCligLp2f0tRuV23AVVb9B/T8IwatWQqFC+axSiMMJu3Q57RRbMbWhJINiovfNZ3qb88kXliObeaiygCuk/IiByXPxL52iwbp2OqAPo1BRaRzTC04XgnAUHUAOSslc5huQGL084Rl7hXCBM5uj38k4Q/oHxt8zFKcsE4mq97F2ikwPPRRYB6+oB5pkiTyF/MybCKiBazCpcPxwrpCN4e2ea+9nxVkBPXwu9JeYJ9XYTnc1emwJV27g/BLEmqAG3B9tPiVKcSDV9jGCO5X1LgyXoFZY6QzLu1sUHnSc0dd0ISVHhRJE/1yCWMfP5rLAucof+weDqtOgzQeJu5blI50kPtLsHkMoqkXON7X/U+0rJBuQZ/p4aMfUA8rzsKFvV4NfQkFSYGQ8Tn9XhQQec+jZVZSUz9rJEBxtWq4CvjQcbTfkS8zGI0zxyHAo4Xrh3xZ3iryz8oAJ1bK9O1/eOyv03J45USMON+UksJzm4KHh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(41300700001)(186003)(6512007)(36756003)(66476007)(6916009)(66556008)(4326008)(66946007)(86362001)(8676002)(5660300002)(38100700002)(316002)(44832011)(8936002)(6666004)(1076003)(6506007)(2906002)(6486002)(83380400001)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/1dRcnWtx4dFVCf4bnWRKl9J+arYRcb5hqiYcKbGwqXeP4XWKRvo59U5x9SH?=
 =?us-ascii?Q?nbnSuCrheqqHhIYSjJLooKSPsUl5G/eDfOrcosapKUhuZuJqvjPvDBYVGmzz?=
 =?us-ascii?Q?GutgV8IWbVWqBWyCwYYUE6FQ05adMfiiuHC6iswMRQOgROXMTWcC8CXuECHO?=
 =?us-ascii?Q?eDpWH6o+mG1s7XwKn8g717OEPHg57mWwoiXjXD9oeWQvBUVZHEpmCyOAF0FA?=
 =?us-ascii?Q?jLFpv8KoPKpaNjD4vLTNEe/wyL/v17jBtONJ7Fubb7qDZKSi1uWtomjNdaOg?=
 =?us-ascii?Q?wVdKUqMfZC1a1K3xO8vxlOlYEub+iu1oBggQVxTmxZMYtLcCzqNaJVOf23bC?=
 =?us-ascii?Q?nWqOGNOGFFHWOfoWMPU+r3MLKl4pbhu1f7dZ7pfozez0wnFKUNFKbfhnKtq5?=
 =?us-ascii?Q?lFeA87gypBoZaGD6o6RM2M1TAq9KnxgPOSTpulPel9k8wVsFwUhpfRpAlP9V?=
 =?us-ascii?Q?v46DwDScgtL0fdH5+h8JtgxiD0eK2gqe0alZgcxISJEhriqPoJnF74eSAwuq?=
 =?us-ascii?Q?Qpzb0yJw04cwWdmT1Xupdwe6ADs3Y0q8thxuIjYLJBMqhwKgXNIzIt+KNzIg?=
 =?us-ascii?Q?CwWtHDP24FkR5UuLUh+fuNMZxkMYml5CEk+5OK4nzqje8fbVWiC3vZvkvePa?=
 =?us-ascii?Q?VNSO0DK91UoYAs1BEi8z0OV2EZJ8Rr+0453r4msTd/JoJS5JSCINtcG4BcN9?=
 =?us-ascii?Q?WgxnNGTgXVd25tUB9zPiuJ0JHc7JTMOq63iPeuw4Cu7GsVqIAVYxFamkItKy?=
 =?us-ascii?Q?k5vNC9DneIGJ+bSrzhhMJAXXe8y2Y8UdyALhMO0LvCL36g7mFpTksMZtocBj?=
 =?us-ascii?Q?a3c31M7i3JnkwWNkchDFqBvLG+uss70GxqP45XNu1Sjy4aYxMDGz/mOBNohw?=
 =?us-ascii?Q?dW0ZmH5ErmF/yVAoSvsk996ZzC9sU47Uxuulc+SKLuz3nHQB4BNApIcoCw0x?=
 =?us-ascii?Q?lWvBZHf9Vzh5//vWH/1Luopb+Ky38K1zSugHF3drLwvI5u0bp9dwZwiYsiDp?=
 =?us-ascii?Q?q/tEchvzydCSbNJzEYNv08rswsmghsAsLBvJ44wJ6op2dgZmNohPQJpCOip8?=
 =?us-ascii?Q?8dmaAmorQkytNPaqUQQbuA+gLxDzj5jHkbgMLBlpjNOwVJtFb7RNDgJ4InDo?=
 =?us-ascii?Q?GDrh/qs4ubjTMbO8NrlLDkRHCwjWROZ7crbQmYCUYcDC0XOpHtdscpbM9LW7?=
 =?us-ascii?Q?ijT0M3NRQZuUuT41C4N23qM1A0i6+Dtwcw1ER0BmDGs+iWEaV1tI5LLByyvD?=
 =?us-ascii?Q?wpdA0h8OVKEPGWmA1yrOP/r0plpI3DPzGNmwp9/02aTSiaowtJ8qCOxcyD2p?=
 =?us-ascii?Q?TzDTGks4mYBqHtV1ekJGQ1xBOsGFnIR9hNYr9IRFw7A76lZNaoZA8VZqLhon?=
 =?us-ascii?Q?w11uwzZfg9ZNl0Mfksfjf2/MIhJMRIbV34I0IH/ag+wsGYVFb4nw0eheW0sJ?=
 =?us-ascii?Q?nNAIb0Bf99Sx5TER63nF32a5ux2u7WadzxSYThi2D8mqYiPuzgCSKVkoRsly?=
 =?us-ascii?Q?Eb3zXFqEbl1v72JmDVZ55EdrbDdBFf2poz84b02SZaKO/NWEY7T0aXVLWYUJ?=
 =?us-ascii?Q?Vnk1/lQvui0nZq7zdGWcddYkHdqASMuE6og/E1f/QWt96MxM+fu/Q4shyOHD?=
 =?us-ascii?Q?M0pOfnmBqZxSBk7kNl20SKM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?N3JDCqGPkdJDRWl6KaWduZkjdGMGTEiFQIrl+VptyUjLQ7DRQL1V+TiePme8?=
 =?us-ascii?Q?Bk0Dx4GNHiQ/kSYvtGWd2dTex0KhpJ+EjWTtstQLb22IYSF86Ynlpuy7t2a7?=
 =?us-ascii?Q?zwGvSwcuI3z+dr3GyDkkzMu5s2J2+Haugxa1P0qPODmw0UWHrG/tD+V8UOfb?=
 =?us-ascii?Q?DxOarieSJIgST9ZLUw1Lid8bWGiCUlx+G1ByB5VB7OPW2jj44tTzIkGI7HbW?=
 =?us-ascii?Q?lnjNbPL8JOYcLGfTfx+NUNm5zMARFX1pDEPApKU6hh9B8VZ39wTibj/4z8RG?=
 =?us-ascii?Q?JUUiR9yz7y/4WzeEz3eA7LaD0bh83xlyhYADpv33XdFkHmRJ2RveDG0RJ/tY?=
 =?us-ascii?Q?P5KbD45qGTycJTZL2rNmkAzhOFhzkOFJ5LPWv8LNmobradshTH7W6Ed8bRyA?=
 =?us-ascii?Q?Y8pEO1ME7/DzwCMQS6Yq8uEHKRB0xAOX4853kgL5PUG+1jCpLnBu8yp6Z+tR?=
 =?us-ascii?Q?f0J95PDfB8rEP09KdO1ODLFgb0z+3IXLgfCvnwCzo+Id/WfYpN5/U6uAX1g8?=
 =?us-ascii?Q?+oPEfvI6bq9g4ilnh49DWoGRDEhYYGBgIM20EC0v7Hq1QV5eSI3K5T2zvcq5?=
 =?us-ascii?Q?6bNbw+gzqFK/7fWfVCzE+84JfzDomkPa84rgYjKJJkqSzGLazjyov2nowqV/?=
 =?us-ascii?Q?gwI1bGvIX7wba1hX2/r7IDGl1pa7NCLB295X0RT7ATRoBVtfzqIkHHg71Ojn?=
 =?us-ascii?Q?DrYXQgexONB8cBaVm/tOixqiSVnt7RnScyri+OGYV3UDgcwu8D2oLwnc8W2h?=
 =?us-ascii?Q?kjuFkv9X8FZVN3FIErZT6kJF1DvmD6ybHyBZAdD27twVJ99cTseOvQDMiJZA?=
 =?us-ascii?Q?MQ5A2fYxoJsfYvurPOB9xbyAWUd0mB6RoQVHKIzUqP20rIAtJ9YgBLFKkTMG?=
 =?us-ascii?Q?FKRSlhoSDDtBUcFYaB2+7V3RYM727SreNit8CTK5K12cJX2+O+2WpPTUIikS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f339ea44-611e-469b-f6c7-08db798bb448
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:01:53.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqA6if3HIEagg8qGNuS4Nlag5SrLXzfp47YM2bs9jrSQ74KPUpYvDr7i8T8z/3PamWxT4M/astosVW4ZfnY5a6hBb8IeAJEoOSN3teRwm3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_09,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300146
X-Proofpoint-ORIG-GUID: urGeiPCiyzMhR8jjYf4p9KdnqREN2AdO
X-Proofpoint-GUID: urGeiPCiyzMhR8jjYf4p9KdnqREN2AdO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit 273df864cf746 ("ima: Check against blacklisted hashes for files with
modsig") introduced an appraise_flag option for referencing the blacklist
keyring.  Any matching binary found on this keyring fails signature
validation. This flag only works with module appended signatures.

An important part of a PKI infrastructure is to have the ability to do
revocation at a later time should a vulnerability be found.  Expand the
revocation flag usage to all appraisal functions. The flag is now
enabled by default. Setting the flag with an IMA policy has been
deprecated. Without a revocation capability like this in place, only
authenticity can be maintained. With this change, integrity can now be
achieved with digital signature based IMA appraisal.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 Documentation/ABI/testing/ima_policy  |  6 +++---
 security/integrity/ima/ima_appraise.c | 12 +++++++-----
 security/integrity/ima/ima_policy.c   | 10 +++++-----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 49db0ff288e5..a712c396f6e9 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -57,9 +57,9 @@ Description:
 				stored in security.ima xattr. Requires
 				specifying "digest_type=verity" first.)
 
-			appraise_flag:= [check_blacklist]
-			Currently, blacklist check is only for files signed with appended
-			signature.
+			appraise_flag:= [check_blacklist] (deprecated)
+			Setting the check_blacklist flag is no longer necessary.
+			All apprasial functions set it by default.
 			digest_type:= verity
 			    Require fs-verity's file digest instead of the
 			    regular IMA file hash.
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 491c1aca0b1c..870dde67707b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -458,11 +458,13 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
 
 		rc = is_binary_blacklisted(digest, digestsize);
-		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
-			process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
-						   "blacklisted-hash", NONE,
-						   pcr, NULL, false, NULL, 0);
-	}
+	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash)
+		rc = is_binary_blacklisted(iint->ima_hash->digest, iint->ima_hash->length);
+
+	if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
+		process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
+					   "blacklisted-hash", NONE,
+					   pcr, NULL, false, NULL, 0);
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3ca8b7348c2e..71e270141101 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1279,7 +1279,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 				     IMA_FSNAME | IMA_GID | IMA_EGID |
 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
-				     IMA_VERITY_REQUIRED))
+				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED))
 			return false;
 
 		break;
@@ -1354,7 +1354,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 
 	/* Ensure that combinations of flags are compatible with each other */
 	if (entry->flags & IMA_CHECK_BLACKLIST &&
-	    !(entry->flags & IMA_MODSIG_ALLOWED))
+	    !(entry->flags & IMA_DIGSIG_REQUIRED))
 		return false;
 
 	/*
@@ -1802,11 +1802,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				if (entry->flags & IMA_VERITY_REQUIRED)
 					result = -EINVAL;
 				else
-					entry->flags |= IMA_DIGSIG_REQUIRED;
+					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
 			} else if (strcmp(args[0].from, "sigv3") == 0) {
 				/* Only fsverity supports sigv3 for now */
 				if (entry->flags & IMA_VERITY_REQUIRED)
-					entry->flags |= IMA_DIGSIG_REQUIRED;
+					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
 				else
 					result = -EINVAL;
 			} else if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
@@ -1815,7 +1815,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 					result = -EINVAL;
 				else
 					entry->flags |= IMA_DIGSIG_REQUIRED |
-						IMA_MODSIG_ALLOWED;
+						IMA_MODSIG_ALLOWED | IMA_CHECK_BLACKLIST;
 			} else {
 				result = -EINVAL;
 			}
-- 
2.39.3

