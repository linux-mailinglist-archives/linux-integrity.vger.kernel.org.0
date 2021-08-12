Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4253EAD3C
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 00:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhHLWhX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 18:37:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31964 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237804AbhHLWhV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 18:37:21 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CMFbfq024975;
        Thu, 12 Aug 2021 22:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=BMOIKK6jzjj0JiGDZ6NWY0dqw5h+oBGu0ZXYV3LXPIw=;
 b=QQtDafNVyTaFt8ZfwZry4HkoFsMG9CgOY2PvCMUZ9dZw9NJ3IctbFIe3KXUgXId9jWYH
 rGJ1gXPGqex0zm81pLF9ngogrqsZm9PDal4QwyWECtDARpBHkb5sM6DqRK0UT4CDXdBE
 TeuA9CoyDepWmtqJCR53TUHbzb/PrEEKQEawBcl2aVhJc791wZYyLQFEvHoBpE6OR9nY
 oswbOv2earsjJuMvupKjYxYK12DMyPtOC4DxDgbARNHsST6dZd+0x+JvYFOh+Sb3mrMy
 niNUCad/CGAuOEDyPIGu0QHsG4zObVPKFBKgRNWUPLd1KQirDyvvZdmcI6oKOruK7w1Y Gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=BMOIKK6jzjj0JiGDZ6NWY0dqw5h+oBGu0ZXYV3LXPIw=;
 b=ZWo5P5Srip6ukCgHl7cX2YME4vZSwiEtGyuDxBP74z1SKzY594g+9JWlQjoYAGJMX0H1
 eqYR9NXz247xEIIlWl56qOIQPgFjKsyLjI/XwNXb9ud9LbKJf5buLY51WpzIMF8scqCA
 2MKEPvtCJJmCf2iZhuT4xJERH9VWvhmZKS6LcvVabZHNjLm420yv7CtLy+W++Ag3HKdz
 YlzcrJ3nMW/7Nt+2urT5cXoU2hXZk9/skrI/zMsK2WTf+c3naNSiCqPW5hA7U0jxUKKk
 jxGSaCHp7imkdKGYDi5nVcfhzGpoi+KuxQQMM5M+j6k2g+qGQe+EIyYNSZXhMQn1KyRy vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ad13v9mm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 22:36:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17CMITV6084041;
        Thu, 12 Aug 2021 22:36:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3aa3xy5ymv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 22:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrP9VEq7STcb4A8q8IzwxZHlpzO2ntW1z16DFoBGrxTVV03mgjTtUYUyTaM/7pw66DZzY58pYKkUp+kjurXhizxPi4BcjmCoCj9f63c5Pe4/FdbxcjcRvQPRQN0nal6i+vTAP+Sftp+YpcqOZuXaNQazfbs1/Dxp+df1o0H4i1TEVL5V1rCza7OUHSLNLFM+t2KeVHfU6IqMQPClMA+wYNxSWvcy5KcQvUqbtToK/xLn0T21c1GdBsPfL05c6U/je65Xy/zB4Lm/vg6zNAlVD13fE1SAXd6h8NP7YeqtBsZvPk6XZBH11gBcr+DLPONm1hlEgkwofn3ahY3ACIPsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMOIKK6jzjj0JiGDZ6NWY0dqw5h+oBGu0ZXYV3LXPIw=;
 b=WHV6RQwGrO7KQd7S7cLZl8ywjDDK1vKRfkLdpKoExYONv43WqDqtKY2z0My7KlwyI1AcceJoxrrRnVj/FDKoG3NJw4wJShI+e+ro9ys/wPa0F6TS2HtvB4+S+oixtggq5ElROIbjYbukttHmjnnb3K0hGde+TOvYU9Hg+RTLUKGzTe469WRg8b09G1IYxwtym//wvV1YZF0f5m6ytLwK5KKmi2lY+spW81RNQh2RRXL357+Ol1boylKNKQjBeRyOIGGRN8jMygXvkZMijw6kmDQV+TGNU607dbFSJECiJHzKy9490GHxGLaRA33AQx1u9uQPAt1wZcHHvQCOGVDAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMOIKK6jzjj0JiGDZ6NWY0dqw5h+oBGu0ZXYV3LXPIw=;
 b=HGZwxKXa4g+gum2N3ivgCayU49ThgRIVrsbig4ezPyedPOfR8dEdmnRhBeF9pzpS6a1rS9s6eILRlcN2/NZCZe5ejnc454EZGcaHNp6UGCXzl7iXm+xleeFG7tn56lendX8UUU/13NV7BUaweRIxTFzz0L797miORmgsfDH4H3w=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4311.namprd10.prod.outlook.com (2603:10b6:610:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 22:36:27 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 22:36:27 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 01/14] integrity: Introduce a Linux keyring for the
 Machine Owner Key (MOK)
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <34b12d8d47564a182f0a29a9592e203b17ccdd69.camel@linux.ibm.com>
Date:   Thu, 12 Aug 2021 16:36:17 -0600
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
        pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <915366E7-0B86-4F38-8AFD-EDA5FC1916D5@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
 <20210812021855.3083178-2-eric.snowberg@oracle.com>
 <34b12d8d47564a182f0a29a9592e203b17ccdd69.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::8) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:92:8000::196] (2606:b400:8024:1010::17c6) by SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 22:36:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e4c61be-0c41-46a8-988e-08d95de19f1c
