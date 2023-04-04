Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072FC6D6EB5
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Apr 2023 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjDDVKY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Apr 2023 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjDDVKX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Apr 2023 17:10:23 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839B24C08;
        Tue,  4 Apr 2023 14:10:16 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id d18so29701207vsv.11;
        Tue, 04 Apr 2023 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680642615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv+NohhAsBdq0qMaXbBxfOXI3CzelfObpMxTOlgtCAk=;
        b=BOCN0mhwoHV3xj1SyAnW6jYyE15XhHQIbz0um8w3XOZFjMIf3A7zvTUzv/rcxo3A7w
         evQM3Faredh/Pf5xPpNcTgQtCurZPbL6Kxwfh3j7DtczdgV3rf2OcQfPVVsg1eefGDLL
         yxfjKaW5MVaWdcF0yoSE5/fpDOjPHSO51eNMpd78YvbEsX7qlvPM1SgrfCKhhGo/hSMT
         R+aGsPrWW3sfafMxHnE1XlJXfaCSVjH447WJFKYa+ysBNW7+6C9mvtAvWREyyyc7M8A+
         CB4CWcKf99zljQRBuI7/hmTMNlTez1FcOmfFtpk6z0yEe2ze2lQVFwg5WZ7liEh8ZdLZ
         eSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uv+NohhAsBdq0qMaXbBxfOXI3CzelfObpMxTOlgtCAk=;
        b=oK1iUC2BZmeIvu2pB41SQ3Ys0AdyBx/JbyzcWgCZVBDdyTNP3Angu0/GlIGm6oeZ0Y
         8JGNj++ycXhCedJb4Y57MK8h15QjY5iMLfHJBjv7JKWMst70ZBeH384x5elGM3oWwWR6
         ZwrG6kN1W6fptx99rBtC7c03Bp3eTnj3jZUS5jqTOe8/HNJPM8LqM36rGyzmPSJd1nLO
         +5y3IbDWnJl39l8IJMrNpaFvvK4HztI4/GpH905X07FhkKfKyql5O7E35nJrL1qyNRzq
         v55ZkMCgESZu06/lKnM90LfE3qWSBmAenhZ+vQx/TLDeDS/27xjePXBMt2U2HXpwBG4+
         gJqA==
X-Gm-Message-State: AAQBX9djhlg4zevNaO31tron/eAoQLouWkl4rgBGpKTW7ku9a0tZGOTa
        uyYJwHb6Im0QbsvmteZBePuf3GEt0YVNwOqmsQ3XzRGd
X-Google-Smtp-Source: AKy350bB4R0Gi3aEgXvBXeD0jaOYuof1iLQq/69/0zYjYg2tfWC264gn2tF+Wxhn4Lv+sY8jZd3rWmkxG2V/Ux+A0Jg=
X-Received: by 2002:a67:d91d:0:b0:426:7730:1a4b with SMTP id
 t29-20020a67d91d000000b0042677301a4bmr3307365vsj.0.1680642615034; Tue, 04 Apr
 2023 14:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <CAFftDdpTWjtNEf=E5V0X1c5ZrG=LQKo1WH6n0Ok2DE7jsh6yqg@mail.gmail.com>
 <414fd2f5e49f9772dd1de4bd281a63e27e60e934.camel@HansenPartnership.com>
 <CAFftDdqeaRWvfvZfGwdXYaFcGBNirDV75JsuRR88FSdCrYmKpg@mail.gmail.com> <c025ff772580552ced343d88c608b41cd3e11889.camel@HansenPartnership.com>
In-Reply-To: <c025ff772580552ced343d88c608b41cd3e11889.camel@HansenPartnership.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 4 Apr 2023 16:10:03 -0500
Message-ID: <CAFftDdp84qYaL+VuUXNiMbgPadOzZF1aS07ewW_jTJfM=0yDjA@mail.gmail.com>
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

On Tue, Apr 4, 2023 at 3:19=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2023-04-04 at 14:42 -0500, William Roberts wrote:
> > On Tue, Apr 4, 2023 at 2:18=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Tue, 2023-04-04 at 13:43 -0500, William Roberts wrote:
> > > [...]
> > > > > The final part of the puzzle is that the machine owner must
> > > > > have a fixed idea of the EK of their TPM and should have
> > > > > certified this with the TPM manufacturer.  On every boot, the
> > > > > certified EK public key should be used to do a make
> > > > > credential/activate credential attestation key insertion and
> > > > > then the null key certified with the attestation key.  We can
> > > > > follow a trust on first use model where an OS installation will
> > > > > extract and verify a public EK and save it to a read only file.
> > > >
> > > > Ahh I was wondering how you were going to bootstrap trust using
> > > > the NULL hierarchy.
> > >
> > > Well, actually, I changed my mind on the details of this one: the
> > > make credential/activate credential round trip is a huge faff given
> > > that there's no privacy issue.  I think what we should do is simply
> > > store the name of a known signing EK on first install (using the
> > > standard P-256 derivation of the EK template but with
> > > TPMA_OBJECT_SIGN additionally set).  Then you can use the signing
> > > EK to certify the NULL key directly and merely check the signing EK
> > > name against the stored value to prove everything is correct.
> > >
> >
> > Yeah that model is much simpler. My guess is that on install it would
> > persist this "Signing EK" to a specific address that is different
> > from the typical EK Address?
>
> Actually, since this is used to prove trust in the TPM, we can't have
> the TPM store it;

Hmm, I think we miscommunicated here. At some point you need to call
TPM2_CreatePrimary
with the "Signing EK" template which would require Endorsement
Hierarchy (EH) Auth. So I would
imagine this key would be persistend to avoid needing it all the time?
Then the use of
TPM2_Certify using the "EK Signing" key would also need EH Auth since
AuthPolicy is coupled to EH Auth
via PolicySecret. I'm just thinking every time these commands are
invoked, especially if this is used
during boot, where EH Auth would be coming from or am I missing something?

> it's going to have to be somewhere in the root
> filesystem, like /etc.  Ideally it would be in the immutable part of
> /etc so it is write once on install.
>

I'm assuming this would be the template or name of the "Signing EK"?

In systemd we just shove the name (Actually a serialized ESYS_TR) of
the SRK into
the LUKS data and ESAPI handles the check in session establishment.

> > Any particular reason for using the Endorsement Hierarchy outside of
> > the lifespan of the seed only changing on revocation of the
> > Manufacturers Cert? Ie why not Owner Hierarchy?
>
> That's it really: it's the longest lived key of all those the TPM has.
> If I'm deriving it once on install and keeping it immutable until
> reinstall, I don't want tpm_clear upsetting the apple cart.
>
> James
>
