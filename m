Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB39492D3D
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 19:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbiARS0C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 13:26:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231563AbiARSZ7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 13:25:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IH2P5o031785;
        Tue, 18 Jan 2022 18:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iE9WKD1YJTxYs5keYigsr8/4SV2jwquBdbV3r5pWp08=;
 b=M9zkN6O4Bknm74VroZcEhcqzTgXhAJ7PWKSnOFk4IU9VTO+QrPS/XZkByB1fYYOvFUws
 0HrL+HOZCiPY4CkyQceEfXL3J3s1Hj3DO/8RBYa5uSEzpT7SdKMA95jK6T15y77Ucgyl
 /tOae2iiWFPlzaotU0RZ2hqdU4rm/T1j8twm1yIkpjtm2ZYewwaexVowKTK9N9lgpJCp
 RZuYQUdxiAk7HSBw0Mml7Tx3kblDHM4L3G8cdvbFijkJ/8yoLRJkFcEtiIPJZmr3IcZN
 rQMnifUdQCE4LzHHxChUqdqY9/5VG00LMo8IgRIAtYEtx26ItaPgML0is5aZ2y8z1Nrr rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dp1kq26kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 18:25:44 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20IH3WSH003597;
        Tue, 18 Jan 2022 18:25:44 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dp1kq26k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 18:25:44 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20IIHeoF019546;
        Tue, 18 Jan 2022 18:25:43 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3dknwavyjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 18:25:43 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20IIPfNF31326610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 18:25:42 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF2E86A05F;
        Tue, 18 Jan 2022 18:25:41 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52B7E6A04D;
        Tue, 18 Jan 2022 18:25:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jan 2022 18:25:39 +0000 (GMT)
Message-ID: <546afc0c-8d86-e471-49cd-8665cea643fb@linux.ibm.com>
Date:   Tue, 18 Jan 2022 13:25:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 10/19] ima: Implement hierarchical processing of file
 accesses
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
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-11-stefanb@linux.vnet.ibm.com>
 <20220114112114.tu4f56bm7tewzfmj@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220114112114.tu4f56bm7tewzfmj@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VNH60PNfUU_LgIrC_cUmgkt2DVU7OxvU
X-Proofpoint-GUID: aqpCJlpBsGArLMbKizDpsEL0PYhojCq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_05,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/14/22 06:21, Christian Brauner wrote:
> On Tue, Jan 04, 2022 at 12:04:07PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Implement hierarchical processing of file accesses in IMA namespaces by
>> walking the list of user namespaces towards the root. This way file
>> accesses can be audited in an IMA namespace and also be evaluated against
>> the IMA policies of parent IMA namespaces.
>>
>> __process_measurement() returns either 0 or -EACCES. For hierarchical
>> processing remember the -EACCES returned by this function but continue
>> to the parent user namespace. At the end either return 0 or -EACCES
>> if an error occurred in one of the IMA namespaces.
>>
>> Currently the ima_ns pointer of the user_namespace is always NULL except
>> at the init_user_ns, so test ima_ns for NULL pointer and skip the call to
>> __process_measurement() if it is NULL. Once IMA namespacing is fully
>> enabled, the pointer may also be NULL due to late initialization of the
>> IMA namespace.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   include/linux/ima.h               |  6 +++++
>>   security/integrity/ima/ima_main.c | 37 +++++++++++++++++++++++++++----
>>   2 files changed, 39 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index b6ab66a546ae..fcee2a51bb87 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -65,6 +65,12 @@ static inline const char * const *arch_get_ima_policy(void)
>>   }
>>   #endif
>>   
>> +static inline struct user_namespace
>> +*ima_ns_to_user_ns(struct ima_namespace *ns)
>> +{
>> +	return current_user_ns();
>> +}
>> +
>>   #else
>>   static inline enum hash_algo ima_get_current_hash_algo(void)
>>   {
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 621685d4eb95..51b0ef1cebbe 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -200,10 +200,10 @@ void ima_file_free(struct file *file)
>>   	ima_check_last_writer(iint, inode, file);
>>   }
>>   
>> -static int process_measurement(struct ima_namespace *ns,
>> -			       struct file *file, const struct cred *cred,
>> -			       u32 secid, char *buf, loff_t size, int mask,
>> -			       enum ima_hooks func)
>> +static int __process_measurement(struct ima_namespace *ns,
>> +				 struct file *file, const struct cred *cred,
>> +				 u32 secid, char *buf, loff_t size, int mask,
>> +				 enum ima_hooks func)
>>   {
>>   	struct inode *inode = file_inode(file);
>>   	struct integrity_iint_cache *iint = NULL;
>> @@ -395,6 +395,35 @@ static int process_measurement(struct ima_namespace *ns,
>>   	return 0;
>>   }
>>   
>> +static int process_measurement(struct ima_namespace *ns,
>> +			       struct file *file, const struct cred *cred,
>> +			       u32 secid, char *buf, loff_t size, int mask,
>> +			       enum ima_hooks func)
>> +{
>> +	struct user_namespace *user_ns = ima_ns_to_user_ns(ns);
>> +	int ret = 0;
>> +
>> +	while (user_ns) {
>> +		ns = ima_ns_from_user_ns(user_ns);
>> +		if (ns) {
>> +			int rc;
>> +
>> +			rc = __process_measurement(ns, file, cred, secid, buf,
>> +						   size, mask, func);
>> +			switch (rc) {
>> +			case -EACCES:
>> +				/* return this error at the end but continue */
>> +				ret = -EACCES;
>> +				break;
> This seems risky. Every error not -EACCES will be counted as a success.
> It doesn't look like __process_measurement() will return anything else
> but I would still place a WARN_ON() or WARN_ON_ONCE() in there to make
> that assumption explicit.
>
> Right now it looks like your only error condition is -EACCES and non-ima
> cracks like me need to read through __process_measurement() to figure
> out that that's ok. With a WARN_ON* in there I'd not have needed to bother.
>
> switch (rc) {
> case -EACCES:
> 	/* return this error at the end but continue */
> 	ret = -EACCES;
> 	break
> default:
> 	WARN_ON_ONCE(true);
              ret = -EINVAL;
> }
>
> or sm similar.


Agreed. To be on the safe side I would add a ret = -EINVAL to it for the 
unhandled case as shown above.

