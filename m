Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8300133C31E
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Mar 2021 18:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhCORAV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Mar 2021 13:00:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhCOQ7y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Mar 2021 12:59:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FGjAK7114417;
        Mon, 15 Mar 2021 16:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=zMVUWA2MpXQ6FkzNciX36tVWDv5cTQHzZJuOG4lrlDM=;
 b=A215Ye1JlBQGCcjN0vggK/6CZAJu3mGMeHBcXnvuVjCdEov1+OS6XsuVI+8gYkbZGSNR
 BMbX/I1qiZyytQwqQCFC+GzRk7ZOMhHnPLmhsSxYocYyB3H/ihF1HcfGm7rgnCMXd+JI
 Xodu/DA49h0FsmtBT0ThLTQNxVdvclNj3s9qPWh5LPMrw+pwh+P+OLdYtwGolr4HZdjP
 lISucIwnp41VaTL9d6iXPJWuZJHSTRx2iNWMuXMNVhumPKGUOuMmnXXxMnmQ1kX5DFfS
 UTEF2egMB66oh+Is/EtOvlBOT39tZgvCbhxwsjFtir9o8iBiEZ+ngkztsEcqQT4tt2FC /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 378nbm4may-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 16:59:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FGjrRe179287;
        Mon, 15 Mar 2021 16:59:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3020.oracle.com with ESMTP id 3797a04c03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 16:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT+/5UQQpgU7OWkvVgpfXrE6aNQdVyejes/yNGQyIZ3kDrTQpS5INA8PCq1eyVO90Sbx5R8UVXqhb5lxNOQqDYpWiftWD0BigJcXJn1gxHgFbeD7gVx559qE98auu7wtkAM/qgpYZIjXF1zelmVbI5givIj0EzIEbyTqwAfI0UkfqrRYsyQfE5oo1nAd+LmtMSm/bDH2KM8h9gXuSZXmh3IrdrkXHSfO/cdy7y0aVl5nygdd7oUva/e1GfnNZqfxpwGTOj/jlu9bZy/25EoK9OTpj6ZXxeyck2+PuiQI29ZTbJl28WscC+tw/olQRdk219kNxy/Q0eQxL9bq18wD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMVUWA2MpXQ6FkzNciX36tVWDv5cTQHzZJuOG4lrlDM=;
 b=f2k4OwSnJrw9Cz90I9BtOG9pbmEfj93HliEdAE3fUHKZ0lWBaVfWwlsYgS20rgU7c+9mv32vXXfrKpRoh7tfFE/gZKboqjrXTN862cl/4vUQMv45r/Ex1Gc5v6BOc4ZCrBVn+Es9WXypIEHp9MUFHhD0jhtyQWECCwzBeFN3+xeGc+PIIHCCwVzzDtmPLrYBD09gBl8kqaOJ6i7k5tIDw924Evq1nt2k86i3nT6QYjlPslPuHzHnvDAy9+gortY5tUZoSxxebS4sx8MlmmHKPdqSgU2jWH4YR94Pt5r4eXHmycEMmpNbvfEw+h49UWOvkJDJspi0+9LmCQkTJWyNsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMVUWA2MpXQ6FkzNciX36tVWDv5cTQHzZJuOG4lrlDM=;
 b=GuOcmPnyM4yBFFl9ES+hsBTAGENSnoXyaug12f6X2b7SRPNtsXIQEDG5XlujO95HtrS35RaxEYO2Ir45+ZCGgXc0ZZeGWUrFkZIokdI9x8xlyLdbwm/wHbCs6QCe6Kr1YN+Mlh41RSv/0E1W/V3W9buMbmKQwn+qLh2Oou19IpQ=
Authentication-Results: digikod.net; dkim=none (message not signed)
 header.d=none;digikod.net; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 16:59:22 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::95df:950e:af4c:a5df]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::95df:950e:af4c:a5df%9]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 16:59:22 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v7 5/5] certs: Allow root user to append signed hashes to
 the blacklist keyring
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <20210312171232.2681989-6-mic@digikod.net>
Date:   Mon, 15 Mar 2021 10:59:16 -0600
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4CD568A-6D8E-4043-971B-8E79FFB58709@oracle.com>
References: <20210312171232.2681989-1-mic@digikod.net>
 <20210312171232.2681989-6-mic@digikod.net>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
