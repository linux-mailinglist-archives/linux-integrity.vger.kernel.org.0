Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFB0267ACA
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Sep 2020 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgILOS0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Sep 2020 10:18:26 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:32156 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbgILOSX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Sep 2020 10:18:23 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08CEDfGe027674;
        Sat, 12 Sep 2020 14:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : subject :
 to : cc : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=sg1bdme1ke6Q50V86+5S43VHeSOi1IecIC1VXvGj0tg=;
 b=Chibd4Y9/AtTyd0oJNtYIEJEcT4NOKXeZA9nooqDaT1ZOguyWnyAwcbCLdsd+g677pil
 QiAFh5shAkh28g2Df4HLJYv9wKUfvux86gwPg9604+WcwmDD4Evuq1z2sT6UibeGUYAX
 uKz7Ixl6tX9TBlC4YqmpwfGtFx875wQwna6ci4XOVvw+aAWhOGyT7+IV2qIgjgCh3wZl
 K9ktVaeMcCX4wuBFEXNJVv5wG507G+LKgAwZbt2I0A7F47U7555kgRUtfdfkFL8FL5D5
 0CKbd/Kl6r4vxPnLD7aIypqcPcbrmft9omOjDZAkY3qmmZOO90utJNkgbRSspkWUV0Q4 Fg== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 33gn0ctm0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Sep 2020 14:18:06 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id C96E34F;
        Sat, 12 Sep 2020 14:18:05 +0000 (UTC)
Received: from G4W9336.americas.hpqcorp.net (16.208.33.86) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 12 Sep 2020 14:18:05 +0000
Received: from G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) by
 G4W9336.americas.hpqcorp.net (2002:10d0:2156::10d0:2156) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 12 Sep 2020 14:17:43 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W10204.americas.hpqcorp.net (16.207.82.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sat, 12 Sep 2020 14:17:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHMK2LCcwu8EroXR1T3Q5EvViifgTNm1gPkjKfsbkiGK4tf6ylrPX2heCs7RD6mTEfNW1yQbc1cI7PKRIvtDY9XtsUlwVJqfIbahTJoZnJOldbM3jeRXsP+BWTE+xvsrA6eJV/AQYk4PeJ3RI5i+FaivSCYlhW3kFWdHpBOqVchZxGwc8h5//Y2m5fAeGKA+eAyMuqEFaEuPdQS5CiQEswLAnWACh1L8zMMfUqz8bolU8Hcs/SEvJ5/F0AvflLBEjONFUZlSjUxOdBpvuDtTTNA5acdF1Cf2RG0qHALQ7vccp+aMjFkSGIN3jn/D/n+HkL47aT/bTAw5Ha29ZGy//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg1bdme1ke6Q50V86+5S43VHeSOi1IecIC1VXvGj0tg=;
 b=Z2mleF7P3RVzntj1A+Bu7m5eSRyLqnGdyRqYsXn3VnXID9ARCQkZOKnMpeDdSbMNG/uFV/N5tgilTiUUrkOe2wTeOosH2NmfXihxBhhRp/kJu7ANM69nqL5SYZui8pR3HcUHAGj78u+OAEJQNMZ/CO8SpYp6eWBjn4n0A21c941w/KiUTcmFJPlH0Dm2yb/XRoLYl+0xSMC1tf2sMSc8NZsbq71Fus1MbzFAmd7jbCUDmwHLcHkGjG+IbvEuTsYEs4V2bJCqhKRsz3cnkA7KNnjAt57s9Sd7H2pYBLa4kHghFZWEt3eFyJYPjkwrhrpyHUoCnE0GXD+9Q8NGI4czPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=hpe.com;
Received: from AT5PR8401MB0803.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7424::10) by AT5PR8401MB1251.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7429::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Sat, 12 Sep
 2020 14:17:39 +0000
Received: from AT5PR8401MB0803.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::608a:ea12:b665:5432]) by AT5PR8401MB0803.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::608a:ea12:b665:5432%10]) with mapi id 15.20.3370.017; Sat, 12 Sep
 2020 14:17:39 +0000
