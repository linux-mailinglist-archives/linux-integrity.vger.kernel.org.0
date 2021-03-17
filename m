Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8643F33F3AB
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Mar 2021 15:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhCQOtB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Mar 2021 10:49:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38896 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhCQOs6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 10:48:58 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HEmATW046038;
        Wed, 17 Mar 2021 14:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=H80uWJ85hSUk/gfcf4mEvpDUHB+7aV5CzVURGW2W5h4=;
 b=B3S6S6rhOHImHDxkr2OFQH5w1rO65c1+dNNeocTp19rUsjcgW4arte6TJ44TgMp7p7iy
 nVhqbx2+OYO81GxEoRx2/VSqDMxQBOhBDaEddEjpFJY2EtjM81EMftWXxmmT9cX8/BjW
 TqTY5x2qgPt46m9opC4qq/GI2RUNLpN+eYDUEFa2/QszHASzsNtIDts+5dy7iJNB60SA
 1ix2UpBQ8erJAOX2RxGQ+8FRqzrBIVozxr1c3uCnPfiOVkmkfcU+C0Lyp2Nr7JBpIR1o
 YFoQAIvnfPWVMbhZXWPpXVq47p2Xt5hqVYOb71o3IoAnWMaD1kLQ+t6DLLIokGccWdVd MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 378jwbmdmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 14:48:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HEQjqG028670;
        Wed, 17 Mar 2021 14:48:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3030.oracle.com with ESMTP id 3796yuwyra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 14:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fklojk6W/vHFduyY1ATSWaOPvHWNTQ8+38iL2haV+yGOwz5sZkBFRaCoMw0xxZVu8CCoUH2LkvgrZGxCb38YwYhKYnAMnVKp3Syo9GDgYxS4cKlJAj7bIVasTOhPJnDUeOhx1accmBI3gxcychHRn0vSh9s6EIn7cvLMTSnC62bjmGq2YylG/yqJFike7hku9vgeyFGUhA4bWHoPjzIYEwbsI+qzUYRENTu6cSq25E3l2SFjuSUo0ICcAlvkXsem7NIczkYeNez+pbauY+LR028BEjzr2EXleqqouh9S6Ca7sSZeL8NNjyFr2ZqxvtbEeqP4ttkaDU2wpq+MDrV5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H80uWJ85hSUk/gfcf4mEvpDUHB+7aV5CzVURGW2W5h4=;
 b=UubbqyLflUZhXPhj2Xoab+SpH9eWQjPbYU7BtvHWH76wMfFHCRpVdHKG3Pf2BwEN5/Ri8Y246u2RSqFCf+xcphbj4zxNqUDLqr6nmCBdkn+MEcsYmxW2ye76UOCy9HyuiCBQqVRrlRXnwbEAkFgXk0g6c0/IoZ0YmdGuFtXHnJHHw3crjX8aBcWyE5Aad236+yiuwwMA71bHA12BFAGacD7MbPNcTl7R4MP/KNkz+KPZroMevTCfrU66XGzVlVjdQBY+xQSqhEfywsQOXxG2P/c/CfTXRjCZrDhIOiXt1rK7EzX2VAT+l+7rBYHTBIIdTFTm/n1btmg/ybBtKoP5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H80uWJ85hSUk/gfcf4mEvpDUHB+7aV5CzVURGW2W5h4=;
 b=sjgaCO4XAS3YkDnzHm3PGIlaeZ0F3zGEqUKgdwQyqKfcf6LQT4OgZpbkjvkm/gCDCJdnc+HKP/HF6xGVSK3OPUbXYIQMeEo63GwKNG/dptXpv6NXO4hd449V6gziUw9iTtKCpQlg+LpyXlrCvCNEKyBxz7RsdmC5mDXH7ieY/JM=
