Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B5170CE95
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 01:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjEVXOV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 May 2023 19:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjEVXOR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 May 2023 19:14:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FAC118;
        Mon, 22 May 2023 16:14:04 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKNvsA019660;
        Mon, 22 May 2023 23:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3IlKownzKQnV0esoc7tiWUWS3dFXuN+CS+6glGtutmw=;
 b=Uj4Gti4RgKw+K8nKNe1XN/+2O0g8Utwob7HHjcf9s6AnQ5ZNNjs83KlGFCZm6Gp1wjyB
 nCIFa77xdSXpW/GK2ARFP4wtp5e4iinHhaVNaHiVJ/kqr2+uIZJ7gau5rt4Jz0uGhP1E
 dOQ/UD13GCTNAgA97bj6+6nXhuA4up13+QzCUOHETCGdx0fO6qtBWerknLPDLdOrPxVY
 fXGw01F7iIjTf7ZgBdS7ARzlGujaQbbS25DSnEwabzjKU9yZOixi0H43EH1oQR0vn+ME
 dJVghV3JQjOC+sfuXvtQLsQsFYq+P385YTkXD0GL5mHPOKPxJYxOcFHWYksn02HDgsze Vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cbwjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:13:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLeYVV013062;
        Mon, 22 May 2023 23:13:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7e3asj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:13:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJtF42PORVSrThw4/FvKsbjEVUl5PAlzEGhI1PzLlq30cZ5CyS/tqFoaZUQPl0qj0JZkyLrwFHVOhQy+fYDQdZN00ChOfLAqveLjVvGQr8SmZj9tqlRWVZ481y1+vuuPV9QeWWLYimIgruz5QaE7Mr9kws5Upxw8vcFpf3XBJHs9Tw8YT6tg3NhqdZOVi4cxgQK5nURGhNe+y9l7j3J6liBc9dz3/JFOiw/ZK0jEQVAONNVpBuSEDMVoqV039qwLebEu9KNws/6Ip0eMidiPUJba2T/jdfftVELk0LCVuTnviD6nK3a+Ly9FyWI8IIlClzwWEiC5vPV+eD8PJCR+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IlKownzKQnV0esoc7tiWUWS3dFXuN+CS+6glGtutmw=;
 b=iv01GkXa9U6H6LxtT9PFo7J8QkUqf6V7RVPn8yxoyAhKxI+RjdzrMzUPJ4pv0ewK/t4GjyuVjZbmTQhKd8TWYT51jlc5hGUviaLHpFYRR7avws5dGw425gf/ChPhs3v/8w6s5ds+NPTSMLdw+pXnetpPnmH5BfJhuK/RWgNYBokFk1qNwonrWfmkHLoYWOl/df9YBKQR6uoiViQNPlmr7ZnBeU+6Bvhsol6mk6VOCHI7o46BarzW/aeaObYslSEEoV19cloQg4qc26dHzJLnfYiMnqlmw4u8dq5y/bJ4E6sy6qIG1N45RFWA7dLfkSmO8GmRlyRpfm5H+izDmPaiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IlKownzKQnV0esoc7tiWUWS3dFXuN+CS+6glGtutmw=;
 b=of4FQ4pn3TmvpxdezuRuztS/EAkZAZLi9kjFIP711EivSZRD5PFKjYJRumzv0LAKRo7mGT5hOdvzpFy/a3Kbj52ICrLWPT2PP960F+VFqrPmYdeWZ1iOP0lzojz72qDewXqjg2RDevvX0kiepSHls4EPdrOeBfxRAL75YmL1Eic=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA3PR10MB7095.namprd10.prod.outlook.com (2603:10b6:806:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 23:13:38 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 23:13:38 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, jlee@suse.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 3/3] integrity: Remove EXPERIMENTAL from Kconfig
