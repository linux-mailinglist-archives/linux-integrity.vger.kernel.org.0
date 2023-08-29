Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2378D023
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 01:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjH2XPd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Aug 2023 19:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239804AbjH2XPb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Aug 2023 19:15:31 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9742F11B
        for <linux-integrity@vger.kernel.org>; Tue, 29 Aug 2023 16:15:27 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-594ebdf7bceso39424717b3.2
        for <linux-integrity@vger.kernel.org>; Tue, 29 Aug 2023 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693350927; x=1693955727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vTa4PdCZfjFG5lHc4dNqG+0XSK9QBpqhYShWqlnoIo=;
        b=UEjiKqvWpSQPtRSN0RbSnmCI54Gd7xmOQY7+HBbCJiFNIqTEJAtn46eEsDqfSEPr/o
         3yFSwBdSN4qUZjnQUs/aAEWUaG9vpUzth69Rj2+ps502QXDb+EJV0hG7MShpq49AK5FO
         LrmiyiEJL8N7u3QY2E65zi1gCrnAR3w3ic3RHoYObQiOjXeSHbUVm7ZsrEHzBQOYpdbi
         t7+6BJvh0Sz980Dfdr6pa6EVJA/pstaKI0NTEtwNISLhr43wVmzUszFTYF9v5QQnOCu+
         VmrtHMPwbC+k8H3HFltpso+B4Z1gOQhVi3ddi6tiXaXQAkRxri+RDob335bMnU02NU0D
         HBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693350927; x=1693955727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vTa4PdCZfjFG5lHc4dNqG+0XSK9QBpqhYShWqlnoIo=;
        b=Ol/oik/77cDndhrEqP0xTQ7SbpkPlofKNSX4b49enjtEF2nKoJujEAUPmFN47ToEsZ
         iktu3TIgbdb/EyWx5hiehSWNvFkWS4hiKTdR976X/E6y/3ggEOmSZ0+BEdVrh445hQyo
         Rt0HGxjYnERFbChtaLPnZTdMsvBra/lXlYx1bLceWhb2YIiVZfhwNXSOmuy9vU+y3rti
         /khYEeKgGjusrvlEx9VBUfQRMmNQ18BbNKR9e98gFqBV6YdXmXbAybKR8h5IQcinAO8d
         jks3m6hteDjVdE+8i2XDj8bMwjeX+JLCL/sGP3Q9fqGukPiBm0Yg6YQHM0OB1WTdt2EV
         2gbg==
X-Gm-Message-State: AOJu0Yzjq8ccfAKOQn1xBLih/7JN+P7oLxaMcUa1LT76SjLVRCOsaZPz
        VDdmTJWOyo9ao1wVJA8Ljx1e6FV3NRYcf6Y+PZbmAzf0zODgX5o=
X-Google-Smtp-Source: AGHT+IEfAIghQaOyFnhkOGghnSvmH8Q49mVxjPxt1pfkRStK7iBX7xSiHCbitdTjS+woAotcGaHR8STcdKo5RHy6JPA=
X-Received: by 2002:a81:9204:0:b0:569:479f:6d7f with SMTP id
 j4-20020a819204000000b00569479f6d7fmr407224ywg.43.1693350926827; Tue, 29 Aug
 2023 16:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
 <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
 <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com> <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
In-Reply-To: <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Aug 2023 19:15:15 -0400
Message-ID: <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com,
        code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.mic>,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 29, 2023 at 5:54=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2023-08-29 at 17:30 -0400, Paul Moore wrote:
