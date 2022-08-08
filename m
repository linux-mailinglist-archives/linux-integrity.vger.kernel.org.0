Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82A758C1FF
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Aug 2022 05:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiHHDTm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Aug 2022 23:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiHHDTl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Aug 2022 23:19:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCB1E086;
        Sun,  7 Aug 2022 20:19:36 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M1Lwr4Rm8zmVN5;
        Mon,  8 Aug 2022 11:17:32 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 11:19:34 +0800
Message-ID: <cc760579-36f4-fe32-3526-bb647efd438c@huawei.com>
Date:   Mon, 8 Aug 2022 11:19:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Race conditioned discovered between ima_match_rules and
 ima_update_lsm_update_rules
Content-Language: en-US
From:   "Guozihua (Scott)" <guozihua@huawei.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        <selinux@vger.kernel.org>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>,
        luhuaxin <luhuaxin1@huawei.com>, <paul@paul-moore.com>
References: <ffbb5ff1-cec7-3dad-7330-31fdfb67fecc@huawei.com>
In-Reply-To: <ffbb5ff1-cec7-3dad-7330-31fdfb67fecc@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/8/8 11:02, Guozihua (Scott) wrote:
> Hi Community,
> 
> Recently we discovered a race condition while updating SELinux policy 
> with IMA lsm rule enabled. Which would lead to extra files being measured.
> 
> While SELinux policy is updated, the IDs for object types and such would 
> be changed, and ima_lsm_update_rules would be called.
> 
> There are no lock applied in ima_lsm_update_rules. If user accesses a 
> file during this time, ima_match_rules will be matching rules based on 
> old SELinux au_seqno resulting in selinux_audit_rule_match returning 
> -ESTALE.
> 
> However, in ima_match_rules, this error number is not handled, causing 
> IMA to think the LSM rule is also a match, leading to measuring extra 
> files.
> 
> Relevant codes are as follows:
> 
>> static void ima_lsm_update_rules(void)
>> {
>>     struct ima_rule_entry *entry, *e;
>>     int result;
>>
>>     list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
>>         if (!ima_rule_contains_lsm_cond(entry))
>>             continue;
>>
>>         result = ima_lsm_update_rule(entry);
> 
> A RCU style update is used with no lock applied. Reading to rules would 
> return rules with staled au_seqno.
> 
>>         if (result) {
>>             pr_err("lsm rule update error %d\n", result);
>>             return;
>>         }
>>     }
>> }
> 
> 
>> int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
>> {
>>     struct selinux_state *state = &selinux_state;
>>     struct selinux_policy *policy;
>>     struct context *ctxt;
>>     struct mls_level *level;
>>     struct selinux_audit_rule *rule = vrule;
>>     int match = 0;
>>
>>     if (unlikely(!rule)) {
>>         WARN_ONCE(1, "selinux_audit_rule_match: missing rule\n");
>>         return -ENOENT;
>>     }
>>
>>     if (!selinux_initialized(state))
>>         return 0;
>>
>>     rcu_read_lock();
>>
>>     policy = rcu_dereference(state->policy);
>>
>>     if (rule->au_seqno < policy->latest_granting) {
>>         match = -ESTALE;
>>         goto out;
>>     }
> 
> SELinux would return -ESTALE here.
> 
>> static bool ima_match_rules(struct ima_rule_entry *rule,
>>                 struct user_namespace *mnt_userns,
>>                 struct inode *inode, const struct cred *cred,
>>                 u32 secid, enum ima_hooks func, int mask,
>>                 const char *func_data)
>> {
>> ...
>>
>>     for (i = 0; i < MAX_LSM_RULES; i++) {
>>         int rc = 0;
>>         u32 osid;
>>
>>         if (!rule->lsm[i].rule) {
>>             if (!rule->lsm[i].args_p)
>>                 continue;
>>             else
>>                 return false;
>>         }
>>         switch (i) {
>>         case LSM_OBJ_USER:
>>         case LSM_OBJ_ROLE:
>>         case LSM_OBJ_TYPE:
>>             security_inode_getsecid(inode, &osid);
>>             rc = ima_filter_rule_match(osid, rule->lsm[i].type,
>>                            Audit_equal,
>>                            rule->lsm[i].rule);
> 
> rc here will be -ESTALE.
> 
>>             break;
>>         case LSM_SUBJ_USER:
>>         case LSM_SUBJ_ROLE:
>>         case LSM_SUBJ_TYPE:
>>             rc = ima_filter_rule_match(secid, rule->lsm[i].type,
>>                            Audit_equal,
>>                            rule->lsm[i].rule);
>>             break;
>>         default:
>>             break;
>>         }
>>         if (!rc)
>>             return false;
> 
> -ERRNO is not handled, this func will return true.
> 
>>     }
>>     return true;
>> }
> 
> It seems that IMA would not "leak" any files, but widening the 
> measurement range.
> 
> Is this the intended behavior? Or is it a good idea to add a lock for 
> LSM rules during update?
> 

Including SELinux in the loop.

-- 
Best
GUO Zihua
