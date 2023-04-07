Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F3A6DAEE7
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Apr 2023 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjDGOkv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Apr 2023 10:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDGOku (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Apr 2023 10:40:50 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3C28F;
        Fri,  7 Apr 2023 07:40:48 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id 89so29939035uao.0;
        Fri, 07 Apr 2023 07:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680878448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY7VgH+o7BImM3mCHKzPFaZJMnpPi9NhPlVfx1lXYRQ=;
        b=gJKw5yVZemHELBRTUZdPrP3VlFqjOd9xYtXNUJBJHW4Jc/lSqMczyq46l8ABAvpQzM
         hihwjrnVJU4mQfXrEIJ4dX5HmuuIpzALH7qd2QuiQBGTIXDWG9lXY8VDYB0des+XD1Oc
         IbYFthOysV3pffKKUUygdDMCbno762RlJTY9GEjFapLqhLy7/s3viFvPXzh1ebyMu1Df
         RzKHFMnW7xlLgHtRlHnvKH6QKXrvzEzSsyPKDqkcusV4ATeEJTyt0jvYiX6xwqIxmK1i
         l8U7x/9FV+wnAAi4KgyhcpAX8zL6aLxp8jWOROtavNEKOGslDUksY34a+/EtoPT4X+/y
         B4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680878448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY7VgH+o7BImM3mCHKzPFaZJMnpPi9NhPlVfx1lXYRQ=;
        b=wMHk4MqPOO7mRcCUf+9XrlyV8XlZMH/cisJ9ZCKQUMTrX7ettsRRY38Kd1JXFqcIbn
         5QGiyxKvn7nfDDqn82e1HjP8lnfg3VSC5SW69WcunKTWF8YdvFAu3g3Y1XolNEqybdjT
         tPrmGk1Wy6imGzGGdjkBdqkyn31YT8loR6eAFbeQXnglOLDcc/S9PLo/J6JZN2Qk1/JR
         z2FAfVdUc7oxrj8ws1neOnSoSkdkWTqu26wAZyoXXeAe13a/k8er8+IHy5s4/MmNk/lu
         ppvNtPdgYOXo8mNrLNjm+z1EJtDxy+S9Q9/nXFYX6N6CD1tJobwfUnNUiaYPC14q8T94
         pLag==
X-Gm-Message-State: AAQBX9ewrGPpZABtizl/V5vwhybomRjt9GPFVRfEiSOzLZQuC+RK7DCK
        14yEK8UJRaEp4kaDtRoq5XDhfNqgvSIp7KGZPhw=
X-Google-Smtp-Source: AKy350aLSfpqxqaT8uCLN7MhYxH67Zfzh4XVn811EwYUJyj3dtP85IOAsKwWhtWzESJr5JJ8WNU681cgDE1yPnjFBk4=
X-Received: by 2002:ab0:1005:0:b0:68a:8f33:9567 with SMTP id
 f5-20020ab01005000000b0068a8f339567mr1256929uab.2.1680878447958; Fri, 07 Apr
 2023 07:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <CAFftDdpbJ1Y7tupzPicXbX352Xk0zE-gSShg1WXGyTFJ22mdbA@mail.gmail.com> <a94021ce2b2a9fc74ad1609f114f62c7b9f279d5.camel@HansenPartnership.com>
In-Reply-To: <a94021ce2b2a9fc74ad1609f114f62c7b9f279d5.camel@HansenPartnership.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 7 Apr 2023 08:40:36 -0600
Message-ID: <CAFftDdrnZ9WurfAN7HWMshzqE85Dhk9eAG+nn0KyROnP610FcA@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] add integrity and security to TPM2 transactions
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 5, 2023 at 1:41=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2023-04-05 at 13:39 -0500, William Roberts wrote:
> > On Mon, Apr 3, 2023 at 4:44=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> [...]
> > > The most insidious interposer attack of all is a reset attack:
> > > since the interposer has access to the TPM bus, it can assert the
> > > TPM reset line any time it wants.  When a TPM resets it mostly
> > > comes back in the same state except that all the PCRs are reset to
> > > their initial values.
> > > Controlling the reset line allows the interposer to change the PCR
> > > state after the fact by resetting the TPM and then replaying PCR
> > > extends to get the PCRs into a valid state to release secrets, so
> > > even if an attack event was recorded, the record is erased.  This
> > > reset attack violates the fundamental princible of non-
> > > repudiability of TPM logs.  Defeating the reset attack involves
> > > tying all TPM operations within the kernel to a property which will
> > > change detectably if the TPM is reset.  For that reason, we tie all
> > > TPM sessions to the null hierarchy we obtain at start of day and
> > > whose seed changes on every reset.
> >
> > Rather than doing this, wouldn't the session be flushed from the TPM
> > on reset and thus subsequent commands using the session and session
> > key fail?
>
> That would happen only if we kept a context saved session, which we
> can't because the current session manager doesn't do de-gapping.  To
> get around this we start a new, short lived, session for most
> operations.
>
> There has been a thought that it would be faster if we did context save
> a session to keep re-using it, so adding de-gapping is on the list
> somewhere, it's just not near the top yet.
>

Rather than implement this half baked, why not just move this feature
to the top of the list,
userspace users are clamoring for this?

I had this on our TODO list at Intel, but I have been moved onto other
projects now and
don't have the resources to work on it or I would.

> > If that's true, couldn't we just pin the trust to an existing trusted
> > key that we have the name of and move on? The kernel would know that
> > something happened when session protections started failing without
> > the complexity and time of generating a key in the NULL hierarchy and
> > certifying it.
>
> If the goal is to check not only the kernel but also the boot
> components (like OVMF/EDK2), then we need a handoff protocol.  The
> beauty of the NULL seed is the name is a nice short thing to handoff.
> If we relied on sessions, we'd have to hand off a whole context saved
> session and all its nonces, which is a bit of a security risk.

Yeah I wouldn't hand off the session information. Bit for pre-kernel
things isn't this all bootstrapped with the
name of the "Signing EK '' stored on a filesystem? I think you
suggested a RO portion of /etc. Since that's
the root it would need to be available for the initial boot strap
before you can just hand of the name of the
NULL hierarchy key. But if Session Ungapping was implemented, it could
just be a handoff of the "Signing EK"
name. Which would reduce the need for a createprimary and certify command.

>
> James
>