> > On Tue, Aug 29, 2023 at 5:05=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Tue, 2023-08-29 at 15:34 -0400, Paul Moore wrote:
> > > > On Mon, Aug 21, 2023 at 7:08=E2=80=AFPM Mimi Zohar <zohar@linux.ibm=
.com> wrote:
> > > > > On Mon, 2023-08-21 at 15:05 -0700, Sush Shringarputale wrote:
> > > > > > On 8/14/2023 3:02 PM, Mimi Zohar wrote:
> > > > > > > On Mon, 2023-08-14 at 14:42 -0700, Sush Shringarputale wrote:
> > > > > > >>> This design seems overly complex and requires synchronizati=
on between
> > > > > > >>> the "snapshot" record and exporting the records from the me=
asurement
> > > > > > >>> list.  None of this would be necessary if the measurements =
were copied
> > > > > > >>> from kernel memory to a backing file (e.g. tmpfs), as descr=
ibed in [1].
> > > > > > Even if the Kernel maintains the link between a tmpfs exported =
and an
> > > > > > in-memory IMA log - it still has to copy the tmpfs portion to t=
he
> > > > > > Kernel memory during kexec soft boot.  tmpfs is cleared during =
kexec,
> > > > > > so this copying of tmpfs back to kernel memory is necessary to =
preserve
> > > > > > the integrity of the log during kexec.  But the copying would a=
dd back
> > > > > > the memory pressure on the node during kexec (which may result =
in
> > > > > > out-of-memory), defeating the purpose of the overall effort/fea=
ture.
> > > > > > Copying to a regular *persistent* protected file seems a cleane=
r
> > > > > > approach, compared to tmpfs.
> > > > >
> > > > > From a kernel perspective, it doesn't make a difference if usersp=
ace
> > > > > provides a tmpfs or persistent file.  As per the discussion
> > > > > https://lore.kernel.org/linux-integrity/CAOQ4uxj4Pv2Wr1wgvBCDR-tn=
A5dsZT3rvdDzKgAH1aEV_-r9Qg@mail.gmail.com/#t
> > > > > , userspace provides the kernel with the file descriptor of the o=
pened
> > > > > file.
> > > > >
> > > > > > We prototyped this solution, however it
> > > > > > does not seem to be a common pattern within the Kernel to write=
 state
> > > > > > directly to files on disk file systems.  We considered two pote=
ntial
> > > > > > options:
> > > > >
> > > > > If no file descriptor is provided, then the measurements aren't c=
opied
> > > > > and removed from the securityfs file.  If there are write errors,=
 the
> > > > > measurements aren't removed from the securityfs file until the wr=
ite
> > > > > errors are resolved.
> > > >
> > > > It sounds like this approach would require the file/filesystem to b=
e
> > > > continuously available for the life of the system once the log was
> > > > snapshotted/overflowed to persistent storage, yes?  Assuming that i=
s
> > > > the case, what happens if the file/filesystem becomes inaccessible =
at
> > > > some point and an attestation client attempts to read the entire lo=
g?
> > >
> > > The main purpose of the change is to addres kernel memory pressure.
> > > Two designs are being discussed: Sush's "snapshotting" design and
> > > Amir's original suggestion of continously exporting the measurement
> > > records to a tmpfs or regular file.  Both designs require verifying t=
he
> > > initial attestation quote by walking the entire measurement list,
> > > calculating the expected TPM PCR value(s).  That doesn't change.
> >
> > Sure, but my question is about what happens if portions of the
> > measurement list disappear due to file/filesystem problems?  How is
> > that handled?
>
> With the "snapshotting" solution there could be multiple files, so
> portions could be missing.  The other solution, the preferred solution,
> would be one file.

With the snapshotting approach the kernel doesn't need to maintain
ongoing access to a file, that is left up to the user process
performing the attestation (or simply inspecting the logs).  I have to
ask, for the third time now in as many hours, how does the proposed
kernel-holds-an-fd-open solution handle the case where the
file/filesystem is no longer accessible?  The snapshotting approach
should be much more resilient here as the error recovery paths can be
much more involved than what we would have available in the kernel,
not to mention the flexibility of allowing a user process to determine
how to store and manage the snapshotted log.

Considering that the snapshotting approach is opt-in (userspace has to
initiate the snapshot), I'm not sure the concern over log offsets is a
significant objection: existing userspace will never trigger a
snapshot, and new userspace that could potentially trigger a snapshot
should be written to take that into account.

--=20
paul-moore.com
