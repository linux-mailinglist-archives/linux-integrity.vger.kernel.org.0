Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F78D4AB106
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Feb 2022 18:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbiBFRmT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Feb 2022 12:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiBFRmS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Feb 2022 12:42:18 -0500
X-Greylist: delayed 1290 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 09:42:17 PST
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC22C06173B;
        Sun,  6 Feb 2022 09:42:17 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 216FigkE026399;
        Sun, 6 Feb 2022 17:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NBqrMi7xopHaW9gcpcMahF8SSykQzlv27VKrheGwC8s=;
 b=AIX5yyD0eOKKh6ajfjpKTaQywUX0rnwhuc80HiRtncA4PuV81mLpuGxWLXuQUmn+zVV+
 wbKFbWU4GUF8Hg92FYHOMZbnkOZ5acmsGE2/RODCET7cyJXak9DWTSf8m1AX9ubI8cIm
 /8sDLEub1EPNXHRHJWVWQBtgngI1NPKnP6TIVw3foU92XVlpqN/EzCloKP8CT0qqyLou
 8Dcx9OFBgCV0kC01ueB5z/8H+RQWCOkDhu0OWFZdtR/qUQlQFTB58oUKmUn1VOXdB1BX
 T8Hhc26QUprpQCnc6iejiIOU4AbJZ+DizkssLUgOnmOyt4AKkBSlL6R06yzqZePZftkC qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e23anacj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 17:20:18 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 216HKH3E007885;
        Sun, 6 Feb 2022 17:20:17 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e23anachv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 17:20:17 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 216HCmFd016488;
        Sun, 6 Feb 2022 17:20:16 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3e2f8m1f6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 17:20:16 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 216HKFT19044512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Feb 2022 17:20:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A2B1AC05E;
        Sun,  6 Feb 2022 17:20:15 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8CA5AC05B;
        Sun,  6 Feb 2022 17:20:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  6 Feb 2022 17:20:14 +0000 (GMT)
Message-ID: <9c8a09d6-6373-c8c2-c8ff-2b4c3f92ddf1@linux.ibm.com>
Date:   Sun, 6 Feb 2022 12:20:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 12/27] ima: Define mac_admin_ns_capable() as a wrapper
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
        Denis Semakin <denis.semakin@huawei.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-13-stefanb@linux.ibm.com>
 <20220205055826.GA15072@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220205055826.GA15072@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aagAQgTRfkLb-Lq3exPImckM-UJqhyU1
X-Proofpoint-ORIG-GUID: otIMV6j2_uervesGtk77m3IwpIO9v2vH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-06_05,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202060127
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/5/22 00:58, Serge E. Hallyn wrote:
> On Tue, Feb 01, 2022 at 03:37:20PM -0500, Stefan Berger wrote:
>> Define mac_admin_ns_capable() as a wrapper for the combined ns_capable()
>> checks on CAP_MAC_ADMIN and CAP_SYS_ADMIN in a user namespace. Return
>> true on the check if either capability or both are available.
>>
>> Use mac_admin_ns_capable() in place of capable(SYS_ADMIN). This will allow
>> an IMA namespace to read the policy with only CAP_MAC_ADMIN, which has
>> less privileges than CAP_SYS_ADMIN.
>>
>> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   include/linux/capability.h      | 6 ++++++
>>   security/integrity/ima/ima.h    | 6 ++++++
>>   security/integrity/ima/ima_fs.c | 5 ++++-
>>   3 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/capability.h b/include/linux/capability.h
>> index 65efb74c3585..991579178f32 100644
>> --- a/include/linux/capability.h
>> +++ b/include/linux/capability.h
>> @@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>>   		ns_capable(ns, CAP_SYS_ADMIN);
>>   }
>>   
>> +static inline bool mac_admin_ns_capable(struct user_namespace *ns)
>> +{
>> +	return ns_capable(ns, CAP_MAC_ADMIN) ||
>> +		ns_capable(ns, CAP_SYS_ADMIN);
> Do you care about audit warnings?  If the task has CAP_SYS_ADMIN but
> not CAP_MAC_ADMIN, is it desirable that selinux_capable() will audit the
> CAP_MAC_ADMIN failure?

Good point.  I will switch both to ns_capable_noaudit() so that the user 
cannot provoke unnecessary audit message.

Thanks.

     Stefan

>
>> +}
>> +
>>   /* audit system wants to get cap info from files as well */
>>   int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
>>   			   const struct dentry *dentry,
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index fb6bd054d899..0057b1fd6c18 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -487,4 +487,10 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
>>   #define	POLICY_FILE_FLAGS	S_IWUSR
>>   #endif /* CONFIG_IMA_READ_POLICY */
>>   
>> +static inline
>> +struct user_namespace *ima_user_ns_from_file(const struct file *filp)
>> +{
>> +	return file_inode(filp)->i_sb->s_user_ns;
>> +}
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
>> 2.31.1
