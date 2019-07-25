Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B175222
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbfGYPIB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 11:08:01 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:40636 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387422AbfGYPIB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 11:08:01 -0400
Received: by mail-ua1-f54.google.com with SMTP id s4so19975912uad.7
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jul 2019 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xsn8z/tHUHtkJTb9R9sNsE/rfo9z1JdCCx8KYpLn15s=;
        b=kvnAQtpw5hKGYcZJzljLHLOuY+osMGIM09PJXoPYsh9O6Th3/KgjB5eX+XzZGaIbBo
         W/VDmdB6TljTxUx9YCt1zzFBptwzpeWK+f6zXYVSSEue49KDb3YLw+3ZkBqi7RbFHsgA
         4vSlbt6cpc6s59XskYlfvFRugpVMv1n/9iwxNkJ9ykPZj4YaFQYOSlPm3uNJrn+ueS4Q
         It5BJeY9U0AOA/5djQGF9VQwftGrQ0SHBWH5iTRIuYgwrZ9NLXzXmMa1aOaCkcVCWpOa
         mI+GSHj7HVGB8xIHCNlCqX5S8bNI8DQ56URNZQqwhz0YH7muXz8hnsF7nV6NuP6Ob2vt
         2lCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xsn8z/tHUHtkJTb9R9sNsE/rfo9z1JdCCx8KYpLn15s=;
        b=AAxokoy7wzkPrrBXUQU2QJJpR1ZHCcwiPkhBuYyFFuD+3k98bG5MA4dqgamgwCJW01
         0LiEsHVLsLIC1ZRdcZS4bdW1mGFxAkoBthI4DRs3wAHjt4i5Bry+1wFaMYm3EahkP8z7
         bInXMiFD5Qw6LK3VzRhpVJhJE7Ui4qptMTpuAivpcYee93kbnRfeNFSF78p3JjnXWKjL
         uWRFAz7zvmCVWNJYJdJ8OyWOoUTpw+UuuunaZzNa70mPYr5mo+AoTAAS3KoJ3WgD18Ib
         +Lb1I++YLVIX+fIf3xt/JXmDcQdFcnaMyZ7OrxnGb+xNrSnEoxyjSHew+AFtlADdLJXP
         9lxw==
X-Gm-Message-State: APjAAAW2Fagqm0tXrO/w6Tl9IJ74+t0KB1hEgKUyzKaF0nKl1YQ5S9bm
        Z3Bgcau6nYYSaAvJUUPtys4PeugbJWl54Gcv1pXqcS1S
X-Google-Smtp-Source: APXvYqxP+LUQxD5bm0VVw/JDQlB+aW2Tcpn2ZWGmuw5pbRLXnMwP31AX0GnrxyfE9zVxWxl09+uCg23Qgz5r3Wki74M=
X-Received: by 2002:ab0:2789:: with SMTP id t9mr40008979uap.69.1564067279977;
 Thu, 25 Jul 2019 08:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABatt_yn_yjw-MOUnrPDyg-ZQd1AjaHkcJKxNBo8STC9o2EGrw@mail.gmail.com>
 <165e3170-9b5a-7c75-9a9b-265ede62f55e@schaufler-ca.com> <CABatt_yS9m0nkqSzh_LwSDfc8wuubkXgiOxd6kgVKWuNjbFKuA@mail.gmail.com>
 <36c9e956-b821-0fb6-5a38-93285d341916@schaufler-ca.com> <CABatt_wPccEg=xpb16K-XDHXOzvbwVapNTE_XhWbQBghJNYZFg@mail.gmail.com>
