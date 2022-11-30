Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF74763E2CE
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Nov 2022 22:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiK3Veh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Nov 2022 16:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiK3Vef (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Nov 2022 16:34:35 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CDE91374
        for <linux-integrity@vger.kernel.org>; Wed, 30 Nov 2022 13:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669844073; bh=9U2E94RBlTMblCGWV03HjfJY5rIFmw28+geFCpPgjEk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=KdRwPc8CSSOrCgYyRF70avJ7X1aowdi1oXeRGWhZNYO0xaGcuKZB4ki2NcTeHE/2LDgv52yZfc5EBH6/Jur9dtVcHgBYtYaPsFJj8g7NkX27vfL47+k8pl8z08melE0bGGqn20wusGNmauqMXSGrk3RwIDkmy1O+9oTEdS5Y95CLRwlf+2U9NSVUTb+Na9dFb4H6vwRLGzRth2bGrHMkCuer24sAgSBQyS0je0k8ZRzXhbAn5jRY7eK/3rlEoxaIa5tHijM4cA0PDDVfkQhsuS8GoUpHAM9n5576REbN/irTBlW/95FeU4wkYTNlXOm+ljGDLlCgmviOfyXqca/Ogw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669844073; bh=R/sUcaEQOXqq221zTjdyFrqZX0l5E9pjfJRj/CquQ9+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Grhwkcqbj/EtM8OajtMO6ZyvbzZ4vIu9FPqWmU5faeHAQ1RIYCxqF89YfGU5fsF5h5y6Jl7dDbQWkPeq39t1Sk2QVWQFg8lTVjOU7W+zr4FzAUuiwPKqhLgN/l6Z8hQBI+nQ3uJZHpnerCvD6PYdmFSYwmteYX4gghtvFZ61+seB+9faUHjkiNvaGAEqhdcEBJbW8Dul8kOi00huWgVJ0i/xCrV+NJLRwxnxUoM7PfQwWnseYqVAlW5+ESuYx1VtQxIactKtdiiW1hpN8rdUtc/ySesJqlHVHvn1mIzDNg7MuCun9Brej4FswijBsa7yDgxCcHAOMOhV+3vQhmBkdQ==
X-YMail-OSG: xfTe_vQVM1nYnhbIqNX6OCt2AcVELPuJkL_d65pfNlRofL6uSO_ZlNQULLQ2zOz
 QWmRxho04NgRS1wQi13igR0Cz.YD1x.BKJNXXMWtEUheg5YxL1xd.1FZW_GZzKGVNCpW8q8eAxCb
 fWXv6UurSdSBfeeiPjZ0TrYzw5HOPSIFoL.V51Jq0UcZYgfGZCJm.JU2e5N6xNM3FdQ6vFOaNldM
 goWdVi_2jVzcWHOaI.3ZUgM8c9RedqChxGBRAo3EPUadISjOdoh_Hd3o6gJp0RyIcnQzp3rGQPx1
 CYyVv2spJm0WswiqmEx._qQOUVQNPr.6zBQZ_w1KdRDoN4xQVXTE76jHeVfGgy3wpXFGzX3K7g5s
 Oe.imnLYkcAjXAMXfXLfVWsTnIfAUYZsrdEz1Auo2.qAHK2nlX4sIja9qs7NkCz55QAhrxo5mgJR
 POzqRw6M7vZUzdkbqep2r25Fhszcao4mKjRYdytMoKR_DzPFTNcSSmCJgDDGJAOFKW3jd0RuQL2V
 DpwHhZQ3FzC008Tf8DvqlZeTpfr1A6GLZaHm3PR6I9Gpml0sRYcZbSd.qEZwKCuSu32Kc2FwiV.a
 INdZ9cux7vUBDLTeFE.8BiwGStmLkJp_tKZ9q.xhLTK.vhlUka4fn3CHFUyYE4bYH0Gzp1_r_pRp
 ezGPtnyqIzYnHS3nc7XicgM00s73u0lSoz15YYi.YHiXw.o8cDqI4JlO4Ba8skzZy42cfDgM939q
 5WaoU4NkRFQN_oZW.EEPULxbTdn84QJ9J4QK1ytGl.z9WsDbA3x6DJEhvtdAKj2ZyV57Ac5Q6l.K
 _WWtelYXZwXwEBfJiGkCkUqyPV.DpHkKMXaslL8WFo_kMMVFzz4qKhlsasSOgz5WeUajPtUYE3k0
 qt54akL3koNUVV7jP1fkd9LNyEVKgVcu9W_6NoH5I3QACv9P3q4LFVnq5kn8opVHOz9zAFDyIvcM
 W4j2yvr53O1dwFyRUz1_qDR26c_u20VKEBGUsKqtrkr7SptPQugTZJI6S5Xu4Uznfcsxkc7gBfeC
 CqrcmUB643Saa5yn4yHUg8v0XG_msRR3iWz5s0JQDy5WcLo2izHvIBljD2fBFwkajfnp3pUNg23N
 aF8clNS9FJQi9IQQZwRxr6E9qmmR5jRu5sQ0yurqyF38iEhUnWAt76qc86yNubNEv1tyTHuikOAU
 My_ishgGFupUWyLtdvIp.nJ7vzyApxneqqh_wMPjS2pr_RJdef1_z_9i5Y1Af4nGjTvOBx_dzLYy
 WQVYyTwg72H7mKzKAVWKL.hn2uhpDibFWFsuJ_LVKSNrXQp4Nq1FSAsxOcLjU1P.u0kjLkySLX8h
 ElYtFezQAFpI16sM_gNnoAoldtSy5kfbp3PFXgyArQAPw1h3lfnZLhdrL2COs_epe2lwn5H0tF3m
 oShgmwCR_CRkCXvFGE1NSNAB_OwRobiV14pSbonCEestY4uG.3q3e6dhZJ0szZ2Z5cL05rImfycc
 1s45guw62MhsB7VDnuxgpK1nVxBgSGUHoqhPyEJF4E1e3LcLpZLqJpt_D2PwJvWGKCOuzCR7k8Ya
 BYJzyPjDlbT6PAr75ug.8pgqdSd3nIzFYx58Wl.3Fk.PzU3KxpQ2NhD1mdm5Cnp1z48yxPfh02Ui
 CzKCoTTds0DLkQfWydCKtlAEBOpJrkTVdi5qphu7LLC411EMZEj980uVHq04Hv9lUt6Yf7c.o4S8
 nE3N3cT70tG0Jp6dtb5J9TpzqmtGtB5a9c9ROZO8bBTiYfse31Bf.TZ8gQa.d5rjEe47GPHFjm_e
 slC4hq9mk78fM0XkqMQFA8_AUjdEtJWiePDQr0Krg_RSp6ojxzlulMWBHJTWDjiMzwwnfiS1ewRi
 IbZ_7RXehNQ9XZO02oCO63.8u4A257UHNZkPIsILBgeyAbZ7NStUgGnn4JjZprivlSL0uCnLK2Xk
 PSA.oJJlPTRKmmVz.NRgKCNBjZNQIbWKMQjkjH8gZH0znFGuyOm9XjvObbWajBRQf9szAD8fxHAZ
 Gcj2xxyj5EwoFHa7b0_lOxiUDTmBYYoBYrcURHR402m_vPdLM6qmhrzkebWucifu1WJBfbBkP2cO
 wqopXFoBgKYDdE1IWgsWfjaHyCgzQRsmCCodjO.pjbfHXSNX7zfiSMwOI8WC4p1JGswsXgDNPW6q
 EDgm.zS6JiPkU3W4lOMy8gjFlzfGwsjG0o9PY1PdDI9RYhtaUyclaDRc2hEY_KmLpetge0wrnacl
 1vkPgM_bGINvXrK8Ks7ZEe8Bcex8PLKdCnZzV
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 30 Nov 2022 21:34:33 +0000
Received: by hermes--production-ne1-7b69748c4d-7vsxg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e1770d4ce4bc5dadcc8ac264e78f86d4;
          Wed, 30 Nov 2022 21:34:31 +0000 (UTC)
Message-ID: <5d4b205a-9a6c-aa6a-0c83-17e9861fecf8@schaufler-ca.com>
Date:   Wed, 30 Nov 2022 13:34:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, casey@schaufler-ca.com
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
 <Y4ORZT2t/KhL5jfn@kernel.org>
 <53e3d7f9cc50e1fe9cf67e7889c6b5498580e5d9.camel@linux.ibm.com>
 <20221130202220.GA13122@wind.enjellic.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221130202220.GA13122@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/30/2022 12:22 PM, Dr. Greg wrote:
> On Sun, Nov 27, 2022 at 11:41:26AM -0500, James Bottomley wrote:
>
> Good afternoon, I hope the week is going well for everyone.
>
>> On Sun, 2022-11-27 at 18:33 +0200, Jarkko Sakkinen wrote:
>>> On Mon, Nov 14, 2022 at 12:11:20PM -0500, James Bottomley wrote:
>>>> On Fri, 2022-11-11 at 15:16 -0800, Evan Green wrote:
>>>>> Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
>>>>> restricts usermode's ability to extend or reset PCR 23.
>>>> Could I re ask the question here that I asked of Matthew's patch
>>>> set:
>>>>
>>>> https://lore.kernel.org/all/b0c4980c8fad14115daa3040979c52f07f7fbe2c.camel@linux.ibm.com/
>>>>
>>>> Which was could we use an NVRAM index in the TPM instead of a PCR???
>>>> The reason for asking was that PCRs are rather precious and might
>>>> get more so now that Lennart has some grand scheme for using more
>>>> of them in his unified boot project.?? Matthew promised to play with
>>>> the idea but never got back to the patch set to say whether he
>>>> investigated this or not.
>>> Even for PCR case it would be better to have it configurable through
>>> kernel command-line, including a disabled state, which would the
>>> default.
>>>
>>> This would be backwards compatible, and if designed properly, could
>>> more easily extended for NV index later on.
>> Um how?  The observation is in the above referenced email is that PCR23
>> is reserved in the TCG literature for application usage.  If any
>> application is actually using PCR23 based on that spec then revoking
>> access to user space will cause it to break.  This is an ABI change
>> which is not backwards compatible.  You can call it a distro problem if
>> it's command line configurable, but the default would be what most
>> distros take, so it's rather throwing them under the bus if there is an
>> application using it.
>>
>> Of course, if no application is actually using PCR23, then it's
>> probably OK to use it in the kernel and make it invisible to user
>> space, but no evidence about this has actually been presented.
> If there isn't, there will be in in the next week or so, if we can
> stay on schedule.  Otherwise, I fear that Casey Schaufler, who I
> believe is holding his breath, may turn irretrievably blue.... :-)

Sorry to disappoint, but my supply of apoplexy is firmly rooted elsewhere
for the time being. :-( Also, you overestimate my interest in things
TPM related.

> The Trust Orchestration System, Quixote, that we are releasing for
> Linux uses PCR23 to generate an attestation of the functional state
> value for an internally modeled security domain.
>
> TSEM, the LSM based kernel component in all of this, supports the
> ability to implement multiple 'domains', nee namespaces, each of which
> can have a security modeling function attached to it.  Each internally
> modeled domain has to have the ability to independently attest the
> functional value of the security model implemented for the
> domain/namespace.

I am very interested to see TSEM. I have heard nothing of it to date.

> We have found, and I believe others will find that, particularly the
> resettable registers, are too precious to be constrained from general
> usage.  We actually just finished lifting the PCR23 extension
> functionality out of the TSEM driver and into userspace because having
> it in the kernel was too constraining.
>
> With respect to making the behavior a command-line option.  We've
> slogged through 2+ years of conversations with sizable players who
> have indicated that if the 'distys' don't implement something, it
> isn't a relevant Linux technology, so a command-line option poses a
> barrier to innovation.
>
>> James
> Have a good day.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
