Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F51476EAEE
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Aug 2023 15:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbjHCNoJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbjHCNne (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 09:43:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50286592
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 06:40:50 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373DWICW002598;
        Thu, 3 Aug 2023 13:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/E6qeqMuEIytKD9g4uGkz8byYUSFbvkZO3NLxVjZLWQ=;
 b=eLVrFWIZOScPnfSE8xyot24UyNPRhUIUY6qhSKcZomAleY8B8jC6BAl16vrFTun2zzG8
 NchjejKDY9fedLLPNdt/6Upr9dDRQjDLcUWMLjVl5wdYrJNgNg1Mi5qVcianpRJfF5V2
 bt8X+QZsD7UtZXwtSJAd1Vq4ES4KYVPXpdQMFczJsuiEfiEQvEquD4gzBkF+225pU08q
 xNLcLC6HP3a43qNyhH/Mg9A5wg+kkGU3PO0sb7SWv8fPiHL8MLcDxRinQVLXNj072rlp
 lXog76opigp0YJsDh6ESKOrie6KJDRhpk2sJ4Uz4qY8iEKZjqTcbb9iSFs5O2O7wFV8K mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8d708bnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 13:38:42 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373DX31g006231;
        Thu, 3 Aug 2023 13:38:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8d708asw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 13:38:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373Bp8be019095;
        Thu, 3 Aug 2023 13:37:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5ekkwnpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 13:37:40 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373DbdME8979198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 13:37:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A59DD5805C;
        Thu,  3 Aug 2023 13:37:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E02D65805A;
        Thu,  3 Aug 2023 13:37:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Aug 2023 13:37:38 +0000 (GMT)
Message-ID: <dbfb545b-9399-d505-6739-c2940930ef48@linux.ibm.com>
Date:   Thu, 3 Aug 2023 09:37:38 -0400
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RHXLIxKzxi9e7_jCsdu5wNKmgLyyBdiw
X-Proofpoint-ORIG-GUID: iUqfTBK7U3CNGMgAS2YwqdIeGYKAmCrO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_12,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1011 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308030122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/1/23 14:19, Tushar Sugandhi wrote:
> Entries in IMA log may be lost due to code bugs, certain error conditions

I hope we don't have such bugs. And I guess the most critical ones would be
between logging and PCR extensions

> being met etc.  This can result in TPM PCRs getting out of sync with the
> IMA log.  One such example is events between kexec 'load' and kexec
> 'execute' getting lost from the IMA log when the system soft-boots into
> the new Kernel using kexec[1].  The remote attestation service does not

Though this particular condition I thought would go away with your kexec series.

The other conditions would be an out-of-memory or TPM failure. The OOM would
probably be more critical since something that was supposed to be logged
couldn't be logged and now you cannot show this anymore and presumably not even
an error condition could be logged.

https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_queue.c#L179

> have any information if the PCR mismatch with IMA log is because of loss
> of entries in the IMA log or something else.  TPM 2.0 provides an update
> counter which is incremented each time a PCR is updated [2]. Measuring the
> TPM PCR update counter in IMA subsystem will help the remote attestation
> service to validate if there are any missing entries in the IMA log, when



> the system goes through certain important state changes (e.g. kexec soft
> boot, IMA log snapshotting etc.)
> 
> This patch series provides the required functionality to measure the
> update counter through IMA subsystem by -
>   - introducing a function to retrieve PCR update counter in the TPM
>     subsystem.
>   - IMA functionality to acquire the update counter from the TPM subsystem.
>   - Measuring the update counter at system boot and at kexec Kernel
>     load.

Then the bugs you mentioned above that may happen between system boot and kexec
load are still going to confuse anyone looking at the log and quote. I don't
think you should mention them. I thought you would provide a way to sync
up on every step...

Also, I thought you had a variable in your kexec series that would prevent all further
logging and measuring once the log had been marshalled during kexec 'exec' stage
and this wasn't necessary.

    Stefan

> 
> 
> This patch series would be a prerequisite for the next version of kexec
> load/execute series[1] and the future IMA log snapshotting patch series.
> 
> [1] https://lore.kernel.org/all/20230703215709.1195644-1-tusharsu@linux.microsoft.com/
>      ima: measure events between kexec load and execute
> 
> [2] https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_Part3_Commands_pub.pdf
>      Section 22.4.2, Page 206.
> 
> Tushar Sugandhi (6):
>    tpm: implement TPM2 function to get update counter
>    tpm: provide functionality to get update counter
>    ima: get TPM update counter
>    ima: implement functionality to measure TPM update counter
>    ima: measure TPM update counter at ima_init
>    kexec: measure TPM update counter in ima log at kexec load
> 
>   drivers/char/tpm/tpm-interface.c   | 28 +++++++++++++++++
>   drivers/char/tpm/tpm.h             |  3 ++
>   drivers/char/tpm/tpm2-cmd.c        | 48 ++++++++++++++++++++++++++++++
>   include/linux/ima.h                |  1 +
>   include/linux/tpm.h                |  8 +++++
>   kernel/kexec_file.c                |  3 ++
>   security/integrity/ima/ima.h       |  2 ++
>   security/integrity/ima/ima_init.c  |  3 ++
>   security/integrity/ima/ima_main.c  | 29 ++++++++++++++++++
>   security/integrity/ima/ima_queue.c | 16 ++++++++++
>   10 files changed, 141 insertions(+)
> 
