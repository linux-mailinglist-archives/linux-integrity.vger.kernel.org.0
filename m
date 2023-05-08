Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2016FBADB
	for <lists+linux-integrity@lfdr.de>; Tue,  9 May 2023 00:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjEHWLP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 May 2023 18:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjEHWLN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 May 2023 18:11:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A159DA;
        Mon,  8 May 2023 15:11:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348JOwwd013547;
        Mon, 8 May 2023 22:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=+ZxuZqLtwXycLB/M1RtKBPVWf60cLeT/zgVQFmTG5X4=;
 b=DUS+JU/e+XgzwNRJ75FHn2+WN5ea7fwfMgbMNN9yhJmkFuPGcsk2ECPdCMVVonoO1Xhu
 kl5JvdKSWAfx4x7+yfWl1eftKQBdhNLXMugFOnMFzvESP1k75PZaZ8nx7/WabhKd6th3
 LBMEVMNcD1KrEzE3fA9SPl4dpD6QgL6jlzLoWe2CY6ggmGZ7B57yZdjGp1ne1KFzWQ30
 JBMQnuvsZcvn+sl0C5gvu2FAzQ9JLJ3ItKNoZ16Uvs5L7fM5+jhentqv7w7Ii3P2oG/p
 3NABpeyBPh8Vp+i+/fXUmzMKJZs12xbpRNSa+iTl9uAeKUg0mSs2Dpm8NIWHXhcNxg8o Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf776g9hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 22:10:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348KFEMV032711;
        Mon, 8 May 2023 22:10:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7y33djk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 22:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWjFArz844utkT/MGt8XfcILnxcPtT40g8RJn9baqMvJAf6JupS2NhS9NIrhYgeE3bPCTc1y7r+yG8cZ5mABKKDrRSba+OwE3hxaqQ2uHOcj2EigBGbDTaM4K2JdN03Myozd6jsQiE0PmLLSFw6g0RwH7ditz8ISRfpApYNs8X/bonAKfHuOhNoHfpqWzWiK3tGvHxRIXZHKLPO+rLWhCt7J/CiOCNYbDmyhyCusKqNF3Ra9bGBZq1VJT0R6KJRDTC2BICJW3r7pwyizy2qvJNCJue5IMi+CHZ6MSU+m3ui16L/22IePHIhffPY7rZCLu1icGq4mfDq50sUq0Gh4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZxuZqLtwXycLB/M1RtKBPVWf60cLeT/zgVQFmTG5X4=;
 b=g1AAzTVdTXzcaoLWsQRNLVvn+F+/f6/BxeDfX6ggeavnHhCRhr7XZzTgw3KJQF/CAVlK5uVLVew3zQ28uKD9LDD+9H6JWJoc+voVOxJgZEfU96ZSYS/7SZlKzCxYkb54krw2XIAJhu4pbte2Gu2rjoq1o/gv6i0rdpi/4H9mplxv0PruRmA3DQPIzUEkCSR0WHJ5uhtycSFkLv4dKiI/kT/omBUn4k7xFp3MkMLRhXNnIYAQcbnDDT1XgmKsbSIgrK3StAWEqSe91uX5txJyGtqEP0A6wMWqXqsGZ/O2lc42c4sPHKREVSA02/Hhec6gpCvtDD1xu7fa4TiEM98VLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZxuZqLtwXycLB/M1RtKBPVWf60cLeT/zgVQFmTG5X4=;
 b=V0BqcYUJ+PyqRO7PuIWQKCZL319DwSobeW7M6K8VT9RNiCgANV/kfqIRRbK9GtLtZdQAIAk6cTlq6ZeUnTxwX1YGeAPt0m7RgIV8/RDhjN4WLihpfLHAdD+mFby8u8UaB4/yPwxC9FY2zmmsQkZ1DRKpeXpo2U2zVR0+7Pad+dE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB7065.namprd10.prod.outlook.com (2603:10b6:8:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Mon, 8 May
 2023 22:10:34 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 22:10:34 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, jlee@suse.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 0/3] Add digitalSignature enforcement keyring restrictions
