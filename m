Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9710D6FBADF
	for <lists+linux-integrity@lfdr.de>; Tue,  9 May 2023 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjEHWL3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 May 2023 18:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjEHWLQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 May 2023 18:11:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C99959DA;
        Mon,  8 May 2023 15:11:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348JOnug013290;
        Mon, 8 May 2023 22:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=CA/3g1Jj1BALJzeNjGclS1aW39twbOyywfaWvaYDKc8=;
 b=TWLgmh5lYxpjRvI6ACepa8hTkWt97tjYaBuxoGxM4i0KyvLjL3NrHLMGzYrd8JVmYhd5
 c3CS+TUEs6Vv7Gb4XHqkY1wKiQEIc1L36JmsHpwwiXEDEDEJ3T6UFOEOpvGzECu2CunZ
 VKZABXZfdxbpWYyaAhzF6Ngs/4YtwqswYDJ3iWIkRypIOI/KWsl7NMyWisIS0TUrY5zQ
 f12PXO7E+SEtlX2qamN3gNhFcvbsSZfS+zuvh+SGybEBJPo5CqUxvEKU2aK6PjYnTezF
 zbXr7KHn1yrt0qSuCEt602ASgfwIxypuAKHp3JYNBjUEnzjHylg4/LNxNLlmeykuNGgR kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf776g9hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 22:10:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348KJH8M020059;
        Mon, 8 May 2023 22:10:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf80yu968-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 22:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L560UIoe0+uCSBcmQ6eFvCRfTtZe3rd09eG3/hEDGKP9ErvKJfjjKwqKoB0f7+RX9IZXpE5nIvt1TivdUOsZvaFiGar2AtNLFYjAlMmI/fF1O07gGP6DEUrSBF/UoD9bN1yVCAvAVXoagubUBAmi4fsyhBI/Y/qEZGICK7M4Z146q+uWUhicMvKGbAmzekJDt5cNp8hMqQshe7nBAPyxgEH056uJeFg9MsXRcHwDnjnJjK6omtPNr/Onek6LcYwznIQpxhQnG3OTdjnRnMNPdL+p3n0JQzyVltPhk8UL1DLCQy4u9oNn8ln6pluEe9I8XWuA6E8M9Spd+4HnIXizWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA/3g1Jj1BALJzeNjGclS1aW39twbOyywfaWvaYDKc8=;
 b=CNw3EIWW/GdDL5LYMriWhvcfXMZNL/BAQiej7ensF8WwTSXnKs4G6VLF64VU/B6NtizWxaW+vkH3XJG245KxXez4sGdkxtaUGscAoLiuh9yKBPXXeyAhZiZ8hkZ+QTFeJC6Q0THUFQc3glUCEC9hPNJcg6lNleiPAYWmhFPrBQcy32wzSgLX1Rm222waxVPPCzfxa4P3GvEp02jHr+zObqvrxOmnUKjrYrusYac+q2UVgjt8jceYOeInPR1h+iBLT/M0BIE7oRddCqUqD6GJgXWsYvttBNRDylUhSHfoKLcoXiSA3oxNZ7AqGUIbIjP4CtVmvwik8A382P/ij2MFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA/3g1Jj1BALJzeNjGclS1aW39twbOyywfaWvaYDKc8=;
 b=BKlKgjTW06Xkdt0ULo8OdLRE3OTKUms12EeQMQ5fR627F/aRvMcMDkV/HpHxLaiUcOQyDt3fF8EipBTQ+gjMgaXSHNN/j5MolV7RvIrZc4C71WgXXXtSq4t8spyQCyspOWwwbWnve7Mpg44KDwqPMEtP0Dk/rmJxJNOap8lIY2k=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB7065.namprd10.prod.outlook.com (2603:10b6:8:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Mon, 8 May
 2023 22:10:37 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 22:10:37 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, jlee@suse.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 1/3] KEYS: DigitalSignature link restriction
