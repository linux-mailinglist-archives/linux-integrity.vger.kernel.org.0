Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F16307617E
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jul 2019 11:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfGZJF1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jul 2019 05:05:27 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42749 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGZJF1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jul 2019 05:05:27 -0400
Received: by mail-vs1-f66.google.com with SMTP id 190so35613320vsf.9
        for <linux-integrity@vger.kernel.org>; Fri, 26 Jul 2019 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUA0sYw5jci3DCOM8UIi+T2XABEzycMvXVGFv3r4bZo=;
        b=soEnegLxxUULL8e/mR/zFdpxReZg67UGn/ILPtYYAdJzmnjqj71XZG1q6Fes0wt3h2
         A8mCA38bURtYKN03/sXGDizskHIJ6J+Z6t9kLfcrQkEMVZr3OCqwcL6GtBYNnppVKTmH
         2bSggazYgDn3TfyNFXc4fvkmeV+f7jtvUxEY5sLBwlsc3Twqf4ZKWw3CHYLtTSO4wFS6
         nVFxSCHwBk7TYPOVVpPano5T/kVY/lGwACPQXkRtt2ukR8T+NbR7tlSuT8ioilTsUYBH
         leOJ9TkGzpKn6/8qgl0lLYyDWdf/ToSziGY+CllrQx21DTrjo1RIvt+r7gk8b/yZSvYH
         c2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUA0sYw5jci3DCOM8UIi+T2XABEzycMvXVGFv3r4bZo=;
        b=UEBcSiSteOaOB6DtfCngeWEcJBavkEWkcM5G98diOSVrNSWVqRDWcNlqSaX1xBHrpu
         xdOicjXr7wbqobWKlqdr85/jCfxq5N1JsEKzMxB1I/a8DsiEIUjKigZ48mSoZ7spvtqH
         i2QptF5Y6VoZYeVP9u80DUfKjvNd/E63VH02//ZwM/49Id8IWcM8bAjvp/9Ru0DmHrru
         LFp9IkVst1gVRQHYxXwXlBOsjh2q5NWm4YZCOg8K3I6CcyaXoewYEfNVJ+4HZxGgH7p4
         qAhCwl3vPaY871KM7POpdVOc87nG+g5MCFUBz7zuGWT4x99ejJh3gcVWaFb5KPeIAKUO
         AdvA==
X-Gm-Message-State: APjAAAVpkMhgMHrel6hwyd3hAtEHHzk0p/TYMmK2gUog9RFr0VZX8UuO
        coV4p37ai0q1ouG/HV2R27crqSCWTjhU3W6+c51fwIJh
X-Google-Smtp-Source: APXvYqx02ZFmeNfAZkJNxKjto9aNt6BDn0vPufB8jezCcyXaITv7K6mM1OG/vUej9FxAWVnwTdMn/NwQmEcnwWrUbEU=
X-Received: by 2002:a67:c914:: with SMTP id w20mr32521001vsk.110.1564131925771;
 Fri, 26 Jul 2019 02:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <CABatt_yn_yjw-MOUnrPDyg-ZQd1AjaHkcJKxNBo8STC9o2EGrw@mail.gmail.com>
 <165e3170-9b5a-7c75-9a9b-265ede62f55e@schaufler-ca.com> <CABatt_yS9m0nkqSzh_LwSDfc8wuubkXgiOxd6kgVKWuNjbFKuA@mail.gmail.com>
 <36c9e956-b821-0fb6-5a38-93285d341916@schaufler-ca.com> <CABatt_wPccEg=xpb16K-XDHXOzvbwVapNTE_XhWbQBghJNYZFg@mail.gmail.com>
 <CABatt_zcFXOFYqLBcaZzuMewKp9EmqnUtsGB8H9gr14ui4xB8w@mail.gmail.com> <459451d7-d946-9c9d-9e7b-3ebd710fd479@schaufler-ca.com>