Date:   Mon,  8 May 2023 18:07:05 -0400
Message-Id: <20230508220708.2888510-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::25) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS0PR10MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: def0739b-f166-4ed9-e884-08db50110b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eoptKVhOkypKruF8X600P/6BuTdrrDSbsZVewSFDGjLc8mqhvaw9pxL4G5WtZaJF9aBix9R4uALHsUqB20WAn0po1F83YQqGKjbglLrv5vF56qnVRK8VkLcuaKlcPrTLkg2vfJuvaNURYjkXPDMB6o7oaOg6SdMZGpBdMr4xr/RIYta9i4aZfY76djcvq82cSph9yF3QXvK0/vAlqM3W3w3kYi30MS+8FHHMq+Kgqe0fDv6G9qWN7W2YJMiimXeyPSdM3U/L09sT2e15Q+O1w6rjK2FB+X1bZHbKlHOmI8xEk03mIwq+bStM5sCr7/1fXQUVmWnwhv+QW8PNNsBA5nDAth59gzUKPF5zLlKx3lEY18lAc65CUVbRHzdT2z0cf3pojZ/dglosYJjoeuJ6SEcWeR9pFafaAMN3BBVVTpjhlyo869H8SgB6QT+pcPr3dmNea6JqXTh2sXFnwrA/JPNf4nupnNqi2Xtxk9opSD56oZNUkL7h3ADm/kwAvP7IegWs2Hjil3pHApckmq44tszXZ9m6eUEcDX9f8yn7KhMzqjF7ZXB2gBFjSao1eRHSERijsN9RzcE8AyLsRANL+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(83380400001)(2616005)(186003)(2906002)(38100700002)(36756003)(86362001)(6486002)(8936002)(8676002)(966005)(316002)(41300700001)(6666004)(5660300002)(44832011)(7416002)(478600001)(66556008)(66946007)(66476007)(6506007)(1076003)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SkgkzXU7p3AsVznC+r0qr1XZq4GQVEHOgUCglZTjJNfjplpEHTrr5QMYRq/L?=
 =?us-ascii?Q?KH2TdH52TCIUTQ73kgEcQNt+kEJPEqouVvXu52yNGmdZMNszMJyr66SBo3ap?=
 =?us-ascii?Q?lJaHKaaVckwTdTKORoYSIg/vs7/m0WBSGMqpBrsn3c+wB+hloYCW19DwYOP6?=
 =?us-ascii?Q?NCvsThlky6z2eV0hJwcKnzf1DYXoYZeUP0nOR/jpyVkgrAql5J1aZIon+0zQ?=
 =?us-ascii?Q?HFBUfiFUx2nKMsNj6rRvqsZx6tBUxIgKq6XN/xCjgGp4cYsu5+hERk3AEgcu?=
 =?us-ascii?Q?w4b7yS4bLbMpugDhT4fEf97uUnMnZZZLtqvvdKUpy+2/LnaNhi4lVzxXBSyv?=
 =?us-ascii?Q?WgAt0SKj4RSB2UHxHBt1wxOEuExEIop74R04TXsZ9ZEJjSHdtvKMUzpbXv4P?=
 =?us-ascii?Q?UzAewbVmIgUWidDo9jTwu1SHRMOBC6CDi0exqKyr/MGflMUkg37EhUJ2HvcY?=
 =?us-ascii?Q?ngulaRFRsbwoA7YpvTpxfgsvHs+7w7WAiYuCAvwZNV42rMk1Cdc68gvcaMWI?=
 =?us-ascii?Q?gjnM/6suxa/rVUNMkxA/UZuhrvzODHF2sIXhdTh/1k4gDZFmCipeUvkQCIyk?=
 =?us-ascii?Q?tTqKph9hz97dV9NodiCSM8lHX4yBcTQPD/n5AITc3OGUhuAB5zUUhRDXeq40?=
 =?us-ascii?Q?ePBE7lRxipkYm89W3KbdX8TicXswNBGGxOI1UKd/dMpUw8Iri5V9OguuT/4y?=
 =?us-ascii?Q?3RnrxIPZfaifGfyvYhLGYI8+Dm2kBBiredM+wWXAYstoq+TQeVzrsF9N/NVZ?=
 =?us-ascii?Q?JfQBO/a2W+M7baFE/D9bHz2n535R4Oa7OMBdWAlaLE0/tUTyrCoqzvKQt/3x?=
 =?us-ascii?Q?Uk+KaLdH86gKmF3FTyiLitHFYkky0I61U32fPiXQlOJS2lUWzmWjHfZErB5k?=
 =?us-ascii?Q?g4UvsWnlbE3lXQYg8a1g//9LekmGDbMezZl24r+Lqpum+g4jN/tWxIcpknWs?=
 =?us-ascii?Q?fjyyi7MgK1J04nuHFmtmYrAyxgN4Khb6fBp0qACy+7AEDJxiJax5OfSH4DM1?=
 =?us-ascii?Q?4lq9xtOVjFVN54PG+a7TU0+zUm0QZDixIDgdhumrrlCP/rjDu4UzGmZh957g?=
 =?us-ascii?Q?c8IWToOAfNqqqVasipsPxwL+t5l9+9Du7Ymi3kggd7qHoAU30+JRPxIfCRfa?=
 =?us-ascii?Q?vwDZdMZpY7ulz6Vgko+qnLvbvTx3pZtMAUNK358RpVZkUCsKA6CQe4/+igqH?=
 =?us-ascii?Q?uUhfmTfUXLwpPKIYTTVvpCgKpgh+ISVZIx67xV+ykAFP9f9XENsoGpo/p/6B?=
 =?us-ascii?Q?/PYvNYbFiIcAtLP8+Au/te32FWttA+6NkygkaoNA1Pghd5kfC8Zz94bkonre?=
 =?us-ascii?Q?+QhfzBavCW44ikFgj4IBF6UDXhUoDhOG5Lf78WR13qdrM6uuEWUquO6JizEq?=
 =?us-ascii?Q?UqIVkiSHkDYVYsx32wOmYRVSk1hT4vvXIHf3KqJb2BlrULxHI/yyvhg+LizP?=
 =?us-ascii?Q?x4w6HT6eRkTfY830fqW0kAeaezMvGSKLCvc7pv/bQDhaIBrdI1rfpdxy6QBf?=
 =?us-ascii?Q?9/GOTK8dREtERQx/EHr0CyAWX9ShP4mS/BET2VgmzZRjdWUa7nEziXiupo/J?=
 =?us-ascii?Q?8FEOxpoM8qfAyaZqLzaZNlhJ8CMphvqUS03IwjeZ8IP6EnnvF92U1z6lpxfE?=
 =?us-ascii?Q?BWtdT9ILzRzjbkm4sa9W/X8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?we1bmI1i4FCf2eVJGPibHnJFrikNxbm5Plfbgn04OyBZ6QcpJRl6wx1i1lSw?=
 =?us-ascii?Q?iLK5Vt/xc74jjRZROIh3iDgnAIUMxPW86u/pneUQc6k8BnL+HK7dAMgcpxA4?=
 =?us-ascii?Q?o1RjcchMYaAQrv+CS1b5zTCLoqB1aISpnHKIFVhVW/Rj4ktRE+VP9egmqh+a?=
 =?us-ascii?Q?gh/LrcK7hNFfplNaMQzCnKRD7qVZ+wb0b1zxj7eel89TYayZFx+tCjIC5vcF?=
 =?us-ascii?Q?LSpiQuLD8Sehu3VFdw43yejpfyomwARv1MwPUCBA1wEDz/V4wV5E23zja5Xf?=
 =?us-ascii?Q?viYi7zlTM5HqjKHXl28X5y2RfE/2yLRbkOINtNaAn3A+oZNtzo8lc8N+45hy?=
 =?us-ascii?Q?FxIfxMq42mqX5piFuhWzNFFa7+eb080SaO/vctFav5zuOqF3meAXgaCTuYmY?=
 =?us-ascii?Q?ew998V8Ybao/rzV8VHoszv9CTeR+aoffZgkwoKMTWK7lSNkp03XA9YbbSy2A?=
 =?us-ascii?Q?BAaw9cWLOh/5zbrhDSOBlwfoPk4WEeRmqpjN6f+7B3o1H+Z0nxoq/hy+Hfsa?=
 =?us-ascii?Q?WoyYGFeuffuwuGEi/XOJNG8zzqwcT5H1al/SOSzqq2jnUKq1FxAylZptKSqV?=
 =?us-ascii?Q?yF4JNucuoJ9yFZMwGU3xCo1GsxwGfJ0r+ajYLH3sRIwGYfxn6Jo9JAWcApdu?=
 =?us-ascii?Q?DQorcU97dLxSQsvjHN7UWr1ObNXdMpbkJaoovPoL8hFz3ko6kRx8cvxfZIVa?=
 =?us-ascii?Q?Xwd3Hp6+sPAPHiZM/jMy0N1FRGQAGTh69L3YYOD3umPyxHyQZ+YNTRioJD4a?=
 =?us-ascii?Q?DBrp+wu0MfO7kc0NBuqYOI/XXzlFdjZnFRbtoDXpXQjSFDRFMTEOGEhs/MQO?=
 =?us-ascii?Q?VIIhEGUtNK8R2y//Om7mYbn+8IZCgxL2Ni7bfWzTv9C+EuyEHOSw+Vb4dwqV?=
 =?us-ascii?Q?Bem0xMD4BvA1EhOFqKWamvRMcj4I60rLZMHV9d8MhDHc26EGLH4CpbjfaG7b?=
 =?us-ascii?Q?ERfru8eAAKVbwNMaQcpOxWnp0gaBA6jN835CDIQnqu+8tNeHmpUmxagzOZFh?=
 =?us-ascii?Q?emze+/P6hhbHn83SoYJbZGyowRtFAmPap6f9DC0/Aul6jS2E5mAhRgl8I5Qx?=
 =?us-ascii?Q?/FtmzKQag90meExVcU0f9wm9NfzqnMRYa6+sImthxJgEnMdPAj0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def0739b-f166-4ed9-e884-08db50110b9e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 22:10:34.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPNFY22FNh9eMoXd7QM3hPtT13o1/bABfjgnk9PYJ21YrqHhWTo7fiT+fJroWaSAQ5veOjQJyhoNpYb15vBg0r+d3elmDmWvP4WVBo3+B1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=729 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305080146
