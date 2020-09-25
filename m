Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5432278BA5
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Sep 2020 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgIYPAH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 11:00:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37194 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgIYPAG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 11:00:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PExb6n080825;
        Fri, 25 Sep 2020 14:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RUQAeHAOHk3wxKfPZ9ublHZsm6YTzcN/WXIHLlNQUCw=;
 b=yl70M3TF1zas7gYFkJhW04IP2zYoYcWsjMRBuQON/B2ZLdkMGrXhXV0yEfCrwKX/2ykT
 GIkWkdHM2rHF2Ji4mSIUFSp9xcErtncMYSkpCzsdqv+05fgHaFK3bH/0NfMFLOaZ/Itz
 t9LHXrQfwURajIe03YXIklYRthWgvQ+0RvNy5yUu5CiiHHbBbxQy2t9g7bd4ZyVNmf2y
 rBdciY6UO3tO2yUkEUr1c8u8oFYLdlkq/Pw6W2SxwaNBLgqTTqxxJclwX059ZcorPvWe
 u4i5UyNdSuJqu08dl6bThK12FP5PTFWX4HnM9opFAGVgcSLBPmwpnoXzBHfLs2gvqtmJ 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33qcpub37e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 14:59:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEuC8W034274;
        Fri, 25 Sep 2020 14:59:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33r28ygfx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 14:59:38 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PExa4n011122;
        Fri, 25 Sep 2020 14:59:36 GMT
Received: from [10.39.243.24] (/10.39.243.24)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 07:59:36 -0700
Subject: Re: [PATCH 01/13] x86: Secure Launch Kconfig
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        trenchboot-devel@googlegroups.com
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-2-git-send-email-ross.philipson@oracle.com>
 <22ecb054-c340-cea7-7d80-28469fdcddc6@infradead.org>
From:   Ross Philipson <ross.philipson@oracle.com>
Autocrypt: addr=ross.philipson@oracle.com; keydata=
 mQENBFtHZ04BCADHhtvMImplKfIEOytU7ZH4haZ9eFAqZpGeIpG9D+pzTCuReM2/49bvgNoI
 e1xuiQFO+UEJ8FjedFjDdqY7fSw3xVdX9gLwD1Rmw0Dadc1w6sGbcoOQLHcglesu+BmcKBtU
 tWQZkzCpEShN4etgZThk8469YnAvO08vNZsrizgrpD90T7mEYiNXxIkX87sPGbnBrL1X7RvZ
 TaRXfE8174W+XVwGEpSiO/GjRgLW8+DFZB5MgXpCR993+U1YT9Lz97/MRzr4hqcOYry6LBYi
 s8dOly4oP7gK15oW8Xap9+ur0Jd8Vy8o99Axq+7yunF+2KE2SwP3/w8H3VDpx7EeDhWDABEB
 AAG0KlJvc3MgUGhpbGlwc29uIDxyb3NzLnBoaWxpcHNvbkBvcmFjbGUuY29tPokBVAQTAQgA
 PgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJb
 R2eBBQkJZgGzAAoJENpHdTZHiMYcPYcH/Rlp3/F3P4/2i/W0F4yQDVD6rAkejCws4KlbgC5D
 Slkdvk6j8jOW/HNeIY3n+a3mW0iyyhZlipgYAqkK1loDiDxJjc2eUaHxiYWNLQ4CwIj2EC27
 AWCp6hgwHNWmZrdeNbM/Z6LTFQILx5xzgX+86KNqzFV7gOcAaS2qBVz1D83dgrFZaGaao918
 nvfe+SnImo0GaEf8nVDKgsD2zfzMBkk4q/E0mrEADFXwBHSvNCnVyrCN6Ve0dHWgI7SszUDt
 7v01zbGPR5mRfGuyC9gykd2SDCw5/Q27RMWfaPFL/dtiZBljUzb2yW5jicZAz7zNdDcBSUGR
 r//wxtG4k/dBrMW5AQ0EW0dnTwEIAPelEnLDnfJnHdFR+1Thrvv3Udt/1cjqQfHqH4F8zef/
 MsIcPV1skL7qPUYD+CrbasvmqhlPxtJAtN68inPa70fA2g0PtNmLUH1NBb2e6EjOoVZg9ais
 BWfdYUITZouOXs2zCTFsoNWjTJANnXxexbTf1ZEqfzlVtQK+xAnXl3kiL4Y47VMbgDkGedhw
 3ZMWQ2zMMZqYJkPYhtlTXtedhV91DL1347ULwHsvkUJDZ0gL+WU6tYhsCOOiD61x58PfUiFb
 /WkZEPxb96dSSSWrTlLlBWSSD24RnhfbJjfsXeSu9s4XldmGTDkj7jclMVU1xV0BUfqEwhVn
 xR8FlC+dZvkAEQEAAYkBPAQYAQgAJgIbDBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJbR2eB
 BQkJZgGyAAoJENpHdTZHiMYcDIAIAIRJrKjIStRvLsOOCX92s9XJPUjrC/xmtVsqVviyFWIC
 QRPQzDE+bDSvRazudBHmcPW+BOOB5B+p7zKZzOGoZV2peG8oA/Y8oCxOYBtpbBaZ5KJexm/g
 BbnJUwb3uhmKtDShHGUCmtq8MZBJBr6Q6xHprOU8Qnzs9Jea8NVwaz9O226Rrg4XVv/sK1Lh
 ++xZfhi7YqKWdx5vdfdnX1xWe8ma0eXLeCDh3V6Ys+Habw1jEbMuafrcVzAbp1rMt2Lju1ls
 BNAoxeViK7QXWfwGTmGJP++jHmo99gMqEtiohf+37N0oS6uYu6kaE7PxsEcOjWKJxW/DdgwO
 eFq+D6xuiKk=
