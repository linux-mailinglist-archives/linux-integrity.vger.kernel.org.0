Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACE97796EF
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 20:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbjHKSRG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 14:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbjHKSQ4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 14:16:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4435930DF;
        Fri, 11 Aug 2023 11:16:56 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BIGBob025041;
        Fri, 11 Aug 2023 18:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=k5mR17zkrffo+X2rFTZCfWzMuxIb9pkxOfVjmLz2Jx4=;
 b=Iy4k7SHoiYa7dasuiqUN9ozO2bDIFFRYnnU6OYJYSvWgMu9Uni+F15lYU6eeWwJhBZby
 czQzQPuXrP6J3oRP7U8qr5ZRmppo4rdQS5tZFNz/7TlVAl7jpB8pgYUZutHmWueoj0mO
 n/Vt32Zn4KFSanhnjj6z6dpra2yjoByTA5HB9Hub2S++4PjQljT4Q8GHZA0bfGG9UE6p
 MZEKcQkUrRl2Cc5oilHYJvwzcZG3XkgWsTmWMu8EQ5WCjcYAf2JpIm0ykja6R+ozPcjp
 UrD3kCp4on5fx0Fz98pKxfdEUn6OmCv6bCAqrASbJEIzd51tVIrdbVEWc6w+JeNsMoZJ GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdsu98kyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 18:16:31 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37BIGUMq026395;
        Fri, 11 Aug 2023 18:16:30 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdsu98ky0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 18:16:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGhvtF001802;
        Fri, 11 Aug 2023 18:16:29 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f2mhyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 18:16:29 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37BIGSOB6423276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 18:16:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B8BE58061;
        Fri, 11 Aug 2023 18:16:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C2A05805A;
        Fri, 11 Aug 2023 18:16:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 11 Aug 2023 18:16:25 +0000 (GMT)
Message-ID: <b9094b2f-d349-e029-80d6-bab92f6eaea6@linux.ibm.com>
Date:   Fri, 11 Aug 2023 14:16:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
 <b538f7d2-5a04-46d0-3792-a18653230a95@linux.microsoft.com>
 <011d8a79-236f-dc20-08fc-b5da7dd1d5a7@linux.ibm.com>
 <aba709f8-a808-9aa4-8322-430e3997f686@linux.microsoft.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <aba709f8-a808-9aa4-8322-430e3997f686@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4Mb-Xrz-dEpYPqWQnql2U-MEJZLcvnn7
X-Proofpoint-GUID: i0ZJQDqKGnUUuTBys-drocWQPo-vyd5I
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 mlxlogscore=855 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110165
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/11/23 11:57, Tushar Sugandhi wrote:
> 
> 
> 
> [1] https://patchwork.kernel.org/project/linux-integrity/cover/20230801181917.8535-1-tusharsu@linux.microsoft.com/
> 
>> The shards should will need to be written into some sort of standard location or a config file needs to
>> be defined, so that everyone knows where to find them and how they are named.
>>
> We thought about well known standard location earlier.
> Letting the Kernel choose the name/location of the snapshot
> file comes with its own complexity. Our initial stance is we don’t
> want to handle that at Kernel level, and let the UM client choose
> the location/naming of the snapshot files. But we are happy to
> reconsider if the community requests it.

I would also let user space do the snapshotting but all applications
relying on shards should know where they are located on the system
and what the naming scheme is so they can be  process in proper order.
evmctl for example would have to know where the shards are if keylime
agent had taken snapshots.



>>> Yes. If the “PCR quotes in the snapshot_aggregate event in IMA log”
>>
>> PCR quote or 'quotes'? Why multiple?
>>
>> Form your proposal but you may have changed your opinion  following what I see in other messages:
>> "- The Kernel will get the current TPM PCR values and PCR update counter [2]
>>     and store them as template data in a new IMA event "snapshot_aggregate"."
>>
>> Afaik TPM quote's don't give you the state of the individual PCR values, therefore
>> I would expect to at least find the 'PCR values' of all the PCRs that IMA touched to
>> be in the snapshot_aggregate so I can replay all the following events on top of these
>> PCR values and come up with the values that were used in the "final PCR quote". This
>> is unless you expect the server to take an automatic snapshot of the values of the
>> PCRs  that it computed while evaluating the log in case it ever needs to go back.
>>
> I meant a single set of PCR values captured when snapshot_aggregate
> is logged. Sorry for the confusion.

Ok.

> 
>>> + "replay of rest of the events in IMA log" results in the “final PCR quotes”
>>> that matches with the “AK signed PCR quotes” sent by the client, then the truncated
>>> IMA log can be trusted. The verifier can either ‘trust’ the “PCR quotes in the
>>> snapshot_aggregate event in IMA log” or it can ask for the (n-1)th snapshot shard
>>> to check the past events.
>>
>> For anything regarding determining the 'trustworthiness of a system' one would have to
>> be able to go back to the very beginning of the log *or* remember in what state a
>> system was when the latest snapshot was taken so that if a restart happens it can resume
>> with that assumption about state of trustworthiness and know what the values of the PCRs
>> were at that time so it can resume replaying the log (or the server would get these
>> values from the log).
>>
> Correct. We intend to support the above. I hope our proposal
> description captures it. BTW, when you say ‘restart’, you mean the UM
> process restart, right? Because in case of a Kernel restart

Yes, client restart not reboot.

> (i.e. cold-boot) the past IMA log (and the TPM state) is lost,
> and old snapshots (if any) are useless.

Right. Some script should run on boot and delete all contents of the directory where the log
shards are.

> 
>> The AK quotes by the kernel (which adds a 2nd AK key) that James is proposing
>> could be useful if the entire log, consisting of multiple shards, is very large and
>> cannot be transferred from the client to the server in one go so that the server could
>> evaluate the 'final PCR quote' immediately . However, if a client can indicated 'I will
>> send more the next time and I have this much more to transfer' and the server allows
>> this multiple times (until all the 1MB shards of the 20MB log are transferred) then that
>> kernel AK key would not be necessary since presumably the "final PCR quote", created
>> by a user space client, would resolve whether the entire log is trustworthy.
>>
> See my responses to James today [2]
> 
> [2] https://lore.kernel.org/all/72e39852-1ff1-c7f6-ac7e-593e8142dbe8@linux.microsoft.com/

I think James was proposing one AK, possibly persisted in the TPM's NVRAM. Still, the less keys
that are involved in this the better...

    Stefan

