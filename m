Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5603338B887
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 22:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhETUjq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 16:39:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58412 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234997AbhETUjp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 16:39:45 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14KKZj7l023711;
        Thu, 20 May 2021 20:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=yEIfWUCSQfIMmUUsXooy/R9si3kiUZYqYEZR7vEFb44=;
 b=rRhsvaVJjSjhv3OIhqZAjKILqkZJNY1DNeEL2+aFsztOs9/BJ0wsPa4T/dH3EFtfqfny
 RxNvdj2SBY2Rc1DqqYNcXGTqmp33veIeyiuUTNAhzFB7poI9vN30aYuDcbNeCgW8Lan7
 fbD/05FFtuwlOmjSDh69FGXr0hN6Z7pv9Oz6DGnTW0KbH4oKFYhZn6WvrtpmS8rimKkP
 QwRbacL40MQN9rLa85GQzp9i0dCjGBYReGtxo0maT3DCYaiKXYEESNXOzsFsShk6NGiW
 cVEfxLcF6lnY4D+MhPCSAXP3yfC3bniJWiHP+A4dF+sWHaWwoBfWOz0t4Gb+ZZtVb/Xt OA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n3dg0nfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 20:37:44 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14KKbhfU185919;
        Thu, 20 May 2021 20:37:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3020.oracle.com with ESMTP id 38nry0udek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 20:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5xTAeIVqjHUzXBYKoYYt1CbcW2jleaIFjGiFZI69wdN1Su3rKaKHYMBqysTPVuiMHYf9Gp0cptx3TEHTxWCBcjfr1jWWiToAE7HTDhPYZH4/bgOvZH4i8G78sexq6cxnRBiiJqmi1S1HBxAciocuGI7gRC2tpnMTbHSjZed2ol58p681WKa0e+7yebsdLCcbj1udnBvjFo1UKSjYt+TpJw2v5/9Nlmvsr3TCjDelCP2bY5mLoV76aXnY+VFVsxVPtu3w7oQM1N0tiIvf32h65Lvn92xBU1aBCtC770848ezCaBu5r6SNNmHFAl2KdnVn2PfCLNQ3k2cWw5EDbJnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEIfWUCSQfIMmUUsXooy/R9si3kiUZYqYEZR7vEFb44=;
 b=e/ZMmhXvC2Gvc87c3WSINoPUGBIc+hybCOb3zstqI6vfbRH83efJUxgyl2P+sXOuRCaX0tVVotPFD25/0/ti1somUXpqSg6LhA5SN0scBSggXULMu51R5X+ftgmOOYJoskMvoGeTAbVJbODwt7L5li9owbTZ0yVz+Pvn66nOjpg+0wrzDJ4VWqAU1LX6bQBA/Cc58LY0kClnAUhQsjWrlDv49wYMplB/69bdu3ZCTyOoVdS7MdfQLJp9UI6zVa2rzHgm8APp0+pldHTsYz9sSyVXdnubJw9VpXjG9fbkcFkSyf17WlCfwgHxLEURqBBsGKRGVSmjRAcM4NBEi0cckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEIfWUCSQfIMmUUsXooy/R9si3kiUZYqYEZR7vEFb44=;
 b=aEYWLBg/9WH1o27umWhW83HRkn/UAIjk4FQ/Q1KEvYzUTQdL/gxxfounYOJwee7aLxAx/y7lMr72DswiZyYMFsA2NX9Pzq3aYmsuz2L8fICJkMG0wqjrukhupTRyR0FIQ1pjddm9+kw8Dg7WzjLMMfacqDUmSVGyE9LCzrrVD8U=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4181.namprd10.prod.outlook.com (2603:10b6:610:ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 20:37:40 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%6]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 20:37:40 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC PATCH 0/3] Add additional MOK vars
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <c134ad45d924e8b719f8abb6d36b426b889e9394.camel@linux.ibm.com>
Date:   Thu, 20 May 2021 14:37:31 -0600
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
        Eric Snowberg <eric.snowberg@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A887886-BDB2-4F88-9D83-73B9BC9E641F@oracle.com>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
 <fdb42621e7145ce81a34840cbcf0914874c78913.camel@linux.ibm.com>
 <7F861393-7971-43AB-A741-223B8A50FFA0@oracle.com>
 <c134ad45d924e8b719f8abb6d36b426b889e9394.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>
