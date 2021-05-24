Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45C738DE88
	for <lists+linux-integrity@lfdr.de>; Mon, 24 May 2021 02:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhEXBAC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 May 2021 21:00:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25116 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232050AbhEXBAA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 May 2021 21:00:00 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14O0vxV5023104;
        Mon, 24 May 2021 00:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=opwIe6hkcohYA/n5hPJFLoQLM0a/Tm/S5WXAmX0JFLo=;
 b=TYxhDrCjcTEpRpe8NSHb96k8qYUylMzi17Af+4j/+YhGWEOAEp/i9U0J9MvJHdoaxXJe
 hFbsctkt1g/XCWGEmWRowLpRB2AulYJVxvjOBkjZIme9ZbkdQ7+m6G8zF192F4v0spfB
 VVejsNOFPks2+AMl8kww8nATsz2x+aoA9Qy60yHEYgwWQDOseWSQAWglrL7nZWpkljbu
 +zNyNpxPtAucjOnJdwjbAhQAT91m0n1h9mNLsEvAXDVvsst+EwDWC3usDkaikeY3ugyh
 PIY+CDqrlHfg+4WJ6Tvg3ogdTeIGRBQnFWCEqYyFTaUeoycUq1WvI5F4zQ2llGv4En3r Bg== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38r1bdr0bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 00:57:59 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14O0vwTH095507;
        Mon, 24 May 2021 00:57:58 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by aserp3020.oracle.com with ESMTP id 38pss42f5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 00:57:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw+N/b5K9DPmjP9ehLOzo+8h+uxx3CRuU5v1YTda/XmaLAyzYcaqGVZaB2e0g8szOkL5uffcs7J/As5gGdssyDcMC3RU7xhu/xdFdUTw4jlKh/5jKMmzsDOiKnznkaITT6yQ1KUC0t34SpP/+sFb6kTBWyODDKQg8fy5kCGqjpFDRDGS3ePJ+WoISDu1mQTAKuAxTKofKwlsg25MEmMcO8phmllXW0L+CxwCAtBNTiYZxkyfo0jLrt3BusWXjVJD4qDOryhtiUomnGJ8eIZYaiNvhceLVC0zJCC08/+NHSiVaY0Fq8iTm+LzTxahPZlAf10FWPRoGZkOPkj/uE61qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opwIe6hkcohYA/n5hPJFLoQLM0a/Tm/S5WXAmX0JFLo=;
 b=Ivbxw5esRn2kX9+9QadjwVBX9EpMhr7WtFIVMic8l5U3jgdKOZA1EIlHiJriL1P1NuU8ScUQ6ViMeJXkFjpd4QJid71/K4gx7gUXhVgaWeHvyAa/y6IzLw8hg+mRpWMoo2NoSQrDzitOKpgq1GqJv9Es9IFJZ+3ii2q6/05gzq/HDEffz0RAjy50mGdOXXuqyiPXpmdAP/j1k7H2rTsx7hyPuGp8kGnywuxARRtvqNQR72O084xEjtRS/X1YDr+85tUaQLaA3dTBcPkX7TGwJxMD5MDQ1VS+PxX6xkNAnx8DLoFfXJ5pFC99/7uduo6NLjpptYW6mWCdOxOfmBNY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opwIe6hkcohYA/n5hPJFLoQLM0a/Tm/S5WXAmX0JFLo=;
 b=p0R1k1Yf/BywCBKLJ8PSeGdU47KHEG8Aosyc+bycuoY86kJSiw2DvTNlNOA1bRi+eQxGYxxNloAwX31ABCa3MVwIrzsdYU/nfhrd/DN0zlgKF8I7HiWNgvCMzC/ZprB/WBzLcVx/sUBcdtwMDZSHo2MvxP6fXF8JaDNMRvOXOAM=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (20.180.7.141) by
 CH0PR10MB5226.namprd10.prod.outlook.com (13.101.44.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.26; Mon, 24 May 2021 00:57:56 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%6]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 00:57:56 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC PATCH 0/3] Add additional MOK vars
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <fd0e91c43cf0dc14aeeda4e7095416c77df0d0cc.camel@linux.ibm.com>
Date:   Sun, 23 May 2021 18:57:52 -0600
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
Message-Id: <7440CE7D-9630-44DB-8916-792523AC86E7@oracle.com>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
 <fdb42621e7145ce81a34840cbcf0914874c78913.camel@linux.ibm.com>
 <7F861393-7971-43AB-A741-223B8A50FFA0@oracle.com>
 <c134ad45d924e8b719f8abb6d36b426b889e9394.camel@linux.ibm.com>
 <4A887886-BDB2-4F88-9D83-73B9BC9E641F@oracle.com>
 <fd0e91c43cf0dc14aeeda4e7095416c77df0d0cc.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>
