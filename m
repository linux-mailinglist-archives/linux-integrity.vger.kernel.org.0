Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A9C3F1C98
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbhHSPYq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 11:24:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13542 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238427AbhHSPYn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 11:24:43 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JFMWLO027059;
        Thu, 19 Aug 2021 15:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=azjBDlWFNd5lkuuPxOGjDPTcX7Y9r75zz5ExSdrbqok=;
 b=vyzCjO1PIO3aVtaUn0FSDRw82sMpdwnhEnA6UIEi4vVKy+u8a1h37W6gkhlswPA2IDbq
 nc0ZT3Ti7iwX7ftyFkRNfDSJ5M1cRx8gSRqkfokjzxW4TgLO8pugEm0dWKADVCPIh+Bt
 kPs6L2kfsM/yvKbiNSUmltf0tF1BfUaFmAgeV3z9l3ApbkpZw0N8n53XD3HziiRN2Wg3
 vBMCbAo1UNHKsOuZ5K2a7dz3Xk/T7c54p8XjOkzA+u6vt8YuFxdDHLeGusVu3mLMtZTU
 SsZLtI2SCzVDLKADDYGe6OKHEEE18ijyKBmbiRT7H6tNsyH6TcGXk39ptQluBjHNceil Qw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=azjBDlWFNd5lkuuPxOGjDPTcX7Y9r75zz5ExSdrbqok=;
 b=KRQhT1gwTn+36gMz9gTTP4bhGys0nGa6/wSiFqgh5KVPgGzgw+ukgeQ+PEzjE2GFAjpT
 jgZ11nwW3cFpTCrUntfvLuZvsmb6Un0h0nu+FquNVbdqYhBD3gJfRIuT1nGjdLmlNfMo
 MnD1TTfE/DK3GOeeA40FdF3qa8u8zsTwa01fX706X+UdRN3qaHjVKnZHJTvY7DqTo1ZU
 QXOCmujJgdAuYDp/PflG0iBJAugcuAvgaKP8Z3SpaxCH4kl5xaRv/x6jgraGGdP7gkd5
 ywDss+Ni+0UEkyGUdh/2w5SqKUFyo5oe75BWmhlC/z1iAy6Lh/wuQ5izsWMdrCpQ9Wkj Ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmkkx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 15:23:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JFF8LO096132;
        Thu, 19 Aug 2021 15:23:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 3aeqkyp2y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 15:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuqAcE+LaCBCeeDtPZ6ZXvGP20RpB9fBl83mYaKyolQjfm9nRfIs9zzlfuVS7f1xBUrib8ICrfTfzihf2gXvTzer7B83M14eiQoBD+2/MoIP5fwY/0H3Okd1CfhVlDCMLXsGlayPbhzA+BCkAit7Git0z7SU+K8oBvoX8WuS9uLADwHmLhYL8WYXDwbFn/qBmlwCjgDXaKHQGHCrtHOIQ0uCQXOHiFPz4vd4xN/ms1l6xDtKWDTRIgBxJXI/nnIUsB1tVDL2xbUSXnhqKc9fXaF4BRIT0fGKgdlCazxsjgC1hre+LfKLTw+1thQyuR5daWDyS0Kb9VNUOz6IDu3ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azjBDlWFNd5lkuuPxOGjDPTcX7Y9r75zz5ExSdrbqok=;
 b=MhObo5EhjKvr2ITaTHGHxsyjn5okcRlCx/Df4HeDJc5fDCwhw+2R6wCyRq7Ux4nF6/Yen7Q5A1xn2FMQgLQpPRAy+NssnxTaBD44FdKoVeruw4D0n76qxYYbvTqEKBNKJw+PARzgjHSXSSN8U8dDL1+NPDCX4caHoD7bmF8CnfX+iHqa4wgYD9tCiKUB2nJ51i+xYrziFDQREHFrcbItI4AiZHzFrF33kGErv6DUDPfZSxkisA+MA0/TuNow5mvAjZ0nfMQdG6XPQGBVXc+X2n9X0U4c+x4u+oIyVJvAeziz97p+boeStI/fq+1LjmzoY1fbTdWKhnyq+/GU2UsWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azjBDlWFNd5lkuuPxOGjDPTcX7Y9r75zz5ExSdrbqok=;
 b=ZCgEQCKyGfJbB6WZizT5RMIyaLUbPXS6+3SIJj8hGvQXYNXvZm0V0qUaBxiqfHpguvIf0Wmz3al7RcTL3aDlMsJDvfLQbQSKj0KLcODQzdxKfGOl3Tr1+EiSDTYR92rBh5wnlIv7d5K/XZDt5k4cVQ3ayxXh+v/pJUZeWV3UCxI=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4891.namprd10.prod.outlook.com (2603:10b6:610:c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 19 Aug
 2021 15:23:32 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 15:23:32 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
Date:   Thu, 19 Aug 2021 09:23:20 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <91B1FE51-C6FC-4ADF-B05A-B1E59E20132E@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
 <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
 <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: BYAPR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:74::36) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:92:8000::1af] (2606:b400:8024:1010::17c6) by BYAPR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:74::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.5 via Frontend Transport; Thu, 19 Aug 2021 15:23:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2094ca5a-53a5-4d0a-6eb1-08d963254e20
