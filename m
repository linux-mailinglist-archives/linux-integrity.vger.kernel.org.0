Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB7A78E247
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Aug 2023 00:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343778AbjH3WVx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 18:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243992AbjH3WVl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 18:21:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0597C2
        for <linux-integrity@vger.kernel.org>; Wed, 30 Aug 2023 15:21:16 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5925e580e87so3186107b3.1
        for <linux-integrity@vger.kernel.org>; Wed, 30 Aug 2023 15:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693434073; x=1694038873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYk4CFaJHq5Hn6MNLc9y9pnXnFv2RVUlYwtYTLNBaOM=;
        b=bPy91i0URlvwSDNHyoHRhvYHLYMGyK4qqhnwsQuYD5SMxdeVtQan+d6ZoF22VGmuRu
         o28QwBpsZCqzzMFYKmIY24PatySy68iqKesCsUIOX939wck7PMusiAlQNX/5OkXm8u9h
         8/zR/Ynjfmr/rBRrsarhO/iiQp2mQOEzALCJDoh2mLEX9v/3brazyD0hlMOnhDwogoTm
         W2oCjaKADrDq1iqaCXexhr7tvOL+dnfXWPPHNNQNMHii0KYpsuf9q/Lq9LFGca7eJ/+j
         QZnrDoIscX0ybg7wKfWmySdCaDPVXVmvMR5ErCMP0ogpLTXv8/UKq09HxceFWl0SxGg+
         dUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693434073; x=1694038873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYk4CFaJHq5Hn6MNLc9y9pnXnFv2RVUlYwtYTLNBaOM=;
        b=RSv2WBTndzkUT7aiQWj+kAq5mhnD2D+rBGYWgiUyYjjddbCDULNbAyDWuhN5lJpk9Z
         aMCvIDjilXOmRi9CWdM0CUMVF6NwbVDMHPRan0TnC35L2aKVwfeQj7IiXgUuoFBa0QPW
         eNtS8zr4Ecl7il10qUXijPXYNpiaPz3oZ7W+JtR6cz4N+iOP0La4jmAUnSObtjSs+d5S
         thiZ9M0ubdNaeNLkhl97SXmaDtgs+7g8PHz9jA6Ug03NGLsloBjYxXFk7iL5OSDdTeHh
         kq6dWvvBmLHdf3H/eREMIKhtoUpnB8jAE3oILjNHRA5Ta8KaazS1sPGcD7A8aQtxT0WN
         dLcw==
X-Gm-Message-State: AOJu0YxZrun18AJWJSGPrRfqftScLDEX0KGls6qGD1KNByeMxFGkR5I/
        rcdKFjOg6vBpEVPw+OwpikOy8y/anhnk5Z0IC6G7mzQabbukHX0=
X-Google-Smtp-Source: AGHT+IGLa2mnu5VKtaPSkRoADo7A1aX/WXgcrneTfTmHdg8nJb9SVHLhU7aD/Zz7xh/yLdcyJJm3VMS86nMGzyYIV+I=
X-Received: by 2002:a81:4e14:0:b0:586:a627:da2d with SMTP id
 c20-20020a814e14000000b00586a627da2dmr3479971ywb.9.1693434073693; Wed, 30 Aug
 2023 15:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
 <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
 <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
 <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
 <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
 <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
 <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com> <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
In-Reply-To: <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Aug 2023 18:21:02 -0400
Message-ID: <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
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

On Wed, Aug 30, 2023 at 5:50=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Wed, 2023-08-30 at 16:47 -0400, Paul Moore wrote:
> > On Wed, Aug 30, 2023 at 4:25=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > Your initial question was "what happens if the file/filesystem become=
s
> > > inaccessible at some point and an attestation client attempts to read
> > > the entire log?".  For what reason would it be inaccessible?  For the
> > > original single tmpfs file, what would make it inaccessible?
> >
> > In your reply that I had responded to you had mentioned that the
> > kernel was simply being passed a fd and taking ownership of it, the fd
> > could either be a tmpfs backed file or some form of persistent storage
> > as both were discussed in this thread.  I imagine a tmpfs filesystem
> > could still be forcibly unmounted, resulting in problems, but I can't
> > say that for certain.  However, there are definitely cases where a fd
> > backed against an arbitrary filesystem could run into problems:
> > storage device issues for local filesystems, networking issues for
> > network filesystems, and good old fashioned user/admin intervention in
> > both cases.
>
> "I imagine tmpfs filesystem could still be forcibly unmounted" sounds
> like an attack. Not being able to verify the measurement list against a
> quote is probably a good thing.

Okay, can you answer the question for an arbitrary persistent
filesystem?  That was always the more important question, and your
continued avoidance is getting me increasingly annoyed.

--=20
paul-moore.com
