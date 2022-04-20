Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB68F5091F0
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 23:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377263AbiDTVSj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 17:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357944AbiDTVSh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 17:18:37 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623D5443F3
        for <linux-integrity@vger.kernel.org>; Wed, 20 Apr 2022 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650489349; bh=VEt2vTTDYkmBujADODnwKYS3us+DTqw2dfUBc3H8tB8=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=sWtiG2OvmamDf0XPcpTfWDLKFg7STuXt1BwDN+fIoXpQYlEHM8WZ35PTljGGmdkWrOHTYS+nZq8nwIu4DDooDh1Z5sUYAm5BCCQ3+dKL4oLhHZCc2Ukots4wFAUYlH9XPb4SNCAoCXfWCs2AeEsm5PTrKzYnnBr72YfLCzC8BUeYao13oo3FpvH5jgJdNu3TWLL6yZDgjwAiHDExjtHSn8f4p9FRpe3cwtFNFiINoumr9vvhHp6xE8YCpR2IaKU0nFCvKVOT4L+u4OIVT5naGB8a+0fpCkKnuU5JmutC7IJfrDgHKAgkWVM87XCGtU8YH0aaXNGmLkkFDBU1CUSovA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650489349; bh=9m8++KeGxVZxdXZRfRnvZt6Xdp9DZ5b/uLyC9A6AzUU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cFEZCPbI198yopWY93i0T3hFDM4Z3vyC0imypxJHYxjbDUDmSpB/eFzCAI2Xav78FH/ODa7Bd2GzKMtxkhX0oTWfzBEmGigmwLRpPrnxsS77N8q4qggdfA35oNonNth/TS6UlMBVkvrJzuJN4uTqcTCGMIYDUObhNFnJIUg09bGA8ZdJ+RmLL/HYSktPI2NWZpM0AhNwdSWfFa1xTu5NCGEu2FciSHBI3s2rCK1dDVyrAfOuuaKoUUjreh7B7BsSaamy3CDPGOBRjmemNTRqi1OB3lx1NF6JA9vlpTKv9CXEduWfh93j7eWXgTtZbtol7it4sfJpeY8Oe4ReIQs4+g==
