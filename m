Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B852C6A873B
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 17:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCBQrl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 11:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCBQrg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 11:47:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF1557D29;
        Thu,  2 Mar 2023 08:47:28 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322FE3RJ012480;
        Thu, 2 Mar 2023 16:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=I77HzmKdZaGDrTgNYjcGpGrNW49DZzvHc37sxhVc3Zc=;
 b=xBn21OE4zw4DlAIhKFHQd1hAAk920KRS2N/LyqlqapgPj+lWMPq4GWdOU54S7DcgxMz2
 V4jUhSIVsuBD/Igta7ytRRE8QdvMvCw0MKq0szogQGa8rL9dmp0h+bV2rTKPy8Yun9cf
 +whIYOGijYf1d4FYFpSUjGxLKbneKB7dSlY7j3tL2GZL9x/BntHQQBznI86wgkf2vO0/
 s3zEaa0L/FMivLVb9YeUX03LnE7XWEEOE/n7mp7vFEKfV8+3RhRPKQVc0a7vTvL42h57
 qYl73n9IESV0Pi7tAyFOvMHF76sHLSpLiT1gcs0+UiQvA5+4+gjn6Nn/caqDoR09rJRC 7A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72m6pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:47:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322FVdcG034939;
        Thu, 2 Mar 2023 16:47:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sgcuwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:47:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGvR5SX9pp5z3FRTLL/vbc3Xpid7F3hAtx6QredYa2ceOdQZBU5a388pcWi2RwKRzUx2CpDkRTbXddEqi0S1VHn1JO0jRBMcp5VEwpPdthE18zC+cTXgqZ/jOOeFztZtmov1nTySzWMKvZllhrTDG/k0ZrTDMurlyM/q/xUF5jIXjC/05eKxNLhDXdfJytRoqIXXg/KCtkUNFRQSlUcz2QH6eO4JikmvsBxw9bpAgDQCJuEKo4n4BO1HCipKeWuxg17SMpQnSG45R0wIQd7og/p7yuWGgtAk1f/4Ilx6QdbHck4o7zFDa47R3iwzaZsWeE/URPZvNKKA3nn32xB1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I77HzmKdZaGDrTgNYjcGpGrNW49DZzvHc37sxhVc3Zc=;
 b=l8hHdNCSTrhzDUQBtoMQI67O594qPBiocOA7oaarlv3NfocUiUZPFXi1S76M/VWMYrd2ZxI98gM3C7tuAb8wUMrr/hR7g1isMXxHxHWJUlfNMzCiQj0B+bDb1vjLEa9W2gZ84m2YZJmb+/prkR/8Dmpk2FXgcAXVNwhQm5y+v5VrcPje7f5ErLOb5MG2iQIYPPAAw2Kcc3PWeBwtoSt473SZbsdxMLZft/jwKzXVoXbEtJSt+jG6MB95U4WaeS01N3YKV/Tqm231Np0gZ5w1uAyTAa22ATrGuQMG3R4N6d98O+YtZul66ypnpItMdihK3EAq3q3v0nJCkr31SRRAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I77HzmKdZaGDrTgNYjcGpGrNW49DZzvHc37sxhVc3Zc=;
 b=y4iQULa20sluVe4sDKFtNwqE6qQwSeelIV+xn2Pr2lXd2YNrLUIGx5/KljO4B4/zJj8IWt/ctyjMIwZqcxyXJwXNc3CKmsgUQF8Pauev0N+NOGg3y6ykvjvxMSI8rRe94d/2Z61va9m9wW6FSWEQRflq2xNujyegrvx9CXWpGkQ=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5150.namprd10.prod.outlook.com (2603:10b6:5:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 16:47:00 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 16:47:00 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 4/6] KEYS: X.509: Parse Key Usage
