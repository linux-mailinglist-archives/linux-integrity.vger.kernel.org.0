Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1CD532C12
	for <lists+linux-integrity@lfdr.de>; Tue, 24 May 2022 16:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiEXORx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 May 2022 10:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiEXORx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 May 2022 10:17:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4235DA70;
        Tue, 24 May 2022 07:17:50 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ODoL5A019788;
        Tue, 24 May 2022 14:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=48zm3WbH9RuCz4QK6/PJjpinT6WsMc8nOREZWmXsybk=;
 b=HC4Uyua1G8+aT6s9w2LBLhSqE85ObLgZGenTbqMPoMoCX5wSmHrpxZDDzQxkAeVsNTq4
 iwCbnfVGnm5inEDbwtuxTL2tVubbKHp3igib1zu9CSvnWY4KoeMn92V7/2ZqElHK4o8J
 fUfANlrc1jT0ivLeFYlhHA8AA8JpUUAdhlQ+bVHuSKObz/nNKZn7yG7jeEnM74jFxPWm
 YENipcgc7SPX4FNf8B8mUujB0vNh5JnmGVQAKBroMY4qKo167NfyqZlmjxmZpGkHifWm
 Ees1YEvF0rxE0nfmp3uOi7Ud12SqrpgbFN7c2v9OmXMebOZy1Li7dBUkkLWgB9BqGLg8 ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g903bsn9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 14:17:31 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24ODprTs028893;
        Tue, 24 May 2022 14:17:31 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g903bsn95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 14:17:31 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OEE7xX030227;
        Tue, 24 May 2022 14:17:30 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 3g6qq9ggf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 14:17:30 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OEHTIf34734364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 14:17:29 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D5D26A051;
        Tue, 24 May 2022 14:17:29 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BE596A057;
        Tue, 24 May 2022 14:17:28 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 14:17:28 +0000 (GMT)
Message-ID: <ba9027b7-40dc-c958-e140-2eaa102e2c30@linux.ibm.com>
Date:   Tue, 24 May 2022 10:17:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v12 11/26] ima: Define mac_admin_ns_capable() as a wrapper
 for ns_capable()
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Denis Semakin <denis.semakin@huawei.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-12-stefanb@linux.ibm.com>
 <20220522173100.GB24041@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220522173100.GB24041@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: esteqUPeWMnvSxMLspjEYyYUNNRU3vHR
X-Proofpoint-GUID: G4XWVbpVinR-Lha1H_-xsFupBL_sVYzW
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_07,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205240072
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/22/22 13:31, Serge E. Hallyn wrote:
> On Wed, Apr 20, 2022 at 10:06:18AM -0400, Stefan Berger wrote:
>> Define mac_admin_ns_capable() as a wrapper for the combined ns_capable()
>> checks on CAP_MAC_ADMIN and CAP_SYS_ADMIN in a user namespace. Return
>> true on the check if either capability or both are available.
>>
>> Use mac_admin_ns_capable() in place of capable(SYS_ADMIN). This will allow
>> an IMA namespace to read the policy with only CAP_MAC_ADMIN, which has
>> less privileges than CAP_SYS_ADMIN.
>>
>> Since CAP_MAC_ADMIN is an additional capability added to an existing gate
>> avoid auditing in case it is not set.
> 
> It would probably be best to become a user of
> https://lore.kernel.org/all/20220217145003.78982-2-cgzones@googlemail.com/
> 
> when that lands.

Hm,I'll try to monitor to see when this gets merged. Though the function 
proposed there uses a hard-coded init_user_ns, which may not work for 
everyone.

> 
>> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> ---
>> v11:
>>    - use ns_capable_noaudit for CAP_MAC_ADMIN to avoid auditing in this case
>> ---
>>   include/linux/capability.h      | 6 ++++++
>>   security/integrity/ima/ima.h    | 6 ++++++
>>   security/integrity/ima/ima_fs.c | 5 ++++-
>>   3 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/capability.h b/include/linux/capability.h
>> index 65efb74c3585..dc3e1230b365 100644
>> --- a/include/linux/capability.h
>> +++ b/include/linux/capability.h
>> @@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>>   		ns_capable(ns, CAP_SYS_ADMIN);
>>   }
>>   
>> +static inline bool mac_admin_ns_capable(struct user_namespace *ns)
>> +{
>> +	return ns_capable_noaudit(ns, CAP_MAC_ADMIN) ||
>> +		ns_capable(ns, CAP_SYS_ADMIN);
>> +}
>> +
>>   /* audit system wants to get cap info from files as well */
>>   int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
>>   			   const struct dentry *dentry,
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 5bf7f080c2be..626a6ce2453c 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -491,4 +491,10 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
>>   #define	POLICY_FILE_FLAGS	S_IWUSR
>>   #endif /* CONFIG_IMA_READ_POLICY */
>>   
>> +static inline
>> +struct user_namespace *ima_user_ns_from_file(const struct file *filp)
>> +{
>> +	return file_inode(filp)->i_sb->s_user_ns;
>> +}
> 
> include/linux/fs.h has file_mnt_user_ns().  Maybe you should add a
> file_sb_user_ns() next to that?

I did that now:


+static inline
+struct user_namespace *ima_user_ns_from_file(struct file *filp)
+{
+       return file_sb_user_ns(filp);
+}
+


+static inline struct user_namespace *file_sb_user_ns(struct file *file)
+{
+       return i_user_ns(file_inode(file));
+}
+



> 
>> +
>>   #endif /* __LINUX_IMA_H */
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index 89d3113ceda1..c41aa61b7393 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -377,6 +377,9 @@ static const struct seq_operations ima_policy_seqops = {
>>    */
>>   static int ima_open_policy(struct inode *inode, struct file *filp)
>>   {
>> +#ifdef CONFIG_IMA_READ_POLICY
>> +	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
>> +#endif
>>   	struct ima_namespace *ns = &init_ima_ns;
>>   
>>   	if (!(filp->f_flags & O_WRONLY)) {
>> @@ -385,7 +388,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
>>   #else
>>   		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>>   			return -EACCES;
>> -		if (!capable(CAP_SYS_ADMIN))
>> +		if (!mac_admin_ns_capable(user_ns))
>>   			return -EPERM;
>>   		return seq_open(filp, &ima_policy_seqops);
>>   #endif
>> -- 
>> 2.34.1
