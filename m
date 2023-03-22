Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9256C5078
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Mar 2023 17:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCVQWD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Mar 2023 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCVQVq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Mar 2023 12:21:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68D25AB69;
        Wed, 22 Mar 2023 09:21:15 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCY6JJ002434;
        Wed, 22 Mar 2023 16:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=lGhkscDY4XpxKBaIsuY7bmxasgOQ5OGXrgGjT7bjriY=;
 b=IwTEDXFQRjqB2XMIdcIstdVqSmcYSudH0kZnRxVk0/k05TvVjFxkID5+O3c2fE4eps2w
 Sa4nN4theCYoTc7gHO5m4vNb8HmXyVCx6gL6ivH0mL+BzT726G/OpUM25QjgDmtlr1Qx
 G8+46/CiQwJAfEv9BxHtB4j8p+tWLwz4bKRi/B4blBZGs6ydT6OylS0DzbmRRC6l2nBR
 UWvRFHTVfxJ8IPoq4BQKX5sAeSnJbSHx0aHt0330yD2BfJ7fp4f9bn+yxGGPbTfkzAFh
 Opcrelek68fL/6NxCrSwEQ4lCvJKTICAJ2UCcmiha96svCj0ez5cgejCFQ6IxjTUj8uL og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd47tsgmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MFNqTq030372;
        Wed, 22 Mar 2023 16:20:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pg49ejhxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msM/fTAdJevMWoo//7ROI2hUxmLMzzYxojtUR+UpZ8HJXuZUND68MJX/wd9CUz/P1Se22uXpdO5dFaqP/vHDNj+LYAw0UpxJ0HrjKJPohlilFgtJ29ZQN/aWcMnvO6w+mD5608Ihl+1EqlYXdEhRfGcRP8tdQTwTrHnU9sl69t0vJlecaA6vU375DoVfql96otMcc572hcYIQ+7A7Bc4H3Q0sR9gnUme0su6sPwLL7FI/XPdRLfGPe7PQIfRSH0m4883JOgaZZEuGMGfet3RYeSbv0JQiaeO9sH7hXnTXv7brWg5ibekTdQs52ooAeFnFYWin09SfXqryyGbJTMhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGhkscDY4XpxKBaIsuY7bmxasgOQ5OGXrgGjT7bjriY=;
 b=btsTi00hVe7en2FhruQEssh5jTssdVoYDeaPJZImStC5iMt496wRhtEYHq6tljm6bUwn9X0qCWcelTNNyw93yZ1y5qFQlYLBLF0o7KPjrQhWwiwa4PD3xOFH7u/hayr3HIlHEYuFT+ywkylpbmeqt9scTfcmH/Wmc+rJa5QdgumK+YoC221NdhCH+C5YIQO5CNnTMKSlw5fEj2t7Y+9wCpB7Y6SPFXUXGZojodxIyMJO4/KBk2mNXVbTmHXmJnk6pkaDfpP2JD9w3ONlhf8jKiBlbjSPe4EiANpezvtYv/fIqod0cyQx19SPNp1zMrtxd4OxmOrMIaNj+nrky0gScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGhkscDY4XpxKBaIsuY7bmxasgOQ5OGXrgGjT7bjriY=;
 b=mJ9qXl24X1ltM4OQPLWfvKwcVotzu5bTGMlwGL96AtPGzgBJ8EvLVaHdoZmEQuA0JeKCV17USbWFXddl+KhCQOgvq1k0s037jgX7nz8UqlBAnQbf5VyoM9InK08T4O5p5wC7A822/mq4jr4WzN1NVRvngpIYrreb1sCB602ll/A=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW6PR10MB7688.namprd10.prod.outlook.com (2603:10b6:303:246::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:20:14 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:20:14 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com, jlee@suse.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v6 4/6] KEYS: X.509: Parse Key Usage
