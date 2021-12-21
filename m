Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF247C14D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 15:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhLUOSP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 09:18:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235448AbhLUOSO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 09:18:14 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLCUbPL029863;
        Tue, 21 Dec 2021 14:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=L38EGZPh0MTK7NIKzTy3tAX0A1zg41J+OOXfyktAzos=;
 b=lIbz9bhgeJEXz9BYEKAHi7UW8HPXmksdmPfqxdD6hDCW9sCkMC/fuApL/rQ972RjeifS
 e7/xsqgmUmYVbBatgUfOgb8XnMBY0V5S5WTOFmQzBojuak04MABLgr6+p3H5EgdzYia4
 MT2DzojUnPmPq7n5+CGvTyteZWSZU6eHTNu5beFOQDvJsdTR3hUtZcpS7w31HoUc673J
 PErTPa39Dq9Z2zhRobf20NgqPOf5cOmxGcigjzU5wWXhvNPluwpMhx/9Jqcsb27RBPAu
 4RZg00yeQxUHutUoGdmGT1gKbuHo8julHaYby/ok0mILUhwxKmJhy2gkkG/8xXi3mG/M MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d3f0aj5n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 14:18:09 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BLDiVUS029320;
        Tue, 21 Dec 2021 14:18:09 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d3f0aj5n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 14:18:09 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BLEH1w8004500;
        Tue, 21 Dec 2021 14:18:08 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3d179axght-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 14:18:08 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BLEI4Lc23462334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 14:18:04 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 178E011206B;
        Tue, 21 Dec 2021 14:18:04 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 048FC112061;
        Tue, 21 Dec 2021 14:18:03 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 21 Dec 2021 14:18:03 +0000 (GMT)
Message-ID: <eca48e99-3aad-d2fc-c073-aa5ff18c9b51@linux.ibm.com>
Date:   Tue, 21 Dec 2021 09:17:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] tpm: Fix kexec crash due to access to ops NULL pointer
 (powerpc)
Content-Language: en-US
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, pavrampu@in.ibm.com,
        Korrapati.Likhitha@ibm.com, gcwilson@us.ibm.com
References: <20211212012804.1555661-1-stefanb@linux.ibm.com>
 <YcGUoJCtmqfCWER0@iki.fi>
 <8b0c9683-d29b-38a2-8dfe-8f47db6544f2@linux.ibm.com>
In-Reply-To: <8b0c9683-d29b-38a2-8dfe-8f47db6544f2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d0EAq7upulZ-bLNmTEwKI7py22Jw1x5e
X-Proofpoint-GUID: gOxxZfjsrUmlle-J1uOvqKzwxS0PQYrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210065
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/21/21 09:01, Stefan Berger wrote:
>
> On 12/21/21 03:47, Jarkko Sakkinen wrote:
>> On Sat, Dec 11, 2021 at 08:28:04PM -0500, Stefan Berger wrote:
>>> Fix the following crash on kexec by checking chip->ops for a NULL 
>>> pointer
>>> in tpm_chip_start() and returning an error code if this is the case.
>>>
>>> BUG: Kernel NULL pointer dereference on read at 0x00000060
>>> Faulting instruction address: 0xc00000000099a06c
>>> Oops: Kernel access of bad area, sig: 11 [#1]
>>> ...
>>> NIP [c00000000099a06c] tpm_chip_start+0x2c/0x140
>>>   LR [c00000000099a808] tpm_chip_unregister+0x108/0x170
>>> Call Trace:
>>> [c0000000188bfa00] [c000000002b03930] fw_devlink_strict+0x0/0x8 
>>> (unreliable)
>>> [c0000000188bfa30] [c00000000099a808] tpm_chip_unregister+0x108/0x170
>>> [c0000000188bfa70] [c0000000009a3874] tpm_ibmvtpm_remove+0x34/0x130
>>> [c0000000188bfae0] [c000000000110dbc] vio_bus_remove+0x5c/0xb0
>>> [c0000000188bfb20] [c0000000009bc154] device_shutdown+0x1d4/0x3a8
>>> [c0000000188bfbc0] [c000000000196e14] kernel_restart_prepare+0x54/0x70
>>>
>>> The referenced patch below introduced a function to shut down the 
>>> VIO bus.
>>> The bus shutdown now calls tpm_del_char_device (via 
>>> tpm_chip_unregister)
>>> after a call to tpm_class_shutdown, which already set chip->ops to 
>>> NULL.
>>> The crash occurrs when tpm_del_char_device calls tpm_chip_start with 
>>> the
>>> chip->ops NULL pointer.
>>>
>>> Fixes: 39d0099f9439 ("powerpc/pseries: Add shutdown() to vio_driver 
>>> and vio_bus")
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>   drivers/char/tpm/tpm-chip.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>>> index ddaeceb7e109..cca1bde296ee 100644
>>> --- a/drivers/char/tpm/tpm-chip.c
>>> +++ b/drivers/char/tpm/tpm-chip.c
>>> @@ -101,6 +101,9 @@ int tpm_chip_start(struct tpm_chip *chip)
>>>   {
>>>       int ret;
>>>   +    if (!chip->ops)
>>> +        return -EINVAL;
>> This triggers to all drivers, not just tpm_ibmvtpm, i.e. the fix has
>> side-effects.
>
> What are those side-effects?
>
>
I am asking because if one entered tpm_chip_start() with chip->ops = 
NULL it would crash any system. So now the side-effect is that one can 
call this function without crashing the system but gets an -EINVAL back.

Another alternative that prevents these crashes is this change here 
including code deduplication:

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb7e109..888d37293091 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -296,7 +296,7 @@ static int tpm_class_shutdown(struct device *dev)
         struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);

         down_write(&chip->ops_sem);
-       if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+       if (chip->ops && chip->flags & TPM_CHIP_FLAG_TPM2) {
                 if (!tpm_chip_start(chip)) {
                         tpm2_shutdown(chip, TPM2_SU_CLEAR);
                         tpm_chip_stop(chip);
@@ -473,15 +473,7 @@ static void tpm_del_char_device(struct tpm_chip *chip)
         mutex_unlock(&idr_lock);

         /* Make the driver uncallable. */
-       down_write(&chip->ops_sem);
-       if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-               if (!tpm_chip_start(chip)) {
-                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
-                       tpm_chip_stop(chip);
-               }
-       }
-       chip->ops = NULL;
-       up_write(&chip->ops_sem);
+       tpm_class_shutdown(&chip->dev);
  }

  static void tpm_del_legacy_sysfs(struct tpm_chip *chip)



     Stefan

