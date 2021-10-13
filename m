Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38442C9B5
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Oct 2021 21:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhJMTQI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 15:16:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229941AbhJMTQI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 15:16:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DJ6r8v021042
        for <linux-integrity@vger.kernel.org>; Wed, 13 Oct 2021 15:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=U39s3Ps9TyKOwQnz8SU6eagiHS/tKPHvlceRbNMZFcM=;
 b=f3Dz1RDCxSH85b1Ex3lLccx4Gn4acFDpSuqC/wf4NNdMvD08jNsCwmtHa8xxFtZif95M
 T9Jh1WO1P4cugQAHllHOyCvpOcf/ysmmTgNO2X3ohL8qZp+6z9IzQ9jJL+bq6tdznwxt
 5DF4dxjamdpuEu/z8sgBziS9sZx0pZxsripAbIFQ9y88mUv0UrOeDgWLzV0RbqkmVz0V
 t83oeBqc5Wdp912QeDLzTxg6cnEZ3hFVBpNVkEXNp2/CgSq+1aoBecKciqw7lJsFbn8K
 c/Fv3vufYl3a+SUlu9zkfvJRy3g18m8bGHFVwEMJT4gpQRimS1d9NpHdh0RdbqDi+W5Q kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bntpx8ekf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 13 Oct 2021 15:14:04 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19DJ3eUN030373
        for <linux-integrity@vger.kernel.org>; Wed, 13 Oct 2021 15:14:03 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bntpx8ek5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 15:14:03 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DIvRHm032651;
        Wed, 13 Oct 2021 19:14:03 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3bk2qcke80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 19:14:03 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DJE1vN32244206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 19:14:02 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3C0F28067;
        Wed, 13 Oct 2021 19:14:01 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6AF42805A;
        Wed, 13 Oct 2021 19:14:01 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 19:14:01 +0000 (GMT)
Subject: Re: IMA namespaces
To:     Denis Semakin <0xsemakin@gmail.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org
References: <CABtpKGVtgwZbvX9j0QNB3FyZkT_LgwHWdpKYijULeBZ1Z+Xw0w@mail.gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <de9e081e-154e-03c9-c23d-b3e624910975@linux.ibm.com>
Date:   Wed, 13 Oct 2021 15:14:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABtpKGVtgwZbvX9j0QNB3FyZkT_LgwHWdpKYijULeBZ1Z+Xw0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3n3HbJjfMxinRDsypI17zGWEZ-BB08lD
X-Proofpoint-ORIG-GUID: ACQ6gT5OSra24Et_kOYlp5orOam6ClA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_07,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 9/1/21 8:00 AM, Denis Semakin wrote:
> Hello.
> A few months ago we started a project dedicated to single IMA namespaces.
> Last years there were a number of patch-sets about this problem, e.g.
> the last one was from  Krzysztof Struczynski. But no one patch-set
> wasn’t applied to the mainline.
>
> Also there is a document (thanks Mimi) that describes the main goal,
> architecture and design - “IMA Namespacing design considerations”.
>
> As a result of investigations: Krzysztof’s patches were successfully
> adopted for Linux kernel v5.10.30 and tested,
> at least that allowed to study integrity and IMA a source code a
> little bit. But that patch-set does not match “...design
> considerations…”. Then we may take all patches as a base, use
> “Considerations…” as architecture description and start to implement
> but it is obvious that it does not make sense without community
> (review, discussion, etc).

We are working on another design document, which is based on the initial 
one, that lists the following design requirements for IMA namespacing:

R1 Each container must have the possibility to spawn an independent IMA 
namespace
   (IMA-ns). Each IMA-ns must have the following properties:
   R1.1 An IMA-ns must have an independent IMA-policy with
       (i)  an initial default policy, and
       (ii) rules that provide the possibility to cause measurements and 
appraisal
           in IMA-ns child namespaces.
   R1.2 An IMA-ns must have independent IMA-measurement with
       (i)  its own measurement list and
       (ii) the possibility to measure and log files accessed in an 
IMA-ns child
            namespace per the IMA-policy.
   R1.3 An IMA-ns must have independent IMA-appraisal with
       (i)  its own set of keyrings and
       (ii) the possibility to appraise files accessed in an IMA-ns 
child namespace
            per the IMA-policy.
   R1.4 An IMA-ns must have independent IMA-audit with
       (i)  its own emission of audit messages distinguishable from 
those audit
            messages of other IMA-ns's and
       (ii) the possibility to audit files accessed in an IMA-ns child 
namespaces.
R2 As an additional requirement host root's actions in an IMA-ns must be 
measured
    and audited (in all IMA namespaces) in the IMA root namespace, 
independent of
    whether the IMA policy enables logging or auditing in child 
namespaces, if there
    is an IMA measurements or auditing policy in the IMA root namespace.
    The same may apply to a container root user whose actions in a 
child-IMA-ns need
    to be measured and audited if there is an IMA measurement or 
audition policy in
    the IMA-ns.
R3 An independent instance of SecurityFS must be accessible to each 
IMA-ns showing
    the IMA-policy, the IMA measurement list, and other information 
related to the
    'owning' IMA-ns.
R4 A container's root user must be able to
    (i)  load the IMA policy inside a container using SecurityFS of its 
IMA-ns and
    (ii) sign files inside a container.
R5 An independent vTPM instance should be connectable to each IMA-ns 
where the
    IMA-ns extends its measurements into the vTPM's PCRs.


Maybe we can discuss those until we can share the document with a wider 
audience.

    Stefan


