Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E92C466757
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 16:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbhLBQBk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 11:01:40 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:33020
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347621AbhLBQBk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 11:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638460697; bh=nlCAWenUzyZHS9v5schkQlPVcQORjza3kU4gz0S1uxY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uV6rE7vaIKuo4+MECwaFSHeIr+jEW9NKgeBAkoRgW7yjZz7t0ECqDkRBdH2Y/ckT4FPMcFdDfricn44tbSrW7WlpdTcgToSVM9tU/ECe0uPQud4eX7ktV77BlF3wuTUx67cx6VlLGWkuDnlAWlxI0l8zDYKW25lu5AieEAsEkp6amvmDqgtRxIDGeHqZjr92NSs5UTTbNeIT9uSS9T55HG/43NmEL+IM1LhDU+CC9XFacvCxpeQjwpijWQ/+Wq0X/WcEJPXUCHBkGivoHrfUVvxY0Vggr5g4RpbdvM9SdMTlUB0zxwjC0YeSPTdf29CbfstjmMY3jQk8qJotsoVseg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638460697; bh=SgwL7EEAdOYCW0unUvfgOKXPtToCFHEob10+bBvuepd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=C/WXOOgCcbu2YdnFa938oPyjI9ZETvd2GG/82o+Pnn/ewpjE552sEzcx13Ee+FI+AoG7ppKzI0yBdTESVQGAUTkp649qN1/NvSwFv4ckiGoWSkOmuTNvMOj3bqdrGbJ+kb6sEmuS1zkDh4CbuwkPY0ThRKWwnY6pPOo3Ovk/mhCL3XHWVmWJ8YUkQmlR72pxXawCmJOWVVLHjEQvvc943HBNm/Yrm48u9dMmOQL4xqEaK/1P35PHWgRiAlAkO5JiQqJTrAGZhOXJ8CPhj/aswvZSND+6Km/pMWc3GRjwX5mx6GizdbiMZnpNaKc59ZlEwioVnJ9hFhtC0ae5XkRYGQ==
X-YMail-OSG: cFZM2EkVM1mnmh_OY6rFAY.ec1NEk_hmSJLcMeMZ8tkQ1S7RkcXXGJgBqJgz5uV
 L5C.UpC4RqZYiID3SSBDvRayvAM1ASPBSOi4K9iePIlK1_ZW68tPWAwqKDoqMVnCo8l2T3V1xfEB
 OY2kFgLLIzDXe2n9UyzkTvM1BGaPi8bb9ywScEARmYfPXSv2jOmE3yNtZdFI0CxEwX._kaXOMlq2
 PsxQmn_3uWZnTTeF7fgvA.Ibeb5aBtah24opQFJAAkXalXj6P.myoiNSgarnx2dteqch2K7Y4j9p
 iocbNsBjyzewob1BuivDkFNRmVjj4jo_ssdW_LLMN6easOmWM6iTwBajhtm_N9QTnFM.cNx.PRHi
 52tSkmoKK8fuJEiJpdWN.26CTsN_7qFc2r7aCpUxF5iFnol8dQmSOg0ZdiSNpD82eJVCGD.UJvbo
 2DZVtnCKWEykqtdCLN2iZD6GotvMUrc_vX5LFL.GlmaECCUW9iMXUwE7fRmBjUm0hBuwwS9e.tkT
 sUfeubH1yuHMu_vaHNKze3n5XHsFT0PmxwVPvv32aSjco.1YKs46mFfvK8ryXDHipP4psrEhyqad
 bt4KMYpOSuW.JWzdFnPDSK8KNNGNxA_NrM3ZVmnzwvpmlxDB7Tyzuc8o1gjldAX9Q3tZgapvhkBI
 GaKWglEvG9H6suwJ1.gt5r1Exzic7S9_JnNGQgwqUJ.tPK.snjRqkowN9AUr6PWgVFv1bMQy9ltt
 Z_Hxp622zQ7a79i33_64tB0m7C9ldEMGJ_iiPZ9dWZapDleoXC7dh6qTBISfJ1lRZH.CS8v5ulJ6
 KvRsFs_zje_90g7gZg00b05c4NA73cM1wwhnwRgHFZhPT1AImNqAGFWHsZ4I13qRK9sZvIGbV_Hp
 V45Pfu3QykmC5ptj6YABckMuVyMkpXiqW4pg7Ucxi_SFRAGlrkhKKxv.qCXPCupN7EHkNvzxiNDP
 f7sa0RShTb1kotXHAuE4TLy5nUTvq2SBofjJ9DH9t2g4E.7Ff5XmvGXaM8jdvhQQOqU9CpZR2Hk9
 _5aiZBJOFKGj.Pd3Zd8.V1eq.qPAvZfNlEy6Fp3R7T4pGPn0pKFVeFDRiPBzarKm5s8MKLQKJWeV
 J7_C_cWG8a5g_8vMa.Y0V02sQQzlWYWTgCSEaDIeehFCvMg6AoTBu8hsT2._nDLLE1H_k0JGcOSN
 I5UIM3_Z1rR28AOc2x34Nhfik3QxpPNfX6R9dw8cS_xYi5LlvppgR6YjVho3kmmNcbytv0b440Lk
 AbeeY0NxX09W3LSLgFgGyWT3cskHFnDIUMeYp_ee0sBI9BG4RbVFXeW16xfKGTBWpNSMxnUHj1UV
 lE78CwdqNYhjYhTaLmRd.KcWJfoJvrCjMYN4rfpvtU2o2MeSXT4qnRcWIvl98WUTs87iSeyY344U
 lj4BtHdavLf93JpE6m2q8J7qtRvpadXGXm1_2Uy_GU6nmrW5nmL54TQY0Woss2HlN_Gi5QirHbyZ
 D8LlCyO81Yy9dvJBkByuC1HYH3zVTjodW1NBuZPqa.ICY7UXZyeuD0haA98iGDSwVK7MjZ3Mzfef
 uJXuvaqC7rQH8tw98_BWadovcZo8uyzGIro8QIJzKxwrowTSb3RH3jozpVBeVjfzv5hL0uKoLvMQ
 lTqFKEwN.f6n9RMBdVBNTQJbYsWxNFyIWhhmIh6eyweSh2lf3Z0iicXBDUfG9eutG4yWySl5fEHf
 AQQt_ImigcAW_Ve55tjqlgeo1aomB4mDNGDCO3lT39JU12XXf2TMjJxtLZ5fjtvYIGezVfI095HV
 KyzQ8tYPj2.tM4GXNoMVlc6ovVBEsJ1C4rKmI_CwZmiHJbBbdUri1zBLuv8AAQlfgw.0Hxwzy0y.
 IucJQ3paU2Y0aJxNAlP.KJHq7CO9brcDWZfh_O80cLrxTy2_mkoIKRfRf07YWpl7zizaYYESQdlz
 o59TWgGF7cAt06op7XycUUnkXNLV.IVfBNlF8xuahMfAGwH.ukyLkejn.sP0iN5B4.7McDoO9qO7
 dAQSBxECWPpZxBYEMQsHBYZFk4NG0XH_nM.7dDGrFXynCHFC.TFNj9AOy2ndeatra9At2TaaaDNj
 mb7EaMGCyREyuiuUxoT.Eqpluaqgl2DN8bgeGBynDbPdnK_vViprqCUuKwRjW7XjDOJygwkzjnpf
 HEqM_XZBQCOQ2I2MNBjV9y4ziLgUDwWCpebyv834s1Poi04eUi8eUuob1RNm2Tp.Po.mM1A6jGBL
 tXxvZBqyJoep_cXYAVwids3HTwCYO2WwpzFGRBHKaFCDZf7X6jY4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Dec 2021 15:58:17 +0000
