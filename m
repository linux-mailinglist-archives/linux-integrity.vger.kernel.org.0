Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6438C15AAB8
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 15:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBLOFI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 09:05:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727781AbgBLOFH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 09:05:07 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CDxNgg067983;
        Wed, 12 Feb 2020 09:04:44 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y3pqgsn76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:04:41 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01CDxQvm068284;
        Wed, 12 Feb 2020 09:04:39 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y3pqgsn4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:04:39 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01CE4NKQ008115;
        Wed, 12 Feb 2020 14:04:37 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 2y1mm750n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 14:04:37 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01CE4bTS53477640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 14:04:37 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F24C9112061;
        Wed, 12 Feb 2020 14:04:36 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3CF6112064;
        Wed, 12 Feb 2020 14:04:35 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.47.68])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 12 Feb 2020 14:04:35 +0000 (GMT)
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
 <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
 <09D68C13-75E2-4BD6-B4E6-F765B175C7FD@oracle.com>
 <1581087096.5585.597.camel@linux.ibm.com>
 <330BDFAC-E778-4E9D-A2D2-DD81B745F6AB@oracle.com>
 <1581097201.5585.613.camel@linux.ibm.com>
 <764C5FC8-DF0C-4B7A-8B5B-FD8B83F31568@oracle.com>
 <1581100125.5585.623.camel@linux.ibm.com>
 <992E95D5-D4B9-4913-A36F-BB47631DFE0A@oracle.com>
 <1581101672.5585.628.camel@linux.ibm.com>
 <C25E5885-F00B-48C0-AEF1-FA3014B2FDA6@oracle.com>
 <1581205431.5585.645.camel@linux.ibm.com>
 <0F13CB66-6962-44AC-A20D-CCBD82B43625@oracle.com>
 <1581354556.5585.827.camel@linux.ibm.com>
 <90E53A33-530B-40FB-9982-2818FFD78D73@oracle.com>
 <1581366829.5585.898.camel@linux.ibm.com>
 <0842A02F-3166-4E29-9CC5-9E4C5057E270@oracle.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <eae8aa2d-1874-ba72-0452-a55bc811bd3d@linux.vnet.ibm.com>
Date:   Wed, 12 Feb 2020 09:04:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <0842A02F-3166-4E29-9CC5-9E4C5057E270@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_07:2020-02-11,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120110
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/11/20 12:33 PM, Eric Snowberg wrote:
>> On Feb 10, 2020, at 1:33 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> On Mon, 2020-02-10 at 12:24 -0700, Eric Snowberg wrote:
>>>> On Feb 10, 2020, at 10:09 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>> Ok, understood, “modsig” refers to strictly kernel module appended signatures
>>>>> without regard to the keyring that verifies it.  Since there are inconsistencies
>>>>> here, would you consider something like my first patch?  It will verify an
>>>>> uncompressed kernel module containing an appended signature  when the public key
>>>>> is contained within the kernel keyring instead of the ima keyring.  Why force a
>>>>> person to add the same keys into the ima keyring for validation?  Especially when
>>>>> the kernel keyring is now used to verify appended signatures in the compressed
>>>>> modules.
>>>> Different use case scenarios have different requirements.  Suppose for
>>>> example that the group creating the kernel image is not the same as
>>>> using it.  The group using the kernel image could sign all files,
>>>> including kernel modules (imasig), with their own private key. Only
>>>> files that they signed would be permitted.  Your proposal would break
>>>> the current expectations, allowing kernel modules signed by someone
>>>> else to be loaded.
>>>>
>>> All the end user needs to do is compress any module created by the group that built
>>> the original kernel image to work around the scenario above.  Then the appended
>>> signature in the compressed module will be verified by the kernel keyring. Does
>>> this mean there is a security problem that should be fixed, if this is a concern?
>> Again, the issue isn't compressed/uncompressed kernel modules, but the
>> syscall used to load the kernel module.  IMA can prevent using the the
>> init_module syscall.  Refer to the ima_load_data() LOADING_MODULE
>> case.
> Within the ima_load_data() LOADING_MODULE case, to prevent IMA from using
> the init_module syscall, is_module_sig_enforced() must return false. Currently
> when is_module_sig_enforced() returns true, the kernel keyring is always used
> for verification.
>
> What if I change this part of my patch from
>
> +       if (rc && func == MODULE_CHECK)
>
> to
>
> +       sig_enforce = is_module_sig_enforced();
> +       if (sig_enforce && rc && func == MODULE_CHECK)
>
> Now when the init_module syscall is available, finit_module syscall will use
> both the ima keyring and kernel keyring for verification.  When the
> init_module syscall is blocked from use, the finit_module syscall will only use
> the ima keyring for validation.  I believe this would satisfy both your use
> case and mine.
>
There are two syscalls - init_module, finit_module - and two signature 
verification methods. The problem you are trying to address is the 
finit_module syscall, using both signature verification methods. Why 
enable both signature verification methods ?

If the modules are signed with build time generated keys, use module 
signature verification. If the keys are generated by you and can be 
added to .ima keyring, use IMA policy. The IMA_ARCH_POLICY defines 
secure boot policies at runtime, based on the secure boot state of the 
system. The arch-specific policies defines IMA policy only if the module 
verification is not enabled.

Thanks & Regards,

     - Nayna