X-YMail-OSG: aEyS0EMVM1ky6tspFzkY9HmHyCDa4xWLPuJv2cAlVmEr_KA.I0_zWXpGC7.PMqd
 S7sBvz2ZK.rfwv4_M4uviJFbFI7aXE_M7UKjmNYf2AakrThJGUpAg7SadeaT8v4USm61dCyGvTAW
 IATOvwYWytnpLWUz7yXynaZWqUJw0pDN03L4diTrZKg7ypwWEakb9RRN0gMtXwf48TjBzkQXcXYl
 WbTZDcKL7w_AFzFk.h3_njDVTJXErY4hNn8g6C_t86q_5OGMvOLTqVpAKdCS88DfhIBH1bp07AkK
 QllX_.I4Rp0bBNJ4luk8UnKcDooojizJVZdAFxJDZggSb.GhtxEgQNH71n0Quk9Qj_jqE4YN3PvU
 jNQaMljEZaNM89NIAyOLusJX4Q3T_.vnWXD2IrDa_PZH8i_HLjcAF4djTAbXH.D_7GkhI8mOXxzV
 a80jUWK328szntpXy8ZNP6cUE_Y7omz0VOKnd8Lus2Ra2x2GcsbkGuX11VDPCb_OPFe0_CdeJyb0
 phZbnD7RM7HdGii3V.Vz1UKSWcUlQTv.e_syW0Y96SYYgsS7EPIuYL9WP3b9kgERKBzTn4a8jErO
 ACrFKGh1vl7d8RbW681pkL2R0ptut00l.xMrU2JsukMEoVDkLsyZGf5OLVotsJ4KyK9dzRyzzcYd
 GCQdYOqWa2iiLQe2DS1_MTtF.WS3vs0OYc4geVYzYVeP83BbDkR6LhPSUocUOttOd6dCZ7UnMng2
 AEK.AV4OlxWpFy6xyvTrGtAFZGis2wqwFfafFgRg5XeHrQfGXDpo61DL7Vqn8SUXLd9De9GXWOOJ
 .i61FW4_CNiRHNUEc0b2OWq27i7EBzD32DV_fnvVg2BfcTOZFB45tPMWNDYm1OIxNopz6CuNO2uQ
 0MbDRZd5xcAUdVpPqV.E5MXZ8YCP.lJwvWckn9czn.KrPIVt699xzhlnNy4slx1Bv_bMZqGy165M
 6Gb1bQb0D7PPP1r265zfT_3rkeiZ.RaDHyF_JlKmBF2om32H9xV7xQ4_sOv_JDKIoDci3LEPAh.y
 M0LwWpBxrHn_nZ.RuaV1ugY7PAPElLUrfnKd_CIjx8tbJXVAPFXKodV7zy2QV6JStCn2zphBBjsR
 z13GW9Ya189s2qUBirJCMH2unGCIDuEsWBKM.FC3iwF0Ti4mfIPweFOEcoGej41Ad.LkZaDP.rab
 lM647iG6yicEf2APCUxoLhhRcTVieq0FHMKBpNa7c9mcA0GsYVZmh9JwtwEy38wQ22c978AHUpeZ
 F3eUoLdIvsulZm.hEz.XYAtbbt9lTxKfu5T8p3sURgEmLe_KzzATGFpXzqiNN6Wa5annSG84_uKw
 hZc7cTOx2jaAm3KbYnN00n_xp_SkbYtnvFuuqbyp1eF0P7RH1Humpi.ZQzJ6ACb9rs6K3rA1_z8Y
 A85UtCEhcyjrcP2J_VjYUy3bu0W6gsbwRWLYfdfZYSxGoqpVGMAB03Zz84Umqvz18HRTQSjQwgZc
 5nFvBMJRRX7LOyHBcEhJDs0j7v9RPplNYJMi0vjT6WHv6CVUJQdNLbwBr4lS2w01XmayBIKcq8.c
 _ih4Jsg5RC8qTP0H9WFk_aXXVE2lSLSZIAbSbLEZRquW2FcxbjoVBAhATVdkntWQZd_MO_V4ynlW
 .yJnoFRjo9QmMlN6iLi.m5jbV0ZFDXE1wvCZzh.Gv8V..SdydNW9NR83LC8c.sE0Uvm0KUbDmZSZ
 d5CUn.2PK5Smg6eb8wiSs09UBeaeKa8jrOtr9G04MsnKgyNiMgeLiEdYJ_pN4Bo_uRoJnKnniCFD
 T9eItMY8dyofnVaL4_lzetSj7oknw15s2cyhEjeSJcltTHqPTb10Mr.EXMu_YaKk0iGvbftHE1Rl
 bdb93ZED211UxmAyuEqIgpuIbXZCHZh11_mnT68eZp0BhGgPYaOYZVuVFitr_PuKLLRzPVgGqrt1
 uoIryDgHeF00_4ouZnfB4Vjid83J6L3g3raXXXMxDe_wKsAz.iS.LE.p2LwCbo2rALyT2la15OhJ
 6yhh8aOpYP6EPvJocc.u_fhW8_vydntqiMZr3D.KUi9mUyXIwAvk_OKBD3m2q2cBQQqb6WOKejek
 Kubn7ud5t45BxSyWjBKZRevWdnV.GBGN7ae3UNbn0oxR944v_XG.s280X4rEwrpQ.Xdm5QrXa3WN
 EE8AoNq__bcF6s._B0QHXFKq.67nr7P149dj4_u.XsAFaafHYwTXVVtve7zmfga8BiilgsoQQmtS
 FieH_36pHipuofOqbL5_mfYzvF0TIPjZRljrjbiBkvW0P
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 20 Apr 2022 21:15:49 +0000
Received: by hermes--canary-production-ne1-6855c48695-xh97j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e69a230a26c5c4fb9c8c14254e1497a0;
          Wed, 20 Apr 2022 21:15:47 +0000 (UTC)
