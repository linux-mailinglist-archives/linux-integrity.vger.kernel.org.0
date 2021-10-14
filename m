Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F76542D871
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Oct 2021 13:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhJNLqa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Oct 2021 07:46:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231250AbhJNLqV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Oct 2021 07:46:21 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EBaVpT014239;
        Thu, 14 Oct 2021 07:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CYG9NOulpfBzL19tViJqN/tdKovcx6JB2vB5XeSA5XM=;
 b=CycwXLQ8KgxuqyUqirTr+UcORfYa/81Y4OR757TvzaBCiO1inRiIxbLFglvONc+c1W2B
 yl1OS3Wz3bZ1xN93g0SOlWBGIREfaOdbiIsX1IgQ+KPIseUJm4Nh5Ltk5XVt8Z82MEH0
 e2u2/1Kljjq6sMuUw2XqcZrpiBHaeGEY98SI78fbOMalGrcSynEZEz6EtXmIYzPfwtDA
 aqD5VBD6aTFZsSPTpP7xY7UR1lZH9X46u5/i+Nb1TFE+CIH6OvLDM4Uz++5jTWSaNPpG
 Lv+6wo5S4hpY45GQYNfLnVrdp/1sgZfm8zM4YDCw9NJkEoiTYa4uv9m2IuLj5pcajm9C Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnshj90rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 07:44:09 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19EBam9b018459;
        Thu, 14 Oct 2021 07:44:09 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnshj90r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 07:44:09 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19EBfdDc021982;
        Thu, 14 Oct 2021 11:44:08 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 3bk2qbns5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 11:44:08 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19EBi7hE38011216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 11:44:07 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42311136055;
        Thu, 14 Oct 2021 11:44:07 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B09BF136067;
        Thu, 14 Oct 2021 11:44:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 14 Oct 2021 11:44:06 +0000 (GMT)
Subject: Re: IMA namespaces
To:     Denis Semakin <0xsemakin@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        denis.semakin@huawei.com
References: <CABtpKGVtgwZbvX9j0QNB3FyZkT_LgwHWdpKYijULeBZ1Z+Xw0w@mail.gmail.com>
 <de9e081e-154e-03c9-c23d-b3e624910975@linux.ibm.com>
 <CABtpKGWqH4K2pSZczgqAF1BMYTE+g1Nn+d2sePsjpJEU+RxiuQ@mail.gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <fa1c1f1f-3bc7-d61f-3665-65afeb300644@linux.ibm.com>
Date:   Thu, 14 Oct 2021 07:44:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABtpKGWqH4K2pSZczgqAF1BMYTE+g1Nn+d2sePsjpJEU+RxiuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tuWt5PoE2wkY6v3NthOXgRu4LrhZp9Pr
X-Proofpoint-GUID: hDObAUIQ0MaSowUkB4g6aPOF6DQv4AfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_03,2021-10-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 adultscore=0 clxscore=1011 phishscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110140073
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/14/21 6:12 AM, Denis Semakin wrote:
> The new statements look very similar to previous. A couple of the
> items are already under development.
> What about new capabilities CAP_INTEGRITY_ADMIN and
> CAP_SECURITY_XATTR_ADMIN which are mentioned in the first original
> edition of "Considerations..."

They still exist but are part of the implementation rather than the high 
level requirement R4.

> Br,
> Denis
>
> On Wed, Oct 13, 2021 at 10:14 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>> On 9/1/21 8:00 AM, Denis Semakin wrote:
>>> Hello.
>>> A few months ago we started a project dedicated to single IMA namespaces.
>>> Last years there were a number of patch-sets about this problem, e.g.
>>> the last one was from  Krzysztof Struczynski. But no one patch-set
>>> wasn’t applied to the mainline.
>>>
>>> Also there is a document (thanks Mimi) that describes the main goal,
>>> architecture and design - “IMA Namespacing design considerations”.
>>>
>>> As a result of investigations: Krzysztof’s patches were successfully
>>> adopted for Linux kernel v5.10.30 and tested,
>>> at least that allowed to study integrity and IMA a source code a
>>> little bit. But that patch-set does not match “...design
>>> considerations…”. Then we may take all patches as a base, use
>>> “Considerations…” as architecture description and start to implement
>>> but it is obvious that it does not make sense without community
>>> (review, discussion, etc).
>> We are working on another design document, which is based on the initial
>> one, that lists the following design requirements for IMA namespacing:
>>
>> R1 Each container must have the possibility to spawn an independent IMA
>> namespace
>>     (IMA-ns). Each IMA-ns must have the following properties:
>>     R1.1 An IMA-ns must have an independent IMA-policy with
>>         (i)  an initial default policy, and
>>         (ii) rules that provide the possibility to cause measurements and
>> appraisal
>>             in IMA-ns child namespaces.
>>     R1.2 An IMA-ns must have independent IMA-measurement with
>>         (i)  its own measurement list and
>>         (ii) the possibility to measure and log files accessed in an
>> IMA-ns child
>>              namespace per the IMA-policy.
>>     R1.3 An IMA-ns must have independent IMA-appraisal with
>>         (i)  its own set of keyrings and
>>         (ii) the possibility to appraise files accessed in an IMA-ns
>> child namespace
>>              per the IMA-policy.
>>     R1.4 An IMA-ns must have independent IMA-audit with
>>         (i)  its own emission of audit messages distinguishable from
>> those audit
>>              messages of other IMA-ns's and
>>         (ii) the possibility to audit files accessed in an IMA-ns child
>> namespaces.
>> R2 As an additional requirement host root's actions in an IMA-ns must be
>> measured
>>      and audited (in all IMA namespaces) in the IMA root namespace,
>> independent of
>>      whether the IMA policy enables logging or auditing in child
>> namespaces, if there
>>      is an IMA measurements or auditing policy in the IMA root namespace.
>>      The same may apply to a container root user whose actions in a
>> child-IMA-ns need
>>      to be measured and audited if there is an IMA measurement or
>> audition policy in
>>      the IMA-ns.
>> R3 An independent instance of SecurityFS must be accessible to each
>> IMA-ns showing
>>      the IMA-policy, the IMA measurement list, and other information
>> related to the
>>      'owning' IMA-ns.
>> R4 A container's root user must be able to
>>      (i)  load the IMA policy inside a container using SecurityFS of its
>> IMA-ns and
>>      (ii) sign files inside a container.
>> R5 An independent vTPM instance should be connectable to each IMA-ns
>> where the
>>      IMA-ns extends its measurements into the vTPM's PCRs.
>>
>>
>> Maybe we can discuss those until we can share the document with a wider
>> audience.
>>
>>      Stefan
>>
>>
