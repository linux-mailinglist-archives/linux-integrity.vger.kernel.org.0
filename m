Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1DB49FB9D
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jan 2022 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349109AbiA1OZa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jan 2022 09:25:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245047AbiA1OZ3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jan 2022 09:25:29 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SDa6jq000403;
        Fri, 28 Jan 2022 14:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UTlrCQsN9wvW4smbvkC4PWfNrFCit0FQ5oUvlfRUla0=;
 b=F+FWOl7ym1BE0rVtbMJs9VJUZnIZsd3NDLTFLIz4SEkWKbM4JHP2cARlCvEy9iDa3+aO
 b0C0vBMN15tcW1W3fTS3OS+bz2P1618P+6aG8t0lyHzrgw8XdAfohhDcMUQRcL+N63ju
 F3Qbhqq9+oPoju7puVTnlhbW9+EjHE0pnkTfxJDtrA8TlZZ8ByXX/V7A2mDPJ3j1QFD2
 6CIjwNpmLs0YOVNQnsJBBgS6GbXJM1k5BFd8AE+s/RW6NSRc+qka+xin0zmq1Z4MOLNX
 Ya+fIXvaszJkx8Udko5PDQY06NXP/B49EUwDsgIfQbAQ/XJjHJOYL2LGNkHodwgmq18l BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dvg79jqhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 14:25:09 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20SDcwNT008686;
        Fri, 28 Jan 2022 14:25:08 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dvg79jqgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 14:25:08 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20SDxFT2027105;
        Fri, 28 Jan 2022 14:06:54 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3dt1xc1wpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 14:06:54 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20SE6qWC40829318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 14:06:52 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9033B11206F;
        Fri, 28 Jan 2022 14:06:52 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3676E112070;
        Fri, 28 Jan 2022 14:06:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jan 2022 14:06:52 +0000 (GMT)
Message-ID: <aff500e2-b52d-c153-8d23-f9b84e6bb182@linux.ibm.com>
Date:   Fri, 28 Jan 2022 09:06:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 08/23] ima: Move measurement list related variables
 into ima_namespace
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-9-stefanb@linux.vnet.ibm.com>
 <20220126092159.4rgclr5s3jli7aqy@wittgenstein>
 <9ca21852-17ee-fc99-4764-300cd5199810@linux.ibm.com>
 <fc0fda8455140dce4f5af25fa8deef66ba931a95.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <fc0fda8455140dce4f5af25fa8deef66ba931a95.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oIW9bFUFWFaNwjmefRAMiOe6HdhKuKxF
X-Proofpoint-ORIG-GUID: LLxiEZz_RB3P6Es0z-JWYOWamC0gQxR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_04,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/27/22 16:48, Mimi Zohar wrote:
> On Wed, 2022-01-26 at 17:23 -0500, Stefan Berger wrote:
>> On 1/26/22 04:21, Christian Brauner wrote:
>>> On Tue, Jan 25, 2022 at 05:46:30PM -0500, Stefan Berger wrote:
>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>> Move measurement list related variables into the ima_namespace. This way
>>>> a front-end like securityfs can show the measurement list inside an IMA
>>>> namespace.
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> ---
>>>>    security/integrity/ima/ima.h             |  5 +++--
>>>>    security/integrity/ima/ima_fs.c          |  6 ++++--
>>>>    security/integrity/ima/ima_init_ima_ns.c |  5 +++++
>>>>    security/integrity/ima/ima_kexec.c       | 12 ++++++-----
>>>>    security/integrity/ima/ima_queue.c       | 27 +++++++++++-------------
>>>>    5 files changed, 31 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>>>> index 340a59174670..45706836a77b 100644
>>>> --- a/security/integrity/ima/ima.h
>>>> +++ b/security/integrity/ima/ima.h
>>>> @@ -106,7 +106,6 @@ struct ima_queue_entry {
>>>>    	struct list_head later;		/* place in ima_measurements list */
>>>>    	struct ima_template_entry *entry;
>>>>    };
>>>> -extern struct list_head ima_measurements;	/* list of all measurements */
>>>>    
>>>>    /* Some details preceding the binary serialized measurement list */
>>>>    struct ima_kexec_hdr {
>>>> @@ -136,6 +135,8 @@ struct ima_namespace {
>>>>    	struct ima_rule_entry *arch_policy_entry;
>>>>    
>>>>    	struct ima_h_table ima_htable;
>>>> +	struct list_head ima_measurements;	/* list of all measurements */
>>>> +	unsigned long binary_runtime_size;	/* used by init_ima_ns */
>>>>    } __randomize_layout;
>>> Moving this into struct imans seems sane to me but I'm not going to ack
>>> it because I don't have enough knowledge to guarantee that this code
>>> will only run for init_ima_ns. I'll leave that to Mimi.
> Moving the ima_measurements to the ima_namespace is needed for
> namespacing the IMA measurement list (next stage).  I think moving it
> now is fine.
And besides that we can now already how an empty measurement list 
without having to special case the code.
>
>> The code modifying binary_runtime_size may do this for all IMA
>> namespaces but the esulting value of binary_runtime_size may only
>> matter in init_ima_ns (not 100% sure, but Mimi seems to say so). Moving
>> it into ima_namespace rather than special-casing the code keeps the code
>> readable.
> Right, there are other changes like moving the binary_runtime_size to
> the namespace, which aren't needed, but are being done, I guess, for
> aesthetics.  The binary_runtime_size is only used for allocating the
> memory needed for carrying the measurement list across kexec.  Anything
> related to carrying or restoring the measurement list across kexec is
> limited to ima_init_ns.
>
>> There are also some case in the code that may do something like this:
>>
>> if (ns == &init_ima_ns)
>>
>>       foo = xyz;
>>
>> Those will go away when foo is moved into the namespace and then it
>> becomes ns->foo = xyz, which is much saner for readability but
>> unavoidable for some variables at this stage.
> Since binary_runtime_size is limited to the ima_init_ns, should it be
> conditional?

Moving it into ima_namespace keeps the code clean from these kind of 
constructs above. I would move it... The less of these constructs are 
there the less confusing it is, IMO. But ymmv.



>
> thanks,
>
> Mimi
>