Message-ID: <b73e9b7f-ae5a-8cc0-cdad-e91445ba16a5@schaufler-ca.com>
Date:   Wed, 20 Apr 2022 14:15:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v35 05/29] IMA: avoid label collisions with stacked LSMs
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-6-casey@schaufler-ca.com>
 <286ba5a2-7399-b2b9-9846-e4235171db32@schaufler-ca.com>
 <caac73351355243bb1a545fe46ecb88db2600030.camel@linux.ibm.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <caac73351355243bb1a545fe46ecb88db2600030.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20048 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/20/2022 12:23 PM, Mimi Zohar wrote:
> Hi Casey,
>
> Below are a few initial comments/questions from a high level...
>
> On Tue, 2022-04-19 at 09:50 -0700, Casey Schaufler wrote:
>> On 4/18/2022 7:59 AM, Casey Schaufler wrote:
>>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>>> index eea6e92500b8..97470354c8ae 100644
>>> --- a/security/integrity/ima/ima_policy.c
>>> +++ b/security/integrity/ima/ima_policy.c
>>> @@ -89,6 +89,7 @@ struct ima_rule_entry {
>>>    	bool (*fgroup_op)(kgid_t cred_gid, kgid_t rule_gid); /* gid_eq(), gid_gt(), gid_lt() */
>>>    	int pcr;
>>>    	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
>>> +	int which;		/* which LSM rule applies to */
> If "which" was defined in the lsm[] structure, it would be clear
> reading the code that "which" refers to an LSM (e.g. entry-
>> lsm[i].which).  Perhaps rename "which" to "which_lsm", "lsm_slot", or
> "rules_lsm".

Both fine suggestions. I will incorporate them.

>
>>>    	struct {
>>>    		void *rule;	/* LSM file metadata specific */
>>>    		char *args_p;	/* audit value */
>>> @@ -285,6 +286,20 @@ static int __init default_appraise_policy_setup(char *str)
>>>    }
>>>    __setup("ima_appraise_tcb", default_appraise_policy_setup);
>>>    
>>> +static int ima_rules_lsm __ro_after_init;
>>> +
>>> +static int __init ima_rules_lsm_init(char *str)
>>> +{
>>> +	ima_rules_lsm = lsm_name_to_slot(str);
>>> +	if (ima_rules_lsm < 0) {
>>> +		ima_rules_lsm = 0;
>>> +		pr_err("rule lsm \"%s\" not registered", str);
>>> +	}
> Specific IMA policy rules could be independent of the default one being
> initialized here.  Probably "ima_rules_lsm" should be renamed
> "default_rules_lsm" or "default_ima_rules_lsm".

Sure. No problem to change.

>    The pr_err() message
> should indicate setting the default rule LSM failed with an indication
> of which LSM is set as the default.
>
> Assuming 0 is guaranteed to be a valid LSM,

Unfortunately, it's possible for there to be no LSMs,
in which case 0 won't match any LSM when the hooks are
being invoked.

>   then something like:
>   "default rule lsm \"%s\" not registered, using \"%s"\", str,
> lsm_slot_to_name(0));
>
>>> +
>>> +	return 1;
>>> +}
>>> +__setup("ima_rules_lsm=", ima_rules_lsm_init);
>>> +
>>>    static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
>>>    {
>>>    	struct ima_rule_opt_list *opt_list;
>>> @@ -356,7 +371,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
>>>    	int i;
>>>    
>>>    	for (i = 0; i < MAX_LSM_RULES; i++) {
>>> -		ima_filter_rule_free(entry->lsm[i].rule);
>>> +		ima_filter_rule_free(entry->lsm[i].rule, entry->which);
>>>    		kfree(entry->lsm[i].args_p);
>>>    	}
>>>    }
> ima_rules_lsm is initialized to 0,  If it isn't guranteed to be a valid
> LSM, then ima_rules_lsm_init() needs to be called from ima_init.c:
> ima_init(), so that it can be reset to an invalid value.  Then
> ima_filter_rule_init()/free() could check it.

If there is no LSM in slot 0 that implies there are no LSMs
suppling the hooks. Since the list of hooks to invoke will be
empty it doesn't matter what value is in default_rules_lsm.

>
> thanks,
>
> Mimi
>