X-Mailer: Apple Mail (2.3273)
X-Originating-IP: [24.52.35.144]
X-ClientProxiedBy: BYAPR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:a03:80::34) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (24.52.35.144) by BYAPR11CA0057.namprd11.prod.outlook.com (2603:10b6:a03:80::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 16:59:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad5ca2ae-001e-4b88-c8e2-08d8e7d3ae5b
X-MS-TrafficTypeDiagnostic: CH0PR10MB5180:
X-Microsoft-Antispam-PRVS: <CH0PR10MB518054AD41DE6A57250FD93D876C9@CH0PR10MB5180.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pizUSCGWW9L8uCzxOXde3zySb3nMvxc2l5GU9ur0JyEf0YX1JjdzPLn4qXv8e01HJtxSsEi1ob4MhvPuevig0KNuwMgU7evWambBnK8Jq4s4Aat+G/iF4DjhCl7LEOjsaEUVnx2SN7kyxNcorBqcI/BHQdbS1v4wNHPJOJNC3CLXjs3cQYFMrk8cArIX/hPFkfhGJZJn1V9nEyJjMMLlkNAlG3y4eFT+2JD0eR+TbWd0TvCnbKY5Ub5NUwruEGXpFzkeUhxyDpNF463pxBKKGahQkEEiGj293qGGs9N9uKkMdFTlMgl1MTyulS3m1GRVQanJKea6FSpMIBI7rDhpq4KdjYMWxhGjRc0mQe5oK/FRA4CNKWqbOHtfH5GoDPBwSMLNYfQnfV5b5o4U3eAkbAPSTHc+vF9quNNvAUHMIQCtFBr8LY84E6voiMOA7kV0CIpYErlwdfrSt7Ds+AsL+B98ard7V3ORhW4lNRctjPzP5/acTQb/rm0EOaVOJdpEz/yi1kfSQS2GaC9avdTFYeDZ4rCG2FLVuY682QD8/3qM8xO3V2UCr0yBbayEwVtZrBXhOH0AHHAQtwAVQabxr3TL/mGPdB2vx1Gd1zammyeuWtWbFC7f3zzuIymUHaj8GH1hXVuzoZjx1DmuEricXetZ2QFrb+jkNCPLQU9dXYQDAeuNUtGHmJtmbxpRWrQJ5BwZqYZHwzHNSD58dXrVMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(86362001)(26005)(6916009)(36756003)(44832011)(966005)(53546011)(66946007)(6666004)(316002)(83380400001)(7416002)(52116002)(956004)(2906002)(66574015)(186003)(66556008)(478600001)(54906003)(33656002)(66476007)(2616005)(5660300002)(4326008)(16576012)(8676002)(6486002)(16526019)(8936002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WnFndnUxQlJlclQ5ejB0YnlMbEVhaU5LNHFlemlMOXhvd2hhdllMQ1BmS0ZC?=
 =?utf-8?B?TmlKcU1OOHBORll0cEhBSFR2QVNyaGQvVkJQbzdBdURaK2JJRmxQdGYzT3Jz?=
 =?utf-8?B?Q1ZRT2tCdno2MEFld2pub09HYysvSW50UjczUXJxMCt0WjRENTd2bWllK2da?=
 =?utf-8?B?ZjJsbTdJM2ZQYTR6ZWFsNTJWc1ZJRWhQd2svdDZyQmxYWkNYQlVDV3hHdHNy?=
 =?utf-8?B?ZGZ2T3IzczlMWVZPYW0yQ3duS3RNamJCNXpJSXZoTUpjUUFNeEFXRUFGb2V2?=
 =?utf-8?B?ZzkveHVSWng3SzIyci91OFA4U2hmUmdDbFJGSVVyVzVWSnNxOGdFZFdRS2J6?=
 =?utf-8?B?NzcwOSswbW9URlN6cFpIbVFFUDFIektSdENTRzRKY3lWWFFUb2ZldkpFQlhp?=
 =?utf-8?B?S1hYeUw3TUFhMTUwUFI0YVA3b24yQTV2TENyR0ttSGV5NEQ3VEJjR2N2WTN6?=
 =?utf-8?B?WjFjODVQbUtzZXhvcDFlVUorWHIybGNJWmU2cUZkcDVQWi94TCtLS2FLbVVL?=
 =?utf-8?B?M1JEalhITmdSNVptc0dyZzFCQkVkaVZwd1JhV1BVVUNVWFhlYXVXeGgzMHQ4?=
 =?utf-8?B?c0NZUStPVWthQUp0M3Arcy9pb0FIQXJwMXYvc3U3S1ZHYStTWmpzTW1uNytj?=
 =?utf-8?B?UE4ra3FSQnJhdDJROGlNUHZzeEQyRmNrdVB0NVdPcVRrMDhTenNBOXF2RU5o?=
 =?utf-8?B?YTdkUE0wODc3YlNKTU9neGxTaFhsSlVTMGh1aWltOHR6K1hPeStKdy9mYkdZ?=
 =?utf-8?B?YW5jUnc3WldySDdEOGl1c2ZKN0xkWE1iTlVIdXlKV2lqSzBlMk9QNHNvTUlh?=
 =?utf-8?B?WCtHM0JMYk1PQW1GL3lBVVZhYUlmcmpOMWlZcXJRQ2M0U0NuK1A1UUZ2SWVN?=
 =?utf-8?B?MW0xWFBNd3VuSklnQmxvcUFnR2tzc1IrKzJyc2JEVkl0RWcwdEdKU2dNUVAr?=
 =?utf-8?B?dEhXa3Irc1RPejFXWDliN1p1S3IxaVV5VDcyT2VPbHRBUGtabDJQeEhlelo3?=
 =?utf-8?B?SmJLdW5uU3doUjFxUVg5SEQvOTBKUlR5aGFMS09XWUg0UVlPT3FvNGY0MTlH?=
 =?utf-8?B?dWtpMTdYb2JDcC9jTzRoRWdXY1NlRkRtU2FjRXRjM3FFamRkMXpPa1R1V2hp?=
 =?utf-8?B?S2VDWTBReEtoejcyRDFRRUtxVnJIWkxaQzZzeTM5a1VQWTdZajlaQWtwa3M2?=
 =?utf-8?B?ZmxaZ3hSN2lEbmJGeEt5K3hEeGNoWkhSSzkzRXI4T3IxS0NCSCtKZ2Zkbzht?=
 =?utf-8?B?WUJ5SGhrUk5BUDJCY3ovZkk1d29vYUp0c2Mza3B4WE43WWNJVVlmUzgwTlUw?=
 =?utf-8?B?WHYrNTdtaXNsdFdpTjFpelRZMkp1OHJwcjdpdkdsWURhem5LNCtYMWNtZkoy?=
 =?utf-8?B?S3VNeFV5dW05NmRWcVlxZVI2YVFRcW1oZmR3TC9NaFcrYXlsK1YzVUEzNi9E?=
 =?utf-8?B?V0l5VVA5Slk0OGVoTko1RVZZTmIwaHVDYnA0cFM1V1d0YjB5TERKUmhNZE9y?=
 =?utf-8?B?ckF0UDNsNVdUZktPUzAvVUp2L2J1OU1Od0VqNXg1b0lUbzR4Zjd2Y29qVk9O?=
 =?utf-8?B?Tk5sQ0N4RFNPWVpWb2dDMGo5MGpJb0hyUEwrWGluc1BJTytHUWhhaGRZNWs5?=
 =?utf-8?B?RHlsZXhZUnpQVE5Pb1dXeE1QWnM2UkNZWDkrWVA5Q2E0ZU4vNncyWTF5VTRw?=
 =?utf-8?B?QWQvVnhsc3U2SE1hdWlkZ28vNmxwMnpUTmhDdXRwdkRFQnVSbXRtMFNPODZK?=
 =?utf-8?Q?5+E/Owl587opVPVMw1jN8D5ctaAEh+FZSFyIipC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5ca2ae-001e-4b88-c8e2-08d8e7d3ae5b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 16:59:22.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M78N0nafXUSRtzXqCwNBW8hgqIcp9aDXunIZDuRc+h8Os4YYUH4g5OT3a82viLBJE6dM9vZ4FsgW0YMvNhRu4OdM6YxgsfJsWbcw50G2CUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Mar 12, 2021, at 10:12 AM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>=20
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>=20
> Add a kernel option SYSTEM_BLACKLIST_AUTH_UPDATE to enable the root user
> to dynamically add new keys to the blacklist keyring.  This enables to
> invalidate new certificates, either from being loaded in a keyring, or
> from being trusted in a PKCS#7 certificate chain.  This also enables to
> add new file hashes to be denied by the integrity infrastructure.
>=20
> Being able to untrust a certificate which could have normaly been
> trusted is a sensitive operation.  This is why adding new hashes to the
> blacklist keyring is only allowed when these hashes are signed and
> vouched by the builtin trusted keyring.  A blacklist hash is stored as a
> key description.  The PKCS#7 signature of this description must be
> provided as the key payload.
>=20
> Marking a certificate as untrusted should be enforced while the system
> is running.  It is then forbiden to remove such blacklist keys.
>=20
> Update blacklist keyring, blacklist key and revoked certificate access ri=
ghts:
> * allows the root user to search for a specific blacklisted hash, which
>  make sense because the descriptions are already viewable;
> * forbids key update (blacklist and asymmetric ones);
> * restricts kernel rights on the blacklist keyring to align with the
>  root user rights.
>=20
> See help in tools/certs/print-cert-tbs-hash.sh .
>=20
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Eric Snowberg <eric.snowberg@oracle.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20210312171232.2681989-6-mic@digikod.net

I tried testing this, it doesn=E2=80=99t work as I would expect. =20
Here is my test setup:

Kernel built with two keys compiled into the builtin_trusted_keys keyring

Generated a tbs cert from one of the keys and signed it with the other key

As root, added the tbs cert hash to the blacklist keyring

Verified the tbs hash is in the blacklist keyring

Enabled lockdown to enforce kernel module signature checking

Signed a kernel module with the key I just blacklisted

Load the kernel module=20

I=E2=80=99m seeing the kernel module load, I would expect this to fail, sin=
ce the=20
key is now blacklisted.  Or is this change just supposed to prevent new key=
s=20
from being added in the future?


