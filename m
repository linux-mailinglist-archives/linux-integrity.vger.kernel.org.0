Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9030A200F53
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2020 17:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392423AbgFSPPd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jun 2020 11:15:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392419AbgFSPPb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 11:15:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JF3QjF114727;
        Fri, 19 Jun 2020 11:14:26 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rkgjw7b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 11:14:26 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05JF9wSk027687;
        Fri, 19 Jun 2020 15:14:25 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 31q8km3xuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 15:14:25 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05JFEM0r10420970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 15:14:22 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37C3613604F;
        Fri, 19 Jun 2020 15:14:24 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C39D136059;
        Fri, 19 Jun 2020 15:14:21 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 19 Jun 2020 15:14:20 +0000 (GMT)
Subject: Re: [PATCH v3] acpi: Extend TPM2 ACPI table with missing log fields
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-integrity@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
References: <20200331214949.883781-1-stefanb@linux.vnet.ibm.com>
 <20200401083729.GD17325@linux.intel.com>
 <CAJZ5v0gQ04h1+zN4wHj1vkwPvqu3RPfsY60VJ+GOtgUrvWuxLQ@mail.gmail.com>
 <20200402192145.GB10314@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <dfd2d622-90cb-9621-7b7d-5282f5ee7359@linux.ibm.com>
Date:   Fri, 19 Jun 2020 11:14:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402192145.GB10314@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_16:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 cotscore=-2147483648 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190107
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/2/20 3:21 PM, Jarkko Sakkinen wrote:
> On Wed, Apr 01, 2020 at 11:05:36AM +0200, Rafael J. Wysocki wrote:
>> On Wed, Apr 1, 2020 at 10:37 AM Jarkko Sakkinen
>> <jarkko.sakkinen@linux.intel.com> wrote:
>>> On Tue, Mar 31, 2020 at 05:49:49PM -0400, Stefan Berger wrote:
>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>> Recent extensions of the TPM2 ACPI table added 3 more fields
>>>> including 12 bytes of start method specific parameters and Log Area
>>>> Minimum Length (u32) and Log Area Start Address (u64). So, we extend
>>>> the existing structure with these fields to allow non-UEFI systems
>>>> to access the TPM2's log.
>>>>
>>>> The specification that has the new fields is the following:
>>>>    TCG ACPI Specification
>>>>    Family "1.2" and "2.0"
>>>>    Version 1.2, Revision 8
>>>>
>>>> Adapt all existing table size calculations to use
>>>> offsetof(struct acpi_table_tpm2, start_method_specific)
>>>> [where start_method_specific is a newly added field]
>>>> rather than sizeof(struct acpi_table_tpm2) so that the addition
>>>> of the new fields does not affect current systems that may not
>>>> have them.
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> Cc: linux-acpi@vger.kernel.org
>>> I think I'm cool with this but needs an ack from ACPI maintainer.
>>>
>>> Rafael, given that this not an intrusive change in any possible means,
>>> can I pick this patch and put it to my next pull request?
>> Yes, please.
>>
>> Thanks!
> Great, thanks Rafael.
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Do you mind if I add your ack to the commit?


Any chance to get v4 applied?


>
> /Jarkko


