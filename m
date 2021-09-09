Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9E405C8C
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 20:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbhIISFs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 14:05:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46034 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234493AbhIISFs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 14:05:48 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189HiAVt024931;
        Thu, 9 Sep 2021 18:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=WakdN0Otp3Z6T3yq3lPqAuc0lF2tt+1ruxmRGl/EeME=;
 b=aCiTq/qgO8oSmFBFHk5Un6Rk9BFOzj3MeD8tebjzW7rFrhzguK7VKi5H25BoXA/YmvtL
 QD+OTBiWnNEagDeai+uhMP81/TMT4uFauyYGqVu6uXMdj0ytdL2589lsv278qsWli/0t
 kGSBTyktiaajU+0dUGdBxRLiBovfYngZ0r/H4rrGchdICNrRI6nfQAyclDrUB9Ga/mT5
 JAMs8Fe8+2p2nkh+iWiO3tzRXrPMogatNym+z23gx2SQBVt8j+iziWdu3mG8rV6gmwNG
 ZdARXceS7dHvbpEn01M2moAEfynzAOnrrhcP4F623XxTUJ3EDxeIKONYzjZNZhyaaU41 oA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=WakdN0Otp3Z6T3yq3lPqAuc0lF2tt+1ruxmRGl/EeME=;
 b=JfyzqejUzp90g6mbozROUUe1wU/fj1y1jIPj1K1Q8admQBK4YL6kgL18aC13IXSt5Z6A
 dXzmetEAT3NdSVvJusvw7JfeN8sfZkZXYGeVys6ZPdkEy6KWaeAn++DVTKCzavL9zsxG
 qzQlbrBF6DzjIZKPkoF0LgjnTBfQlUWJ7PrrH/qq3HMiqJOCjNmDAXQEGpyXzd0zlesW
 sSXcwlg2h/miXPhCfszJfwWgrgy/LzCamleHat+vtevGHMD9d62rkwBjMkYlnnPZWzkx
 UkFpBBhh6C/G1VLTFVlyRO3MoczM9IarHMnEIBbKxETh/aOJIUxDaIgjR2kSBTXMrIDT 5A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ayfrpsfaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 18:04:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189Ht9uF176344;
        Thu, 9 Sep 2021 18:04:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 3axcq3bfpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 18:04:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjaMVqugnQ6PeCwbI8qZCCBrMCDJICvorF/knUJdcB4HXP9n93YWgyQ+/cRj5+N2Sx7OJrJylEG0aBOrF3RU86AyoBwUs3rwnqO7nf0ZbLJ+z7P75Cw8fCj4tKVJ17HIyGRRFcOCUbEACMaxsiD2M8V4vwoIyv1HQ7UGxz+LbIp69kuodNdKLlD8581j98HC/i1Zk/DjKrF5/uR4eAEOiBuHKBuzJK6CKYcszodUCPZCQ6DeHpmbbwQD3S3d5/xXK/a2w6l72BWyVWLSjOZzudZZDIJHGVh/gd9jO/IyRVAtwunJt9KVrOdFbiKbvL/XfDKnf10KdNGFoHndxtLIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WakdN0Otp3Z6T3yq3lPqAuc0lF2tt+1ruxmRGl/EeME=;
 b=bgOPt1rSpghrDsQmo7lgv5OavGkEeOPzq4rPM/UcTNuZAT4XxaAbkP0zloU9WxZw4LCloWbWsdH1IUVKYrdGRFBsy+VGYsyzLmtiCheqKQc2DzbrPmrIhR1ATMnPlomQVTmP6yBLJw90dVO7grp4sZ84EQrl68v6pF0Do/DlgPR+sXzOEQ5+ytXnGi80QHutZ3gKXvJhWii7k3WzvfjqEOwNPA2kmg89heKUMgfu34LROVCtfxz11G/cX4svaH339vGHh5CFp2DZNA3K1NdtX8+bfyXAYva14V3C5nPQKYZTwKNMK217lHC13Rc8GVmRF88lfyrhlqX17VwQd6d/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WakdN0Otp3Z6T3yq3lPqAuc0lF2tt+1ruxmRGl/EeME=;
 b=uuUQDITkULJXbGXVP3kxyp+3VrFwvHpsk4gr9AGHX/vE8LHEBZuIxMGGjU0EWS9FpsAD0Ufo+qOJI4uRdCHaqBnW3+zhilHxDcsGNPuF0VIdiIvEJWXzjQEuOh8EvXdWoNXaOXCJIIJtkx7Dm7o3NIfjrfCc1HRqX4aYAs1By5w=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4857.namprd10.prod.outlook.com (2603:10b6:610:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 18:04:11 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 18:04:11 +0000
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH v5 07/12] KEYS: Introduce link restriction to include
 builtin, secondary and machine keys
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <b8ba9facf525c60760b49da6cea50d701ad5613d.camel@linux.ibm.com>
Date:   Thu, 9 Sep 2021 12:03:58 -0600
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
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6BD395AE-2549-4E33-8F4F-34B3BDB0649A@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
 <20210907160110.2699645-8-eric.snowberg@oracle.com>
 <b8ba9facf525c60760b49da6cea50d701ad5613d.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:91:8000::70a] (2606:b400:8024:1010::17c6) by SJ0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:2c0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Thu, 9 Sep 2021 18:04:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2bf3039-2f08-48b2-8ec6-08d973bc39b7