X-Proofpoint-ORIG-GUID: dtFdIMDS-5q4rWrvjJ0jv3XZgwjpqJA-
X-Proofpoint-GUID: dtFdIMDS-5q4rWrvjJ0jv3XZgwjpqJA-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

X.509 certificates may contain a key usage extension [1]. The key usage
extension defines the purpose of the certificate. One area of
interest is the digitalSignature. The digitalSignature usage is
typically used for code signing (integrity). 

Within the "Add CA enforcement key restrictions" [2] series, the
digitalSignature is being saved.  This series builds upon the previous
one and adds restrictions based on the digitalSignature usage.  

A new keyring restriction called restrict_link_by_digsig is added. The new
restriction only allows keys that contain digitalSignature usage within
it.

The first two keyrings to use this restriction are the .ima and .evm
keyrings.  With this update, only keys containing a digitalSignature 
will be allowed in either keyring.

1. https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.3
2. https://lore.kernel.org/all/20230329220231.h6afgarrvdlwwdjc@kernel.org/T/

Eric Snowberg (3):
  KEYS: DigitalSignature link restriction
  integrity: Enforce digitalSignature usage in the ima and evm keyrings
  integrity: Remove EXPERIMENTAL from Kconfig

 certs/system_keyring.c            | 52 +++++++++++++++++++++++++++++++
 crypto/asymmetric_keys/restrict.c | 44 ++++++++++++++++++++++++++
 include/crypto/public_key.h       | 11 +++++++
 include/keys/system_keyring.h     | 11 +++++++
 security/integrity/digsig.c       |  4 +--
 security/integrity/evm/Kconfig    |  3 +-
 security/integrity/ima/Kconfig    |  5 +--
 7 files changed, 125 insertions(+), 5 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.27.0

