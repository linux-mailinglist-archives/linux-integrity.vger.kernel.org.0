Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD16FBAE8
	for <lists+linux-integrity@lfdr.de>; Tue,  9 May 2023 00:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjEHWLe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 May 2023 18:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjEHWL2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 May 2023 18:11:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF83D65A4;
        Mon,  8 May 2023 15:11:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348JOfdT019671;
        Mon, 8 May 2023 22:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=/ML4z9buu/tKu3pmw4Uu+TAMQuENNubX/WpRl8kjGMw=;
 b=HGAZJSvRNxqUYJoNZAZTvgpx8alticJ0txdZhzIUkrBn2AsgGCyTwM05BDfHh3j4oh6T
 PgTMuxOHE8OSGLDv9RPjDyKjg1jOTZAU5gjRzlvx6k2kp3ikIxmjxV5aq14jFB8E6te/
 gdLZUelmNZ0sxOjWU2LFGQ+z/waOd49EfggnwsczYKxtPTS8reCpKc2OaUPDr3sky3Uq
 R6TZZNh9jiF6OjGjDYnGo5CHWEXph2KQfAdujZz3/a3RNT5Mzs1EeRXm4qByjp3X1e9t
 si8xErXMrPCo5/yGZ/0N0OeOIcKgGj0ps3sJE68lMsNyTGPNumqrgVNijZ2ArxnZx+iF pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf778r9xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 22:10:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348Jv2Wo005865;
        Mon, 8 May 2023 22:10:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pgc65b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 22:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGa1fXS1Ze3QUDA+w2R+rlkgBBC/5iuLUe0F2xpv0jYiIgSPpnDkIIvSF2g1Vi4eFwGapqfNqmjoMMp2oodMg3Fyz6U5eR7d/WByMdtomo4Ugebuw7DFe7zW2w8nGF0apE3+dBl9hJZb3iB0de1YggnhcL1iEvurcbixte+0kphU/11f49mbwF4canX+nWndZLGyupxvQYCtJ6b3UJ2Nh3wjUYMg9OL/j0YbYKmktBIW38z3pZFUngUsOzp7SGMLHm9m2Kjve5oaLeV4QlZRM7xOualu3yGaAeBqncreByxYcQ7ioEz9ZAhRTYTQWDSW0br3FGjgz74bUM/FOIIF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ML4z9buu/tKu3pmw4Uu+TAMQuENNubX/WpRl8kjGMw=;
 b=RZ5QZTOG8vEkEQqbgMBYTkf9HDnx0dasUKiheaYC0Vc0AtDMS5uL6tGbqBaGzTINl7pbwXP2H2nryV41nvMQuY5rYYSz3oIsYbWTlOV+BljabYKLbCvUaNaRpIs4QAYgck41fDQDnvjB1gW5rbYElGPBtRwLLk53gj96FCChKt7hUNXtZ7Xu1tqQft6hiaWd1Joii1IK9/jBPAbVbS1cbZnED1CewkG9BQohaISLsC6WyjZqx61/YbY7nEhuDhpSf+dJWviXt5nyPHqwWfioU2fBy1Hrhjw+yBN4f6lGpYcO4gZK4lGBWKLGWWzD/6XJeW7dNMr/672MDJ7M/DGsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ML4z9buu/tKu3pmw4Uu+TAMQuENNubX/WpRl8kjGMw=;
 b=xRh1gEZCrCPlqeUSQNXN5pQ69JSu9QRwsWdBnpfGYNHNiPzGVGw19ZbrBXPKJdb1iP4a2BhNO865fPxtuYdYiT1FuUVSBuXuVx1iRaRHHmsqLOirGcpxpS7tBcTGq2Ky5c+ETJ+v3Wec8r/f6AoCFkP/oyAgKy51mZvS1Y0qmgs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB7065.namprd10.prod.outlook.com (2603:10b6:8:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Mon, 8 May
 2023 22:10:46 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 22:10:46 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, jlee@suse.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 3/3] integrity: Remove EXPERIMENTAL from Kconfig
