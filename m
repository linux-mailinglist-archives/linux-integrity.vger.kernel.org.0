Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C69180A31
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2020 22:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgCJVSQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Mar 2020 17:18:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgCJVSP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Mar 2020 17:18:15 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ALGc5B002011;
        Tue, 10 Mar 2020 17:17:03 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym852d2fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Mar 2020 17:17:03 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02ALGXwO024560;
        Tue, 10 Mar 2020 21:17:01 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 2ym386nk0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Mar 2020 21:17:01 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02ALH09c51380540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 21:17:00 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AC21AC05F;
        Tue, 10 Mar 2020 21:17:00 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FBBBAC059;
        Tue, 10 Mar 2020 21:16:59 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.11.149])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Mar 2020 21:16:59 +0000 (GMT)
Subject: Re: [PATCH v6 3/3] tpm: ibmvtpm: Add support for TPM2
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        gcwilson@linux.ibm.com, jgg@ziepe.ca
References: <20200304132243.179402-1-stefanb@linux.vnet.ibm.com>
 <20200304132243.179402-4-stefanb@linux.vnet.ibm.com>
 <a54d6cffe536d568a9fde46f1f32616e89a42d30.camel@linux.intel.com>
 <8dcd22c1-b05f-d619-58c5-fd2248c75b9e@linux.ibm.com>
 <20200306183305.GA7472@linux.intel.com>
 <9905c816-04f3-4674-055c-b2606e30fc17@linux.ibm.com>
 <20200307110825.GA6705@linux.intel.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <ce77deb4-95cd-df1a-bdcf-bb5794b9ca42@linux.vnet.ibm.com>
Date:   Tue, 10 Mar 2020 17:16:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200307110825.GA6705@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_15:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 3/7/20 6:09 AM, Jarkko Sakkinen wrote:
> On Fri, Mar 06, 2020 at 01:51:30PM -0500, Stefan Berger wrote:
>> On 3/6/20 1:33 PM, Jarkko Sakkinen wrote:
>>> On Thu, Mar 05, 2020 at 08:58:15AM -0500, Stefan Berger wrote:
>>>> On 3/5/20 6:21 AM, Jarkko Sakkinen wrote:
>>>>> On Wed, 2020-03-04 at 08:22 -0500, Stefan Berger wrote:
>>>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>>>
>>>>>> Support TPM2 in the IBM vTPM driver. The hypervisor tells us what
>>>>>> version of TPM is connected through the vio_device_id.
>>>>>>
>>>>>> In case a TPM2 device is found, we set the TPM_CHIP_FLAG_TPM2 flag
>>>>>> and get the command codes attributes table. The driver does
>>>>>> not need the timeouts and durations, though.
>>>>>>
>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>> There is huge bunch of people in the cc-list and these patches
>>>>> have total zero tested-by's. Why is that?
>>>> I cc'ed them because of their involvement in other layers. That's all I can
>>>> say.
>>> OK, so there is no one who can test this?
>> Nayna said she will test it next week.
> That'd be great. Otherwise, I have no issues pulling the patches.
>
> /Jarkko


I tested the patches, except testing of bugfix for vtpm1.2.

Here are my Ack-by/Tested-by for the patchset:

Acked-by: Nayna Jain <nayna@linux.ibm.com>

Tested-by: Nayna Jain <nayna@linux.ibm.com>

Thanks & Regards,

      - Nayna