Received: by kubenode528.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c4c04d9609476e39968ee243e8acedb8;
          Thu, 02 Dec 2021 15:58:14 +0000 (UTC)
Message-ID: <63d4dc72-52ae-46ff-3996-3b80d41f4978@schaufler-ca.com>
Date:   Thu, 2 Dec 2021 07:58:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC 17/20] ima: Use integrity_admin_ns_capable() to check
 corresponding capability
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-18-stefanb@linux.ibm.com>
 <7c751783b28766412f158e5ca074748ed18070bd.camel@linux.ibm.com>
 <34085058-ff5f-c28e-c716-6f4fa71747a3@linux.ibm.com>
 <4b12309289c6a51991c5062fed0fde03e0a6f703.camel@linux.ibm.com>
 <20211202125955.qcmmnblit3nmatdo@wittgenstein>
 <20211202130110.ij5h3o6mcbqscjqh@wittgenstein>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20211202130110.ij5h3o6mcbqscjqh@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/2/2021 5:01 AM, Christian Brauner wrote:
> On Thu, Dec 02, 2021 at 01:59:55PM +0100, Christian Brauner wrote:
>> On Wed, Dec 01, 2021 at 02:29:09PM -0500, James Bottomley wrote:
>>> On Wed, 2021-12-01 at 12:35 -0500, Stefan Berger wrote:
>>>> On 12/1/21 11:58, James Bottomley wrote:
>>>>> On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
>>>>>> From: Denis Semakin <denis.semakin@huawei.com>
>>>>>>
>>>>>> Use integrity_admin_ns_capable() to check corresponding
>>>>>> capability to allow read/write IMA policy without CAP_SYS_ADMIN
>>>>>> but with CAP_INTEGRITY_ADMIN.
>>>>>>
>>>>>> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
>>>>>> ---
>>>>>>    security/integrity/ima/ima_fs.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/security/integrity/ima/ima_fs.c
>>>>>> b/security/integrity/ima/ima_fs.c
>>>>>> index fd2798f2d224..6766bb8262f2 100644
>>>>>> --- a/security/integrity/ima/ima_fs.c
>>>>>> +++ b/security/integrity/ima/ima_fs.c
>>>>>> @@ -393,7 +393,7 @@ static int ima_open_policy(struct inode
>>>>>> *inode,
>>>>>> struct file *filp)
>>>>>>    #else
>>>>>>    		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
>>>>>>    			return -EACCES;
>>>>>> -		if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
>>>>>> +		if (!integrity_admin_ns_capable(ns->user_ns))
>>>>> so this one is basically replacing what you did in RFC 16/20, which
>>>>> seems a little redundant.
>>>>>
>>>>> The question I'd like to ask is: is there still a reason for
>>>>> needing CAP_INTEGRITY_ADMIN?  My thinking is that now IMA is pretty
>>>>> much tied to requiring a user (and a mount, because of
>>>>> securityfs_ns) namespace, there might not be a pressing need for an
>>>>> admin capability separated from CAP_SYS_ADMIN because the owner of
>>>>> the user namespace passes the ns_capable(..., CAP_SYS_ADMIN)
>>>>> check.  The rationale in
>>>> Casey suggested using CAP_MAC_ADMIN, which I think would also work.
>>>>
>>>>       CAP_MAC_ADMIN (since Linux 2.6.25)
>>>>                 Allow MAC configuration or state changes. Implemented
>>>> for
>>>>                 the Smack Linux Security Module (LSM).
>>>>
>>>>
>>>> Down the road I think we should cover setting file extended
>>>> attributes with the same capability as well for when a user signs
>>>> files or installs packages with file signatures.  A container runtime
>>>> could hold CAP_SYS_ADMIN while setting up a container and mounting
>>>> filesystems and drop it for the first process started there. Since we
>>>> are using the user namespace to spawn an IMA namespace, we would then
>>>> require CAP_SYSTEM_ADMIN to be left available so that the user can do
>>>> IMA related stuff in the container (set or append to the policy,
>>>> write file signatures). I am not sure whether that should be the case
>>>> or rather give the user something finer grained, such as
>>>> CAP_MAC_ADMIN. So, it's about granularity...