Date:   Mon, 22 May 2023 19:09:44 -0400
Message-Id: <20230522230944.180389-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230522230944.180389-1-eric.snowberg@oracle.com>
References: <20230522230944.180389-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SA3PR10MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 0022ed28-2cfb-402d-f9cf-08db5b1a2117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e50ARCgbg9gMMxVrt9xNbROCcqbj6pJl6MlTWr7tXQ+zNiC6E1brxkU+yJCEEg9HYUhpGTZMh2a1QQ58P6kfnJwg1DsbXcfkK2bFSmsNapZxmf5f++t91/dcvFjvSEd6+82eJgIcwbZW3BwcWDjQDeTsxDL6JEMMu/p+/y/OsucPiwIcKVrxq3Za5UqjrXx2JqkuamTD9E0YwrlDNK7e4mRG7Odh5VS/FAgIOqpP/xXG+qNxKl5b8N5Zad1L0CTGI3fobfqSh+SFj/0j45Min1zmWpQFHxCPivW1GswMF71UruJkJsRunUKM4TegiP9zvTumNBSOrLi6YpGMUx1nr0CIlZfF7VYKM97GZLVrgDc0CMb93WxLYGaBGM83gSpSBVLUWBPY2GOGUb57R4EW1UID9V7S08ZaAl1npe8zqwAP7SPceeco/r7DWwe5k8vDhKizIRuD/shgdBjTvYrheA9jaJbur52DGQ/NJEqc6O0VWiCbdwAeH/R0EE7GWxJ9jQ1OXF9RDLZY2hcQgbys/91onxkGf9KuT7eLV2skaWdU/L1kUyxVVuooz2WSCuAV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(2906002)(7416002)(5660300002)(83380400001)(44832011)(8676002)(8936002)(36756003)(66946007)(66556008)(6486002)(66476007)(4326008)(316002)(41300700001)(478600001)(6666004)(86362001)(2616005)(1076003)(6512007)(186003)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K2i/4X+tomsQTln4phHbpah+9Tm5PJVSF33PE/4PI/+e1MMhWujKHQ+nVQB2?=
 =?us-ascii?Q?KbrxBRXfm6yW8mqmbsBkFQ63fTUBHSBqPIrLBDBJFClZgxQBy1XPCrztgVhM?=
 =?us-ascii?Q?vegUMp0bQ7jHnlVMcHjKJIw5tnGZgV4BPYHBGb1BuNz5LTN4g90eqrjoIh/m?=
 =?us-ascii?Q?X4Jgh/kyp+qxdLVe7xS3Pn8pgh3IxhsufHYI6AdMSL9LA/nuDGuh08YiPapC?=
 =?us-ascii?Q?35+c33AUVMDO4IFdbo6/bwf/aK3D5hL4IWdyLHP+XDRlYSdmEdnhXxp0eJ+x?=
 =?us-ascii?Q?CkPhPNuDIihxUGvqrsL92theHjJ0ccYgw3u/TCbpjhL+YpVx5EW+fh0kaeCW?=
 =?us-ascii?Q?0wzpoJ9iSfzxPClV8mtSgGmQnH+sXtRuHQUvJ5T0xYkA9FEaEnLG73RfKJTu?=
 =?us-ascii?Q?FNStsh7A4o9qg9GguynLe/YrVPRcRSS65i42cPU22HayX6IiDI4+z8Tp/4/J?=
 =?us-ascii?Q?3Yu1bvToe4y1WVs8BjJdEshUib5vpK2U5UDwuxnBAjnUQp0NX2dRj0hhA6TM?=
 =?us-ascii?Q?4GNlxqVwU35cQCet53GJbF8sFhLvuUfpR/BSvH8YCiR6Yyx08/H/MUpZEB2h?=
 =?us-ascii?Q?ouCpf50sSv/Md3Q2x/Dkb5r8slpm0wmO8FRDWIL3ioSSYUGaL9zPz/i4gPIu?=
 =?us-ascii?Q?2T/QBFQpQbF+IUyC8H0q5nzKahWi1/l9Dy4y6id6vXpG33kuaY4LSEMruKdz?=
 =?us-ascii?Q?2KnsvqKDxLimsrGfE4ZsTGCsDwQMMAfiHjprl5uQ6b0HjxY+qyuyGGxAFCjU?=
 =?us-ascii?Q?5ZXjYnPmg84njQC0hJ5XE+z1jSEDgrQQ5uJ2MAvI7RFWMuDKbdiVaFBFXOAu?=
 =?us-ascii?Q?/8ht3tUdghrsOc1pB0TsrCXKn+DOKS0kJZb24S0+YJUXTlPklsobSs04x2qF?=
 =?us-ascii?Q?4cMZDybaALUrh46LNK5GMc4dsSO3M9u6rMWjhJrqLfnUdxPTAEd6KpSdJmmk?=
 =?us-ascii?Q?GpzzFpgGjmObteyNRLt897T++qnMZ1Jk+5/lEsWZeEDD50viN32ssBeh9Fld?=
 =?us-ascii?Q?uRukPk7vnUYok1ZUKRZrkJYszOvPSeEhdIkBKmTj3/haThqnuwQ89agtzuuI?=
 =?us-ascii?Q?PgbqN1Ja792HtUSr7NhVQwQd7LcfUbmiGR8SbV2wfRbsEmMXX3NnYkGCfW4i?=
 =?us-ascii?Q?/5Ah1dpPP1S9RaWtjshRmcyXK+j+EwXByKeaxd5y7rkY/RP6sJ6yXY3LTdio?=
 =?us-ascii?Q?x9JEamySso4QsnQWtFB4CEhxYiwCQo3fy/sCd4WX/iqJFg+7i1Sq3KzZ3s8c?=
 =?us-ascii?Q?dGp8vqBK11vi24GB7NP8GfrCd2Rtxu2hw/tmwZQyVjga4jZWzhkAwJhEpsKc?=
 =?us-ascii?Q?Qqr9x1ICmU8aL6ksDETJq1Ifj1oKBGz8BnaWsBhhYJTN7ZOJix1EVxun3KmO?=
 =?us-ascii?Q?Oap8IQA7+alXEjlAUTPpjWHZtY1allPiwa+iQKFpTNkIwLMqTGRz44kr7NRu?=
 =?us-ascii?Q?i9X4XDlWka2pe2VQaw6ufBRhvqKwwyKHHJI53Gf6mjKudOQmhck4sw1HY3Kp?=
 =?us-ascii?Q?iUQvi7GS16UcPdjN2+HJwgo4cpcOH9gnUcmMniZHJX12oDC6hNF0e3jGzoLt?=
 =?us-ascii?Q?CgJFDbxTynhT7xWHE1D71utDq9NHv7pXKFh7EyuidVQhlUJ+Fi7T7LXSHo7/?=
 =?us-ascii?Q?pKMrOdC+7xK03cwKs0e+ik8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?q4/Gb/t3eD5pVbp6bO3zNHu33QJ8HZZ0YiNGBi/IbEKnjYRK4XYxNxH6rvjO?=
 =?us-ascii?Q?lcOMJU6CPcoZLXC/q6GzPpLDdcSm+V+RdsXMxNKhBtSSnYERBqPm2KHhYGC8?=
 =?us-ascii?Q?7OwneQq/m0K7RKmil81Inv8avySN0Q+qPTnpdUWDdpdkPiWVRe5D8UbBH4zu?=
 =?us-ascii?Q?5KuL2uNoreDEWr/YYhg1GoV843zVU6PYc2D/4ATjAzTX8Wk+1fDPDDwgtys5?=
 =?us-ascii?Q?VWpj6YTnGcYTXlX0VQFoKPJSeZakzEKWh6tPnc9Kc093GH2l1Qn5gbCDmQUc?=
 =?us-ascii?Q?2M9Oo87qqEsZH7utjrHkoDZJDV3ti3guAmJkPKG04g/71Ce/gp2XDFxYsNXT?=
 =?us-ascii?Q?peAfDukzu4vjMP94pl2Hv3moqIeBw0nOKVHq90Kbarnb/PuDKAEf89/kuO6g?=
 =?us-ascii?Q?MtDZ/A6Eoh327Z/7+SneZYbSnTFvRpCT8Igf+TpohKnP4HqJINts9R/HhGu4?=
 =?us-ascii?Q?BhzRSf6oCIoIU0fWx6EbXDmsCerZoawXRc7rU6wrP7moWUpkJkCeDv6gRpR6?=
 =?us-ascii?Q?xKbeVfHD8LKiRbyRpw9BdqFHXxoyAZHKC8f/UCF8rj6VY+Tq8ZNLo//fGoG1?=
 =?us-ascii?Q?bLzQYiVPw8vYMOUjkEbNoRW5k5lurDEKVqAYK2Qg1k00k5FkQTtHkJlE4ihk?=
 =?us-ascii?Q?UojYfgSvPqKo1CnvZDDn5zJ9L4+iX0WNdHBj3+8APVmzZrZZtpCFzduBr/s6?=
 =?us-ascii?Q?5CU8Kf43PorlSqMAZrC90nJti1nr260RXn46QyYXOUghrt0JAyl2c6kImt7g?=
 =?us-ascii?Q?gZtvoEE9XRCsqD9XJjFN66N1YBBzyUaBbbM9VRea4XECzgKi4MyWr3ueYfPc?=
 =?us-ascii?Q?Xb+KS+fLNQIFKExbhCfdRKA8MKeRaWbGed/1w3mAttF8Dlu7ltXFQgPEdR6K?=
 =?us-ascii?Q?HJ/bKHl0SIHiw8RbPu/NB1yOBU9cejxVQbhyftasa6WPDZSjGsO+QY0IX53m?=
 =?us-ascii?Q?XLWm7iKRzVqd6JCSxUBlZpnFFZEpRWX8n2uFBanMs1Qr7+UIOTINSmAp1nFS?=
 =?us-ascii?Q?9te3BwLtW+L0M8alUlrD31tiRLR8wzPT/Q2c0KSGqOlKsXoz02kp98EuXq5h?=
 =?us-ascii?Q?2wmpZrYE26j/SbNlUjNUSChDfQlgVqmr53T9rpq0H6XDL/Pq0TM8OSVSJtSN?=
 =?us-ascii?Q?73XHY+M/qgaS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0022ed28-2cfb-402d-f9cf-08db5b1a2117
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 23:13:37.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxHmmhmrxN5mrCfk5eaYYUPYLQy87yxry4RnmpNRXB9a7EnER1BZ+C8baSDgiRwtHHxD660rd7jiB2DVjOnJ83QUBIjzWe1ukJStWEBRLpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_17,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220197
X-Proofpoint-ORIG-GUID: zJ6RLlJxzVGxlafb0nI_WxReJu1L0fLa
X-Proofpoint-GUID: zJ6RLlJxzVGxlafb0nI_WxReJu1L0fLa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove the EXPERIMENTAL from the
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY Kconfig
now that digitalSignature usage enforcement is set.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 684425936c53..225c92052a4d 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -261,7 +261,7 @@ config IMA_TRUSTED_KEYRING
 	   This option is deprecated in favor of INTEGRITY_TRUSTED_KEYRING
 
 config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
-	bool "Permit keys validly signed by a built-in or secondary CA cert (EXPERIMENTAL)"
+	bool "Permit keys validly signed by a built-in or secondary CA cert"
 	depends on SYSTEM_TRUSTED_KEYRING
 	depends on SECONDARY_TRUSTED_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
-- 
2.27.0

