Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23732050A0
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 13:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgFWL1w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 07:27:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34780 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732189AbgFWL1u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 07:27:50 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NB6EWM032232;
        Tue, 23 Jun 2020 07:27:45 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uds05fvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 07:27:45 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NBQ8ZX015213;
        Tue, 23 Jun 2020 11:27:44 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 31sa38ptxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 11:27:44 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05NBRgYO10617418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 11:27:42 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B43586A054;
        Tue, 23 Jun 2020 11:27:43 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 002E16A047;
        Tue, 23 Jun 2020 11:27:42 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jun 2020 11:27:42 +0000 (GMT)
Subject: Re: [PATCH v3] acpi: Extend TPM2 ACPI table with missing log fields
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-integrity@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
References: <20200331214949.883781-1-stefanb@linux.vnet.ibm.com>
 <20200401083729.GD17325@linux.intel.com>
 <CAJZ5v0gQ04h1+zN4wHj1vkwPvqu3RPfsY60VJ+GOtgUrvWuxLQ@mail.gmail.com>
 <20200402192145.GB10314@linux.intel.com>
 <dfd2d622-90cb-9621-7b7d-5282f5ee7359@linux.ibm.com>
 <20200623005647.GD28795@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8d032b3c-650b-b806-3d97-2921341b7f0e@linux.ibm.com>
Date:   Tue, 23 Jun 2020 07:27:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200623005647.GD28795@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_06:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 cotscore=-2147483648 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006230084
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/22/20 8:56 PM, Jarkko Sakkinen wrote:
> On Fri, Jun 19, 2020 at 11:14:20AM -0400, Stefan Berger wrote:
>> On 4/2/20 3:21 PM, Jarkko Sakkinen wrote:
>>> On Wed, Apr 01, 2020 at 11:05:36AM +0200, Rafael J. Wysocki wrote:
>>>> On Wed, Apr 1, 2020 at 10:37 AM Jarkko Sakkinen
>>>> <jarkko.sakkinen@linux.intel.com> wrote:
>>>>> On Tue, Mar 31, 2020 at 05:49:49PM -0400, Stefan Berger wrote:
>>>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>>>
>>>>>> Recent extensions of the TPM2 ACPI table added 3 more fields
>>>>>> including 12 bytes of start method specific parameters and Log Area
>>>>>> Minimum Length (u32) and Log Area Start Address (u64). So, we extend
>>>>>> the existing structure with these fields to allow non-UEFI systems
>>>>>> to access the TPM2's log.
>>>>>>
>>>>>> The specification that has the new fields is the following:
>>>>>>     TCG ACPI Specification
>>>>>>     Family "1.2" and "2.0"
>>>>>>     Version 1.2, Revision 8
>>>>>>
>>>>>> Adapt all existing table size calculations to use
>>>>>> offsetof(struct acpi_table_tpm2, start_method_specific)
>>>>>> [where start_method_specific is a newly added field]
>>>>>> rather than sizeof(struct acpi_table_tpm2) so that the addition
>>>>>> of the new fields does not affect current systems that may not
>>>>>> have them.
>>>>>>
>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>>> Cc: linux-acpi@vger.kernel.org
>>>>> I think I'm cool with this but needs an ack from ACPI maintainer.
>>>>>
>>>>> Rafael, given that this not an intrusive change in any possible means,
>>>>> can I pick this patch and put it to my next pull request?
>>>> Yes, please.
>>>>
>>>> Thanks!
>>> Great, thanks Rafael.
>>>
>>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>
>>> Do you mind if I add your ack to the commit?
>>
>> Any chance to get v4 applied?
> You should split the actbl3.h change to a separate patch and add 'Cc:'
> tag to Rafael to the commit message.

I did this in one patch because it seems like a mistake to extend the 
structure and not modify the size checks.

   Stefan

>
> /Jarkko


