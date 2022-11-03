Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD08618BA0
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 23:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKCWg0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 18:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKCWgZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 18:36:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D06A1FCE7
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 15:36:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 21so5227492edv.3
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phnKeO1dMgzl7mkMf0YYrKl7ykqDKgipvnWqDP1fXiM=;
        b=Zw5snCsIB19dCp6x644ge7l8Z2zGk39qvSf5/mFVSE7YXuhMIfqKkCDKBlO9bIdtMR
         OyZOpreqF4uq5F9blNYVLcpU7aEpl6hHLBK64TCF1ndNy/39PwaKhDZWsBO+YBFECR5L
         1QQtCKDM2FXEpHoFjUeHkFb67XBzTgvnGvLJxV2vUjxyqYwHheAJQGGODfKT6ruAg0Kk
         EPlODLPZTBuODjdUNKiMrjOd1ErYj/HgM+Od6E/2eOM4/RLKDhAZnxuLUbI70EVe9ixR
         ToNxj4C8Q8PauiU/vqm+TvQcdeTy4CQiMrXUxIMMZcHfdh3CGuwoVboe6HAJWOZ1c3P6
         78dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phnKeO1dMgzl7mkMf0YYrKl7ykqDKgipvnWqDP1fXiM=;
        b=P85V+oSL1AQ3On3wxdpggKpxxC2+vM01XXAbHEqstBjE4mrW0gF7/m0z3jSBlK+BKF
         d5qRiFhpw2ZPqpv3pS8yQQAlRfZeZ2gidKf8qpdMVMhc5eLaTSYfHnx4png3eHpk2g7k
         pNr1BI3mHFD9DQCMPDZzHO7t52NKOZsR8hDl73BMMkf84ZwTKggoy4qlNUqY17X9FWJ3
         d/rfKanHcY7jdu2o5EAoZkTgxppVvmiUNurqyYANIBWYwhP5Mar9O/ylN7BaGCEheGkK
         KioudyQP+hzfStAJS/4j50ofh9XvHp4Wmotzm+U8/T7ePrGAvuA3dYmSdrdWxxe97vSh
         gQ9g==
X-Gm-Message-State: ACrzQf019OcUCdSkhUz9Fl9lG2M0BMwldxAcQ82hg5CR//+Yw+CVsPCq
        3Y1GZn0ysLexxtJjdL0iHsoZe9Cz1d9ltsm72HeuLw==
X-Google-Smtp-Source: AMsMyM6WFzo+OgehrLaJjm0nQW9+wXHYKuyO/jelSqVpQCDtV648WrecT+6LYon5WVlBVNrK5QMLRJaidQJgFvSexIc=
X-Received: by 2002:a05:6402:d05:b0:462:9b84:3299 with SMTP id
 eb5-20020a0564020d0500b004629b843299mr31565565edb.270.1667514982434; Thu, 03
 Nov 2022 15:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221101020352.939691-1-jsd@semihalf.com> <20221101020352.939691-2-jsd@semihalf.com>
 <CANkg5eyWqhReHJd7Bj5EEG5chz89M-PKCnak91qPRWZEzm3NRw@mail.gmail.com> <CAOtMz3Od-r03EigmuEAG_q27bvifRS8ZV8YPOUHrayEW6YXO-Q@mail.gmail.com>
In-Reply-To: <CAOtMz3Od-r03EigmuEAG_q27bvifRS8ZV8YPOUHrayEW6YXO-Q@mail.gmail.com>
From:   Tim Van Patten <timvp@google.com>
Date:   Thu, 3 Nov 2022 16:36:11 -0600
Message-ID: <CANkg5exkR7rEK2k+3_aLUuGEaKp0Z4_jMULs_gjCCDt8fvWELw@mail.gmail.com>
Subject: Re: [PATCH 1/3] char: tpm: Protect tpm_pm_suspend with locks
To:     =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Cc:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de, rrangel@chromium.org, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Nov 2, 2022 at 3:28 PM Jan D=C4=85bro=C5=9B <jsd@semihalf.com> wrot=
e:
>
> > > -       if (!tpm_chip_start(chip)) {
> > > +       rc =3D tpm_try_get_ops(chip);
> > > +       if (!rc) {
> > >                 if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > >                         tpm2_shutdown(chip, TPM2_SU_STATE);
> > >                 else
> > >                         rc =3D tpm1_pm_suspend(chip, tpm_suspend_pcr)=
;
> >
> > This if-else block is still interacting with the TPM even though
> > you're not guaranteed to have the lock, which could lead to
> > racy/inchorent results. Would it be better to just bail out entirely
> > since we can't safely attempt any recovery at this point. If it's
> > still worth attempting the shutdown command, it would at least be good
> > to add a comment admitting that we have no choice but to communicate
> > with the TPM without a lock.
>
> If tpm_try_get_ops() returns 0 it means that we have a lock. And if we
> don't have a lock, then we are not executing any TPM commands. Are you
> referring to tpm_mutex or something different?

Ah, yup, I was reading this backwards, thinking that something had
gone wrong when entering this block. Nevermind.

--=20

Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997
