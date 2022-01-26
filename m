Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE2749D565
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 23:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiAZWYb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 17:24:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbiAZWYa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 17:24:30 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QMOIcH001282;
        Wed, 26 Jan 2022 22:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AqLDb7oC344gTow/uDRwc6F7y7gWhyphzkM/OBMcx78=;
 b=QItk+nQx3lsn47mp5QDUGPPgTj16HMGTOJxl5QFsKiqGR7/NY6W0q1dxYEtOGLC58pUo
 Nv36Z9++oO99zdCXDmnyheypEm0UwZKuXj/bXDteuzg5StZsCDkvE6OVV8s33opS7pgx
 owkfkbFP+DJq7pVEByxEDtVi94grNotiqI1O9FU3SGhDvKpceiWOGtReG1fkCvYU3gzk
 LuRttgap2jicYG31hd1NGstyxnG8+8JcxNE0qEn/HjQQ2x2hch9GnopsWmcC8kJ14DGN
 9xTFh58nSwIDE5dqm5no7ppBWPo7HLYV1p7T70KIkKMbD/Xq3AdRhQ6UiIY/QtcIV8RK ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duet70bge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 22:24:18 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20QMNnLN031399;
        Wed, 26 Jan 2022 22:24:00 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duet70bfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 22:24:00 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20QMDAK3007199;
        Wed, 26 Jan 2022 22:23:59 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 3dt1xakmts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 22:23:59 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20QMNqrX29819320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 22:23:52 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38F646A047;
        Wed, 26 Jan 2022 22:23:52 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B81D16A04F;
        Wed, 26 Jan 2022 22:23:49 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 22:23:49 +0000 (GMT)
Message-ID: <9ca21852-17ee-fc99-4764-300cd5199810@linux.ibm.com>
Date:   Wed, 26 Jan 2022 17:23:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 08/23] ima: Move measurement list related variables
 into ima_namespace
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-9-stefanb@linux.vnet.ibm.com>
 <20220126092159.4rgclr5s3jli7aqy@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220126092159.4rgclr5s3jli7aqy@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6d07J6qR1P1xp3FrOFIPPdlzD9hXsE1y
X-Proofpoint-ORIG-GUID: JdVJZpC1BlMcH50MZWAEpLy_SOIE4NbH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/26/22 04:21, Christian Brauner wrote:
> On Tue, Jan 25, 2022 at 05:46:30PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Move measurement list related variables into the ima_namespace. This way
>> a front-end like securityfs can show the measurement list inside an IMA
>> namespace.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   security/integrity/ima/ima.h             |  5 +++--
>>   security/integrity/ima/ima_fs.c          |  6 ++++--
>>   security/integrity/ima/ima_init_ima_ns.c |  5 +++++
>>   security/integrity/ima/ima_kexec.c       | 12 ++++++-----
>>   security/integrity/ima/ima_queue.c       | 27 +++++++++++-------------
>>   5 files changed, 31 insertions(+), 24 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 340a59174670..45706836a77b 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -106,7 +106,6 @@ struct ima_queue_entry {
>>   	struct list_head later;		/* place in ima_measurements list */
>>   	struct ima_template_entry *entry;
>>   };
>> -extern struct list_head ima_measurements;	/* list of all measurements */
>>   
>>   /* Some details preceding the binary serialized measurement list */
>>   struct ima_kexec_hdr {
>> @@ -136,6 +135,8 @@ struct ima_namespace {
>>   	struct ima_rule_entry *arch_policy_entry;
>>   
>>   	struct ima_h_table ima_htable;
>> +	struct list_head ima_measurements;	/* list of all measurements */
>> +	unsigned long binary_runtime_size;	/* used by init_ima_ns */
>>   } __randomize_layout;
> Moving this into struct imans seems sane to me but I'm not going to ack
> it because I don't have enough knowledge to guarantee that this code
> will only run for init_ima_ns. I'll leave that to Mimi.

The code modifying binary_runtime_size may do this for all IMA 
namespaces but the resulting value of binary_runtime_size may only 
matter in init_ima_ns (not 100% sure, but Mimi seems to say so). Moving 
it into ima_namespace rather than special-casing the code keeps the code 
readable.

There are also some case in the code that may do something like this:

if (ns == &init_ima_ns)

     foo = xyz;

Those will go away when foo is moved into the namespace and then it 
becomes ns->foo = xyz, which is much saner for readability but 
unavoidable for some variables at this stage.


