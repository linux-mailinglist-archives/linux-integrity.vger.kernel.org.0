Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9AA46688D
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 17:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbhLBQtC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 11:49:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238116AbhLBQtB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 11:49:01 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2GI28S027469;
        Thu, 2 Dec 2021 16:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=l+K+Ookopkzvd+CJEGt7x3Jz7EsHAKf5HQ1o3s6fdR8=;
 b=ONlSa17l2oIU279+pSxBS7QryD8Cg5YtWHd6T32nVgV+/TBF/CWVeXhhsaDRJqniN131
 vSVYXajEAOOhvdAURt1K0FthIAq56dD++jXsJlmE5Tt9h1UbG7n0zRrfJSXdjwcFuOyH
 xxhOdUNHi3DIhiyEaaJILo6+NXUCzM6dpJJYEQaTLzKgWL+zsBHO6sttr5RojafvTryC
 0aH17KpOJtVp/rksugmjy2mYigGxh7eETQxCHX2pjfEbmy8pB5IODpB2HO1nTroRa9cZ
 oQdhYwvbYNSd1uM6wo7OzRDXeEMTdTf4aiT9m053F8S4CRvWpqTBoEA+wH659Yn6blMl gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq1hu8hku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 16:45:21 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2GK5wn033197;
        Thu, 2 Dec 2021 16:45:20 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq1hu8hjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 16:45:20 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2GTI83007260;
        Thu, 2 Dec 2021 16:45:18 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 3ckcacj6s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 16:45:18 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2GjF3i53018964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 16:45:16 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9A2CAE067;
        Thu,  2 Dec 2021 16:45:15 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FE6CAE060;
        Thu,  2 Dec 2021 16:45:15 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 16:45:15 +0000 (GMT)
Message-ID: <05da6ebc-0cd4-753a-8589-4b1a06d198c6@linux.ibm.com>
Date:   Thu, 2 Dec 2021 11:45:15 -0500
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <eeaadc76ca2da67d79c155497a73c6905b70e726.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WmJdWiRd0ge4Ij2YPXuu74KLBRRrYzV8
X-Proofpoint-ORIG-GUID: _3yC0eyIgMNykxFT7g8CaXCYLn-y9ftT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_10,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/2/21 11:29, James Bottomley wrote:
> On Thu, 2021-12-02 at 08:41 -0500, Stefan Berger wrote:
>> On 12/2/21 07:46, James Bottomley wrote:
>>> On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
>>>> Move measurement list related variables into the ima_namespace.
>>>> This
>>>> way a
>>>> front-end like SecurityFS can show the measurement list inside an
>>>> IMA
>>>> namespace.
>>>>
>>>> Implement ima_free_measurements() to free a list of measurements
>>>> and call it when an IMA namespace is deleted.
>>> This one worries me quite a lot.  What seems to be happening in
>>> this
>>> code:
>>>
>>>> @@ -107,7 +100,7 @@ static int ima_add_digest_entry(struct
>>>> ima_namespace *ns,
>>>>           qe->entry = entry;
>>>>    
>>>>           INIT_LIST_HEAD(&qe->later);
>>>> -       list_add_tail_rcu(&qe->later, &ima_measurements);
>>>> +       list_add_tail_rcu(&qe->later, &ns->ima_measurements);
>>>>    
>>>>           atomic_long_inc(&ns->ima_htable.len);
>>>>           if (update_htable) {
>>>>
>>> is that we now only add the measurements to the namespace list, but
>>> that list is freed when the namespace dies.  However, the
>>> measurement
>>> is still extended through the PCRs meaning we have incomplete
>>> information for a replay after the namespace dies?
>> *Not at all.* The measurement list of the namespace is independent
>> of
>> the host.
>>
>> The cover letter states:
> I get that the host can set up a policy to log everything in the
> namespace, but that wasn't my question.  My question is can the guest
> set up a policy to log something that doesn't go into the host log
> (because the host hasn't asked for it to be logged) but extends a PCR
> anyway, thus destroying the ability of the host to do log replay.


host log goes with host TPM and vice versa

guest log goes with (optional) vTPM and vice version

Extending the PCR of the host's TPM would require the data to be logged 
in the host log as well. So, no, it's not possible.


    Stefan


>
> James
>
>
