Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8900E76F57A
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 00:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjHCWKb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 18:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHCWKa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 18:10:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36788110
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 15:10:29 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373M1MAm022992;
        Thu, 3 Aug 2023 22:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PV/ya0GbaqKT5ixJr5roBxDh/Cx5QfIoHQDlR1REVig=;
 b=IuAsGEAa6rOwwXmggSIztrR1D0eE7yjsFMmoTATRowVC1GbxOJi+BhWZ4AtCkCEvIwTX
 uGqPz9XiCQziXKj8h8wkZqQFVyTVVJKbzMJdnXE0OiySIaF01anCS5QX+vsjPJl/8468
 YA+RT39E9klt1pU0qyZKRZdoK7QdLfMKgJwr/NmIPqcZDu3DBNj90ak27H4UfRjbATUk
 9+zvmt9AwBEqVDCZP71DPbol5FSL8T+e3OYf26fkbM3MZDKKnke0L0fvJe6vL6ndkEbl
 2gAAPl3p+zIPBMF48qr3peNipDYbh9TKqt8+kZNDHcMj4Ei8BwYofS92IhqPgTTHjLwi ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mnf0axe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:10:04 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373M20fW025111;
        Thu, 3 Aug 2023 22:10:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mnf0awr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:10:03 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373Krdbd022144;
        Thu, 3 Aug 2023 22:10:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kp2rey7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:10:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373MA143262782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 22:10:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B18D558059;
        Thu,  3 Aug 2023 22:10:01 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37ABD58058;
        Thu,  3 Aug 2023 22:10:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Aug 2023 22:10:00 +0000 (GMT)
Message-ID: <a4a5e40b-abc1-27fa-3984-cee18fb4522c@linux.ibm.com>
Date:   Thu, 3 Aug 2023 18:09:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/6] Measuring TPM update counter in IMA
Content-Language: en-US
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <dbfb545b-9399-d505-6739-c2940930ef48@linux.ibm.com>
 <cb2029b8-d585-1c06-a0ac-15624cf70e28@linux.microsoft.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <cb2029b8-d585-1c06-a0ac-15624cf70e28@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4kiFAqEFpwnAeSykxNBNTiHf7D4U9xq3
X-Proofpoint-GUID: zZZx4wBAr_3PElPU33vqKndaUEtepgfM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/3/23 17:30, Tushar Sugandhi wrote:

> 
> Thanks Stefan for reviewing this series. Appreciate it.
> 
> On 8/3/23 06:37, Stefan Berger wrote:
>>
>>
>> On 8/1/23 14:19, Tushar Sugandhi wrote:
>>> Entries in IMA log may be lost due to code bugs, certain error conditions
>>
>> I hope we don't have such bugs. And I guess the most critical ones would be
>> between logging and PCR extensions
>>
> I hope so too, but in general, it’s hard to prove a negative.
> That’s why this patch series. :)
>>> being met etc.  This can result in TPM PCRs getting out of sync with the
>>> IMA log.  One such example is events between kexec 'load' and kexec
>>> 'execute' getting lost from the IMA log when the system soft-boots into
>>> the new Kernel using kexec[1].  The remote attestation service does not
>>
>> Though this particular condition I thought would go away with your kexec series.
>>
> Currently the events in-between kexec ‘load’ and ‘execute’ are always
> lost – because IMA log is captured at ‘load’.  My kexec series addresses
> this scenario. But as you said, there is always a possibility that the
> events will still be lost during kexec because of error conditions, OOM
> etc.
>> The other conditions would be an out-of-memory or TPM failure. The OOM would
>> probably be more critical since something that was supposed to be logged
>> couldn't be logged and now you cannot show this anymore and presumably not even
>> an error condition could be logged.
>>
> Precisely. As you can see in patch 5 of this series, I am logging the
> counter at ima_init (ima_init_tpm_update_counter).  So we will get the
> baseline counter at the system boot, where memory pressure is hopefully
> low.  Even if we are not able to log the counter later due to OOM, this
> baseline counter along with the number of events in the IMA log should
> help detect if IMA log is missing events.

How do you account for updates to other PCRs than PCR 10 that a user may use for whatever reason?
I think you would have to have the TPM driver count the updates for PCR 10.
Form what I can see there's one global PCR update counter for all PCRs and
all banks.

Also, if we hit an oom condition when logging then the PCR is not extended, which
is good since otherwise we would be hopelessly out-of-sync.


