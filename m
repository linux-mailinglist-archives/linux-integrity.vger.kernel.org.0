Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EBC3F4FCF
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhHWRtz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 13:49:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36014 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229746AbhHWRty (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 13:49:54 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NHIUC0008493;
        Mon, 23 Aug 2021 17:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=zPcWThsMjDv5A0X3vQiEIEfYlh473WN/ukHNEA8RKzc=;
 b=ObchtfO7zypcuVSc6HZ8muYgRQD6bHQn85aLvn5g7oUHjdQJwSWwUDAc8ko1zFYbRZqj
 xcliKDgPn1OMmo4mGvXYgiQ/23Sh8DzStBk4izqK+wvSZqVWjMHVZRM3OuicF8ZPdYK2
 nGSlSCo3v8xDet1aNUrmagHspujOIQ3o6albOwd1lSGJlf/zR7grgRosk/dtx/pN+cJ6
 1cNsxbxoiILV21cR1LF9S2F39S7WuBznCDvAHSieGZzvflqkAIIw+vQoQj7Ctv3AVyJq
 OzDoPZ/OO7IgMGeYqBK8z2WwkprNfJZZFAB+JGUoBEaHROEgQuHSEoNffsPqmhRoWw95 mw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=zPcWThsMjDv5A0X3vQiEIEfYlh473WN/ukHNEA8RKzc=;
 b=neAgPxFMJg6TwIsRmhQBEYe4yQ7DYbjvHBpp8pxTu9dAZMpFAMe1UkjMAqXf0disNSeT
 lGzWuJy7/JVQRugbTEpvH5Ig5FDFDva6khReT+ElaTagdi/5JFczwjXkQ2jOFPhS/s7S
 W6sCQ+u2YQWbNpedcYuv7fikbXuIUBqRCOrKCR5Hi90xgNnq6QJp2ux+CG3IL5V3/iVI
 Kn44OCadWO1NVHvgc+pSHeb/aeIrXJqdXn70OjvibQ/QDvn3QRDoQ/Qh81IoakrQ3Zg/
 wvyNTtjH/3xXi+nFczb7iOaJ2OKlvN0uGYhPY+/07S2ncIWWlHE5GisoCRQppFRM3lPv WA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwcfa6ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 17:48:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NHjVPi167703;
        Mon, 23 Aug 2021 17:48:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3030.oracle.com with ESMTP id 3ajpkvnfs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 17:48:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hskH02mruOmKotMlJmn1Uy9q614i6kiSb+5NJN1KNCydtV4YZyZWVASCji42V5phXo/p8q8xYhPIhMceCmFhngTDU2UQ5HSqUhw5o0uO7vmzIDV9t2vnxIqdCgKncSCaHPw/14g1pq47MYmayygdcmoZ9rQ7Eng8/tnQDipPDotC7ghqv/TKmLt12VvVGzeR6k4o0WsCtuCTS6+k4oelPnuMJfgZ0P538MUjMXOZc2HDV46xiti23tje4S+Cdq7yWDw4JJBU5Id6QgbxoU2bqrrziWdFEljyGa1FgaFDk9Ui/8MQVpZC9GJnFi91vmK1w9iAS87XpGiNUSe9qaG0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPcWThsMjDv5A0X3vQiEIEfYlh473WN/ukHNEA8RKzc=;
 b=kqA7QhVj6xt7LBwf7SItOcG1RwQyL3LphjnFbYidEPwJd6RwZ9PMfdXbjhPqpeyz+GVkxiILMX/sKNoFZ9nI/HtTsOtqZddoDT18HF9S7HKaov0z3A1Jh6GVEkEo+Js6PEhH0QeJsTDeZnlFyGiTTkbb1nRcbD9s1N7zgY++t/iSpcjIgLCCIboY3wyDiIhxiOoDo1st2pwGVDl8F20IO9/w3nJMskmnJPqQnnOwrWEVjqbludR/JKMLNM2Fr8qxDVgbR3tmga8gKIlB88J+d4JsX0OpZRQQ/IWeqrXpQhd4bNCt3fe3SDMpOu1XcyRp3FXr+hbOmpOme5k6IA4oLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPcWThsMjDv5A0X3vQiEIEfYlh473WN/ukHNEA8RKzc=;
 b=os4FVO3hrzgLTg3nX1FugVvrOmlW/TD/1bPM5lRAqYUX7Mo2uLBx/InhdKXO+uUV8KuPcCLbRlrM189eCd4xuiRJ+ljPxX9Ft5ysPjS95orbEFKjKb+SjkwouYj+vanse7vpHo98eqzVJ5soB1zFMEWweJSXhTBV/UWF/bC0ZFU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5500.namprd10.prod.outlook.com (2603:10b6:610:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 17:48:24 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 17:48:24 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <335ba50bcb9069faac135bce77c6f7ba19bd90ca.camel@kernel.org>
Date:   Mon, 23 Aug 2021 11:48:11 -0600
Cc:     Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
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
Message-Id: <D6D0C236-38C9-40EF-AABE-41F90CA796C8@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
 <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
 <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
 <335ba50bcb9069faac135bce77c6f7ba19bd90ca.camel@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: BY5PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:180::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:92:8000::da3] (2606:b400:8024:1010::17c6) by BY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:180::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.14 via Frontend Transport; Mon, 23 Aug 2021 17:48:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4af4c877-0658-4ee4-bfa7-08d9665e3462
X-MS-TrafficTypeDiagnostic: CH0PR10MB5500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5500ADD6D404650258F168F887C49@CH0PR10MB5500.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKAF8tJnOIwBnDe08GcgvcjVYXbOVz1BV6NKqLueJfyc96LntmK1Js0OHcr8BKV0iwqmSkd2hDZICVx2Ix6aB0/sb8kfa1OyZnv4ALGS2e7Xz7me5LUiqaUuVvz4gKy16JhwrzdjU0LS7tYezk+MZtaQ/QSDdE/yuN+OHxOfLURCjGMRs13pKCZXwm5F3zHuYomMm9+SJPBDp7mBDdPFLdmaV+dVYLKEWMinALM8c34wYSII+FJNp5iHIGix8yN3n58Q+J1EGYDpj54UszAGzlJ96QW0zDRUJAlitcZ5buZGDDOdcXK4yYd8Yx5/xwFypIURfBg3z3yyA0D4UKQzVL/biGKdrmpYikdPUz6I9Vq6/dEJgUa+NQwPi/cEYRKzLaVpFEfSEOVUiTJtksi0krPDqvf4n13XvFFsmALF4y5szfEqfZUrcGAoaGVUoW+Vq0mx7n3zxHRT/06gYT2T2y87WMRY/ndnMyxCbesb54f8O0VadAqhoKckMUcEuoLTHaIXyWz2AyjkzNsX9vzMjCXaP/IDPF5aXZt2YEx5ITD9QzQCCst5yBUIe+swIpZPj/NK6+l9EP4ccggSHkZSCaACrwOtP29uvZ/m4mJ0yTndv3lBX9W+F6PC2VNHJrK8w7C9xeHFKrcvuOJTZK5WqJe1nkzHKlf0M7dqMGcAcRqIXZJIzKkF4yOr58Ox4C2z3+4QbDKKBAZOCnPJuWWkCxwPveL4W7ZjZZfB4fNLUtD1Z+e0+IO5R5M1Y5S4OCXUH3lP1R9MdeM2GBJDmCJ01A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(396003)(366004)(6666004)(966005)(6486002)(2616005)(53546011)(66946007)(478600001)(83380400001)(36756003)(186003)(66556008)(8676002)(33656002)(316002)(6916009)(86362001)(4326008)(5660300002)(66476007)(8936002)(2906002)(52116002)(38100700002)(54906003)(44832011)(7416002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTJqZURHLytCbFB1ZGJzWVpmZWwwQy8yejJpTG5pK2VmQU1zQW4xV0NtdVN5?=
 =?utf-8?B?NTIrQ1V0NU8yeCt3QmdHOHAvajdTbXJrYzNqa3JveWFNS1NUek1GcWNzSmpt?=
 =?utf-8?B?ZzNHLzRJT2ZSK0I1MFhxeklpRllIMC9Kb2FjUFpVOEZzc3RoYTdrUitocTVJ?=
 =?utf-8?B?QjNWQzhiVzVIaUoyS3FCdkF0RHpVRVZHUmdTUDZybWFadE92TVUyOWs0V2lU?=
 =?utf-8?B?SU45UXFpYmhGUEdhU1R2d1k1MVhPL3VDOTNETm9SNnRzbGxMZWRJbzlxeUtS?=
 =?utf-8?B?RW9qNU0xdlBIaXBwTVN6Zk5NeW9rcUhHT0ZnUTlnbnIySW5JS2x5SlBUSEhT?=
 =?utf-8?B?VWRzRVZJL29KUFV0U3FCL0lKSkFTWmpja2dUL0tXNmZiOUs4aGIwbEFVVnFl?=
 =?utf-8?B?WllKK0hnbmJlV0dRb0xTQlVMejFOYlR6VUxFMWFmUkxuTXQ2bkdsUnpqSlc2?=
 =?utf-8?B?d1BpS2RKNHRicSsyWXpiOSsrYXFEVW9hRERwNlc0LzZNTmVnODRvTjNVcWhP?=
 =?utf-8?B?TDlSNFVueVo0R3pLc1BoRFZRdGk5eXpHY0RBVG8xSkloclJmQ3BtcG5wTS92?=
 =?utf-8?B?TWRwaUdrWE1OWDhwamZEaW1sM3h3eXdpeHI2bUZrOFhyVFczYkZhemdRRjR3?=
 =?utf-8?B?NDk2VTNwN3BIS3RIV3VmSVNFMHQweUVJeW5TL29jYUZyUm9BMUR4T1QzdzR2?=
 =?utf-8?B?MHF2UkJzTWlHSUZBOXQySTNXR3poVU1xNW5uN2MvcDcySTdHaUgvTFZLSGx4?=
 =?utf-8?B?K1AvSlRsbFFiV2FlKzF6QXU2N29aNkluNlBOTGM2VXR3M2U4U0JDZzhtdDl0?=
 =?utf-8?B?dmsxKzg1UHk4cks0V3h3VWYvNUFTeVJsTE8wRzBSVnc4aE1yNDVVaVVQOWR0?=
 =?utf-8?B?KytlMUkwQ0lYaHFsYWx6ZThtLzYzc21say9rR0pFNU85Q3BlWXlQaUNBK3Ba?=
 =?utf-8?B?RjNxeGkwUDlpMEg5azU0OGNJVko4eXhJL25CSVhvUHFnMWI2Nm9oMlZ0T2NB?=
 =?utf-8?B?NEdJYjJHOXdGQnRmeUJ1WEhHY2pDczV5SWxRL29Pc0F4ZWlDLzRIY2NVVVhK?=
 =?utf-8?B?TjdBbWVUNG53TFlnaHNiZFIrUWFVaHpzWUV1TnJaa0xDQ2pYcFhiRGZOWm0x?=
 =?utf-8?B?NDdrY1hTQm41ZUpiUktoNjd0MTBsbFdXS1ZsQ2o0Q3Rob0I1Mm9pclI0NUV0?=
 =?utf-8?B?Y1g5QjQvcU1hNlNZQWFuUFNiY2hQbVF5aDhnTUthZUVCako3VG5rZVJGTldv?=
 =?utf-8?B?Znh6MUo3RTMwbXZDRnVLNGFQNHJ2WXlmQ2xnMHdoaGpKbkMvSW5CZTVOUnY0?=
 =?utf-8?B?akZNNmttc1Qwcm5TTktuSkpDcEgvOTMzNzBPZGFKNlFnWkpjOWxOWllrM1FB?=
 =?utf-8?B?Wit1RkRFdUkxeFZQOTBUMTBYNHlpZGxUcCtKWWFndVhVMEJZc0VaeGlUSW9Y?=
 =?utf-8?B?NG1OTkRaanpIU2xON3ZSRlJhZ2JONUJpdVl3UzhJMHEvdU11ZXU4dU52Nlhz?=
 =?utf-8?B?UG9OaWE3KzVZVVNBM0JhTVhraHF0dEFidmFhNlZIczl6UzRyWWJTOHMxNmUw?=
 =?utf-8?B?Tk8yK2RBVHpLZGhEQ2NJOStKZ0dMRFg5VmhyOUdDOEp6eU5WcWlEVzFGN2x5?=
 =?utf-8?B?K0dYbmVpTk1sZUVNeXV4NEpqSG5POEE5UlRCVWNjMEJEV0FzNG9HanhVaEZQ?=
 =?utf-8?B?TGRSenQwTEZwSGltaEZrQmZCN1JudE1QRmlmaUQ1cU96RGpoWTVQaDlNYk00?=
 =?utf-8?B?WDBOSXgyakNPOTN4Q2tRRXVuNWJGNWQrRWNZSDU1bERvYURTRkRQK1N1Z2lL?=
 =?utf-8?B?Y2tYOEZyY2pVM1lRdVFEUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af4c877-0658-4ee4-bfa7-08d9665e3462
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 17:48:24.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdctoJlTLdJ91GJ8FyYHnGmH/jTxZjlYwSymjd7u3yS90l4bs884TwRamjC+6aX61/CdxwTAcGXR9NDY0+sP5Tqmjfq4egTtSrklkiH2xE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5500
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230121
X-Proofpoint-GUID: u6kH3SliFuIOqZi4o9WJcnZcKpTzPBKP
X-Proofpoint-ORIG-GUID: u6kH3SliFuIOqZi4o9WJcnZcKpTzPBKP
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 23, 2021, at 11:35 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Thu, 2021-08-19 at 09:10 -0400, Mimi Zohar wrote:
>> On Thu, 2021-08-19 at 14:38 +0300, Jarkko Sakkinen wrote:
>>> On Wed, 2021-08-18 at 20:20 -0400, Eric Snowberg wrote:
>>>> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
>>>> what is called Machine Owner Keys (MOK).  Shim uses both the UEFI Secu=
re
>>>> Boot DB and MOK keys to validate the next step in the boot chain.  The
>>>> MOK facility can be used to import user generated keys.  These keys ca=
n
>>>> be used to sign an end-user development kernel build.  When Linux boot=
s,
>>>> pre-boot keys (both UEFI Secure Boot DB and MOK keys) get loaded in th=
e
>>>> Linux .platform keyring. =20
>>>>=20
>>>> Currently, pre-boot keys are not trusted within the Linux trust bounda=
ry
>>>> [1]. These platform keys can only be used for kexec. If an end-user
>>>> wants to use their own key within the Linux trust boundary, they must
>>>> either compile it into the kernel themselves or use the insert-sys-cer=
t
>>>> script. Both options present a problem. Many end-users do not want to
>>>> compile their own kernels. With the insert-sys-cert option, there are
>>>> missing upstream changes [2].  Also, with the insert-sys-cert option,
>>>> the end-user must re-sign their kernel again with their own key, and
>>>> then insert that key into the MOK db. Another problem with
>>>> insert-sys-cert is that only a single key can be inserted into a
>>>> compressed kernel.
>>>>=20
>>>> Having the ability to insert a key into the Linux trust boundary opens
>>>> up various possibilities.  The end-user can use a pre-built kernel and
>>>> sign their own kernel modules.  It also opens up the ability for an
>>>> end-user to more easily use digital signature based IMA-appraisal.  To
>>>> get a key into the ima keyring, it must be signed by a key within the
>>>> Linux trust boundary.
>>>=20
>>> As of today, I can use a prebuilt kernel, crate my own MOK key and sign
>>> modules. What will be different?
>>=20
>> The UEFI db and MOK keys are being loaded onto the .platform keyring,
>> which is suppose to be limited to verifying the kexec kernel image
>> signature.  With a downstream patch, kernel modules are being verified
>> as well.
>>=20
>> Initially Patrick Uiterwijk's "[PATCH 0/3] Load keys from TPM2 NV Index
>> on IMA keyring" patch set attempted to define a new root of trust based
>> on a key stored in the TPM.  This patch set is similarly attempting to
>> define a new root of trust based on CA keys stored in the MOK db.
>>=20
>> The purpose of this patch set is to define a new, safe trust source
>> parallel to the builtin keyring, without relying on a downstream patch.
>> With the new root of trust, the end user could sign his own kernel
>> modules, sign third party keys, and load keys onto the IMA keyring,
>> which can be used for signing the IMA policy and other files.
>=20
> I can, as of today, generate my own mok key and sign my LKM's, and
> kernel will verify my LKM's.
>=20
> What is different?

Are you sure your kernel doesn=E2=80=99t contain some version of the reject=
ed=20
patch referenced in the cover letter  [1]?

https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com=
/

