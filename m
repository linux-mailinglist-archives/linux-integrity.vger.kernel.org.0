Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAC82198667
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 23:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgC3V0b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 17:26:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728407AbgC3V0a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 17:26:30 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UL5k2D020038;
        Mon, 30 Mar 2020 17:26:29 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3020wd1cs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 17:26:29 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02ULPUBN021597;
        Mon, 30 Mar 2020 21:26:28 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 301x770p19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 21:26:28 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02ULQQou47382936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 21:26:26 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B94906A04D;
        Mon, 30 Mar 2020 21:26:26 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C7EF6A047;
        Mon, 30 Mar 2020 21:26:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 30 Mar 2020 21:26:25 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] acpi: Extend TPM2 ACPI table with missing log
 fields
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20200330151536.871700-1-stefanb@linux.vnet.ibm.com>
 <20200330151536.871700-2-stefanb@linux.vnet.ibm.com>
 <20200330192830.GC1384380@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <fa195dea-205b-fd0e-fb58-8d185a4a13c6@linux.ibm.com>
Date:   Mon, 30 Mar 2020 17:26:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200330192830.GC1384380@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_07:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300175
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/30/20 3:28 PM, Jarkko Sakkinen wrote:
> On Mon, Mar 30, 2020 at 11:15:34AM -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Recent extensions of the TPM2 ACPI table added 3 more fields
>> including 12 bytes of start method specific parameters and Log Area
>> Minimum Length (u32) and Log Area Start Address (u64). So, we extend
>> the existing structure with these fields to allow non-UEFI systems
>> to access the TPM2's log.
>>
>> The specification that has the new fields is the following:
>>    TCG ACPI Specification
>>    Family "1.2" and "2.0"
>>    Version 1.2, Revision 8
>>
>> Adapt all existing table size calculations to use
>> offsetof(struct acpi_table_tpm2, start_method_specific)
>> [where start_method_specific is a newly added field]
>> rather than sizeof(struct acpi_table_tpm2) so that the addition
>> of the new fields does not affect current systems that may not
>> have them.
>>
> Cc: linux-acpi@vger.kernel.org
>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> You have this comment:
>
> /* Platform-specific data follows */

You mean there 'was this comment'? I actually removed this comment 
because I didn't know what it meant or what it has to do with 'platform':

-
-       /* Platform-specific data follows */
+       u8  start_method_specific[12];
+       u32 log_area_minimum_length;
+       u64 log_area_start_address;

Specs: 
https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf

PDF Page 16 / Doc page 10 bottom.

start_method_specific is obviously related to the start_method field. 
The subsequent two fields are optional and show those 2 filelds we know 
from the TCPA ACPI table.

>
> Can you elaborate a bit which platform you are speaking of? It is now
> enabled for everything.
>
> /Jarkko


