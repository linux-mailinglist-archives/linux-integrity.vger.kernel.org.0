Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF10F3EACEC
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 00:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbhHLWLl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 18:11:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29484 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230089AbhHLWLj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 18:11:39 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CLvgXm010194;
        Thu, 12 Aug 2021 22:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=0Mucst0+2NcPe+pPNJvxKAf0ahHJGJ72JZahV/4x2Pc=;
 b=BvSnKzXCSBkKME+Cf0nyjgAED5jDp9720UVxwiA7MPrxf+EQ2oxk4H+uoIrLhfyeoOFo
 L2oszecgAyVLe3uJhEzoKpDcI/95JbiTS+2N6vpRXw35/nSsHAexrNuGcwiTMHJeHt4B
 H4bi8E7j19AQKvmxXqeqOgxC/89qxYG4/vf1ApbFDf+F2+lQz1Mrv831iX+H9GQSljcG
 q1oxpWvAIqg1XsM5BXL8wTyDHBWy8UY5Knjj9FA/Mx/xafgbpF3fueoAqNkbtSPQt7fu
 ILtpgLROJWp1iHFFT/WagqdJg5HGlazUTiT7jbz85S1f8Hh5L+1OrhUNUFv3ca8WGhO4 Tw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=0Mucst0+2NcPe+pPNJvxKAf0ahHJGJ72JZahV/4x2Pc=;
 b=R5ckXqN89QMr20w/zVvc1otoox767FxKBK7jKNuXP2+q2VdK8pBdyeaQ3+uHyXB5OnzU
 UAOTNRqLPfuzMaF4C5B1Gys+56s4n63PbnGY4/zHBuaRRuctihlw9sd2oLEyTVx56Znb
 N/dbHXkYKpefPEY7ETrDT+BT+Y3+y0F1P2bSbFD0GfGiDzEX9yvAnyA5HOmvJjLasQZR
 MvdoHW63IHB/WM9zXo+E0mnFBZFQ3eUbEyt5lLpDfx1q8ZCEmaCHHhh0KPpX0WzLwSSw
 qnybk1fz/2GZFG1TUL6vwa4mnJ8G8Mi/GoS7PlanB9e08N74YpDMQuwi7SDCxJPElpF7 Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acb7a4gen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 22:10:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17CLuUdS083184;
        Thu, 12 Aug 2021 22:10:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3030.oracle.com with ESMTP id 3abjw9d8j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 22:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGNDm9TIakmrWwbz60mWUEe5I2HewgQOuqUd/iEJdKQKLJZSxP//V+BLHFGGXZxsYi2DtP2ZiMT2PvrN6GbrvhHDMekMlhVtYofgAAFkl4jH2/94fOEfRMYpEreP8v2TsdzYOI9lS3FvocbGki+St4LsbiwhT2DnUkwG0d/tFm9VEtI6zoDuTM4pQYH40LpRphJwg17h9eua9PzNa9y1uhBG1dSfsl0yTGkJGlJJBNHwuwN4ARoVTuqh0TBQPiajTfdeDLY66yG6PFPJAmsgYzhaa22o53cpzS1r/Yzed7Om1eI8Ggd2dHWm+ejFGaJaCrlAif2exAJWFpbnY96vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Mucst0+2NcPe+pPNJvxKAf0ahHJGJ72JZahV/4x2Pc=;
 b=K/AjZZE7jXR309lTxU+2OABf+1uvfFmbrN10Z8dEPr06ap0PS0jnEAbVXx8WfSOubafYcfnhuo3tdD7F0UXju7L9zrgr5auWOR9LIkdeX2CsG5EnelXxSil05IQhpXCg8Zo7xY7gCczvMPqXmkK4GofAsrsNcYcdAKjSSp45JrnyFH6EVmAhr6lgobzoaWuKMjohP7HknmbyhDwQKx8+WYndoRIbu0J2I05mbbFzKWP8I5z6kT/mjzvCkssR59Z/qtX3waDC6PQGCXl+qoGu4C0MzQHGkfZRRn1mtisGX6tpugC1D6P7edyWAqFoxtBWWaNM2tJMJgvl4Y8SffIExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Mucst0+2NcPe+pPNJvxKAf0ahHJGJ72JZahV/4x2Pc=;
 b=YNRPO173DIbMNjSCinRcu0GUu2rBRUmYczWnZ14E+MMTcQcqEG15JjYN5DBxBlxKLrU02h/zyZ7MGJCpS5buM0CCg1hCoUI1sPJBR3vWdnfKxuhM/9io1AWB9I8H0P1V1ZaRbTM383p2Y1gOuDJu3Ojr3yvwKBTGN8bH8M4SIbM=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5164.namprd10.prod.outlook.com (2603:10b6:610:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 22:10:45 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 22:10:45 +0000
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH v3 10/14] KEYS: change link restriction for secondary to
 also trust mok
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <58e6e03b69b8fadfb854669086020c633837be88.camel@linux.ibm.com>
Date:   Thu, 12 Aug 2021 16:10:35 -0600
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
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F792F96B-C482-4F28-A984-A6B5F49C3A56@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
 <20210812021855.3083178-11-eric.snowberg@oracle.com>
 <58e6e03b69b8fadfb854669086020c633837be88.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SA9PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:806:a7::35) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:92:8000::196] (2606:b400:8024:1010::17c6) by SA9PR10CA0030.namprd10.prod.outlook.com (2603:10b6:806:a7::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 22:10:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97e403a4-7b78-4cfb-7899-08d95dde084c
X-MS-TrafficTypeDiagnostic: CH0PR10MB5164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5164CA756B533C57F3A37B3687F99@CH0PR10MB5164.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2yJltKRIk6x+PCRq8+cbA8Trk9VW74gVRGOnJJ48Om+q8baEbh+0k0aO/o4o6IVTZyDRVzTh/Xkpsk3aDAlLKoLW468bStfAqz3zDghChnCROjx/0nWsCvFwavTrfd6rvEA4OdhBTACU1ejkj5Q2TW79rNjhFJZHUs6HcZP4OHpYnAI/XPgbUI8jMmTawQ2oUdpu0Rc7CSFnlj5qr6gjXgtYUSqsLU8zoveNebCsj/DPhI4x08MBwOhoMULzcBiSC+mAeXBkI5/RR47d5JZ5NbKz3IvtcNoWQ2ncwWPguvuBVrzos/y3I8ZIwbsZ0qRjhsm19/8lfIVmEy9rg1tvMo4ROUkXbqaiaQxoLyqLDwsOFFEMAZPEe5RhhDETHBeL+QFhtsiaAlj9fBHHSR2u/QQglQQ+Bqw5aA+ef+pvRZ9v7Wk/bksz5zuijXLRsc6L0r6CrOYH5Yso2uo7zXwdE9NcAKfLlvBZGu2RpIYl8UQ15++eYzwZWHr2tznF56pq+eSLpmxax7Pe+DLg5yVzd1SRE0Q8pcqjCE1Hnr8gueX2frD+1cjLfGzuZC096l3xkiWAiHVdbZhGfw1W2ChjUHrUI3lzAVcTJziTccMCIXYjKa4U+VTURoGO5y2sXN00o4Ya6FZOdVZJmbr01uPIGbM6xtWu9dGAC2dlMSi1yo8nScGV+NRd2vQhCXFQ5mYmsIOOoHiTeFVY7VWssFIjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39860400002)(366004)(396003)(83380400001)(66476007)(66556008)(66946007)(107886003)(86362001)(2906002)(44832011)(6486002)(36756003)(33656002)(2616005)(8936002)(8676002)(5660300002)(7416002)(478600001)(38100700002)(4326008)(52116002)(316002)(6666004)(186003)(53546011)(6916009)(54906003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/lX1PKFQW0jZN5brGErxRPusoz+UKNDN8pGK9KYZRLz4nNiE4FZgygo2IQ/A?=
 =?us-ascii?Q?chm7Oq3o5X8w3LIcXFhPFuQouIgBt3RMaNgFQ485S7+7Ozi+ASv46oWsllhw?=
 =?us-ascii?Q?uyl8grFvSJmi0V9qhSZo9DNWOhKSjYmt7eNa0UQo0KmHY3nVzwmYoixYkKXf?=
 =?us-ascii?Q?JcRRbcUPmhbRNYQCbABB/qYZ0kVb2gGMxMoR6s4uL4Ets/QA3GsrM5j1CPN7?=
 =?us-ascii?Q?5xvClu+NGpRCTakI7O6rVd0qjSSp3AiJbb3VEJ7oTRho9ErWFSSJmsu3HXPe?=
 =?us-ascii?Q?5giRXTMx2c5GaNojP+ub2smkAQ1895winpRuhyAYmHoV0CWEDgqXI2FR6PNm?=
 =?us-ascii?Q?/TABVrAQVI9jDwsJojiDEKFKP2QPbvpj+1QjZzWP/Al03qdqopPeHIN4YvKA?=
 =?us-ascii?Q?HK/nfxhVTwyCJ3u2HKr2HmDBq6TZnbgqiJm27AC8jQZFNOMg4HBA0nq9YtBe?=
 =?us-ascii?Q?lvMBjUpA1hOq0qmQGPime3yXF/O1oy3i4R7fOnjpn6za1lQzuxbcbqZSTc7v?=
 =?us-ascii?Q?dY0GqKjHVS2arNwETj1HD5xWowoC0PYIDwdXcNWhSJbGapaBzKjpeaILJYlM?=
 =?us-ascii?Q?l/QTIXltu7LKBg6YfExogUV+QMThcQKIv8W+rTKrqzSMeqsslDgK0SqCiFWd?=
 =?us-ascii?Q?gaFvsFltuwMDqn7m3iNJPG8OV7yY0R66g77AVHaNAqlT90q0dtENpsSwFIxN?=
 =?us-ascii?Q?EfNPY0fs8vT+PpzgVb0dmsv0goaPlcJ/Vdtiob9l3QptbmkZOPsUAB44ji7B?=
 =?us-ascii?Q?Bz1Cp6lk2/a2OvYCaKOnHdvyEFtl6NX1mgGSLU2wgzk4yFIZNq3oQST6Bs1q?=
 =?us-ascii?Q?uP407iPFAUiRKe4WO9j1DPl3hX5nqjoCcQCSLlbclD7G26pcc9WaKw0vixIn?=
 =?us-ascii?Q?/8P69N+ZMW7Ppc560a4xCnCz1A0Sho2Rs16cDTjJof0Ne7mk/LNYeFW/YRUB?=
 =?us-ascii?Q?8p9VHBptz7owqi0dFL4fc+z1+PCcQtXMj71ZMuzagv3UnxdILIuuabQdeYjJ?=
 =?us-ascii?Q?sdQWySeIDajvlgewyxCcRoUctXj2vkT2JSS8dLvNKFZr7kmAAgJMiRcZB3SI?=
 =?us-ascii?Q?sgqR8Pi2/zpHy0fZVCAxKzUscYhFC0Jzx2999/cE/+t26KieYiehuOMiKqkk?=
 =?us-ascii?Q?oY8VcmG7SX/e3L0mRNR9mNh1HIjh5EfZRLU8Z+eYkbxirEtVWlPDQkeSeUm7?=
 =?us-ascii?Q?B5XhaS9KZQm3t04BHc1TCpX6EIajRo1mW382XJxKVsVe/YIJbTUHSnvtOhM5?=
 =?us-ascii?Q?N8CE8ruumoZyPozTtBU9jqKFWQaD7rknoicubqlLrW2AfRzzHLxSwvaN3D32?=
 =?us-ascii?Q?SHKRhtYB5gjFi2BFf5/B13nGj4/XEhLmlyZJJl9MpkPvUxHgXZJObUV0A5ma?=
 =?us-ascii?Q?20ozxfw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e403a4-7b78-4cfb-7899-08d95dde084c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 22:10:45.4471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHU760AsDbpPtxAb6yCdbyKEwG1XdyFPZnnvzINTZu/iYMwgVdXGwEoUXkdDe97b4Ykx/6yAsA+Dw/pndp1fK0rc2ZCrL4rkm6eBwcTRyz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5164
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120140
X-Proofpoint-GUID: tIYnotgIq4MQWe35awJy_oW8vKSL6Mj7
X-Proofpoint-ORIG-GUID: tIYnotgIq4MQWe35awJy_oW8vKSL6Mj7
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 12, 2021, at 1:46 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> Hi Eric,
>=20
> On Wed, 2021-08-11 at 22:18 -0400, Eric Snowberg wrote:
>> With the introduction of the mok keyring, the end-user may choose to
>> trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
>> trust them, the .mok keyring will contain these keys.  If not, the mok
>> keyring will always be empty.  Update the restriction check to allow the
>> secondary trusted keyring to also trust mok keys.
>>=20
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>> ---
>> v3: Initial version
>> ---
>> certs/system_keyring.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
>> index cb773e09ea67..8cc19a1ff051 100644
>> --- a/certs/system_keyring.c
>> +++ b/certs/system_keyring.c
>> @@ -110,7 +110,7 @@ static __init struct key_restriction *get_builtin_an=
d_secondary_restriction(void
>> 	if (!restriction)
>> 		panic("Can't allocate secondary trusted keyring restriction\n");
>>=20
>> -	restriction->check =3D restrict_link_by_builtin_and_secondary_trusted;
>> +	restriction->check =3D restrict_link_by_builtin_secondary_and_ca_trust=
ed;
>>=20
>> 	return restriction;
>> }
>=20
> Not everyone needs to build a generic kernel, like the distros.  As
> previously discussed, not everyone is willing to trust the new MOK
> keyring nor the UEFI variable for enabling it.  For those environments,
> they should be able to totally disable the MOK keyring.
>=20
> Please define a Kconfig similar to "CONFIG_SECONDARY_TRUSTED_KEYRING"
> for MOK.  The "restriction" would be based on the new Kconfig being
> enabled.

Yes, I can add that.  Currently there is a Kconfig to enable the secondary=
=20
and another for IMA to trust the secondary.  Would you like to see two new=
=20
Kconfig options added?  One that allows the secondary to use the mok as a n=
ew=20
trust  source and another for IMA to trust the mok keyring.  Or a single Kc=
onfig=20
that handles both?  Thanks.

