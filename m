Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DAB6C50A7
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Mar 2023 17:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCVQ14 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Mar 2023 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCVQ1s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Mar 2023 12:27:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90415C9E3;
        Wed, 22 Mar 2023 09:27:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCYGmf029339;
        Wed, 22 Mar 2023 16:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=cAQFlTExmc++UK7mNtjwpUj5omxprR8upvNl8wEq/GU=;
 b=E13giFrlWoxAiXT0Jx2tOfdGrrV5Vh7lhqvFi6thqMNUIH9lvMslOLVv+YmtE11Lbgnt
 TPVNZEmehuJmn3hk/q0JOa9jVbZ94DG4V4YwqHDqeCLwlxG2XkNj/BC3p7tMcbmA5Ti/
 P1SLZUQzSOfT7BoU8SrjpJ9EXr+hLuCHpvi/SA4QwRTLaaGIcSdkuWS/43F1zscA2TwN
 3Vn0N1bKBbgU+H0Nz7zFP13Z7EFpsXSJuFRzV3yqaCdYYCj+cgziGJvJpLDZvnnKEzKC
 hRLUSjApgHA6biPLfNlOYOGLFOZBrBDnoP5hZI6jJhRDbhVOA9j9OYI2YlUNcYp9LTet +A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56b1b86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MGJXLG008357;
        Wed, 22 Mar 2023 16:20:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pg53jg0j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lihT1E0Iw/agmCn/+K3X/SCAR6kpMRb9fIr3xFXHUehUGhG18SzMxwp9Q5G42sfeHKyXlU+uOZDmQv0/BmWVkN8TmeLBR2tB/eFUd+uKkmLtbDp6otOKfpGClzRfyjA5niW4Xef/mvDXPan2H2EqWmmWp5DvsIWlc7ugeiY4p9UoFYWv6bhbyAxoLDyP+xWYNU/mDmZJtTFdhuM04zwtSaR8yT2JX8LqvWgbHVztcT7u1Pm/5BCoZ/m//zZasAOPmHARXIgREcLroWfDfEhtCLDo5xRwnsoSX9uujdjpnEoEEje65YbdImnD0v8gRR6Df3zTT047hBNBMlZ7FOgnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAQFlTExmc++UK7mNtjwpUj5omxprR8upvNl8wEq/GU=;
 b=GFYYiYpjrihKaog4L+zGcuH3xyrMGhT1L3UUua7XvHaATOhlmgEfgD0oEkCJ61u0mjpgz3b+6b0CpLqE1J9nwP6T8jWkheBHzc48xyTfM54RvpjWXhZNm28wCICddM68JTFogkiFx6k0R/L1up5aLn8quei37z7VEe7YS/8FP20wfk/ML7MKxulj4D9I399C27R5kMNTQlpMiqWIO2SurSWxL/V7LTz/SX0vCnNppK2BQ/caHP5b8UkOPpfAm7y9AUgYfnyha7AdLflL5oIBq/KNVJtVwgn0t9XEj0ZcgxRSIUSpPoidSTv9UnF8OQq/78XL17r+1UO8xG94262pUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAQFlTExmc++UK7mNtjwpUj5omxprR8upvNl8wEq/GU=;
 b=fdvoE4jrVr6LO1ujP2L3kkHmllPtHthtkZ6nosrIjOOuO0NpSWMQHiPiFS42BcQTxe311L3/VoBUrVy9OS+K5n8UAmieiXNH+pkFeN1qqUPe6BiwLAae3KwZQo6FL5XrTEBbnJh3GqGGljCfV7mIIRUltW8uvHzXXUz7ABAyrN8=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW6PR10MB7688.namprd10.prod.outlook.com (2603:10b6:303:246::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:20:08 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:20:08 +0000
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
Subject: [PATCH v6 2/6] KEYS: Add missing function documentation
Date:   Wed, 22 Mar 2023 12:16:30 -0400
Message-Id: <20230322161634.2233838-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230322161634.2233838-1-eric.snowberg@oracle.com>
References: <20230322161634.2233838-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:a03:333::6) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|MW6PR10MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cf6f47-6a0e-4462-3037-08db2af14da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfbfqdrjl/JSE4FkzANFcuVg+Cexs/Cxe9k7UydwQdozlVkXtFowG8GQ1sz9J42SdIPX5Q3zza8cwnOV7q53//9pd+I7bsKVCqnGPostwf/iGHqLzvdZV7lT7NGQ97SVOmu+Nij7KeMNyENdDcN00dy07voVD/LsHWpRAky/JcY7dqIXV02kDjK3FDk1X686oTBRJpkNFvGpitWgEAmX7YLHydiDvs+Sn0zPexkf+G7S7YqJ6A9lNg+W8qNYVdDLIZNF/2BgywIJfTIXw9mO85WzuysWlOFt9mJIkl30+XIcwpnjP9V9unyyPa2HgOJIsaLGx1nuTNsPj219MRQWPpTWqQJjXPNkst6p6gQTFbFv/h8TYUZA1jj9Nv6HqP0nzWVxfBqXtW1KohTIIYJd9FCjVs8Xkwnc5uJ6XI/H/1PaMWgt1xksqzVDjHIiitqPQpX82N7iEhBl9nlZX40WXSzupSHxgPoYORbtQAM0Gt7orodC1aBt/rIH8/RTpn2e8rSMSZrDv4POLTp9zfJgQBQoPW2dwiwO/MtBfnd3JBZVqhOQeoYB3/xu+fAa9H+kOXrdhysU6zt8y5kiMVZRF/taJyaaczHFY1is4blzDPvpJ9ZTO1PS2gewYRv/EQVamrZ9oLR130iwQI4L4rBf8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(38100700002)(83380400001)(186003)(41300700001)(316002)(66476007)(44832011)(8676002)(5660300002)(36756003)(66556008)(4326008)(8936002)(66946007)(2906002)(7416002)(478600001)(6666004)(86362001)(2616005)(6512007)(1076003)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ekvtsAV4rmfADj5qci2iKuzDfT1COYqZobEVhN2FYPLdzyLTWy8spGkRsp4k?=
 =?us-ascii?Q?m9bdmN5lIf2inSJnM7nZ0wVDoqCYERFY8480lQKOANdQXhCN6cbZLzkg52Am?=
 =?us-ascii?Q?u1Ek8SggtBgjWsfPs7poDYI+5xCAbokaAuz4PiI8cmBwtpCd70dTg/D8FP9S?=
 =?us-ascii?Q?83ShQZDNDLDkjdouWgqgb6gDmf/rF9i4Ina0dczdlcS/Fs3hitumOJHuBuFp?=
 =?us-ascii?Q?O7OheKLDNW9vhfwFOPaVzyRnJMwA/hnp19xgwG+RHt23PNho1SuJKBWw6mZN?=
 =?us-ascii?Q?SndH1lEGQb/vTImGMKLZtFF+KW9+ELgb40pejJuxCeU8dhXOkK/YpzqQie1k?=
 =?us-ascii?Q?+eqt+o7Cu7t5Dba8hJXSQrA8QwbLEsYU2L/wDI6FLasUUiOMrjtUqAtp/Jh8?=
 =?us-ascii?Q?Ibtp4FW/+P/pAUqnUA3b/4FI/+MtXzhgE138JMYhdUem7sikEscMPBLpQZtD?=
 =?us-ascii?Q?xSBzODTha7CsP+edj5fZXj7OwV/3qmWLJ5hPb8OZP/dZ9QS4C80JI8AVxFX4?=
 =?us-ascii?Q?xpDs7P3ssrAJuge1s3UidYAvH8jk0rTILf0XHUio8nY0shDB4Dr4DlPMEIAu?=
 =?us-ascii?Q?l4r0RPS0426Mp/Mjdu6rKpHzLVRfFg5OPTCRb/5fyeBijJO4on61WQwo9Ipq?=
 =?us-ascii?Q?gALIuRHbmZrGQT2YF7oIqivu9wblc2UTnwlJhTmhhBZsjgWe73ipqfDNtH3O?=
 =?us-ascii?Q?Y/Bu8bdKDFjjW8pvRAtbGYzbV3dtbF4cQ0+yi3cM69GU814UZfo5ynfUxY9m?=
 =?us-ascii?Q?L/usHMBUK67F2YqDmR/QmhgwcDeY2zLoR9MVltSS9A+tK9TvqS6Z/P7WKTX6?=
 =?us-ascii?Q?NvHqMR4rOFB1RphoV0w9v8XwDQbAixauQE7p8sCLlvYLiDFABOawFMNyudSe?=
 =?us-ascii?Q?ZL2tGG2Y/woUIv/HKdGyvplL43Qu7TNy7rbm0CD2WarGcwcvsqX9wt6HWlm4?=
 =?us-ascii?Q?c19hJz5p8VoiNUqogeIFHuMgwFlst4NMgJEY2BCyio+hfi1Psrs4f3e61glV?=
 =?us-ascii?Q?0GsPrMzLtEaD7fTFzpJ/0DAUvBKyo93Ggxsabm6P1MNSLh5qy+cVkMdjGcHK?=
 =?us-ascii?Q?MNMUKnmMxEDD6hXjX4Yhf1I17y3V4zb1sIHotaD+TWcmp261NGK3h0UIndks?=
 =?us-ascii?Q?LLi6FNJEYVSZ3d2/m+6capx2qNTp/nnIKrAOxV7Ccs7MmsGk+dxxqFMF9D4R?=
 =?us-ascii?Q?uyDD0lhjGPY/b+DAMvepzUKT8LNoZfbEmz1xkMOlda51bKD1BJgNAhyGuMW9?=
 =?us-ascii?Q?gOQmERtahXoAFl40HSN8+jZglc6ObiqYskPM4Xw5DfWBk8LYYSAgpuw2dqPM?=
 =?us-ascii?Q?7TMBAaFGaf+AvgmPLqpkvUdBHGOQVcoTElsC6uC4jaBQZpus6q79NYzmjy4i?=
 =?us-ascii?Q?VNyLzVrEdtPVXEwqBjDxWKMTuJaDi2xs1cyeOiUeaHRIyj3epSk3Q+7afRkT?=
 =?us-ascii?Q?NCnwSrhNoXIFdD+jU5qbmz05NLu4m0+Cl5m27a5x28alhJOm3pJJ5SWpt8oz?=
 =?us-ascii?Q?g6xk6hINXbQGo7fxA4uuZu8lxZgDVllNyCq/3YNOHCMy394PeQn+A///13/P?=
 =?us-ascii?Q?EC1nitusd05VR+kZclQw35+NIJcUjPmkGB/zkF2IjfGmNfMiwixk6Etqtl+h?=
 =?us-ascii?Q?Yfg1EPOXeTqPtIZWDl51L18=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nr2ERYBTxTEYyoumlSheoAeI/wwO2EEqgdTYiJOnR5wD/FldbZ3FOwhzvSqB?=
 =?us-ascii?Q?HQDCZRnisfZf23jqrIChekGDSADoXE0nyvUPGpskH0Wt/xkZnR9/sHvPjkto?=
 =?us-ascii?Q?3lpCAG9afJOAGkygzvHT8hvLmfNbufkh+jFjGXLpt1ZuYeAMw4c0V2h3ULQT?=
 =?us-ascii?Q?PyxKcb7RuSz0Fc9p/Z3DbKjFI4wRyucSo2kxDxZMS5WWoF3/qIOwmFMU66Kg?=
 =?us-ascii?Q?BPcHmD+zOjnDItYkSSvO19w3G0N9KbdlSBo7bwlDFRToXKYG+cOmeGX2UxDU?=
 =?us-ascii?Q?c6NN/RQ/N5RhITCLo1Qw0+tQjMFYJ9hEIR1cK+GGCKLq+6hLRI6/5e3sX+h8?=
 =?us-ascii?Q?qg1M7UkRlDD2PxwBN8/5e3RTbJXoRauVWsKqRkWpXYJRXcqcXOtbLaLF8En1?=
 =?us-ascii?Q?qtRTfgUq/wXlvrQFgInajN2d9UKYEtZhTRMg9eS2j9xeV7/yedgn1wAyuM5M?=
 =?us-ascii?Q?Zvy8dwgdiBrQamCXLBd56NJ8WhQmK1vUrz90PZasheQl7o+5QNxhfWrqMn7U?=
 =?us-ascii?Q?jlFbwHysCF23k5J6lh8jqlcGXphXemd4r6x6cmFj933RzfGcr3c1u99/hHi+?=
 =?us-ascii?Q?XXHqV17R6YeV09W51TjWqzzptNL1UgzQpkYwnAoHw8WF+j6Rp+ouFrAcSxVe?=
 =?us-ascii?Q?0stx6w355/Re3RRrDgtVMnDb4SxnAoH3SE/SD/lNBQ5aMXjCs9lFsUMs30lK?=
 =?us-ascii?Q?8p15RTIsSZlR39Md5Ets/zBWYjcELCilw0OH/M3YzhIAIhRb1JRjJMVNUtns?=
 =?us-ascii?Q?oPuulz+t1lDcSeDRlf0UrrXMpNjBy07tplLWdmDCI+S067FR12ralxttsSi2?=
 =?us-ascii?Q?8D17Z8m8nx7xRvfHSdrHhJSoji5zTJ+lilqTx3m+GEnhuwztWMp6E00HhBD1?=
 =?us-ascii?Q?7F8DVCu58luatmsji08od5q8oJqtptgxJGdK5+p8opeR1bxgL90Q4iAmV6Iy?=
 =?us-ascii?Q?bJHmBjcX0McCDv9l4z18CZWB1QSyfppgvv2PIHpMYJCKAHGGNrJGS/3Di7IV?=
 =?us-ascii?Q?Wmglx/8BZ3n+JPE4y5JWun7wNpfNVSI8r/D++HhjdJ5xCpmqJE2VLYXM9VjI?=
 =?us-ascii?Q?3kO1lfC6IPOdbf2LS/cJWqXQBWjHukk1+lxBYyGQLTfNSmVFe80AyPpovKKL?=
 =?us-ascii?Q?+zsPKwlhLDjMs1MVzHasv7Mmzl8oUykuGtEuGOK21B/lrUoNbP2300c54Cjw?=
 =?us-ascii?Q?+eGah5E3FK+0nouG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cf6f47-6a0e-4462-3037-08db2af14da2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:20:08.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmweB6kWEYdw4yLpzXGzzIz7qJr2lVegl9kDJqRTSLjnzm3YieG4B1derESA6spvZkvwMlBj9l/5OcyvzIvAIMtNwGbzZCsjHFWlqq4guFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220115
X-Proofpoint-ORIG-GUID: TVA6eqlsBmYgghjX0MJkysu8k3BPhvDh
X-Proofpoint-GUID: TVA6eqlsBmYgghjX0MJkysu8k3BPhvDh
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 certs/system_keyring.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 5042cc54fa5e..a7a49b17ceb1 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -33,7 +33,11 @@ extern __initconst const unsigned long system_certificate_list_size;
 extern __initconst const unsigned long module_cert_size;
 
 /**
- * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
+ * restrict_link_by_builtin_trusted - Restrict keyring addition by built-in CA
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
+ *   addition by both built-in and secondary keyrings.
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

