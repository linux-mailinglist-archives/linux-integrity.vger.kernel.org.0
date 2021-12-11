Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24147471481
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 16:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhLKPie (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 10:38:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229881AbhLKPic (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 10:38:32 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BBFRWMQ002915;
        Sat, 11 Dec 2021 15:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vExcjYxaBdrMHVQmrf0Mg7RRDZ+JgZ/Mti44iswBctY=;
 b=TvWlnhAwLwMNFGhF3/4pCzeUFHqjA/xOwlUduZTQIlsglzLWxtilxmJsyXmdffY1DQ/R
 y8L6qbxWxT1bsUWXzxp/5/KdD4cRuu1SlUenQ8Jiuwunt6XuW5z9WmD5ZrWjZdVttcty
 gAL8LhtxsPk9d0bjuBXa0OrBU32BA/hcGQXrcWfPtiV6jKiSxetgFN1CDwNiT65zDbuV
 7RLWpZ5Uti9c898AGAqSZgRLnV95xBfaSLVTJs1U4QJxQEe9B95z+9YIu4kdzxyvjVXH
 NU6MnQOm9bKB5VgkK8Qmf5/QrUViCkDVAzKIQm976Dj34+kk3BXpkzpHCZbfSJGjR1jf Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvxn7846a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 15:38:14 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BBFcDcr000520;
        Sat, 11 Dec 2021 15:38:13 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvxn78460-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 15:38:13 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BBFSKog010825;
        Sat, 11 Dec 2021 15:38:12 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3cvkm9nvhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 15:38:12 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BBFcBAP48431498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 15:38:11 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8113AE05C;
        Sat, 11 Dec 2021 15:38:11 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66C1EAE060;
        Sat, 11 Dec 2021 15:38:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 11 Dec 2021 15:38:11 +0000 (GMT)
Message-ID: <7a914d80-db7c-cdd9-358a-97138ec6d750@linux.ibm.com>
Date:   Sat, 11 Dec 2021 10:38:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check
 corresponding capability
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Denis Semakin <denis.semakin@huawei.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "mpeters@redhat.com" <mpeters@redhat.com>,
        "lhinds@redhat.com" <lhinds@redhat.com>,
        "lsturman@redhat.com" <lsturman@redhat.com>,
        "puiterwi@redhat.com" <puiterwi@redhat.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "jamjoom@us.ibm.com" <jamjoom@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "rgb@redhat.com" <rgb@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-15-stefanb@linux.ibm.com>
 <cde301002f884f43bcb7fa244b1c6b84@huawei.com>
 <20211211150246.GA24925@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211211150246.GA24925@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PlNsclHo1LAQvRAvsjgzWHfCg7NDxhC_
X-Proofpoint-GUID: RgHZQ0nI7C39c5h4TGczP-3QlgKBMTYT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-11_06,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112110085
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/11/21 10:02, Serge E. Hallyn wrote:
> IMO yes it is unsafe, however I concede that I am not sufficiently familiar
> with the policy language.  At least Stefan and Mimi (IIUC) want the host
> policy language to be able to specify cases where an IMA ns can be
> configured.  What's not clear to me is what sorts of triggers the host
> IMA policy could specify that would safely identify a IMA ns generation
> trigger.
>
> Stefan, would you mind showing what such a policy statement would look like?
> Does it amount to "/usr/bin/runc may create an IMA ns which escapes current
> policy" ?  Or is it by UID, or any file which has a certain xattr on it?

If this policy here is active on the host then file executions 
(BPRM_CHECK) of uid=0 should be measured and audited on the host in any 
IMA namespace that uid=0 may create. We achieve this with hierarchical 
processing (v6: 10/17).

measure func=BPRM_CHECK mask=MAY_EXEC uid=0

audit func=BPRM_CHECK mask=MAY_EXEC uid=0

    Stefan


>
> -serge
>
> On Thu, Dec 09, 2021 at 08:09:20AM +0000, Denis Semakin wrote:
>> Following that thoughts...
>> Will it be so incorrectly to unbound IMA-ns from USER-ns?
>> I realize that it could lead a lot of problems but it is still unclear will current IMA-ns will be useful for Kuber...
>> How userland supposed to use current IMA-ns implementation?
>>
>> Br,
>> Denis
>>
>> -----Original Message-----
>> From: Denis Semakin
>> Sent: Thursday, December 9, 2021 10:22 AM
>> To: 'Stefan Berger' <stefanb@linux.ibm.com>; linux-integrity@vger.kernel.org
>> Cc: zohar@linux.ibm.com; serge@hallyn.com; christian.brauner@ubuntu.com; containers@lists.linux.dev; dmitry.kasatkin@gmail.com; ebiederm@xmission.com; Krzysztof Struczynski <krzysztof.struczynski@huawei.com>; Roberto Sassu <roberto.sassu@huawei.com>; mpeters@redhat.com; lhinds@redhat.com; lsturman@redhat.com; puiterwi@redhat.com; jejb@linux.ibm.com; jamjoom@us.ibm.com; linux-kernel@vger.kernel.org; paul@paul-moore.com; rgb@redhat.com; linux-security-module@vger.kernel.org; jmorris@namei.org
>> Subject: RE: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check corresponding capability
>>
>> Hi.
>> My question won't be about capabilities. I'm wondering how IMA-ns which is associated with USER-ns and is created during USER-ns creation would be used by some namespaces orchestration systems, e.g. Kubernetes?.. It seems that it can be run without any user namespaces...
>> Their community just discuss this opportunity to support User namespaces. (see https://github.com/kubernetes/enhancements/pull/2101)
>> Looks like currently IMA-ns will not be applicable for Kubernetes.
>>
>> Br,
>> Denis
>>
>> -----Original Message-----
>> From: Stefan Berger [mailto:stefanb@linux.ibm.com]
>> Sent: Thursday, December 9, 2021 1:18 AM
>> To: linux-integrity@vger.kernel.org
>> Cc: zohar@linux.ibm.com; serge@hallyn.com; christian.brauner@ubuntu.com; containers@lists.linux.dev; dmitry.kasatkin@gmail.com; ebiederm@xmission.com; Krzysztof Struczynski <krzysztof.struczynski@huawei.com>; Roberto Sassu <roberto.sassu@huawei.com>; mpeters@redhat.com; lhinds@redhat.com; lsturman@redhat.com; puiterwi@redhat.com; jejb@linux.ibm.com; jamjoom@us.ibm.com; linux-kernel@vger.kernel.org; paul@paul-moore.com; rgb@redhat.com; linux-security-module@vger.kernel.org; jmorris@namei.org; Stefan Berger <stefanb@linux.ibm.com>; Denis Semakin <denis.semakin@huawei.com>
>> Subject: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check corresponding capability
>>
>> Use mac_admin_ns_capable() to check corresponding capability to allow read/write IMA policy without CAP_SYS_ADMIN but with CAP_MAC_ADMIN.
>>
>> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   include/linux/capability.h      | 6 ++++++
>>   security/integrity/ima/ima_fs.c | 2 +-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/capability.h b/include/linux/capability.h index 65efb74c3585..991579178f32 100644
>> --- a/include/linux/capability.h
>> +++ b/include/linux/capability.h
>> @@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>>   		ns_capable(ns, CAP_SYS_ADMIN);
>>   }
>>   
>> +static inline bool mac_admin_ns_capable(struct user_namespace *ns) {
>> +	return ns_capable(ns, CAP_MAC_ADMIN) ||
>> +		ns_capable(ns, CAP_SYS_ADMIN);
>> +}
>> +
>>   /* audit system wants to get cap info from files as well */  int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
>>   			   const struct dentry *dentry,
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c index 0e582ceecc7f..a749a3e79304 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -394,7 +394,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)  #else
>>   		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>>   			return -EACCES;
>> -		if (!capable(CAP_SYS_ADMIN))
>> +		if (!mac_admin_ns_capable(ns->user_ns))
>>   			return -EPERM;
>>   		return seq_open(filp, &ima_policy_seqops);  #endif
>> --
>> 2.31.1
