Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B833F946A
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 16:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKLPfx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 10:35:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726376AbfKLPfx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 10:35:53 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACFTHiM008173;
        Tue, 12 Nov 2019 10:35:45 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w7wqk4u6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 10:35:45 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACFUOEj003050;
        Tue, 12 Nov 2019 15:35:44 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 2w5n35yukr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 15:35:44 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACFZhxK50397546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 15:35:43 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 461E6112061;
        Tue, 12 Nov 2019 15:35:43 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30016112062;
        Tue, 12 Nov 2019 15:35:43 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 15:35:43 +0000 (GMT)
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
 <6d6f0899-8ba0-d6cf-ef3b-317ca698b687@linux.ibm.com>
 <20191112142418.3wwa4iukas4h2glp@cantor>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <23360efd-131d-d696-220e-0cdb388a0201@linux.ibm.com>
Date:   Tue, 12 Nov 2019 10:35:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112142418.3wwa4iukas4h2glp@cantor>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=883 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120134
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/12/19 9:24 AM, Jerry Snitselaar wrote:
> On Tue Nov 12 19, Stefan Berger wrote:
>> On 11/11/19 10:36 PM, Jerry Snitselaar wrote:
>>> Question about 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ 
>>> before probing for interrupts").
>>> Doesn't tpm_tis_send set this flag, and setting it here in 
>>> tpm_tis_core_init short circuits what
>>> tpm_tis_send was doing before? There is a bug report of an interrupt 
>>> storm from a tpm on a t490s laptop
>>> with the Fedora 31 kernel (5.3), and I'm wondering if this change 
>>> could cause that. Before they got
>>> the warning about interrupts not working, and using polling instead.
>>>
>> I set this flag for the TIS because it wasn't set anywhere else. 
>> tpm_tis_send() wouldn't set the flag but go via the path:
>>
>> if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>>
>>         return tpm_tis_send_main(chip, buf, len);
>>
>> the only other line for the TIS to set the IRQ flag was in the same 
>> function further below, though that wouldn't be reached due to the 
>> above:
>>
>> [...]
>>
>> priv->irq = irq;
>>
>> chip->flags |= TPM_CHIP_FLAG_IRQ;
>>
>>
>>    Stefan
>>
>>
>
> Ugh, you're right I was reading that as ! around both the flag and 
> priv->irq_tested.
>
> Should the flag be cleared if tpm_tis_probe_irq_single fails prior to 
> calling
> tpm_tis_gen_interrupt?
>
The disable_interrupts() should be called to reset the flag if, while 
probing, the interrupt handler wasn't called. Maybe that t490s returns 
either via this path

https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/tpm_tis_core.c#L631

or this one here

https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/tpm_tis_core.c#L634

thinking the (shared) interrupt is not for it?! But this would mean 
TPM_INT_STATUS is broken...


