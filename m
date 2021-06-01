Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06C2397684
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhFAP1A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 11:27:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48674 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233360AbhFAP1A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 11:27:00 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151FH58f003511;
        Tue, 1 Jun 2021 15:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=czma77i9OosPojyNxuP7mX2vUUId+mOmYYk7evd1BeE=;
 b=sRhGYqve94ykj2IQA/FZFMSpzb2AkyS9zjh4fGEOa76YO4tqoQSyyz9gUgyChc6n3faN
 +sCpFLSFCtpOA/osgZK+DzRKTgByuFL1B7JBGi/rJ0jdtUXKjNNFf+aSEf1uL1OOgyOv
 KlwI3Ke5sYngCvuYOSJ9Jnf0RzP1/aitU1E5pNCLDIhw6wnrEUDdn2VOmxwEgf9K+zad
 CuyqSgOh+MpHmH1Gl3sBY14nnboxdHsUbe/FJ05sD4Fn0OzzqMnONSyE36ba1sMY+exz
 NT9OkCAH9dT2yKp5uHm7aSYKEdnbnEZsmAsoYRXIGw2UtQdTgepxsVtu9t2p45+/mBnN JQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38vpk2gma3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 15:24:49 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 151FK1Kt138072;
        Tue, 1 Jun 2021 15:24:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3020.oracle.com with ESMTP id 38ude97e5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 15:24:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMK5rW/vgWFgtCvP1+GY2u50XdBjMmj6jxJ/Ot8KmEFEySVgjttk47m928fWHBmcBXcCAptOXELNj4+TukuV7v/WToUHlDKs71dE76/QctZ+fDldrl68MgMMKTrwDpPCiKWEimc2XLtWGoiRsf6uhGE3+8Nj8BI9Xp/7g+NuUIcEdaFzoSKw3Im76iKfCk+n6SRyIUCclCHkav816R6f9tapfd66LXoOeb0sGhm5qXAW6RKIvDwzYxU8QNU3RKwCdgJ0bH9lH/lbEQBFEcR1QeVDFl+bMTYlh2/IEUMcCUV5zc50ffEmdSmbFXnekTAijOsiyh+dPzzjyj9dyIbJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czma77i9OosPojyNxuP7mX2vUUId+mOmYYk7evd1BeE=;
 b=C4iFhb2YAF8BQZbW7hpMuO6kauN2YxknFv78HthqbZh8RZZkwy3qrS+/qlltLqbrN4J1z+bEz4JCeqLRj5jZpY2UTVKqXHeDbApgQWc2edDQ3dAxfYmM8E+J5eXssi6hZcqQLr9KgTbZZTlHYmFHLp0KVCP6ZLUza1Gq+nrUSHSvUFCm4Lx7W4vkZwh/4fcLEysLK0a8nSwLPqZE2SlaPmLFeA7mKM3jNkkDyZfUsR1JIFRGxJwA5IJdjSBqUyeFWx+yRHphtr93BEP5VNb8XI1q19xpVppniXJu5t4TVH+SuGrlP7S1GR6ttFB5zI8J0uOj+zlXciqiGJMCEpy5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czma77i9OosPojyNxuP7mX2vUUId+mOmYYk7evd1BeE=;
 b=VEro6JE8Ub+JKmBTX4CGmmdxYqV8NBxumPV1noeEG/NP+/lM2CmT8p/s9OxH77EfglhZ4/4+V9VRjTCQOhOFlSHEu6k/xnNfKGcbMIP0k4CO4DmhtTv+wqNkOoBjW4j6Bli/iQlEjpicg6ckislPYaeMfWDbH8xK0pjQ6KmrGDU=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5099.namprd10.prod.outlook.com (2603:10b6:610:ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 15:24:44 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 15:24:44 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC PATCH 0/3] Add additional MOK vars
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <7a51691adae4099c9d0e1b23e8edf5ce5535eb44.camel@linux.ibm.com>
Date:   Tue, 1 Jun 2021 09:24:39 -0600
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com, glin@suse.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1AA941B5-05C0-41D4-BC3E-AA68BB5810DB@oracle.com>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
 <fdb42621e7145ce81a34840cbcf0914874c78913.camel@linux.ibm.com>
 <7F861393-7971-43AB-A741-223B8A50FFA0@oracle.com>
 <c134ad45d924e8b719f8abb6d36b426b889e9394.camel@linux.ibm.com>
 <4A887886-BDB2-4F88-9D83-73B9BC9E641F@oracle.com>
 <fd0e91c43cf0dc14aeeda4e7095416c77df0d0cc.camel@linux.ibm.com>
 <7440CE7D-9630-44DB-8916-792523AC86E7@oracle.com>
 <7a51691adae4099c9d0e1b23e8edf5ce5535eb44.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>