Date:   Mon,  8 May 2023 18:07:06 -0400
Message-Id: <20230508220708.2888510-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230508220708.2888510-1-eric.snowberg@oracle.com>
References: <20230508220708.2888510-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::24) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS0PR10MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: b35df5d4-8d47-408d-13cb-08db50110d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLGpbZdlBy2b9QUz8VqZMXUspQ0g07pQayurQKU9OHc3bQWhn7oIqYGKrBrczJbD2Ayo9PN5/TcJ5nMQKvYVpLFOxCdUJjWV+gbATFXSUcisw2J7b2tJxLeDIiagJnpLdlvlKY3ADzEMzWscxt79ERAIr0N8rcwefbtuexuq6BAPq6noM8anazHGmBSnHXmnu6MlTSqPHIxilui8+3GJYslhZ2LTOFu1PHSTvoLlIbA3W11BOIt31KOfHjBO7k+dhcXrmHajfRrJja8wvOwrwumrgMMPxGUJLeth3GXPhT14D783B9ZF7JcG2vIZePrGQNziauG5xrt8ukerUKtr2dpZ30V2IsHBrKTHvA5TClQhv4gcOmzjU7mJu04WxqM/IGruc3gESwYKR5S/lJVXLULC3gKF1CoX9ovf2YvAF3tG0WM3R+61S/BvNjLATxjwPrlp5iIxkbpN2ebTYDZnENRC8X7JXeFAeBKnFzh9JoQi/+E+WqcZtBpQh/tYAYXCGphmnNLC5smrFYzraU/1p11PvrMNSgGiyJ2oGutGRTqItrIzdvXKnO5X2/yIVThS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(83380400001)(2616005)(186003)(2906002)(38100700002)(36756003)(86362001)(6486002)(8936002)(8676002)(316002)(41300700001)(6666004)(5660300002)(44832011)(7416002)(478600001)(66556008)(66946007)(66476007)(6506007)(1076003)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AisVj1DGw6m8a0HRi20c6goGsS4y406MTLlohdzrUjgUppv87dOHiWvHjLu7?=
 =?us-ascii?Q?tfsOewHsg97UKsxsQy6Dwrx/VgZKsOgcOjIm5qh071xXsoMwqG4ZddJxBLgn?=
 =?us-ascii?Q?QDvoPekarBE2HhK4w96ObATU1rmkKfJBVEooH3mZ7dxYNXIBIgSf3plJrLta?=
 =?us-ascii?Q?jhNyvc5m+T+v5P2KluVnuiRzFv1alkQ6cUdRPZpNFIGLTO4uTCszOQNZ+OAa?=
 =?us-ascii?Q?LBrblGdqCaoF0fS9lTKDvvQZwM47akMomA5NU8OqKQSL2CnE9dlG6Mq7wgjA?=
 =?us-ascii?Q?z/OfOs47KikUx1xlXxLtPGNhPTwbjIJj+n7XWy+AJEKGOuZlW+YT8vJSfgE/?=
 =?us-ascii?Q?gjUcfkZ6bypYHDZBMx6sOgUAd1byyvP4++Wm7h9JHitnV5X2R/xD5D0CTVqW?=
 =?us-ascii?Q?Oqx9qSg1c/cujokgRvTFYxh4nhowVtxMQSUGfxnsOHvS0vJerMp5EKnZPieZ?=
 =?us-ascii?Q?16rUd8vJ/AIfURcl7FqRkiVzbc/iAuJQ/JwAUuNwOAhGfKW2h5Vg2vf2jofJ?=
 =?us-ascii?Q?r6sww5awTP/nVvmlQ9wtyWaMAj6tnI8r7DYXURQsP9B8JZQYRlEIlqtyhQ8Y?=
 =?us-ascii?Q?aqJGWPEQBzDeSPxJMwfdtbzESNtaXRcxylkeQ662JZtXarfWciDQe9yGo+Ht?=
 =?us-ascii?Q?h5EsdnLYgAyA2blj6CqtV/U5w/hR4ernEZpfJECh51uT90ArHGh2/EJXtRuK?=
 =?us-ascii?Q?Z+x+1X8YBAwBxo04a5TcfT4anzNBgbmYYmtsXRb47pm06yRvVr/FCoRS7Vn6?=
 =?us-ascii?Q?lhz9JEGlZ+718tMsPP6TfkunIWt5k9NWmrGWTWaWPweLfvN36f/Yht7VQDLN?=
 =?us-ascii?Q?qyY29s2LaaA9SHDyVwX/Yz6z7WRAQk4YDI9/heaOVZ5bGQzlP0UPX9HP+wRv?=
 =?us-ascii?Q?b18NiYjZ5Pem2tTeomH/p5wDLcd6vt4DytMpMZ3BtGC9bruxHCiJ0ebLQMgj?=
 =?us-ascii?Q?CO/R9MesAH7mHTiX83SNNJt5BZUclevaXo4pdTPPm9v5Msjd5I7tE2q1SEWV?=
 =?us-ascii?Q?9wGk8J7hQN3ag8raRgWufDDeEokyDj4cfhW1ibViBas7TK6C2bo6toinEVP1?=
 =?us-ascii?Q?E1AqU5nX7LO4fUdj5fmJGisxWHcRZ5phRw2/JtuImwb45oHFZDdajuAXp3wB?=
 =?us-ascii?Q?7vwCsjzZSGQNpgxAOEZGX3m23tOJeTuXqTDEBHd9w9B8NocWQZLcd71hBiCI?=
 =?us-ascii?Q?Rj6WPk4+h/RpIORkyD23kwhE5Trw5Nqg/P1gxwYKZNoPqnCLJvmsauTb4Xsh?=
 =?us-ascii?Q?PEvcVNryld55XLTM3BIK1tBecCJcw4XiUQ19pdZ1XLTtx8cDPXIxujGlb6OP?=
 =?us-ascii?Q?6dWoa+/3LCqXr+O2pwt1+kYYEYgwozyUyfAdD3QsDDjATDXdiW/5pGvcwz6s?=
 =?us-ascii?Q?n6ecSMNPVK1SmW4hFUEWSPpsTJxEWnUgMmddsljjpy1Z/0oSLnZl4ZPPFpC+?=
 =?us-ascii?Q?V0EvQ3DruxDHtQPS9rUpHXj46ZNEWuam8p9iVYFdrM+HDf96VpJ6n1Xu9Sfn?=
 =?us-ascii?Q?zl131JxFUnGOyw/O8FUnPS4uiAKoS57LBszhnPiFLoT6/zDL3dfL9vAHIb8a?=
 =?us-ascii?Q?N5L4nIBHs9XpDTZJ73JcBNVZyClsgDMVu2Pw5T1b/d0QzAalouoEt6DRTYsP?=
 =?us-ascii?Q?TfK6q9iiJgT1HtNXtOefL70=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ncv1Nw+1suxKcO/AvHVKquDy4fXMxJFGDt1F+RmL+ni/OJFwXCHzCO4Dvp/p?=
 =?us-ascii?Q?Y19WYFxuM0/DdjwOMwYe/yYql3XhBHor0XaMYXlJh6yWX6zniP4jnaBNk3h2?=
 =?us-ascii?Q?Vr37uHPizzOfrzXY9UKymbvfNCmrowTQAkapIvnTYmC42hPEwV8wu56ISfuM?=
 =?us-ascii?Q?5cocZV7zPHG2869s3NUNLNE+eTBIaE63lH1PfGHbK13uEP5IEZorEacJsEgK?=
 =?us-ascii?Q?c5kHcKIQhvQZcLqmHWQpuO43z7nJF3Jo24sK6wyQI981lehrrI0AFmyCxzp1?=
 =?us-ascii?Q?MUTEnpfco2SlBnkpF6bVBfDSBNJgiEkvBD17tLtAdj5yJ45axQxTq9x6WU0a?=
 =?us-ascii?Q?XB+0Isj6k9XAq8lz7o3nAzzbyKidGu76W5OoreOd9611A5UaASrnmprCEfO9?=
 =?us-ascii?Q?t0qBwkjys8KVeKThZ69iXEDNG/YmsJ5qr9AfmccBmW4odFAdkGg1IwU98AqB?=
 =?us-ascii?Q?1jj3OUBAWMXbW7mqrt2NPKXSVZda1W32EzO+VLOhHBcipV8302/aOPNG1EV5?=
 =?us-ascii?Q?epT8UKVyaZAscOsuhu+mx80DMzLgWodpe1dWIpFiByaa22Q4UTo4x+w6BnUi?=
 =?us-ascii?Q?GYcIiP2HHvq1Dq8+CGD5dgMGwKMUGrxD0bkE4nDHfOmqNz4CzmX4BNpTUAwp?=
 =?us-ascii?Q?3ONxexDEaen+3uHY5Ev+yHFnyBrleV+QF2kWjf3QB+mSw1KGUaxzLuam79zq?=
 =?us-ascii?Q?e1k7jX0GfG8pbaAPFmsecJIAgQbE5IWPKa38XrA/MeO+apWnkOUmRJZLudGB?=
 =?us-ascii?Q?7z1Dx+5yhmhgsCRrb9Ld2NZUvncYF7LDTE0XiLdPZR3g5hJUxajU9FGrMnNq?=
 =?us-ascii?Q?SkZYCHwzAEyjbI9oC32HXVZdWaKIAI1X12JbbYwuEbJjzNKNJL4OIFb2cfEr?=
 =?us-ascii?Q?5eF0dbrOsAfqpFGBq5U5cz7O+fG+hpkAXfFtbUCIz0sg/3CPSqH8WPC2L9Vg?=
 =?us-ascii?Q?BRkZvr0dxlXiWaNHgrEz+4ojDEv9sJCy2QBP3k2PXmYm8G7vy43dnVHiHtpM?=
 =?us-ascii?Q?d+D6mwb7GuiF+GtQGjSLtmzm+squw7ouiscEogx1cfOhNY5lczy+0HGS2oKM?=
 =?us-ascii?Q?ThQzuZa6dOxJR7hDf+P+KiRQyV08D5TAIRNBgxPdZyNzKzDg8J0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35df5d4-8d47-408d-13cb-08db50110d21
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 22:10:37.0123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLeMvitJG43/EDLVHwv1kUAQW6dFyWfjNa8AzlyeetbJENXFDnwF0u/rvwp2zY3dZU6o34WBlvcu601wazI2uIg3oClu2hCIrOUpNmTebUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305080146
X-Proofpoint-ORIG-GUID: I9kAFTEb3FpvcC7JH2TzCnl-1dqHFdCn
X-Proofpoint-GUID: I9kAFTEb3FpvcC7JH2TzCnl-1dqHFdCn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a new link restriction.  Restrict the addition of keys in a keyring
based on the key having digitalSignature usage set. Additionally, verify
the new certificate against the ones in the system keyrings.  Add two
additional functions to use the new restriction within either the builtin
or secondary keyrings.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c            | 52 +++++++++++++++++++++++++++++++
 crypto/asymmetric_keys/restrict.c | 44 ++++++++++++++++++++++++++
 include/crypto/public_key.h       | 11 +++++++
 include/keys/system_keyring.h     | 11 +++++++
 4 files changed, 118 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index a7a49b17ceb1..4249c49bd43b 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -51,6 +51,27 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
 					  builtin_trusted_keys);
 }
 
