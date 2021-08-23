Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF2E3F5264
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 22:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhHWUt0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 16:49:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232486AbhHWUt0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 16:49:26 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NKXBs2071394;
        Mon, 23 Aug 2021 16:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GwgTHTWFp+4KtL2BdI3Wl8DT7iBBWIm4W/wc8D4PTzE=;
 b=INslB6mZOffpznEJNq36CgJn68TFeAnnBAFZqt05nXE4MXnxQTyABaAtoLzY02pFuYje
 ApRMLJHgOZWu+sDMo2gfn3hTrgVIlKgy9xkd9obzFIdSwvP7U6K5csDV+ZgdKc+vzcAk
 gglkmB2ymHb8EErZVWm5oBL/S3oOdIaIWI4Y3k5e06ph1vAcPLEt0pi1Ql9K/vJbcBm2
 RHIWKCTVTlHXstoLLU8AUjO7iXuWH0v9qhFm4v5sL1IrHCBXBRy1KZkFB5ZOaUIp0Ag4
 vZBJ3zCfuXkkHaUm09m8kHpvNU30azqVJjMT6h/vtm8ITBm3ADSlOvqeAwxYecaBxgLH kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3akejb88s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 16:48:16 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17NKXGWM071753;
        Mon, 23 Aug 2021 16:48:16 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3akejb88rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 16:48:16 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NKhIeQ029476;
        Mon, 23 Aug 2021 20:48:15 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3ajs4bbten-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 20:48:15 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NKmDo021037374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 20:48:13 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9700E136051;
        Mon, 23 Aug 2021 20:48:13 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 227F6136059;
        Mon, 23 Aug 2021 20:48:12 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.211.127.29])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 20:48:11 +0000 (GMT)
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
 <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
 <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
 <91B1FE51-C6FC-4ADF-B05A-B1E59E20132E@oracle.com>
 <e7e251000432cf7c475e19c56b0f438b92fec16e.camel@linux.ibm.com>
 <cedc77fefdf22b2cec086f3e0dd9cc698db9bca2.camel@kernel.org>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <bffb33a3-d5b5-f376-9d7d-706d38357d1a@linux.vnet.ibm.com>
Date:   Mon, 23 Aug 2021 16:48:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <cedc77fefdf22b2cec086f3e0dd9cc698db9bca2.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9OXXfLd94kr_A6N6E9AMIXxONqEE6Oxv
X-Proofpoint-ORIG-GUID: 58giprlgX9pWVHV4rPlSGeIWkMiItOtP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_04:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230140
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/23/21 1:51 PM, Jarkko Sakkinen wrote:
> On Thu, 2021-08-19 at 13:32 -0400, Mimi Zohar wrote:
>> On Thu, 2021-08-19 at 09:23 -0600, Eric Snowberg wrote:
>>>> On Aug 19, 2021, at 7:10 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>
>>>> On Thu, 2021-08-19 at 14:38 +0300, Jarkko Sakkinen wrote:
>>>>> On Wed, 2021-08-18 at 20:20 -0400, Eric Snowberg wrote:
>>>>>> Downstream Linux distros try to have a single signed kernel for each
>>>>>> architecture.  Each end-user may use this kernel in entirely different
>>>>>> ways.  Some downstream kernels have chosen to always trust platform keys
>>>>>> within the Linux trust boundary for kernel module signing.  These
>>>>>> kernels have no way of using digital signature base IMA appraisal.
>>>>>>
>>>>>> This series introduces a new Linux kernel keyring containing the Machine
>>>>>> Owner Keys (MOK) called .mok. It also adds a new MOK variable to shim.
>>>>> I would name it as ".machine" because it is more "re-usable" name, e.g.
>>>>> could be used for similar things as MOK. ".mok" is a bad name because
>>>>> it binds directly to a single piece of user space software.
>>>> Nayna previously said,
>>>>    "I believe the underlying source from where CA keys are loaded might vary
>>>>    based on the architecture (".mok" is UEFI specific.). The key part is
>>>>    that this new keyring should contain only CA keys which can be later
>>>>    used to vouch for user keys loaded onto IMA or secondary keyring at
>>>>    runtime. It would be good to have a "ca" in the name, like .xxxx-ca,
>>>>    where xxxx can be machine, owner, or system. I prefer .system-ca."
>>>>
>>>> The CA keys on the MOK db is simply the first root of trust being
>>>> defined, but other roots of trust are sure to follow.  For this reason,
>>>> I agree naming the new keyring "mok" should be avoided.
>>> As I said previously, I’m open to renaming, I just would like to have an
>>> agreement on the new name before changing everything.  The current proposed
>>> names I have heard are “.machine" and ".system-ca".  Is there a preference
>>> the maintainers feel is appropriate?  If so, please let me know and I’ll
>>> rename it. Thanks.
>>>
>> Jarkko, I think the emphasis should not be on "machine" from Machine
>> Owner Key (MOK), but on "owner".  Whereas Nayna is focusing more on the
>> "_ca" aspect of the name.   Perhaps consider naming it
>> "system_owner_ca" or something along those lines.
> What do you gain such overly long identifier? Makes no sense. What
> is "ca aspect of the name" anyway?

As I mentioned previously, the main usage of this new keyring is that it 
should contain only CA keys which can be later used to vouch for user 
keys loaded onto secondary or IMA keyring at runtime. Having ca in the 
name like .xxxx_ca, would make the keyring name self-describing. Since 
you preferred .system, we can call it .system_ca.

Thanks & Regards,

        - Nayna

