Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C02D83F5
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 03:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405998AbgLLCS7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 21:18:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35018 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728618AbgLLCSe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 21:18:34 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BC22YVE136599;
        Fri, 11 Dec 2020 21:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=CHlR03O/slhkZb7UI8AeVZ+E4TnENN5FXY5RSgCtZI0=;
 b=Gv4+YDoZtt/dFZRvxOvWmDqddZ3JCIr4RXy6pEzwX/uKfUj57SRzGhVOAYbiJDMnr8hQ
 BpH79INNJApoHGdv1hGbtwf5WVvWN0n46KLB+XHAmKU3TtNkme3xgtWL0U815GXRlgr1
 VVk1mbDoz8zdIs7H23Anjcpm4YO/ERuG7wtl2QqE6E+1B2/jQKwfa5lZ8E8s9I87opfv
 l9pkBTpp7tMWOg/oQmBUXBu0nWiL2v64a3yMeebPB52tlBMP0hjUTtSJJLKJk6o0BvfT
 sxlb7KgRVi/Ce/OecLHJVLQxOlaRQelZPu8xLG1RKvnQS6BpxyaUT7yTl0U+z/mh85iH kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35chm63y4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 21:17:17 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BC22jaG137406;
        Fri, 11 Dec 2020 21:17:17 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35chm63y3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 21:17:16 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BC2CjZb030545;
        Sat, 12 Dec 2020 02:17:16 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3581ua90v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Dec 2020 02:17:16 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BC2HESB23527900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Dec 2020 02:17:14 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3CF8BE053;
        Sat, 12 Dec 2020 02:17:14 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96A49BE04F;
        Sat, 12 Dec 2020 02:17:05 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.160.59.9])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat, 12 Dec 2020 02:17:05 +0000 (GMT)
References: <20201211221006.1052453-1-robh@kernel.org>
 <20201211221006.1052453-3-robh@kernel.org>
 <6934c005-d848-314d-cfee-23f2273c119d@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Rob Herring <robh@kernel.org>, takahiro.akashi@linaro.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au,
        zohar@linux.ibm.com, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [RFC PATCH 2/4] of: Add a common kexec FDT setup function
In-reply-to: <6934c005-d848-314d-cfee-23f2273c119d@linux.microsoft.com>
Date:   Fri, 11 Dec 2020 23:17:02 -0300
Message-ID: <87360bahup.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_10:2020-12-11,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012120010
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> On 12/11/20 2:10 PM, Rob Herring wrote:
>
> Hi Rob,
>
>> Both arm64 and powerpc do essentially the same FDT /chosen setup for
>> kexec. We can simply combine everything each arch does. The differences
>> are either omissions that arm64 should have or additional properties
>> that will be ignored.
>> The differences relative to the arm64 version:
>> - If /chosen doesn't exist, it will be created (should never happen).
>> - Any old dtb and initrd reserved memory will be released.
>> - The new initrd and elfcorehdr are marked reserved.
>> - "linux,booted-from-kexec" is set.
>> The differences relative to the powerpc version:
>> - "kaslr-seed" and "rng-seed" may be set.
>> - "linux,elfcorehdr" is set.
>> - Any existing "linux,usable-memory-range" is removed.
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> This could be taken a step further and do the allocation of the new
>> FDT. The difference is arm64 uses vmalloc and powerpc uses kmalloc. The
>> arm64 version also retries with a bigger allocation. That seems
>> unnecessary.
>> ---
>>   drivers/of/Makefile |   1 +
>>   drivers/of/kexec.c  | 228 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/of.h  |   5 +
>>   3 files changed, 234 insertions(+)
>>   create mode 100644 drivers/of/kexec.c
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index 6e1e5212f058..8ce11955afde 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -13,5 +13,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>>   obj-$(CONFIG_OF_RESOLVE)  += resolver.o
>>   obj-$(CONFIG_OF_OVERLAY) += overlay.o
>>   obj-$(CONFIG_OF_NUMA) += of_numa.o
>> +obj-$(CONFIG_KEXEC_FILE) += kexec.o
>
> For the functions moved from powerpc & arm64 to "drivers/of/kexec.c" in this
> patch, compiling kexec.c when CONFIG_KEXEC_FILE is enabled is fine. But when
> more functions (such as remove_ima_buffer()) are moved to this file, Makefile
> needs to be updated for other ima kexec related CONFIGs.

IMA kexec is only available if CONFIG_KEXEC_FILE is enabled, so I don't
understand what problem you are seeing.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
