Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3F70B8B
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2019 23:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfGVVgA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jul 2019 17:36:00 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:37369 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfGVVgA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jul 2019 17:36:00 -0400
Received: by mail-ua1-f51.google.com with SMTP id z13so16074122uaa.4
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jul 2019 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZVh65/58lxHPJC4RLLU/E+lo61XW5YeUMYN1xdN9n4=;
        b=jgKEzjt8soD408kfcT7kUB9jBhBPFMv5xUwyrMO0aHQc/IyGL6/4w922Ae9pKLdEkq
         s9OLIWnQBHeA0420o2SMGqUgjeaskQ7bZES0FX46XrGOCTT8NTwm8WMwZU3gd9MP1Mfh
         aQN/NsT3hw2qrus+cmJH33c6R7aw4WJybX7Z/Js0asg8YqY+LRRp/IWmiPNgCp39Bv6l
         2/4BtuB733fVLuiqYJi3cirhRAbfPAvp2ftlW3eN2uGhVDZtNvu5EQA0VFcwQ4ToH0Y9
         mPoOIMegP2qSenkYNcy1qpk+ztZPZpUgNCZ9saEDn2kuwT849Oq7FPdgdioC65P+I/bZ
         m7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZVh65/58lxHPJC4RLLU/E+lo61XW5YeUMYN1xdN9n4=;
        b=j9qpduEtBNR+jdMcz9nOraghIiBW14xtfkpUrMjWX9JRnezM9RqAKIDbx/+/Fc422j
         3B/QAQXwg9yUpe1GVniqvZmCdqB1pOW1nGouEdOKKhmCPEBBbX7AZ85tuMF1eN9OPxwZ
         aDCeztLoKEQev1oiXl6KgoRW/72TtYzJwXNE6uKM4iLHLJQWSwJWPjpEjJSbPIp14VUa
         XCozzs1xUx1raEEsZ3LTUH+4FYRjxi9UoSrvZz6HLVzeH0zV3QnqvyQH9v9bg0m7eH0I
         BBcwD+3RHo6C64Tafqn5Bq9BZPQ1Bclf+uVHJtZze0c5LvAJJU3A49uLwlQOIlHzRpQV
         4PAQ==
X-Gm-Message-State: APjAAAXX/sH2CpOiDR3nfWwhCU2iVaRP5R9lovbfpGIc9XjFvd/Xqujp
        cUFsnJ1+A4nQNXFQEbj7YTXH38dhjiShcrEmquJogPlR
X-Google-Smtp-Source: APXvYqwdyWTvSMkF4wh7kYSG+/JRTZTigqdBn6LPLTOD1bZ9JoVYUVzYnj+vzAFAbT/r/cDDUE7+qTiJxI71p74eGCs=
X-Received: by 2002:ab0:6353:: with SMTP id f19mr45210819uap.34.1563831359139;
 Mon, 22 Jul 2019 14:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABatt_yn_yjw-MOUnrPDyg-ZQd1AjaHkcJKxNBo8STC9o2EGrw@mail.gmail.com>
 <165e3170-9b5a-7c75-9a9b-265ede62f55e@schaufler-ca.com> <CABatt_yS9m0nkqSzh_LwSDfc8wuubkXgiOxd6kgVKWuNjbFKuA@mail.gmail.com>
 <36c9e956-b821-0fb6-5a38-93285d341916@schaufler-ca.com>