Date:   Sat, 12 Sep 2020 15:17:26 +0100
From:   hamza@hpe.com
Subject: Re: [Bug Report] Kernel 4.14+ TPM Driver Bug for Atmel TPM Chip
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     Hao Wu <hao.wu@rubrik.com>, Ken Goldman <kgold@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>
Message-ID: <2DUJGQ.3X1TLM389WIN@hpe.com>
In-Reply-To: <5a62669c-59e2-861a-f851-bd28e5e84e36@molgen.mpg.de>
References: <9173F912-F682-44CC-8408-565A6C675749@rubrik.com>
        <20200911041800.GA541925@kroah.com>
        <5518aa6e-a10f-9e07-e885-2ab43a0906e9@linux.ibm.com>
        <d9fc244f-f8ac-64cf-2b8f-0b13685fe6be@molgen.mpg.de>
        <B003F2A9-2DF5-4633-91C4-FD6B8A3353ED@rubrik.com>
        <5a62669c-59e2-861a-f851-bd28e5e84e36@molgen.mpg.de>
X-Mailer: geary/3.36.1
Content-Type: text/plain; charset=iso-8859-13; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO3P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::9) To AT5PR8401MB0803.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7424::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.43.228] (92.40.186.221) by LO3P123CA0004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ba::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Sat, 12 Sep 2020 14:17:37 +0000
X-Mailer: geary/3.36.1
X-Originating-IP: [92.40.186.221]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b41f76f9-d6c6-403e-d752-08d857269aee
X-MS-TrafficTypeDiagnostic: AT5PR8401MB1251:
X-Microsoft-Antispam-PRVS: <AT5PR8401MB12517EEE30C8FAD400354DA9F2250@AT5PR8401MB1251.NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQOULvBKXnGCuNtWSAJr9CXd9taMhYctk9S9gvVCrsO7Fn+LTgEPgWudAkWhh4vhWI3zvYABZ/A+IsBJZqHeWggXXVO7UqznTrdLcSkyAStWispzDzvJOzG6orYGUsSaGjmHAzJdLgfaWzvzTJZx2mgn+qREmzS+zlboBUh3QHLiCG91Wecy9W/OFQMhYWscw08gfuaRk9BBGjBslQx8EylCNV+TQm5DxNQTfbl1C+QVAo7Ish5IMgda2L5aEYtxLhH6tPs+S699vGpH2Am67BFD8BJ6xTjWV5vceCHYVhvP8RZwSsaIm9zu3zrnGWknCRtH4kx5SXoS1DXFFjG5CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AT5PR8401MB0803.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(54906003)(53546011)(83380400001)(478600001)(55236004)(2906002)(52116002)(16576012)(8676002)(66946007)(66476007)(66556008)(9686003)(5660300002)(33656002)(6916009)(2616005)(956004)(36756003)(6666004)(186003)(16526019)(26005)(8936002)(6486002)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Axc2ya0D+Yr6Jf0ZRaTZA/z0AIzvnVlMynUu1mL0XHYrEjlvM1GiTc83WeOTkzN8L4Pe6DaheiFmkdWrNzMeJ5LPRy6tK5rcpxzd0XCVGLQbkaj20fUqBwSCiiQClga376Em9wRI1QbvkochZ+0Niy3aTEyQ4C8J69RiThgKnEptak7a4+a0UtJJt8H20SSpfe/L2XwXLw9NerIV3Y+DdV6DdylCP7tSdeCHe648tEU6cGnO97Du+Mz1HmzOwQCKzZy8hC7SZ/f1ZzmVXsBMhpZxrw54pF0h8RcVzd0//vj5rvLL3RCZV1PcfGEBbJpVU5wIbwweiNhq/djuudqNr4IhSNxztS9qpf7uyL0aU6pUJgHqSxnkpzH8bUYM/vf+Pob1T/DtQexoTBvjilVEGG/uBmeTA0aybEflG3g6d4HYb9C6ot7SAtiMv+kdNhVsg2eu30SdM8W6BQ/unoBVI9MBmUUluejB8qLe6GCLZGTR0FEK+qhKb7JTDKbwcepJ/5KZgylpMEpWQOn/emrDSe7dcno1TvT1/OWTZvIs5IOccxOeQAAfMtPc77eRsKmMgSv7pfo/niAaBrcpEmy4k9lviQOv76VkhhfAfB5z2uXGueUddgr53VEUcrbgp+/R0f5XQ5V3mr2c4hxNk5mxIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b41f76f9-d6c6-403e-d752-08d857269aee
X-MS-Exchange-CrossTenant-AuthSource: AT5PR8401MB0803.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2020 14:17:39.6221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkseoltRhpkGK8Cl14dZkrjZit+3qIOgZTu20TrM2pbZKSpwguJ4QxswcH0o/jDB6OMW2jl4IZYboCbrO3R//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1251
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-12_06:2020-09-10,2020-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011 suspectscore=2
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009120137
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello everyone,

