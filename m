Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C8E6A8752
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 17:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCBQrs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 11:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCBQri (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 11:47:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB6E5650F;
        Thu,  2 Mar 2023 08:47:30 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322FCWUq005684;
        Thu, 2 Mar 2023 16:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=b69PoULkFOQ2xhN5a0O35QRgDeSDedJTt3nH58xgAF0=;
 b=sghgpMS7MDLvxAuaG3u9zimvisFi2guexMCFpcbfzhlyTtljHMV5670tGa1DjgAsi/pF
 yWiaTiFz8++yGecdlihqN16vWw3P+dyHDLOvZUcEz4OTw2+6mPsSSyjJcm6TZX210vUZ
 eQT9Pn1uC2NDpzbhr9K+ugMBNbHLPMBdKyc83dbbW7f9L0hpHy3gIAaEXw1OQ6u29Uab
 G4m7z0OvKFVT72NHhsbcGgbwmjgDvHaCiQll6CncTAdBPfNI3HSjLKXtGjbzQbl5DTp1
 L1O8W6OFFks/1Adh6uWak3N0mqFCUyezXO7J33nFS0EqK0QX67bARV0eu446ftPFf2KB fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9amd6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:46:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322FWT1V002175;
        Thu, 2 Mar 2023 16:46:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sa1vy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebVEuZb3Nh3mFWZe3VKPCUHW0pF3DTOIFCOd8S1YjARmESEBOPRwKsS4mb1dxvGMsLj+yfHZuHq9Y3JTmOWVxWY2j97kZ/YTFpRNqyS5s+YMr5cyXmF4QCj7hZcuIW0ZsffATjg44+/q9x/BRDQsCsVt1eFSKekkIpLqb4WYV/aMULqGlWA/7rVEmPLcFFvCuwoMQpdun6NynYEJJ5H9huLKKFTMtaVV5O9P8GHuEY0zUEosHPP0NNJ1o0gYNdC09va9r+B89ZcWgT8dBKDn0Dmh7QteZxJ7l4GEi6AfMNOfGXevPYXwvDeq0tii4i/eao6sMB7mpoCD8wc9gIJwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b69PoULkFOQ2xhN5a0O35QRgDeSDedJTt3nH58xgAF0=;
 b=O9+Mg8jwqsWLCn9EfLHcOyDcqXVPjAYxR7UIhUJCRQGT8lHPykJbIG0ZB48Ojofmey8ooX05gLfuOSEJnhUoxJZIAYWhJ2w1iiMSL//h/p+UAbMSaLlNqrCw/H/IPGwVyJI0Sx34tHxC4jTYo/4X4g0fyHc3G1sUmA2ZRoy+KIqBUW1mt3bDJoiewlAzuxgdkieXPz+tQBpuN1V2QcRQBGKRIFJZ5BcSNG0Pv1Q1x9mYNiyi+x0YQ20OxmwMO32mmvQmbK2UkjtC+uPg9nKqBp0Evwhhe1lrA5QU1fYSsJ/JcsA4egmI1hIVgFpaZj+UyYTOVr+pmQanoJpduwXBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b69PoULkFOQ2xhN5a0O35QRgDeSDedJTt3nH58xgAF0=;
 b=MsU9Rs9MBPZEyV4+dX+39tvmiJlCeTNXF7zYRs7P8J0pi5Ii6Dmg+QV8GCHbnrl8Wa80XTa4VYrZO/0ZuWzS2p9N1QJJqULyk+X5zlltizjs3PpzMd9y+QOJiBgLyd00rutsdE8CbBx8Sn2s1cQnkfufaFh5LwUT7rfkadA5f5E=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5150.namprd10.prod.outlook.com (2603:10b6:5:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 16:46:47 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 16:46:47 +0000
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
Subject: [PATCH v5 0/6] Add CA enforcement keyring restrictions
Date:   Thu,  2 Mar 2023 11:46:46 -0500
Message-Id: <20230302164652.83571-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:a03:117::26) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 109bb9f7-49de-4270-af6f-08db1b3db6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tglan04l1QMq9imzz3Ae692N9Xf02NxJPwe0f1BqqcTZTR2eFrPZalgC098QcF1A16I8phrc/jAAzZ5PlSua+pzyei2FWQ9/NJbu8rIK52zbxrkvSU6wGsvLMY1WaX/TlPkI1FJrFokSkImYsw61FYJibIWZLaAQ64UuqlGT4zzJOuaO/9EgGktRKVQhxfvWQkWLCKFff/RaR4c3o4S5ZrleUWd7YAEo/vre3ddenr2zIOQbT17AH/01gar4pK6KyOn3dnmMkSHPrXZdc68/7XBSSx2U2AmOTuQgIvx1hubSvIrnIm402QYaZ6cEgJrGfu0opr0/jI4XIl1IpsiezNLSWoRY469seWAJthtDQ0EXwDVeAt6Gd707/yiz02Acdm61B8y2EZNIQyoXs8Y3Z06XlQNnkxZclO59YfimvASkjPQGbXiIZ9D/dYTGCcsbXxG4d7AF8QTWmOp/hrXXS0jZzaP2o+atYIr4bnC3A9Lgg0bz390qoTY/Hy7Xq/z+6o1x33OgyV0Ezy/UI9s1oHkgua/zbluhgDAiRa4h1Zg0fjeqXfizODuTvvVJn2NGw45SOHnjTflMmMZX+RQCnhTX/hF2+Jy5uL3Cs4VDYY7bRvEbQsugBbfTvRfTkdL8aqBDksMEFEmHaI81lR1NDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(36756003)(86362001)(8676002)(41300700001)(66556008)(66476007)(5660300002)(7416002)(8936002)(4326008)(2906002)(44832011)(38100700002)(6486002)(316002)(478600001)(66946007)(83380400001)(6512007)(1076003)(6506007)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8zj2x0Kcda0W5UdZmYYi4VS52K6o4i2Bnuqexa5Ie3JRKHla8CeyrkLxQsdU?=
 =?us-ascii?Q?z6FSry4o/XjwIi+VJtpKv+KStxxaMy5U2HKSKtPcuOrTxtVB5HNW+8PR5X5x?=
 =?us-ascii?Q?gC9ODkn72jOWYqFd25gY5+MamJ4+6dOo/3T++tr2MYAxKsVK/cvdZLyJfjks?=
 =?us-ascii?Q?sqOsqQiCRI/vi72a6Vbk9lcGczpTlEhRgpVEkkCTF7xTTatdrghUpzu+K6gH?=
 =?us-ascii?Q?DhzJtg5n3LXmCxB7oji3dH8LI7H/b7FqtIAopQLINoT3i7EQY4vx61bYv8gj?=
 =?us-ascii?Q?P6E7hnVQQ37ApQx4R7HGNEtsvLOVdJPRMW3+Q5n2ukAbTbNeguG2Vq3vKgHs?=
 =?us-ascii?Q?Jv5SG5mf2i+ohlX++GSTfXm09FlkfcfysxUofGabCfi9mN7JFHk6ymPJ2YM3?=
 =?us-ascii?Q?TusrrSDPXqv9Yb6H04uK97YtP6ENWiY8fWkAXSAlVh6ejuuHjwfKd1j9E+gQ?=
 =?us-ascii?Q?Ygq6xVqhuwjJiCdcApMTrdhjtGSyd/KZFCyu3Ma9a6eSeqLR3KPy62OG63V+?=
 =?us-ascii?Q?FHBWh/nhKmjrssZOkU2pJm4jiGRx06aBi+IkfJGbwkd6KqTKf4+4yL2xTnso?=
 =?us-ascii?Q?n5Z2TF0dYpKI2Von6xHc+ZVXAQg6bD78fFtzexPd/cPlX1mQ0pmTjCZDIWM1?=
 =?us-ascii?Q?8lxGIUFAWUHE+dBiAPaS19nR03VuGdZufm7wuB6XR/kvRm+3TnI5SRXidNhx?=
 =?us-ascii?Q?YQZOU86tx0fpqfurNtAnC++QZZwzdvxwLS5WpBBCSubXZZPZJeew6qNuISYc?=
 =?us-ascii?Q?ul5UBy1j2K0ENPtI9tvsFejOw5+kZ1FJb5BVzgfqCKz506mXWZsG3XnENMGy?=
 =?us-ascii?Q?TDaTRTD/KoI4YHxksms656iXyB8xItTqjPFDgcH51Js5fvClDJFiCtFDpKyz?=
 =?us-ascii?Q?pZ04wSGZkkewkL2H7kJBELpQwD2yITEOIUPyyWF/kYfqLoAs0WkF2wmK5GWV?=
 =?us-ascii?Q?mRPx/zakM2BitTjUfAE2sV4ADlPqmkEsyyjbkycWHfuwpfBAbKGRY64Nv0YR?=
 =?us-ascii?Q?7i9ToWfHq/xKiru5ADm4QxgV1KA3gA/ZvuW+7nobxdnMeprVjlSNj7U0UYg4?=
 =?us-ascii?Q?52+rnsKMXzoYksCeXtw1A7MMzWHY95giurIKMAp719ie4SZrOjzV39ai6OEH?=
 =?us-ascii?Q?mbwCegTZMHGfNlMJ3QZjCyDZ6wgvZ6a3/aTcRfFmHO+UwOxfyCOwUDM0zKR0?=
 =?us-ascii?Q?LVVPkoiWmihar6KmXJgnnBrg2o4mcLKV47rpaJ+CdZmKNkQJWeEoEa4ndWm2?=
 =?us-ascii?Q?JNqynh3/SJ59eDoFSjU7rbptk13L6Rg/nq3kJZ05QNE0abgDgRxLfC6aDUx1?=
 =?us-ascii?Q?40PkkZeg9O0hUq0T8rEjfdNpstSJr+8ro87rw6ybfSY1L3jJyQWNsmnmg6x8?=
 =?us-ascii?Q?BccNCznWHGxE306QeIqO9Am4fkoKsCt7QCSfqUz22RwrdpH8DOd4TbCKDWzp?=
 =?us-ascii?Q?1VOuhl+otpLWbhuBwOdaap0foi1Maf2SAufLD/1cGiqfgecoghHd0vsgF0K+?=
 =?us-ascii?Q?3M83jWQWFgmOqA0xx1q3AycowzYcubKzcVbmzltltdV6j0giplGvIHLtHpTs?=
 =?us-ascii?Q?79szYu65JuSUi6l4JCeZaS6e8ZQvsXauv6Qjf/b/mWGviGP2tsJbpwySyrkB?=
 =?us-ascii?Q?vzgril5b7rQkjHr8N0D3iRA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Bagqvo+Lg+L8kSJ60aZ8LDHMduCxpl1v9ktUW6Wciej37cMqRkJdLcbhaV7f?=
 =?us-ascii?Q?bpEsNDXfYmvBE1Y6/flS5fobX60aFINnRsPA6c9eLvPBjqqT8ntAxLUOmeXY?=
 =?us-ascii?Q?CO+qJF6h9+FX49Kxn7dsQgP6cgbeE+LjT6Ta08y8bLQPmSyDUHMPtrdXp1+a?=
 =?us-ascii?Q?NZvwxqeqy/h8lXRO+zYPGKzerfi87EuPvfctt/vchCLyUMWAiakX45xqhWrX?=
 =?us-ascii?Q?CnBDv6mfTumYDCTVK49+JKKFALjeqwRV2cWvW3LZqXSJJWDHGZwPoM2nUhoq?=
 =?us-ascii?Q?v3QjQT86YydwTnh0Q/PMiitrEiAbQtW/lIiGXiHZiGf6lgoPmun4bQM+1pyj?=
 =?us-ascii?Q?YNf4zewFl89IUDsWeFqKqOHqwpx6da5C+2w87F7ssG+IYgBEmlwVHdutLbcr?=
 =?us-ascii?Q?TzM6/Xg8NY3b+8stXC86VG+FGiQzusgw95RYUofnyIAnPEi2iAreIeJjJN2J?=
 =?us-ascii?Q?VzmlL7DklyKgNiEs09OjvxAhrZxXqjYhioqmO7tFwHFvsBJjUwNFRrAeMaXj?=
 =?us-ascii?Q?mY7j3mdkCWF3pb8pWZPLepMnh2SGEz9cY/bje5rmuxESURZTrUHuCi1ceW5U?=
 =?us-ascii?Q?3vQ/lpHzvhCi9tJG/vxDJqA9s2XAFM+ITxO026tC39Zo2uU9GW/O12+0Mama?=
 =?us-ascii?Q?JY3lzuOf0BI3/FJWFU73Q8f2D60Zd69y0FXb0Kw7va3Pv0JAYLNBNvqGe9Yy?=
 =?us-ascii?Q?47s3X9QDz0gJi5vCG7nmbITJhyH73W9pplfVsaNEoIrnUr3+vzXDCd9dYhpj?=
 =?us-ascii?Q?cYP5bwLMVF1CfWayvIZf7u3wDvQ3m94y5Pl9mWWyPCc6u5tzm+hqh+usImwN?=
 =?us-ascii?Q?lJnkAr0HB4IsUE0b4qWqC4g5xCA2KVUwZMAT1kI7jCixGOhkRspBB1GtZhfA?=
 =?us-ascii?Q?LhxAUbAEGsh7gRKJboqT3CgQ7qcIv9Vo/qda2Ypt3xfkMXIZhBG689V+0bEX?=
 =?us-ascii?Q?stjS+YFRqVxw4eOK8woga8iEypC/0ECNnyGCPDmUs9vBDPcjwyASPTu/7Yy8?=
 =?us-ascii?Q?ri4JGnSfuNEG0uqNYwiFaUZ7uTgmQ+nNMJyBOvYtPrxQj/nP0TsgnUyqcG3l?=
 =?us-ascii?Q?JTa8i43m93O4gVZSxqViIzelZs9ZrD6BFeYcKOinbzn4ExRaCsJ56qWVYTo9?=
 =?us-ascii?Q?tw8q3LvmGwTgIWxoHBH/B7WtBAHxE6kVio8OJ8jiKqoqqGcfdVNgLts=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109bb9f7-49de-4270-af6f-08db1b3db6b2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 16:46:47.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bE+MJ6MtQcq0sVJrP5KSqklB/xXoxEty1nlTzQdNSMerLpxVGV+/JM6YIgihPLPukau7gS2rB1HUP1yI+pcS4XPhWCBn+23Kv7abOHIJUmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_10,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=982 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020146
X-Proofpoint-GUID: DzxRYldGYFSVbyE3vI4ft4b4kUeWXwUK
X-Proofpoint-ORIG-GUID: DzxRYldGYFSVbyE3vI4ft4b4kUeWXwUK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prior to the introduction of the machine keyring, most distros simply 
allowed all keys contained within the platform keyring to be used
for both kernel and module verification.  This was done by an out of
tree patch.  Some distros took it even further and loaded all these keys
into the secondary trusted keyring.  This also allowed the system owner 
to add their own key for IMA usage.

Each distro contains similar documentation on how to sign kernel modules
and enroll the key into the MOK.  The process is fairly straightforward.
With the introduction of the machine keyring, the process remains
basically the same, without the need for any out of tree patches.

The machine keyring allowed distros to eliminate the out of tree patches
for kernel module signing.  However, it falls short in allowing the end 
user to add their own keys for IMA. Currently, the machine keyring can not 
be used as another trust anchor for adding keys to the ima keyring, since 
CA enforcement does not currently exist.  This would expand the current 
integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY 
Kconfig states that keys may be added to the ima keyrings if the key is 
validly signed by a CA cert in the system built-in or secondary trusted 
keyring.  Currently, there is not code that enforces the contents of a
CA cert.

This series introduces a way to do CA enforcement with the machine
keyring.  It introduces three different ways to configure the machine
keyring.  New Kconfig options are added to control the types of keys
that may be added to it.  The default option allows all MOK keys into the
machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING is selected,
the X.509 CA bit must be true and the key usage must contain keyCertSign; 
any other usage field may also be set.  When
CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is also selected, the X.509 CA
bit must be true and the key usage must contain keyCertSign. With this
option digitialSignature usage may not be set.  If a key doesn't pass 
the CA restriction check, instead of going into the machine keyring, it 
is added to the platform keyring.  With the ability to configure the
machine keyring with CA restrictions, code that prevented the machine
keyring from being enabled with
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY has been removed.

Changelog:
v5:
- Removed the Kconfig _MIN Kconfig option and split it into different
  entries.
- Added requested commit message changes

v4:
- Removed all code that validated the certificate chain back to the root
  CA. Now the only restriction is what is initially placed in the
  machine keyring.
- Check and store if the X.509 usage contains digitalSignature
- New Kconfig menu item with none, min and max CA restriction on the 
  machine keyring

v3:
- Allow Intermediate CA certs to be enrolled through the MOK. The
  Intermediate CA cert must contain keyCertSign key usage and have the 
  CA bit set to true. This was done by removing the self signed
  requirement.

Eric Snowberg (6):
  KEYS: Create static version of public_key_verify_signature
  KEYS: Add missing function documentation
  KEYS: X.509: Parse Basic Constraints for CA
  KEYS: X.509: Parse Key Usage
  KEYS: CA link restriction
  integrity: machine keyring CA configuration

 certs/system_keyring.c                    | 14 +++++--
 crypto/asymmetric_keys/restrict.c         | 40 ++++++++++++++++++
 crypto/asymmetric_keys/x509_cert_parser.c | 50 +++++++++++++++++++++++
 include/crypto/public_key.h               | 28 +++++++++++++
 security/integrity/Kconfig                | 23 ++++++++++-
 security/integrity/digsig.c               |  8 +++-
 6 files changed, 157 insertions(+), 6 deletions(-)


base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
-- 
2.27.0

