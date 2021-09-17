Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA4940FD8A
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbhIQQI7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Sep 2021 12:08:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30852 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhIQQI7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Sep 2021 12:08:59 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HFwrHn025129;
        Fri, 17 Sep 2021 16:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=FbVt8BaQDfjRRtPCNMYAThbkmliiDw7IGKPVVOmSu6E=;
 b=NwO0qPK60w+TCBMOzrbRnp3CUOYcKOOy5FerhIqtjmPuudDhB13QcLwssLr9Dax0S1EM
 rCRaDou7jZ17uXZyUSSMH5t0gzT2Y3Wk84HQ8d7iqzKA0VLqQbdXJHlctV4vq/fTEvFQ
 4AxnlN9WhAsSvFJuKZGqL8+CFtn33zTnzIzadk3QYM+RU72bQ6VW+EKBQRCvNfzmp9+3
 wNoY2V93OpE1yGK0sjyUv4lAHQavI2kSIeN35pWu2URiLD/8Oix2gb2bakp87d2foUCg
 OaTSpjCXFUsyUSL5zF63VjbtvJQlzm7PieUA3RPp91xZxyI0GJN1JEXluhVScvqREK7J Iw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=FbVt8BaQDfjRRtPCNMYAThbkmliiDw7IGKPVVOmSu6E=;
 b=gf2cNvDyeDuvrmk/tbi01UuLd2ToTW5dm5WdUdbwp/TQbEvWgGSiUIBuPIpE+YiQECIW
 BZUJQlrlOyi1+7y+2suOOIdhRz3mhdAbe5qt0O4DEcz2ASMEKDVWTXXfS62AQL/SmzwL
 GENMYQz6k/B5rZqoQcIU0UBg9y+YE7pDPA0otoKGqKEH9HrQi05by7piRFs8w+i1tYsO
 kTxgWtvwwZgyzFFkaGJc/klW+7cAs0QZhjN2wdsQqHmu0fU7ZP/JiHjgPUvXWNk9r5jc
 Hg1QhXQoOD5YA3+EEjB89yvBXO34s7HZRCHy9kAZzQEOht7RrxT734oGdwEDO4TvIcIQ ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b4u8srt7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 16:07:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18HFxjX3165380;
        Fri, 17 Sep 2021 16:07:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3020.oracle.com with ESMTP id 3b167x07jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 16:07:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMDu+fE3+QZOQxLLxMImhMfmbVb3EW+oDuxFNVqenEUv0LgF4IfEE0Nz+gJn25dM+9bCaF5fKE/zQQjxzFaNjGsdstAk8Usyvbb91JMLlCxqKSYK8hYYf/mCVL+rod1IHczjIHkecLNanNAOQBAjPCGUDCYaGeRaSllXYezYQAR1c42fzKhq/CbyenwqJve9D8oFRiK3uulOo2ZWhhos3Ch8I5DbQb09CoNSXotQudQmqx2eZCksEQwkN6OppZ57xGpGeEnBbgRaZhpA3F0CRCZ1fFxaciHJKxBC0rpzHXzjoXVGIIst8gTOn5iRTcBshJP2LhV0oPZR8VAplmIYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FbVt8BaQDfjRRtPCNMYAThbkmliiDw7IGKPVVOmSu6E=;
 b=Q9g9PEZ80dXK3e4QeGJYvF1DXYKgFn9gcv/7jiY1CMfETE4MXsdNmXzptOBy6h+BIMJE63ujmlG+dHqIbh4bfqyM4GaFupnMriliiZpyNCE4W7HM2ENW5gKyADoQWl//cNOaNauTGAtuA5z8vLpDUO9zX/gXWhfUvqblukxZnZhQ0A5jcjurIfIjxhyiXji5wM6jmj3Xnq60BTTMl78YhRnVSOJKxDsYYOCAGpw2d0c7/t2Pjtd8MBCa9F9eHgzM00vT6z2j+4bs7c63lRbw/3DU/RnwdUjv82oZRtdlAlwh6vzK0lHVhvM2jkq2SqCcWIXXm775pD/1gNukn9P1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbVt8BaQDfjRRtPCNMYAThbkmliiDw7IGKPVVOmSu6E=;
 b=V3LOgDfA3m0X9CVGAI3N+sMairG21hSYwSEyCiv0rKs3qAAPywkyXnU33Xd0pQxqHXzoNlIa8D+heu9Qux3AqMRkR/7ARediqHgkPJOGCGCfLj7wVaBwpIr/GXIW9vZHyKfoxY3zaTY0E7B74mXKWYXnDkjkiazLmseJGcAVdaA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5372.namprd10.prod.outlook.com (2603:10b6:610:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 16:07:02 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 16:07:02 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v6 12/13] integrity: Trust MOK keys if MokListTrustedRT
 found
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <20210917150332.cakrhyxh655e73jo@redhat.com>
Date:   Fri, 17 Sep 2021 10:06:56 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        James.Bottomley@HansenPartnership.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <354B8A37-28BF-4C2E-9FF6-FF00B39B4D06@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
 <20210914211416.34096-13-eric.snowberg@oracle.com>
 <20210916221922.xjplaobua2iss2bn@redhat.com>
 <9C5B2B68-5F03-472F-8B17-E0A716C85CF2@oracle.com>
 <20210917150332.cakrhyxh655e73jo@redhat.com>
