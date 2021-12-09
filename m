Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1146F63F
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 22:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhLIV5x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 16:57:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231868AbhLIV5v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 16:57:51 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9KZHjb027392;
        Thu, 9 Dec 2021 21:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WMWPuPqMKkG7POp8eawwV4RyD7I/ba69OipN2SLIhY8=;
 b=CQvQZs82boi9r/eoannQphMh+dI0uZhcqNDtBHo5FK+3ZSVy6ZL3noAsV3RzaXUdAGzl
 maworrN7wm4zu+ueXaE6DbbtmSyABIcqp3AXXadrzv59wybqvXuAiuLBhi5sYRo/ohAJ
 KCp3bTvihHt2x2Ds7SHmcr3I20WigbNag2S85aN29mmldXcx/mukpQvKbKjsbvmAmccA
 oPqB5T4kaw7VFy9Ge8WASuFOY7fm/qdgclaufYBEC1CY8jzy1HiwAWIcqr+CpV+q3gFW
 uu4KBoZ7QjsoTPorlYuWd4XViUrgqUQbBg/bFzKhQdsD5AhNDK374+iog2ZV9WYkTyCq SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cup7pwehy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 21:53:39 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B9LrdNB019382;
        Thu, 9 Dec 2021 21:53:39 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cup7pwehr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 21:53:39 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B9LcEZB011635;
        Thu, 9 Dec 2021 21:53:37 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 3cqyyc2mqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 21:53:37 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B9LrZ3927132204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Dec 2021 21:53:35 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93B856E056;
        Thu,  9 Dec 2021 21:53:35 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97FCF6E052;
        Thu,  9 Dec 2021 21:53:33 +0000 (GMT)
Received: from [9.211.103.28] (unknown [9.211.103.28])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  9 Dec 2021 21:53:33 +0000 (GMT)
Message-ID: <790c68ce-070d-c391-0c3a-4637c616fa5e@linux.vnet.ibm.com>
Date:   Thu, 9 Dec 2021 16:53:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     keyrings@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <cover.1637862358.git.msuchanek@suse.de>
 <8b30a3c6a4e845eb77f276298424811897efdebf.1637862358.git.msuchanek@suse.de>
 <c3c9c6e4-6371-2f5a-ac94-fa4389d5dbe5@linux.vnet.ibm.com>
 <20211209092155.GO117207@kunlun.suse.cz>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <20211209092155.GO117207@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x2XUc9cxjnO1DJ8AfathjBta2FnXVAlc
X-Proofpoint-ORIG-GUID: HZolCF3M1gk1kZAg8NUwVeVyMGL04EK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_09,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/9/21 04:21, Michal Suchánek wrote:
> Hello,
Hi,
> On Wed, Dec 08, 2021 at 08:51:47PM -0500, Nayna wrote:
>> On 11/25/21 13:02, Michal Suchanek wrote:
>>> Copy the code from s390x
>>>
>>> Signed-off-by: Michal Suchanek<msuchanek@suse.de>
>>> ---
>>>    arch/powerpc/Kconfig        | 11 +++++++++++
>>>    arch/powerpc/kexec/elf_64.c | 36 ++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 47 insertions(+)
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index ac0c515552fd..ecc1227a77f1 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -561,6 +561,17 @@ config KEXEC_FILE
>>>    config ARCH_HAS_KEXEC_PURGATORY
>>>    	def_bool KEXEC_FILE
>>>
>>> +config KEXEC_SIG
>>> +	bool "Verify kernel signature during kexec_file_load() syscall"
>>> +	depends on KEXEC_FILE && MODULE_SIG_FORMAT
>> After manually applying the patch, the build is failing with the following
>> error:
>>
>> build failed with error "arch/powerpc/kexec/elf_64.o: In function
>> `elf64_verify_sig':
>> /root/kernel/linus/linux/arch/powerpc/kexec/elf_64.c:160: undefined
>> reference to `verify_appended_signature'"
> This patch does not add call to verify_appended_signature.
>
> Maybe you applied the following patch as well?

Yes, I tried build after applying all the patches.

Thanks & Regards,

     - Nayna

