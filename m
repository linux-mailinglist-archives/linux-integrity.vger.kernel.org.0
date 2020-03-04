Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EA0179129
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Mar 2020 14:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbgCDNSd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Mar 2020 08:18:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388065AbgCDNSd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Mar 2020 08:18:33 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024DIR8J098820;
        Wed, 4 Mar 2020 08:18:27 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yhsv9rrdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:18:11 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 024DHdTt011667;
        Wed, 4 Mar 2020 13:18:10 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 2yffk73qjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 13:18:10 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 024DI9P265601856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Mar 2020 13:18:09 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6856A7805E;
        Wed,  4 Mar 2020 13:18:09 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54BBB7805C;
        Wed,  4 Mar 2020 13:18:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  4 Mar 2020 13:18:08 +0000 (GMT)
Subject: Re: [PATCH v5 3/3] tpm: ibmvtpm: Add support for TPM 2
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca
References: <20200228030330.18081-1-stefanb@linux.vnet.ibm.com>
 <20200228030330.18081-4-stefanb@linux.vnet.ibm.com>
 <20200302111514.GC3979@linux.intel.com>
 <2f8a9519-c1ab-8d46-18c4-4e0f9d53e3ff@linux.ibm.com>
 <20200303201104.GG5775@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <d2fda6ef-0c1e-7e20-08a2-44987564b7e1@linux.ibm.com>
Date:   Wed, 4 Mar 2020 08:18:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200303201104.GG5775@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040102
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/3/20 3:11 PM, Jarkko Sakkinen wrote:
> On Mon, Mar 02, 2020 at 11:21:27AM -0500, Stefan Berger wrote:
>> On 3/2/20 6:15 AM, Jarkko Sakkinen wrote:
>>> On Thu, Feb 27, 2020 at 10:03:30PM -0500, Stefan Berger wrote:
>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>> Support TPM 2 in the IBM vTPM driver. The hypervisor tells us what
>>>> version of TPM is connected through the vio_device_id.
>>> I'd prefer "TPM2" over "TPM 2".
>> Fixed.
>>>> In case a TPM 2 is found, we set the TPM_CHIP_FLAG_TPM2 flag
>>>> and get the command codes attributes table. The driver does
>>>> not need the timeouts and durations, though.
>>> A TPM2 what? TPM2 is not a thing.
>>
>> I don't know what you mean? Is it the word 'found' and it should be
>> 'present' ? Otherwise a TPM2 is a 'thing' / object / device, at least to me.
> TPM2 chip would be better. TPM2 can refer either to the protocol or to a
> chip.

Let's call it 'device', which in this case is a virtual device rather 
than a 'virtual chip.'


    Stefan

>
> /Jarkko


