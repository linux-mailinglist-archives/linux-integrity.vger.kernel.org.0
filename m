Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714403EAD00
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 00:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhHLWSG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 18:18:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5102 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230089AbhHLWSG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 18:18:06 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CMGCja031062;
        Thu, 12 Aug 2021 22:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=1UzAX1dKq9ti84H+LsPqzuX8EqQKb2e7DDWrgmH49AU=;
 b=n/7+3dQdx3VBhjLwMBRsY237M+4gMjIyJC1uXnIaakYLm9OMVuZeXZ/EM0Th6/IuAosH
 YKWuqLDe4S9IS7h8/cZ9O56/qsJGSTRHW8MmDDZLUOad6lmSiR/+ydfxBceb/9BbYSv+
 NFZ3Cf2z9rPUkO3Qe0FyIxhZv1bK110lhACQwM8llmzPROnQYqg/Ko4AMWDzdgrndtR8
 lYir9QwqbeKL6od9TbgvafF8r2ExA8n9wC+UC0FhlFsv69whK0UcSktTjcLPLI+96cu4
 SnmK3NrHB+UQDr0aMYS/EyOcIVONd8JAMtZ8UGng2vT+zwku5SG1NO7rRW2PdfFy4Z78 3g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=1UzAX1dKq9ti84H+LsPqzuX8EqQKb2e7DDWrgmH49AU=;
 b=Yb6J1Fjavn9h7C7Nje7FvR5h5ri8r7hfYDDRwDsLgX3JnqijSfDALcrEfGoc+MFnLQt7
 P6E8aemEIoGZJCh8XuoOJ9XrJBUV3/eimlkzdO2PtXt3Lfre3PfYda02Zpx3vj2L/Ipl
 1FnVn+erGX3+HS9ZucqiuU/xk/czd+G3jo5h+q2kzJCcF0782xF7E83iCtrsRicPsMwS
 NqFK+OQjT4L2Hye0p1/U//e9AoQLTA/jPr1w/p/z7Yw/uVH4kvwJHIz88aIAYz092jHz
 KTUzO42xUCXY+TZ/TTF3AdLi1Y22jVvPk+xLVi7gEPVjUTQCEvEYR7/QHdSnJ2PGfikR 8g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ad2ajhg8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 22:17:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17CMEXvp125562;
        Thu, 12 Aug 2021 22:17:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3020.oracle.com with ESMTP id 3accrcwqwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 22:17:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFrSJK9nE+LWVHAy+iHlPb2NtEqXwBDhp+dwyOwFCpB2VX/xRiplDKI2w4OSBfgJlXAaJ460vejUALye8jplMtXvW2qFsG/zcRmgmqiDfj2lPqDsWiNYQgBemgGPU4MpcSffvaWhrHFgsI9eEsf5FXGQmmYhsolH3bf42iod6uJYFrTVVu6O7/b/J0GgrkfFBdM7YnjM+WPNm6NxFRCvs5Ifz1jD4T1zOuh4/9d3UuTCDtUQHH4QYmsXp/6z1TXfk2y9xaUym5qCw6k9Pt+Bb2Lcj4N0QGwSJqzTDI8qw+PWKMtAOiOV5icMvzQHyXuVD+47SugxFiy3kEDSg5zrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UzAX1dKq9ti84H+LsPqzuX8EqQKb2e7DDWrgmH49AU=;
 b=dSX/8M9d/Vjgw0OctdOrqelZOuYj6vazKdOBM2mqhDMXbDlmwh7smiITxj/7yAIX7gtJqrKuPIbQFUgi44Ps8uLNnyID1LWrUN45NEahvkF3Pz0Qazab+8EI59q0Az7vxaB23cvsZD6fEsd6evBUNHz2fNdEOobG4V41pGJxL/ZffO8KPBtA96IfwCeSF5xJusFLNP8L0Z1dri4fyoeUgoEzs5sL3X/ttZJT0LdGY6B9I3+wDHDIguSPHQBt7qWJnyV82qywuGvsQqJrpomn4xYwmKu4n6TdHar++YLf+Ou7hEFk7Petn2+cX5hmqqGF+MuQbRm8dZLLe9eF9+qzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UzAX1dKq9ti84H+LsPqzuX8EqQKb2e7DDWrgmH49AU=;
 b=UyfP3DJtjw30aukaxge03rfJnXe+lN0k9LOR/QqjeqISgnLW6LGhF23xUstyhQzPTQcIJVIYTMXFuUr01oPEdVwiHeRWDujnRfMIDieebJ8LvEVEjbnECJ+y8XDR/vRo93ITjuHhV9X7qgN+zVoSuGOywEEfausuDnbPx77l6rk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4859.namprd10.prod.outlook.com (2603:10b6:610:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Thu, 12 Aug
 2021 22:17:02 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 22:17:02 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 01/14] integrity: Introduce a Linux keyring for the
 Machine Owner Key (MOK)
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <20210812185853.p5mgsgrftgwvt5fx@kernel.org>
Date:   Thu, 12 Aug 2021 16:16:51 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FE0A686-81C6-4A36-8098-0549D87FBAA0@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
 <20210812021855.3083178-2-eric.snowberg@oracle.com>
 <20210812185853.p5mgsgrftgwvt5fx@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: BYAPR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:a03:80::22) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:92:8000::196] (2606:b400:8024:1010::17c6) by BYAPR11CA0045.namprd11.prod.outlook.com (2603:10b6:a03:80::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Thu, 12 Aug 2021 22:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6267be4-4db5-48e2-e505-08d95ddee8d3
X-MS-TrafficTypeDiagnostic: CH0PR10MB4859:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4859E9B518C4412085CDDCF387F99@CH0PR10MB4859.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYHD9RuAKhU1LSDrMI0OBgp61KoKnILURopAc1EVcYo1kfx12ZuqXGRpftG0LFJ5jkspCEfkMoIk/inMUJP72dcwvAtCEfYtJA5b2gtBunKa7SsVN0Zp+MQU9bFGd/3EiG8+pnRmZ7P93ocFWXIgxLAoG/gF/vmzU4L5Zo3kXhZVS5fxcOnshBcfhCLKfeOrIHiIuk20YJ9ELTDq5HfNC7gTdeHw765aOLgmtEjNukBzRBfqaD4/YYvYAaJY8MccXBqP8WIOaRBkQNjlNhvXdLu3juREhguCHSUWPfIZ/qUGX6LlHEzqcissUDT//YFIw6umiCQLz2wW7Xr6rLRHcbDkLjIy72NDRQbBskeC0zc5rwWsAP0I3/kSSpba2CCeTeLPQYfUc/BlqXHfvarsA5H5ihxS6EXCPwNzDNA8b2zFZAK8OAh6hu63Jzl5Q+ULh3PLNiO0XXNGWhQIVOu+IEOM6+3q8HtWdorBLhhhLcoXY2kMkQ0QnBCsQitVRIuSksKUPqlG7b7SqZUlMfhRVzqEhRCCvv4XeTWg2Ak5iLzNDYj215rpwr9HvDzNfgZeDiuD05mXqkr7+LY0pEW3roKLtZQqJ7lMMlLzjVVpW0f2CDK09FMxCk9ameCGE5DFUIvAnF+0zFT+fW7kdfrvowQbC0eMuIpFVRTRwd/O+rRdymupSeidSYdzGVjuC58jq0BoSSkPYjOV1Y0fBC+SWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(8676002)(6666004)(66946007)(44832011)(86362001)(7416002)(508600001)(2616005)(4744005)(5660300002)(6486002)(66556008)(66476007)(316002)(6916009)(53546011)(4326008)(8936002)(33656002)(54906003)(2906002)(186003)(107886003)(52116002)(36756003)(38100700002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3JIMFl2dFZQbWF6QVRIc1RSVFFhemZUZmovNVZ1MWRYNUhGV05tbHhJRmFT?=
 =?utf-8?B?ekNzWlErVkVraHlHdXNzMW9rQzZPUHJmOVV2VngzYkFLZmJRSkhnYTJVaFkz?=
 =?utf-8?B?N1V2bUhzUG0ySm5iRXp1QU04RFM3aUk3OE04dmd2NzJPVXpTSUs3TGNycEg0?=
 =?utf-8?B?NEFoejlZa1BBZW5aOG9lTEY5TURuSmxCNEVQWjdqN0tVUkV6UDBLS2R4OVVE?=
 =?utf-8?B?aVNRaFZkNjRlWlVrU3JKaVhCTEVhVXdWZ2FNMU84UkZVaDVJNC9JNzNLbW0y?=
 =?utf-8?B?QUVOdkpzVTdKWWRsVzh2c0lyckphOTg5RzI3dHR0Q09ycXB1NmV5RjhZSS9k?=
 =?utf-8?B?WjgxUnkvSkZsL0lkZWYxRXZHeWZrNU9JRFdGbUVoTEltOWxyYkZ1M0FadXhY?=
 =?utf-8?B?cVV5eVZwMDVsejBJNVR1bUpCNEpiOXZYalJZRXMvMDVWTjNDUE5QNjUyVTQz?=
 =?utf-8?B?NVhNOW84RGdKY0doazladksrblM0TXFid3ovV09HeXE2Z1NLUkcwTG5qa2ts?=
 =?utf-8?B?NkFaWnJ2aUtjMGc4WitmMkkxeWNTUW5sWElNWENlWndUeTBvUkpuZjJaUDA5?=
 =?utf-8?B?cFRNbFJXay9IcndtUkRvL0hwNndQMzVUeG9ua0IwQ1dyUEkwTDhjazVXNm80?=
 =?utf-8?B?d2lZVFlieCttTElPRWNFVXBmUU9MM0ViZ3hHZVk0eVBxNFF4MUxLNXFreFFu?=
 =?utf-8?B?VG5XVUFSTFQ1UndHQVc1bmhVVzhwdldJWllZQ291SHh2aUJRelRxWEtSbUJi?=
 =?utf-8?B?TW9jN3hWMVpwUkZpY1J5L0FsODlBa1B4emRFSXNmM3VDdGxEZzB1cTFSV0Z3?=
 =?utf-8?B?UFNFdW91L2U0WDZQaGNyMEE2TmlOR3JDTW53VkE0Yms5K3d3K3lMVGphUm5N?=
 =?utf-8?B?aG10QjhyKzh2cmN6ZjJDQUNaTC83eHhldElkMnRrRXY0VTFQejdJY0xlMHBX?=
 =?utf-8?B?bmZYbnBrVDZubjhWbXFjWFhGUlBtMGZPcitVWXJVOE1mb3p0ek56a0JNM0dz?=
 =?utf-8?B?c2ZTOFM5N2IrSE1Ra1JZV2U2ZzB3QUxCMEhFblNuNi9sUXR5RzFBS09LRTBv?=
 =?utf-8?B?bFhjS1hCbmNwcDgrUEhETVBBdUlOemdZb21Sb2RnZERCSUY1ZVJGNHhmS1V5?=
 =?utf-8?B?K2MwS1FZY0ptalZxeVNaamNOUFFlS3hBY3NRQmJUbWMrcHFjZjhMVmczTjdY?=
 =?utf-8?B?eHJXaU1DOGtoc000bkVibk1Hdk9qTVZPRW45QkN5aHZSZ1R4aHJ1U0thVUo0?=
 =?utf-8?B?ZHhuVHhNeTZhQzVoYTlMQXVDbE4yR0hpd1RMZTVIdklXZGNhU2hpVHdHQm11?=
 =?utf-8?B?YWphY0tIdmlndTRHYnUxWitiSG9kZURPVHpaazFLSVg4Y1N0dVYwNVBneGt1?=
 =?utf-8?B?NExheStwb3pMUnIvNkNQVHlLcllCVDRQRlQzYWFkVndaSHFwWUYvdzJobGxw?=
 =?utf-8?B?bG9OMSsrM1J4WnNFb3VTMXVvaEMxN3ZKSEluR0c1ZlpDWFRnUTRKQXRDa2cx?=
 =?utf-8?B?ZWYrSE83WTBmb2I4MzhWOGZKalpLQnUySWowbGQ5NURnY3lCc3cyeWtTYnFo?=
 =?utf-8?B?T3YrTUg1cHk4cnU4ZzdqVXNqSDhQK0UwbW11bHdQUDMvektGM1VjaDdLcG5k?=
 =?utf-8?B?dGlPSkhNeXBwbVhOWGl3ekhSbEs3ZWVqWkhNbldFZjdyMXFxWkVzM1dIc1J5?=
 =?utf-8?B?dExRYnNaOUJhSzZGNkZrQUJlZUg0TnlzMTRSWStaeFlJR2tSV2l1aUNzaW9Q?=
 =?utf-8?B?ZE1veFlBZ3VxZzZiMkQ4ZjVOaTNmMUR0TEtjTlBNdWgvRGRZS1BIblZZWEpx?=
 =?utf-8?Q?Bk144jnWxdmEfBtqosOaZAIauXWS67UqD34fs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6267be4-4db5-48e2-e505-08d95ddee8d3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 22:17:02.1353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdggE8Ep7JTjj4/3zKZ9eG3GoHHSB13Ls+kC1lqKNYMxmMzpGVO/IfulX7fVFGf3AIjcx2zEgW+NaUGpgZ+o4x7oqAAD2V3D87vSOUj+YQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4859
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120141
X-Proofpoint-ORIG-GUID: M1YNXa_cFY41vkjQ9-7D-d6I8ZsEe4KQ
X-Proofpoint-GUID: M1YNXa_cFY41vkjQ9-7D-d6I8ZsEe4KQ
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 12, 2021, at 12:58 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Wed, Aug 11, 2021 at 10:18:42PM -0400, Eric Snowberg wrote:
>> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
>> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
>> Boot DB and MOK keys to validate the next step in the boot chain.  The
>> MOK facility can be used to import user generated keys.  These keys can
>> be used to sign an end-users development kernel build.  When Linux
>> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
>> .platform keyring.
>>=20
>> Add a new Linux keyring called .mok.  This keyring shall contain just
>=20
> I would consider ".machine" instead. It holds MOK keys but is not a
> MOK key.

I=E2=80=99m open to renaming it to anything that you and the other maintain=
ers=20
feel would be appropriate.  I just want to make sure there is an agreement=
=20
on the new name before I make the change.  Thanks.