Date:   Wed, 22 Mar 2023 12:16:32 -0400
Message-Id: <20230322161634.2233838-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230322161634.2233838-1-eric.snowberg@oracle.com>
References: <20230322161634.2233838-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|MW6PR10MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ee3953-a931-419d-429a-08db2af1514e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81eXPFag3YQ1AoaBt7Rrtjs4dvEm+icG4Oy92djtkRvBbvhGVdI9H8iN/IBcfv9v2V9m1H71Ly+Ga0mN/3BRoW9B4bGyLD6xwKTgu5g2y8z2OB7lEMMybno2iOqzOVEYp3wdEsk29YlyfgcqSp++F3V8/RdCJXOic78sFMz05MWyCY7xiEjDgYpNPaZ/04R/L3/TBwgv/F48sxXuDqdhCWnG5BjBW4AKIcV7xd52CEga5APrbVRUEtcrA76I3T80zCZjGBZwImHj4RAPspO/SLUs18/sqXmzs8/YC+oNvY9Ts0MYBktu1U2kR8GsDeSMyasXKRaAK112JEG8r1LvQTh3kRSL7XgZ770h0dbGsWKrPwT/2MTweiCNYgMK+wy+W7OFdUMk0wDISTWu8bRveqiWCWIvDNU5Kl3eo1/Fp0sVbcEARgf7HzNUjGmL8TNKysR7Sl5WNrzMWVtUP+uF3NRozgBXa7STxffa/s4+bU1lJkxY2NEcgHnQoqj+plumFuYQlaiVYyctVol25ESRKvWk1L555PJoYcoBzefrWxMAQMRKD/7cLZrYPnPMW8w9KibvjWE7r/hz/YHI8wS3/3+q+PdfpcoiRtz0bXR+cC9tsxIMfMvYN+AJSZE6Y6qL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(38100700002)(186003)(41300700001)(316002)(66476007)(44832011)(8676002)(5660300002)(36756003)(66556008)(4326008)(8936002)(66946007)(2906002)(7416002)(478600001)(6666004)(86362001)(2616005)(6512007)(1076003)(6486002)(6506007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?COVsxoHwCW26TVL/dHSWWwtovU3e3SUReNkZgxV88gSpPiOGHdCpKGHJViEI?=
 =?us-ascii?Q?T5PFSXHf65bIS0uar1KqWuytjtktRw58qorzpaXZ3IOODdcwcsmyKxUIVJqc?=
 =?us-ascii?Q?5QwfTlpnXNaLzdv7IQ06LpkSYaJOS4Sqzi+oFHSKgUihUOeEoruQHUzefA2T?=
 =?us-ascii?Q?252r6UGMBK/NOkr2mqlw5UkcvKxTQ+rFpKLs1gRaTqsb4YKfxMA45oiz8mjG?=
 =?us-ascii?Q?5dPhGzPpix6Pakwsk2PqwOC0D3SzaNoPT2iCe0JndKpCD+6KmAb8QCDHlysN?=
 =?us-ascii?Q?t65HYfSqXv612ILHBRBHsHf66mxo77qhM4Pco/hJehKItj0nHUfTIdC14z1m?=
 =?us-ascii?Q?c3aN6+3r+562wrz0DDaxEDUFgHqd8wFSG1JAKys4MIOfHHu8dForA0dShXnD?=
 =?us-ascii?Q?NyrATR66ihKxANCElV5w7mizOoZrysf38QWcb3TJU9PE28qzzkIZ6deb414I?=
 =?us-ascii?Q?nzVA3eqTqIIK666h8xJ+n3e8FiIZC/H6iRCCc6+9BcBJgSvuyy7+/s8n4E8k?=
 =?us-ascii?Q?/+5tLYMKgclW/sIm+WvdDebDHeAiOns2jHnKTZbtwf2D7lkNPU58Wg75YsEy?=
 =?us-ascii?Q?DMfB7G1cuyjZ+ytE7m020RjdYokE4QsG2EiUfYNKJpua1dMk19yHg5xaAMSI?=
 =?us-ascii?Q?f66DaEBwCIiI9hjgIfIQnku8Qdp92O5O9SeQ2julr14C4LlQGu5UOxZbFT+Z?=
 =?us-ascii?Q?brZmrhh8FDdrKnbl7Zq5fCk50Q2Po5oomGpjua3cjon9ZE0T1I0X57VyEc26?=
 =?us-ascii?Q?x4ER1zo5wBhXhGDpTHRubuuaTQXWAoI9zVywW8AMO5t04ZITPuO1iN9zcTri?=
 =?us-ascii?Q?R590F8zps2JeFbIdJg1dR/RDCfp2ezeaiF2CglNZe7De60/th5OeqhzlQdow?=
 =?us-ascii?Q?4fAqfKoY7PLkiAotS8cHTvjUOjOjC/KMQduhdik+m7Be1GYTSEs99IKENPTX?=
 =?us-ascii?Q?CQGlvE4YqttiBV2x8AsDqyNnBoJ81QgyB91/noVY1IgrTk2P6QU/SdjSg4l+?=
 =?us-ascii?Q?yCW0wW6CFq9qj7RQQl6tr8snE0plS7DA6/7rH2U9eVZW4Z//+VUpGVCDhkAS?=
 =?us-ascii?Q?ej072E7Ien3afxDiPy+EmvSJ9MSJzF9Uc5BmhWBbVVOHwZfOt+/g0tVQ6u66?=
 =?us-ascii?Q?hOkEZaC8EnskB+7U4vV+FZVzIqkcoI7cu+XjJ17OPBM9SUeGJzUc5QxvRCZ3?=
 =?us-ascii?Q?91uNKny73B2sAWCe59PCPd/Mv064W1T+hQ0tIj3h2fOH7XedpfNMIn0X7hP1?=
 =?us-ascii?Q?6AsmVw2JanNOpIXbS2ZavnooNxJGtC8FZmBpAuLaAyDVzyyDEHQWyctatZlZ?=
 =?us-ascii?Q?RyLyOpQZo0dUvJWMGSnv1aubrAZte+QazkcXJQCvTxTXJilhH5wo8j966UWG?=
 =?us-ascii?Q?ijIVk53RtBzP93reFTG74ZoZzNGTER8sOC20MHH0UhnNcG2l+UbBUQ8uUg6j?=
 =?us-ascii?Q?wi8yaoHl2RBlzWJjjwfaClWeN6UO3AB3z7bahbwkhmbDre+MwLu99wO0gLRz?=
 =?us-ascii?Q?BnlMhYu0kC0Gk9ZL5AKXQvaehrP9BH7OwjYe8k8NRyscvJaWSPbEzRW1Au/f?=
 =?us-ascii?Q?OXoc5vjU3FCX0zJNurE6uh72eVpOYZY7aN01E4uB6hAnQxspqBTRmMw3qOvR?=
 =?us-ascii?Q?Y7n7UhAgpbviotfQ6lJkcdg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZPD7cZUvXB15Npnkqje4DLCAFP3+A3gdGtFLLtDeOaG/Ma9HcoH6iv6YJVny?=
 =?us-ascii?Q?hNemz3YbuaAYIPbYAqP+TUhQJkPogL8UL+XYNFschlYlR2Sjz8VqF3PzgIz8?=
 =?us-ascii?Q?LTWKhfmQfoflw5lT4UYOkmKWBU+1swkOf3RdtT7qus+ErzCkwrjqusEhjj0m?=
 =?us-ascii?Q?0bGxTJ6e/upvmpJWh3lWqLtC68qJ9yKly+uMTahGUAlB0jKtjIOEpct6MNzc?=
 =?us-ascii?Q?DVqSAyYHkRe6WziZJ/MP/iQm+BlV4dewZhmZteLGiQU2Bl+yY5VAVbkaCT09?=
 =?us-ascii?Q?UkF5D/dXB48G+YIg8rdj6kGy77vVwPo11QRW8TaUGD92H3W2xlOGf18UJqsM?=
 =?us-ascii?Q?SmUxdIIZsyQLw9TmUvJgUa2hzHGvSTTc0cEOVSL4EhQt9TcvUQQfnOatMQj4?=
 =?us-ascii?Q?QEpJKF5QINXF1rchchZ1mOBxBhAkZn7psx3623HhViL9VHtlqN6u3nNSEiiY?=
 =?us-ascii?Q?pg7I1Zgu/s28bTsIRxqvV/OKswit6kiw/6Ah2OaDlclofSuwHTa+v3zVo8S2?=
 =?us-ascii?Q?DXux8qb35nZ3D7K6jx3JyFI1vKLviaDFABEEBuDRWzFYzk7IVvjsWcjIrHkF?=
 =?us-ascii?Q?8YlvAa5H+ofKl9L/x1wRm6QNpRFkFsrVzlzS+fquLtlqJ5BDQVjDYnOlbg8a?=
 =?us-ascii?Q?L0wU+f8OJfv9AxBqecUnBkP+rKUDL/Rs40m9maYb2heuUW15U1kXEANrxRi+?=
 =?us-ascii?Q?Y9JmusYY6kqm+tnW46cUgwLg5/PmUCQHHj3rD2aZC3SLZrgVncOWd/Kjtafq?=
 =?us-ascii?Q?jRLmN2433hv3fdzT+zyfqXMxo2sinjZE06BI0qtsVHDxk2epDn+X99DTG6OI?=
 =?us-ascii?Q?afTsNNfOIQxGHzHtEB4ttb8uGhey/KMfuwHzsNwt+yg5w1Tvlxac1HbKBT4I?=
 =?us-ascii?Q?DSkcrPgovAecRmg5ZHGlJQg+BElNaowgdAO8yRoCw/UsH7K8ckIRAClq7X/3?=
 =?us-ascii?Q?ypLLOXc4Zd29YvxjZjmd6f8l7fT9A1jjuUDMhCrgPQ7OSgtn6T8Y9ghFbKUG?=
 =?us-ascii?Q?On+uy/12odW/SaJrf2UxRBVghtQejnQlaLhP3jnEjrstm1K8VGovxSoWoOLX?=
 =?us-ascii?Q?HDdWGpxllBoL3Et6VSIitTP3WJFXFo1YZuSjh93bTdlRRLUDLt5yShdofi4b?=
 =?us-ascii?Q?so9CzGVECUrmAWr4FD3yup+Iija9atO1/ESSWGufgJS5yriWDdB14T+/yBlk?=
 =?us-ascii?Q?N5drajcG4suRJPSK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ee3953-a931-419d-429a-08db2af1514e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:20:14.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+n4fIZxGxOV8LMnYFYyf0r4ArmORa/TbF3v/tWzoZTr8DvRgnooiFZmnZaAIowRHu/HPFLH7wTMa0Nhhdg7EdrJyHg6B2EPWi7J4D1uan0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220115
X-Proofpoint-GUID: fUe5T_ZkDzErI9fJoaFgWbyRctM4kYvH
X-Proofpoint-ORIG-GUID: fUe5T_ZkDzErI9fJoaFgWbyRctM4kYvH
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Parse the X.509 Key Usage.  The key usage extension defines the purpose of
the key contained in the certificate.

   id-ce-keyUsage OBJECT IDENTIFIER ::=  { id-ce 15 }

      KeyUsage ::= BIT STRING {
           digitalSignature        (0),
           contentCommitment       (1),
           keyEncipherment         (2),
           dataEncipherment        (3),
           keyAgreement            (4),
           keyCertSign             (5),
           cRLSign                 (6),
           encipherOnly            (7),
           decipherOnly            (8) }

If the keyCertSign or digitalSignature is set, store it in the
public_key structure. Having the purpose of the key being stored
during parsing, allows enforcement on the usage field in the future.
This will be used in a follow on patch that requires knowing the
certificate key usage type.

Link: https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.3
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 28 +++++++++++++++++++++++
 include/crypto/public_key.h               |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 77547d4bd94d..0a7049b470c1 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -579,6 +579,34 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_keyUsage) {
+		/*
+		 * Get hold of the keyUsage bit string
+		 * v[1] is the encoding size
+		 *       (Expect either 0x02 or 0x03, making it 1 or 2 bytes)
+		 * v[2] is the number of unused bits in the bit string
+		 *       (If >= 3 keyCertSign is missing when v[1] = 0x02)
+		 * v[3] and possibly v[4] contain the bit string
+		 *
+		 * From RFC 5280 4.2.1.3:
+		 *   0x04 is where keyCertSign lands in this bit string
+		 *   0x80 is where digitalSignature lands in this bit string
+		 */
+		if (v[0] != ASN1_BTS)
+			return -EBADMSG;
+		if (vlen < 4)
+			return -EBADMSG;
+		if (v[2] >= 8)
+			return -EBADMSG;
+		if (v[3] & 0x80)
+			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_DIGITALSIG;
+		if (v[1] == 0x02 && v[2] <= 2 && (v[3] & 0x04))
+			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_KEYCERTSIGN;
+		else if (vlen > 4 && v[1] == 0x03 && (v[3] & 0x04))
+			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_KEYCERTSIGN;
+		return 0;
+	}
+
 	if (ctx->last_oid == OID_authorityKeyIdentifier) {
 		/* Get hold of the CA key fingerprint */
 		ctx->raw_akid = v;
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index c401762850f2..03c3fb990d59 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -30,6 +30,8 @@ struct public_key {
 	const char *pkey_algo;
 	unsigned long key_eflags;	/* key extension flags */
 #define KEY_EFLAG_CA		0	/* set if the CA basic constraints is set */
+#define KEY_EFLAG_DIGITALSIG	1	/* set if the digitalSignature usage is set */
+#define KEY_EFLAG_KEYCERTSIGN	2	/* set if the keyCertSign usage is set */
 };
 
 extern void public_key_free(struct public_key *key);
-- 
2.27.0

