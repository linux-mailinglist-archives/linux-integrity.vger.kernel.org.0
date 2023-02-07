Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A3768CCF2
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Feb 2023 04:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBGDAi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 22:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjBGDAf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 22:00:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B868B35278;
        Mon,  6 Feb 2023 19:00:32 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KDwX7000337;
        Tue, 7 Feb 2023 03:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=OqiHEGMGIC+F47o4hpjg5RDQMq0JQ0n3vZjl4LplxXY=;
 b=lFGTNyJm3pD8OZKl+4ZiJpxIHrkbeN/yj+dRuEjW4UpwSr4iKYHXaVgon0v7Mc8GmAs+
 2LJHIMEi1mcPWje/oalQ3nCL8HhttUwnRSRZA7STC4ZDAt3UqzinxdnvZwseREIFqRtp
 0DYd+UfcrqVTJ43TBi9a40tbWO0oFRrUasGfPKMzaYqo/G31JIORIQsKavk4DAUu7s4M
 CVlgWVirCziqVqCUGJt1tzIXaqM0wOvX2E/rZMcajkK13OQkqQ/7f3tG441O1qxJcK8B
 2BxVIhA5yaiBvlvnZ9qCdTVOWjGnmyIvwQw5KTsix8xRCE1UvsDPjzE6F6gSRB3UveKq cA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53cgb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 03:00:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3172039V037045;
        Tue, 7 Feb 2023 03:00:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtb8beu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 03:00:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5u23QEeyvvFUHJFyWLOhc4889NsvNkyiXaUosiI3F8GNnSh2rP88bq7cXLPWKLO2Y6vrlvuEQwcX2awvn0ZlktB1xj/e/nLaTrx3BikffM+0LHdgsuOT0P54Wg23HgTZpKnkyalFKkuSTnJRKn738xFfMp158xB53yKst6T47UZZyLD3FDx2NOyTDoLPk10MSoS8otRp1+GtUaaYIHpDuh4IFG9tMqxOrFgdDauVIPwV3MbMBFkrqbA5UDJv/Hh6F461PYgF7boqbX45476lShNKqikHLfL/qoy45NIuKf9PuYcrT7nA7AgReZQXEdkHKNZKhWTPyC3OpByL93aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqiHEGMGIC+F47o4hpjg5RDQMq0JQ0n3vZjl4LplxXY=;
 b=HHXAKdUt9WwXkznduDHKOKy0ebkapvew8kvmD3RZSlE33rcWryjc4U/gMlqnuiDQ8dp0gWVi12KNMCUaHBds/6BhmkMZpIj/NOHy9YYYvHvPQwzRYpA8eky25XR07eXAzaS5VOqtrJ8rMKKVkwekpw54b9hU4U1F3Ue/9GSHwSZ/MzOi09d5B3b2j2fP2NcdAKrg2Gs76DzVc7X8vMnf5KI0lSnj52Wo4MYBQX4BvUgUAhMVp3MgrVfw3mndPOhL9VobqwtKyYetTYP4FE7BspF6RLa6jzbQZJEnf5mq1UJlEPa67vydCJtY9jPM2z13/CwoVsLe2k8pjfKh4o2yFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqiHEGMGIC+F47o4hpjg5RDQMq0JQ0n3vZjl4LplxXY=;
 b=Mt3ps9htHE8l0NWJzFCq8s9Xq6xkZfxY4AVyIPs4RArFrdtpB2YrVvI2r5hwe/qV2cooU+/lSgQ+A7tpEQ/N7Ez2UKRmAHnuWvKy9+1/VkgI5rSW+KBBoeow7pDkVuIMg6uWdcspV+qfZ5x5KoMk5f8jJKAkq+rkc6z45SlnVNk=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA2PR10MB4602.namprd10.prod.outlook.com (2603:10b6:806:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Tue, 7 Feb
 2023 02:59:59 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554%9]) with mapi id 15.20.6086.011; Tue, 7 Feb 2023
 02:59:59 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, tadeusz.struk@intel.com,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 2/6] KEYS: Add missing function documentation