+/**
+ * restrict_link_by_digsig_builtin - Restrict digitalSignature key additions
+ *   by the built-in keyring.
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @restriction_key: A ring of keys that can be used to vouch for the new cert.
+ *
+ * Restrict the addition of keys into a keyring based on the key-to-be-added
+ * being vouched for by a key in the built in system keyring. The new key
+ * must have the digitalSignature usage field set.
+ */
+int restrict_link_by_digsig_builtin(struct key *dest_keyring,
+				    const struct key_type *type,
+				    const union key_payload *payload,
+				    struct key *restriction_key)
+{
+	return restrict_link_by_digsig(dest_keyring, type, payload,
+				       builtin_trusted_keys);
+}
+
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 /**
  * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
@@ -83,6 +104,37 @@ int restrict_link_by_builtin_and_secondary_trusted(
 					  secondary_trusted_keys);
 }
 
+/**
+ * restrict_link_by_digsig_builtin_and_secondary - Restrict digitalSignature
+ *   key additions by both built-in and secondary keyrings.
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @restrict_key: A ring of keys that can be used to vouch for the new cert.
+ *
+ * Restrict the addition of keys into a keyring based on the key-to-be-added
+ * being vouched for by a key in either the built-in or the secondary system
+ * keyrings. The new key must have the digitalSignature usage field set.
+ */
+int restrict_link_by_digsig_builtin_and_secondary(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key)
+{
+	/* If we have a secondary trusted keyring, then that contains a link
+	 * through to the builtin keyring and the search will follow that link.
+	 */
+	if (type == &key_type_keyring &&
+	    dest_keyring == secondary_trusted_keys &&
+	    payload == &builtin_trusted_keys->payload)
+		/* Allow the builtin keyring to be added to the secondary */
+		return 0;
+
+	return restrict_link_by_digsig(dest_keyring, type, payload,
+				       secondary_trusted_keys);
+}
+
 /*
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 276bdb627498..6b69ea40da23 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -148,6 +148,50 @@ int restrict_link_by_ca(struct key *dest_keyring,
 	return 0;
 }
 
+/**
+ * restrict_link_by_digsig - Restrict additions to a ring of digsig keys
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @trust_keyring: A ring of keys that can be used to vouch for the new cert.
+ *
+ * Check if the new certificate has digitalSignature usage set. If it is,
+ * then mark the new certificate as being ok to link. Afterwards verify
+ * the new certificate against the ones in the trust_keyring.
+ *
+ * Returns 0 if the new certificate was accepted, -ENOKEY if the
+ * certificate is not a digsig. -ENOPKG if the signature uses unsupported
+ * crypto, or some other error if there is a matching certificate but
+ * the signature check cannot be performed.
+ */
+int restrict_link_by_digsig(struct key *dest_keyring,
+			    const struct key_type *type,
+			    const union key_payload *payload,
+			    struct key *trust_keyring)
+{
+	const struct public_key *pkey;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	pkey = payload->data[asym_crypto];
+
+	if (!pkey)
+		return -ENOPKG;
+
+	if (!test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
+		return -ENOKEY;
+
+	if (test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
+		return -ENOKEY;
+
+	if (test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
+		return -ENOKEY;
+
+	return restrict_link_by_signature(dest_keyring, type, payload,
+					  trust_keyring);
+}
+
 static bool match_either_id(const struct asymmetric_key_id **pair,
 			    const struct asymmetric_key_id *single)
 {
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 653992a6e941..8eb5eff059f3 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -80,6 +80,10 @@ extern int restrict_link_by_ca(struct key *dest_keyring,
 			       const struct key_type *type,
 			       const union key_payload *payload,
 			       struct key *trust_keyring);
+int restrict_link_by_digsig(struct key *dest_keyring,
+			    const struct key_type *type,
+			    const union key_payload *payload,
+			    struct key *trust_keyring);
 #else
 static inline int restrict_link_by_ca(struct key *dest_keyring,
 				      const struct key_type *type,
@@ -88,6 +92,13 @@ static inline int restrict_link_by_ca(struct key *dest_keyring,
 {
 	return 0;
 }
+static inline int restrict_link_by_digsig(struct key *dest_keyring,
+					  const struct key_type *type,
+					  const union key_payload *payload,
+					  struct key *trust_keyring)
+{
+	return 0;
+}
 #endif
 
 extern int query_asymmetric_key(const struct kernel_pkey_params *,
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 91e080efb918..38f63f1c2cbe 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -23,10 +23,15 @@ extern int restrict_link_by_builtin_trusted(struct key *keyring,
 					    const struct key_type *type,
 					    const union key_payload *payload,
 					    struct key *restriction_key);
+int restrict_link_by_digsig_builtin(struct key *dest_keyring,
+				    const struct key_type *type,
+				    const union key_payload *payload,
+				    struct key *restriction_key);
 extern __init int load_module_cert(struct key *keyring);
 
 #else
 #define restrict_link_by_builtin_trusted restrict_link_reject
+#define restrict_link_by_digsig_builtin restrict_link_reject
 
 static inline __init int load_module_cert(struct key *keyring)
 {
@@ -41,8 +46,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 	const struct key_type *type,
 	const union key_payload *payload,
 	struct key *restriction_key);
+extern int restrict_link_by_digsig_builtin_and_secondary(
+	struct key *keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restriction_key);
 #else
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
+#define restrict_link_by_digsig_builtin_and_secondary restrict_link_by_digsig_builtin
 #endif
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
-- 
2.27.0