To:     Peter Jones <pjones@redhat.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: CH2PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:610:50::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from [172.16.177.128] (184.60.195.210) by CH2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:610:50::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 16:07:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 333770a9-dadc-4a42-2e67-08d979f52f35
X-MS-TrafficTypeDiagnostic: CH0PR10MB5372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5372CD11B770D3E190339BF587DD9@CH0PR10MB5372.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMHTxXUV9uPDKGi2URYIhWd+wSiaqLj7BEHzXVVIQATzqmzElXyFR2dMa7839RHxtcn9pVO/Mg+kqe4/9fNL+6nY0dabTCxNuXBsL2jPipmsCRV7Wmz5IIGUxNDwYqirI+j2ODGxEhpJopBaf0aHpsq4jQpUl0Djtg6VKupzOtaMWFrs4vEWhRLlj6wJqtDUHgv8Bttqmwww8YNE/6EnHgJ666Lovk/WZQWCeYxNzqHPOxohUA6oknRF65hYJLixoPhvQkKcP9UsiNSzPttRtdauSoAZhF2vCj/SNyq8cNfm2+oYUfU630jqY98sDJtN9alcFoqzVuBJkBGXgv9kHJpTzUECJIMFKkw2WOZBiZvLyZUqQ2NGBBGcjfmkx3dSswTTuv+z/rG4yhzDKxklUWeSnbWH/Hu5oQl2PYVv8DYMD/cF9Ui3CBKWfm0VaDr/BWLmBWu4TPgpBlSNs8YN4j/tHPOxVWOT9ZpjbTyXxw8mpeIuKYwDmqi9hCM67LfTsbJx+7j+dShJ7B3lhuyQsvJKqc8yKiiizZjrE7Vv8E2VaEaMLuCn/602CKJ3hLjrRb50cRJNxIUIJqcyqzTTP0zTnc8kUWPVQRpyH8cZb0NTLpYf/3Jcnk/Cz0ss7f2MhkRhOx113JAfHHzw367AQ2hVQFGGpnjG5SGrxxh7W3P22jkFHEvo27N3lzT2QRPIwcHrFra6LHjbwXiHk71pafS4tV8wXJ0oKTYlT7dXyIHuuk15HtaIb8Pv9KIi+jBu4rfqW7frPTw54mREdb+0r521KqpOA8P41kHfQm+qv2tf9YWbMm7uYqQqk0WFpr28
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(39860400002)(366004)(53546011)(6486002)(38100700002)(54906003)(6666004)(2616005)(956004)(36756003)(16576012)(316002)(38350700002)(86362001)(8936002)(7416002)(66556008)(26005)(66946007)(52116002)(966005)(66476007)(5660300002)(478600001)(4326008)(186003)(2906002)(33656002)(83380400001)(8676002)(6916009)(44832011)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0NZSWNkdDZJUkozRUVxZTlxdGhhUkpyM25idEUwY0s5dWx2MEtTYzRCUGlm?=
 =?utf-8?B?VEVqSkZSWWVXd3RSb0VibVBhQzN1V1VpMlVHdEZYRmxDUmE0NE5aZDlLV2xh?=
 =?utf-8?B?ZDcxT3ZLUkVrVUxyd3p5V3I1MmJYVXo2ajhZcitZUEZEZHhzZTlFTUxpR2Z1?=
 =?utf-8?B?c0VyWUtyeFcwbUd4MEo2VHp6QndRS01rYVNuL0N6eTJEREY3RmxFNzV4ZURm?=
 =?utf-8?B?ak91Z3pqbGRNQXBSUDRDOXpBOGllTTdnU2tLZGJ1NUFpU29Xd3hkbC9hZHBu?=
 =?utf-8?B?ZGM2ZXdTSDZVMnVJQ3RnSWtDc0laUDE3dWs3RTJHOTFSdEFKTlJ6YndKQzUx?=
 =?utf-8?B?a1E0VU41SzVyMDB1Y3ZwRU41VHg4VEJIWXV5UUM5Y0wwT2FvNHBIbWU0Mjls?=
 =?utf-8?B?cUdkYnF0aGFMNXRGM2YxdElxN09IQVlJSHcveTJQR2s4Q28rZVdEdGZXVkw3?=
 =?utf-8?B?ekFwS3dJZktudUtyT2J6RjNFUjhheVplL0NSWkVMZ3M1NTJnWWZLVnI4bWxY?=
 =?utf-8?B?VWZYd2phOUZqc3BDY3h4ZStKNTZsTTN2enc0V09qYnBNaHVXdVdCVlVZTnpK?=
 =?utf-8?B?WEtyN1UxMjdtWHB6ZVFQdHJLcXppbTV2aVMyWVdYUW5IaDV6ZlZRdEJOZE9C?=
 =?utf-8?B?REpVamVsUWRWcWZxV1g1YndVWUFCY2JSaHNDNW10QUllS21RRFo3NW11T2xN?=
 =?utf-8?B?c0ttcGJaeU93VmZiTlBCQ0RJTXR3YmVuU1hSMnhqMitRRnhHYzZXYXl2Vldt?=
 =?utf-8?B?SHhrakxNY29UUi9mVVBURHYxWTZJb1JaWkorSGs5TFA0WXhtY3N5aTlMeDdC?=
 =?utf-8?B?N0U1OFloMTZRaE5zZGxRU1pRdlloNWhDWndSVGhMTjFHSHFJejl1NlBhRndO?=
 =?utf-8?B?enpkVGxHNVlYZFFVNmhkS1ZjNGZyTzRITmt3aVNjRXIyczJiV0ZabUxuOTJv?=
 =?utf-8?B?Zy90NmFwUjliYjdTVUNxbnBWc05Nb2w0R2QrdG1GWC9xNlBJcm0zN3FQSXBx?=
 =?utf-8?B?ZGlxK01lbkF3d2JHaUJyUnE2SWxTMGJKaUFVa0MvcWNrQTZCYjl6dlF2V1RP?=
 =?utf-8?B?Skg4cnNEVTFJaCtTM1Bsc1hwR2RVazJXR0NOeDZOYldIamNNN3krKy9VSUM0?=
 =?utf-8?B?TDZqLzg2aFM5c214VDY1bmdQZ3FXdVdWRVhoV1BNRmJhSXNjMHJMTERkWWFK?=
 =?utf-8?B?VkVsM2VicUJkVGlSV25FWnpkS0pZQmF6SjVsUFh3VUxRQ0E3MG9NamlwaHRM?=
 =?utf-8?B?SHIwS3NpWS9mOC9mSVA4ZGU1N3BuU0ZlbEJjUngxR3U2c3pkREMxZHIwNVli?=
 =?utf-8?B?RnhRNE13K25Ud05XYUNXRGlvcS9pbHVwQXJvRWVKWTRuRW4rM1ZZdVhZeEth?=
 =?utf-8?B?Z1dnQlZXNGgrTkw5cW05V092bjd3d3RCR28ySWJoM0x4bE1LVUtxaWZWNVpr?=
 =?utf-8?B?UXp5RnYxbjJGZUlGRFZHS0JlM0t1S0w5MS9xdW5LUnBzYXl2ZXJSbUVBbk1p?=
 =?utf-8?B?N09odkhGemx6VFg1OVJ3ZFEwYVF6WTFLbmVYRjU5ZVU1ZVFNYzJiNXU3b2M1?=
 =?utf-8?B?RzlZTHIrZnhjbVZ1R1hiOXMzbm1DWVJVNGJlK1pFcCtITG9PbVBYdDVjNmda?=
 =?utf-8?B?a2ZuSTUvNExFaXQvRS82Vi9sM2o0alhGQzdqWGdudXB0cFRTbVY2NGgzTGlq?=
 =?utf-8?B?OVZuUWdHL2N6aWR5b2RvYWMrQVdyT0dxVkp6U0lwYXhtbTNTMDExdE9aM0FU?=
 =?utf-8?Q?2T3j0PknW0hpbYvLquaHqAZY4dM7yaZKdpsRJef?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333770a9-dadc-4a42-2e67-08d979f52f35
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 16:07:01.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV65e3n6HnyZk9nH+Te+qxhoa7xvCzvuUYVpH916RQoiluQKHOS7oTs3dptgLRIwwOlg+PSuvaa/uqZ2PwhQDySAzb0yn8rOjCgB4+SOTaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5372
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10110 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109170098
X-Proofpoint-ORIG-GUID: dPHUseFi8HFJo1MMPKmlw-5v6rXxuyWv
X-Proofpoint-GUID: dPHUseFi8HFJo1MMPKmlw-5v6rXxuyWv
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 17, 2021, at 9:03 AM, Peter Jones <pjones@redhat.com> wrote:
>=20
> On Thu, Sep 16, 2021 at 08:00:54PM -0600, Eric Snowberg wrote:
>>=20
>>> On Sep 16, 2021, at 4:19 PM, Peter Jones <pjones@redhat.com> wrote:
>>>=20
>>> On Tue, Sep 14, 2021 at 05:14:15PM -0400, Eric Snowberg wrote:
>>>> +/*
>>>> + * Try to load the MokListTrustedRT UEFI variable to see if we should=
 trust
>>>> + * the mok keys within the kernel. It is not an error if this variabl=
e
>>>> + * does not exist.  If it does not exist, mok keys should not be trus=
ted
>>>> + * within the machine keyring.
>>>> + */
>>>> +static __init bool uefi_check_trust_mok_keys(void)
>>>> +{
>>>> +	efi_status_t status;
>>>> +	unsigned int mtrust =3D 0;
>>>> +	unsigned long size =3D sizeof(mtrust);
>>>> +	efi_guid_t guid =3D EFI_SHIM_LOCK_GUID;
>>>> +	u32 attr;
>>>> +
>>>> +	status =3D efi.get_variable(L"MokListTrustedRT", &guid, &attr, &size=
, &mtrust);
>>>=20
>>> This should use efi_mokvar_entry_find("MokListTrustedRT") instead,
>>> similar to how load_moklist_certs() does.  It's a *much* more reliable
>>> mechanism.  We don't even need to fall back to checking for the
>>> variable, as any version of shim that populates this supports the confi=
g
>>> table method.
>>=20
>> I=E2=80=99ll change this in v7, thanks.
>=20
> We do also need to figure out a path forward for something like Dimitri
> Ledkov's MokListX patch[0] from May, though it doesn't necessarily need
> to hold up this patch set.  It looks like your patches will change the
> structure of the keyrings it needs to apply to, but I don't see a reason
> it wouldn't be conditional on the same MokListTrustedRT variable.  Any
> thoughts?
>=20
> [0] https://lore.kernel.org/lkml/20210512153100.285169-1-dimitri.ledkov@c=
anonical.com/
>=20

I had a little different approach I was going to send for this problem, but=
 dropped it=20
after I saw Dimitri=E2=80=99s patch.  Yes, we will need to figure out a way=
 to merge the two. =20
But I don=E2=80=99t see that being too difficult or them being incompatible=
 with one another.