Date:   Thu,  2 Mar 2023 11:46:50 -0500
Message-Id: <20230302164652.83571-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230302164652.83571-1-eric.snowberg@oracle.com>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:a03:54::43) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d60e4c4-b978-4c6e-f629-08db1b3dbe1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLJ2vdjJW4H204Gsf9WrMAdAcDUP/yOHzg03nKQ6BA4FQGc4qn3qh/LCt/yKqILxhSYzjgWD2tFrzwMPHHDzCO4V+VpW1QycYzovhqgVYTACamZu0BvpcNbFCHWsneqNRkwD7MRYGWPWIFuxdUSz8MJ/BAY4Co6R/UR4zejP23th8WT5MIblgWM5pPlLiutiFam9WzeXNBuPtzWa9AqIPU0Qs6viAXxjghON9dHntP/30cw8118bjX/0bUyhpVluN2IAqwzmSEdf1Zt9++aw5+ED/FYTI1PvH1rle92TwcPbmR2OmZS9qTcjto7YvP5bDiwbCsPAEckXEp/p9QzfLQN/k+Wb3encOQsNOjINXaYMoA6D6p/pUGdolnoxB6fhZ+XsiEVIccnFC/pN6IaJ6d/NCRfIL8SHt5m7bUQ8kyPTSKyMvDx5JpXhPk+elipnlrUaXCHVQqYr+FWnQ8dI2L/0ZEBLuRV+rX5+oUM28GRkSCGQJf3NNGpKzyzhUaaGbgHpmY5SU2yTf88VRjR48S0B6m+K/O6mjpWxNYztd4RrY4JLYN2TPaCBbRFAh2euHGYTR8Kxyl3jYEyVr9jhb7rt2Cs3plvD23gGA9TI+flmfPCiZHjQU4HKkkqIsvxk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(36756003)(86362001)(8676002)(41300700001)(66556008)(66476007)(5660300002)(7416002)(8936002)(4326008)(2906002)(44832011)(38100700002)(966005)(6486002)(316002)(478600001)(6666004)(66946007)(6512007)(1076003)(6506007)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E6q5Pz4W4Ys5iN7F+rNSPsU0OJDp5dx/Wi0866C2K0JAZIXMBqAZTs5map+U?=
 =?us-ascii?Q?RkGyrxsrkpaLqRLrAKmZUrxYbE1VnVCfTn7H1I1xrihqnIQxh9r+xQIy4zh/?=
 =?us-ascii?Q?jhD4NeS0lL7aukB4uzbR0v0ADX4LpLyZ84GPIJl+/oQdWS5UEsFPjUuIKkKp?=
 =?us-ascii?Q?5FgY7tOX/vrLnfIbv6/RRAaq97imDOYbnru6+82jOfV+lDUDhU1o0vSmmHAq?=
 =?us-ascii?Q?Tui4JNAj+jrlyF2GmLtokMmLd9ufNbdLcq8qV3CIczlgANCjGmdtSuaN0CXC?=
 =?us-ascii?Q?5J+KJXiF5PEY9mo8KbjZMb1kOhclgKaw2JQkcokNhCn0TU6mX6FJgMm7AOKw?=
 =?us-ascii?Q?ZuUFJCNEzBpoZlGgcVzpSf+n3EReWMWXM/aa04yJuzPvBnYrs6VftuaIT7LB?=
 =?us-ascii?Q?0hksfM+OmLV/xy4SxuSNmKx0PIKo+vFrlrnUAvtXBfETo6d8YPW0FD0ZLvPc?=
 =?us-ascii?Q?arKaSRKUURCs6MKd9cFtP6VEiugOqWaCFe0tadAMg0DsHxWpP2zF6LZf1Eha?=
 =?us-ascii?Q?ulZxd86p73IMRkUD0cfw2+g9UL/4y5EHGNuSxAbFaV2ZGxSnVZ7s4OfzcSnS?=
 =?us-ascii?Q?t2Ag0GFkQ/ON11ErPOteiw9dMS4rLLTQR0pMs9l7fIdif2r4ZsEpMFzsNXZa?=
 =?us-ascii?Q?i/nlV3aSzbpcl+h2HuWUL5VLJaqZNj8jxNb6UxRi9VYv0otLzv/8Xvj6oGMd?=
 =?us-ascii?Q?vd7+Xz5QeIzz0GRt2REmLL0ulMoC1XpK5z1v0Qwfyeh08rNaMCuXDNRHX54W?=
 =?us-ascii?Q?gj79qrKKHD73MQeqOZLWg3tDRf3i7cy+TRHlu1pDhHkwWsGuAbjXucHuyUfE?=
 =?us-ascii?Q?3bya4Wic9I+5zYg5HnHSEficbvpHXBQLzB1utds0Z1JEO/u1XvWD39wK1BBF?=
 =?us-ascii?Q?LQwq1Tc6g6zAmL1moXzZLMhQXxk0m5+2CFXLbLygeTBZ0+TZpknlduDE7oW7?=
 =?us-ascii?Q?Jk3jrwLwHZGP1Zw3OEjibTUVYJIYnAZe47Ql0twv5xoKwx8MvKXqI3ZkcRNe?=
 =?us-ascii?Q?NoghSpt3E6phunYe206BtAcU6OuxBajn+7JwG5056maesWcTQ0ze/PMKg6vD?=
 =?us-ascii?Q?JAuF2itWjC7WQ2II8eWOROSIOWoYvCOlIuhiSA5eto77+BU38j9DuS1DxyQF?=
 =?us-ascii?Q?s1a5sFIhQJdvSUe+mdnKwgJBGxaRoa+72utK6Bq+8Hp3Ghm4lLvgYzZsFjw5?=
 =?us-ascii?Q?nhs4AKRs7kenhyF2n1CRxGFL8HVWgLOKBEt1il2hc7r+ijYl3S9B0wvgnoNv?=
 =?us-ascii?Q?kIDsHRCtsovMvOw5Qdu7stDCxEX+T2DndoXihgZBFnsQXme1AdS9YMVzIjy/?=
 =?us-ascii?Q?lGOC1g3z7BB/B9u+Sn8eChRPm9Bv5Tes260ghU2+/I7CDrYhFiq4T6HCHm/J?=
 =?us-ascii?Q?/0F5Nj6UcBZ5aJbTunr3WKBS20AYlHODK95CosEgjtKpsjHArbvOF561v5R3?=
 =?us-ascii?Q?ociS+y4joE4J1Bd52BDpaCsLIYIHJZl90M/eBOvYsCECx29FtawLacHlReYv?=
 =?us-ascii?Q?yGOM07Gl31887TvMDhSu/E+F5oxDtZjGzGzHYvpS64Qt/lxuOddizhM5GX1P?=
 =?us-ascii?Q?NMuB7xys1G2Z0VvYhs85dgvlmf3logRTxMFU2j03VQHCr7p8BrMpjs8JVsUV?=
 =?us-ascii?Q?04msnZjLl8EauraLsye9/lA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8izzVg+eSWOEG9w1V7oGcTyYTW7zhY4tzYlwkBsEKSUSbj5BIemx3oGRbcnX?=
 =?us-ascii?Q?yin/RzU0DXTz9gMv9xW/fXo9i8FfRkTiuqIr8qufztjbNr2nH1bXM+MPx/jZ?=
 =?us-ascii?Q?AvTXRZyS3GfIizT9VTIsL6yKEGNdZ6uRV39L2ghPAF8qObRZgNB/loVdzVxF?=
 =?us-ascii?Q?0V6iXZDaBA3DKLbt/RCKbcplF5S8/Ez9sb50PsIcHqVUYLS+5XouAVDdiafZ?=
 =?us-ascii?Q?qH1n/OjF1oB7Z/EHrsrcRj/wpPdp/FPkWd0qwZ0HiP+aU3WgSK8bCdMrew7i?=
 =?us-ascii?Q?DC2gqW7NoLe/z6G6WhytNDke74Xof26qJHeUpHwrGibxH9fCWCBu44EfsIsK?=
 =?us-ascii?Q?DrBZ9AzAzl209k5v0PyMDx0zin1ug7nVG5ZRQ5NAxC3L+eSP1B0Ea9inB1dC?=
 =?us-ascii?Q?C1aNVikHxJA6bL3gIXeqZnzUz73JnjtIeup0Gma//8we9DcwfwN+ZYi/tv4s?=
 =?us-ascii?Q?EeJL7fRjZkrB8APzokGR3hpkQJz2PntO9OfNwAzcpbCbEeJvNFxYGJOB0zkX?=
 =?us-ascii?Q?QDhaLffIr/1dTKd09s1H2Jyux4DN2BOtave7tH18VOxbfLp9atDIFmvMbrRn?=
 =?us-ascii?Q?Gpa8sRl3a//uhGOpXgdjAyZlrwN22zv/XQ8sflwseOAtT2vL1kS4QkO2lNtP?=
 =?us-ascii?Q?VhLF55TjtGtq8Y9QyXgFaD9f4pxAm06r5APwRyWbQ2swXXl4eC4SX812SQdD?=
 =?us-ascii?Q?Z0ChHMsuYXE9jORy4TgH/+gRbJwlXvso+DxIlmpDk2XLrN2HM8+dvZ7QDu5f?=
 =?us-ascii?Q?TgkCj2TKITLdEIqXx6rR8QWMRquul8vjFauWJagYxEgO4Bi3S/4WDErR4mYC?=
 =?us-ascii?Q?ZsQRp+JaSwq/VL+PGJRUnoVuD4HF3oPguXLmawk9VIrwPbC8RJhQLx7mzZ5r?=
 =?us-ascii?Q?kjlUT4F9MrDqMh7jKj6Bbl2/R4E7c+VP3VhGHnn0quo0m+YVQafReDA9EN5s?=
 =?us-ascii?Q?+DOp84W/J7b5tPfNcikHa+YM3fJ4pJoy2P3mmTg4HfsQpNZE02d7jvZDTaD3?=
 =?us-ascii?Q?m6Euluc3I4XNBd83KNoNNb6dV6V1HMvLkAxwCc+nID59IFNH5i8VuoxtI6vR?=
 =?us-ascii?Q?i7BSHs6tG9NxVGIxUX9QgLEdS03j8x0WC5YjlGE4u52sgPSAwRjfcHQ24mgK?=
 =?us-ascii?Q?aEE+nUsPlp6jbHGQ2d8os2Hcdj267vjg0KgpPjprQvNERxbz7w+66Nk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d60e4c4-b978-4c6e-f629-08db1b3dbe1e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 16:47:00.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErDQyfdtPnkw5mRrOc9Jte6m02yeIOWkV9grgx/VTpZlptC+QSLHmapYUB9XGx6/2N/PykMy2x8NjEBr6ijiUgMXS5WPyZzEW3sjyZh4mmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_10,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020146
X-Proofpoint-ORIG-GUID: nuGtegfKy1-jtaRp7kvnrKxZSrX49jw9
X-Proofpoint-GUID: nuGtegfKy1-jtaRp7kvnrKxZSrX49jw9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

