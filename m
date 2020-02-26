Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9888D170630
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2020 18:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgBZRg0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 12:36:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgBZRg0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 12:36:26 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QHU3fE115469;
        Wed, 26 Feb 2020 12:35:19 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydqfuwb4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 12:35:18 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01QHYpxm003952;
        Wed, 26 Feb 2020 17:35:18 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 2ydcmkrpgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 17:35:18 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01QHZHF835127648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 17:35:17 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56E4FAE064;
        Wed, 26 Feb 2020 17:35:17 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F4DBAE063;
        Wed, 26 Feb 2020 17:35:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Feb 2020 17:35:17 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] tpm: Implement tpm2_init to call when
 TPM_OPS_AUTO_STARTUP is not set
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca
References: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
 <20200213202329.898607-4-stefanb@linux.vnet.ibm.com>
 <20200225170015.GE15662@linux.intel.com>
 <3813980a-6c5e-c99f-7b37-b20b72eb6a8a@linux.ibm.com>
 <20200226150255.GB3407@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <c31ef080-1172-e10b-e7b1-ab8e1682c860@linux.ibm.com>
Date:   Wed, 26 Feb 2020 12:35:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200226150255.GB3407@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_06:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/26/20 10:02 AM, Jarkko Sakkinen wrote:
> On Tue, Feb 25, 2020 at 01:20:39PM -0500, Stefan Berger wrote:
>> On 2/25/20 12:00 PM, Jarkko Sakkinen wrote:
>>> On Thu, Feb 13, 2020 at 03:23:28PM -0500, Stefan Berger wrote:
>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>> Implement tpm2_init() that gets the TPM 2 timeouts and command durations
>>>> and command code attributes. This function is to be called in case the
>>>> TPM_OPS_AUTO_STARTUP flag is not set and therefore tpm2_auto_startup()
>>>> is not called.
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> The commit makes zero effort trying to explain what the heck tpm_init()
>>> is and when it should be used and why the function name tpm2_init().
>> Are you saying the explanation of when to use tpm2_init above is not enough?
>> 'bviously we are trying to cover the case of using the TPM 2 by a driver
>> that doesn't use the TPM_OPS_AUTO_STARTUP flag and therefore the TPM 2
>> timeouts and command durations and command code attributes are not set as
>> they would be if tpm2_auto_startup() was to be called and tpm2_init() is the
>> alternative to call. I didn't like tpm2_init() either... any suggestions for
>> a better name?
> I'm not getting what this commit is trying to do in the first place.
I sent out v3, maybe the text there is better.
>
> /Jarkko


