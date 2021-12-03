Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119B5467E50
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 20:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382916AbhLCTkr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 14:40:47 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:40913
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382907AbhLCTko (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 14:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638560240; bh=GgtddZpEBtDplc2DOvH8LMiL0XCFO2jo+0ec1rY8erI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iis7QifRCE5hVBrO8wTEuONpJm5x26bgt/bn+rChG1K78JdRhCEuPTITBe0duNSsMJV9T+oCwmipLK5ZxMIuNqx8Fu02BpQEtIlt1YJ72DVLbxlkJQRi1E7k/4pIFf9iSaOvLQU4f5eIYLXNuGrf4KwFkOtNASTn2peEkOZFiTdxijJUcuZaeuusSVzEs38IASUPPwOWl/zsLuXvTZLia2emaZnAsczFvV7Mv2uYyuSYBN4xIfHESWRkJU7oPIucd5VRMRiFkl3TAdyiu7Plrqm3gMAEo/ZvZvq75vndi2OD1UbHj0Z8N+eVYIS6g57Dtu4ExJ1sOatNcHSGBSbdkQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638560240; bh=+vObAazN+lFhXCy3PE0aEB14UVyJZKWADdcMthOkaHc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ojgDW5a12LY2xAN7X8rflyJ6Y+2bMn6okfeB71iN7WwOa3zXZaTd/JlOb/zJUKyS8y0gUQ993aqhOvNzNSJTb39VuvUDyBkv9kdWRP85RZPtbKNZc48IzKE0/1l2d1K/Tpyxg9R9IgTCg34ksJXS64mKCZGTs6GCbUtC8AqmzdV9Y3DzOG0fEJ9pVmukG8UwiFsBeZRI7Cj9/1Y0E3Yi11u5XLTO6Z3tmwSTcmWanpRG7H1teLAxzwA7j98RdLw2vJGbiVmHWKfJAHSIMN/hcBqE+XuA6qcnoD/OEtGslDR0RwBaT2hlx8ALO7IUROfHjA8DZNn0DbAASZwc4r3OdA==
X-YMail-OSG: Z19ulUAVM1lNKAkehqTwQepY9oCuOfWSWBKYisCDTJgrFsMpDGEIKoM26PDDN6o
 PWAKCfxyy3Ioh2FgzoyrjzKyoW18k_zWYtFg8FqnwluIjc6rmO_QAmivAWd_3nuGV90yImO15p07
 FPXJSA_E8cgaW20g9sey.0kxULgYlfHL6Az98iUz.NYi.lOQxeWnVNR0DjKZpniMl8vMLu6laDap
 2WtZ4GGPmAgsHu9BPsmtOkQBfqVKSQ5zYnXmSApDpxp6SJDzgDuqGJBg1KyR8shlxeI1FeOhsdoD
 zxy2iuBU0G50m6xY8m5kZ3sHVbcjuARTPQTSPomcDc_DPo2u34PIdgVw7O4W6cF849FTqBEZ52c5
 OA3f0MOu.NhrTQr31dw.3MaKuExioM4WzzgQDBckWehxeGawYv8N4XqP7_hM31haQ7WD91IqAPH.
 b_V3K4XNW1V7c8OLJlTNtBYhQ6S3cgux_sdzZkgQ__8QHOZ0_RQOsgnY3P9gdfF85Aj.39D8N4.M
 jwbDi4Hnk4xy7N2TJnPgo_s4_Yw01ZxAacRqgTCF4akbP7T6NFJtRgKREiOJSv8RUHtvZV_KtCkB
 h2ptUQSsg9iNln2eQII03Sb2Y13Mz.U0K.f.NoPjjT97.NbycO4.tdzECViNXlRoHR4xm3zDtTy_
 86YobExMj9VeDdVcJXhg8yNYbM59K10XbVQwYEC_yqeV5jqbR52LfCDZroZyvfkWsJ8pKiam_vAh
 xlgDSF9xyJfX3r5Qt5HlFWAtgK4lFr7Ri0KscV30Fpr4aIV85v5mbLt7fp.vEgVDWk6Fh6iggQTu
 34c_FJFrUIXaN1Uz0QkMuvbNu6OGWTGUfPPW4iZxS4k.T78Hq1O1YXSASZMEbB44YgHUbWyOh4qy
 505ZFDO.ev3oHOgUK4XbB9v4Bq_XBs53dl7jcaeLgL7_xA3Io0rrWA4ep5mEt6z2QtJT4UtZPPCP
 1r_BCSnFYRRiusS5nSgtVO80ZTPyfEzZuN_Ai3CLbQDzNjAvuHig5QI0nvfwfRRFG64cGoMYzB9v
 4I8Z5HJtbN7bsCSkWWIccgyPyUzE.fy1Nqq8m9uEieMvr._hMAwYLyRZQeWkP55f1MV7DHo_5ey7
 HcKT3TFMATjWrP4oBn7dGYkODwOfaxGXWMs73qtLU.WvwzDePPiRkfLOG7lDDXZku86UPau_2oTz
 xB785h_fpWFe4_3eyhLXX0huO4GUQqBgZloL7ylobnvCAIcb2fbj2qTMAfFCkZYpKvyvcPCnZBYQ
 Yc.SSb7MEcUnVqwwwY4FgMZIpitwmVElubjfnh4txn73UHGPvDBDEgJd8nhUTXLvheP91Qf970A0
 SLs05gbxdCpd7jUgAKDZwSxkuFis_ESURJvCujbh2mbJELJSGJNoI9fn1iw2KLbxHiUUwPvsSvNl
 fpz1Re79STkvNy5DDr5aKFMUWvA2U.4IpsdrrDOnVBlvGQzM8lwctpRsis4HMVzqxla7TcE_OwBi
 wU.maMSkQ94EcELNCuZdAUSyMwAIA6EZU0NNdQmdalyt1EUD18vPyDZOdU4PmclfkmRVCo53jWFU
 EfoRtxH7b5CXX_EobvOkctHtybzXJas3CwBzxS.dlETsVTnua_51RpIvRHXuqlXxZ8aRKrtqy6fV
 Vzd1TskmGoD2OQhTMuq8In_IsqkNPBdNY1et6mM6s1lm26L780QhDCdOcEW1GEOHzCkm0Wy4Ljb4
 8Q0eF5ic7kw56WOUCt9RmL0g4tutHualpcdE7sDiEmU_HC0UFH3unalsSBTBTZ5adbmUwYPACeb.
 hLJ9h0ZjHGLvqCldLMxfbIOkTGRC_rdQcDWUvepWTtx6TkX4pnL88GF_2GMaRqdXKg7.1dT.tTGh
 8QCHLfLpK2jZGT8uPeMfvGoCd2bbrNYAgUzScI39e4eDK3veiOMguvWMML_4QAg9sCNfZvu9KmZv
 G6ansp6t0pvDwNcs1yWWokFvGvZGmjJTuPVwkUrwEOqoAQgxXQOYkEkiR4vhkbIcakNyghPhv4kC
 sygJKXVvJkSvl0IxR6dmUL4dC20s_te04HWyNRGjaD_bscMg9py40KE5WCtYT57_6jmDOAosF2fg
 sb3I552XQwrY8jxJT0jaWRKULU13MODK5bnn6sT2up_3zXaJ1na0BhmkgymChgwO0RlW40EnhigV
 HFuDZeUUd4aSeC4xihB1sAHzxZ1sPgd.69TR4OpmYpxYBTVHsGK76wZ5pnoAS4sF_gPqFd5d6Ns_
 bHDPvfjoXcNo0nG2TVOa6FAzqY37.UNgcFXxBBVOKc___fpW_Vj4jCcCB5w--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 Dec 2021 19:37:20 +0000
Received: by kubenode512.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e14b2f3ebf61173d438fd5983e858938;
          Fri, 03 Dec 2021 19:37:16 +0000 (UTC)
Message-ID: <ed654d0f-6194-ce29-a854-3d9128d81b7a@schaufler-ca.com>
Date:   Fri, 3 Dec 2021 11:37:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
Content-Language: en-US
To:     jejb@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-20-stefanb@linux.ibm.com>
 <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
 <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
 <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/3/2021 10:50 AM, James Bottomley wrote:
> On Fri, 2021-12-03 at 13:06 -0500, Stefan Berger wrote:
>> On 12/3/21 12:03, James Bottomley wrote:
>>> On Thu, 2021-12-02 at 21:31 -0500, Stefan Berger wrote:
>>> [...]
>>>>    static int securityfs_init_fs_context(struct fs_context *fc)
>>>>    {
>>>> +	int rc;
>>>> +
>>>> +	if (fc->user_ns->ima_ns->late_fs_init) {
>>>> +		rc = fc->user_ns->ima_ns->late_fs_init(fc->user_ns);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +	}
>>>>    	fc->ops = &securityfs_context_ops;
>>>>    	return 0;
>>>>    }
>>> I know I suggested this, but to get this to work in general, it's
>>> going to have to not be specific to IMA, so it's going to have to
>>> become something generic like a notifier chain.  The other problem
>>> is it's only working still by accident:
>> I had thought about this also but the rationale was:
>>
>> securityfs is compiled due to CONFIG_IMA_NS and the user namespace
>> exists there and that has a pointer now to ima_namespace, which can
>> have that callback. I assumed that other namespaced subsystems could
>> also be  reached then via such a callback, but I don't know.
> Well securityfs is supposed to exist for LSMs.  At some point each of
> those is going to need to be namespaced, which may eventually be quite
> a pile of callbacks, which is why I thought of a notifier.

While AppArmor, lockdown and the integrity family use securityfs,
SELinux and Smack do not. They have their own independent filesystems.
Implementations of namespacing for each of SELinux and Smack have been
proposed, but nothing has been adopted. It would be really handy to
namespace the infrastructure rather than each individual LSM, but I
fear that's a bigger project than anyone will be taking on any time
soon. It's likely to encounter many of the same issues that I've been
dealing with for module stacking.

>
>> I suppose any late filesystem init callchain would have to be
>> connected to the user_namespace somehow?
> I don't think so; I think just moving some securityfs entries into the
> user_namespace and managing the notifier chain from within securityfs
> will do for now.  [although I'd have to spec this out in code before I
> knew for sure].
>
>>>> +int ima_fs_ns_init(struct ima_namespace *ns)
>>>> +{
>>>> +	ns->mount = securityfs_ns_create_mount(ns->user_ns);
>>> This actually triggers on the call to securityfs_init_fs_context,
>>> but nothing happens because the callback is null.  Every subsequent
>>> use of fscontext will trigger this.  The point of a keyed supeblock
>>> is that fill_super is only called once per key, that's the place we
>>> should be doing this.   It should also probably be a blocking
>>> notifier so anyconsumer of securityfs can be namespaced by
>>> registering for this notifier.
>> What I don't like about the fill_super is that it gets called too
>> early:
>>
>> [   67.058611] securityfs_ns_create_mount @ 102 target user_ns:
>> ffff95c010698c80; nr_extents: 0
>> [   67.059836] securityfs_fill_super @ 47  user_ns:
>> ffff95c010698c80;
>> nr_extents: 0
> Right, it's being activated by securityfs_ns_create_mount which is
> called as soon as the user_ns is created.
>
>> We are switching to the target user namespace in
>> securityfs_ns_create_mount. The expected nr_extents at this point is
>> 0, since user_ns hasn't been configured, yet. But then
>> security_fill_super is also called with nr_extents 0. We cannot use
>> that, it's too early!
> Exactly, so I was thinking of not having a securityfs_ns_create_mount
> at all.  All the securityfs_ns_create.. calls would be in the notifier
> call chain. This means there's nothing to fill the superblock until an
> actual mount on it is called.
>
>>>> +	if (IS_ERR(ns->mount)) {
>>>> +		ns->mount = NULL;
>>>> +		return -1;
>>>> +	}
>>>> +	ns->mount_count = 1;
>>> This is a bit nasty, too: we're spilling the guts of mount count
>>> tracking into IMA instead of encapsulating it inside securityfs.
>> Ok, I can make this disappear.
>>
>>
>>>> +
>>>> +	/* Adjust the trigger for user namespace's early teardown of
>>>> dependent
>>>> +	 * namespaces. Due to the filesystem there's an additional
>>>> reference
>>>> +	 * to the user namespace.
>>>> +	 */
>>>> +	ns->user_ns->refcount_teardown += 1;
>>>> +
>>>> +	ns->late_fs_init = ima_fs_ns_late_init;
>>>> +
>>>> +	return 0;
>>>> +}
>>> I think what should be happening is that we shouldn't so the
>>> simple_pin_fs, which creates the inodes, ahead of time; we should
>>> do it inside fill_super using a notifier, meaning it gets called
>>> once per
>> fill_super would only work for the init_user_ns from what I can see.
>>
>>
>>> key, creates the root dentry then triggers the notifier which
>>> instantiates all the namespaced entries.  We can still use
>>> simple_pin_fs for this because there's no locking across
>>> fill_super.
>>> This would mean fill_super would be called the first time the
>>> securityfs is mounted inside the namespace.
>> I guess I would need to know how fill_super would work or how it
>> could be called late/delayed as well.
> So it would be called early in the init_user_ns by non-namespaced
> consumers of securityfs, like it is now.
>
> Namespaced consumers wouldn't call any securityfs_ns_create callbacks
> to create dentries until they were notified from the fill_super
> notifier, which would now only be triggered on first mount of
> securityfs inside the namespace.
>
>>> If we do it this way, we can now make securityfs have its own mount
>>> and mount_count inside the user namespace, which it uses internally
>>> to the securityfs code, thus avoiding exposing them to ima or any
>>> other namespaced consumer.
>>>
>>> I also think we now don't need the securityfs_ns_ duplicated
>>> functions because the callback via the notifier chain now ensures
>>> we can usethe namespace they were created in to distinguish between
>>> non namespaced and namespaced entries.
>> Is there then no need to pass a separate vfsmount * in anymore?
> I don't think so no.  It could be entirely managed internally to
> securityfs.
>
>> Where would the vfsmount pointer reside? For now it's in
>> ima_namespace, but it sounds like it should be in a more centralized
>> place? Should it also be  connected to the user_namespace so we can
>> pick it up using get_user_ns()?
> exactly.  I think struct user_namespace should have two elements gated
> by a #ifdef CONFIG_SECURITYFS which are the vfsmount and the
> mount_count for passing into simple_pin_fs.
>
>
> James
>
>
