Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D37A3E2D12
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Aug 2021 17:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242832AbhHFPBi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Aug 2021 11:01:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6140 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242443AbhHFPBh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Aug 2021 11:01:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176EpATF024848;
        Fri, 6 Aug 2021 15:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=wtofodPOjEqRfemeRqUTJ0/2jGdlXfX3g3bIwkrsGvQ=;
 b=ffKJmJgzy0jGVwZhzajfn8UOrSMLbS6ODOPa7VOcins6zI3OJzq75GJf62HiOUxMSyHb
 I2zVRwl/lk1xWjyZ/xDYe4TpcGjmLNh02A8gY3hVbA5835ICRT9JH5btpteo7iG701oZ
 99cl4FFbuPLN5ViclS6IPK1xZoTXSkEgI4Y0fz2hk5I+UE3R/NUplBN+ccn8MQBqj7Tp
 bLvXs5s46PiiJ229rfY3P9pNc52kkBCHpfF8dEiVDgjWkoavRkSkI1/4Ih5xho5soxF9
 YyGr/ucgskseKWK3FBRDc4awU0OzzIi1qIW0p/Ktc5R59uHtrUnLNfMomvFkspCYvKad Og== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=wtofodPOjEqRfemeRqUTJ0/2jGdlXfX3g3bIwkrsGvQ=;
 b=exBNnlAfu7b0DXkAlTw4MKT1e6AK+fLBb0LAS6kRZTj7zgI9d+9KrTT5tWV1qEuU1+ul
 6zHRUf4ZBEfkmTM0vgCUHpPiK26lL2DsA7/3Ys9Qe9PCRSMNnyHTllQcabb+LKKmNzSg
 myj1xsK1eKGZi+RD1eFrS6H9I2S148WBvAH1BrxGkMLdLKX7PWjsHjiKNxnihzoiID9U
 ZW2xFhcGzK0ZHSztOvaymIaCOBYSshnn9eZXJyybUew6o0XOgfs1FnMonYbDgmsLik7b
 dlVZny2vZp4r+agq6YJt5cNZ9cC09+s+lVXwRMlFb/Vs4DtCCRCWS/QDuDFAe0URMqfk Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a90jus0kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 15:00:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 176F0Iqg143744;
        Fri, 6 Aug 2021 15:00:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 3a78dan0sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 15:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDaGGHJYCw6HWfNGVti6pDeUf8hV9HgHN5gF16vRwtf0R3KnFwphxaApxWFO62L45x7nQN3mcEjmJzUQSUiYqVbt9To7cPwfYo6oLcSKROnlB9DHmyskGF8ugbyAo+bP6VDDGxVC3PDhm0+//Gtfbt1KTY/T8+hlhCngFvWoto713UqgkKTlSuh8KMysvgjRcws2HhW+um2YdnZQZuNWUP6pFh+hhtx9CCcTnyYgGANvRyAmBrV10u53Oc/v3QKsn+gXZ9cWhUBcT51I+6jhIdD3umBKm7lgxUqc814Z8ySbM4mRHO5ZvzXzDfNMKaKJRsJGgVo5gdXeFjA+UVhAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtofodPOjEqRfemeRqUTJ0/2jGdlXfX3g3bIwkrsGvQ=;
 b=DbV7HTKGye+p9yzT8DWmJfCIqbqupI3OvaTG1BrO62m8uBeovg167Czx0SQfb1mCh3wUNe+4bDlnrfuXn9Y0AyvkPP1rRNmCQK+bdJvRwy8RGbS+U/FUnC/K8Tb5sHVxZD/SRqJ7COsma4/xIYFY/6JbTW17Ylu12MInk9bLYh9H2uOA04JXXrBvs5v0e6TpobkAoUMZz22eq1JVyf9ZEV3ItInrIXLgiPOD5kEsX0FwPqIzeqZMbI3Iwq9b8Nz8jhkegxih89dinWo4WzNvYNZmAYFlh2OzX4wBkT6qgutanEcX6NzeYXmhvI7HV8AlfIV1P7zTQJUy/aOEooZQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtofodPOjEqRfemeRqUTJ0/2jGdlXfX3g3bIwkrsGvQ=;
 b=XeJLvHt+q/KEuPnN7dORXRAMLtsE7jgKGqKCCU4ti+zyrnnDZ44S2G4uNL46kLIIZBjICmQaLQp9z29a8+Bs6FrJufnr1g2r6B89MGqvEKRW4Wv5OQwqrWoMGuM6+lu5f7dWC5b6rTIrKP7cXBwbDmQSiEZJsyT29WTtK0qSQog=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4157.namprd10.prod.outlook.com (2603:10b6:208:1dc::18)
 by MN2PR10MB4030.namprd10.prod.outlook.com (2603:10b6:208:1bd::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 15:00:29 +0000
Received: from MN2PR10MB4157.namprd10.prod.outlook.com
 ([fe80::e876:8eb5:23ed:d99b]) by MN2PR10MB4157.namprd10.prod.outlook.com
 ([fe80::e876:8eb5:23ed:d99b%5]) with mapi id 15.20.4394.017; Fri, 6 Aug 2021
 15:00:29 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH RFC v2 10/12] KEYS: link system_trusted_keys to
 mok_trusted_keys
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <d85bfe88bb4abd06e47a36743f53d0610da0a259.camel@linux.ibm.com>
Date:   Fri, 6 Aug 2021 09:00:20 -0600
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
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <21CB8F51-9066-4095-9C6E-428FF9E86443@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
 <20210726171319.3133879-11-eric.snowberg@oracle.com>
 <6c751dadf4ce7385d0391ea26f1c7e4e910219e0.camel@linux.ibm.com>
 <44ADB68B-4310-462B-96A8-2F69759BA2D8@oracle.com>
 <d85bfe88bb4abd06e47a36743f53d0610da0a259.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To MN2PR10MB4157.namprd10.prod.outlook.com
 (2603:10b6:208:1dc::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (184.60.195.210) by BYAPR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:74::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Fri, 6 Aug 2021 15:00:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde8b54a-6394-4372-b67f-08d958eaee06
X-MS-TrafficTypeDiagnostic: MN2PR10MB4030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB4030C152BEB086D048ADB5DA87F39@MN2PR10MB4030.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuebFQ/Nl1h/ERxBI62MIB+IBCLmsw/WTlTUYjSfkUM4P0/P7mpdMqC4mcSrBn5plq2JV+BHwEid4Aq/f6usfbTtriKkUBmYjV1cIOHI+YUOj1hy2oJRNQ+IjOtkI6Dxr/9mA+3VHdrMFmPISpPOa1iqSQ6T/FrUW/p0j7wr06D6ecb1CznBcZlNADXU/KDWqkeiLHQBNfYPAdEzNWew/Oyaetg0dQqVOs2zv3gV4uLk/FC6BikQ1TePph+BxSxqKrA1D5dN0h3tSLFoLX/KAJB0xm8UK7gaR8Ml0vLZMr6PrqXeIwJZ123Ag6qFKxJo7wy5ySOA6c7A5PIXWHm2X7GHO95uV34yeNMOymFHLGo/1jyXnta26WojP3/swEL3xeQVAYquDoTvDLXhQyvfEvhmTmjp+59LVQV/AYmRZ3nKTHEdACZDqQ/I0MgQ0ywazgtHfcUOZH+CKc9JxtEm/37qNy0MFYmUDHkYwTIWrOZOXPH6+180Xaf9KYBppCSBVIolEvU09WAC7WWuokmh4fU8N2ZSPb2tXZGkZxl1qjYPn9NRFRSio+QKdIjhXMCF2Nr58o7n+88BO+LyTPuMwSC3e/xwM6DtX/N/MitOhIE4eLAw8B1kYNGDxWIaDMNsFIdCe+o+Yv89UtV3lCsCmguB5ecZsmcL3Oo10iaCl1R/qIf3/PpLNMqiuOlczhojNLkGrP9tg48SRUVdVKQnsh+8EmHcS5tv3iM4gwZayIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4157.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(136003)(39860400002)(38100700002)(33656002)(478600001)(38350700002)(26005)(956004)(2906002)(2616005)(36756003)(54906003)(44832011)(6486002)(186003)(16576012)(316002)(5660300002)(83380400001)(7416002)(4326008)(6916009)(6666004)(107886003)(8936002)(52116002)(8676002)(86362001)(53546011)(66556008)(66476007)(66946007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWIyLzZpdkpNOEtLNzQvUzV6S2VqSWxBYnU5RmhBcjlmS3BEcTBqMnNqWnNu?=
 =?utf-8?B?MGhKcDFiMDhCTjhnVmVSbCtvOW5Qcm5EK0lUQ1lEbU5zOVZ4Z0xHaTlnOG9n?=
 =?utf-8?B?dVJuSitMVjU0YlJLLzBXTGpvU2FnRDd2cW1CRGl2VE1SSXJsU3kwaXVpbHlo?=
 =?utf-8?B?UmZ2NkYwWk1NaTdpUWZjZS9UVEtlMTVXQVdkRDROMlcyNGhMbVc1OGlJejlT?=
 =?utf-8?B?dHB5K2NmUmsrKzlzNFpkbTBXZ0tHZWQ2SFRVOWZwTUE5Y1hwbEZTQ3YyMXhi?=
 =?utf-8?B?b0FPVVRUT0RnS3djL2tLOEQwdzNNTUx5S1RrQ0Rmb3J6bGZuY3Q1Wit4MXI5?=
 =?utf-8?B?a2RSTy9OK25qRXhoclVQdEV1TDZJZHpLQXBhNGt6OHVWQUY5dGFuaElJcndB?=
 =?utf-8?B?NlBab3g3Z0hQYlhadm1DUkZxV3lxS2Z5WnlxaVNUSU1PamhhenVucVNPbkdw?=
 =?utf-8?B?aTkzUDU4RWd4QktwekllWlRReittNVE1MDJ4elBaclZXUUJ1TGtteTJWaEpt?=
 =?utf-8?B?OUhXMW5WcDlHNFJwUlZqSTJ4Z2JrVHluUXp2aitRcG1BTTFzbVRJa3RYMHRt?=
 =?utf-8?B?Vnk1TDk4TnRLNU9kanpKRFFqWlJNS0dxQnlyR1dKSnlzbSswK1BpNldzNTZz?=
 =?utf-8?B?b1Jzc0poRDdOYVo1dlhKY1hQd3lzY2JOMTRGdHQyOTRDVEtaTzNqSUg5Y3ph?=
 =?utf-8?B?cjdSVWFtUW5TWEFmL3paL0dxaUtiUTluN2tWc3JRK3F4eFY3WHpUSjhpeVda?=
 =?utf-8?B?RmVaZ0ZoL3JwN2I5TDhCRmtvK1BaZ0ovc2tvL0xiQjBZcWdaVnhhdHNqNzJ5?=
 =?utf-8?B?ZTRDckV5d0hjcVZaWThBZkV3OGtGa3BldHpCc2lLWFhqRTdOOXY5bFE4eEZZ?=
 =?utf-8?B?dVZWM21VWU1ZVlFhaFZ2MjZYTGJTdkx0Q0ZLKzBEQVlsb1puM0djN0Jqck5J?=
 =?utf-8?B?bS9UaTNWdCtDcG5XaU4zUUxWbkJmR2JHTmxnVHRwdEcrOGdKNWRGNnJpNC9o?=
 =?utf-8?B?V3VkSUVGL0VWU0l4WW02ZmxnL0xhMU9HVFN1OExhSC9UUjM0aG9kWUM0aFQx?=
 =?utf-8?B?RFpwOTFkQTlLUDVIY0JkM0xvU0NVSFZzKzFBL2RoVFB4Zy9ISHVzQnBWMmYw?=
 =?utf-8?B?SDFPMUJWd05zRkZ5aDc4V0dpWUdMMCs5RE93OExLOVlCUHpFd1Z4WVgrYldV?=
 =?utf-8?B?N25XVjkvRlZyMFVoSXFML0VGaUVJeDFVR0t4WTJ0djVXblpRenA3RmUxa3Bq?=
 =?utf-8?B?aThOVzRPdXQxVDlGeVhyL0xNNng3TUxvNlV4a0U2eHhqOWhvbnRtLzZQV1hV?=
 =?utf-8?B?RDJ2NkZCRGxPdmZGeUsrcGNkNjBhS0lSUXVrcnBCSk4xako0dGdrK0xGZkdB?=
 =?utf-8?B?Rjg0RzdmZnZTVHNscHZaOVkwNG1aTThhN2c3OGhqSWpTazRhZ1dtOEFlNGJL?=
 =?utf-8?B?RTZBbUthTFNJWTNvWnYzK3k3aEdhWG1XU0wvSUR5YVBvQjczNVIya3hYakNB?=
 =?utf-8?B?NXBoL0xXakhCc0NacFYwdWtVNDVPdFJKN2tJN2JMQzlxcWhZWjhGN25TMWc0?=
 =?utf-8?B?eWtGMXRCdG1VdUp5cGtNS25VTHltbnZUZ1ZHSklUSHo4RUo5QXh4SlQ2Lytx?=
 =?utf-8?B?VFYvenIvNDhJTTFCaktHWmJEcUFBdW0xdkdLQzRZR0NFVEFOMjhjWHMwU2p4?=
 =?utf-8?B?MVUveXBkN1RpSlVJTzhrU25ydjEvQ1dmemdheGZSbVpiVG9Rcnd3YlJqMVpr?=
 =?utf-8?Q?5JXJwKYlkPyneFXD/hcAhgauDIZDrYxGzayfQJo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde8b54a-6394-4372-b67f-08d958eaee06
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4157.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 15:00:29.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOvTPQTkkhFoUj66nLM1b/hmoascPBCigVh4ojyNzd6oQ923duoCyGQZ+OjigRKlh48vCckLmDaHE+Tt6pZsQjhu6dySRI1niF0Cc3k2Gnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4030
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10068 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060104
X-Proofpoint-ORIG-GUID: AqFCpAvWOQ9cjF9yBLsQRYvjalnB_t6B
X-Proofpoint-GUID: AqFCpAvWOQ9cjF9yBLsQRYvjalnB_t6B
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 5, 2021, at 9:19 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Thu, 2021-08-05 at 19:29 -0600, Eric Snowberg wrote:
>=20
>>> From the thread discussion on 00/12:
>>>=20
>>> Only the builtin keys should ever be on the builtin keyring.  The
>>> builtin keyring would need to be linked to the mok keyring.  But in the
>>> secondary keyring case, the mok keyring would be linked to the
>>> secondary keyring, similar to how the builtin keyring is linked to the
>>> secondary keyring.
>>>=20
>>>       if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0)
>>>               panic("Can't link trusted keyrings\n");
>>=20
>>=20
>> This part is confusing me though.
>>=20
>> Here are some of the tests I=E2=80=99m performing with the current serie=
s:
>>=20
>> Initial setup:
>> Create and enroll my own key into the MOK.
>> Sign a kernel, kernel module and IMA key with my new CA key.
>> Boot with lockdown enabled (to enforce sig validation).
>>=20
>> Kernel built with CONFIG_SECONDARY_TRUSTED_KEYRING=3Dy
>>=20
>> $ keyctl show %:.secondary_trusted_keys
>> Keyring
>> 530463486 ---lswrv      0     0  keyring: .secondary_trusted_keys
>> 411466727 ---lswrv      0     0   \_ keyring: .builtin_trusted_keys
>> 979167715 ---lswrv      0     0   |   \_ asymmetric: Build time autogene=
rated kernel key: 07a56e29cfa1e21379aff2c522efff7d1963202a
>> 534573591 ---lswrv      0     0   |   \_ asymmetric: Oracle-CA: Oracle c=
ertificate signing key: aeefb4bfde095cacaabff81dd266974b1b4e23b8
>> 968109018 ---lswrv      0     0   \_ keyring: .mok
>> 857795115 ---lswrv      0     0       \_ asymmetric: Erics-CA: UEK signi=
ng key: 9bfa6860483aa46bd83f7fa1289d9fc35799e93b
>>=20
>> With this setup I can:
>> * load a kernel module signed with my CA key
>> * run "kexec -ls" with the kernel signed with my CA key
>> * run "kexec -ls" with a kernel signed by a key in the platform keyring
>> * load another key into the secondary trusted keyring that is signed by =
my CA key
>> * load a key into the ima keyring, signed by my CA key
>>=20
>> Kernel built without CONFIG_SECONDARY_TRUSTED_KEYRING defined
>>=20
>> $ keyctl show %:.builtin_trusted_keys
>> Keyring
>> 812785375 ---lswrv      0     0  keyring: .builtin_trusted_keys
>> 455418681 ---lswrv      0     0   \_ keyring: .mok
>> 910809006 ---lswrv      0     0   |   \_ asymmetric: Erics-CA: UEK signi=
ng key: 9bfa6860483aa46bd83f7fa1289d9fc35799e93b
>> 115345009 ---lswrv      0     0   \_ asymmetric: Oracle-CA: Oracle certi=
ficate signing key: aeefb4bfde095cacaabff81dd266974b1b4e23b8
>> 513131506 ---lswrv      0     0   \_ asymmetric: Build time autogenerate=
d kernel key: 22353509f203b55b84f15d0aadeddc134b646185
>>=20
>> With this setup I can:
>> * load a kernel module signed with my CA key
>> * run "kexec -ls" with the kernel signed with my CA key
>> * run "kexec -ls" with a kernel signed by a key in the platform keyring
>> * load a key into the ima keyring, signed by my CA key
>>=20
>> So why would the linking need to be switched?  Is there a test I=E2=80=
=99m
>> missing?  Thanks.
>=20
> It's a question of semantics.  The builtin keyring name is self
> describing.  It should only contain the keys compiled into the kernel
> or inserted post build into the reserved memory.  Not only the kernel
> uses the builtin keyring, but userspace may as well[1].  Other users of
> the builtin keyring might not want to trust the mok keyring as well.

Should this feature only work with kernels built with=20
CONFIG_SECONDARY_TRUSTED_KEYRING defined?  If so, I could drop support in=20
the next version for kernels built without it. =20

