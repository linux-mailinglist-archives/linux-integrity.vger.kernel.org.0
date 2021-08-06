Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253E23E30E7
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Aug 2021 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbhHFVVR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Aug 2021 17:21:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62528 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237719AbhHFVVQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Aug 2021 17:21:16 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176LHdVQ009680;
        Fri, 6 Aug 2021 21:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=0/wVmg9lzBkJqJi16PggskP27pYpVFg1/JKTIbsojPk=;
 b=O3g2lRI0iTPCr2obHYaNTxZnsX5CnlD3ttZzj5s1B3arZrcReB5tE39hIwmc51sZR1O0
 vY4ykQFm6eJZ9e1cllxpbypOQlKoHHpdDe/f24H2rZJ6zobFRyhhJqC/iJlYt95VAcXK
 Dzf7/Q08U4cT4muR6htTx9HekGsRxt1YkolfF2wgQcVx31n4gdmab3FnRFt3Dbnp/fVp
 qD26FzvJEUUy7sYGBkIu7uUGZmp+5hsubifXlMfKq4FswpANH1/QtpdscXznJAFBcRHV
 3vDpy+RMsjfjBkEKkfdwrD6olos2YQXCeF1nPNVXPp5QW4wB7KiwkiR6K2icup/VUe3o Qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=0/wVmg9lzBkJqJi16PggskP27pYpVFg1/JKTIbsojPk=;
 b=Lgn0ArfflvERjfrttA4VdDlMqKD2KlqeYyT0dPI24kw7kMb5YQTl9aqXMjrC4343vlIv
 FwbXnLF44fs1bBnX71ULPJcdyd/bUacghjrY0bFWMiSWRzgeopdpBWgbL2lAU5Pouz2D
 c0i6C286KbtTDtmHyvyJpahnLaU/GnI8YhrWMRUCsXRsdQurjeOC7OEPWQeBFRc4lV6w
 +viZgCkjy0EYxKwEPmWGWjuyRb917IcuKSKAsvlEfj2Z0wgrKdDXLfxRSXfKujD/B2Mf
 hxHHfJ7gcqdyGkdoRex3Q95u+gQnD+b2ZnfjH0eUZeSVknHQlBeW39+LrHZKj0bWGdwr 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a9661ry1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 21:20:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 176LGAGn149139;
        Fri, 6 Aug 2021 21:20:26 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by aserp3020.oracle.com with ESMTP id 3a7r4c950d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 21:20:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQcJLVhjICa4KN4vo1bwqiWdmnUfwHzG1yP/E/cboeKO7Y/mw0kRmTgtRn/rdMpOS3sM3FC2ZS5LaSEUVzYyljNC7UaIz40KLVH7dTuSbBsZKoMhfQXzO91Xbw0xJPl5Qguve6HNYKcmffSSidmXXkj/lZoyzAuOtBfcP/OcR1fSKiYhD6aXCesnoCikb/g6Tu9lV0/0BQQC1tNm+5dFTTOQIPKNcmrzBqhxkm8/859O5g3xuGEGWYje/lu2yFINIjfaGDUEcuvtyl22NCbRCrsJA0H5aZjBSJPipfr4Mfjo9XBw3rBiFBsMFkmoyiBi00SBQ0jB4YMjPqSOBNjtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/wVmg9lzBkJqJi16PggskP27pYpVFg1/JKTIbsojPk=;
 b=nrsc7/GFDyyfoCEgHSTWxtashOEvnvUUx+q7q4PgLO9EPhP2gUvX3XUo1aFeddSSOq6xocgxhL+yEHdEtNYP1CxPzg4aNcgm4hiS/HBWFkyX8C2c3zeJKwdt4vhdvP8kk0HdO5Dny0/s+KzbtG9ehL24pgD5F13KmatjQ7P4KKrvV/u5ouCJ1U6kLrSh1GhnDTfsUeR5mdllj2InT9V3m7wtxosJMvFx94O3qpYvHmVkLvCwUwcvkAsqf61t0xCqMXLuRE1C6FNSLYVA9u4gUizK0H/D0mPtDkTPh73wMM1B/4pCcDUjtK4n8HlaHa6yc/95l6JxyXFh6ylbP7E58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/wVmg9lzBkJqJi16PggskP27pYpVFg1/JKTIbsojPk=;
 b=xN0V3WJ6xso+fG1ik8OnX41ApGua2/hA2oFhwK8Didk2vnsCCjoyi1/DZ63dx6oXMzT3YG6P5hTQhAE3Iwyh37vLI5IuhT2rbiSuyaQL9hH3wQZBP4Gt7lB17OliWCghNzmZdmsjrkxBtBjrq/ml/71G2xxNNhwhmc54ucbfoMc=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4157.namprd10.prod.outlook.com (2603:10b6:208:1dc::18)
 by MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 21:20:23 +0000