X-MS-TrafficTypeDiagnostic: CH0PR10MB4891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4891A3284E1872397F3FE3C987C09@CH0PR10MB4891.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5n0OUaBVco2cZHroxFJV9KJ4/MOlSfsFN1Gzlgp6j2xML+OoU13kxd2LLINWGobWieP8sFT1d4HITTokLNBUnIWXZHWlbjmK/IVJo0kJLSMYUtF6p3T/GiTbHGfNwRC1T077CoBkp941+DUrPPCmz69YgRpO6UUxBfxSjF5HLwxkeBQEZXtT3fe+BGT4/qO3NEKU0a7bQ1FRhvRHlE52SSJ5bq/1O9+oiNLszTO+WyJVqu3P8/H82UIuQ4UQI5dxDK5fJVNdIlCctdmc1o9AC7uZlIcVsgQP4w3VNh92Aqtu+cROnZxbrEHPvKM8nDForbbSnJ9ISgI29iNRm4+RB7YoqcLXn/9W74nd7HbIs8STRNAuKnaA9omh85Lv7fhzsHSPsQM3HC/kiI3WrkQmP9ZgvwMwUlhrqQ+RdaDDpRieG2UkgGdaLr3+9ZaoWKaJDY8XVkUn79DLiKg3DsnoNMogASg0DN1OiKQONWaOifH3hlSBTv8ThwQbpCv7bgL2gqidUr8GMNNSMYiQHiZ/+LZzA0NdB2OLq+C+pIytqrZoAuAR0nzhcMDFkRjl8AIS1HEOXvs2QaTqP9HPqaA/stl2sWSfjNq5+/4i8OmJt/9uwZCtjQkGV360AP+EQhrZb923rPY4MjHbX7ryZuaYdRsgU2PAx9P6dEI4n5LmKZCTcxWjLfd7nO/AXTc6LhIaony3zJL6/y1cx8DSduJ/1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(86362001)(6486002)(38100700002)(44832011)(66946007)(54906003)(2906002)(2616005)(66476007)(8936002)(66556008)(52116002)(5660300002)(110136005)(316002)(508600001)(8676002)(83380400001)(53546011)(186003)(6666004)(4326008)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnljMktvZXY2SWhPbFZmOVZWQktLZEtTYVZLdFdvWmRTdWtsU0JVOHA5TWRn?=
 =?utf-8?B?aGdDcmZmWVZPRER3WHpjRW5TR2UrbkR6VkpDRGswU1ZLU2xEL1lOVDhVYkRj?=
 =?utf-8?B?aFpaTkhFc1JSUXkyQlQxR0dPVjNlQVJyUmdCMWtsK1lzdDV4ZGFOQ1VlSkt6?=
 =?utf-8?B?YnkxaUJaRHBtcnBxQ3o1SjRrM3JMSUp4T3A0dkxtL2I5ck5SV1luaVI2ZE9v?=
 =?utf-8?B?ZHBETlExRC8xQ21qTVQvT1Bneld2VThtaTdiSllTMmY4QlhyMzlQNkdvWWtZ?=
 =?utf-8?B?Zms1eS9NWkFyTmptVE9BT2c4ZlVQeUY4VXFWV28wZnpRV3JscTFaL2wwVDkr?=
 =?utf-8?B?QUpjZFoweU5nSDkvMmhCL2VTS2FqenRWdDJzMnZCTXlURzE4VGNHdU5mcDhM?=
 =?utf-8?B?T1VFSEhEZ2tNcG1ISHNJMzZxbjdJZnNtTFdKVjhVZUlVU0pVdmdYaHVIRWxn?=
 =?utf-8?B?djdxbW5iMGwxbGw1d2NodjBZcGhnK3BvNmtDd0l3dCt3UGl4SU44b2hwWlNU?=
 =?utf-8?B?V0h2eUJTb29KZHlYeStiNi9MeWx5RzByelpURTJBbTBZM1NYaUJZVHlBK0RG?=
 =?utf-8?B?a3ZkZzNWenJucVFPOGZGVTV5S0xQZTVXTkprNk9VVnpxS0h4TC9DUFNVNHFp?=
 =?utf-8?B?MWlZaDRVVGRScEJWUzZORUtWRFg1OTZhWEVIY3gzWHZkQk5ZbG5odTVHQURj?=
 =?utf-8?B?dkpVdFdzWHEwVEYzdmQ0ZHVlMEg4L0RvN0pOZEU2ZGlpYUZudGdWWFg1cm50?=
 =?utf-8?B?M010eDFtREFpVTY0SHpVZmVBNXVsa1NNR1AzL1czSlBLZWgvREU0SXRzbmpW?=
 =?utf-8?B?L2IxRXdZajdDaEQzRkMxU2UvVUYwTFlQN2hJdkdxMkRPMlhPL01GaG5mZkFy?=
 =?utf-8?B?aWlJTXNFeG5tMktYQ0g2czViTzFxWWloeWNnWitxaWtSbVJpVFl2VEwybkVH?=
 =?utf-8?B?Q1JtVFBSODJGSkVtSlFhZVVDQkk2QkpYdUI4MWdZWE9DbFA3UXNUU2ZzZmZE?=
 =?utf-8?B?dEIweWRFQ1JqUlJBWnR1SWZaWERxVm9wMUJ5aEM3SXZEd0xteS8xMk5OZUMv?=
 =?utf-8?B?bElJWTVDQTNuYitlNk9IWEVFcTY2bTNPSllhZHlRbVlMU3NENStQQzFVcW5s?=
 =?utf-8?B?NDg5UFJiaThjM0dRaDlxakdmU293dTB3ZExiOUdndDlDRGJ1QmUrL0M5RkN4?=
 =?utf-8?B?QjZuMXU5WkRyY0NZVTllRjhxL0tXNitNM0dWSmQ5SitiNkpWUnJicENVM0M2?=
 =?utf-8?B?QmU0U1hlUmFId2RsaW1kMmlUTkg1ZkZTZnVjaXE0Y3lpLytKdDFOMXlLZFAy?=
 =?utf-8?B?NXZnTWhibE5wMWpoOTdWZ09KTTZnemVKYVpldUFoZDdrQ3pBaFh3WlZ2Vkoy?=
 =?utf-8?B?QkVoYVdVcEtLclQ5enlrTFdzQ3M2TURtZERSZTdGZWhraEp1Y28xY0dxNjlW?=
 =?utf-8?B?b1JmQTlueGMyemZGMnBjczJQamJwdGN2WGQrVk1IV2l4UWx0MjZyL2kwN040?=
 =?utf-8?B?SGVHTUVPNFp5eWp2TXZvS3hhVEx0RUdxQVc0WnppZDc0ekNTS0NjTm5YVDkx?=
 =?utf-8?B?dmJzNU9pR1FuWFhQL1FmVmZtYnd3eUYvZTFkYlM0NmdiTGNqNnNBS05lRmdK?=
 =?utf-8?B?VmgwUkp4c25aSndwSFdFaERiUFY2U0RvNDJLdCtQc0VIVUhCNFNaMHJBVDlB?=
 =?utf-8?B?WFBCVDNUc2tRcWFMSkZnODViL1QwNVo2bjV5Nml1d0ZrUkdkamEwSDdyYUNW?=
 =?utf-8?B?WHo1REJieGtHK2h1SXRIWDBCbHBGUEVweWVKN0w3SW9CK0UwY0JzUm1uZTR2?=
 =?utf-8?Q?4dW6POROQAf7D8kE5Zg/P3DY8FVXl9FOPT7VY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2094ca5a-53a5-4d0a-6eb1-08d963254e20
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 15:23:32.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFOoicmdD0bpgNUJDA57uSTiZ0yse5KwNM7IFOLM/jZIQVflw3ntQZ0sBiRGRh3G/NKIJ9cz4jJG46lRpKPdDKTmVi+WJZRpz43hbbyD5/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4891
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190090
X-Proofpoint-ORIG-GUID: HyyEVGQl8qlzKpFMWjeQE877S-PFPA3c
X-Proofpoint-GUID: HyyEVGQl8qlzKpFMWjeQE877S-PFPA3c
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 19, 2021, at 7:10 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Thu, 2021-08-19 at 14:38 +0300, Jarkko Sakkinen wrote:
>> On Wed, 2021-08-18 at 20:20 -0400, Eric Snowberg wrote:
>>> Downstream Linux distros try to have a single signed kernel for each
>>> architecture.  Each end-user may use this kernel in entirely different
>>> ways.  Some downstream kernels have chosen to always trust platform key=
s
>>> within the Linux trust boundary for kernel module signing.  These
>>> kernels have no way of using digital signature base IMA appraisal.
>>>=20
>>> This series introduces a new Linux kernel keyring containing the Machin=
e
>>> Owner Keys (MOK) called .mok. It also adds a new MOK variable to shim.
>>=20
>> I would name it as ".machine" because it is more "re-usable" name, e.g.
>> could be used for similar things as MOK. ".mok" is a bad name because
>> it binds directly to a single piece of user space software.
>=20
> Nayna previously said,
>   "I believe the underlying source from where CA keys are loaded might va=
ry=20
>   based on the architecture (".mok" is UEFI specific.). The key part is=20
>   that this new keyring should contain only CA keys which can be later=20
>   used to vouch for user keys loaded onto IMA or secondary keyring at=20
>   runtime. It would be good to have a "ca" in the name, like .xxxx-ca,=20
>   where xxxx can be machine, owner, or system. I prefer .system-ca."
>=20
> The CA keys on the MOK db is simply the first root of trust being
> defined, but other roots of trust are sure to follow.  For this reason,
> I agree naming the new keyring "mok" should be avoided.

As I said previously, I=E2=80=99m open to renaming, I just would like to ha=
ve an=20
agreement on the new name before changing everything.  The current proposed=
=20
names I have heard are =E2=80=9C.machine" and ".system-ca".  Is there a pre=
ference=20
the maintainers feel is appropriate?  If so, please let me know and I=E2=80=
=99ll=20
rename it. Thanks.