X-Mailer: Apple Mail (2.3273)
X-Originating-IP: [24.52.35.144]
X-ClientProxiedBy: SA9PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:806:20::16) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (24.52.35.144) by SA9PR03CA0011.namprd03.prod.outlook.com (2603:10b6:806:20::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 20:37:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f455d27-e57c-4eb1-02b3-08d91bcf1c92
X-MS-TrafficTypeDiagnostic: CH2PR10MB4181:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB418164FF71B677EB4F553DBF872A9@CH2PR10MB4181.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwjQUUhDoC4QyoSidzWk3g962R1MDNf3fXUognNzh70ES32ATDCb2C73qmgR0VIpDKZknGZ+PPBCx4zq+STpHK4MQsVR+7zHaYVjdeeSMF88sPLXQ6oqyUe2qBeG06uN9TP2BBieSbPFpL1oR6KX6EiZbyGV7Ma9Da05u8BWfjPPxq2QIzaTL0cSEh1smpuDuyUrWuPzOYIvyMV2JtdN1pUmnMmU7kFcPeE2KM/BbAQlc0KX7jSifs/khOtVKWlHRMNFc1QR/FZ4L31plp5pc7DJG44N/8cUbc+iHvTNzOLUc8siIuNyqK1UAF2o+mA9UHRQ20wj6gHNkaQcsutTdLzy/MVF5QHtiR6tTGWcHK+/+uWreBw/oAF8QqRVAe+Sfdl3KZCJsEByaVNxLhZZgxC++WCqGcBbbExhmecp0yeEnFrio+q08haIu3f74y5GDVp2VtxbPx8snYNcI06vTXbvnrFcBLwjyO0qJSvza/FVnHYFoDxikxKYQ4yKmhT34+DUIq37IZMSQ8m1m18lUWy2Ot1o/X8kKVwSsb9UGbM5owaw7NgE8AeXfuljvmcS2HLY/ZRJO6nsIN3g6viU070//A9nQKYdS9rQ2My+B+6O1lo6bwg+7/ia9gpZ6e2R5UJWy9Was5eqWRjW8874BS+v6LTwtPmVzkWBViGrN8WYK9GRGqsZGUFDBC55TjsSHdDVjY+oV29Km3hxtukfxLhmzNwTRhhS7BPnbhF1D4zhFTyqULZLuRMI+aaw1GDewvg7QCNSWwwLA/As+G8Bgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(376002)(396003)(136003)(8936002)(83380400001)(53546011)(38350700002)(107886003)(4326008)(5660300002)(8676002)(7416002)(6486002)(52116002)(33656002)(2906002)(26005)(16576012)(36756003)(54906003)(6666004)(66556008)(66476007)(86362001)(316002)(478600001)(186003)(16526019)(956004)(66946007)(110136005)(966005)(44832011)(38100700002)(2616005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Qk1xeml1L3dMSGJXM1NJeDVkQXdaL2tqMW5xd1NwSzVJZHBnZHRwWHFibFBW?=
 =?utf-8?B?T1JKb2kxamdJd3JxaTJDZ0FiWnZtVEdGU1lLU0pFVFQydGRYVU16THZnVHcx?=
 =?utf-8?B?VEpmQ1FUOG4xSGJqcHRnYnV6OGhRTUpBVnNRODRXNjNldkMrcjgweWswL21j?=
 =?utf-8?B?dkRKajRkMTVuQlM1VVFKUnA1YWtlRkFhN3hvMUwzQ2Z5L0pLQ3h1L3ZQTkZi?=
 =?utf-8?B?Tk5UQTQvbXZndWJ2cWhHSWFGMWNmYTYrUDRLcUIwM2JuNTNyY295eXp3R21t?=
 =?utf-8?B?QWZmMHlDUURvWEFCcXlPK2U2Zm9QditYa3FjQmxaWEdkd2Y1Sk4zdTRZMjRl?=
 =?utf-8?B?clllRm5XM0pCd0FEbDg1K0IzOEUzanMraDY5aU1Bbm5ZTUxBV3JjeUFoVTJa?=
 =?utf-8?B?YWlwN2wrOGRjNVQ4KzNkNG5FRnhGZFBNdlgydmRqTFFIVUhyYkhvVUIwTHYy?=
 =?utf-8?B?Zi8xOUFId09ST1E3OERrL1BWckczUHRCU3UrdVc1WDRTNTlTRVhxei9hWkdx?=
 =?utf-8?B?dVRxQnZqN09mcEZjK0sxUHh4cUcvaVlQYVlPenlLM3ZlRXJHNlZ4WFM3cVc0?=
 =?utf-8?B?RmlObTRjb09QK3ZFQ1k2MmprZnpRTkZMc2c0RXlDZStwbThxTXE3ZVpLUXoz?=
 =?utf-8?B?ejByM01QSm5tZ3lGQ1d1UWVzRzl1cEhTaVJkTWhVVWkxbnI3MTlIWW11Njdp?=
 =?utf-8?B?dHJydmprL3RBemJBWU4vK1lzcU81UmhaRXE2YXZWVUtTZUtzRXoyR3pLTWpU?=
 =?utf-8?B?Zk9ka200dFF0dmh0UHQ3UkNLVlB3WllNSkZhNUpyQVdxNTRYcWNTcEhsejNY?=
 =?utf-8?B?Q1Z2Q2pPNW5FemdEWTFqWEhPMTNmaGJIS2Uyek04RUdOSkpvRU9teWMrZnFT?=
 =?utf-8?B?UkFPK0lCZVpkVEl2T3BMOEoyWVBqNTY2cVc0L1B5VzFCenNYVEt1UDhLU1dW?=
 =?utf-8?B?N2IrOGVIQTVMRjdSanFqUlI3REU4SDVBZzU4OS9YVTh0eXhRQVpGUjNNOUJ5?=
 =?utf-8?B?YmIzazc3YVFFRW1DNWtEUU9hK01Gd1BVa29iQkI0TXNGTWtGR2FCci9mRnhG?=
 =?utf-8?B?RSs1Y1BiV2dWRGkycDRYYlRJRGJEN21LeXpxSTYyTXA3SFlEc3NDUEVUK2Za?=
 =?utf-8?B?ZnlsdWZpck9KbVk5aTJnOGdIM2lYazNkNW15c1BXNHVQUGpwcGppcURQc0hC?=
 =?utf-8?B?dktqL2FnV044RFFPd2pjTk1kZHA0aytBVWFIZFFxMXRka24zN3YwNk5FckJP?=
 =?utf-8?B?Mm1TSnRNa2krRmFqS041ekYwazVacXl0eHBxYXdYYUVqL2czcjVrZGJETGc4?=
 =?utf-8?B?WGQvRlNxS0lRTGF5SU9jOTEwZVkxelBaNndwR3FqaHdDSk1lL29mTWFIMnJy?=
 =?utf-8?B?VVdDam5IMCtWeUF0VVBBTWg2VHlFTmhHUkV1bktpbUhHTnpadStCNk1JK0Fv?=
 =?utf-8?B?VG5TeDF1OUVJSk50M1pEWnoyYUNPSTRtbEJqTmVHRWJVRjBBN2pNZ2prT2dZ?=
 =?utf-8?B?UkVvanlxak5QOFVSZS92aGJqckMvZ01ublVFMytpTnFrYisyY3VUQVhQY205?=
 =?utf-8?B?OWxMNGpiYkdSWnplK2pWd29LVGNUeVM5eXdVUHRyNjR1TDdmdGZnblBxai9I?=
 =?utf-8?B?NmdZMVlnUHViMVJQNnZWTGZDd1c4N0ZtaTNhaW1tZUhOdldCaVd6a3FvUXdo?=
 =?utf-8?B?RGtVWklNS1VVQ3dXWnBnUllyZnFHNXc5Tm4yaWdDb0JnTEJqck9RbFZTM2hC?=
 =?utf-8?Q?VPIL5YYd54vPvGq81I8x8YbA51n0EO0Eub9luuE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f455d27-e57c-4eb1-02b3-08d91bcf1c92
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 20:37:40.3357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVUt3H0BjrpvN2gA87QxtvncYKNxy8bko4hhYBICNCrwSMK3e2LbDxvem0QnV6T26cI9PdaWBW1tt2R5BFGxduN1RKEIeNOP7NEeqZ03ORk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4181
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200129
X-Proofpoint-ORIG-GUID: SIq-ShwczpJAQRGYRbHUzCtTczSG2F1L
X-Proofpoint-GUID: SIq-ShwczpJAQRGYRbHUzCtTczSG2F1L
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On May 20, 2021, at 6:22 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Wed, 2021-05-19 at 16:04 -0600, Eric Snowberg wrote:
>>> On May 19, 2021, at 8:32 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>=20
>>> On Mon, 2021-05-17 at 18:57 -0400, Eric Snowberg wrote:
>>>> This series is being sent as an RFC. I am looking for feedback; if
>>>> adding additional MOK variables would be an acceptable solution to hel=
p
>>>> downstream Linux distros solve some of the problems we are facing?
>>>>=20
>>>> Currently, pre-boot keys are not trusted within the Linux boundary [1]=
.
>>>> Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
>>>> keys are loaded into the platform keyring and can only be used for kex=
ec.
>>>> If an end-user wants to use their own key within the Linux trust
>>>> boundary, they must either compile it into the kernel themselves or us=
e
>>>> the insert-sys-cert script. Both options present a problem. Many
>>>> end-users do not want to compile their own kernels. With the
>>>> insert-sys-cert option, there are missing upstream changes [2].  Also,
>>>> with the insert-sys-cert option, the end-user must re-sign their kerne=
l
>>>> again with their own key, and then insert that key into the MOK db.
>>>> Another problem with insert-sys-cert is that only a single key can be
>>>> inserted into a compressed kernel.
>>>>=20
>>>> Having the ability to insert a key into the Linux trust boundary opens
>>>> up various possibilities.  The end-user can use a pre-built kernel and
>>>> sign their own kernel modules.  It also opens up the ability for an
>>>> end-user to more easily use digital signature based IMA-appraisal.  To
>>>> get a key into the ima keyring, it must be signed by a key within the
>>>> Linux trust boundary.
>>>>=20
>>>> Downstream Linux distros try to have a single signed kernel for each
>>>> architecture.  Each end-user may use this kernel in entirely different
>>>> ways.  Some downstream kernels have chosen to always trust platform ke=
ys
>>>> within the Linux trust boundary.  In addition, most downstream kernels
>>>> do not have an easy way for an end-user to use digital signature based
>>>> IMA-appraisal.
>>>>=20
>>>> This series adds two new MOK variables to shim. The first variable
>>>> allows the end-user to decide if they want to trust keys contained
>>>> within the platform keyring within the Linux trust boundary. By defaul=
t,
>>>> nothing changes; platform keys are not trusted within the Linux kernel=
.
>>>> They are only trusted after the end-user makes the decision themself.
>>>> The end-user would set this through mokutil using a new --trust-platfo=
rm
>>>> option [3]. This would work similar to how the kernel uses MOK variabl=
es
>>>> to enable/disable signature validation as well as use/ignore the db.
>>>>=20
>>>> The second MOK variable allows a downstream Linux distro to make
>>>> better use of the IMA architecture specific Secure Boot policy.  This
>>>> IMA policy is enabled whenever Secure Boot is enabled.  By default, th=
is=20
>>>> new MOK variable is not defined.  This causes the IMA architecture=20
>>>> specific Secure Boot policy to be disabled.  Since this changes the=20
>>>> current behavior, it is placed behind a new Kconfig option.  Kernels
>>>> built with IMA_UEFI_ARCH_POLICY enabled would  allow the end-user
>>>> to enable this through mokutil using a new --ima-sb-enable option [3].
>>>> This gives the downstream Linux distro the capability to offer the
>>>> IMA architecture specific Secure Boot policy option, while giving
>>>> the end-user the ability to decide if they want to use it.
>>>>=20
>>>> I have included links to both the mokutil [3] and shim [4] changes I
>>>> made to support this new functionality.
>>>>=20
>>>> Thank you and looking forward to hearing your reviews.
>>>=20
>>> This patch set addresses two very different issues - allowing keys on
>>> the platform keyring to be trusted for things other than verifying the
>>> kexec kernel image signature, overwriting the arch specific IMA secure
>>> boot policy rules.  The only common denominator is basing those
>>> decisions on UEFI variables, which has been previously suggested and
>>> rejected.  The threat model hasn't changed.
>>=20
>> Could you point me please to the previous discussion on the threat model
>> this change would violate?  What I found was [1], which I have tried to
>> solve with this series.  Having the ability to update a MOK variable=20
>> indicates the user is not only root, but also the machine owner.  MOK=20
>> variable updates require both root access to update and then physical=20
>> presence to set via shim after reboot. This patch set tries to address=20
>> the "*second* order" Linus requested [2].
>=20
> The concern is not with the normal way of updating MOK.
>=20
>>=20
>>> The desire for allowing a single local CA key to be loaded onto a
>>> trusted keyring is understandable.  A local CA key can be used to sign
>>> certificates, allowing them to be loaded onto the IMA keyring.  What is
>>> the need for multiple keys?
>>=20
>> We have no control over how many keys an end-user may wish to enroll. =20
>> They might want to enroll a CA for IMA and a different key for their=20
>> kernel modules. This is a generic kernel that can serve many different=20
>> purposes. Think distro kernels - like Fedora, Ubuntu, Oracle Linux, etc.
>=20
> This patch set changes the secondary keyring root of trust, which is
> currently the builtin or other keys on the secondary keyring.  My
> concern with this change, is that any key on the secondary keyring may
> then be directly loaded or used to verify other keys being loaded onto
> the IMA keyring.

I understand the concern, that is why I left it up to the machine owner
to decide what they want to trust.  I took a quick look at a few other
distros, each one I checked (Red Hat, CentOS, Fedora, Ubuntu) all carry
this rejected patch [1]. These distributions have made the decision for
the end-user that they will trust platform keys for verifying kernel
modules.  With my change, it defaults to what the upstream maintainers
feel is an important trust model, but allows the end-user (assuming
they are the machine owner too) to override it.  This leaves the kernel
distributer out of the picture.

> I really do understand the need for extending the root of trust beyond
> the builtin keys and allowing end user keys to be loaded onto a kernel
> keyring, but it needs to be done safely.  The first step might include
> locally signing the MOK keys being loaded onto the secondary keyring
> and then somehow safely providing the local-CA key id to the kernel.

If the machine owner and Linux distributor are independent of one another,
I don=E2=80=99t see how MOK key signing could work.  There wouldn=E2=80=99t=
 be a way for
the kernel to verify the end-user supplied signed MOK key.  An end-user=20
choosing a Linux distro is trusting the company/organization building the=20
kernel, but the trust doesn=E2=80=99t go the other way.  Do you have a solu=
tion=20
in mind on how this would be possible? If you do, I=E2=80=99m happy to move=
 in
a different direction to solve this problem.

>>> Making an exception for using a UEFI key for anything other than
>>> verifying the kexec kernel image, can not be based solely on UEFI
>>> variables, but should require some form of kernel
>>> agreement/confirmation. =20
>>=20
>> Isn=E2=80=99t that the case today with how MOK variables get set through
>> mokutil and shim?=20
>>=20
>>> If/when a safe mechanism for identifying a
>>> single local CA key is defined, the certificate should be loaded
>>> directly onto the secondary keyring, not linked to the platform
>>> keyring.
>>> The system owner can enable/disable secure boot.  Disabling the arch
>>> secure boot IMA policy rules is not needed.  However, another mechanism
>>> for enabling them would be acceptable.
>>=20
>> For a distro kernel, disabling the arch secure boot IMA policy rules is=
=20
>> needed.  Distributions build a single kernel that can be used in many=20
>> different ways. If we wanted to add a built-in IMA policy for an extra=20
>> level of security protection, this allows the end-user to opt-in when=20
>> secure boot is enabled. They are then protected before init is called.=20
>> Not every user will want this protection; a different user may just want=
=20
>> secure boot enabled without the IMA level protection.
>=20
> When secure boot is enabled, the IMA arch policy rules verify the kexec
> kernel image is properly signed.  When CONFIG_MODULE_SIG is not
> configured, it also verifies kernel modules are properly signed.
>=20
>> After going through the mailing list history related to IMA appraisal,=20
>> is this feature strictly geared towards a custom kernel used for a=20
>> specific purpose?  Do you view it as not being a feature suitable for=20
>> a generic distribution kernel to offer?=20
>=20
> IMA-appraisal is enabled by distros, but requires labeling the
> filesystem with security.ima xattrs, before loading an appraisal
> policy.

I was referring to digital signature based IMA-appraisal.  If a company
wanted to ship a distro where all immutable files are IMA signed, today it
would not be feasible.  The end-user will undoubtably want to install their
own application, but this is not possible. The end-user can not IMA sign=20
anything since they do not have the ability to add their own IMA CA.


[1] https://lore.kernel.org/lkml/1556116431-7129-1-git-send-email-robeholme=
s@gmail.com/