Dear Hao,

The first aim of the patch you mentioned is not to shorten TPM timings,=20
as no
timing is changed at all on this patch, but to count time more=20
accurately.

If your TPM needs more time to perform a specific operation, it has=20
nothing to
do with this patch, but rather with its specified timings in the=20
kernel. The
timings for your Atmel TPM were certainly wrong before 4.14 to begin=20
with, they
were not counted accurately and your TPM working was potentially a=20
"positive"
side effect of the imprecise time counting (ie non-specified delays=20
were added
every time msleep was used instead of usleep_range).
TPM polling should not be affected because we use a different way to=20
count
timings in the kernel.

If you see issues with your Atmel TPM, I'd suggest to make the changes=20
in the
tpm_atmel code only (tpm_infineon would be a suitable example to look=20
at) and
discuss the timing values with Atmel TPMs experts, but reverting this=20
patch and
affecting all the other TPMs seems like a misunderstanding.

Thanks,
Hamza ATTAK.

On Sat, Sep 12, 2020 at 10:14, Paul Menzel <pmenzel@molgen.mpg.de>=20
wrote:
> Dear Hao,
>=20
>=20
> Thank you for the reply.
>=20
> Am 12.09.20 um 10:10 schrieb Hao Wu:
>=20
>> Thanks for quick responses over this report.
>=20
> Thank you for the quick follow-up.
>=20
>>> Hao, I wouldn=FFt expect a longer timeout causing the TPM to be
>>> queried less frequently, but I do not know the code well.
>> From our understanding, the TPM queries might be retried due to some
>> reason, increase timeout 3x would lower the query frequency to 1/3.
>> The explanation might be wrong, but the fact looks like the timeout
>> matters.  Unfortunately, engineers from Rubrik are not experts over
>> the TPM driver code neither :(
>>=20
>>>> Be careful about making this a global change.  It could reduce
>>>> the TPM performance by 3x. We don't want to affect all TPMs to
>>>> fix a bug in an old TPM 1.2 chip from one vendor.
>>>=20
>>> Linux has a no regression policy, so the performance penalty
>>> wouldn=FFt matter. Unfortunately, the regression was only noticed
>>> several years after being introduced in Linux v4.14-rc2.
>>=20
>> So does that mean we are good to apply the global change ? Or we need
>> to discuss about the actual fix further?
> To get a fix into the stable series, it first needs to be applied to=20
> the master branch. I guess you tested also with Linux master, right?
>=20
> Please add the explanation from your email to Greg into the git=20
> commit message, format the patch with `git format-patch -1 -o=20
> outgoing` and send it with `git send-email outgoing/*` to the=20
> addresses listed for the subsystem in `MAINTAINERS` and the people=20
> listed in the commit introducing the regression.
>=20
> Then it can be properly reviewed and discussed.
>=20
>=20
> Kind regards,
>=20
> Paul


