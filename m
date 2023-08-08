Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893A9774B1A
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Aug 2023 22:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjHHUku (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Aug 2023 16:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjHHUki (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Aug 2023 16:40:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CB81CEBC;
        Tue,  8 Aug 2023 13:10:21 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378K8dC7001628;
        Tue, 8 Aug 2023 20:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UTbFCsGJMcwIn5bFHcp4kGcFhSNH5fmtibVxRAf1030=;
 b=bM3t79mEgpBFmad+AHd22ZInfKHy47dph2WBo8f68D5JcCBLCVHPsiQANL+mpFzM41yL
 /yb0b/IoK0AZ6oVwuiztlyVzMHCBymhrH0il0V/CQOG4eungnMFmRefTkb3LRCdwQhB7
 5Ol/NoMLtNwRES7q0j4R1HUo0yGAM9HIenbd24fJoT/Tr2PLOU4W/x10on5QslbmpLVE
 WgyMqbYzdNBssPe7315ru/4i7L++loqRucV3sHgRk+dTV5ct4vuE5DzaUPGG23YjV6DX
 xvisWzGTe7dR7btuM2HzK3ao2gQkftpyDUBJ0XJ7bfc+t0MMo6Qx3TSkW1blyUkQhYWW dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbv8srg5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 20:09:56 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 378K8r4t002293;
        Tue, 8 Aug 2023 20:09:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbv8srfvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 20:09:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 378IEI1i001888;
        Tue, 8 Aug 2023 20:09:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f1s846-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 20:09:48 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 378K9lcZ27001576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Aug 2023 20:09:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46FA958066;
        Tue,  8 Aug 2023 20:09:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB2A25805D;
        Tue,  8 Aug 2023 20:09:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  8 Aug 2023 20:09:45 +0000 (GMT)
Message-ID: <04fb2fe5-9ebe-b35f-bdde-6ef22786438f@linux.ibm.com>
Date:   Tue, 8 Aug 2023 16:09:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
 <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
 <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
 <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T9udji-d3sRLml-8nc4OKKaRcnP0bfXH
X-Proofpoint-ORIG-GUID: UizCQRrMEbz1qE8ogLzySaNARXm9SgsR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_18,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=829 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080178
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/8/23 14:26, James Bottomley wrote:
> On Tue, 2023-08-08 at 09:31 -0400, Stefan Berger wrote:
>>
>>
>> On 8/8/23 08:35, James Bottomley wrote:
>>> On Mon, 2023-08-07 at 18:49 -0400, Stefan Berger wrote:
>>>>
>>>>
>>>> On 8/1/23 17:21, James Bottomley wrote:
>>>>> On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
>>>>> [...]
>>>>>> Truncating IMA log to reclaim memory is not feasible, since
>>>>>> it makes the log go out of sync with the TPM PCR quote making
>>>>>> remote attestation fail.
>>>>>
>>>>> This assumption isn't entirely true.  It's perfectly possible
>>>>> to shard an IMA log using two TPM2_Quote's for the beginning
>>>>> and end PCR values to validate the shard.  The IMA log could be
>>>>> truncated in the same way (replace the removed part of the log
>>>>> with a TPM2_Quote and AK, so the log still validates from the
>>>>> beginning quote to the end).
>>>>>
>>>>> If you use a TPM2_Quote mechanism to save the log, all you need
>>>>> to do is have the kernel generate the quote with an internal
>>>>> AK.  You can keep a record of the quote and the AK at the
>>>>> beginning of the truncated kernel log.  If the truncated
>>>>> entries are saved in a file shard it
>>>>
>>>> The truncation seems dangerous to me. Maybe not all the scenarios
>>>> with an attestation client (client = reading logs and quoting)
>>>> are possible then anymore, such as starting an attestation client
>>>> only after truncation but a verifier must have witnessed the
>>>> system's PCRs and log state before the truncation occurred.
>>>
>>> That's not exactly correct.  Nothing needs to have "witnessed" the
>>> starting PCR value because the quote vouches for it (and can vouch
>>> for it after the fact).  The only thing you need to verify the
>>> quote is the attestation key and the only thing you need to do to
>>> trust the attestation key is ensure it was TPM created.  All of
>>> that can be verified after the fact as well.  The only thing that
>>> can be done to disrupt this is to destroy the TPM (or re-own it).>
>>> Remember the assumption is you *also* have the removed log shard to
>>> present.  From that the PCR state of the starting quote can be
>>
>> Yes, the whole sequence of old logs needs to be available.
> 
> Yes and no.  If the person relying on the logs is happy they've
> extracted all the evidentiary value from the log itself then they can
> reduce the preceding log shard to simply the PCR values that match the
> quote and discard the rest.
> 
>>   IF that's the case and the logs can be stitched together seamlessly,
>> who then looks at the kernel AK quote and under what circumstances?
> 
> For incremental attestation.  Each log shard can be verified using the
> base PCR values corresponding to the bottom quote then replayed and the


Somehow you have to tell a verifier to take a snapshot of the current state
of the PCRs when it replays the logs to be able to truncate the log. Whether
the state of the PCRs is in the log itself or it's just some sort of entry in
the log indicating a truncation probably doesn't matter for as long as the
verifying side keeps state of the PCRs at point of truncatiokn.

Also, the verifying side needs to take notice of the trustworthiness of the
system at the time the log was truncated in case the attestation client is
restarted and starts out sending the log with the first entry. The PCR state
shown at the beginning of the truncated log (when restarting the attestation
client) must then match when the 'notice' was taken and that determines its
trustworthiness at this point in the log.

That there's a kernel AK signature at this point doesn't seem necessary since one
presumably can verify the log and PCR states at the end with the 'regular' quote.
Nobody should ever trust a system by starting to look at the beginning of a
truncated log. You have to have evaluated all the entries in the log before and
determined whether the system was trustworthy. I don't think the kernel AK
quote buys much - at least not from what I can see.


> top quote verified.  This means that logs that aren't needed anymore
> can be discarded, which, I recall, was the base reason for this
> proposal: reducing IMA memory consumption.  Although all you need to do
> is extract the shards from kernel memory to file space and free the
> kernel memory.  Since that scheme can keep all logs intact, there's no
> reason to further reduce them unless the filesystem is running out of
> space.
> 
> James
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