Received: from MN2PR10MB4157.namprd10.prod.outlook.com
 ([fe80::e876:8eb5:23ed:d99b]) by MN2PR10MB4157.namprd10.prod.outlook.com
 ([fe80::e876:8eb5:23ed:d99b%5]) with mapi id 15.20.4394.017; Fri, 6 Aug 2021
 21:20:23 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH RFC v2 10/12] KEYS: link system_trusted_keys to
 mok_trusted_keys
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <dc76d9463bb5e081d10154e909321b0d75391846.camel@linux.ibm.com>
Date:   Fri, 6 Aug 2021 15:20:17 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
        pjones@redhat.com, glin@suse.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A8F92EA-9E4A-4995-A1E3-B489207514E7@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
 <20210726171319.3133879-11-eric.snowberg@oracle.com>
 <6c751dadf4ce7385d0391ea26f1c7e4e910219e0.camel@linux.ibm.com>
 <44ADB68B-4310-462B-96A8-2F69759BA2D8@oracle.com>
 <d85bfe88bb4abd06e47a36743f53d0610da0a259.camel@linux.ibm.com>
 <21CB8F51-9066-4095-9C6E-428FF9E86443@oracle.com>
 <dc76d9463bb5e081d10154e909321b0d75391846.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SN4PR0501CA0063.namprd05.prod.outlook.com
 (2603:10b6:803:41::40) To MN2PR10MB4157.namprd10.prod.outlook.com
 (2603:10b6:208:1dc::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (184.60.195.210) by SN4PR0501CA0063.namprd05.prod.outlook.com (2603:10b6:803:41::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.4 via Frontend Transport; Fri, 6 Aug 2021 21:20:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 628af2e2-226a-4abe-44d9-08d9592000b0
X-MS-TrafficTypeDiagnostic: MN2PR10MB4318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB431852F7A8BBA45770AA43AC87F39@MN2PR10MB4318.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1sATdzwauvaa0FMybRzSa4BArcv+zx/OvLPqOOoHHJ/57cv7oJd1a8i4ZaoI0MGLKr4h62JuUK2D7DguloLTknLcwfJTRpMfsuipOZbvqWKpNsJDPIIt503VEkzF65Ugf4PTI3CMwITZyOChE6mr2NDRZykrwHaxGjueubX5VsjISBPU7XEEiBDrqdEdVrTpH+cctoba9IWvdqHWO+BjkY7rfb+l8aM86aLdSi/8GJTegDyroZtCWG+imI6tU9UeHVuKa4hTX/RFrdoM7IkruV1ejxCI0PqUuKNHI85SGLngoyX1cKKYCSkDQw625zaLFQZ6gqxcOUNridAdtN7FT0sBPUbBOsJ60uxFLwJkIpvWpFF9VtX05M5A8pWx30gfw0aASDe/p70YY2cy2hRsYrVlQskISmVffas5RRb6fwFT2aiZAfe85gb4I0Ui3FXi8VHNpRNDtnEsniHsrqcWTG5/Ym1kbbkf82pw5k687YCzQz5ujOvwe8/wAqk4ix4lwlWX0/BQt0aL6IMmAav9V4kgUWIOCZ0FBu/IdBAy2Kwhxs8tWMDEEgZ4yog3pevC4lPuZe506KzCGT99uwPFWOOLdIQt9Wx2APPInE1us14pheAL3sPYQPM1b3XlepK4W4PrbNyA7719sOiUrWCwl0ENPUBcogmn8xowcpxs3/BB5vbeP/5znWsTZv5CHD/0bXbqyhx2xRHaOFPcMxSpgp0EjhgUg78QBTAcn/UoO00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4157.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(39860400002)(366004)(52116002)(44832011)(4326008)(8676002)(33656002)(956004)(478600001)(54906003)(316002)(2616005)(8936002)(38100700002)(107886003)(5660300002)(53546011)(6916009)(38350700002)(6666004)(26005)(186003)(16576012)(66556008)(2906002)(6486002)(7416002)(66946007)(86362001)(36756003)(83380400001)(66476007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVM5emFlLzhvUDJ4Z0lBMk4zRWt0UVdpejdENUV4V0NYYTNnYXRrUFlRbEZx?=
 =?utf-8?B?M0RzWEpRTmRSb2szaFpxUEhvREk0eXFYYXMrN014RkFNZzBnbStGUUwxWEta?=
 =?utf-8?B?SGREbm13Ty91R01rYld1bGZUWnhWVEo3THNLbnpSVmo4dlN4ZUIyWXlaVkxX?=
 =?utf-8?B?NXBka1E1bWhDaUpyYm8wOWQ4RHdVeVMxak1mYkF3c2pqa0I2N0JLSGtOVFNp?=
 =?utf-8?B?K01MdWRucm11ZDIwY2hKc1I1R0xIVnBhTnlhTTJ3czZjNnNwaXpMT3dhT1dx?=
 =?utf-8?B?QUljWlBSOTJoQS9ZNlNFbWFwMzRVSG1aUEM2WWM3WkVlc1Q3VzlzTGt1VTRF?=
 =?utf-8?B?dHU4N1dkNXJUbTQraFlOdHdETHRtTnB4TEtLV05KUElkaGlqQzRqZHdGcHFM?=
 =?utf-8?B?WDdxVi9BNVNCR3M3SWx5djRiOUFvMFI3U2dsRFphWWNyOWhGZmV0T1M1dnBZ?=
 =?utf-8?B?RENPUDR2N2ZmQjR0VzBXZTl0bk1XaUFRQ2djVHByMkFlVnN6dWcwSzVxNW9X?=
 =?utf-8?B?OCtSNkRzOFNEeTVqaHFKa2ZTU0toZFhsQk1DVGxKb0xCUjNrbXZnQkU0SWcx?=
 =?utf-8?B?eWtpQnpWemdybHNhTXJ3VEVud1h1czJTU2VDbXluNS9Va3hacWtLRStTVkFU?=
 =?utf-8?B?d29YVnZBNFNyMHJSaEtlUld1Rkc0VFpEQjFmRHVxVXdCbUQ5R2FYTnVkYU1U?=
 =?utf-8?B?akovUmt4OUNOSk15bXRvbnN3SVdQTzUydUJybE9MdXNiejhEeUJzWXhoMW9R?=
 =?utf-8?B?eE9LSUFicHFMWFU5RVJIemcrOXFmRU5mVmRSSStTSUFtWTJPcDRhYWUzRGFS?=
 =?utf-8?B?ZEduRCtieFE2Z29pbTlvQ1RreHdlZmNoVFFzdWF5ZFdvYWV2N29ScU5FNDRt?=
 =?utf-8?B?dGc4RW9pVHN6bTIvcmVxRndlQ2xkY1JSWkFzdlI0YW1zM0RTUXQ5T3AycnQr?=
 =?utf-8?B?N3RkWmlxSEtZSUk5cE9NTGNTZGRCSnVRQVEvdTRGTWErYUN4NUdoQzBEMXdm?=
 =?utf-8?B?SERnN1BLUlg2ZllLNXpncnBibEtWdXBuK3kwampTOXFnb00zenJLd09YVzZ4?=
 =?utf-8?B?V2U3M1UzNzNjTHJ0WVgwdG8wWDRUOFdMb1ZsOU95bWZNYVhrb2hBVWhTYVp1?=
 =?utf-8?B?OGtHME4yZjlORXMrVUc1MFJmeUczWEp2OWtpeVR6b2ljcDEyRnNRUkpGYUM0?=
 =?utf-8?B?aVdTWWVicUNBVUNGclRncmZtZzFXMnlnbnVRUmkvL296Q2l6b0h0R2tVOXFk?=
 =?utf-8?B?R0MwTTJFdnNyaDJ4RE1iay8zbTZQR3hzcy9keklSNlJ1eDdxTUZvVWlTOHdK?=
 =?utf-8?B?d2VqZkw2dnVjQ3ZnMkhOaDhBWDRuMUFQVzZ1K0I4U3pwNnZnd29KRms3MVJX?=
 =?utf-8?B?elpsMEw5MmwydjAzTXdXTUhYRmJHZkdOa1dpdkEzZ1QwRlRNdU9UMkJFZWVO?=
 =?utf-8?B?NVR1WjJUUUxUWlF4SkFBZEloYXdCUWpLM0RFYU1FZU9qMVRhenZEcnN0dThM?=
 =?utf-8?B?K2dhSW03TThhVjV6TlB0NjRZUHluaFBBcC9OTDI2MS9QRnVSTVhuVWIzUmJp?=
 =?utf-8?B?U1lNVDQ1VlArRkNGZU1mMjR0TEMrTXZ3R2RCelJpbDhhb2J2eDZUV1d4ZEFC?=
 =?utf-8?B?ZkRxRUo4dGl1QTR2L0pSU2NVU2M4bnJGS1Y4RW9Taitsc2lnaGhNRU5wZ3lW?=
 =?utf-8?B?QTM5UHlQMGhtV2c3MktCR1BOUnVOczNpd3FmUmphMmxHWnA0aUQxcUdySS9M?=
 =?utf-8?Q?bqGUBy8LdIDDnFowUq5y2MuIvNVqxHaL3lFCJXU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628af2e2-226a-4abe-44d9-08d9592000b0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4157.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 21:20:23.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEeR41NUwX66W368ekQaMDfLDD9Y0/7qzBT6YU0ndJp3w7QrWlN+Ey9FVqhf/+Lo/5BD+BTOlY0HsuBt1ZUaBqp4teTLfUQxIG8m5DCxmVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10068 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060139
X-Proofpoint-GUID: YJt6i-q3GYfod6C7d4JENaVY4DVvRi9m
X-Proofpoint-ORIG-GUID: YJt6i-q3GYfod6C7d4JENaVY4DVvRi9m
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 6, 2021, at 9:18 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Fri, 2021-08-06 at 09:00 -0600, Eric Snowberg wrote:
>>> On Aug 5, 2021, at 9:19 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>=20
>>> On Thu, 2021-08-05 at 19:29 -0600, Eric Snowberg wrote:
>>>=20
>>>>> From the thread discussion on 00/12:
>>>>>=20
>>>>> Only the builtin keys should ever be on the builtin keyring.  The
>>>>> builtin keyring would need to be linked to the mok keyring.  But in t=
he
>>>>> secondary keyring case, the mok keyring would be linked to the
>>>>> secondary keyring, similar to how the builtin keyring is linked to th=
e
>>>>> secondary keyring.
>>>>>=20
>>>>>      if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0)
>>>>>              panic("Can't link trusted keyrings\n");
>>>>=20
>>>>=20
>>>> This part is confusing me though.
>>>>=20
>>>> Here are some of the tests I=E2=80=99m performing with the current ser=
ies:
>>>>=20
>>>> Initial setup:
>>>> Create and enroll my own key into the MOK.
>>>> Sign a kernel, kernel module and IMA key with my new CA key.
>>>> Boot with lockdown enabled (to enforce sig validation).
>>>>=20
>>>> Kernel built with CONFIG_SECONDARY_TRUSTED_KEYRING=3Dy
>>>>=20
>>>> $ keyctl show %:.secondary_trusted_keys
>>>> Keyring
>>>> 530463486 ---lswrv      0     0  keyring: .secondary_trusted_keys
>>>> 411466727 ---lswrv      0     0   \_ keyring: .builtin_trusted_keys
>>>> 979167715 ---lswrv      0     0   |   \_ asymmetric: Build time autoge=
nerated kernel key: 07a56e29cfa1e21379aff2c522efff7d1963202a
>>>> 534573591 ---lswrv      0     0   |   \_ asymmetric: Oracle-CA: Oracle=
 certificate signing key: aeefb4bfde095cacaabff81dd266974b1b4e23b8
>>>> 968109018 ---lswrv      0     0   \_ keyring: .mok
>>>> 857795115 ---lswrv      0     0       \_ asymmetric: Erics-CA: UEK sig=
ning key: 9bfa6860483aa46bd83f7fa1289d9fc35799e93b
>>>>=20
>>>> With this setup I can:
>>>> * load a kernel module signed with my CA key
>>>> * run "kexec -ls" with the kernel signed with my CA key
>>>> * run "kexec -ls" with a kernel signed by a key in the platform keyrin=
g
>>>> * load another key into the secondary trusted keyring that is signed b=
y my CA key
>>>> * load a key into the ima keyring, signed by my CA key
>>>>=20
>>>> Kernel built without CONFIG_SECONDARY_TRUSTED_KEYRING defined
>>>>=20
>>>> $ keyctl show %:.builtin_trusted_keys
>>>> Keyring
>>>> 812785375 ---lswrv      0     0  keyring: .builtin_trusted_keys
>>>> 455418681 ---lswrv      0     0   \_ keyring: .mok
>>>> 910809006 ---lswrv      0     0   |   \_ asymmetric: Erics-CA: UEK sig=
ning key: 9bfa6860483aa46bd83f7fa1289d9fc35799e93b
>>>> 115345009 ---lswrv      0     0   \_ asymmetric: Oracle-CA: Oracle cer=
tificate signing key: aeefb4bfde095cacaabff81dd266974b1b4e23b8
>>>> 513131506 ---lswrv      0     0   \_ asymmetric: Build time autogenera=
ted kernel key: 22353509f203b55b84f15d0aadeddc134b646185
>>>>=20
>>>> With this setup I can:
>>>> * load a kernel module signed with my CA key
>>>> * run "kexec -ls" with the kernel signed with my CA key
>>>> * run "kexec -ls" with a kernel signed by a key in the platform keyrin=
g
>>>> * load a key into the ima keyring, signed by my CA key
>>>>=20
>>>> So why would the linking need to be switched?  Is there a test I=E2=80=
=99m
>>>> missing?  Thanks.
>>>=20
>>> It's a question of semantics.  The builtin keyring name is self
>>> describing.  It should only contain the keys compiled into the kernel
>>> or inserted post build into the reserved memory.  Not only the kernel
>>> uses the builtin keyring, but userspace may as well[1].  Other users of
>>> the builtin keyring might not want to trust the mok keyring as well.
>>=20
>> Should this feature only work with kernels built with=20
>> CONFIG_SECONDARY_TRUSTED_KEYRING defined?  If so, I could drop support i=
n=20
>> the next version for kernels built without it.
>=20
> Support for loading the CA keys stored in the MOK db onto the mok
> keyring, only if the secondary keyring is configured would really
> simplify the code.   Support for using the mok  keyring without the
> secondary keyring being configured, could always be added later.  As
> long as the other distros agree, I'm all for it.

Agreed, it will simplify the series and there is nothing preventing the=20
dropped code from being added in the future if a different distro finds
it necessary. I=E2=80=99ll work on this in the next version along with the =
other=20
changes you identified.  Thanks for your review.