In-Reply-To: <CABatt_wPccEg=xpb16K-XDHXOzvbwVapNTE_XhWbQBghJNYZFg@mail.gmail.com>
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Thu, 25 Jul 2019 16:07:48 +0100
Message-ID: <CABatt_zcFXOFYqLBcaZzuMewKp9EmqnUtsGB8H9gr14ui4xB8w@mail.gmail.com>
Subject: Re: SMACK and keys
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 22, 2019 at 10:35 PM Martin Townsend
<mtownsend1973@gmail.com> wrote:
>
> On Mon, Jul 22, 2019 at 10:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 7/22/2019 1:19 PM, Martin Townsend wrote:
> > > Hi Casey
> > >
> > > Thank you for the swift reply.
> > >
> > > On Mon, Jul 22, 2019 at 5:25 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >> On 7/22/2019 1:03 AM, Martin Townsend wrote:
> > >>> Hi,
> > >>>
> > >>> One of our developers has reported the following audit log entry when
> > >>> trying to add a key to the kernel's keyring when SMACK is enabled:
> > >>>
> > >>> Jul  9 09:33:23 mach-cw-rnet-ppm-1840 user.notice kernel: audit:
> > >>> type=1400 audit(1562664803.960:12): lsm=SMACK fn=smack_key_permission
> > >>> action=denied subject="programmingapp" object="_" requested=w pid=905
> > >>> comm="programmingapp" key_serial=98475196 key_desc="_ses"
> > >> The Smack label on a key is set when the key is created,
> > >> and is set to the label of the process that created it.
> > > I'll have to check but I thought that the programmingapp process from
> > > the audit message above was trying to create the key, the dev team
> > > were reporting that the add_key syscall was failing the SMACK access
> > > check.  This raises another question, we currently compile in several
> > > root Certificates into the kernel, would these get a SMACK label? and
> > > if so would this be '_'?
> >
> > Yes, that could easily be what's happening here.
> >
> > What does a "compiled in" certificate look like?
>
> It's a PEM file of concatenated certificates that you copy into the
> certs directory I think and then set the following in the kernel
> configuration (in this example we have a file called
> builtin-trusted.pem)
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS="certs/builtin-trusted.pem"
>
> I'm assuming that the public keys contained in the certificates are
> added to the kernels trusted keying automatically during boot.
>
> >
> > >>> I had a quick look through the code in smack_lsm.c but can't see how
> > >>> I'm supposed to set a SMACK label for keys or keyrings.  Is it
> > >>> possible and if so how?
> > >> There is currently no way to change the Smack label on a key.
> > >>
> > >>> We are running a 4.9 Kernel with not much
> > >>> chance of upgrading as it's a vendor kernel (linux-imx).  As it's an
> > >>> embedded system we are happy to hard code the SMACK labels into the
> > >>> kernel if this is possible?
> > >> In smack_key_alloc() change
> > >>
> > >>         key->security = skp;
> > >>
> > >> to
> > >>         key->security = &smack_known_star;
> > >>
> > >> and all keys will have the star ("*") label, which
> > >> grants everyone access to them. Not the best solution
> > >> long term, but it should get you by.
> > > They are currently adding a rule 'programmingapp _ rw' so I think this
> > > would be an upgrade :)
> > > Could I go one further and have something like?
> > > #ifdef CONFIG_KEYS
> > >
> > > +static struct smack_known smack_known_keymaster = {
> > > + .smk_known = "keymaster",
> > > + .smk_secid = 9,
> > > +};
> > > +
> > >  /**
> > >   * smack_key_alloc - Set the key security blob
> > >   * @key: object
> > > @@ -4327,9 +4332,7 @@ static void smack_inet_csk_clone(struct sock *sk,
> > >  static int smack_key_alloc(struct key *key, const struct cred *cred,
> > >      unsigned long flags)
> > >  {
> > > - struct smack_known *skp = smk_of_task(cred->security);
> > > -
> > > - key->security = skp;
> > > + key->security = &smack_known_keymaster;
> > >   return 0;
> > >  }
> > >
> > > or is this just asking for trouble
> >
> > That would be even better. Be sure to add smack_known_keymaster
> > to the list of known labels, just like smack_known_floor and
> > friends are.
>
> Thank you, I didn't spot that.
>
> >
> > >>> or is it set to '_' by design and we
> > >>> should add the key whilst the process is a privileged state before the
> > >>> SMACK label for the process has been set?
> > >> If you can run the program that creates the key with a label
> > >> other than floor ("_"), perhaps "keymaster", the key would be
> > >> labeled keymaster, and you could create access rules like
> > > I will get some more information on how they are creating the keys as
> > > I thought the process creating the keys was labelled "programmingapp"
> > > so the key in theory should be labelled "programmingapp".  And looking
> > > at the smack_key_alloc function mentioned previously it definitely
> > > looks like it should have.  I'll see if I can get them to create some
> > > test code and debug why this isn't happening.
> > > Thanks again for your help.
> > >
> > >>         programmingapp keymaster rw
> > >>
> > >>
> > >>> Many Thanks,
> > >>> Martin.
> >

I created the keymaster label for all keys and I also had to add a
rule of "_ keymaster rw" so that the kernel could setup the built-in
trusted keyring and it boots fine but then we are seeing lots of
processes failing with what looks like integrity checks and then
messages like

Jul 19 10:11:15 mach-cw-rnet-ppm-1840 audit[1572]: AVC lsm=SMACK
fn=smack_key_permission action=denied subject="ubihealthd"
object="keymaster" labels_differ pid=1572 comm="(ihealthd)"
key_serial=20092166 key_desc=".ima_blacklist"

Jul 19 10:11:15 mach-cw-rnet-ppm-1840 audit[1572]: AVC lsm=SMACK
fn=smack_key_permission action=denied subject="ubihealthd"
object="keymaster" labels_differ pid=1572 comm="(ihealthd)"
key_serial=694943947 key_desc=".evm"

so I'm guessing that this means with my change I would have to give
every process that reads the root filesystem a rule for keymaster as
the main root filesystem is signed with IMA/EVM.  The default of '_'
I'm guessing would have the same effect and we would have to create a
rule for floor for every process?  I'm not sure what to do next except
if we can somehow identify the ima/evm key and give this the '*'
label.  For the moment we are going to assign all keys '*' so we can
proceed.  I just thought I would report our findings and wondered if
anyone had any ideas?
