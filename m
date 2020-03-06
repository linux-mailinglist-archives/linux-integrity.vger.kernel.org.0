Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0D817C5B0
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Mar 2020 19:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCFSvx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Mar 2020 13:51:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgCFSvw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Mar 2020 13:51:52 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026IpMKb036224;
        Fri, 6 Mar 2020 13:51:40 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ykgng1yb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 13:51:40 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 026IoqlY013024;
        Fri, 6 Mar 2020 18:51:39 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 2yffk7tw01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 18:51:39 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 026IpcDt57868664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Mar 2020 18:51:38 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C4397805E;
        Fri,  6 Mar 2020 18:51:38 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3818F7805C;
        Fri,  6 Mar 2020 18:51:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  6 Mar 2020 18:51:30 +0000 (GMT)
Subject: Re: [PATCH v6 3/3] tpm: ibmvtpm: Add support for TPM2
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca
References: <20200304132243.179402-1-stefanb@linux.vnet.ibm.com>
 <20200304132243.179402-4-stefanb@linux.vnet.ibm.com>
 <a54d6cffe536d568a9fde46f1f32616e89a42d30.camel@linux.intel.com>
 <8dcd22c1-b05f-d619-58c5-fd2248c75b9e@linux.ibm.com>
 <20200306183305.GA7472@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <9905c816-04f3-4674-055c-b2606e30fc17@linux.ibm.com>
Date:   Fri, 6 Mar 2020 13:51:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200306183305.GA7472@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_06:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003060116
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/6/20 1:33 PM, Jarkko Sakkinen wrote:
> On Thu, Mar 05, 2020 at 08:58:15AM -0500, Stefan Berger wrote:
>> On 3/5/20 6:21 AM, Jarkko Sakkinen wrote:
>>> On Wed, 2020-03-04 at 08:22 -0500, Stefan Berger wrote:
>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>> Support TPM2 in the IBM vTPM driver. The hypervisor tells us what
>>>> version of TPM is connected through the vio_device_id.
>>>>
>>>> In case a TPM2 device is found, we set the TPM_CHIP_FLAG_TPM2 flag
>>>> and get the command codes attributes table. The driver does
>>>> not need the timeouts and durations, though.
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> There is huge bunch of people in the cc-list and these patches
>>> have total zero tested-by's. Why is that?
>>
>> I cc'ed them because of their involvement in other layers. That's all I can
>> say.
> OK, so there is no one who can test this?

Nayna said she will test it next week.


    Stefan



>
> /Jarkko