> 
>> https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_queue.c#L179
>>
>>> have any information if the PCR mismatch with IMA log is because of loss
>>> of entries in the IMA log or something else.  TPM 2.0 provides an update
>>> counter which is incremented each time a PCR is updated [2]. Measuring the
>>> TPM PCR update counter in IMA subsystem will help the remote attestation
>>> service to validate if there are any missing entries in the IMA log, when
>>
>>
>>
>>> the system goes through certain important state changes (e.g. kexec soft
>>> boot, IMA log snapshotting etc.)
>>>
>>> This patch series provides the required functionality to measure the
>>> update counter through IMA subsystem by -
>>>   - introducing a function to retrieve PCR update counter in the TPM
>>>     subsystem.
>>>   - IMA functionality to acquire the update counter from the TPM subsystem.
>>>   - Measuring the update counter at system boot and at kexec Kernel
>>>     load.
>>
>> Then the bugs you mentioned above that may happen between system boot and kexec
>> load are still going to confuse anyone looking at the log and quote. I don't
>> think you should mention them. I thought you would provide a way to sync
> I used the kexec load-execute bug as an example to demonstrate the value of
> measuring update counter.  There could be other examples which I am not
> aware of.  As we discussed above, even when I fix the kexec bug – there is
> still a possibility that events may go missing in error/OOM cases.

Yes, and we're not extending the PCRs then either, which would be catastrophic
if we were.

> 
> I can remove the kexec example if it is causing confusion.> Please let me know.

I am not convinced we need this series  ... :-( Your kexec series prevents
further logging and especially PCR extensions after the frozen measurement log
has been created and in ima_add_template_entry(), if we hit an oom condition,
then we luckily do not extend the PCR either. If either the log was to have one
more entry than number PCR extensions occurred or vice versa, then the remote
attestation service will see this mismatch no matter what and all the PCR update
counter won't help (and is generally not a good indicator for this purpose imo)
for it to recover from this. It's better to declare the system as un-trusted/
corrupted in this case then.

    Stefan


>> up on every step...
>>
> I don’t fully understand what you mean by “provide a way to sync up
> on every step”.  Could you please elaborate?
> 
>> Also, I thought you had a variable in your kexec series that would prevent all further
>> logging and measuring once the log had been marshalled during kexec 'exec' stage
>> and this wasn't necessary.
>>
> No, the variable suspend_ima_measurements[1] suspends the measurements
> while copying the kexec buffer during kexec execute to ensure consistency
> of the IMA measurements.  It doesn’t prevent all future logging. The
> variable is reset and the IMA measurements resume when the system boots
> into the new Kernel image.
> 
> [1] https://patchwork.kernel.org/project/linux-integrity/patch/20230703215709.1195644-10-tusharsu@linux.microsoft.com/
> 
> ~Tushar
> 
>> Stefan
>>
>>>
>>>
>>> This patch series would be a prerequisite for the next version of kexec
>>> load/execute series[1] and the future IMA log snapshotting patch series.
>>>
>>> [1] https://lore.kernel.org/all/20230703215709.1195644-1-tusharsu@linux.microsoft.com/
>>>      ima: measure events between kexec load and execute
>>>
>>> [2] https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_Part3_Commands_pub.pdf
>>>      Section 22.4.2, Page 206.
>>>
>>> Tushar Sugandhi (6):
>>>    tpm: implement TPM2 function to get update counter
>>>    tpm: provide functionality to get update counter
>>>    ima: get TPM update counter
>>>    ima: implement functionality to measure TPM update counter
>>>    ima: measure TPM update counter at ima_init
>>>    kexec: measure TPM update counter in ima log at kexec load
>>>
>>>   drivers/char/tpm/tpm-interface.c   | 28 +++++++++++++++++
>>>   drivers/char/tpm/tpm.h             |  3 ++
>>>   drivers/char/tpm/tpm2-cmd.c        | 48 ++++++++++++++++++++++++++++++
>>>   include/linux/ima.h                |  1 +
>>>   include/linux/tpm.h                |  8 +++++
>>>   kernel/kexec_file.c                |  3 ++
>>>   security/integrity/ima/ima.h       |  2 ++
>>>   security/integrity/ima/ima_init.c  |  3 ++
>>>   security/integrity/ima/ima_main.c  | 29 ++++++++++++++++++
>>>   security/integrity/ima/ima_queue.c | 16 ++++++++++
>>>   10 files changed, 141 insertions(+)
>>>