X-Mailer: Apple Mail (2.3273)
X-Originating-IP: [24.52.35.144]
X-ClientProxiedBy: CH2PR14CA0032.namprd14.prod.outlook.com
 (2603:10b6:610:56::12) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (24.52.35.144) by CH2PR14CA0032.namprd14.prod.outlook.com (2603:10b6:610:56::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Mon, 24 May 2021 00:57:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e77044d-3c04-43e1-0192-08d91e4ef7d4
X-MS-TrafficTypeDiagnostic: CH0PR10MB5226:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5226B3E699D0DBCF9D7B40FB87269@CH0PR10MB5226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXy9J9Rtimm4m2lQboi293C2T8OackLnHKuHmNhUaNiLskMqzg+FNdUvZL+5em0HHGr84iNvFCyvVewsCl2LEmW/pB56bnn6ZKqpp1XvbCjARdhIzkb0OCDMusLdnnQCnW11YQSvVixpwSSlRX71v0/qX4PRhov0y9vb9zfuupIP4vCc9Q4yZzladWZaxLvYkUVK7jEY13XswAfXQ/hCdD4q6zHuqSiyx6T+YY6nlWvRGzKRtdlZUqgP9B6lX2vRbLh1Zkp21qrDGfrCbgysSely64Wh3aKjHYcweGp8au6MP9i461iEVnfhkA9VVF8mQM39TuVEJnmJ3v6ROybpSN0btgXHfYByrPqHPPGVd6pU36hLRinGYWJxdKHH113zK4Up/ClvW73W3Fwrwn8DOIyJfUa5k3keOzHqSjdX4lHpnqHyMLLH46MRP1M5X2PruUDWJjtS32G9F/pFOrzRKzON3RD/MGj+V0kjjpvq3DbuIKdAMgWlv1nLaHERhtYGB9inb8hM7vPxoXGMuWTYU1UWtwVQVkaIxZZBAVxIj8t35adPCHRzrcScJn3aFK8fzNWDY+GP2jXVwFxyMsmwEkeivzIMO9jiTLGu1BVMENuphS9O7p3+545Ske0RQPoFU2hiwGeEm62C0hywbjkErjD3ulu7RFcbyQQpsSwUpiZjp4QweOv1lDRGQLTCe7CE339KbNMgHRZgfMNT1cKWkbAA9NmH05s2x98t4NHVezreBr3SHHY7mSau3Xr3VQHHNquhZE7dE46y8SYdYmmgC63X6I0y3dUgDgSz1PH9gpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(366004)(396003)(136003)(66476007)(66556008)(5660300002)(38100700002)(38350700002)(66946007)(6666004)(83380400001)(36756003)(107886003)(110136005)(2906002)(53546011)(54906003)(52116002)(86362001)(16576012)(8676002)(316002)(2616005)(44832011)(956004)(7416002)(26005)(186003)(16526019)(33656002)(8936002)(6486002)(478600001)(966005)(4326008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?REdXWFVlMEUvZ0xURHQ1SjBmMkd2cHJDMjVyZmRoS0NQd2RtSTJCZnlHWlZG?=
 =?utf-8?B?T0tGNjNjamFGNmNSZ1F3MmdmaWtvYmtDSHo4Uno2U3JmOFcyQ0lyTHJnN1hM?=
 =?utf-8?B?cDNSb3ZWc240bVVLUVZWcWIzUzRIWUxTNnN3VlNLL0tyajYwZnI0dGhESm5q?=
 =?utf-8?B?VDB3bXk0dnE1d1dmTUZSaXZHVk9sczhJaHFZMEtySU5tWm9HSjFGZUVJRjB1?=
 =?utf-8?B?aFZ5c3RqZEhHRm1hUjRlTTdldTNVY2ljTUNkVHNGb212WFJYdHhtUnRPZmJs?=
 =?utf-8?B?Ym5oNHBiOS9lNzdGWEFWM2VUQ3ZkTlFuL3Nra2ZWWkRyaGdYRnlMWUhzd1dW?=
 =?utf-8?B?ZndCNFdyN0NsYm1NaFJCN3lFRlVoVndDQXZFSzVhb2txa2dOS2s5N1JKekVB?=
 =?utf-8?B?U29JeWVha1l4dzM1YmRYUjBzUXpBUXpWU3o2Q0lZaERtOEFoaXRZQnlycmJ6?=
 =?utf-8?B?VDB3K2d2QStHMzhqSHNZL0ttRGlJbGtTYTVFMDl4bGZFbks3N1Azb2RPaVFl?=
 =?utf-8?B?SUxibnBORG9qaG11VHovNUNQVDg0dnc3NHJIaW5paElFclg1NWVhcVhzZlpJ?=
 =?utf-8?B?NVdEZHQrU3J0bEx5YjJjM0FoRE5NWkMrVG5VdDUzcVBORFlFRDB0UzdnOU9n?=
 =?utf-8?B?TWd6cGVUOEVTeTVoZ1RyMC8zallBNGNaVU0vNWI5NUFnNW0zbTVlTUE1c0Uz?=
 =?utf-8?B?c055UGhlK1hRL3k2MmNVNVBhUnRTa2RGaTMyVXFNdEJPMmtWaUJHak1xMXN0?=
 =?utf-8?B?Rko0azlJYmFUOHdXVFEyZ0tzbkc3Mk1UcFpzTGtjYks4a09qdVF0d3lWY3Mr?=
 =?utf-8?B?QlVjWTM4TXVjQUVHN1FXaERwNldTMkRmSjhkVCtTNkhWRjc1VHlhd1FISy9w?=
 =?utf-8?B?SFB1d2l0c2tOSkxKYVJGeU9IT0Z4NVBKMlpGa0xaODlZb003TkNsY2k3MFZz?=
 =?utf-8?B?dzBqcHRQRDFWQ2JDVThTd2o3cU83WnZJL3l3NXVjL3BkYmpZYUJpZHBMVFNn?=
 =?utf-8?B?Q2IrWWNwakhsYjEyalpRZWdwQWZqeko0VWRYZjdOSGxyZUs3MzhrMFVQNHdR?=
 =?utf-8?B?ckFKMURicC9FS0NUdUZoeHc5YUpVTTUxU0o5M0t0clFvVlFKTitlQ0lMVFUv?=
 =?utf-8?B?Y1BaSXN4Zk55WWRlelBTdVlpL0hwTW8vZ2I1cExBS1BHeWNJTkoxL1lJWlpZ?=
 =?utf-8?B?bVJsYTBOU0tYRkZYM3JHY21sTDFQQ3c0ZjZGZDFJWUlCS3RTV3VMcG9HeElr?=
 =?utf-8?B?cVVwanBzRUJMd1VJVUI3ZVJ3bEdYTldTdCtneEpZSnV0cC9wVlZSUlVXOElD?=
 =?utf-8?B?K3BQeWMvOXRlNkhGU3R4N0EyQnU3c3BHRmhPMUJVdnZnM0o4cXhWRlRubnJQ?=
 =?utf-8?B?RFNPRHZpRUlETElabFR3dHdXeDNSN1U3VnFETzRuQURMcTdXdEg2UTVqbFdH?=
 =?utf-8?B?VE9FR3JPcFppQkFERGJOR0pNNDlYYW1lTnlHdHFqYmFmbm1qTEQ3a2I2RXdT?=
 =?utf-8?B?dkI0ZHFlSDBzTXJta045bDlvanNDVWNMUU93NVdqa2U0Z0FyT2ptSXE2U003?=
 =?utf-8?B?YWlKRU83eWk3NzRpM2lVbTdYaWJKSFhrODFSb2p2ckRFaGczOGtXKy94b1pq?=
 =?utf-8?B?MGVpZFZKOHBkcUJFT0dQMmJ4MzVVc3pIYmo4SDhXNUM4R1BLN1oycWh5SzJR?=
 =?utf-8?B?QTlTVVdHVVFLZlBRczZQTUt0VU9rMis1TGJjOFRUa0dMTXN2WkhmdjRrNWlH?=
 =?utf-8?Q?WiIl9Kx54Y6yhF7RtLypfDxaVK1eDI3rEmFP3ld?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e77044d-3c04-43e1-0192-08d91e4ef7d4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 00:57:56.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfaoS98Oxn3OiFdTcl9X8D35eLXapIS58YUX9GVJhFSDpaGbELJHSNYdl6p4qmtfYh21Tgeqz4NRN2RPZnjvrC/ZE/eW21dD5pS4uDpP2xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5226
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240002
X-Proofpoint-ORIG-GUID: h3sWZoFrNqFKHFLYhu1d1j8stjfoJj4m
X-Proofpoint-GUID: h3sWZoFrNqFKHFLYhu1d1j8stjfoJj4m
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On May 21, 2021, at 5:44 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Thu, 2021-05-20 at 14:37 -0600, Eric Snowberg wrote:
>>> On May 20, 2021, at 6:22 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
>>> I really do understand the need for extending the root of trust beyond
>>> the builtin keys and allowing end user keys to be loaded onto a kernel
>>> keyring, but it needs to be done safely.  The first step might include
>>> locally signing the MOK keys being loaded onto the secondary keyring
>>> and then somehow safely providing the local-CA key id to the kernel.
>>=20
>> If the machine owner and Linux distributor are independent of one anothe=
r,
>> I don=E2=80=99t see how MOK key signing could work.  There wouldn=E2=80=
=99t be a way for
>> the kernel to verify the end-user supplied signed MOK key.  An end-user=
=20
>> choosing a Linux distro is trusting the company/organization building th=
e=20
>> kernel, but the trust doesn=E2=80=99t go the other way.  Do you have a s=
olution=20
>> in mind on how this would be possible? If you do, I=E2=80=99m happy to m=
ove in
>> a different direction to solve this problem.
>=20
> We are working with the distros to address this problem.  The first
> attempt at extending the secondary keyring's root of trust relied on a
> TPM2 NV Index[1].

Yes, I saw that patch.  I view (which could be a mistake on my part)=20
digital signature based IMA appraisal as an extension of a verified boot.=20
Once a TPM is introduced, it is an extension of a measured boot. It seems=20
like this patch is using measured boot to solve a problem that exists on=20
the verified boot side. While it may be a good solution for someone using=20
both measured boot and verified boot at the same time, not all machines or=
=20
VMs contain a TPM.=20

> Using MOK is a possible alternative, if it can be done safely.

I do want to point out, in case this was missed, when the new MOK variable=
=20
is set to trust the platform keyring, PCR14 gets extended [1]. The UEFI BS=
=20
var MokTPKState is mirrored to a freshly created UEFI RT var called=20
MokTrustPlatform.   The contents are extended into PCR14. This happens ever=
y=20
time the system boots. The UEFI RT var does not persist across reboots, it=
=20
is alway recreated by shim.  The same thing happens with keys in the MOKLis=
t.
Since the contents are mirrored, a key change can be detected on each boot.=
=20
This makes it possible to use attestation to see if the system was booted=20
with the proper variables set. For someone using measured boot, would this=
=20
satisfy the requirement of safely protecting the system from a MOK update?

> For example, if the boot command line could be protected from modificatio=
n,
> the end-user could enroll a key in MOK and identify the specific MOK
> key on the boot command line[2].  The boot command line would then
> become an additional root of trust source.
>=20
> The root of trust for loading keys on the different trusted keyrings
> are self documenting -  restrict_link_by_builtin_trusted,
> restrict_link_by_builtin_and_secondary_trusted().  A new function would
> need to be defined to include the boot command line as a new or
> additional root of trust source.


[1] https://github.com/esnowberg/shim/commit/ee3961b503e7d39cae7412ddf4e8d6=
709d998e87#diff-b1dd148baf92edaddd15cc8cd768201114ed86d991502bc492a827c66bb=
ffb69R259