X-Mailer: Apple Mail (2.3273)
X-Originating-IP: [24.52.35.144]
X-ClientProxiedBy: SN4PR0501CA0129.namprd05.prod.outlook.com
 (2603:10b6:803:42::46) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (24.52.35.144) by SN4PR0501CA0129.namprd05.prod.outlook.com (2603:10b6:803:42::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Tue, 1 Jun 2021 15:24:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c56c348-97e1-4e10-7ac2-08d925116229
X-MS-TrafficTypeDiagnostic: CH0PR10MB5099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5099FB5EE9CE0074A124238B873E9@CH0PR10MB5099.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpW1dw0h5rMM9tV4xY4N9WQt7QLvKb//Gtxc6XZ/t4tx4KlZq7pis6LlrGsk3jKz25Rx3CSNyDJVpT14vglhnMVu1JOo4fwppLYoPIpN46bnyzPCTm9AECG2OOLKU9Pr5BDw/M6YMXydu5QLcC+1pxRihE3KyMgyXeKfPskucJ//oJu8IhuU0u287hIpzSoUJDKTK6BO4GuuBk4ZXx5Qu1YvhEseIBpmE/4VhKEvmHmfIxJIgIPNadn1aSTf2nLQf+u1SABXbvnXCYAYwQU+lr1N3lVNi9+9WhBfGDJmvKMB5cmiu4ID/0TieRN4i55pD7RXKFJHKxJbCHjNrKJOKwk3exzLSRG6KwqebfbYsZXWh01Azd3fd0LePCuzlOHaE0JriqUswTtmJ+DflRNCAFXQwUzjTE2qZh2I+zprl4S7LzKDlxVtKzCvQjsw5MrHLg1IwEeo4BB9ccYj+DCTp7FY2FioqUBSh9r5gfIFRTmSkaxR9/Btdm+0VqLqd/sRB5slH5Njy31nsUdk3dcQL4Q9zDSeNbAQEXUS9fFDoOtU5zaFM8OU82y3Gzyu0IO12UPjLOrnRNkDXzPd0jQ4cTc3Q+A26ykTABdUoUgNDhiZVa1BFxUr0BpQrJYf3TzMaUO2OM/R3cHfz9NDYWZYX+A+FitxSE7R63XoY+21eWe13aw49CIAFT2iO+ur1UN/1C0BiOBMhh4ScT6nKBHWvxldAGVA8fc+nb8k9vokwKHxMJ3j12QwEA347veOZzjCENRHrLC/tSAu5JwOdydsKwCz1wbQGxAOQ/1OPP7w5tI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(136003)(39860400002)(44832011)(26005)(16526019)(2616005)(8676002)(38100700002)(33656002)(52116002)(83380400001)(956004)(107886003)(6486002)(186003)(86362001)(5660300002)(2906002)(110136005)(53546011)(54906003)(7416002)(6666004)(966005)(66476007)(66556008)(478600001)(8936002)(16576012)(38350700002)(36756003)(316002)(4326008)(66946007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dklYWnBha2RYRG5tTTJkdHNHK1B5bTV3MWtDbm4wOVIrTVBnWFIybEZrcncx?=
 =?utf-8?B?K1l0TTRmTDkySG9HRHI1UTMzaDFpRmFyd0s0K0FCSTI3YmVMOGNFWllCcHdO?=
 =?utf-8?B?cUtpaDVjRkpSOXYwcDlydHQwQitleGllWUdSc3VXbnJQejlvQ1UvdmIvenJy?=
 =?utf-8?B?cjYzSDM3akVzYjdYQ0tsajVyMzBkUWczNUY3YlhuTmFZaWpzNW9xSjNvanNI?=
 =?utf-8?B?a1J3OXVFT3pRYm11S21OSTQ5Ym9XVmp2ZlI3ZUVRWEF1bFBEWW5XU016SFha?=
 =?utf-8?B?RDAwYUtUM2FPR0w2K0VTT1A1L1ljRlhSZy9zd3VBck1jSzlab3ZmRU1idUdX?=
 =?utf-8?B?empUc2VtYmhyamlkRUJtUXpRcWdXT2dTUUhNTXk4cDBtc0NNRGtKSUw1cWpG?=
 =?utf-8?B?VmFyb204eHBSRjZkdVFEK3ZPWnJVM01SUnFIUi92U0s5Z2xNZm9JRVRQbVQ4?=
 =?utf-8?B?UE4xQW5nOXRuUjhWNGFIdU5lSjlTL0Uvb0RvODlyUVNMTzNvN0hDRXFDUzcr?=
 =?utf-8?B?RmhiYWQ4T284aVZrNE9SeHpSR0sxYjczUGdDZHRoTTVHRzZOUWtWUS9UK2l2?=
 =?utf-8?B?ZG9hajJnWDhhbEpXOGNYcHdVdlhCZllHcVYyanlDeld1bjg2MHVZSUdXYXRQ?=
 =?utf-8?B?K01kaUlGSTF0VEZPb0UxM0FFeDZmQmVaY3crWUphcW9zeHllcEJSVU1keDMr?=
 =?utf-8?B?ellGSUZ0TWJSMisxekhoT0ovODRwQXZSSHpaUGVEelRzUkVUZWJTS1Y1cE1I?=
 =?utf-8?B?TXZXd1p5VlU0R24wd21FYzZDc1VyVVhJVXF1RzRKVjkwWG1Na21KdFZNa0JB?=
 =?utf-8?B?TWdHM0wxNFdPbkl5amdlblplb1k1Kzg4VkRFT0Jjbms3WkZjb3FyRm5DWkFq?=
 =?utf-8?B?UFdFR25KbmZ6OW1VUlpwSnNVd29RR2M3Q0RYSU9lRnYrcnRIamhBRmxYUVN2?=
 =?utf-8?B?dTFBWE16RVFXRkVmVUR4L1piSWxTSU1RUFJOcnhlSmo4T1BpdVhlWnBmTjNu?=
 =?utf-8?B?NTEzWUV1REpTVURuU2NiTkplMVhTNTRuTzZ6WHF4TjV6QjNiUUtIRXVIT3Ft?=
 =?utf-8?B?Y1FyRUE0U1REVTQ0YWplelI1blZqWnJvM1NSeFNQOEFFVkttUVFKV0ZaRTQy?=
 =?utf-8?B?ajNIRXNaOVBYaHJxbWNVL1l6RHc2YXo5UWZZTnhlTENGQmFjWTRKcE15ZEh3?=
 =?utf-8?B?ZGgxVFZ4WkxmY0J3SmVLMFd3dzBZVyt3YlIwSXZOWHhxUHMySitkNEtCdUhm?=
 =?utf-8?B?QmZtazVUck50TWZmVjJFMEsrTk1MdlFTM2hRWjFEOW9saktBY1pKSXA1ejRw?=
 =?utf-8?B?L2RBRXZMV2c0YlJmVGRvWXdrSC9mVFAwdnNMOXh6UkpuTkQrNG5icC92YzFo?=
 =?utf-8?B?MVhISGd4TGU2R1pMSndmTjgvZkVYdnA4cmljY2NqVHZ6Qk50WlpVVFZsVndO?=
 =?utf-8?B?emk4TGQwdHVjMWxzWGRXT0RHT1dYNk9KckgrRTdYWCtpUHJER2tBcEFDZm9r?=
 =?utf-8?B?L1NFanVXbWlmY3RyYWdNeGZmSHd3Nkc5alRpTi9BTGpheW5NTUd3cWxVRlJl?=
 =?utf-8?B?dHNaaTIzTUlWZ04vTHBBOUptWWY1bUpyMnp6U0xvQmwzaVBmUHVPN1R0SEdW?=
 =?utf-8?B?a0JYTHp1eXMzbGNiTG9kbWozajEzeGlJdThNcHVtZWxSQlpVRG5qNWZKSlky?=
 =?utf-8?B?WVVDSkJRS0lSeVRERzlqSzRUUDc1N21oTUpHb1pSNFZnZ2FCMExpeExqeHJr?=
 =?utf-8?Q?l1Ymq1JVljK8EZII4aoVa2h9iofbmKRzqavZr+f?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c56c348-97e1-4e10-7ac2-08d925116229
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 15:24:44.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iPlvF3og0xpf6glW0NAZBJvpwe2G28Cvf2F9y0z2APaSUhEFRRvxjJ9xXUIXGHNLvN+RbLVI6g6CvnktYVyxN4xJaXTOOLPxoNZfmTGtXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5099
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10002 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010104
X-Proofpoint-GUID: XHn3hXXNP4SwjTZ4D8Z-19HvAGIewG_Q
X-Proofpoint-ORIG-GUID: XHn3hXXNP4SwjTZ4D8Z-19HvAGIewG_Q
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On May 24, 2021, at 5:12 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Sun, 2021-05-23 at 18:57 -0600, Eric Snowberg wrote:
>>> On May 21, 2021, at 5:44 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>=20
>>> On Thu, 2021-05-20 at 14:37 -0600, Eric Snowberg wrote:
>>>>> On May 20, 2021, at 6:22 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>=20
>>>>> I really do understand the need for extending the root of trust beyon=
d
>>>>> the builtin keys and allowing end user keys to be loaded onto a kerne=
l
>>>>> keyring, but it needs to be done safely.  The first step might includ=
e
>>>>> locally signing the MOK keys being loaded onto the secondary keyring
>>>>> and then somehow safely providing the local-CA key id to the kernel.
>>>>=20
>>>> If the machine owner and Linux distributor are independent of one anot=
her,
>>>> I don=E2=80=99t see how MOK key signing could work.  There wouldn=E2=
=80=99t be a way for
>>>> the kernel to verify the end-user supplied signed MOK key.  An end-use=
r=20
>>>> choosing a Linux distro is trusting the company/organization building =
the=20
>>>> kernel, but the trust doesn=E2=80=99t go the other way.  Do you have a=
 solution=20
>>>> in mind on how this would be possible? If you do, I=E2=80=99m happy to=
 move in
>>>> a different direction to solve this problem.
>>>=20
>>> We are working with the distros to address this problem.  The first
>>> attempt at extending the secondary keyring's root of trust relied on a
>>> TPM2 NV Index[1].
>>=20
>> Yes, I saw that patch.  I view (which could be a mistake on my part)=20
>> digital signature based IMA appraisal as an extension of a verified boot=
.=20
>> Once a TPM is introduced, it is an extension of a measured boot. It seem=
s=20
>> like this patch is using measured boot to solve a problem that exists on=
=20
>> the verified boot side. While it may be a good solution for someone usin=
g=20
>> both measured boot and verified boot at the same time, not all machines =
or=20
>> VMs contain a TPM.=20
>=20
> True, the TPM is used as part of measured boot, but that doesn't
> prevent it from being used in other capacities.  In this case the TPM2
> NV Index was used just to store a public key and safely used based on
> TPM 2.0 rules.
>=20
>>=20
>>> Using MOK is a possible alternative, if it can be done safely.
>>=20
>> I do want to point out, in case this was missed, when the new MOK variab=
le=20
>> is set to trust the platform keyring, PCR14 gets extended [1]. The UEFI =
BS=20
>> var MokTPKState is mirrored to a freshly created UEFI RT var called=20
>> MokTrustPlatform.   The contents are extended into PCR14. This happens e=
very=20
>> time the system boots. The UEFI RT var does not persist across reboots, =
it=20
>> is alway recreated by shim.  The same thing happens with keys in the MOK=
List.
>> Since the contents are mirrored, a key change can be detected on each bo=
ot.=20
>> This makes it possible to use attestation to see if the system was boote=
d=20
>> with the proper variables set. For someone using measured boot, would th=
is=20
>> satisfy the requirement of safely protecting the system from a MOK updat=
e?
>=20
> TPM based trusted keys can be sealed to a TPM PCR.  Only if the PCRs
> matched, is the private key unsealed.   In that case, measuring
> provides the trust for releasing the private key.  In this case, just
> measuring the UEFI MOK variable and key does not prevent an unknown
> public key from being loaded onto a keyring.   Once loaded it could be
> used to verify any signed code's signature.

Correct, it does not prevent an unknown public key from being loaded into=20
a keyring. Shim prevents unknown public keys from being added. Only the=20
machine owner with physical presence can make these changes.  All keys=20
shim loads into the MOKList get measured on each boot.

If an unknown public key could be loaded into MOK, shim could boot any=20
kernel signed with it as well.  This kernel could be changed to load=20
anything into the kernel keyring. So, I struggle to understand the=20
difference; isn=E2=80=99t this exactly the same threat?

If an end-user wanted to protect against either case, they would need=20
to construct a measured boot attestation policy that included PCR14 and=20
took the host out of service if the PCR values didn=E2=80=99t match up.


>>> For example, if the boot command line could be protected from modificat=
ion,
>>> the end-user could enroll a key in MOK and identify the specific MOK
>>> key on the boot command line[2].  The boot command line would then
>>> become an additional root of trust source.
>>>=20
>>> The root of trust for loading keys on the different trusted keyrings
>>> are self documenting -  restrict_link_by_builtin_trusted,
>>> restrict_link_by_builtin_and_secondary_trusted().  A new function would
>>> need to be defined to include the boot command line as a new or
>>> additional root of trust source.
>>=20
>>=20
>> [1] https://github.com/esnowberg/shim/commit/ee3961b503e7d39cae7412ddf4e=
8d6709d998e87#diff-b1dd148baf92edaddd15cc8cd768201114ed86d991502bc492a827c6=
6bbffb69R259

