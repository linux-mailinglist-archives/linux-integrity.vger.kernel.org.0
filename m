Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C4578EFB6
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Aug 2023 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbjHaOnt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Aug 2023 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjHaOnt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Aug 2023 10:43:49 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982BE1B1
        for <linux-integrity@vger.kernel.org>; Thu, 31 Aug 2023 07:43:43 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58df8cab1f2so10674727b3.3
        for <linux-integrity@vger.kernel.org>; Thu, 31 Aug 2023 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693493023; x=1694097823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5MQm3fUOAVIdvuU6wM87p/9n+mW7Iovd0grQUogv/U=;
        b=SEpyx3x4AAFFj32HfQYm3ZaBYxWAPqD3N7W0eCfv8X3FV9OYKAPtddKwAygRjsygWT
         xLetoRUSMPgsmDxyOEyWPRcntOomHjz9jeroA6hgA2qrf+o8jNjHMuSaUcB3xomBDd+f
         fOJiJJZaBMolHMvrwXTZzR0KczQDOVN69XhotPvXGX3aRZjalfd/sbCxxYDE2FJR9ncU
         R/8XjpRLfTsPbKbHt7HI5FEOWe2mGY28QCFpmul3pvMCYgSqExHnB+ttNcAwGaGTkOQf
         9renvl21xFtI4MjCO7ytWq8+PaoFoaAvzvSt/XHmzNZe1lNFpK1YnVa1DLOCajOdQFNY
         sTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693493023; x=1694097823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5MQm3fUOAVIdvuU6wM87p/9n+mW7Iovd0grQUogv/U=;
        b=PKBN8Xkf0LDMK/ifL42NQqZOeU8LvBGnymWEVs+SokxUprQToMwIw9wSlv/Fp5DyLX
         qUg9SntXLnsxXOhFlbvM2sMBEj1EzgGdyyYbE6bGuMnQZaIf41/ESWRjH8AsWOB8Ev+r
         5bggoUvkU2K4CeE/yLisBwucDVbgSalVSms6ch16FJWR0BL90UkvPZdLhMdgwVbe1fLO
         /UW5BFmCYefbcJU+GEwjXxA2zq0mNhZGiCZ9jk2XT+WhyDYZQCjVRoKgjvkBUvoGRD68
         Vbxy7fiUNazi8dzUsMLAw4z4dOa7hrjhMD2DCQ8tNjdBpoAIwCuDoc3n4mZwTkXuwcdF
         Wwcw==
X-Gm-Message-State: AOJu0YzE7Kntihvxy/vyc+o097SqpqGJKm4h4+EaGnpszCP8jZx9qngX
        2ZVTJaiQM2YADguYfMewMY2VTTU92nZLlsR9Qpdj
X-Google-Smtp-Source: AGHT+IG1r2zoUi/oJ+J5eTJZa1yrr0X+VIYEtApjtpvis+gmqeMjwcAGIlYIWjdi27/ajwxiWrA6b5fgOYrgcYdOdaI=
X-Received: by 2002:a0d:db8d:0:b0:589:a095:76ca with SMTP id
 d135-20020a0ddb8d000000b00589a09576camr5472125ywe.44.1693493022786; Thu, 31
 Aug 2023 07:43:42 -0700 (PDT)
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
 <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
 <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
 <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
 <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com>
 <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com>
 <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com> <99ff7c12dec73209a0a20464f3010c4c61d6c5f5.camel@linux.ibm.com>
In-Reply-To: <99ff7c12dec73209a0a20464f3010c4c61d6c5f5.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Aug 2023 10:43:31 -0400
Message-ID: <CAHC9VhQbnyd2nvmL-t=3kXppsm985ps+NPJ5QDvM1WSS-Hd_Ew@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com,
        code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 31, 2023 at 10:07=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Wed, 2023-08-30 at 19:22 -0400, Paul Moore wrote:
> > On Wed, Aug 30, 2023 at 7:07=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Wed, 2023-08-30 at 18:23 -0400, Paul Moore wrote:
> > > > On Wed, Aug 30, 2023 at 6:21=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > > On Wed, Aug 30, 2023 at 5:50=E2=80=AFPM Mimi Zohar <zohar@linux.i=
bm.com> wrote:
> > > > > > On Wed, 2023-08-30 at 16:47 -0400, Paul Moore wrote:
> > > > > > > On Wed, Aug 30, 2023 at 4:25=E2=80=AFPM Mimi Zohar <zohar@lin=
ux.ibm.com> wrote:
> > > > > > > > Your initial question was "what happens if the file/filesys=
tem becomes
> > > > > > > > inaccessible at some point and an attestation client attemp=
ts to read
> > > > > > > > the entire log?".  For what reason would it be inaccessible=
?  For the
> > > > > > > > original single tmpfs file, what would make it inaccessible=
?
> > > > > > >
> > > > > > > In your reply that I had responded to you had mentioned that =
the
> > > > > > > kernel was simply being passed a fd and taking ownership of i=
t, the fd
> > > > > > > could either be a tmpfs backed file or some form of persisten=
t storage
> > > > > > > as both were discussed in this thread.  I imagine a tmpfs fil=
esystem
> > > > > > > could still be forcibly unmounted, resulting in problems, but=
 I can't
> > > > > > > say that for certain.  However, there are definitely cases wh=
ere a fd
> > > > > > > backed against an arbitrary filesystem could run into problem=
s:
> > > > > > > storage device issues for local filesystems, networking issue=
s for
> > > > > > > network filesystems, and good old fashioned user/admin interv=
ention in
> > > > > > > both cases.
> > > > > >
> > > > > > "I imagine tmpfs filesystem could still be forcibly unmounted" =
sounds
> > > > > > like an attack. Not being able to verify the measurement list a=
gainst a
> > > > > > quote is probably a good thing.
> > > > >
> > > > > Okay, can you answer the question for an arbitrary persistent
> > > > > filesystem?  That was always the more important question, ...
> > >
> > > The original proposal, not mine, suggested using a tmpfs file.   The
> > > idea of writing the measurements to a file on a persistent filesystem
> > > wasn't mine either.  Sush/Tushar were pushing for writing to a
> > > persistent file(s).  No argument from me that writing to a file on an
> > > arbitrary persistent filesystem is not a good idea.
> >
> > ...  Okay, so we all now agree that the kernel writing to an
> > arbitrary filesystem is not a good idea, and using tmpfs doesn't solve
> > the problem of general memory pressure (from previously in this
> > thread), that's all helpful and good to clarify.
>
> Do we also agree that the "tmpfs" solution would address the existing
> design motivation - kernel memory pressure?

I haven't really looked into that so I'm not comfortable commenting on
that.  I can say that in off-list discussions with Sush, Tushar, and
others the issue we are facing is general memory pressure so using any
type of memory backed filesystem doesn't really resolve our problem.

> > Assuming Sush and Tushar rework the document to clarify the
> > motivation/purpose for the work, as you suggested earlier, I'm
> > assuming we can revisit this problem and solutions?
>
> In addition to the mismatch between the motivation and the design, the
> design has some major flaws that first need to be addressed.
>
> Assuming the design issues are addressed, please make sure the document
> is written clearly and concisely.

That feels like a normal part of the design, review, and iterate cycle
to me.  Sush and Tushar are following along and I'm sure they will
take all of that into account in the next revision of the design
document.

--=20
paul-moore.com