Message-ID: <30392fae-30ad-4438-d1ea-1cc306baf99f@oracle.com>
Date:   Fri, 25 Sep 2020 10:59:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <22ecb054-c340-cea7-7d80-28469fdcddc6@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250108
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/24/20 10:08 PM, Randy Dunlap wrote:
> On 9/24/20 7:58 AM, Ross Philipson wrote:
>> Initial bits to bring in Secure Launch functionality. Add Kconfig
>> options for compiling in/out the Secure Launch code.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Hi,
> from Documentation/process/coding-style.rst:
> 
> Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.

Ok sorry about that. I probably just copied what the previous entry was
doing. Will fix.

Thanks
Ross

> 
>> ---
>>  arch/x86/Kconfig | 36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 7101ac6..8957981 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1968,6 +1968,42 @@ config EFI_MIXED
>>  
>>  	   If unsure, say N.
>>  
>> +config SECURE_LAUNCH
>> +	bool "Secure Launch support"
>> +	default n
>> +	depends on X86_64
>> +	help
>> +	   The Secure Launch feature allows a kernel to be loaded
>> +	   directly through an Intel TXT measured launch. Intel TXT
>> +	   establishes a Dynamic Root of Trust for Measurement (DRTM)
>> +	   where the CPU measures the kernel image. This feature then
>> +	   continues the measurement chain over kernel configuration
>> +	   information and init images.
>> +
>> +choice
>> +	prompt "Select Secure Launch Algorithm for TPM2"
>> +	depends on SECURE_LAUNCH
>> +
>> +config SECURE_LAUNCH_SHA1
>> +	bool "Secure Launch TPM1 SHA1"
>> +	help
>> +	   When using Secure Launch and TPM1 is present, use SHA1 hash
>> +	   algorithm for measurements.
>> +
>> +config SECURE_LAUNCH_SHA256
>> +	bool "Secure Launch TPM2 SHA256"
>> +	help
>> +	   When using Secure Launch and TPM2 is present, use SHA256 hash
>> +	   algorithm for measurements.
>> +
>> +config SECURE_LAUNCH_SHA512
>> +	bool "Secure Launch TPM2 SHA512"
>> +	help
>> +	   When using Secure Launch and TPM2 is present, use SHA512 hash
>> +	   algorithm for measurements.
>> +
>> +endchoice
>> +
> 
> 
> thanks.
> 

