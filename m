Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDB8FECB0
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Nov 2019 15:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfKPOdK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 16 Nov 2019 09:33:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727617AbfKPOdK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 16 Nov 2019 09:33:10 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAGEVnjn098442;
        Sat, 16 Nov 2019 09:32:08 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wacaj952r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Nov 2019 09:32:08 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAGEVlKx098072;
        Sat, 16 Nov 2019 09:32:08 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wacaj952h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Nov 2019 09:32:07 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAGETgQn002017;
        Sat, 16 Nov 2019 14:32:11 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 2wa8r5bk3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Nov 2019 14:32:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAGEW6nD33227092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Nov 2019 14:32:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 538DBB205F;
        Sat, 16 Nov 2019 14:32:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 433FBB2067;
        Sat, 16 Nov 2019 14:32:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 16 Nov 2019 14:32:06 +0000 (GMT)
Subject: Re: [PATCH] tpm_tis: Move setting of TPM_CHIP_FLAG_IRQ into
 tpm_tis_probe_irq_single
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, jsnitsel@redhat.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20191112202725.3009814-1-stefanb@linux.vnet.ibm.com>
 <20191114164151.GB9528@linux.intel.com>
 <20191114164426.GC9528@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com>
Date:   Sat, 16 Nov 2019 09:32:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191114164426.GC9528@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-16_04:2019-11-15,2019-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=857
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911160137
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/14/19 11:44 AM, Jarkko Sakkinen wrote:
> On Thu, Nov 14, 2019 at 06:41:51PM +0200, Jarkko Sakkinen wrote:
>> On Tue, Nov 12, 2019 at 03:27:25PM -0500, Stefan Berger wrote:
>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>
>>> Move the setting of the TPM_CHIP_FLAG_IRQ for irq probing into
>>> tpm_tis_probe_irq_single before calling tpm_tis_gen_interrupt.
>>> This move handles error conditions better that may arise if anything
>>> before fails in tpm_tis_probe_irq_single.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> What about just changing the condition?
> Also cannot take this since it is not a bug (no fixes tag).

I'll repost but will wait until Jerry has tested it on that machine.

    Stefan


>
> /Jarkko


