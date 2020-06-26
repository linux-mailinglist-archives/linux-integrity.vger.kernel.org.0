Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC8D20B134
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 14:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgFZMQz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 08:16:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727977AbgFZMQz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 08:16:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QC2nkZ111790;
        Fri, 26 Jun 2020 08:16:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31w3a3xp6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 08:16:47 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05QC3203113248;
        Fri, 26 Jun 2020 08:16:47 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31w3a3xp65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 08:16:47 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05QCAAGp011560;
        Fri, 26 Jun 2020 12:16:46 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 31wa24u44m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 12:16:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05QCGj3x48038384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 12:16:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFCFC112062;
        Fri, 26 Jun 2020 12:16:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BDC2112061;
        Fri, 26 Jun 2020 12:16:45 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 26 Jun 2020 12:16:45 +0000 (GMT)
Subject: Re: [PATCH v2] tpm: tpm2-space: Resize session and context buffers
 dynamically
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
 <8d19d5e2-91bc-09ad-6b94-d51a7aad6376@linux.ibm.com>
 <20200625212556.GC20341@linux.intel.com>
 <031020b9-dc0a-3c2f-32e4-4bb2db4b5a2b@linux.ibm.com>
 <20200626114815.GA5847@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <5d786bca-6a0f-0c7f-e856-04dac2f280f6@linux.ibm.com>
Date:   Fri, 26 Jun 2020 08:16:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200626114815.GA5847@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_06:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260084
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/26/20 7:48 AM, Jarkko Sakkinen wrote:
> On Thu, Jun 25, 2020 at 05:27:50PM -0400, Stefan Berger wrote:
>> On 6/25/20 5:25 PM, Jarkko Sakkinen wrote:
>>> On Thu, Jun 25, 2020 at 08:41:18AM -0400, Stefan Berger wrote:
>>>> On 6/25/20 12:38 AM, Jarkko Sakkinen wrote:
>>>>> Re-allocate context and session buffers when needed. Scale them in page
>>>>> increments so that the reallocation is only seldomly required, and thus
>>>>> causes minimal stress to the system. Add a static maximum limit of four
>>>>> pages for buffer sizes.
>>>>>
>>>>> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>>>>> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>> You don't want to try a fixes tag? None of the previous versions of this
>>>> code will work with newer versions of the TPM 2 then...
>>> It's not a regression.
>> Ok, so distros will have to backport it.
> Now that you mentioned PPC64 in some other email that would make this a
> regression since x86 provides less space for keys than PPC64.
>
> I studied PPC64 a bit and it actually allows max 256 kB page size, which
> is too much for us, given that there is no accounting implemented for
> TPM spaces (so far, should be done eventually).
>
> So to summarize: 0 the idea would decrease the limit on PPC64 and
> increase it on ther arch's.  `
>
> Dynamic scaling is over to top for fixing the issue, which means that I
> will just define static size of 16 kB for the buffer. We can reconsider
> it if we hit the roof again.

16kb is plenty of space for years to come. Maybe just enlarge the buffer 
for the regression and then do dynamic allocation as the final solution 
for the tip. I can try to test compile it on one or two long term stable 
kernels. Hopefully it applies cleanly. Simple test just in case you had 
a setup with a VM and libtpms master:

# echo hi | clevis encrypt tpm2 '{"key":"rsa"}' | clevis decrypt
hi

This only works once patched, gets stuck in the decrypt step otherwise.


    Stefan


>
> /Jarkko