Authentication-Results: digikod.net; dkim=none (message not signed)
 header.d=none;digikod.net; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 14:48:14 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::95df:950e:af4c:a5df]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::95df:950e:af4c:a5df%9]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 14:48:14 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v7 5/5] certs: Allow root user to append signed hashes to
 the blacklist keyring
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <bd28dd0b-b183-44bd-1928-59e3e1274045@digikod.net>
Date:   Wed, 17 Mar 2021 08:48:11 -0600
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
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5111D396-9910-48E9-8D91-6433E719EDB5@oracle.com>
References: <20210312171232.2681989-1-mic@digikod.net>
 <20210312171232.2681989-6-mic@digikod.net>
 <A4CD568A-6D8E-4043-971B-8E79FFB58709@oracle.com>
 <bd28dd0b-b183-44bd-1928-59e3e1274045@digikod.net>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
X-Mailer: Apple Mail (2.3273)
X-Originating-IP: [24.52.35.144]
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (24.52.35.144) by SJ0PR05CA0154.namprd05.prod.outlook.com (2603:10b6:a03:339::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Wed, 17 Mar 2021 14:48:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14650e86-42a3-4284-2e66-08d8e953b1a3
X-MS-TrafficTypeDiagnostic: CH0PR10MB5180:
X-Microsoft-Antispam-PRVS: <CH0PR10MB5180DA44D5672A4B73A1FB75876A9@CH0PR10MB5180.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jK7P5S7fWMp7OcSMuWheab5wpMBCNr+A6nHJEjoPQBZPyaZHKHz7e2OHqabwgx/Ci6/SK1GDxDn1fJ0iVut4ZAomH0hJVebJtKsDSKGf2YSAlrO81sbjboCOnlNC+npyXMiHRn4TrjDTmH482GsH5domU9CbyP8mWIegQDceYmrVh0JBGKpMA3y8JheAIq0UcZKSmSEUU14a1Is5b2lGAe59ZXnEo0ZESoQ2qyhzI0pSu/JVkaLWZmT6ujx2etustJelgLcoYtPuFHzaY2zq4b4PLg55L7LVeOXCi9M1S7F/DsJZJlhxL9exQebwTxX0HVF/QwTY1N5nZLySMyZB+e51UVWwlVvGKyqnN9FAQWgGPYLSnZoZtjI9UsnvQsXzt7lzoAIhqi6ZVp1sQy3YFQYJzznDM+0Zw12HAZrwmilGGVC+9LoQYnYszRxLTykvecJmwAycKnStCdAf2t1E2D5xJ9EbITP3/PjUGquUf89mnSHmUAyUI3bAz5et/LtB7XGO163xJn+vtOIG93Wk0pEYYVsfMjdAQy5Gd0aFR60dp15ixCSj2uQT14LohZICRg4if23bjmeEOpqQsZoELlZ8C7xz7z05HQxnX4jY/9PUI8SiT7z4tHdr9/Ou6KiElL6ByzPS8jQrtiWIAUwiX78Dxi8FZ6WnW9qYQwokA604FR5F6yVEIKb8x/VCqXHS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(39860400002)(136003)(346002)(316002)(36756003)(44832011)(5660300002)(16576012)(6916009)(6486002)(52116002)(66946007)(66556008)(66476007)(54906003)(53546011)(2616005)(956004)(8676002)(2906002)(7416002)(66574015)(8936002)(26005)(4326008)(16526019)(186003)(86362001)(33656002)(966005)(83380400001)(478600001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eExSbnA4NDdOUG5KN25zUEhQa1NuUXEwUEhTN2ZpSVhrWlo0NVFJZ29TOEo3?=
 =?utf-8?B?b2RENVdkcTZoUHFzRk9HU2F1WU9KUjVVUlgxYWNGN0FacnM4VStya2lhUU1U?=
 =?utf-8?B?Y0cvR0FLSHBhSmNKeGhSS3I3bVg1OENwMVd2Z3lSM2Q2Qmo0eFp3UVIrYlFk?=
 =?utf-8?B?aHdKL21HUFdXNS8xdnBRZUJTOWpBWnVEYk1qVTZjSUVXblM3dmViZnZlMTlt?=
 =?utf-8?B?UzcydHVkRnRwQkU0YXN1ZkVabzRVNFNRZzVDL2FrZWZ1NVVhWkg2Z2tZcno1?=
 =?utf-8?B?c3orU2s0TFdGOFJuaUZMWG1WNWROd2tJLzNWYXZOU3l5NEVqLzRzZjdNLzYw?=
 =?utf-8?B?U0NjWVJKTXdzbVQybk14M0ZlZDZuUTA1cVZXRHBPZlJlZWxjcVV1K0pBY0ZO?=
 =?utf-8?B?eHBLN25YRGMxSGpxYlFvL2g5ZkhaRnNDTWluWnZTSHRGRzRuVURSRFR6a0lT?=
 =?utf-8?B?TzgvVnJEWDh4UjJMVDN5ZEFKSUhlQklmOTl4WS9YODdVSjJacEM3KzQrV1lH?=
 =?utf-8?B?b1o4YUxxWktKZnRrRVBucjJjMndtdG5Wd0xwRjdDZzdqNFNMbXo1UVhDRWtM?=
 =?utf-8?B?aHk0SE1pWmZlNTZXSzhKMmowbVhacVIwVE1RU1FDK0pwcWR2UHdqSGh5Mk1n?=
 =?utf-8?B?K0xYR0RKVEQrUHRzdlk5M1ZxWGpINEFUdnhxVU5EZEx1b3Z1KzNWVVhsN01F?=
 =?utf-8?B?eFFRUlpkb1M1K1lJNDZYSEwyUEludFNhRVdlL0FSUERDMUxpNEhVOThoZWxI?=
 =?utf-8?B?N1VxT2w1dVZxMFgrdTNCbExHdmliWVJmdFN6RnVXelVOYTl3cjIxbWFLcjBV?=
 =?utf-8?B?TWpOaFB1ZU1sRDBHV1AvdjF4ZEJqK1FxTnVXY05zRHFQZlV1Tzg3RWQrZzFy?=
 =?utf-8?B?cnV6cmVpYms0N1BVZFBTYm91alk1dVB5ZGRQcFhvQzZGM2YyMEM2NGJYSkM1?=
 =?utf-8?B?bTlIbFExNkJXMHpTSS95ZnRjd2lFUHM1UHEvaG1TT25PNzNCelE3TjNrWmsr?=
 =?utf-8?B?VmtZSlAvbUMzWkViWjRtWlliS0k3VHdtVnY5SVhJZ3VML1E5WmNYdmloQ1pF?=
 =?utf-8?B?WTNabVRJZjFheERiV2JYRHEzYWhlV1ZaVTFPZ0FLY1BKMGdJYWYveHBQVjdx?=
 =?utf-8?B?T1VLaFZpQ0lKaTNYZlpQSGRCNG9SUjJXRTZrRFJjbmQ4RythRFRqRC9haVJF?=
 =?utf-8?B?ZmFJbHYzRDlFUjFtdmtxcEJ0QllFa1QvYXhGNGdNU1E2dnVlV2MzaE9QL2NX?=
 =?utf-8?B?Tml0Wm9EakdRcS91VkRGeXBMMS9odk9BZVNPbFFNWVMzSHpzWlAxQkp0YktO?=
 =?utf-8?B?dG9BcGtrekdJamt1RklnRDNmQnNOQ01ZczBiQ1dZVWVkYzdhVzJhR08vVS9o?=
 =?utf-8?B?dmdYRndCWUkyLzZpOVl3V0xGT0w5a2RzUGJtU2UwV2luMFNPZ0dxQldPRkRS?=
 =?utf-8?B?Yy9BUHlNUFNlUjVaQmQyUzU0SG5UUXRtZk01eXhvWmlObkxXcmtUMjBhb1B1?=
 =?utf-8?B?aGlkVzY4MHpkWVZSa281eTBBVm1lYTFqSFVmaFMrdlhFNFZ6b1dNQnFQUXBn?=
 =?utf-8?B?S3VLQzBKUkx2cXR6RDFvdllUZzlnMzZRRkVSVWF0aCtIdWlsQ3AvbXc2ZXBD?=
 =?utf-8?B?L0h2YkhwbGJ6akJ5dC9JZkx2ZkRWd0hHMTNRdHpOYzlXdEx1REVxQ1BsaTBy?=
 =?utf-8?B?WFhaTWw4SjFhYVRWWFRSOVhjODhvZkxiUHVmQUp4eENjU3RXZld4cEJha3ZN?=
 =?utf-8?Q?XOYnZU8N7ThSV2N8RcZOHL+6y0LyedbDkKqCefr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14650e86-42a3-4284-2e66-08d8e953b1a3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 14:48:14.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeFky3Qd8hAflBaUCAWqwcSua0FPf9SPl8r8Uu6ZYiP7FBHdRXbhdB6tflKnspMHiYPLpY935/BPLmAy42jG6JUl1UL2dXhXiFJiTAQpGCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Mar 15, 2021, at 12:01 PM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>=20
>=20
> On 15/03/2021 17:59, Eric Snowberg wrote:
>>=20
>>> On Mar 12, 2021, at 10:12 AM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net=
> wrote:
>>>=20
>>> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>>>=20
>>> Add a kernel option SYSTEM_BLACKLIST_AUTH_UPDATE to enable the root use=
r
>>> to dynamically add new keys to the blacklist keyring.  This enables to
>>> invalidate new certificates, either from being loaded in a keyring, or
>>> from being trusted in a PKCS#7 certificate chain.  This also enables to
>>> add new file hashes to be denied by the integrity infrastructure.
>>>=20
>>> Being able to untrust a certificate which could have normaly been
>>> trusted is a sensitive operation.  This is why adding new hashes to the
>>> blacklist keyring is only allowed when these hashes are signed and
>>> vouched by the builtin trusted keyring.  A blacklist hash is stored as =
a
>>> key description.  The PKCS#7 signature of this description must be
>>> provided as the key payload.
>>>=20
>>> Marking a certificate as untrusted should be enforced while the system
>>> is running.  It is then forbiden to remove such blacklist keys.
>>>=20
>>> Update blacklist keyring, blacklist key and revoked certificate access =
rights:
>>> * allows the root user to search for a specific blacklisted hash, which
>>> make sense because the descriptions are already viewable;
>>> * forbids key update (blacklist and asymmetric ones);
>>> * restricts kernel rights on the blacklist keyring to align with the
>>> root user rights.
>>>=20
>>> See help in tools/certs/print-cert-tbs-hash.sh .
>>>=20
>>> Cc: David Howells <dhowells@redhat.com>
>>> Cc: David Woodhouse <dwmw2@infradead.org>
>>> Cc: Eric Snowberg <eric.snowberg@oracle.com>
>>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>>> Link: https://lore.kernel.org/r/20210312171232.2681989-6-mic@digikod.ne=
t
>>=20
>> I tried testing this, it doesn=E2=80=99t work as I would expect. =20
>> Here is my test setup:
>>=20
>> Kernel built with two keys compiled into the builtin_trusted_keys keyrin=
g
>>=20
>> Generated a tbs cert from one of the keys and signed it with the other k=
ey
>>=20
>> As root, added the tbs cert hash to the blacklist keyring
>>=20
>> Verified the tbs hash is in the blacklist keyring
>>=20
>> Enabled lockdown to enforce kernel module signature checking
>>=20
>> Signed a kernel module with the key I just blacklisted
>>=20
>> Load the kernel module=20
>>=20
>> I=E2=80=99m seeing the kernel module load, I would expect this to fail, =
since the=20
>> key is now blacklisted.  Or is this change just supposed to prevent new =
keys=20
>> from being added in the future?
>=20
> This is the expected behavior and the way the blacklist keyring is
> currently used, as explained in the commit message:
> "This enables to invalidate new certificates, either from being loaded
> in a keyring, or from being trusted in a PKCS#7 certificate chain."
>=20
> If you want a (trusted root) key to be untrusted, you need to remove it
> from the keyring, which is not allowed for the builtin trusted keyring.

Is there a non technical reason why this can not be changed to also apply t=
o
builtin trusted keys? If a user had the same tbs cert hash in their dbx and=
=20
soon mokx, the hash would show up in the .blacklist keyring and invalidate=
=20
any key in the builtin_trusted_keys keyring. After adding the same hash wit=
h=20
this series, it shows up in the .blacklist_keyring but the value is ignored=
=20
by operations using the builtin_trusted_keys keyring.  It just seems=20
incomplete to me, or did I miss an earlier discussion on this topic?

