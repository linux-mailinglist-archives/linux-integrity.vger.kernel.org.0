Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41A26FBAE4
	for <lists+linux-integrity@lfdr.de>; Tue,  9 May 2023 00:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjEHWLa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 May 2023 18:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHWLR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 May 2023 18:11:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C4A61AD;
        Mon,  8 May 2023 15:11:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348JOmCD025761;
        Mon, 8 May 2023 22:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=WAc2o8evP5QrJAXt5SFJeOiH/ErrwgwG5Vrrg8IgJBI=;
 b=P2E/OLwB8rMzih6truj8UnmE2dKbSSle7IteBONmjJ/gZku/uibU+cFPkQXtDBtUB4RF
 GJ0K8tMBdb6qDoDw/Kk28ZTonrd4MChAAj1FBgYaJFViybfxeLBvJVf3bTUDsUT3g0Fr
 CDXXAuZJusE8j1A9FsUd3B2sYh4JXVDnm64pcXBJUU3KSBWnmdNPoCnAtDJpmJ2zOqPq
 82D3pMblKcg006ED3iF+mNlPdh6q+mbfjbpGoHN6v1c5b+L7EO1juMe3vKMDjw62QxLN
 DdFSPiiuGnLV7PUFmUKON827d7WpqRNBWqw47ajVVxzxxdmdUSJbPOrlfx2lcEaXQOcd 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77709p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 22:10:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348LW7nD015439;
        Mon, 8 May 2023 22:10:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77f56et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 22:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsDk7FF/kYRqRXPz8CbdkLY1uXMhIEaRaKMLf1J0Cqkgxa+Wj+x9Qx2cpwKyfYNQZz61V+oepdLEPYqUGa42Mto8yzr+AupwBtuCkt3+4dQtRVgH/d53FROqrDhcEA5lWAhSQ88mgi1qyNwkrhgpjCWdmB/7e5h0tk7YEvl+5zHrnrhI+0yWl4UO4Nw8aId8xahLDCWdMLKnhDbE+pjZIuIgx+0Vr/4F0ZJcENDxWLEGVGpWiGO8KMvTOT2bfKCx+vfh0JILmbh/RALfbU7siULUvSx/hmgsKLqnLz5eQMoCqts6qVTiJWFKISjRWF76nzjr1+29HrJsvS0AWVVDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAc2o8evP5QrJAXt5SFJeOiH/ErrwgwG5Vrrg8IgJBI=;
 b=iilygXdY3kp9vZl8HNS3Q/Kb2DRrpaeKpUA23635d9EQj+tP9jnnI133W64Y3bGoCmyWn8LDFm9WAVG3QOr2uAcCQVM3qpRdSQ6R7DQ1NH1s6xm0psR3inldRkRi8LYGoyy3HXwVJqLNwtotqWJGf5i+eGL1pUvtXL98PT2fwxRYthqnByCv1wrMxqa49/05GfH34RV8UBJ0hGdS99jPTxzz5PONxglrjLRLHv+1ytc1fXh1LSJgQHBDXdQfRCGvCcDGZLyDCq0jOEQOWLdf4czvOr93OXrqyQK9R5Hyt9K4O1AfCgWSkDGIlFNV4HeiPb5uZOF3XFKVHF+eMRhXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAc2o8evP5QrJAXt5SFJeOiH/ErrwgwG5Vrrg8IgJBI=;
 b=uaJuQDsbZ7Iz9TvaTp/Lv41l5CmZokbq9A+FzogNtGGSr2JgPF/gw2gxots5R9Gf5uG91QCoZ5IcxmZa5vjhHwHZxLM1A95d2xOql5a1s+eyDxiwtKKHGcRdWKFk6k0FMaPpSbA5JDe2m6IQTehifA06hmkIOjnlgMFMDwr8LOg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB7065.namprd10.prod.outlook.com (2603:10b6:8:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Mon, 8 May
 2023 22:10:40 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 22:10:40 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, jlee@suse.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 2/3] integrity: Enforce digitalSignature usage in the ima and evm keyrings