In-Reply-To: <459451d7-d946-9c9d-9e7b-3ebd710fd479@schaufler-ca.com>
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Fri, 26 Jul 2019 10:05:14 +0100
Message-ID: <CABatt_znPXRJAy+UF9L-0Fgb0WBSonEu2wNUXL17dT9hBdT06Q@mail.gmail.com>
Subject: Re: SMACK and keys
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-integrity@vger.kernel.org,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 25, 2019 at 8:44 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 7/25/2019 8:07 AM, Martin Townsend wrote:
> > On Mon, Jul 22, 2019 at 10:35 PM Martin Townsend
> > <mtownsend1973@gmail.com> wrote:
>
> I'm adding the smack-discuss list to the thread.
>
> >> On Mon, Jul 22, 2019 at 10:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>> On 7/22/2019 1:19 PM, Martin Townsend wrote:
> >>>> Hi Casey
> >>>>
> >>>> Thank you for the swift reply.
> >>>>
> >>>> On Mon, Jul 22, 2019 at 5:25 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>> On 7/22/2019 1:03 AM, Martin Townsend wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> One of our developers has reported the following audit log entry when
> >>>>>> trying to add a key to the kernel's keyring when SMACK is enabled:
> >>>>>>
> >>>>>> Jul  9 09:33:23 mach-cw-rnet-ppm-1840 user.notice kernel: audit:
> >>>>>> type=1400 audit(1562664803.960:12): lsm=SMACK fn=smack_key_permission
> >>>>>> action=denied subject="programmingapp" object="_" requested=w pid=905
> >>>>>> comm="programmingapp" key_serial=98475196 key_desc="_ses"
>
> Why does programmingapp need write access to the key "_ses" ?
> Knowing this may help identify options.
>
> >>>>> The Smack label on a key is set when the key is created,
> >>>>> and is set to the label of the process that created it.
> >>>> I'll have to check but I thought that the programmingapp process from
> >>>> the audit message above was trying to create the key, the dev team
> >>>> were reporting that the add_key syscall was failing the SMACK access
> >>>> check.  This raises another question, we currently compile in several
> >>>> root Certificates into the kernel, would these get a SMACK label? and
> >>>> if so would this be '_'?
> >>> Yes, that could easily be what's happening here.
> >>>
> >>> What does a "compiled in" certificate look like?
> >> It's a PEM file of concatenated certificates that you copy into the
> >> certs directory I think and then set the following in the kernel
> >> configuration (in this example we have a file called
> >> builtin-trusted.pem)
> >> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> >> CONFIG_SYSTEM_TRUSTED_KEYS="certs/builtin-trusted.pem"
> >>
> >> I'm assuming that the public keys contained in the certificates are
> >> added to the kernels trusted keying automatically during boot.
> >>
> >>>>>> I had a quick look through the code in smack_lsm.c but can't see how
> >>>>>> I'm supposed to set a SMACK label for keys or keyrings.  Is it
> >>>>>> possible and if so how?
> >>>>> There is currently no way to change the Smack label on a key.
> >>>>>
> >>>>>> We are running a 4.9 Kernel with not much
> >>>>>> chance of upgrading as it's a vendor kernel (linux-imx).  As it's an
> >>>>>> embedded system we are happy to hard code the SMACK labels into the
> >>>>>> kernel if this is possible?
> >>>>> In smack_key_alloc() change
> >>>>>
> >>>>>         key->security = skp;
> >>>>>
> >>>>> to
> >>>>>         key->security = &smack_known_star;
> >>>>>
> >>>>> and all keys will have the star ("*") label, which
> >>>>> grants everyone access to them. Not the best solution
> >>>>> long term, but it should get you by.
> >>>> They are currently adding a rule 'programmingapp _ rw' so I think this
> >>>> would be an upgrade :)
> >>>> Could I go one further and have something like?
> >>>> #ifdef CONFIG_KEYS
> >>>>
> >>>> +static struct smack_known smack_known_keymaster = {
> >>>> + .smk_known = "keymaster",
> >>>> + .smk_secid = 9,
> >>>> +};
> >>>> +
> >>>>  /**
> >>>>   * smack_key_alloc - Set the key security blob
> >>>>   * @key: object
> >>>> @@ -4327,9 +4332,7 @@ static void smack_inet_csk_clone(struct sock *sk,
> >>>>  static int smack_key_alloc(struct key *key, const struct cred *cred,
> >>>>      unsigned long flags)
> >>>>  {
> >>>> - struct smack_known *skp = smk_of_task(cred->security);
> >>>> -
> >>>> - key->security = skp;
> >>>> + key->security = &smack_known_keymaster;
> >>>>   return 0;
> >>>>  }
> >>>>
> >>>> or is this just asking for trouble
> >>> That would be even better. Be sure to add smack_known_keymaster
> >>> to the list of known labels, just like smack_known_floor and
> >>> friends are.
> >> Thank you, I didn't spot that.
> >>
> >>>>>> or is it set to '_' by design and we
> >>>>>> should add the key whilst the process is a privileged state before the
> >>>>>> SMACK label for the process has been set?
> >>>>> If you can run the program that creates the key with a label
> >>>>> other than floor ("_"), perhaps "keymaster", the key would be
> >>>>> labeled keymaster, and you could create access rules like
> >>>> I will get some more information on how they are creating the keys as
> >>>> I thought the process creating the keys was labelled "programmingapp"
> >>>> so the key in theory should be labelled "programmingapp".  And looking
> >>>> at the smack_key_alloc function mentioned previously it definitely
> >>>> looks like it should have.  I'll see if I can get them to create some
> >>>> test code and debug why this isn't happening.
> >>>> Thanks again for your help.
> >>>>
> >>>>>         programmingapp keymaster rw
> >>>>>
> >>>>>
> >>>>>> Many Thanks,
> >>>>>> Martin.
> > I created the keymaster label for all keys and I also had to add a
> > rule of "_ keymaster rw" so that the kernel could setup the built-in
> > trusted keyring and it boots fine but then we are seeing lots of
> > processes failing with what looks like integrity checks and then
> > messages like
> >
> > Jul 19 10:11:15 mach-cw-rnet-ppm-1840 audit[1572]: AVC lsm=SMACK
> > fn=smack_key_permission action=denied subject="ubihealthd"
> > object="keymaster" labels_differ pid=1572 comm="(ihealthd)"
> > key_serial=20092166 key_desc=".ima_blacklist"
> >
> > Jul 19 10:11:15 mach-cw-rnet-ppm-1840 audit[1572]: AVC lsm=SMACK
> > fn=smack_key_permission action=denied subject="ubihealthd"
> > object="keymaster" labels_differ pid=1572 comm="(ihealthd)"
> > key_serial=694943947 key_desc=".evm"
>
> Again, what is ubihealthd doing that it needs access to keys?
>
> >
> > so I'm guessing that this means with my change I would have to give
> > every process that reads the root filesystem a rule for keymaster as
> > the main root filesystem is signed with IMA/EVM.  The default of '_'
> > I'm guessing would have the same effect and we would have to create a
> > rule for floor for every process?  I'm not sure what to do next except
> > if we can somehow identify the ima/evm key and give this the '*'
> > label.  For the moment we are going to assign all keys '*' so we can
> > proceed.  I just thought I would report our findings and wondered if
> > anyone had any ideas?

I was asking the same questions :) so I put a dump_stack and outputted
the description of the keys in smack_key_permission to find out.

It looks like it is IMA.  From the  log file you can see that when a
file is accessed from any process (ubihealthd was just one of them but
literally every process does this)

I'll pick on ubihealthd, I scanned through the source code and I can't
see it using keys directly but it does write out a stats file.

When the process starts up there is a quite a bit of interaction with
the _ses and invocation_id keyrings

CPU: 0 PID: 353 Comm: (ihealthd) Tainted: G           O
4.9.11-1.0.0+gc27010d #25
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
[<8010ea60>] (unwind_backtrace) from [<8010c4d8>] (show_stack+0x10/0x14)
[<8010c4d8>] (show_stack) from [<803e8784>] (smack_key_permission+0x2c/0xe0)
[<803e8784>] (smack_key_permission) from [<803e7dd0>]
(security_key_permission+0x3c/0x5c)
[<803e7dd0>] (security_key_permission) from [<803df864>]
(lookup_user_key+0x144/0x500)
[<803df864>] (lookup_user_key) from [<803dd410>] (SyS_add_key+0xd0/0x210)
[<803dd410>] (SyS_add_key) from [<80107dfc>] (__sys_trace_return+0x0/0x10)
keyp->index_key->description=_ses

CPU: 0 PID: 353 Comm: (ihealthd) Tainted: G           O
4.9.11-1.0.0+gc27010d #25
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
[<8010ea60>] (unwind_backtrace) from [<8010c4d8>] (show_stack+0x10/0x14)
[<8010c4d8>] (show_stack) from [<803e8784>] (smack_key_permission+0x2c/0xe0)
[<803e8784>] (smack_key_permission) from [<803e7dd0>]
(security_key_permission+0x3c/0x5c)
[<803e7dd0>] (security_key_permission) from [<803db9bc>]
(key_create_or_update+0x190/0x38c)
[<803db9bc>] (key_create_or_update) from [<803dd444>] (SyS_add_key+0x104/0x210)
[<803dd444>] (SyS_add_key) from [<80107dfc>] (__sys_trace_return+0x0/0x10)
keyp->index_key->description=_ses

CPU: 0 PID: 353 Comm: (ihealthd) Tainted: G           O
4.9.11-1.0.0+gc27010d #25
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
[<8010ea60>] (unwind_backtrace) from [<8010c4d8>] (show_stack+0x10/0x14)
[<8010c4d8>] (show_stack) from [<803e8784>] (smack_key_permission+0x2c/0xe0)
[<803e8784>] (smack_key_permission) from [<803e7dd0>]
(security_key_permission+0x3c/0x5c)
[<803e7dd0>] (security_key_permission) from [<803dcb14>]
(keyring_search_aux+0x80/0x130)
[<803dcb14>] (keyring_search_aux) from [<803df400>]
(search_my_process_keyrings+0xd4/0x194)
[<803df400>] (search_my_process_keyrings) from [<803df4e4>]
(search_process_keyrings+0x24/0x10c)
[<803df4e4>] (search_process_keyrings) from [<803dfa78>]
(lookup_user_key+0x358/0x500)
[<803dfa78>] (lookup_user_key) from [<803de2cc>] (keyctl_setperm_key+0x24/0xa4)
[<803de2cc>] (keyctl_setperm_key) from [<80107dfc>]
(__sys_trace_return+0x0/0x10)
keyp->index_key->description=_ses

CPU: 0 PID: 353 Comm: (ihealthd) Tainted: G           O
4.9.11-1.0.0+gc27010d #25
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
[<8010ea60>] (unwind_backtrace) from [<8010c4d8>] (show_stack+0x10/0x14)
[<8010c4d8>] (show_stack) from [<803e8784>] (smack_key_permission+0x2c/0xe0)
[<803e8784>] (smack_key_permission) from [<803e7dd0>]
(security_key_permission+0x3c/0x5c)
[<803e7dd0>] (security_key_permission) from [<803dc464>]
(keyring_search_iterator+0xa0/0xf0)
[<803dc464>] (keyring_search_iterator) from [<803dc674>]
(search_nested_keyrings+0x1c0/0x330)
[<803dc674>] (search_nested_keyrings) from [<803dcb6c>]
(keyring_search_aux+0xd8/0x130)
[<803dcb6c>] (keyring_search_aux) from [<803df400>]
(search_my_process_keyrings+0xd4/0x194)
[<803df400>] (search_my_process_keyrings) from [<803df4e4>]
(search_process_keyrings+0x24/0x10c)
[<803df4e4>] (search_process_keyrings) from [<803dfa78>]
(lookup_user_key+0x358/0x500)
[<803dfa78>] (lookup_user_key) from [<803de2cc>] (keyctl_setperm_key+0x24/0xa4)
[<803de2cc>] (keyctl_setperm_key) from [<80107dfc>]
(__sys_trace_return+0x0/0x10)
keyp->index_key->description=invocation_id

CPU: 0 PID: 353 Comm: (ihealthd) Tainted: G           O
4.9.11-1.0.0+gc27010d #25
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
[<8010ea60>] (unwind_backtrace) from [<8010c4d8>] (show_stack+0x10/0x14)
[<8010c4d8>] (show_stack) from [<803e8784>] (smack_key_permission+0x2c/0xe0)
[<803e8784>] (smack_key_permission) from [<803e7dd0>]
(security_key_permission+0x3c/0x5c)
[<803e7dd0>] (security_key_permission) from [<803df864>]
(lookup_user_key+0x144/0x500)
[<803df864>] (lookup_user_key) from [<803de2cc>] (keyctl_setperm_key+0x24/0xa4)
[<803de2cc>] (keyctl_setperm_key) from [<80107dfc>]
(__sys_trace_return+0x0/0x10)
keyp->index_key->description=invocation_id

... And then when accessing a file we see


CPU: 0 PID: 475 Comm: (ihealthd) Tainted: G           O
4.9.11-1.0.0+gc27010d #25
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
[<8010ea60>] (unwind_backtrace) from [<8010c4d8>] (show_stack+0x10/0x14)
[<8010c4d8>] (show_stack) from [<803e8784>] (smack_key_permission+0x2c/0xe0)
[<803e8784>] (smack_key_permission) from [<803e7dd0>]
(security_key_permission+0x3c/0x5c)
[<803e7dd0>] (security_key_permission) from [<803dcb14>]
(keyring_search_aux+0x80/0x130)
[<803dcb14>] (keyring_search_aux) from [<803dcc58>] (keyring_search+0x94/0xcc)
[<803dcc58>] (keyring_search) from [<803f17b4>] (asymmetric_verify+0x90/0x1ec)
[<803f17b4>] (asymmetric_verify) from [<803f7020>] (evm_verify_hmac+0x204/0x258)
[<803f7020>] (evm_verify_hmac) from [<803f6894>]
(ima_appraise_measurement+0x12c/0x3a4)
[<803f6894>] (ima_appraise_measurement) from [<803f2aa8>]
(process_measurement+0x464/0x4d8)
[<803f2aa8>] (process_measurement) from [<803f2b44>] (ima_file_check+0x28/0x30)
[<803f2b44>] (ima_file_check) from [<8025873c>] (path_openat+0x67c/0x1414)
[<8025873c>] (path_openat) from [<8025a9b0>] (do_filp_open+0x70/0xdc)
[<8025a9b0>] (do_filp_open) from [<8024f9c0>] (do_open_execat+0x74/0x188)
[<8024f9c0>] (do_open_execat) from [<8025125c>] (do_execveat_common+0x1f4/0x84c)
[<8025125c>] (do_execveat_common) from [<80251ad8>] (SyS_execve+0x30/0x38)
[<80251ad8>] (SyS_execve) from [<80107dfc>] (__sys_trace_return+0x0/0x10)
keyp->index_key->description=.ima_blacklist

But that seems to be ok.  Here's an example of where ubihealthd fails
to get a key and it looks like it is failing EVM when trying to open a
file.

CPU: 0 PID: 530 Comm: (ihealthd) Tainted: G           O
4.9.11-1.0.0+gc27010d #25
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
[<8010ea60>] (unwind_backtrace) from [<8010c4d8>] (show_stack+0x10/0x14)
[<8010c4d8>] (show_stack) from [<803e8784>] (smack_key_permission+0x2c/0xe0)
[<803e8784>] (smack_key_permission) from [<803e7dd0>]
(security_key_permission+0x3c/0x5c)
[<803e7dd0>] (security_key_permission) from [<803dcb14>]
(keyring_search_aux+0x80/0x130)
[<803dcb14>] (keyring_search_aux) from [<803dcc58>] (keyring_search+0x94/0xcc)
[<803dcc58>] (keyring_search) from [<803f1808>] (asymmetric_verify+0xe4/0x1ec)
[<803f1808>] (asymmetric_verify) from [<803f7020>] (evm_verify_hmac+0x204/0x258)
[<803f7020>] (evm_verify_hmac) from [<803f6894>]
(ima_appraise_measurement+0x12c/0x3a4)
[<803f6894>] (ima_appraise_measurement) from [<803f2aa8>]
(process_measurement+0x464/0x4d8)
[<803f2aa8>] (process_measurement) from [<803f2b44>] (ima_file_check+0x28/0x30)
[<803f2b44>] (ima_file_check) from [<8025873c>] (path_openat+0x67c/0x1414)
[<8025873c>] (path_openat) from [<8025a9b0>] (do_filp_open+0x70/0xdc)
[<8025a9b0>] (do_filp_open) from [<8024f9c0>] (do_open_execat+0x74/0x188)
[<8024f9c0>] (do_open_execat) from [<8025125c>] (do_execveat_common+0x1f4/0x84c)
[<8025125c>] (do_execveat_common) from [<80251ad8>] (SyS_execve+0x30/0x38)
[<80251ad8>] (SyS_execve) from [<80107dfc>] (__sys_trace_return+0x0/0x10)
keyp->index_key->description=.evm
integrity: Request for unknown key 'id:a35fd9c6' err -13

So I'm guessing using SMACK and IMA together is going to require a bit of work.
How about if I set the label of the .evm and probably .ima keyrings to
'*'? I shall try and report back.
