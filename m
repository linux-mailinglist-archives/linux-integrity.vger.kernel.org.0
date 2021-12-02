Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F3466990
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 19:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376534AbhLBSGm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 13:06:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20952 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376514AbhLBSGm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 13:06:42 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2Hkl16020159;
        Thu, 2 Dec 2021 18:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DaLPx8pR8sGNFKcN02HrXQEQps5bWrnc3GjYQYic7CQ=;
 b=eyonDM9yjYJGnA3MTr/Mv4B30XMedRdztTMR5pxCz+A47KBqQdoMj7FnpN+NgO0Yk97S
 IsLsLesVsKLXt6zXf3KzMjxaOS1jv2P0msG50wSsRuCduLc/u/I3oIyquu6qjhH2ghsS
 Mgl7gGfO4FD6i80QN/GoWWqcTwaYJ4ytuQ19NNsfayvoIYYPRHWkxo0cJCs6ko2daykk
 O6wxCM4NBGrAH4gxaaRSRJ9Lty3UnQycW5ypnP17uV93XZLPa3jSFwwlGPR1JEZCYGnS
 s0nGGarl0rpyCiH5+VC05aJL4HC9Ue41Z+S0xXdRXf2xbe3Ipu0dGqXfMKJMtmReTxwj sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq2uggcm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 18:03:09 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2Ho6L6033564;
        Thu, 2 Dec 2021 18:03:08 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq2uggckg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 18:03:08 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2HvPuZ020713;
        Thu, 2 Dec 2021 18:03:07 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne3b6jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 18:03:07 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2I34nc55247112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 18:03:04 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E57428058;
        Thu,  2 Dec 2021 18:03:04 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7C7628068;
        Thu,  2 Dec 2021 18:03:03 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 18:03:03 +0000 (GMT)
Message-ID: <5a8c8801-d8ce-ab9b-3d38-25fbb4a4f6bb@linux.ibm.com>
Date:   Thu, 2 Dec 2021 13:03:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 08/20] ima: Move measurement list related variables into
 ima_namespace
Content-Language: en-US
To:     jejb@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-9-stefanb@linux.ibm.com>
 <141ce433f026b47edb1d9a8f89e4581db253c579.camel@linux.ibm.com>
 <c3b99439-1dd6-e204-ad41-5d8bacb54d48@linux.ibm.com>
 <eeaadc76ca2da67d79c155497a73c6905b70e726.camel@linux.ibm.com>
 <05da6ebc-0cd4-753a-8589-4b1a06d198c6@linux.ibm.com>
 <39e43a4829b86b5a87bc082628cc6f45d4d8c899.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <39e43a4829b86b5a87bc082628cc6f45d4d8c899.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ap8D9dvnx-l1hQ3OJjWes0GkDtbgPlnH
X-Proofpoint-GUID: tz5krsM6En7cr4IMOIWMM5_qbe-xLfpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_12,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112020115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/2/21 12:44, James Bottomley wrote:
> On Thu, 2021-12-02 at 11:45 -0500, Stefan Berger wrote:
>> On 12/2/21 11:29, James Bottomley wrote:
>>> On Thu, 2021-12-02 at 08:41 -0500, Stefan Berger wrote:
>>>> On 12/2/21 07:46, James Bottomley wrote:
>>>>> On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
>>>>>> Move measurement list related variables into the
>>>>>> ima_namespace.
>>>>>> This
>>>>>> way a
>>>>>> front-end like SecurityFS can show the measurement list
>>>>>> inside an
>>>>>> IMA
>>>>>> namespace.
>>>>>>
>>>>>> Implement ima_free_measurements() to free a list of
>>>>>> measurements
>>>>>> and call it when an IMA namespace is deleted.
>>>>> This one worries me quite a lot.  What seems to be happening in
>>>>> this
>>>>> code:
>>>>>
>>>>>> @@ -107,7 +100,7 @@ static int ima_add_digest_entry(struct
>>>>>> ima_namespace *ns,
>>>>>>            qe->entry = entry;
>>>>>>     
>>>>>>            INIT_LIST_HEAD(&qe->later);
>>>>>> -       list_add_tail_rcu(&qe->later, &ima_measurements);
>>>>>> +       list_add_tail_rcu(&qe->later, &ns->ima_measurements);
>>>>>>     
>>>>>>            atomic_long_inc(&ns->ima_htable.len);
>>>>>>            if (update_htable) {
>>>>>>
>>>>> is that we now only add the measurements to the namespace list,
>>>>> but
>>>>> that list is freed when the namespace dies.  However, the
>>>>> measurement
>>>>> is still extended through the PCRs meaning we have incomplete
>>>>> information for a replay after the namespace dies?
>>>> *Not at all.* The measurement list of the namespace is
>>>> independent
>>>> of
>>>> the host.
>>>>
>>>> The cover letter states:
>>> I get that the host can set up a policy to log everything in the
>>> namespace, but that wasn't my question.  My question is can the
>>> guest
>>> set up a policy to log something that doesn't go into the host log
>>> (because the host hasn't asked for it to be logged) but extends a
>>> PCR
>>> anyway, thus destroying the ability of the host to do log replay.
>> host log goes with host TPM and vice versa
>>
>> guest log goes with (optional) vTPM and vice version
> But that's what doesn't seem to happen ... ima_pcr_extend isn't
> virtualized and it's always called from ima_add_template_entry()
> meaning the physical TPM is always extended even for a namespace only
> entry.

You cannot set a measurement rule in the namespace. That is prevented 
per 9/20: ima: Only accept AUDIT rules for IMA non-init_ima_ns 
namespaces for now.

Also, with the tests that I have done with IMA namespaces I have not 
seen any 'evmctl ima_measurement ...' failures.

Have you been able to cause the IMA namespace to do measurements? It 
would be an easy thing to move the tpm_chip into the ima_namespace as 
well, but per 9/20 this shouldn't be necessary at this point.

>   
>
>> Extending the PCR of the host's TPM would require the data to be
>> logged in the host log as well. So, no, it's not possible.
> Well, exactly: if you don't have or want a vTPM per container the only
> way to attest is via the physical TPM which means all entries in the
> namespace must be in the host log, so the host owner can quote and
> reply and they can split the attested log and give assurance to the
> namespaces that their entries are correct.

Yes, this series allows you to log into the system log and along with 
this extend the TPM PCR.


>
> James
>
>