Date:   Mon,  8 May 2023 18:07:07 -0400
Message-Id: <20230508220708.2888510-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230508220708.2888510-1-eric.snowberg@oracle.com>
References: <20230508220708.2888510-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS0PR10MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: df2284cf-9e60-469d-7231-08db50110efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9h6UPQkvZDqoGeY4RbalhGy1pK6tb9FdeqGylmIIPKFt1O77nQJ+k1Hrd1JUBBZVa4F6isR75Rym4aYONxRUvjDe8jvjyKRNeLQaq+SwXppattlwZ4ltO7wr4sk/dIPPRAEy1PDj2G20vWMBfePXzWZMSr8ekP8+LRwdXaGG88Y0rqS83FMwPMiLmlSG+FTOg53yzzIhvR9abs4mjQDDaMs31sgBCwjjh5MmasCPHYWaef4TdTvd8O1EOTHmMFIXa3UcUDvZnUolkJn1ImRcv8r4aY2vqaRsXSpb0glp9xqz0QEQM7e1Hxsjg51+s/A6y+Yk/Eq7QkV9nUlqQVvnzmczr+TPy/eTvInVtsUXMeJZn57RpMm/PeS4SJBIMrX4/AdjkkI+7ThDjz5sZan1gCGfbn8Wc111ITcwRV3t4DiUeffwxEjiIwlcSZDf0oW0msYvvhQI/JwkEq1kqtR1piV7YeaD8IZlBser1nNldzaT3gEPXa1r89ZtyFc5k6AUnw/J/uvBxUQZE1ZVWuLbdefp7/N47Du/g/zfW2bN6sM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(83380400001)(2616005)(186003)(2906002)(38100700002)(36756003)(86362001)(6486002)(8936002)(8676002)(966005)(316002)(41300700001)(6666004)(5660300002)(44832011)(7416002)(478600001)(66556008)(66946007)(66476007)(6506007)(1076003)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DeRtIrzdGhptxhaE692XkggExcajncWNpeDiyDRIeMzt6nItQ3YEa34QApQo?=
 =?us-ascii?Q?d0ZjS9Qx/rPpvLT7jb7yaZNgq1uknlU8CK8yOlveibU8QieIbuwei2egVrek?=
 =?us-ascii?Q?5UH0BC1N9NW0ZmcDyF5UhIiDjqcaT1mh9SDHInWzmnJuC0gMNzJQFVrQR6M/?=
 =?us-ascii?Q?XhgMCHA0e8nTK8vJmEORoMC8+/fg7gLyyEvFdmuixDUZGLiE26Mx/i3P2j5t?=
 =?us-ascii?Q?nzuyZK8OZ/S1TLoXLLpr3p1FJhh5Gyu8cgH6QqV+Xhnyvox/oHTxsfhT3oWP?=
 =?us-ascii?Q?Dj5kBOgdNP8LZTvmWvZ6RuVLujccnm4opgZ87oQ7Y8EjEIbj59TQw6IWoGJx?=
 =?us-ascii?Q?mCJ6RYDg5Wb7w3i7ao6PZVTENZG5YzvhJPijzLC31h+L7q/olT0lV1wuiUbO?=
 =?us-ascii?Q?udkJIv2XOk7xhmiuVjkXis01TjL3qakx3X/mGBJOj3JilYKqEzA9PbYLGMqL?=
 =?us-ascii?Q?1M8DbjDPoLXN8vQT7y1whkKnW7o2TcF4a2tYjtaCFTsBvpUHUap4TBWNMLyB?=
 =?us-ascii?Q?jL+DjHn04MJ1ij5i7K7ixvR8dty84XBgLX2EdbglRsJKt3B7r+LonGz1D7YM?=
 =?us-ascii?Q?igZojzVhb9TlcKV0P++U5tt6gdqfKClDrcFYTTTlrXPw/D7OuoAPBVApWAyT?=
 =?us-ascii?Q?qT2LEjt7xW4wC+8K76F4XhN23h+VVtKwwKNyVODpQJsoKkaoSsCBVjNCG2Wd?=
 =?us-ascii?Q?3Jz5PPhJHjw5vbxZRzPvYkNvjaJphyO4vmmTsTJ7m93WTAtZ+eyHbW3V91v+?=
 =?us-ascii?Q?AuYwur2BPpiUed7mJn2F7RQs8NsSsKq4P8Jjcy/isXSLm8DOIeKAs9R62aXE?=
 =?us-ascii?Q?D/scQSoqaAH6r9t1g63MwzfqdTFm8rbb1NeWvKo0PNg5XNbdavUzQ1MZy2dQ?=
 =?us-ascii?Q?wFas3LK+rjo1YUdBnc46/5PO7zRfnX0Z/1xSr1rS0CEcmf737pt4nKi/nAQp?=
 =?us-ascii?Q?dMcVBVr2fay8eDhKkalMvfaFZWB3bIccyJkhi12gzcBiFyC7CpxoVo83ECh6?=
 =?us-ascii?Q?q+ia8GKQUdPPOaRYkn9DePqwvQ45yxmTj7PWObpluDPnOYCiZqWphrpmmE+7?=
 =?us-ascii?Q?Vm2V9QRSy7nDpYnoUdM2Z/F5eQ+DPlSVmZtGUdmFH6BiVGaDF3AAVN2DtlfY?=
 =?us-ascii?Q?RiYDl/6HOIzS/S87eDLc522zoj+BtFkDDEBONj1zwFdoJG4NgBswK4LmpZeF?=
 =?us-ascii?Q?AAIoyuxGvb/C7uI3kAYp950Xtf5CSI1oSH7a3BtbgJ4R/60+5QkOaEtNxzEE?=
 =?us-ascii?Q?RhCh7r1RNu22Evsrri7hB5+zgU+4Bomz5idV5ZRmPmatkJfvMGG7U4X7laSh?=
 =?us-ascii?Q?Odr+NVjkR3Q48Rxf34ISm2uysKUAJEHcJtGGW/DsBUlBxf8ntKiocePzCs3F?=
 =?us-ascii?Q?wM2LvXCU1e6FaZ1NSPND8ZPmZscSUcLb5nH21NfLJ21kAFXAPQxT0ICAfo2B?=
 =?us-ascii?Q?9QezzFLM4T+aRrY6FBeCosUDpCFqceHJunCOVperE61J6/UnIO6Wgt81bOkc?=
 =?us-ascii?Q?colAsqWmVRdEot7UDfKws0LhidCQGnGcq1tLHdfArISVr1gWN+fZolJflhuT?=
 =?us-ascii?Q?NnJaLWeGPQ5bsfwCyjVIpLOpGdQQ8KkWr1IF9dlgqqDtXVj86l2SyJE6Bvil?=
 =?us-ascii?Q?IQd2qwwH/HhFDED/e42ZG0w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?T16wsvkYXxfGbQIC5pVXrr8PcuhwjBxsAZMjGpadHa/pwfGxZ4HBk+YFrnMC?=
 =?us-ascii?Q?gXaqWkfTWF66Melhgdud01A56u06ixnp+WJZqa4m2GKif23SlCnG2QImHiGC?=
 =?us-ascii?Q?XdFA8H7wAv5msFwM5I1whdtuuU932J3413iovaM/+xaugKtuU+mPjRd3Ca7n?=
 =?us-ascii?Q?rV2OAJ/4rNqNx6k8653vRVFgiaeJ0FFenIMIkcw3LtIGDruq4rUC2euBZc3G?=
 =?us-ascii?Q?eCMovK2R1thrlP4N5Hi0R49l0BpEBqssZLBigvDHd4GCvGsHRNt5tBIEoyCa?=
 =?us-ascii?Q?DvnPd5d2huYR9hoc3KaaRDb8FWUpYc1KbaL2fUx0hFit2E/qS/6wXidrshRk?=
 =?us-ascii?Q?f3T17t+KjEWpsb+65f7zrYwubr8IomXbC0FirnfKhI4k2B1PzaPLhyIySZQd?=
 =?us-ascii?Q?YM0rzV7q19qXZzGelIpGOb1/wUF+iX4jn/jagmW67Kh4vyhGkgJIgEK+E0+B?=
 =?us-ascii?Q?oH6jfetzpOw9AzfURbnpDf7WcXRNFVGdJUZZGvfsqj+4IgPX6DF7Jv5QC99Q?=
 =?us-ascii?Q?lp9tL28q4WGfNc7AWO/4jMLMHIssoAqGYEUME3m38agU2CZ1BpZytkWaaRZl?=
 =?us-ascii?Q?qHZbPkLx4RLg0roRI3qP+x3l9kv4Mo6nM0jucog0BkShlvVJzA0/mqjHFh2i?=
 =?us-ascii?Q?Hry3xn5tMSIaM/2btyx6QqTMDawu8GhJCYzD+w99fO9ZJPOVCOeAROiMP0X4?=
 =?us-ascii?Q?1wr+o2UW7V41hoGZbs9rPBvsYjcv85JE+Vp7MnvKfOFgr2x4A7T9b7k1a7vY?=
 =?us-ascii?Q?9N1gISYBCBE5B55r27uY4DID5gFYWQ0SwoffE8bSI7TIk5dg+zlJPfuSPrh0?=
 =?us-ascii?Q?pvzJYyw52NK1jSc66NQcwxKRPwSkyez6dY5qbLwfw97hmQwKdgVCXXmqqIOj?=
 =?us-ascii?Q?HInXi+HhsyRRAe9V7xA4GQibOcpRBKgb3JWVmX3eoKcCISMw1uooM9YZei+r?=
 =?us-ascii?Q?d3i/cRispiFQ87rCNb/deZi+a2gXneC8EVYJi6NH+Ba4k1pBr6qR1+UcOxto?=
 =?us-ascii?Q?aEwq46M6Ly+MvMOCuLf2eCCVLMG/qvlXd+dlsDzxEowUE3EzDtwI8n22axHI?=
 =?us-ascii?Q?arX7lz0XBLTOd9SbmkmlqRY2ThvvWRuWp5vBzXSLHt13USC9uag=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2284cf-9e60-469d-7231-08db50110efb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 22:10:40.1774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dFVYDX1uD2S+Z1+NKez2DYxy4NlFhCDvNZlyoZSsgTpapoOkHjHPRUrDGNH4/AOTdSnkwY3wrQz63jPS1E6slJZo+kQ7hA+PvptFV3O4Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305080146
