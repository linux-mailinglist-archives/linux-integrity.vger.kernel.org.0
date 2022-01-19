Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4BA493A34
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jan 2022 13:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354436AbiASMXd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jan 2022 07:23:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345736AbiASMXc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jan 2022 07:23:32 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20J9wtXq029511;
        Wed, 19 Jan 2022 12:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IMGs1lQPREs3fS9tWGWIxado3vIFlDym5QNO9uDunxo=;
 b=OeIqt/AYTwJZ6n+aBVey0QdJEX+xWq6cp4lXc6EZkV52j5fXkZInjCZV9kl2fsXL/vAv
 mkkh0QCTcI+/DrvxwpqlkfnfemEqBXEBDah/WgsjsAWf68vGf9wUXtLCEavmLZCEEkY2
 wQJ5wgBLuHbVFi1KVWGqRH2QFZu1Kv9Zz1zePk9Vozu82CK6aHhaRrHGMdlC2pmP2aKn
 xZr+aBF/XNz5bmvfvuMcOq28PfPnyHwIVSFt+e7L+54tZsF2J2WMdyuxUp0V8uyIqQ3o
 brYx8j2Jjc2pktX8NozKZB1nv8KblW8EjHYYYEDE+WaOtcHHdLdCQb4JaSP9DasUH7du ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpgg2tp8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 12:23:21 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20JC9a7h025271;
        Wed, 19 Jan 2022 12:23:20 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpgg2tp8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 12:23:20 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20JCDwaY029691;
        Wed, 19 Jan 2022 12:23:19 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 3dknwb6xuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 12:23:19 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20JCNHgu8651672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 12:23:17 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE6B5AE066;
        Wed, 19 Jan 2022 12:23:17 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 798E3AE05F;
        Wed, 19 Jan 2022 12:23:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jan 2022 12:23:17 +0000 (GMT)
Message-ID: <8070e12c-e4c5-a1eb-b4a8-0f48f55608ef@linux.ibm.com>
Date:   Wed, 19 Jan 2022 07:23:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 05/19] ima: Move measurement list related variables
 into ima_namespace
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-6-stefanb@linux.vnet.ibm.com>
 <df3d903ee6c1313a4158ccc958e80f8deafa7a0d.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <df3d903ee6c1313a4158ccc958e80f8deafa7a0d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6JigGJykq1pmRhDj72bP5cwNX2THOrlz
X-Proofpoint-ORIG-GUID: xHo-rprkjY8yZa_3c30mgWQrtJe9SBax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_07,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190070
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/13/22 15:27, Mimi Zohar wrote:
> Hi Stefan,
>
> On Tue, 2022-01-04 at 12:04 -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Move measurement list related variables into the ima_namespace. This way a
>> front-end like SecurityFS can show the measurement list inside an IMA
>> namespace.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   security/integrity/ima/ima.h             |  5 +++--
>>   security/integrity/ima/ima_fs.c          |  6 ++++--
>>   security/integrity/ima/ima_init_ima_ns.c |  5 +++++
>>   security/integrity/ima/ima_kexec.c       | 12 +++++++-----
>>   security/integrity/ima/ima_queue.c       | 24 ++++++++++--------------
>>   5 files changed, 29 insertions(+), 23 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 68d8a8e6fd1d..ee16ce5050c8 100644
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
>> @@ -134,6 +133,8 @@ struct ima_namespace {
>>   	int ima_policy_flag;
>>   
>>   	struct ima_h_table ima_htable;
>> +	struct list_head ima_measurements;
>> +	unsigned long binary_runtime_size;
> Please add a comment indicating binary_runtime_size is only applicable
> to ns_ima_init.

It looks like this now:

         struct list_head ima_measurements;
         /* binary_runtime_size is used only by init_ima_ns */
         unsigned long binary_runtime_size;


>
>
>>   } __randomize_layout;
>>   extern struct ima_namespace init_ima_ns;
>
>> @@ -124,12 +119,13 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
>>    * entire binary_runtime_measurement list, including the ima_kexec_hdr
>>    * structure.
>>    */
>> -unsigned long ima_get_binary_runtime_size(void)
>> +unsigned long ima_get_binary_runtime_size(struct ima_namespace *ns)
>>   {
>> -	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
>> +	if (ns->binary_runtime_size >=
>> +				(ULONG_MAX - sizeof(struct ima_kexec_hdr)))
>>   		return ULONG_MAX;
>>   	else
>> -		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
>> +		return ns->binary_runtime_size + sizeof(struct ima_kexec_hdr);
>>   }
>>   
> Please update the function description indicating that either carrying
> the measurement list across kexec is limited to ns_ima_init or not
> supported by namespaces.

This is the updated function description:


/*
  * Return the amount of memory required for serializing the
  * entire binary_runtime_measurement list, including the ima_kexec_hdr
  * structure. Carrying the measurement list across kexec is limited
  * to init_ima_ns.
  */
>
> thanks,
>
> Mimi
>
