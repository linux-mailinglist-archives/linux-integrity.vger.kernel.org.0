Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4BB306C0F
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jan 2021 05:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhA1EOf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 23:14:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231247AbhA1EO1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 23:14:27 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10S42g3c153480;
        Wed, 27 Jan 2021 23:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yuVzlj1KaxSV483KKx6/iP8+B9liUYCdNpO7hs9E9yY=;
 b=I+DXyX1RuBn8aN5ukT7hxEl3AX0MhyTA5GoiZp9DeJxHyjM99abR7lM01Y2bGvB/Fr9h
 MNplPBdiNU2CLDemgBwhg+tY1XOqPbmNNjEcAy1/LTmxAp6wklsETWv6IhXzM06fuOkF
 ondvimUxUeCxF30gujOh7TdPdk3pX4PMT6tVW9levvCk5y7enmEzz9017sf2lALHWBXc
 Ttbx8vKm53wluFpfwgA1zKJuc9OMyB8bJYWVkYHIDbeBvnwscEmCfhicZ6eqGJUcHw9/
 MlBVdWs8wHxHOKAR8mSm13N9gS0TY5e+nNU+gpMy3WhiHF5NN+RV2cHbL2iiQSgAFuZh Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36b4g9b193-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 23:13:23 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10S43P9L157071;
        Wed, 27 Jan 2021 23:13:22 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36b4g9b18u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 23:13:22 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10S3vAvU024647;
        Thu, 28 Jan 2021 04:13:21 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 36agvf0wx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 04:13:21 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10S4DKht35651936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 04:13:20 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C48F3124053;
        Thu, 28 Jan 2021 04:13:20 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33E0A124052;
        Thu, 28 Jan 2021 04:13:19 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.65.198.104])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jan 2021 04:13:19 +0000 (GMT)
Subject: Re: [PATCH v4] certs: Add EFI_CERT_X509_GUID support for dbx entries
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jmorris@namei.org, serge@hallyn.com,
        nayna@linux.ibm.com, erichte@linux.ibm.com, mpe@ellerman.id.au,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com
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
 <86CE3924-E36F-44FD-A259-3CC7E69D3EAC@oracle.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <e18675cc-26d2-bfc3-2043-30e4f01b56ce@linux.vnet.ibm.com>
Date:   Wed, 27 Jan 2021 23:13:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <86CE3924-E36F-44FD-A259-3CC7E69D3EAC@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_01:2021-01-27,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280017
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/27/21 10:41 AM, Eric Snowberg wrote:
>> On Jan 27, 2021, at 7:03 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> [Cc'ing linux-integrity]
>>
>> On Wed, 2021-01-27 at 11:46 +0000, David Howells wrote:
>>> Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>
>>>>> I suppose a user space tool could be created. But wouldn’t what is
>>>>> currently done in the kernel in this area need to be removed?
>>>> Right. I don't think this was a great idea in the first place to
>>>> do to the kernel but since it exists, I guess the patch does make
>>>> sense.
>>> This information needs to be loaded from the UEFI tables before the system
>>> starts loading any kernel modules or running any programs (if we do
>>> verification of such, which I think IMA can do).
>> There needs to a clear distinction between the pre-boot and post-boot
>> keys.  UEFI has its own trust model, which should be limited to UEFI.
>> The .platform keyring was upstreamed and limited to verifying the kexec
>> kernel image.   Any other usage of the .platform keyring keys is
>> abusing its intended purpose.
>>
>> The cover letter says,   "Anytime the .platform keyring is used, the
>> keys in the .blacklist keyring are referenced, if a matching key is
>> found, the key will be rejected."   I don't have a problem with loading
>> the UEFI X509 dbx entries as long as its usage is limited to verifying
>> the kexec kernel image.
> Correct, with my patch, when EFI_CERT_X509_GUID entries are found in the
> dbx, they will only be used during kexec.  I believe the latest dbx file on
> uefi.org contains three of these entires.
>
> Based on my understanding of why the platform keyring was introduced,
> I intentionally only used these for kexec.  I do question the current
> upstream mainline code though.  Currently, when EFI_CERT_X509_SHA256_GUID
> or EFI_CERT_SHA256_GUID entries are found in the dbx, they are applied
> everywhere.  It seems like there should be a dbx revocation keyring
> equivalent to the current platform keyring that is only used for pre-boot.
>
> If that is a direction you would like to see this go in the future, let
> me know, I’d be happy to work on it.
>
Yes, as you said, currently blacklist entries from dbx for 
EFI_CERT_X509_SHA256_GUID or EFI_CERT_SHA256_GUID are applied 
everywhere, and does not satisfy the trust model for .platform keyring. 
We should fix this, but changing now might break some existing systems. 
Probably it should be discussed as separate thread from this patchset.

Thanks & Regards,

       - Nayna