X-MS-TrafficTypeDiagnostic: CH2PR10MB4311:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB43119189D2A76FB5708E27B387F99@CH2PR10MB4311.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rq1g8SmfnXcBBY9o+/WY7khuzVZ3pt3FkUpqZQJHW9d/LPKAAzNPnjEgcO8BGsKY1PummQZZixPOK3NbGTv9lHHqiE9Oz/a3YlT0l1WF6CKySGkj7hBmrRwTtJzdsVUMPMq0RATmZ33ymF71CrH02urP6STNTD8CpFseON2/oSPiSPXWr35oawRtOEZGNOf/mXt3XrmO+fU1AOXK9dazpg30uPrW1Wxph/ThxtBAhZsfWO8bedB2JfahIxTuC80pG/MgNUbkuXygSQp/I84FT465wwg67AUj6tPpQFarhRofGQlGjBLLqOn7pviW5NCjt8vMWFpiXTlB+h9hf10CM9n0rXqbJadVX3Ea+Cl9AGMMi0Mrszi9kmpuqpVnfo21SzLmEd+Gj//3dOY6Uh/+icyH3+WueNuBySowtsmBV+M3MWnvOSb/UaAR8II61Rat5KAlmHSZScJ34udZkYXQ6uvSqydhRldqX7ebYTn1bousJcz48t12dCuWEMohnODmh19snGMyKE9JxmnMvDDErOObBBPLYNvSbUJWtAaxGTu1BXhJFJZEU+FjOxC+F0M5h3tCUzuzArGkAeKBgZnCimQujznHsD86DY/RbLY58F8VKfvO1xnccjNXx471xuLtr1TeSe3HMAqSvgJ606DbkqF3vJc1SNdbegQEUB+Er0UrVAPfuednH9Z8tFrI1uuoOR68xXBKh67cyb/W8yWZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(396003)(376002)(136003)(83380400001)(66476007)(66556008)(107886003)(66946007)(6486002)(86362001)(44832011)(2906002)(36756003)(33656002)(8936002)(8676002)(5660300002)(2616005)(478600001)(38100700002)(4326008)(52116002)(7416002)(6916009)(6666004)(53546011)(186003)(54906003)(316002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXgzci9vbjdkR1dPd3U5azFwYjhpZVRkaGg0RER3UlJHV0F3TW15QkNJanlI?=
 =?utf-8?B?QmJXQVJQbUpmelROOExyaTBPbHJPWXZBaTkrZFMzS290M2twa09ib3M4b25Z?=
 =?utf-8?B?T2VVSmdrQWgxaDdkRFhBS1NXSUUxbGt6RXBXdTdkUUxpclhnVEVxM0kvQTlF?=
 =?utf-8?B?cSs3MW5zQ0R4UFdqNU5jTVh1eGZyVnNrdkxSaEVaSmVzTXhJVnVua1RscGdG?=
 =?utf-8?B?aE8ycVBiWFJzM3IveldncGZaWnROblBJUC93L3lOcERRaW11b0h1Y2l4YU5u?=
 =?utf-8?B?dHpXc3ljdjN5V1FmQVdrZjdSd2w2UWVuMWM3dkh2MjRwVWJOWUcvWHdpSHZM?=
 =?utf-8?B?SzQ3eFFSMXNwd2RjamE3SVdaQlc3TnVkTkVzbENQVkpac0I3M2s3ZWw1b0h3?=
 =?utf-8?B?a3l2eERuNVY5eTNEYi9vVGpSVXIzc1lGKzNwSE9PRGplN3Q0bzlDd3gzRGp6?=
 =?utf-8?B?dW1GeVh1SkJPZ1BpTW5QU1pHSGEzNW9mVnJ4dFlCdFRvQzFCUnFMeHBNYzZJ?=
 =?utf-8?B?ZlZTTGtyOWdWZkN4cnM5YUJqa1U4QXBrMnBnN2JPaGdLTG50NXRkYjdYZy8r?=
 =?utf-8?B?aGpFZWpWSDMwUklIcjc3TldvbE5SbURsYjRHRUNpWWdCU2tpb01KeE12bHpN?=
 =?utf-8?B?YXZ2QWY0UXhveStLaTlzMm5IMmorNVZvZFJPNVNLcVFhTXpYM1pVSFNHQUwy?=
 =?utf-8?B?MGR6aUtvRC9wdFNkWnNOTjBicTlSRTRqeVdzRmx6NERQU1lrSTkxT1NqOVlZ?=
 =?utf-8?B?Vyt5WnVWVmFOWHNhS1NtZlJITHYzV0NkSjFWaENFUUlLd043ZkkvUEthQTMr?=
 =?utf-8?B?ZDZxc2ZpRXBXa2FPSXloaGdYOGVydGc3VHRhWSt4dnI0NzVwRzhMUnVyNlBJ?=
 =?utf-8?B?OElPOUZkeTcyQXZqUnFzREkwQ2x1VGtYbUZ4TFpFaVk4OWg0NkR4bGlzdTlh?=
 =?utf-8?B?cHJUNlY3bjViVU5WWHJid0tpOCtrTkl2eW5JZ1NVRng4MkZyOEZndHRpN0ll?=
 =?utf-8?B?clg5L2Fnd0NqWXpYTjd4aWFPamVHWFp1ek1ta2ltaERmSnc5V0Z4UmhWYTFl?=
 =?utf-8?B?Y09JaUNrNlFoVUhQR0lYMFBROSt3NS9YSGZGckNaZVd0NmtjbWdNd2ZxWXhx?=
 =?utf-8?B?Rm9oMGxLbFB3ckJ2YTdSZ1lUQlNjVW05NmlGRk5tRVdnU1MzOUN4c1FJWEhQ?=
 =?utf-8?B?TXBPMG5qandlQm4vOW15QVhnZ1p4eDRGNlFaVVFZKzh4SzFOTVRneDZZTUJz?=
 =?utf-8?B?T0NNeG56N1VhQzJVck9hSEFjeE1sM1BMcWI2cWNSS3NRSFFiRGpTY1EvSEZS?=
 =?utf-8?B?NXhNSW04alVsNyttTDRDSFlOenI0d2l4Zm14ZXE0NXg3bTRRR1JtRm1wZU00?=
 =?utf-8?B?dWxtb3FqRG13cFd4enZ5OEFBMWMwRE44ak0vMVpWODZuRHhmbGhCMEZzc0pQ?=
 =?utf-8?B?NkFkdmF2NDVvZXlRTWd0ZkFpSnVOdWY0cmMyQ2hTVjVpZE9ocUJRbVdDditl?=
 =?utf-8?B?UUtXWGVicHVOcGw4WGJGSmdWNEF6MkZLYjllRDQ4amlIRGI5WVRwSU1iM2pO?=
 =?utf-8?B?ckorT0hTMUdSRExNUGRheVQ5enZrUmVNWXdzZGNId3hNS0FTRVFHcTMzLzlU?=
 =?utf-8?B?Wlh6eE5nbWhaVzkrOVVVL1BDeEVkckVnWFoyLzc2Ukl6emh5ZTR6UVVFQ2pB?=
 =?utf-8?B?NnkzWUdlOGVFZjl1a1JIN05YWDZ0c3g4UnhOQk9va01VWkgrWmw5U0FyTG5m?=
 =?utf-8?B?SUFySC84WnJmeEwxQjNuUDQwV05wWGZtY1c2OHBQZFRuNmhoYTNQYUlDQm11?=
 =?utf-8?Q?d0ouD7uf488sqqibwDt+hhg9EGbkW/T/Or68s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4c61be-0c41-46a8-988e-08d95de19f1c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 22:36:26.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gp/HCG8Ij8HINRLPm9fm/EBdPzlY89x4rRYNGk6QoZwI3biL6DAp5i5PNDmpIvPyG2YTDH2xHRzeMOndB80XZIFeTEMdczdslkhJZZLEwHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4311
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120141
X-Proofpoint-ORIG-GUID: Iyjwnp5eB3j9Qhi996YGt1ThAGS4_8jb
X-Proofpoint-GUID: Iyjwnp5eB3j9Qhi996YGt1ThAGS4_8jb
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 12, 2021, at 3:31 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Wed, 2021-08-11 at 22:18 -0400, Eric Snowberg wrote:
>> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
>> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
>> Boot DB and MOK keys to validate the next step in the boot chain.  The
>> MOK facility can be used to import user generated keys.  These keys can
>> be used to sign an end-users development kernel build.  When Linux
>> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
>> .platform keyring.
>>=20
>> Add a new Linux keyring called .mok.  This keyring shall contain just
>> MOK keys and not the remaining keys in the platform keyring. This new
>> .mok keyring will be used in follow on patches.  Unlike keys in the
>> platform keyring, keys contained in the .mok keyring will be trusted
>> within the kernel if the end-user has chosen to do so.
>>=20
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>> ---
>> v1: Initial version
>> v2: Removed destory keyring code
>> v3: Unmodified from v2
>> ---
>> security/integrity/Makefile                   |  3 ++-
>> security/integrity/digsig.c                   |  1 +
>> security/integrity/integrity.h                |  3 ++-
>> .../integrity/platform_certs/mok_keyring.c    | 21 +++++++++++++++++++
>> 4 files changed, 26 insertions(+), 2 deletions(-)
>> create mode 100644 security/integrity/platform_certs/mok_keyring.c
>>=20
>> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
>> index 7ee39d66cf16..8e2e98cba1f6 100644
>> --- a/security/integrity/Makefile
>> +++ b/security/integrity/Makefile
>> @@ -9,7 +9,8 @@ integrity-y :=3D iint.o
>> integrity-$(CONFIG_INTEGRITY_AUDIT) +=3D integrity_audit.o
>> integrity-$(CONFIG_INTEGRITY_SIGNATURE) +=3D digsig.o
>> integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) +=3D digsig_asymmetric.o
>> -integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) +=3D platform_certs/plat=
form_keyring.o
>> +integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) +=3D platform_certs/plat=
form_keyring.o \
>> +						  platform_certs/mok_keyring.o
>> integrity-$(CONFIG_LOAD_UEFI_KEYS) +=3D platform_certs/efi_parser.o \
>> 				      platform_certs/load_uefi.o \
>> 				      platform_certs/keyring_handler.o
>> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
>> index 3b06a01bd0fd..e07334504ef1 100644
>> --- a/security/integrity/digsig.c
>> +++ b/security/integrity/digsig.c
>> @@ -30,6 +30,7 @@ static const char * const keyring_name[INTEGRITY_KEYRI=
NG_MAX] =3D {
>> 	".ima",
>> #endif
>> 	".platform",
>> +	".mok",
>> };
>>=20
>> #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
>> diff --git a/security/integrity/integrity.h b/security/integrity/integri=
ty.h
>> index 547425c20e11..e0e17ccba2e6 100644
>> --- a/security/integrity/integrity.h
>> +++ b/security/integrity/integrity.h
>> @@ -151,7 +151,8 @@ int integrity_kernel_read(struct file *file, loff_t =
offset,
>> #define INTEGRITY_KEYRING_EVM		0
>> #define INTEGRITY_KEYRING_IMA		1
>> #define INTEGRITY_KEYRING_PLATFORM	2
>> -#define INTEGRITY_KEYRING_MAX		3
>> +#define INTEGRITY_KEYRING_MOK		3
>> +#define INTEGRITY_KEYRING_MAX		4
>>=20
>> extern struct dentry *integrity_dir;
>>=20
>> diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/=
integrity/platform_certs/mok_keyring.c
>> new file mode 100644
>> index 000000000000..b1ee45b77731
>> --- /dev/null
>> +++ b/security/integrity/platform_certs/mok_keyring.c
>> @@ -0,0 +1,21 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * MOK keyring routines.
>> + *
>> + * Copyright (c) 2021, Oracle and/or its affiliates.
>> + */
>> +
>> +#include "../integrity.h"
>> +
>> +static __init int mok_keyring_init(void)
>> +{
>> +	int rc;
>> +
>> +	rc =3D integrity_init_keyring(INTEGRITY_KEYRING_MOK);
>> +	if (rc)
>> +		return rc;
>> +
>> +	pr_notice("MOK Keyring initialized\n");
>> +	return 0;
>> +}
>> +device_initcall(mok_keyring_init);
>=20
> The ordering of the patches in this patch set is not quite
> right. =20

I will work on reordering the patches in the next round.

> Please first introduce the new keyring with the new Kconfig,
> new restriction, and loading the keys onto the new keyring.  Introduce
> the builitin_secondary_and_ca_trusted restriction and linking the new
> keyring to the secondary keyring.  Only after everything is in place,
> define and use the UEFI mok variable(s).
>=20
> Originally, I asked you to "Separate each **logical change** into a
> separate patch."  After re-ordering the patches, see if merging some of
> them together now makes sense.

I=E2=80=99ll see if merging some of them together makes sense.

With the new Kconfig option, should the default be 'y' or =E2=80=99n' when =
the secondary=20
is defined?  Thanks.

