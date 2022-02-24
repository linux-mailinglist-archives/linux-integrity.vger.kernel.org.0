Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DDA4C3509
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Feb 2022 19:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiBXSvp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Feb 2022 13:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiBXSvo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Feb 2022 13:51:44 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D14B18FAE9
        for <linux-integrity@vger.kernel.org>; Thu, 24 Feb 2022 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645728673; bh=fGF/EoVhODCigYV54NcDHM73XhMtHJ3BGOxKAblacms=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=c1yy3cP3Yxrr0acUmDfynbEv2O+osnOxJlzqLcrLIWzTPfUfFyJEVIVofNypNoxvCjtNM8LD+9qRM8WfpRvzjFCptAR+JAABSfT7lO2RXZQzVYZHsZFY0e/krcwzGzdnZqr0rjxlsVpuYfyiRczMa3sck3oGcZ1Gd0fifTpJDMjEHwKiMDdPXtDMPwoIbjHLNrJUQU3qBJyefpLXOsv1E8yJW8UEE2+ymM3wnEGFPWAp0QL0vwMAhmEdTY/SATiLURifNeYxmDrEqdXgbUlrmgViAC33W2tTchyxUAHxmp+E4x3qyw/uwaEI+zCSMMBhc1AddwPIy0+fwRlgK9PoQw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645728673; bh=OsSEL5s3BmBPYr+G6uYVI2zmjSywNBElDggcAMzbT3e=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GeTziScyA1/iRhS0gm7zomSYGaeUnbzNiq9iMA83V9Oc/FKUzQR75PaUHaGgMJ0S5zCgYQK7altcKAgTbcHnSYtNvFgevwdKLLVB1AsuDnYhNlixvUZUM5MhjLdOQiVQTOvMa9Zq2Jp6sNxIUDt+S5N5et2hQJY2FOD0/FxBbPq5ecB1Q+gweE21CTQ7MbEiObO7elBYVqWQSGGNtIDpKmrw24mNOzlvySSbFTlosHPdQgFLAL7V+iNVbbKTAyoMy4kSz/oWVgJftfK+2EdYyd7k6/Fh0353BNCfewpL8KSxyX6RKfTSNpkgxxbfnwPPZx4uXptqNBn4O3LWbjYqgQ==
X-YMail-OSG: ShwySLMVM1npCShlrpBxlUgFG_NfL37SbrOSYlzQB7mtnJi7JnHBF7JL8c4sPEg
 HPS.KLD15BmkCOoX3A.00e4kInORhrX5ziWPGOVFbuBMNieUL1iufJqTYuSo0ykQzt2iOTMvrHDT
 VPQ3e5pcBB3hc6RYFNmHASh9.89GNos_qJxoQTFjS4JTnhuWf9VqFEarUDetPks8nwOQCkGf0tVf
 0GjJXyQT7zHpQj51YCJ.uJF2gvRxqPj7BxhgxdFcQIOSS.7HhdYRVlMHkGKNC2JD1hYZemcleQ.g
 PrSZEGIjRjzcbqs55wqw6syJfTT.UIpYP8lbHR1xYdTNVwGL46F2PsqZbozmswDULOF8Hkoutbkw
 S4jUwqEIWVXXykhI7MigLWej5wPrFyCBW1g67khKDVo4pyrFasTp2TzacMyJflYHFR3fAZ8ZNpng
 FKTdc2oJ0Aq4a._OogqjQQq89zFH1SmxRREls_nlcnOd.YquhzIRbfHx59xRVKw5Cng9nEiMfeQo
 iGCPbQ4LA5p.qyJh5fDa5DjXZ.67T_2quJwsElovUuuacU2yJSG7xn6TqJDABignkOvyg996SbdW
 PYkvsENCGBDrtys2DDSWhwI1TiOo6IKDdDXbAmFdfhITqi77Dn6ScFG48OU8OsZIDlRvBoL3dKmh
 hcXtCHuU9rWGmUqRxlc1nZmgb_y.FnR2Bp6Q1Exm.NxmnzoFTOdI7fBADnmroLxpbok3qw4i6IEH
 E0Rms6Rp9em8a2_A3sgC7Zo_MNWdk.jD6LUAGK_KIN0Lw1cKV.4ZY_bacK5WaANydPymqnNsdGuh
 A_QhVHHwx4JUC.ocCnCJq9qGnH2QPyp4la6sVsDYJvWHhGqH6OGryDJtOGSzH3Cr0s7Y6savbijf
 uTFTjwHLNIcmMs1YZ0jY3q2v_cduy0ZRR_MAhzfy9bkNa8l0e9Q5PNlWtiRyWLOXFXfhZz94.k5i
 EqBgxH1syiCCPXh92ucQbUY_xE1Ypenjo9yaWUgGDRDw1Wj3YINUPXaZfp0frtx5nOf6lCpOn7CJ
 EzYU.smotV80Z5jSp3vEzFx0MrM7rFzx25nv52T_CkXRPg6zb8Fhf4DggenfdvFEQgRUeS74I3Qc
 79BwTIStvFDiCsSd.L1Gc1nj0eCkI3S9VtPbQUY9BkXDmx7fVQlPEYSGD1ExFQO2.EFgk4R89.dF
 z32bSUXeG.jdYI8zxkjDW0usdv8B60Aeogm9qxFLS.8f0fJS3yMxL83kO.Uh2ZmOs2Tra8Xhslcf
 L3ox5ZNW0QgzbgD84hyorWnpwZtGaYPdRGA_KjWW_ODSfUVzcSyrrHKhS5DfWXxzXm15qZT74A2f
 3prHMk.NFGIFXp9MOTv7asbb68OZKMN4LcyAUNoE3xiJlNswtcFHVRh6FnbnNKmHRgBLwt03BjZf
 HwofRK.nzoSmnhNsXXednbVULZZcwXd5CivVJdwmjTSx5yH9Whn5TI.GFwG1dnBJNbAjs4Yf0lrU
 T.WSjSumRLXrGVZk_04hvc599usQRAKftXWgTc0nyPA2knQV8W.S0qpxVGedDPeYB.2K2esQTg_w
 87hgVSF2Q67RYkSdfZxYUn0lEsYC7jTpqGejuoMfsAogIfZxKUz7s3Y3PNvJL6a8JQ6JoJ.cFbe.
 PkN15rrPnH_cAVS2NRjk823_HRwJDGH48VVZL5LMttvW3pLf0xN7zQVBNhkQwY3aS8aJ5kRlbidL
 kTxA.SbtvqInF1bFLWOiAjULgOyt3WuCMUwIvxE5_z980YfilrTSHAh1_dV33tikcjn6WpeGVYk4
 DhsF1tTOAjuQrQwlPP4yT3ctz4.JWl0PepERt2Bc6.lDEu2UcTPE_1g5..Z1fN_j0R6zNr0MgrOq
 _Z7yfG_yZ7BIJCH3QYBLNXz36y3T56yKiF8TA7qjK4f0vTsU6ld6.kTkbdoi7_kGjnewwrbEoiKK
 rxX5IG2i7WpZH6o3PZ3eNIasAGsxanUe_6sziW9S_LAOB7rKxYPSt4hruHLCe9WCj8uj6x7zpvbd
 ahgQHEWpBCfomVu2bszy6SoOrbTopi7lXed53LesQFKY6ucxiv_a_khSVU0mYwrMxc0t_cewwUXy
 RsKPiLLGFjOJVdkC7rd2i4RTmGUYhKncwpUE_0Fo1vd7.JzPsusl.J4q.cnazgC_3HHx6pyDLHiO
 CF3adUtdydZV6tpQ5Bi0B_oTX9hFIxwFckg4P2nBS5O9GDzSzXsAA1LK2.d6IpAw7Uv.6lcOo0.H
 wNAASIkdsmkF.RQiiIE9o9rNp5IgC6FM8DtpLtW4ggaeeOSzubtlGecNUwmSEDBZgMO7IQHYD
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Feb 2022 18:51:13 +0000
Received: by kubenode516.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5ae05b396aebdbf3fb66b680c61862d6;
          Thu, 24 Feb 2022 18:51:09 +0000 (UTC)