Date:   Mon,  8 May 2023 18:07:08 -0400
Message-Id: <20230508220708.2888510-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230508220708.2888510-1-eric.snowberg@oracle.com>
References: <20230508220708.2888510-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0371.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::23) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS0PR10MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: b6319162-f24b-4e5c-f0fb-08db501112d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mK11fKzeBN+DuiFGPULydUxcv+z8d56Os9tPiZIU2MDmzOEBMqpAbPbwwc85MOx7Z2F6XgHOGXKRDOOHnp7iLky4bDINBmQzBASOsTUoZwt3Tu3XcDatpmWR7S8Dcm/XCn65YsIPXcVlTnY/hhMkjEFfXhPT4X8vWkJ9xA0ddNidIUsz524vSsTt90WfdTCfvV6IxZM7327/k2zQCSLC5FiHUp/99M4v225FrCFWOiYrJVvh67fzxF5rwHaqHS3OeH9+cxGn5CCbudnEt2LRdHkulvyyT0AAVPIajtOgc9cxITHjt5HRhu9WlebH1wWfFo1wEQGlzB+DHaZplwsFtFM8Pj37brbc1UQWfnFjWqKaQaRaargvaOTjP1thnOpX5yd/0AMYZdSlPPs46Bi5EikjhILE/5mytx2qlYXmtrjUqELv36qbPx1ApxaMID/09DbWWLJcbQSLwpWpRcw8a+7KcAAiFlEfGlKe3ucsCPDNAysMGlyaoIS8NgteF9iXxJKrfnjmV5W9CMT6wbT0VZcBTpbKKA4BVML7MngqGXo4PZ9+bNEy0c5JXQkjVHeq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(83380400001)(2616005)(186003)(4744005)(2906002)(38100700002)(36756003)(86362001)(6486002)(8936002)(8676002)(316002)(41300700001)(6666004)(5660300002)(44832011)(7416002)(478600001)(66556008)(66946007)(66476007)(6506007)(1076003)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKWend+t8WvzJeg86uixEx2F+LdKsSvzKlgrps0ICELjgszCrc7GUS0gC8cA?=
 =?us-ascii?Q?WiUiF33wY2nHLPPW2UG3vzvCPdTMk7d7++hduwl4VIB4Hl/eMu0goqgUTJLp?=
 =?us-ascii?Q?aQ+ffd/LjW+H/THH22nWZlXTRkkt6LGbEJVNe0bwZi8E1nrgoYNVw2v4SGhW?=
 =?us-ascii?Q?98ChifDagvvDvUdkR6SxtIei+c8R/MRvAjq9CEZwYaqvNJ2X+a7k2V4IV7NH?=
 =?us-ascii?Q?vh3OuIWLmZuY/Oc2/KnQl07nU8pUMJl9473EiF75avhx4zsNmxrFBHk3jBdw?=
 =?us-ascii?Q?y2mdRpoQj+3KAM57DJPexAwTrhNagE1dqRxczbqcrrojpjE6ES1pH2A7CEIf?=
 =?us-ascii?Q?RyJln4VIbq6/mcWmL3wHb1fivbUXiDldTu4rrvlVdJgTO+lZ4Ad8bCFW0/Qn?=
 =?us-ascii?Q?hNbcTjf1JF8TqzAUGFNGs9Gd6Rg8sBYswnX4w10ltIP9+pRs/qKdIJhe+d1N?=
 =?us-ascii?Q?d6/KdH8JJnu/JZ0VRE6UHZCPygPnLRQaiJhKtU9FC/SZkq0GhwDQundgP30l?=
 =?us-ascii?Q?1y/KBLJY4A6o4bufxyZ6KGwcFWEq2GLFiWUIzWvIxXer6RyPMR4JlSKyMe1n?=
 =?us-ascii?Q?v+TqkNgERn7wG5HlHruayW8vouXAWe0zy6GbFlmQUJtyFuswX9YRHTD4EQjg?=
 =?us-ascii?Q?Zn035M/tQGUfeCrbqhUocHU71E4x6ROmtwLQanjaMNlYn+eGmYzZiGnzbSWK?=
 =?us-ascii?Q?CAciSO4aCfeGX+3s5PtswDAwADgHtVyEDittafnGgCOmC/gY04Winq7/SOgL?=
 =?us-ascii?Q?OXF46FVQmtiTfxwTg+d9TkS7+JNZYAt4xxS6AlNoVbjawkBSw79J09tfXb25?=
 =?us-ascii?Q?Sy5Fvsw+6rhpmCrPfYmMfeXIvKzvGyqGuD2gDSY2hvxZh4OBmPc1b+5bw54k?=
 =?us-ascii?Q?k7n19RIiexEMO/OU4eUI/uw19E1BJ2MtosOELyMUqEMTXh7H45GCkWlvVChj?=
 =?us-ascii?Q?LpAuhL190H8kNa0gtrMNnkodwopcTSnGU2y5qVkRrLM8Ou+DxYJVRbd9H5TQ?=
 =?us-ascii?Q?baU5s6y93RZStW/IjRMrTu2uN2o/qMfEFq2D7H82AwWHGMTmN6e9r7VA2+HU?=
 =?us-ascii?Q?56j3Z+gHaSJMnbvZuuxITfRuXZjtBUx18f+nvKGpcswan0GAOVmNvNAzvEhe?=
 =?us-ascii?Q?7D4qBOKinSImi9OXBduJdnKCZ4KbW73v4YfzfIbQSuowVRtfSvbYOwOXZKs+?=
 =?us-ascii?Q?4ioHhAnc0ClMt/r0WkfFm6F/GGK/gvJvtdkhA1glBGopPB89idIDB5+xuKfc?=
 =?us-ascii?Q?tH/uAX0ZxnpHvCveMc49nzjCrWg7K5solbwMpTNjzgTb4X3GnI3f+xiLqfJz?=
 =?us-ascii?Q?T2gqLeoW27lCDavyT5Jd8Jz/y1ao6ogcMBbzv5MCSo8eDW2ko2dMsAvZdaNH?=
 =?us-ascii?Q?TgtWVfevdHreWR8jqs6/gW5pZdJcgdTtkYRtyzjooEbvKgTZwiqzKadGE3Eq?=
 =?us-ascii?Q?2k7Q2kvQ0s8vgFE3fdyFSnx+h+SHOqVz53nfEh64yE4OeWzL1TOfPjLJ5KI0?=
 =?us-ascii?Q?fV+11BeLw/2tlb0dcsFEtIg70zmmBzhXsWudIdWq6OF6aLKMphkXEyZ1jUSq?=
 =?us-ascii?Q?iA5s644tvvKtcm51z/y2DIf3Rg2lHEB/m4wuE8+Bp7oaCPMUO/m1ftEW1ShP?=
 =?us-ascii?Q?c7YXadcDN+T8GmkG7t/OVJI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cv3d0bTVmt9U8ZvKOsjSK6GHdcpjk41ON9VtE1CArPrQRiImB765qUAQb3g3?=
 =?us-ascii?Q?8oyOUlhDlh/GPOt0+fo9CLOqqcql2S8tKx/USQQpPNjYjyzO0ySa49PA01lp?=
 =?us-ascii?Q?DNgmmaMNs0uPlYG6ZFS0fAxJyF8vFBuyDKG7Skdl3+ligUC/O0WZltVcyYDj?=
 =?us-ascii?Q?Qieza8M0r4VAF8+NSLzVmc/06KvP06sm+ta1lMFRt0mCuIe/kfP4iUFOoHQk?=
 =?us-ascii?Q?q//ixNhQq5cJ6wbgh27MvrkyC2F3XovMKKMNOe7tFQ9vJBcIeKxLlVjoo4AT?=
 =?us-ascii?Q?JZa2HKSaCU8sci+k+pahjY+ms2wANuoOQDjfp22l5zVT6TjsXT/QfzeG5esO?=
 =?us-ascii?Q?ClMQO7bnh9/79ndiTO9gkiJF6vrLjOd+GrwdXYXGvjycfJIYIeHDZYEhBHnT?=
 =?us-ascii?Q?GXsc0CHbII5PhhLExhedR5+P19gVZPkATiAboeRxE6gpHCANVPS2RfqlJdqs?=
 =?us-ascii?Q?R9FasKrFBxnRRKOH6H2xZos6UzGmyxVQ1xPZ6+WGaU0bhod3bar4xE87G8c4?=
 =?us-ascii?Q?mRe0KWlTGamqfq/AHDPW9lQuCYeK9sa3LTkW9f+mXd2JGkRHxnx6GCGeOUim?=
 =?us-ascii?Q?NLdCe+O9TRCkr1Vyaf3JcX+aBq7PN45D8AlCuWcAHw6lhEIisAGthGXdjEpD?=
 =?us-ascii?Q?YNjbO6gSqqhw6yvFFtE+PjehVJXPjNU7TDI6stqrjJOWkSFlnFWftLIR3fmu?=
 =?us-ascii?Q?ifTBQYj1Od8+VR9V5dXxaDxNGSKj7WlvqB3PFcrAskXawvx++qaLziJLUbKK?=
 =?us-ascii?Q?cnJNjKh2cX9C+kfzqluHXvayOFC/mCoaXl6e5fPoJJn828LS2ckgtSY2W/ZO?=
 =?us-ascii?Q?B7fsNlO1UmrnCwLwLOuSv6umQ2m5akh0xXikHHDv+hgI4lBJKDNEsnX096l/?=
 =?us-ascii?Q?EpoGJkNELCwVoEGRpkdeNQRQdg8OB/uBDL2AunXSgMuXSS2dZTk07roEqT0+?=
 =?us-ascii?Q?PfEpClYMrjJ88BBbFhDv340Tl3OgVOqgLrJaVzOucSUiWP5/NSlghOTv6lMX?=
 =?us-ascii?Q?jdlklIenklx1hkk71/XVCBmFfO941gCYIAkR2kWXzvxPbzuwL+4qN+KvV2Vx?=
 =?us-ascii?Q?+mgasnBOq3wGUai+fbciP33lKbRneH7QPAFrCxjnY4GeqdGKjWg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6319162-f24b-4e5c-f0fb-08db501112d3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 22:10:46.5284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahJ7pR+2g0wd+KVCjL89s2OigDGfb971KClfsCBPdrRMb1kYqbHor8Oy4JJLCxJi6+e1e1awsTFsFqAlR3vbOE1S1kcAFltzml231f/SSEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305080146
X-Proofpoint-GUID: uJW5mHjC2nWt5miknFr4JmFnFpko7Plt
X-Proofpoint-ORIG-GUID: uJW5mHjC2nWt5miknFr4JmFnFpko7Plt
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

