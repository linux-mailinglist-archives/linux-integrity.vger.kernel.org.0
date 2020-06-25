Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90A620A865
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 00:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407577AbgFYWsP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 18:48:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407544AbgFYWsN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 18:48:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PMYF1t155889;
        Thu, 25 Jun 2020 18:48:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vts14m6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 18:48:11 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PMkg8U185576;
        Thu, 25 Jun 2020 18:48:11 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vts14m66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 18:48:11 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PMeX2d027952;
        Thu, 25 Jun 2020 22:48:10 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 31uus3ygx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 22:48:10 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PMm92914287718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 22:48:09 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2081112061;
        Thu, 25 Jun 2020 22:48:09 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4959A112062;
        Thu, 25 Jun 2020 22:48:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 22:48:09 +0000 (GMT)
Subject: Re: Enabling interrupts in QEMU TPM TIS
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1ca3a53d-2b83-7522-5ce1-83d9cc2f207d@linux.ibm.com>
 <20200625172802.GS6578@ziepe.ca>
 <0a524093-e744-e266-6087-ddc17b5c598c@linux.ibm.com>
Message-ID: <5b3267b7-57d5-badf-6664-9d47bc9909e7@linux.ibm.com>
Date:   Thu, 25 Jun 2020 18:48:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0a524093-e744-e266-6087-ddc17b5c598c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_19:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 adultscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=883 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/25/20 5:26 PM, Stefan Berger wrote:
> On 6/25/20 1:28 PM, Jason Gunthorpe wrote:
>> On Thu, Jun 25, 2020 at 10:56:43AM -0400, Stefan Berger wrote:
>>> Hello!
>>>
>>>   I want to enable IRQs now in QEMU's TPM TIS device model and I 
>>> need to work
>>> with the following patch to Linux TIS. I am wondering whether the 
>>> changes
>>> there look reasonable to you? Windows works with the QEMU modifications
>>> as-is, so maybe it's a bug in the TIS code (which I had not run into
>>> before).
>>>
>>>
>>> The point of the loop I need to introduce in the interrupt handler 
>>> is that
>>> while the interrupt handler is running another interrupt may 
>>> occur/be posted
>>> that then does NOT cause the interrupt handler to be invoked again but
>>> causes a stall, unless the loop is there.
>> That seems like a qemu bug, TPM interrupts are supposed to be level
>> interrupts, not edge.
>
>
> Following this document here the hardware may choose to support 
> different types of interrutps:
>
> https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p04_r0p37_pub-1.pdf 
>
>
> Table 23. Edge falling or rising, level low or level high.
>
> So with different steps in the driver causing different types of 
> interrupts, we may get into such situations where we process some 
> interrupt 'reasons' but then another one gets posted, I guess due to 
> parallel processing.


Another data point: I had the TIS driver working on IRQ 5 (festeoi) 
without the introduction of this loop. There are additional bits being 
set while the interrupt handler is running, but the handler deals with 
them in the next invocation. On IRQ 13 (edge), it does need the loop 
since the next interrupt handler invocation is not happening. That IRQ 
13 is an edge interrupt, is this a hard-configured PC 'thing'? Windows 
drove this to IRQ 13, which seemed to be the only one accepted by it and 
iirc it wouldn't even touch the TIS (found via tracing) if another IRQ 
than 13 was declared in the ACPI table.


>
>   Stefan
>
>