The important rationale for capabilities is separation
of privilege from user id. Granularity has always been a
contentious issue. Whether you use CAP_SYS_ADMIN or CAP_MAC_ADMIN
you are using privilege, and need to be diligent.

>>> It's possible ... any orchestration system that doesn't enter a user
>>> namespace has to strictly regulate capabilities.   I'm probably biased
>>> because I always use a user_ns so I never really had to mess with
>>> capabilities.
>>>
>>>>> https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerations
>>>>>
>>>>> Is effectively "because CAP_SYS_ADMIN is too powerful" but that's
>>>>> no longer true of the user namespace owner.  It only passes the
>>>>> ns_capable() check not the capable() one, so while it does get
>>>>> CAP_SYS_ADMIN, it can only use it in a few situations which
>>>>> represent quite a power reduction already.
>>>> At least docker containers drop CAP_SYS_ADMIN.
>>> Well docker doesn't use the user_ns.  But even given that,
>>> CAP_SYS_ADMIN is always dropped for most container systems.  What
>>> happens when you enter a user namespace is the ns_capable( ...,
>>> CAP_SYS_ADMIN) check returns true if you're the owner of the user_ns,
>>> in the same way it would for root.  So effectively entering a user
>>> namespace without CAP_SYS_ADMIN but mapping the owner id to 0 (what
>>> unshare -r --user does) gives you back a form of CAP_SYS_ADMIN that
>>> responds only in the places in the kernel that have a ns_capable()
>>> check instead of a capable() one (most of the places you list below).
>>> This is the principle of how unprivileged containers actually work ...
>>> and the source of some of our security problems if you get back an
>>> ability to do something you shouldn't be allowed to do as an
>>> unprivileged user.
>>>
>>>>   I am not sure what the decision was based on but probably they don't
>>>> want to give the user what is not absolutely necessary, but usage of
>>>> user namespaces (with IMA namespaces) would kind of force it to be
>>>> available then to do IMA-related stuff ...
>>>>
>>>> Following this man page here
>>>> https://man7.org/linux/man-pages/man7/user_namespaces.7.html
>>>>
>>>> CAP_SYS_ADMIN in a user namespace is about
>>>>
>>>> - bind-mounting filesystems
>>>>
>>>> - mounting /proc filesystems
>>>>
>>>> - creating nested user namespaces
>>>>
>>>> - configuring UTS namespace
>>>>
>>>> - configuring whether setgroups() can be used
>>>>
>>>> - usage of setns()
>>>>
>>>>
>>>> Do we want to add '- only way of *setting up* IMA related stuff' to
>>>> this list?
>>> I don't see why not, but other container people should weigh in
>>> because, as I said, I mostly use the user namespace and unprivileged
>>> containers and don't bother with capabilities.
>> There are very few scenarios where dropping capabilities in an
>> unprivileged container makes sense. In a lot of other scenarios it is
>> just a misunderstanding of the meaning of capabilities and their
>> relationship to user namespaces. Usually, granting a full set of
>> capabilities to the payload of an unprivigileged container is the right
>> thing to do. All things that are properly namespaced will check
>> capabilities in the relevant user namespace. Those that aren't will
>> check them against the initial user namespaces.
>>
>> But I do think the question of whether or not ima should go into
>> cap_sys_admin is more a question of capability semantics then it is in
>> how exactly ima is namespaced. We do have agreed before that overloading
>> cap_sys_admin further isn't ideal. Often we end up rectifying that
>> mistake later. For example, how we moved stuff like criu, bpf, and perf
>> to their own capability. Now we're left with stuff like:
>>
>> static inline bool perfmon_capable(void)
>> {
>> 	return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
>> }
>>
>> static inline bool bpf_capable(void)
>> {
>> 	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
>> }
>>
>> static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>> {
>> 	return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
>> 		ns_capable(ns, CAP_SYS_ADMIN);
>> }
>>
>> for the sake of adhering to legacy behavior. I think we can skip over
>> that mistake and introduce cap_sys_integrity.
> (Or under CAP_MAC_ADMIN as suggested elsewhere in the thread as I saw
> just now.)
