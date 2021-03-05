Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0DF32F5C1
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 23:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCEWQ0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 17:16:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhCEWPv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 17:15:51 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125M5LcM049164;
        Fri, 5 Mar 2021 17:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VAzirJe/Hk/A2gCMur0L8RjwwmeZlMeq9cZyz2PGjEw=;
 b=bM+NyN1PJ3UAim5D3wAptX1h+/xc074+OPS9f5qvFsX+MtIAUhhjre8/BPbDIKgpHO3C
 K3pcmEeJOFP2xZmef4rhbAtWVudoTTEPFVfINYeSngV58UDPtUxa03xWzV8bojBSkpXj
 0jKXBUAe0Wrg68RXrcgVYT43l3tjgpVHEr5xIcOvJT5uzrELWcYcFU9/aRB6ZWUnNhO5
 Nu4ARkCbVCw/nRD0DylOg6LSgKWQXFBO5nE6c61GYh46mC68FG8B6/Oni0SfMCwLkKfD
 xco1XmOGKBdaWj+fp2W58N4Z1Jxl8pljAvCrevN0GJ4VU60++45ZwOh3XF97GRQtJHpm EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373tntuuxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 17:15:41 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 125M78Q3057284;
        Fri, 5 Mar 2021 17:15:41 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373tntuuxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 17:15:41 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125MCQ0m012336;
        Fri, 5 Mar 2021 22:15:40 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 3720r14th5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 22:15:40 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 125MFd2N12583468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 22:15:39 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFA13BE086;
        Fri,  5 Mar 2021 22:15:38 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAC52BE054;
        Fri,  5 Mar 2021 22:15:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 22:15:37 +0000 (GMT)
Subject: Re: [PATCH v10 1/9] crypto: Add support for ECDSA signature
 verification
To:     Vitaly Chikunov <vt@altlinux.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-2-stefanb@linux.vnet.ibm.com>
 <YEJk44FXEl0+mEPr@kernel.org> <20210305194640.nnerhdadoczqyta3@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <4abdc777-03a9-bee1-3ae1-93d77e14eea0@linux.ibm.com>
Date:   Fri, 5 Mar 2021 17:15:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210305194640.nnerhdadoczqyta3@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_14:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=712 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/5/21 2:46 PM, Vitaly Chikunov wrote:
> Jarkko,
>
> On Fri, Mar 05, 2021 at 07:05:39PM +0200, Jarkko Sakkinen wrote:
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (c) 2021 IBM Corporation
>>> + *
>>> + * Redistribution and use in source and binary forms, with or without
>>> + * modification, are permitted provided that the following conditions are
>>> + * met:
>>> + *  * Redistributions of source code must retain the above copyright
>>> + *   notice, this list of conditions and the following disclaimer.
>>> + *  * Redistributions in binary form must reproduce the above copyright
>>> + *    notice, this list of conditions and the following disclaimer in the
>>> + *    documentation and/or other materials provided with the distribution.
>>> + *
>>> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>>> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>>> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
>>> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
>>> + * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
>>> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
>>> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>>> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>>> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>>> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>>> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>> + */
>> This license platter is redundant, given SPDX.
> I think SPDX identifier supplements license plate and is machine readable
> identifier, but it does not replace or making adding of license plate
> redundant.
>
> - Quoting https://spdx.dev/ids/
>
>    "When a license defines a recommended notice to attach to files under
>    that license (sometimes called a “standard header”), the SPDX project
>    recommends that the standard header be included in the files, in
>    addition to an SPDX ID.
>
>    Additionally, when a file already contains a standard header or other
>    license notice, the SPDX project recommends that those existing
>    notices should not be removed. The SPDX ID is recommended to be used
>    to supplement, not replace, existing notices in files."
>
> - GPL license text have section on "How to Apply These Terms to Your New
>    Programs" which says to add license boilerplate text and it does not
>    say SPDX identifier is enough.
>
> - Also, page https://www.kernel.org/doc/html/latest/process/license-rules.html
>    does not forbid adding license plate text. (Even though it misguidedly
>    says "alternative to boilerplate text" is the use of SPDX.)
>
> - License text is a readable text and not just identifier.
>    I think SPDX tag could be not legally binding in all jurisdictions.
>
> By there reasons I believe you cannot request removing license platter
> from the source and this should be author's decision.
>
> Thanks,
>
Thanks for looking into this. I am fine with the SPDX identifier.

Regards,

    Stefan