X-MS-TrafficTypeDiagnostic: CH0PR10MB4857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB485713852AABEB3571541F6C87D59@CH0PR10MB4857.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vClP9aqWSQfUYpHsQLS5JgwiRlFuHIqacEHdCA4lEOJIqeyp7kFjBwQLyKleYQ5NFTif9mg4MEFkavaROg8h4REqoU5kldNln2Jh5WB0rbrQuGKWsbKOjgnF+/PntC1uUPIhUWp7G2tsMneQfwj3/9Vd7O2PiGgf8I5UpD0k3oMqD2upYrc+xpsNy+KrfeE1tpfJ7/Yq5GiMV6TB8oRN7QJsGPRWIakdp3bgTP/MHxNpPSOm944UyVUEBNvxg6QEoD5kcaM9ya0ZLBLmNjT0mEVuOH5jL6pqDKjmHjgs4WujnNcAA2Y6lXmfQqyXq1luz85h9bEujStTKsLQDpEpwadBrxwStwlQKPCYDoBSAbFWhgzUyi2Wdwy/ER+3gHGnWaJh9MpVJu+U2Tx+Rf0M9s1nkzYkThTaOIqJ0bYxWL/ZpiDgUgf5n9US9wXP0TkchlTN7XNXDA5OFkNACg2gdxyZKAbDo7fMAavIFjjNtNethr6gyFTmDJeBQ3eupK2XWwd9aFmJvwjtVeTRAf/Q9EWHaseLUWjMm+EIBW7XyoA1GNNWCb2P3/C3FUR1rK5WjbbcFRIP5M1nHnE9ihRWfM8y3XIpsI3DIE2Jb9MLk+220RYwBDQNqxva9ZR9aPhdZwYaekwvLJbeXqcr5UChxwpti+yHlAprX8u5hpcJZjj/Woa5iMB7IqkQraZOeh3ywRwWGAwFFc6zyCYNugNX1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(66946007)(66476007)(53546011)(8936002)(6666004)(107886003)(66556008)(2616005)(186003)(6486002)(52116002)(316002)(38100700002)(6916009)(2906002)(54906003)(44832011)(4326008)(36756003)(508600001)(86362001)(33656002)(7416002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qDY76nrjFS3pjodntc+HWt99eRQ2868wBu4+d+TRk4zaZKROo/WUXLHLLekV?=
 =?us-ascii?Q?Xuxmzoey5Zae/ka6Lpdu5MPrha4GuTVnLS3fVKB1bI4lW5UOvwRzr9usjdAm?=
 =?us-ascii?Q?Ln79xHZ2H3WUCUEQLO/BvfAmIGzCD5AlA39KmH5N9SYiuTeKMhzmnpmyKnIT?=
 =?us-ascii?Q?Lc765Om2diyhwwRLi5E4tyiN4esolRh8tRc3ZmQD5Ui3sRQbZrfinrATSrPy?=
 =?us-ascii?Q?Sul0/9dO0oxgvKpG6MX9TRe7fuu/VV5Gzis0a52bq5BYyP6yXIW3V7Y+STXj?=
 =?us-ascii?Q?WxxiSS+k9J/voaCEC8t8xwLtq9rM8tI9DWIqCq/AdzwhcbyPhyboBj0e6n0S?=
 =?us-ascii?Q?7OeXnIo4twsT0mlnxfmC93v0VL4eSNA3V74vxWtemFvO2+JT3mMlz27Gf0Q4?=
 =?us-ascii?Q?EaYz87xAm1N1sA7N2Lr3BJj8QIgMg33PyLf9GXg+PGei89VrvYwthXX54tM+?=
 =?us-ascii?Q?QNqpdYC20BmGXzYtNK9foL1OC/gN8JOfqSsg1rLrLomElcD202KNlGtPGLaG?=
 =?us-ascii?Q?kbzXpKE5Fmjug2uIAwIcWrETlNMCExYyfmM8IqkbYQwvXNlBUZTFPwQkc4Hc?=
 =?us-ascii?Q?7ydArpjA1W2Ct0TgXVyqiiD/du+v+Gb7SsmQPgnLmCRTAbAIroPpj9JZnV5U?=
 =?us-ascii?Q?i/aGOUr/B3WtrJMZk50l5jq+bPq0IZar5++WmvmpgYp5IyD8fF5f+itNRGzc?=
 =?us-ascii?Q?0L3WlWVvxay6HiNAnu+qNmmOOZp4kWKHqiE41XHopxCQGrdTwSAnsxHR9i34?=
 =?us-ascii?Q?jHMVZQvvQv5cKWznLEr+mFfyD0FklRSt0ZvBLHLJyg9WpUeNmo4fKK/INSl9?=
 =?us-ascii?Q?OemIHNRSERsvV8h8OPJrW3IQaCwhiGrUe3Xjl+X7CHAXo9UqdB6DQQicEPFU?=
 =?us-ascii?Q?fcMQRh7OjMoPpqIUrJbEgmcz/tiwHnhYkQ4f3AFhYUieC0UtzJARWGMydwS1?=
 =?us-ascii?Q?63R9fLMKjnYrZhOFnI96/E+03UIIajOpuPiEgKPgi7O5lhZIc+jmZmWkOKcK?=
 =?us-ascii?Q?kKAHC2RY114JMqzSUqS0pFY+KgWZjBHR1Df5tkdUfFfGUS9geagkHRq3APxu?=
 =?us-ascii?Q?b2o/2FglA+rmYs2GxdpOSEycMTlCM0KoUHkxquUw9kGi0tQBo27K44tbWLlK?=
 =?us-ascii?Q?iLy9GLQdtEXEJnqXJqzGYDeJ54xcGPK0DvAoeT2efbAohegaNSpiFHk8waBP?=
 =?us-ascii?Q?DpmU/831k+NcpKI/+QCxyCgDNsrd99FtsBY0tgyOV+81jbmgNKw3dtmT8ZYp?=
 =?us-ascii?Q?V0dKmK2WUF+0TqrDnYzc2BIifYyvwq3kYKRlFKZcVrt31e1yEMWcB2osSJIO?=
 =?us-ascii?Q?Eg3+k8ZZeZZsy5OSnnIZG2mtC7V3Ow7UCV0sJSoqD5PZDA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bf3039-2f08-48b2-8ec6-08d973bc39b7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 18:04:11.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3tnOIKBd+nMz9FgSugDFX20yWDnfVya9gC91QY2EUBLpVVn1hygIRtK153KAgfwglss+t0kjhT9NbUvW0CEjYGP1bXsxo1VZX75mCOubIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4857
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090109
X-Proofpoint-GUID: zCJYT9VWCxcWey2pueBKeH46QIBXRYEl
X-Proofpoint-ORIG-GUID: zCJYT9VWCxcWey2pueBKeH46QIBXRYEl
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 9, 2021, at 11:26 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> Hi Eric,
>=20
> The subject line above is too long.   According to
> Documentation/process/submitting-patches.rst the "the ``summary`` must
> be no more than 70-75 characters".
>=20
> On Tue, 2021-09-07 at 12:01 -0400, Eric Snowberg wrote:
>> Introduce a new link restriction that includes the trusted builtin,
>> secondary and machine keys. The restriction is based on the key to be ad=
ded
>> being vouched for by a key in any of these three keyrings.
>>=20
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>> ---
>> v3: Initial version
>> v4: moved code under CONFIG_INTEGRITY_MOK_KEYRING
>> v5: Rename to machine keyring
>> ---
>> certs/system_keyring.c        | 23 +++++++++++++++++++++++
>> include/keys/system_keyring.h |  6 ++++++
>> 2 files changed, 29 insertions(+)
>>=20
>> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
>> index 08ea542c8096..955bd57815f4 100644
>> --- a/certs/system_keyring.c
>> +++ b/certs/system_keyring.c
>> @@ -99,6 +99,29 @@ void __init set_machine_trusted_keys(struct key *keyr=
ing)
>> {
>> 	machine_trusted_keys =3D keyring;
>> }
>> +
>> +/**
>> + * restrict_link_by_builtin_secondary_and_ca_trusted
>=20
> Sorry for the patch churn.  With the keyring name change to ".machine",
> the restriction name should also reflect this change.

Yes, I can change that. Should it be renamed to=20
restrict_link_by_builtin_secondary_and_machine_trusted? That seems a little
long though.  Thanks.


