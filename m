Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1B7CE2DD
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Oct 2023 18:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjJRQfx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Oct 2023 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJRQfw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2023 12:35:52 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B667DAB
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2023 09:35:50 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso7363496276.3
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2023 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697646950; x=1698251750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg1ixXD9WP2UwFv3eCuFIgDaKeSzuWksYgfLUmtsPLE=;
        b=YyjzUlMVr6NeIBZstb5IqDkkcck+5xjDdyastFAX+IA2reEOf2RmtoKTy2G1G5PXR8
         8KopRCBxuHEPuPBIcqAWqe1g+86RNPddLDwuvPYW1qRNiA/bQO0k9u0BkAok9OC/6wDy
         QKQxpKIjq8f4dqtbJUpPHShIO577inw/fiuT8geddCX5xHrA9gQ+yWS9FQxiRTcrOSOI
         le763e1Fq2N6eHOpaDErlGS6/vKxK7UETnoGUjki13GwCsyzR/RIInWPU43A9JSbm4cD
         FLpZAoBYyGTYu5976WkvHizZRksdf815iH7cfFWToH/LzyYE8TDh+q5JiBjyAvUwMB4v
         VUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646950; x=1698251750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg1ixXD9WP2UwFv3eCuFIgDaKeSzuWksYgfLUmtsPLE=;
        b=eNN5MnjGZp9tpZJR5b0eD2Q1tDf1NIeI6HclPrjhLSD/niBDut/PLLYiFtlaGqXTZv
         h2z2sr3X6Miy6bx85tduFgopEncN/YHRUPk9LLLxqIK2wiSez84BS7BD38ILcUzYAZMv
         fQwFQ3Yxc+EuGYIFU6xFjXeDna61yUP1xJLdHhy/HuHPEl4oFGijchWWHvLWxY8jltiH
         DLCz/5DsFf1pD1h8W4QSfgz97ACM93zVHUw4gerH45Kim9gT1OXgKp5BtkNuSjL7Mg8W
         tP8XfAqjhOvM5/XxV4ITpFqrnlxhcmc39VViXLg5fusz2FHg9y2QHXEtOrUyeQnB79uU
         V7wQ==
X-Gm-Message-State: AOJu0YwjzN8x9fiuFr7zDJTA7XfY7JxpsBi4BHieWOXWVmVgPh1DSXw5
        jZZ3Ye+I5PxkN7j3FbazApK6j8D1bfv0NJ5gzlmm
X-Google-Smtp-Source: AGHT+IEUZ6xuw82JyE5izuSckatFgudDKao+ZUtrcCvlVYbpEdBTt8l9Iieigfc86lzMInTlfSG9zwOCz5pN9FOfDmQ=
X-Received: by 2002:a5b:a:0:b0:d79:d23f:b49c with SMTP id a10-20020a5b000a000000b00d79d23fb49cmr5549383ybp.35.1697646949881;
 Wed, 18 Oct 2023 09:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
 <20230912205658.3432-1-casey@schaufler-ca.com> <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
 <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
 <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
 <CAHC9VhRQ7xpeSX7b3VZfzQ15noJ8mgauNMuHWo_n3hMgsYMAfQ@mail.gmail.com>
 <468436cf766732a3cfc55d07ad119a6ccdc815c1.camel@huaweicloud.com>
 <CAHC9VhTjHT-DGKu0=cZPVb=+kMwmbPdr8HiVWJq-yzaDiYk_SA@mail.gmail.com>
 <6f33144c850c40e9438a6de2cf3004e223508755.camel@huaweicloud.com>
 <2637d5294d4a7ae871f1b758f5a30234836e2463.camel@huaweicloud.com>
 <c896c8ed559d0075146070be232e449b6951eb99.camel@linux.ibm.com> <283bf52d-af6e-4d20-a5ba-d98511c2e530@huaweicloud.com>
In-Reply-To: <283bf52d-af6e-4d20-a5ba-d98511c2e530@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Oct 2023 12:35:38 -0400
Message-ID: <CAHC9VhSiUgY1Dzy6LGOjPF6XQ3pVBiZ9LPdcQANNXZ9rj-WURw@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-integrity@vger.kernel.org
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

On Wed, Oct 18, 2023 at 10:15=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 10/18/2023 3:09 PM, Mimi Zohar wrote:

...

> > I agree with Roberto.  All three should be defined: LSM_ID_INTEGRITY,
> > LSM_ID_IMA, LSM_ID_EVM.
>
> I did not try yet, but the 'integrity' LSM does not need an LSM ID. With
> the last version adding hooks to 'ima' or 'evm', it should be sufficient
> to keep DEFINE_LSM(integrity) with the request to store a pointer in the
> security blob (even the init function can be a dummy function).

First off, this *really* should have been brought up way, way, *way*
before now.  This patchset has been discussed for months, and bringing
up concerns in the eleventh hour is borderline rude.

At least we haven't shipped this in a tagged release from Linus yet,
so there is that.

If you want to add a unique LSM ID for both IMA and EVM, I'm okay with
that, but if we do that I don't see the need for a dedicated ID for
"integrity".  Roberto, Mimi, one of you please send me a patch on top
of lsm/next-queue that updates the LSM ID to look like the following
(I believe EVM was added between AppArmor and Yama, yes?):

#define LSM_ID_UNDEF            0
#define LSM_ID_CAPABILITY       100
#define LSM_ID_SELINUX          101
#define LSM_ID_SMACK            102
#define LSM_ID_TOMOYO           103
#define LSM_ID_IMA              104
#define LSM_ID_APPARMOR         105
#define LSM_ID_EVM              106
#define LSM_ID_YAMA             107
#define LSM_ID_LOADPIN          108
#define LSM_ID_SAFESETID        109
#define LSM_ID_LOCKDOWN         110
#define LSM_ID_BPF              111
#define LSM_ID_LANDLOCK         112

... and also update the LSM registration code for IMA/EVM/etc. to do
the right thing.

Also, just to be clear, you should get this patch out ASAP.

--=20
paul-moore.com
