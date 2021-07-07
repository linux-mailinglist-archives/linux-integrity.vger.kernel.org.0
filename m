Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD9B3BF21C
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhGGWfd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 18:35:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26268 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230264AbhGGWfc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 18:35:32 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167MKwd2000374;
        Wed, 7 Jul 2021 22:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=2+Acsy/Y8Ih+OWQLmZ9JRB0ibClId4afuyaeoXNiRyI=;
 b=CJLlzHSysCGA7/y2cGySLum7iOzgu1utpKCzhbcUy4i/+bw4Jbzvpxnd2BnTCEzsrLW6
 tRrTVal3OFHuZ/HelhD1z/Vyr3oaIAxKq0zP8KzUsjUCBJVwzygl3Uccm7ddVBDJdteL
 QwRGPbqVWz89yPRn5wTR/ukubLbCOdI/1bsoi2rreO/7OER5mJKNpf0kUHaOgpvMfyCm
 xSnMUU/+8inni9vBTYWarFiGQaE4m/Yw+CXUqVNxNxeD2N25cnJLuTBEVuSVqdJV6ao9
 Toz7tUEDyIeoqvFMyrFAKvn4vIFVdZUCJLOQf6aOkXKP0BG5q0Stg2uw/Hshoj7ynGY2 qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39n7wrsqyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 22:32:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 167MK9PU153666;
        Wed, 7 Jul 2021 22:32:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3030.oracle.com with ESMTP id 39jd1498ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 22:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8Xj8X5vvgJhpscRyqmzcyEKNRMb+o8OYbX/fcDdJOg5Or55VytAaDRF9MwJ2EG2A5hFgbXhA++8jlR/QpIUPZ/ji+Z0ZH8Mu+0mWtpUtcmVJra69H0NM3iXeqIQzMDYz+0+p2FxWzN+vs6afNQTB/MwJPUKptQg3Va0raGZXdj990ao5CmIeL1nv/rZihtffiTIRdEULbk5I2w0gAeMkCqxcWlewoor7a7IfdnlHm+65LTFegv7o0h0FV2gTR6b1I1QpC5d+Le6RUPNJCog2Vuk5PffXHGRI+pSiWMo3FQhlHAE7ksBVm+8m75sflabq4MtYpJ6l5XBScYinPK2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+Acsy/Y8Ih+OWQLmZ9JRB0ibClId4afuyaeoXNiRyI=;
 b=BOzdGOHVHgcOiYDwuEcuPA7PjBgcA9C06ImPZZc8J0rXqdM6Mxury6ZaefKSAvezN5FjMtNt9hn+VJ0E3FVYUnBGdv2Nuumqa8BL5SF1RT3w3SUNYVsCXjuhtReMymGRTAMQ4QcONbK9Ssl2EtyNIWtyVIaaRgIhrMJk8mocQFwLxViaoXXEdx7eWSS1GZ4wBfR94rbbDKV6mY/ewBLiXHEK5qkagEFoerFn7w+YWRmMU55/ec87xge0BkCJpuNMePl3QzGpiTgHP1dBOxBLKbKAwQx46qdZKSy2Q7IJSs6i9P70bTFnKqI9OkkowA6jsofQGGKSrpD63AowUIIJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+Acsy/Y8Ih+OWQLmZ9JRB0ibClId4afuyaeoXNiRyI=;
 b=P3JjPnAh4IBhSXoppcd8Z4D5ROWVSVgBOM2Qsn3FfX+efoMoL1/FdJeR0Go2GcKuuw8+fbKHeX1LKl0Z1x5E4A1R8X0Fg1VyCKwQ0phjz2HIH2/U/D1NU6fSIRRKcqvNoHR0v0L3D4KklwN3yC98o8jqcwzt69/XKI1/LlsYBhY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5098.namprd10.prod.outlook.com (2603:10b6:610:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Wed, 7 Jul
 2021 22:32:23 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 22:32:23 +0000
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH RFC 05/12] integrity: Introduce mok keyring
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <20210707212611.pdkmkxhqomkf4ngg@kernel.org>
Date:   Wed, 7 Jul 2021 16:32:17 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        James Morris James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        scott.branden@broadcom.com, Wei Yongjun <weiyongjun1@huawei.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Jones <pjones@redhat.com>, Gary Lin <glin@suse.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7621EA59-5EF4-4ED9-8320-6169000DE9EE@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
 <20210707024403.1083977-6-eric.snowberg@oracle.com>
 <CAHk-=wgEncBgRdv0FZjmZGQP5tzcdYA0XJrxmBEOevi06dimtw@mail.gmail.com>
 <20210707212611.pdkmkxhqomkf4ngg@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SN4PR0401CA0018.namprd04.prod.outlook.com
 (2603:10b6:803:21::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (184.60.195.210) by SN4PR0401CA0018.namprd04.prod.outlook.com (2603:10b6:803:21::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 22:32:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db3b5e64-b272-425a-4fe9-08d941971701
X-MS-TrafficTypeDiagnostic: CH0PR10MB5098:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB509812C0E1F46E632622F2EA871A9@CH0PR10MB5098.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHKduEhhEOhiwTDUZYO36ZKYgejzyseYLc6kmr6jWMF0lv82yypyHcqqLCN1rBhmK2EsjFGfR32+fLf6i8vgwa1PaOxnhUmUiLXN8yDaEISYmrLqOZLR7zZyH7R9zVLHa5PGhzVl7CnhtmXu0Q20WRIkAHEBLoXtjZP5ttdjoOlKZGYZzgY/oLNsnXASQ+Gu/hPvo0Ux6aOAslTy5iGa07s5M45sVHj4nWsbBaR11bq63Z7vFrULwZ2vlli6RoWu30BwUCk8yqkSJAMpxyChylvM1DUxX0sWn25OVu9ydJD5Oifry02G01vZpiSnn2t3HNHXLTilvQ5fwAs9cwT0xBrdjGqfBanpdnX+sYqTExqCGl4JivdVOutV5u3kG6AYsJmNO5MX0Rnrh5FAS77rP1YQKa4mthW37ZNfHrFZkw/P97XUWlWiCxkPK0LNV+vVkwH4Dz/zWUGkOvBqtDlN9mcxydZRoGqE5drfhQNKIrkhhnB4kvMATiEU/xWPG8lR8Gh4QsVAVsowhU8lJEyjqbd69nZW+CGc8UBYxnihdqdYbn3kIY2W4/BT2wIHqWpIVj/R24KYBxe5wwq1xMh1hY6c8toafd+bcRp4Dur+rKDo3f2vQT54CIvaGpE5VAN7Ac1XAkI1h7QonX35IdUoPZ3onPqHBG3vo02qytW/0GatvAaFsyhPdH9+1w6/pbq1Fahzoajv5yAKWuhdNcezQm79ToO19R9KZKdM7vRG2Kw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(376002)(136003)(39860400002)(83380400001)(5660300002)(52116002)(8936002)(54906003)(6666004)(186003)(316002)(26005)(38100700002)(38350700002)(4326008)(6486002)(107886003)(66556008)(66946007)(478600001)(2906002)(7416002)(53546011)(110136005)(16576012)(86362001)(44832011)(33656002)(2616005)(8676002)(66476007)(36756003)(956004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OgRUFsHLljEk/SfHuXvewkCXLy9xARvvprEGF8JaWle99W4ryeAcr1n4E9U6?=
 =?us-ascii?Q?Bzgw0FWeNkYcmSZ/HhqOuHftZwVEpPZhZ4RYYAxu29AXEZzstzP1qK5viMxk?=
 =?us-ascii?Q?KGWlG0Q3fZNFmh1krk2IKOs1YIalmuf9IE3ZUPWFYpFo9wSAJpAw1lQFZGC7?=
 =?us-ascii?Q?U8fSOJJwbz/byVKjC8ApE0ski8X/W4a3YvMbaalusl24Mt3GzqcJ6EXV7gTH?=
 =?us-ascii?Q?+0hLhc9KR8W7spFbYj4RpXcDKnMIB/sb0hKf9zzAehC2frYOKZSpoGBKAffM?=
 =?us-ascii?Q?4PQ38PlQVm8tYToogntzyT2UeP5LbgAn1YrxViBfQqHp6Rip6qSA8XmLYckj?=
 =?us-ascii?Q?SpfsH0PudJN400twB8TVnwWXrGHXqQto9d7pCpTrH3Y4lbWrISKFIYzlt0oy?=
 =?us-ascii?Q?zeieALNmPlUWR14II36re740zcAApsJsDFBqVfydL8FW0H3c//hW19HUzUaf?=
 =?us-ascii?Q?tP2bpHdP17kupJdqFIdwpqWV3cYA6wReiZkkJzbrEdVF6w49QvnWxgjanGod?=
 =?us-ascii?Q?1ogzD3hDTtJU4geE4GuEKUleuT33XoqPZbySLe5wOHU5dmHbPJdIw689rNiC?=
 =?us-ascii?Q?jWI36m3lAtjGUPD5xnmpO5ZNi0hFGiQT+CU4Du7r5Jt+zXjYZGHDhbISTLRi?=
 =?us-ascii?Q?ma7wYH10sX+ON/dEPy5CBmc7LWLgWEuAS3aoe+eUq55xFIAKoD4kGCGskyoQ?=
 =?us-ascii?Q?GNK45tl5+HcdQSqV6KOM+gJRphBhfbAlkpvSrdc+BJ275yCk8oy9Zly37iNe?=
 =?us-ascii?Q?zqEMoQHTbhiKB/GxqPysxV3qIQnW0caW8k8RKGLfOOsa+qdlCKoNIOoVfCbw?=
 =?us-ascii?Q?6QrAhnTwS7TK43ArezoY8bYOh9BpYGyGwi2pGKf3pb21mKEIbH6dfTnbVl6a?=
 =?us-ascii?Q?9446Rps5zErln/VhSVeue7fPi1tNfTsBrjMbKTHpjwRZU9uVA7aiCPtLo/A+?=
 =?us-ascii?Q?rZ3Poxgvv1DdKDU8Jo3HxZKluevPMWdzVEK/ePhxiVm6Z1Qmkx85cGunaZgh?=
 =?us-ascii?Q?IWsuadYLAk82NJ73Sf/H5sB02JhJefiZHYXaznps2StrlX0Fprcc7xQoobub?=
 =?us-ascii?Q?da1UR8Py6OotG8CiFQkMB0BGFhtoCHyceNLZZHcVEzSU67HmQSIYCbzLPOjP?=
 =?us-ascii?Q?VQRYiiRc7Q32TQy189776u7cFNWoBA8xU3r/mbR1JmocCnSofZiyiazCbAWT?=
 =?us-ascii?Q?CHIX7WRCfTAWDZgV/AivRjCnkIe/GhvB1HbE/xiI6Tg2u3MOo5k0AqJtMMmG?=
 =?us-ascii?Q?1AKAHvfmVfhuaNVTWYKTV4BOWMGMh6fZw6JiwgBon6YHE+GE+842Y2a73Xrt?=
 =?us-ascii?Q?Uvwp5paMCQX2zyNoEnkWBdOz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3b5e64-b272-425a-4fe9-08d941971701
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 22:32:23.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHoaueVfuqLEmYrLwOdqqFzRUTphoQVjWwiaaB50lJW8vboxBwtt0kYzyBNVrd0NX7T9JKPVbqCu2tYkjYntSFlU8g/gccr5tSvdN57fQdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5098
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070128
X-Proofpoint-ORIG-GUID: aRgk1wNboYo1OOP0h80T1TwhAL6F8WQ1
X-Proofpoint-GUID: aRgk1wNboYo1OOP0h80T1TwhAL6F8WQ1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Jul 7, 2021, at 3:26 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Wed, Jul 07, 2021 at 12:31:23PM -0700, Linus Torvalds wrote:
>> On Tue, Jul 6, 2021 at 7:45 PM Eric Snowberg <eric.snowberg@oracle.com> =
wrote:
>>>=20
>>> Introduce a new keyring called mok.  This keyring will be used during
>>> boot. Afterwards it will be destroyed.
>>=20
>> Already discussed elsewhere, but yeah, when using TLA's, unless they
>> are universally understood (like "CPU" or "TLB" or whatever), please
>> spell them out somewhere for people who don't have the background.
>>=20
>> I saw that you said elsewhere that MOK is "Machine Owner Key", but
>> please let's just have that in the sources and commit messages at
>> least for the original new code cases.
>>=20
>> Maybe it becomes obvious over time as there is more history to the
>> code, but when you literally introduce a new concept, please spell it
>> out.
>>=20
>>           Linus
>>=20
> I'd suggest for the short summary:
>=20
> "integrity: Introduce a Linux keyring for the Machine Owner Key (MOK)"
>=20
> Given that "keyring" is such a saturated and ambiguous word, and this not=
 a
> subsystem patch for keyring itself, it should be explicit what is meant b=
y
> a keyring.

If we can go in this direction, I will update the heading as Jarkko has=20
suggested in a follow on series.  I will also include a better summary in=20
this patch, along with a MOK explanation at the beginning. Thanks.