Message-ID: <9405bcfc-78bd-8e7f-41d4-b919221f73e4@schaufler-ca.com>
Date:   Thu, 24 Feb 2022 10:51:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] integrity: double check iint_cache was initialized
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, dvyukov@google.com, ebiggers@kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210322154207.6802-2-zohar@linux.ibm.com>
 <20220224142025.2587-1-pvorel@suse.cz>
 <418628ea-f524-05a1-8bfc-a688fa2d625d@schaufler-ca.com>
 <YhfDhYQYZTU0clAf@pevik>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <YhfDhYQYZTU0clAf@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/24/2022 9:42 AM, Petr Vorel wrote:
> Hi Casey,
>
>> On 2/24/2022 6:20 AM, Petr Vorel wrote:
>>> Hi Mimi, Tetsuo, Kees, all,
>>> FYI this commit merged as 92063f3ca73a ("integrity: double check iint_cache was initialized")
>>> is the reason for openSUSE distro installer going back from lsm= to deprecated
>>> security= when filling default grub parameters because security=apparmor or
>>> security=selinux does not break boot when used with ima_policy=tcb, unlike
>>> using lsm.
>> OK, color me confused. Integrity isn't an LSM. It doesn't
>> call security_add_hooks().
> Really: "Initially I also questioned making "integrity" an LSM.  Perhaps it's
> time to reconsider." [1]

It was always my expectation, which appears to have been poorly
communicated, that "making integrity an LSM" meant using the LSM
hook infrastructure. Just adding "integrity" to lsm= doesn't make
it an LSM to my mind.

>>> @Kees, @Mimi sure, people who use ima_policy=tcb will just remove lsm parameter
>>> or add "integrity" to it but I wonder whether there could be "integrity"
>>> automatic inclusion when using ima_policy=tcb. Although the point of lsm= (and
>>> CONFIG_LSM) is to have *ordered* list of enabled LSMs and it wouldn't be clear
>>> on which place.
>> Why would adding integrity to the lsm= make sense? It's not an LSM.
>> Sorry, but something is wrong here.
> np. I explained that: try to boot with "ima_policy=tcb lsm=" or "ima_policy=tcb
> lsm=whatever" (whatever != integrity).
>
> Also have look at commit 92063f3ca73a ("integrity: double check iint_cache was
> initialized") which explain why it's needed.

	"The mixed metaphor never boils."

What is bothering me is that IMA, which is not an LSM, depends on the
LSM mechanism for specification. Sigh, I can see that boat has sailed.

Since IMA doesn't use the LSM hook mechanisms (doesn't add hooks to the
hook lists) it shouldn't matter where in the lsm= string "integrity" is
or where in CONFIG_LSM it appears. The ordering is only relevant to the
"registered" hooks, and IMA doesn't register.

... except that it shouldn't be 1st, since "capability" is always supposed
to be 1st. And it shouldn't be last, because BPF whats to be there, and I
can't say if their user-space will handle the lsm string if it isn't.

> Kind regards,
> Petr
>
> [1] https://lore.kernel.org/linux-integrity/3ed2004413e0ac07c7bd6f10294d6b6fac6fdbf3.camel@linux.ibm.com/