X-Proofpoint-GUID: NryV67p_AYvlZYAGQJh0ILmMLP0R3k0e
X-Proofpoint-ORIG-GUID: NryV67p_AYvlZYAGQJh0ILmMLP0R3k0e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

After being vouched for by a system keyring, only allow keys into the .ima
and .evm keyrings that have the digitalSignature usage field set.

Link: https://lore.kernel.org/all/41dffdaeb7eb7840f7e38bc691fbda836635c9f9.camel@linux.ibm.com
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/digsig.c    | 4 ++--
 security/integrity/evm/Kconfig | 3 ++-
 security/integrity/ima/Kconfig | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 6f31ffe23c48..d0704b1597d4 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,9 +34,9 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
-#define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
+#define restrict_link_to_ima restrict_link_by_digsig_builtin_and_secondary
 #else
-#define restrict_link_to_ima restrict_link_by_builtin_trusted
+#define restrict_link_to_ima restrict_link_by_digsig_builtin
 #endif
 
 static struct key *integrity_keyring_from_id(const unsigned int id)
diff --git a/security/integrity/evm/Kconfig b/security/integrity/evm/Kconfig
index a6e19d23e700..fba9ee359bc9 100644
--- a/security/integrity/evm/Kconfig
+++ b/security/integrity/evm/Kconfig
@@ -64,7 +64,8 @@ config EVM_LOAD_X509
 
 	   This option enables X509 certificate loading from the kernel
 	   onto the '.evm' trusted keyring.  A public key can be used to
-	   verify EVM integrity starting from the 'init' process.
+	   verify EVM integrity starting from the 'init' process. The
+	   key must have digitalSignature usage set.
 
 config EVM_X509_PATH
 	string "EVM X509 certificate path"
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 60a511c6b583..684425936c53 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -270,7 +270,8 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	help
 	  Keys may be added to the IMA or IMA blacklist keyrings, if the
 	  key is validly signed by a CA cert in the system built-in or
-	  secondary trusted keyrings.
+	  secondary trusted keyrings. The key must also have the
+	  digitalSignature usage set.
 
 	  Intermediate keys between those the kernel has compiled in and the
 	  IMA keys to be added may be added to the system secondary keyring,
-- 
2.27.0