In-Reply-To: <36c9e956-b821-0fb6-5a38-93285d341916@schaufler-ca.com>
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Mon, 22 Jul 2019 22:35:48 +0100
Message-ID: <CABatt_wPccEg=xpb16K-XDHXOzvbwVapNTE_XhWbQBghJNYZFg@mail.gmail.com>
Subject: Re: SMACK and keys
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 22, 2019 at 10:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 7/22/2019 1:19 PM, Martin Townsend wrote:
> > Hi Casey
> >
> > Thank you for the swift reply.
> >
> > On Mon, Jul 22, 2019 at 5:25 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 7/22/2019 1:03 AM, Martin Townsend wrote:
> >>> Hi,
> >>>
> >>> One of our developers has reported the following audit log entry when
> >>> trying to add a key to the kernel's keyring when SMACK is enabled:
> >>>
> >>> Jul  9 09:33:23 mach-cw-rnet-ppm-1840 user.notice kernel: audit:
> >>> type=1400 audit(1562664803.960:12): lsm=SMACK fn=smack_key_permission
> >>> action=denied subject="programmingapp" object="_" requested=w pid=905
> >>> comm="programmingapp" key_serial=98475196 key_desc="_ses"
> >> The Smack label on a key is set when the key is created,
> >> and is set to the label of the process that created it.
> > I'll have to check but I thought that the programmingapp process from
> > the audit message above was trying to create the key, the dev team
> > were reporting that the add_key syscall was failing the SMACK access
> > check.  This raises another question, we currently compile in several
> > root Certificates into the kernel, would these get a SMACK label? and
> > if so would this be '_'?
>
> Yes, that could easily be what's happening here.
>
> What does a "compiled in" certificate look like?

It's a PEM file of concatenated certificates that you copy into the
certs directory I think and then set the following in the kernel
configuration (in this example we have a file called
builtin-trusted.pem)
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS="certs/builtin-trusted.pem"

I'm assuming that the public keys contained in the certificates are
added to the kernels trusted keying automatically during boot.

>
> >>> I had a quick look through the code in smack_lsm.c but can't see how
> >>> I'm supposed to set a SMACK label for keys or keyrings.  Is it
> >>> possible and if so how?
> >> There is currently no way to change the Smack label on a key.
> >>
> >>> We are running a 4.9 Kernel with not much
> >>> chance of upgrading as it's a vendor kernel (linux-imx).  As it's an
> >>> embedded system we are happy to hard code the SMACK labels into the
> >>> kernel if this is possible?
> >> In smack_key_alloc() change
> >>
> >>         key->security = skp;
> >>
> >> to
> >>         key->security = &smack_known_star;
> >>
> >> and all keys will have the star ("*") label, which
> >> grants everyone access to them. Not the best solution
> >> long term, but it should get you by.
> > They are currently adding a rule 'programmingapp _ rw' so I think this
> > would be an upgrade :)
> > Could I go one further and have something like?
> > #ifdef CONFIG_KEYS
> >
> > +static struct smack_known smack_known_keymaster = {
> > + .smk_known = "keymaster",
> > + .smk_secid = 9,
> > +};
> > +
> >  /**
> >   * smack_key_alloc - Set the key security blob
> >   * @key: object
> > @@ -4327,9 +4332,7 @@ static void smack_inet_csk_clone(struct sock *sk,
> >  static int smack_key_alloc(struct key *key, const struct cred *cred,
> >      unsigned long flags)
> >  {
> > - struct smack_known *skp = smk_of_task(cred->security);
> > -
> > - key->security = skp;
> > + key->security = &smack_known_keymaster;
> >   return 0;
> >  }
> >
> > or is this just asking for trouble
>
> That would be even better. Be sure to add smack_known_keymaster
> to the list of known labels, just like smack_known_floor and
> friends are.

Thank you, I didn't spot that.

>
> >>> or is it set to '_' by design and we
> >>> should add the key whilst the process is a privileged state before the
> >>> SMACK label for the process has been set?
> >> If you can run the program that creates the key with a label
> >> other than floor ("_"), perhaps "keymaster", the key would be
> >> labeled keymaster, and you could create access rules like
> > I will get some more information on how they are creating the keys as
> > I thought the process creating the keys was labelled "programmingapp"
> > so the key in theory should be labelled "programmingapp".  And looking
> > at the smack_key_alloc function mentioned previously it definitely
> > looks like it should have.  I'll see if I can get them to create some
> > test code and debug why this isn't happening.
> > Thanks again for your help.
> >
> >>         programmingapp keymaster rw
> >>
> >>
> >>> Many Thanks,
> >>> Martin.
>
