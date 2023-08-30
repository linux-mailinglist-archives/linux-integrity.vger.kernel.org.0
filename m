Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2549D78E0F9
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbjH3Uux (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 16:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbjH3Uuw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 16:50:52 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C112F
        for <linux-integrity@vger.kernel.org>; Wed, 30 Aug 2023 13:50:16 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-58ca499456dso2628117b3.1
        for <linux-integrity@vger.kernel.org>; Wed, 30 Aug 2023 13:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693428471; x=1694033271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssuGzZWwIiUWbDzTGLwSAE+t2YPIoJ48hSVHvjVyTrQ=;
        b=C/ORejAQwOxyIfW5fjBZs9ksenVEY8Bdl+28aNgGeAwb4SU/m7tLTfvPdhvku7TBdR
         GCdgi01TJtBiSgsq3hrPYZvxbG+h4bn5orLoVtVn0oRW9eoNafgelM/hEjKXud0FGLJL
         0n7VtHHRrvxTjE2xkKOQPEEgnaDtOGPSCTKh/EXB8uUYbcsSg3m2K0o1wOFyVBbUJnyT
         eavl1vTzcO3F7vpGsgX+D3J0I18xMBSe8SgrdZqsIqVVkokmdtz2TmMEPsc1K6NmgKCv
         sj99LElwGm+xnyjmDvLcjWaM5GSNN6JV8yy1E/OKx+SmiMFsu4vzuZkzZHglc/UZ8or7
         DuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428471; x=1694033271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssuGzZWwIiUWbDzTGLwSAE+t2YPIoJ48hSVHvjVyTrQ=;
        b=A2QDQuEMvRj+vuxeSQsq4amv/dv2MFwFblGQZrt2XUATbj+6aQWXh0YxLCTgp/15tB
         e3E35seYbxEOmNmn6JPGrq1c9d0j7Ia/VWdhj8BbN9wGXUZouqrcZeYYOQL9KxX8/1N2
         DbCPzXytZ5W/Wob2gDhHBjyBJXEU+DqYfX+JD8MY4mCRtGPUnLMN4R4zKE+ARfeu+It7
         z2f9TyrcIwSmPJrfai7/0dDiobAwdH1X2JoFR4C7xiORDgzIHgYKxUx8CRbkT7IHoaMq
         i4gzAZmijVdirYQZyQO7Htd1sJahjAgUNxP7GA/6st4qmDW2LLBhspYn5GbouE+MnqmH
         Hk+g==
X-Gm-Message-State: AOJu0YxNJXqHqav2KQ6w26qPxZZsTPc2GcSLCD5Epp0+ZRAOnyjPWMf2
        s0ysJRZlkItuSOTC7MXJ0/e7HjE+05ymtNIEilHg89WbANNZ79igkA==
X-Google-Smtp-Source: AGHT+IHDRYogg+GkQ5vRG7NJp8ux1iBN2Yw6FJC8DSmoHEs6dPTAHHn7AHBZfxkPF4xTpQ/AfDZfr3Fo/8jD1GOCr/k=
X-Received: by 2002:a0d:f747:0:b0:595:80e4:907d with SMTP id
 h68-20020a0df747000000b0059580e4907dmr3028540ywf.32.1693428471675; Wed, 30
 Aug 2023 13:47:51 -0700 (PDT)
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
 <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com> <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
In-Reply-To: <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Aug 2023 16:47:40 -0400
Message-ID: <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 30, 2023 at 4:25=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> Your initial question was "what happens if the file/filesystem becomes
> inaccessible at some point and an attestation client attempts to read
> the entire log?".  For what reason would it be inaccessible?  For the
> original single tmpfs file, what would make it inaccessible?

In your reply that I had responded to you had mentioned that the
kernel was simply being passed a fd and taking ownership of it, the fd
could either be a tmpfs backed file or some form of persistent storage
as both were discussed in this thread.  I imagine a tmpfs filesystem
could still be forcibly unmounted, resulting in problems, but I can't
say that for certain.  However, there are definitely cases where a fd
backed against an arbitrary filesystem could run into problems:
storage device issues for local filesystems, networking issues for
network filesystems, and good old fashioned user/admin intervention in
both cases.

> In the
> "snapshotting" design this problem becomes a userspace issue.

Yes, exactly.  Userspace is almost always going to have an easier time
recovering from these types of errors ... or at least I believe so,
perhaps you have a clever solution for how the kernel can handle the
file/filesystem disappearing from under the fd?

> The first sentence of the cover letter is "Depending on the IMA policy,
> the IMA log can consume a lot of Kernel memory on the device." ...

As I'm still looking for an answer to my question, let's stay focused
on that before we start worrying too much about the phrasing of the
design proposal that was submitted.

--=20
paul-moore.com
