Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337C0306000
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 16:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhA0Poz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 10:44:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36184 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbhA0PnP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 10:43:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RFOaLm157583;
        Wed, 27 Jan 2021 15:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=eTDeDviNpf4dONWd9b/EujsB896zJyYnCkH7DlTtaeM=;
 b=ROrCQdfGTBGSGLox4uhgSeeanKBx5+6+MLz6i+mbpqNo0nipq5HyGjrDFU/tTK9+Kvf6
 pkYo9PDOxMQi19SbpiI/jUTWYdZPb79qRJINbB//SX3DhM+O+8wKHZnvn2ob8xED2EFx
 yN+jZW5aUwteTdgOuD/o6z3lM0eZGU2cXlwsf29oqr45wFAZIWS2rbAPhARhSqSGVgth
 My/9kX7zV06T4G0tv+WWLAPRDP+ZjmdUnjFCx3ausM2uI9xG8zwnigxqybTMvznBGgDA
 tHM+IAVEC06gylqg+oh22w4/SgDcuqtljXp5wRdNBCXpDVV8oi+snHNebO1xc6bW7+sO Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 368brkqs7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 15:41:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RFKBNo043067;
        Wed, 27 Jan 2021 15:41:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 368wqy0def-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 15:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw5z0gnD3G439ZqVRji2zu+1wpm5gjxUwIy9nplRNHueFdFg61Enhh6zqmEEKL1p7Y1GqC/lHa4s8G3NmnZeyWqWfwi285sH6fiyisC6llBxNbEasIL4LcwW30L2DTCm3pCZmdw+AyoY5uEiGAR04vL/pxlPTZKbYIx+/RB6GIT1WgYgC13rqVMIBTXud0ActupJ6P4IJsYp6ZbLcrbAZ+rXNyysFcf0Qx8rOGBDG0im+jqGuCVtnTJh7nvzq4ayd6OvTHD2cAVoXvhIMszs8lxmQPEaZOZFisdPf0TVCgPYd06wHBnrieEU+00u8JduWXQjinkzY62cyyuuON0wmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTDeDviNpf4dONWd9b/EujsB896zJyYnCkH7DlTtaeM=;
 b=VchifSzbs34UDq7WBNDrVgDo8jAolM1mWpj0EZYGHgW5KLAAJ8OcRdzCr0E/o6ofsMnZOzXzJW4qvmjZF1faEjjNtQwan/E1whLERU0Oo/LSVEGMHpjKGb3NbuSXJ7SJRwnQ371OhfTMB6PZ3XoCUVUTEg7Ui83q5DkiNXM7/8asK9sTEYh/pnM6/rBvmqYM0Ce5OUqSd+k5j419RU+Gy64K4hQZRMyNMrHfB/EqZctoszs9EMIDApg3xrc5xkkSooHou3korB4Nmm9ZN6lIRmnRVcLbeaydrIK32K6oVfLe3tsn3kGtBfkBEtOaG3wjGoYgCH96AjfmnAhAUDuzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTDeDviNpf4dONWd9b/EujsB896zJyYnCkH7DlTtaeM=;
 b=YVS66fInkNtgNn+y00Z7VjERUNRf4FX+zvgBynvl082FjPmO007RNK3bUk9hS6IwQM0j2s/bXefrR0BGWWk+evAuIiGu8yru14setCWguSDvPCTEi2VZ8WFqpahWN+T3a4KDpkKOISXIPgqyPDicys3Tac5nUWtm57uoozs6W/Q=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3099.namprd10.prod.outlook.com (2603:10b6:5:1ad::18)
 by DS7PR10MB5200.namprd10.prod.outlook.com (2603:10b6:5:3a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 15:41:34 +0000
Received: from DM6PR10MB3099.namprd10.prod.outlook.com
 ([fe80::70bf:d626:5218:70e4]) by DM6PR10MB3099.namprd10.prod.outlook.com
 ([fe80::70bf:d626:5218:70e4%7]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 15:41:34 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4] certs: Add EFI_CERT_X509_GUID support for dbx entries
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <61a0420790250807837b5a701bb52f3d63ff0c84.camel@linux.ibm.com>
Date:   Wed, 27 Jan 2021 08:41:29 -0700
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jmorris@namei.org, serge@hallyn.com,
        nayna@linux.ibm.com, erichte@linux.ibm.com, mpe@ellerman.id.au,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com,
        Eric Snowberg <eric.snowberg@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86CE3924-E36F-44FD-A259-3CC7E69D3EAC@oracle.com>
References: <YAjMm9Gq/FFOzQYG@kernel.org>
 <E090372C-06A3-4991-8FC3-F06A0DA60729@oracle.com>
 <20200916004927.64276-1-eric.snowberg@oracle.com>
 <1360578.1607593748@warthog.procyon.org.uk>
 <2442460.1610463459@warthog.procyon.org.uk>
 <X/9a8naM8p4tT5sO@linux.intel.com>
 <A05E3573-B1AF-474B-94A5-779E69E5880A@oracle.com>
 <YAFdNiYZSWpB9vOw@kernel.org>
 <CFBF6AEC-2832-44F7-9D7F-F20489498C33@oracle.com>
 <YAgTawk3EENF/P6j@kernel.org>
 <D9F5E0BD-E2FC-428F-91B3-35D2750493A0@oracle.com>
 <3063834.1611747971@warthog.procyon.org.uk>
 <61a0420790250807837b5a701bb52f3d63ff0c84.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-Originating-IP: [24.52.35.144]
X-ClientProxiedBy: CH2PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:610:4e::38) To DM6PR10MB3099.namprd10.prod.outlook.com
 (2603:10b6:5:1ad::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (24.52.35.144) by CH2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:610:4e::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Wed, 27 Jan 2021 15:41:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d79357-4c37-4aa2-d256-08d8c2da0646
X-MS-TrafficTypeDiagnostic: DS7PR10MB5200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DS7PR10MB5200508F9FC633B92AC73EAD87BB9@DS7PR10MB5200.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T9zzTWI9NU0i1l8jCzrPki266ZHMzxqHwnAICwikDEMFWH8b34z7Or6F8vXwzdfn4HQHUKa4NjoxwFLC4NatW0mERMsbFY86v+1D0aClQ5wsYMPI/klkC011gZaejAPk0PXonMEUqnSf9P5qU9MBxdzSv9HtO5PXBj0vuyOqTwPzwA81m4j6Ntz0iQBCHvGOUbNwHKccqoApK6BIeOIndtk7JnhRyw7kKbvmaO37RgbPmr4EcEIuL3N56ALARR3iVqdEWpg2cn67n0a0s7R5tCbOrTxaFmu748sGdXhVxL0+gJq/9DJFoxzy4sgEBfX2JYNYsTD64jZPd30FzFP0g6l39+EiFnUyajX4xKEGQIXoSBehzyLYbS8xfGnzPe6ISUho/kgc4oifZZkrF3a82GoorfOWtKn8/yzG2Q0vTNaoKk+fmSSVAs7ROI8ZYqyiVnRuY3p/BrUydhByGQmdSOUbuablnRADk3thWWET+fmH9Xvvfl+uG6za7qp0R4CVfNJ8McseFxPPf/De4PbbJoUgUXlpYegwMbCOEGQOWg8bIWuWJdHfxsfxlRr+ZSVD6Cqx26ENhld+QZ8hXDIHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3099.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(376002)(346002)(6486002)(54906003)(83380400001)(44832011)(107886003)(16526019)(66476007)(8936002)(956004)(53546011)(186003)(66946007)(6666004)(66556008)(4326008)(36756003)(316002)(7416002)(8676002)(26005)(86362001)(478600001)(2616005)(2906002)(33656002)(16576012)(52116002)(110136005)(5660300002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S1NvZVdRT3A0c0c4NElwemczTWtrZ1Z2S0xyMDNKalBLaFM4emxRTi9IR3dC?=
 =?utf-8?B?UFdHb3BLWGJRdzM5TTMwTzZSWk1XaFhLbUNTYSs0b2RwWGxFUXBLamYrZFAr?=
 =?utf-8?B?YmV6eG5jSU1OdnVtdUk2OWR0ZS9wN3dveUdMNFQ5QTVGYkZPdzRIbmMwV0ZX?=
 =?utf-8?B?RXpPNzVIc09adlRGbjkwR3J6UTRWVHNpNVkybnFka1huUlBFeWhZa3d6Q0Zy?=
 =?utf-8?B?S0EvTXpuajhSQ3RXQ0xkb3ZwWHd5SEdOcDh2cHZHd2VWTUl4K1BTK1hNREtw?=
 =?utf-8?B?cWZsTWJqVXIwTmFvWUI3RTYwZjFhVzlCNUZ6MEsrcDk1N051S1hOWTBVckF3?=
 =?utf-8?B?cDhsNjhXOHo5U212N3kwRXFGSm1xSzFMVHRLYlZGV0VUU3l4UUVJczhUMzRj?=
 =?utf-8?B?WjNOVURXVFJldTRwQjdpVk42NHBHM0c1ZDF1R3ZJMlU1Y3RwT01sMk9ucXhs?=
 =?utf-8?B?VnU3ejV4VmxNK25jeVVPeENBdUkyaEw5eWxIbXg5eG5ZVGk2bWlZTTZmcVND?=
 =?utf-8?B?Y1l4MEZ2WjhEL0RiZDk3ZHArU1lvRGRUY3BIUlVJV0JjUmYwUnVLMUlEYlZT?=
 =?utf-8?B?cnBkUkc0TVBnYjl4TDNQYk5VMTJKZE9Fb3NHdW1HNXp4TmZxWUR0NWNLM01B?=
 =?utf-8?B?MmxRZzFqUEIyWDh3VFZJQ0h1Zm9xTmF3NmZkL3dlT21NYWJFSTBCdzJ5N1hS?=
 =?utf-8?B?bit0MS8veHBRRS9TTEg0OVRlQmYxMW5nZ2s5bW12WGFWeExQVFo1SGZXWVRV?=
 =?utf-8?B?bU9oUWtvWXI1bnVEQnpPNm16d3oxYnMwZmNaZ0E1Y3BGMFMrT2xVS3VndGJL?=
 =?utf-8?B?aXhMYVp1bE9kOGtLZmI4RGNGdVpuWUFFdUpreFhVaVZ2V09EaVBMNzRJN1NS?=
 =?utf-8?B?N2tmeFJOT1oyRXBqNnhFekxTbmpvTkxVUml5ZzVvOWljbUpMOEhPczN0b2Qr?=
 =?utf-8?B?d09PZUtvYytWRzJ6RjRVeUNCWTRLL3VGQ2dRZVJVL0FuZm5VL2FiRW1yQlEz?=
 =?utf-8?B?VlRVOGRKa0ZCS2xSdGdFNEhMbjlQQUp6V2R1UEhWR2NJK2xRVlFadDFxZW5P?=
 =?utf-8?B?THhRM3lybFFXcUFuUU1mTEVkdi95K0VmUUpxNytYK2NRaUxaMmJ0ZTBUM25S?=
 =?utf-8?B?aWp2ODlxc3BEUE94RkFxZmRRaFFFRjVkUk1ZK1c5dDRPeUN4SGUyMlV3bTk1?=
 =?utf-8?B?ZGh6SE90NlI3K2dUZmxQSjhTUVBxNHhpVmhZUkdTcUJKNnBMNDhic3Q3ai9h?=
 =?utf-8?B?VGRaeHpQeVZlSzBIYklVKzgreHg4T0NDa1lQSTcxN29DMnBJSTBZRU1uYmk5?=
 =?utf-8?B?YS95ME9mRllnM0s0TDFNYXVPRVB5U0dOZmljdkREbkYvVkRKNFVOYVVUYmhu?=
 =?utf-8?B?cUlINUc0a0Zib2xBK3plamZFcHBCN0s2SGg3TWZGNGQxMjVNTkdXVHVpQmw5?=
 =?utf-8?Q?Ag5rgZV9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d79357-4c37-4aa2-d256-08d8c2da0646
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3099.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 15:41:34.2915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPyTVawr+xTWlDQjbgNIp1KAlJkVpchXwGGdZqLJk9Sn+h7sLRFVyq4SU1qJZ29VHc4FshF08Tw10ZbD0QhdoqbLocuJyh2wTQN6Q2wZmFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5200
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270084
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Jan 27, 2021, at 7:03 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> [Cc'ing linux-integrity]
>=20
> On Wed, 2021-01-27 at 11:46 +0000, David Howells wrote:
>> Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>=20
>>>> I suppose a user space tool could be created. But wouldn=E2=80=99t wha=
t is
>>>> currently done in the kernel in this area need to be removed?
>>>=20
>>> Right. I don't think this was a great idea in the first place to
>>> do to the kernel but since it exists, I guess the patch does make
>>> sense.
>>=20
>> This information needs to be loaded from the UEFI tables before the syst=
em
>> starts loading any kernel modules or running any programs (if we do
>> verification of such, which I think IMA can do).
>=20
> There needs to a clear distinction between the pre-boot and post-boot
> keys.  UEFI has its own trust model, which should be limited to UEFI.=20
> The .platform keyring was upstreamed and limited to verifying the kexec
> kernel image.   Any other usage of the .platform keyring keys is
> abusing its intended purpose.
>=20
> The cover letter says,   "Anytime the .platform keyring is used, the
> keys in the .blacklist keyring are referenced, if a matching key is
> found, the key will be rejected."   I don't have a problem with loading
> the UEFI X509 dbx entries as long as its usage is limited to verifying
> the kexec kernel image.

Correct, with my patch, when EFI_CERT_X509_GUID entries are found in the
dbx, they will only be used during kexec.  I believe the latest dbx file on=
=20
uefi.org contains three of these entires.

Based on my understanding of why the platform keyring was introduced,=20
I intentionally only used these for kexec.  I do question the current=20
upstream mainline code though.  Currently, when EFI_CERT_X509_SHA256_GUID
or EFI_CERT_SHA256_GUID entries are found in the dbx, they are applied=20
everywhere.  It seems like there should be a dbx revocation keyring=20
equivalent to the current platform keyring that is only used for pre-boot.=
=20

If that is a direction you would like to see this go in the future, let
me know, I=E2=80=99d be happy to work on it.

