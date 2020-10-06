Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD32850DB
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgJFRdZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Oct 2020 13:33:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgJFRdY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Oct 2020 13:33:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 096HVnlY191878;
        Tue, 6 Oct 2020 13:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hKZxe6f1WIeMfWoU9H8RjJt6qgIqADO7Y/50n2qrLEI=;
 b=ls0261RcITvHLyyY4sStK0dmrl66sDJS+xlm0NNpBqEK8SVkwfTmm26CXP8Y9OC3FCEG
 SgBI+imyRDGFvjx+bQVUtgemYXwvaXwiJdDLsVs+38SbNDsdwWrnZ83sVpYVAlL1n9dF
 /gu7shD8hcl6Z4GpPBrfCvSfbVMlv1a+9AqNhlzq2WJpeRzr2n5cRDT0F3y880YPScwP
 azCt1x2NOUPDLkkbrcRW76aXBt8NorjuwUmrW4lZ1I1Mo5Ui301vPtRkQKs14iXVoE/v
 NR/WO3XHjgLMHfG6vyYadTuyz3mQH0O00gmHQrU5XuhIyUZknLuBVpTFmrYhA9Vf6Eld WQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340u8h3rwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 13:33:21 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 096HNTu0015864;
        Tue, 6 Oct 2020 17:33:20 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 33xgx9fepp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 17:33:20 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 096HXJvN63504706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Oct 2020 17:33:19 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 575676A04D;
        Tue,  6 Oct 2020 17:33:19 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1590D6A051;
        Tue,  6 Oct 2020 17:33:18 +0000 (GMT)
Received: from [9.85.186.165] (unknown [9.85.186.165])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  6 Oct 2020 17:33:18 +0000 (GMT)
Subject: Re: [PATCH 3/6] ima-evm-utils: When using the IBM TSS, link in its
 library
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Linux Integrity <linux-integrity@vger.kernel.org>
References: <136e154e-16bc-9d6e-90a3-075cc67be333@linux.ibm.com>
 <20201006150742.GA16684@dell5510>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <9f7a5275-c7b4-c0b2-063b-1d9ee734d8b8@linux.ibm.com>
Date:   Tue, 6 Oct 2020 13:33:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201006150742.GA16684@dell5510>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-06_09:2020-10-06,2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060108
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/6/2020 11:07 AM, Petr Vorel wrote:
> Hi Ken,
> 
>> This is a prerequisite for the code change that uses the TSS rather
>> than the command line tools.
> 
>> Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
>> ---
>>   src/Makefile.am | 1 +
>>   1 file changed, 1 insertion(+)
> 
>> diff --git a/src/Makefile.am b/src/Makefile.am
>> index d6c779f..bf18caf 100644
>> --- a/src/Makefile.am
>> +++ b/src/Makefile.am
>> @@ -26,6 +26,7 @@ if USE_PCRTSS
>>   evmctl_SOURCES += pcr_tss.c
>>   else
>>   evmctl_SOURCES += pcr_tsspcrread.c
>> +evmctl_LDADD += -libmtss
>>   endif
> But pcr_tsspcrread.c uses the binary (tsspcrread).

The idea is to eliminate the calls to command line utilities, which
are not as stable as the TSS library.  Patch 4/6 does that.

I'm a git newbie.  I thought the idea was to do the patches as
small pieces.  Thus, this one does the autotools piece.  Then
the next one does the C code.  Should they be combined?

> 
> pcr_tss.c uses TSS, but that's already covered:
> ldd src/.libs/evmctl |grep tss
> 	libtss2-rc.so.0 => /usr/lib64/libtss2-rc.so.0 (0x00007fb82514c000)
> 	libtss2-esys.so.0 => /usr/lib64/libtss2-esys.so.0 (0x00007fb824eba000)
> 	libtss2-sys.so.0 => /usr/lib64/libtss2-sys.so.0 (0x00007fb8244ba000)
> 	libtss2-mu.so.0 => /usr/lib64/libtss2-mu.so.0 (0x00007fb824276000)
> 
> Thus I thing this patch is invalid. Or do I miss something obvious?

There are two TSSes.  This one's for the IBM TSS.  Your traces are
for the ESAPI API (aka Intel TSS).

> 
> And other thing: could you please rebase your patches for next-testing branch?
> It's not applicable for master, next and next-testing.
> 
> Kind regards,
> Petr
> 