Date:   Mon,  6 Feb 2023 21:59:54 -0500
Message-Id: <20230207025958.974056-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230207025958.974056-1-eric.snowberg@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:805:de::43) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SA2PR10MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 07014df5-10cd-407c-ce80-08db08b76677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtwwbosltfefbWGx0izktrLDSKr6Y3BvcweENsYZM6VzOZQnW2cG4/YnU2Nt9qzVQGWtJqOjww3FTYs4aLG3+k0ZS6ebN6M2PiXyk4ZioQAfVzE9fzzxdDJxb7vI81RRpzT5AxRBPcgsfCuceswYnN+5zoPQPVOugoSsVopSP1QlcSeNEhF6GSr5eRx+tflVmj8jUx34nOM4wBslhyrWiDigRv24z6ZqLwcgexxhgBs4HdhiIrue0/nXCM5v6tr4INZdIFENIuK0QoOQ9BS1+1eQfrh3tvyBxCk+Xc1dY+wnlp4Ruh4whkuocji3VcAFkMLa96LfgrXJcbAhV2nagNXDZWWX1D/q0xmjnYz1ps1VkG2PB/F98IaWTe5lYNxbv6cGTWZGJzsmEA81iuiqWa0+Fk19wESyoFmPpMvYFPGJrlsOFTdtbpHNkLgn1+y5jT9ZWDoDUkLQZSgUI0Y1Xqq3uWQLLnMlT3i02X5kiBQbVXbBooD2prk/rBmL8/cp5fvK7s8AhwxZdNsz+mXqzwCh4STv5U7T1+TPsaYPfrpyXF0Rye1NHl0//OhzfOSIDrexpKAtbJ0tBSrOtdI7OI2PK90KjkwHJmHYQ2WFqauHW8rEz46nlo2r2GIaarIxeZopj1F8YNuH3GEvvACCdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(66476007)(7416002)(6506007)(36756003)(38100700002)(316002)(186003)(6512007)(6666004)(6486002)(478600001)(44832011)(86362001)(1076003)(8936002)(5660300002)(4326008)(83380400001)(66946007)(2616005)(66556008)(41300700001)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lxW+UimtAsoK7RyQcCMnpZCcJVN6bEnQG5YEu6e0Hm6ZDaw1v1zBfYQ2hmHV?=
 =?us-ascii?Q?VOn1SiPIs5IMu1DAsvlrODJZkIj7ONQ78FRxbJd2Hl68xWXdogWn42HSmFIu?=
 =?us-ascii?Q?TXVDXlllxEZqwHstTjOOOtpNUTI7C/A3V0aqT71YdO3UoJ+6a4g6G1m+z14z?=
 =?us-ascii?Q?T+kwudp/gJ8WxbwBVyCAyoh7ua8tIEYTILlLLsCOQZNb6FR9PPZwy3Rhi1SB?=
 =?us-ascii?Q?peODkhzDqUSUg3FT8dPgeUZJN27Tzez80DzJ1jP3SzAsys4RGaWqtC3pWjlW?=
 =?us-ascii?Q?Iiq+B7IcWoBsX+NyfjAKJhnr0K00w5GH03XfLkndQ50hft0NlvUdAU3m2nw2?=
 =?us-ascii?Q?OrwTniIL+Oz3pDK+Xv5wsRyt16WGoTukqCx1iJ60+czSBHtErZprn1yRBN+4?=
 =?us-ascii?Q?kxuIJ27Of5Gm8X/0P9FWmgTSd1IEf2rWjv8qaj5I3RCa5hbgmT2uvGl/LDd4?=
 =?us-ascii?Q?NHOCLOXD/+GHvHnwolhZvMK+Wez5HYNk12qdn7NMQ/nWHdWTz/qX8C8VH9FZ?=
 =?us-ascii?Q?xm5xRQ9bZY7tjDkSQzdYxlaeSNHJOsiYxKkJ4NzTemcfmMPJA2EKq49HWufb?=
 =?us-ascii?Q?+kvFav8XtXo89+Xz44si9IyjcqKl7RidchbzPINiBplNFjCSaTfwBY80mu3a?=
 =?us-ascii?Q?55Snlbnip9rqhSw2LiXkcjk5I1EI7bvC55AnDhb4+wUnJgoIArt15JTXWQXG?=
 =?us-ascii?Q?J064wdCd69ZoxZqh7wwxIHWx6DD68xrZg3x+1jgnowUKBdQ1CnL6Bd0JEiLN?=
 =?us-ascii?Q?P5/xb2B2cqu8J8atE5EZe82o2ihe8VwTdlLxufu0dBtKFkEwO4lTO2U+WkY6?=
 =?us-ascii?Q?ZX/KcR20zrsfCdFzXb4rRLCPtPqRL/eixjPf27WkUmo0oXwgFgimpy0sUYJR?=
 =?us-ascii?Q?3fy1kJ224DFqQi0KHNOLdql4sPU21uLw7fBpaL3Q1z/A12HZFYdxI2lLC87C?=
 =?us-ascii?Q?Ms+NqhJaBEYEMS53nKT7J4saNVCxafiSU9SlC1pEe/aQu7ouWbh4RVQR0NqW?=
 =?us-ascii?Q?w7DotFn4/HlPyzRNZL3i2MyYgEaEPjjKkpJLEDehS80uTzUiXWYwf5EKATYt?=
 =?us-ascii?Q?qMuOtVz6WdrO2EX5OVfqvh99ylc75MWDV4yUradcPHsFQ/MiMMw5qXa0lZUe?=
 =?us-ascii?Q?Bw310zqHJFhdmlYoPowJHfbKyditnAmgoPg+3GDrjVh4x9IJG03n+YfZwR3O?=
 =?us-ascii?Q?YZPsfMr6ia9VgETnEy/ehphsz1TnoNUKwgWYHOmGP6fLqC9JQn/XigfCp2fd?=
 =?us-ascii?Q?zNeQmeAu156Zm161BVIi9CB9mEWVfTrNq7oqfKTocP9aJGf1pDWLDSx8nJE9?=
 =?us-ascii?Q?R873pmPJ2Z3J5Ieyf6vX/UWhlpz8WQYlMhM0CZcVvQx7sJDft/0iD5uWH0SI?=
 =?us-ascii?Q?0Mq+q1uxh93gqSFE0NKWwKkkYD4xEhNSuYce2EYNsnmnE3XRVogGgT24nfue?=
 =?us-ascii?Q?lNVnMrNhILrpvzQ/tkSySAodaaRQt0EDx0FWkHWit0tFzRAqn6UJz1mI5AIP?=
 =?us-ascii?Q?BYR0X5AeWpn7ZV/K/Z/vzhKIbvVei22sUVUS0HQuEr1/+Oxmv2d/0nhRqCHh?=
 =?us-ascii?Q?/2Jh5Wbe5SOMTNW/ZQEEG/ibl4O6knLGGntQ/Uy2DmjbzOxiuCo1m+GngmjI?=
 =?us-ascii?Q?LNmooZ7FQX9Dy3o4tJs2y1U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LfN2dktxyopmD9qv6EFDxafMpH2cL94N1QjNv5x/LaCQtBkQ18juZnxGrzxS?=
 =?us-ascii?Q?p0p7ZXc/rgNaWQ05/h0RYz+Cir/kwJTFeTfbsJtQbFuCxiz/4Oo4eIg4//Uj?=
 =?us-ascii?Q?T1PPETqY1lvsoVuwsCV3lOHl02ZzGPwsTiTZ8EyHYmZIKGqI4rL5xylXSkY4?=
 =?us-ascii?Q?yXPLI4lHHXjiW9Vf74mfEQ8Zwzs6H5u2N3ErDOgrM6SAYHw2m8QHeMCRQ7ou?=
 =?us-ascii?Q?KzR1nNlWfWdLzSBbPFZt8SO8uvmdZgZsgs3+UCb7DYRYsg3KPGyjDhVqxm7l?=
 =?us-ascii?Q?2bbC/GKpkDXomFFGpv25fcLoly3JA3CNP1FnzNr0DjHho7bKTy/IUykVoPhc?=
 =?us-ascii?Q?uDJFa1PX4+euGJTcuU1ad/bYW+B51IPxXYMfXTT/dNjM8EF+UWJb5gIAAwW1?=
 =?us-ascii?Q?eUVazSZhc1BP/mjH4JNAocsVUjLSdVrM7dzI8UM4Uihbqkl0AdRHA9hwfWVe?=
 =?us-ascii?Q?JsGF+cjC9FwDVMDvP1AR54sDMc4aOcTZV9ZNrHfmsOWVWKE7SAvRumfX3ylK?=
 =?us-ascii?Q?Y4l2cemmSZS2wREM2r/aFWtQz4RbzpOqGzrxcETL3me/mNSVx8ZkB0o3VKKy?=
 =?us-ascii?Q?ruObD+cTKflNk5zUuze0v+7AvZKu5HLLs0V5roLs1gt3BBrMut7Jpxg/lejq?=
 =?us-ascii?Q?iIJxL1Ml0terCOwb6v+0+tIMX3BDPe6lEWH49+7evh4MVRHGABfDhSqQbLWY?=
 =?us-ascii?Q?5FIAFopLXcHK1ZgNQmW1x5JaEINPPcATAv5I5aamz8v6pIqTC1oJWVgF/3PG?=
 =?us-ascii?Q?oLve/Rb4ul1+Ghm4+C37n/GEREci91l2dLBP5FqRI5Y7p47dhkvAg5YrkAQW?=
 =?us-ascii?Q?qvNHa0Ncba6yp0tQMKlgLTYdns3ci3kLQRH6rjF+/2LWwqWXobrSB42htuJH?=
 =?us-ascii?Q?ObrXA9HxHV9dVx0adbxj+QpgrfSlimiq6sABAzT67M9D4TiL3Hg68QRMQXou?=
 =?us-ascii?Q?kOsoWom7aDw5wjqVjvwB7GCJQnyjzqZ44LJO1noUiQLAQoPQHraIfQq/Coa9?=
 =?us-ascii?Q?PqtTs3/jSkW3vgvUCla4rUMUxqPYl5BZNsMWCV2LNeB3y8XfwhRJ48KVw5CB?=
 =?us-ascii?Q?5eA0peeXwx6Gxh6ZjkUsxnTpIaDfuYz+UJjtVeBEdsKnFY6f0dKQ4wLl1qmu?=
 =?us-ascii?Q?ouVl8GUu27JbV7/Je1iadcfnnIj5F/SyNNVQZIh+CSAqCxaCoNZ/8NV7QiOt?=
 =?us-ascii?Q?+Y/snFn6KxvX+M4p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07014df5-10cd-407c-ce80-08db08b76677
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 02:59:59.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIAgeVghJJ+bFD4N/lshS8tgy1OEKO+d2CLHHw687g4siAghaPSSJ3tTrTKWlaYbtX37acIU9ydGF08mdI4s2/NGPC75CmhE43mfOfcqj8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070025
X-Proofpoint-ORIG-GUID: UEkSjHBguTn-ayK0QhJWhWn5wlYr1v9s
X-Proofpoint-GUID: UEkSjHBguTn-ayK0QhJWhWn5wlYr1v9s
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

Fix wrong function name restrict_link_to_builtin_trusted.

Fixes: d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
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

