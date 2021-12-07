Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18D46BFC8
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 16:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhLGPvx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 10:51:53 -0500
Received: from sonic301-37.consmr.mail.ne1.yahoo.com ([66.163.184.206]:37943
        "EHLO sonic301-37.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234065AbhLGPvw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 10:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638892101; bh=c50PxhgkifEBKvSf42ye2srD6/J21pyRHgSE2Y42gjk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=eBMImGt1OFFrQv/97fEf0ICxfBXm/UGRkz+Cb+wlcxiFD7THNj2Bf0Krvh9IBVPzHLz6MKQVXX34dzlxIDbg74eDneSKeZQ/yPNHH9kU3vdZGPCVk8InppcQ8xphpQMCJ2lRpFZaySCEwvcuc8Vuuq8Y2h6+rO2r3i7Lg0H/FG7w/xYPwRNBNLWYVZSAovhJ+rrBS+/W3UxraB4Afl2eY2KApDv6454ztYCEnBbmt5b4DoU+1XZpXyiGHYTInoL2M45jGt2iGbVq4mQBMtgFrw8F4WWK1Sngud5rMNmt+DvERBUtxvWXROAdA/QFHsp7Aa5Km0Mm/EFrFnY2b8l7Vg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638892101; bh=AD4N1mjTlCfugkXGMahialb0i2UiAu7Sst4+3KxtdJH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=n6suwkgfzPJLaYILyzUn+E8N2jzmcKfyDyxgIyxBdnqSaWb+ecGOoHotL8UK/Sc/5WXfyk1XY5ALkY+32zEqOwbOV+vhTwiGy4LBScrGPkzlRLwxukV8a6fNnMEYvQ+kZ1ttOR7epIh02JOIJ3eveTbldyzIxjB9O8JIDCavbW9PP6sUtPbqZG6T492uIrf/wJoYHPlXxANRJwR0+VjsDC7CPnmIlCH9f2YHsmVn4gSHlo06KZffdvOG9B5Uf8zMSGpNiV6K1s6F//+Pu4TwTuuPYq+XOhN4fOVIvW90dHbeJN1gYHCRahSolGto9cXWHNH4Rk/MGj8HdHA0sVevgg==
X-YMail-OSG: th87m.cVM1kv5x4G6JiNf9nMm3MzNTnS23vbYkYFwZrW32UMTclGc6V1.lYNLP4
 MvhT9GLx69xGUhebHImLIlrM0pwS8R9QsqpFHSOQVAokZNgLZ8gVPuSilqFqFtqs17K_gv8nJi2H
 xusOOM5oiXEsRBl.EgW76Se1vZTMZp98lHVQf.YybZniMUav6gDbH0qLxVJ_rwBmT.MjJPS2b_JI
 _A_CRXj73ISXxn501tyH0ZtwgIlDYRzWcLLj_Yy.hjb9Cm8mGA4DB66y9D8ceG7F8B624eRPOFq8
 NOuVYk..SH2iLdHiZiyv_OKByCWizowyX8eivW8tWA4I_O2LAy0pS.G2o6MidFXyciDsLV7mB6Hn
 YUU6gZn9nlkN42sNldgkg4fXT5J4xL4YNxXduFZ6GlcLM1fdiS8Jxave473GjQDVCy.KgjVJVdLv
 3XxEDK45hr3QFZ.aNmyfCC54kR14U5ZOQnyDS9MPXn0prCWJqef.IQx4nddeuUwfG_v8ljpg9Sqo
 8kwcMF23GMuafLjMvJOqnnK4LfkdAs2B2MMYoKv0MuChpT7qYvFn.CrCGFxd7aZmHEbTYHFcZ5aL
 vAqoD6aWzTMJa4JpVugbQBk_48A3jI13AdrjfpplploXrg0eYF84BjLkevL8Iqj2UggsX4vPW7lt
 Gwl50kUkx56mXAWqiy3MLQZAsZO6mwB4SVbKIHNjtUmChxtS95uMrJBCmYNhgxkshK3XFW94dwtO
 VdXJMrrdIzcS6kgPbaUiolRxtTFPjg.1YyKyCpuQe1qFXjPWgFs2bsakhBKeEsPkL5dntRZ61ldN
 ZlvfqAguhtem2rA29SM4.OuAoefT4t_RabRypxL0JA9Ym5CbMA85LQ7B_UIC9sXyQyUkMPkVcUYw
 koGBGALjMrxQsiMqCytsEiDEaq4JKxRcBX5jfuLxYT9wK.c6j5XNAEJSwhxt_we62y0aFMHqm_EL
 b1Q2Omej2aTKVyhiWqxc3B7C5m_otig1coz85y7dJ8RsG6ig9WHfAeDqiWNgiKGddwyZSxVTsrsl
 NXBmDITqsr_QujAC_88L3GH.eqkEuKbmgUfLbWXNPV6wXgbRwanv9OUuEXDfoyCSdhaL2FzbvSsS
 D8AR0.6IjH8s2R4bh2VHKaNUQVeLwtCIrjBCLq7oe5T8dtvUQTW.CKUkw2cjOdh0jweQmLHYDA5n
 gozaAb0VKLJ6gnp3kA.0WFWLychXvfmbhqh5fUfAivn0krXz7KqNd4En.VCd4yQn9mcraiXxX7nr
 9Wn52EUjcD9MKFuOsjOxdhjatzB_msv8peQ.aXsu6hqoLj9ZcP2b5j.BQTwsye29q2ExfTm4fFox
 41PLQ3vfmpWGZF31soSVZZ2PDca2emUrqe4JvkZSfRClP45_aQ9KHLaHvIyyzwbFMYEDQC.GWR.R
 Q9jKwwnHR8nwywuIhaH1Bk6Ntd2EcuXTDoXOlRt2YDUZOshS6AkdraocWmniN5JAN2lH0o_owvnV
 qn7PxseFUD8Qy4cpBVMFK5Ayug9Tbt1DTFiIMhoNG7sm1okXGtPdh_fte8Vt4ZP8_yJ6avavzBze
 6M_6jOvwteqQRMa0kjkfpmLg1j6VTkNNMe5rysfwkmdxPX.E2ssPYTNFeB3zDmCCsBzZ86EmAgal
 qtuy10V.U4Judz2Z6U.mjh0JQ1D8KkE1ZIkNG7KJ5dQ6xko6wmuHgP7iZKNXeHR_Y0wXQ_oaU5_8
 6IWbIz5dBfwMXT6SlwjdXCrAQRk_l6rzURNjqR96UGXusk7gT.HLvxxtUxvDM1Nz_aDzOSNPkWzC
 4DVCxQoA5eruOasTMRMQZfiJ.Ff3U.5fQddo3fDzNABHYtEj6yhFd3V4c9Ji6I0teJNRlqapLOYR
 5MyEFj_.1DWqmpWVfn9J2ajZ_CVP3.rG3QPFfEIOGm1xvNXNN4d0FbJVO19qOLVYAIeGmfA_Eojs
 Ijd0_i8Nrr.RnRSTCpr1XSY9dCqLOlM1fd2feuM6rosRbR57BgSc6A72T3tRYVrH.eqeiFgqsU3d
 _noajpEBuhMnDXek_Cms13sZPYCtQWErNCEzoXhMVdE_IXdO2X.6QDcciZB2VVcVs0i8ZygNzGmr
 JIK2xWfFIjczkP5KzGtMI24yjK5K0SiLgwsWQao3wt.X2BHITocJfNG7Tm7MVG51qGGn7C2Ktjfl
 omaGK_MIFIK9atgpmjqjzSfUgeMiF67CP491BBq3KCRhNnrCCWZ2NuQyblAnB5ze31YPMRXtK_Eq
 DgStVgVxi6V5yTdgM5.x8mtGcscpISHGCQdtokYHanoeQocSGGVjx7pVK
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Dec 2021 15:48:21 +0000
Received: by kubenode516.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2e339e7df98a729bbb7bd8cdb33e9136;
          Tue, 07 Dec 2021 15:48:17 +0000 (UTC)
Message-ID: <edaa3e45-77aa-602d-2b30-66ef9a0a7161@schaufler-ca.com>
Date:   Tue, 7 Dec 2021 07:48:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 00/16] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
To:     jejb@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
 <97ca7651b7ae9a0b6dce4d23c76af266fbd5642f.camel@linux.ibm.com>
 <20211207145901.awiibdgdidbshsbf@wittgenstein>
 <10fa531054c3b9e2a02ceb3dc007fa50e1bae1ff.camel@linux.ibm.com>
 <8491f76d5c8923f35216f55c030a68f478a0325a.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <8491f76d5c8923f35216f55c030a68f478a0325a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19415 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/7/2021 7:40 AM, James Bottomley wrote:
> On Tue, 2021-12-07 at 10:16 -0500, James Bottomley wrote:
>> On Tue, 2021-12-07 at 15:59 +0100, Christian Brauner wrote:
>>> On Mon, Dec 06, 2021 at 04:14:15PM -0500, James Bottomley wrote:
> [...]
>>>>   static int securityfs_fill_super(struct super_block *sb, struct
>>>> fs_context *fc)
>>>>   {
>>>>   	static const struct tree_descr files[] = {{""}};
>>>>   	int error;
>>>> +	struct user_namespace *ns = fc->user_ns;
>>>>   
>>>>   	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
>>>>   	if (error)
>>>>   		return error;
>>>>   
>>>> +	ns->securityfs_root = dget(sb->s_root);
>>>> +
>>>>   	sb->s_op = &securityfs_super_operations;
>>>>   
>>>> +	if (ns != &init_user_ns)
>>>> +		blocking_notifier_call_chain(&securityfs_ns_notifier,
>>>> +					     SECURITYFS_NS_ADD, ns);
>>> I would propose not to use the notifier logic. While it might be
>>> nifty it's over-engineered in my opinion.
>> The reason for a notifier is that this current patch set only
>> namespaces ima, but we also have integrity and evm to do.  Plus, as
>> Casey said, we might get apparmour and selinux.  Since each of those
>> will also want to add entries in fill_super, the notifier mechanism
>> seemed fairly tailor made for this.  The alternative is to have a
>> load of
>>
>> #if CONFIG_securityfeature
>> callback()
>> #endif
>>
>> Inside securityfs_fill_super which is a bit inelegant.
>>
>>>   The dentry stashing in struct user_namespace currently serves the
>>> purpose to make it retrievable in ima_fs_ns_init(). That doesn't
>>> justify its existence imho.
>> I can thread the root as part of the callback.  I think I can still
>> use the standard securityfs calls because the only reason for the
>> dentry in the namespace is so the callee can pass NULL and have the
>> dentry created at the top level.  We can insist in the namespaced use
>> case that the callee always pass in the dentry, even for the top
>> level.
>>
>>> There is one central place were all users of namespaced securityfs
>>> can create the files that they need to and that is in
>>> securityfs_fill_super(). (If you want to make that more obvious
>>> then give it a subdirectory securityfs and move inode.c in there.)
>> Right, that's what the patch does.
>>
>>> We simply will expect users to add:
>>>
>>> ima_init_securityfs()
>>> mylsm_init_securityfs()
>> Yes, plus all the #ifdefs because securityfs can exist independently
>> of each of the features.  We can hide the ifdefs in the header files
>> and make the functions static do nothing if not defined, but the
>> ifdeffery has to live somewhere.
> Actually, I've got a much better reason: securityfs is a bool; all the
> other LSMs and IMA are tristates.  We can't call module init functions
> from core code, it has to be done by something like a notifier.

Err, no. LSMs are not available as loadable modules.

