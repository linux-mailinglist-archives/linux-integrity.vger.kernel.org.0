Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1846649C
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 14:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358289AbhLBNo4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 08:44:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358297AbhLBNov (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 08:44:51 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2DPJNn018379;
        Thu, 2 Dec 2021 13:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=k0HT79Me9ovhdCsM3LaDTtpEBqBTasmenzwgpX70iZA=;
 b=fOd4mSoHfMg7IMNDZr7bQhREIQr6LXOA00fZjnoi1H9UOumV/QWpgoNZlmIfy9VFUMag
 bkB9fE7lChEE3qrvVQchZB7ZOIa5Tn6mXUDxwNueStzBM5oipIODDJGSDPjRf2haekfF
 aBFEXFUNLop/tqeFxUC3v/yw4UTaXWXvt2yFpikMt0CBHsQqpoC1dIM6+FNskbcfThmu
 7RbRHelWuqG1e5lLQna3dM4UDLrIMKnYYz/o8qskghzqUA8zzTIdVcRXlWhQYE5T8BeO
 J+uOWr0Dq9h5/xMzMPA85r7AC/+eBguvgLkn0EIGZNmCerbGQk3Yx5wZbOQ24CaftSvF Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpw57aveq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 13:41:16 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2DcRbB007506;
        Thu, 2 Dec 2021 13:41:16 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpw57ave4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 13:41:16 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2DbBSj026895;
        Thu, 2 Dec 2021 13:41:14 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 3ckcacny97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 13:41:14 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2DfBlQ46596582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 13:41:11 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A680AC06B;
        Thu,  2 Dec 2021 13:41:11 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D5BEAC05B;
        Thu,  2 Dec 2021 13:41:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 13:41:11 +0000 (GMT)
Message-ID: <c3b99439-1dd6-e204-ad41-5d8bacb54d48@linux.ibm.com>
Date:   Thu, 2 Dec 2021 08:41:10 -0500
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <141ce433f026b47edb1d9a8f89e4581db253c579.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5vpw0dqQCrAgrxt1c0eWLevltCqb-px5
X-Proofpoint-GUID: QygAvCJ4ldlvt3lmAk-Lz_6BEEQ9TFoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-12-02_07,2021-12-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/2/21 07:46, James Bottomley wrote:
> On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
>> Move measurement list related variables into the ima_namespace. This
>> way a
>> front-end like SecurityFS can show the measurement list inside an IMA
>> namespace.
>>
>> Implement ima_free_measurements() to free a list of measurements
>> and call it when an IMA namespace is deleted.
> This one worries me quite a lot.  What seems to be happening in this
> code:
>
>> @@ -107,7 +100,7 @@ static int ima_add_digest_entry(struct
>> ima_namespace *ns,
>>          qe->entry = entry;
>>   
>>          INIT_LIST_HEAD(&qe->later);
>> -       list_add_tail_rcu(&qe->later, &ima_measurements);
>> +       list_add_tail_rcu(&qe->later, &ns->ima_measurements);
>>   
>>          atomic_long_inc(&ns->ima_htable.len);
>>          if (update_htable) {
>>
> is that we now only add the measurements to the namespace list, but
> that list is freed when the namespace dies.  However, the measurement
> is still extended through the PCRs meaning we have incomplete
> information for a replay after the namespace dies?

*Not at all.* The measurement list of the namespace is independent of 
the host.

The cover letter states:

"The following lines added to a suitable IMA policy on the host would
cause the execution of the commands inside the container (by uid 1000)
to be measured and audited as well on the host, thus leading to two
auditing messages for the 'busybox cat' above and log entries in IMA's
system log.

echo -e "measure func=BPRM_CHECK mask=MAY_EXEC uid=1000\n" \
         "audit func=BPRM_CHECK mask=MAY_EXEC uid=1000\n" \
     > /sys/kernel/security/ima/policy   "

So even now, with only auditing support in the namespace, you would get 
measurements in the host log with an appropriately written IMA policy. 
The measurements in the host log won't go away when the namespace dies.

The intention is to provide flexibility that allows for writing the IMA 
policy of the host in such a way

- that file accesses occurring in namespaces get measured on the host

- that file accesses occurring in the namespace do NOT get measured on 
the host and protect the host log from ever growing or actions in 
namespaces intentionally growing the host log

There would be a namespace policy that would allow for logging inside 
the namespace. Combine this with the policy on the host and you can have 
no measurements of the namespace file access, measurements in either the 
host log or the namespace log or both. What I would be worried about is 
if the flexibility wasn't there.


>
> I tend to think the way this should work is that until we have a way of
> attesting inside the namespace, all measurements should go into the
> physical log, so that replay is always complete for the PCRs, so
> effectively the visible log of the namespace would always have to be a
> subset of the physical log.

Per the cover letter description this is already possible today.

    Stefan


>
> James
>
>
