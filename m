Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12AFF9C68
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 22:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKLVjG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 16:39:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726912AbfKLVjG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 16:39:06 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACKQcVM080297;
        Tue, 12 Nov 2019 15:30:53 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w820mkshg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 15:30:53 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACKUL5v031354;
        Tue, 12 Nov 2019 20:30:52 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 2w5n361vcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 20:30:52 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACKUprg32964922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 20:30:51 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8001FAC05E;
        Tue, 12 Nov 2019 20:30:51 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 728D9AC059;
        Tue, 12 Nov 2019 20:30:51 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 20:30:51 +0000 (GMT)
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
 <20191112200703.GB11213@linux.intel.com>
 <20191112201734.sury5nd3cptkckgb@cantor>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <50290fc8-4d22-3eb5-c930-079f8b819a8e@linux.ibm.com>
Date:   Tue, 12 Nov 2019 15:30:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112201734.sury5nd3cptkckgb@cantor>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120174
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/12/19 3:17 PM, Jerry Snitselaar wrote:
> On Tue Nov 12 19, Jarkko Sakkinen wrote:
>> On Mon, Nov 11, 2019 at 08:36:37PM -0700, Jerry Snitselaar wrote:
>>> Question about 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ
>>> before probing for interrupts").  Doesn't tpm_tis_send set this flag,
>>> and setting it here in tpm_tis_core_init short circuits what
>>> tpm_tis_send was doing before? There is a bug report of an interrupt
>>> storm from a tpm on a t490s laptop with the Fedora 31 kernel (5.3),
>>> and I'm wondering if this change could cause that. Before they got the
>>> warning about interrupts not working, and using polling instead.
>>
>> Looks like it. Stefan?
>>
>> /Jarkko
>>
>
> Stefan is right about the condition check at the beginning of 
> tpm_tis_send.
>
>     if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>         return tpm_tis_send_main(chip, buf, len);
>
> Before his change it would've gone straight to calling
> tpm_tis_send_main instead of jumping down and doing the irq test, due
> to the flag not being set. With his change it should now skip this
> tpm_tis_send_main call when tpm_tis_gen_interrupt is called, and then
> after that time through tpm_tis_send priv->irq_tested will be set, and
> the flag should be set as to whether or not irqs were working.
>
> I should hopefully have access to a t490s in a few days so I can look 
> at it,
> and try to figure out what is happening.
>
I hope the t490s is an outlier. Give the patch I just posted a try.

     Stefan


