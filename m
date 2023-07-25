Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC97623CE
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jul 2023 22:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGYUo3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jul 2023 16:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGYUo2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jul 2023 16:44:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C264426AD
        for <linux-integrity@vger.kernel.org>; Tue, 25 Jul 2023 13:44:00 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-583f99641adso31163137b3.2
        for <linux-integrity@vger.kernel.org>; Tue, 25 Jul 2023 13:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690317840; x=1690922640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWFtInZ1K1dOfuS7k8qAbtMBBIEMrxLy4VGVUtC5gnI=;
        b=C8boa0Mv2x13zaBKrUj+xzuVti30LteOQD/85/WnBKhzbeDHEzvYvZ3kQdHoCjYdG0
         ftqVyfqFa6NOhebzP3zMyFH7Nlp1JPPPKMGc1aE91kApgf84Ufspb27OrNQYnal4fJdI
         RuMjkIlaBANH5JbWHDMSmJYGIzqqyjVZTAseBtkUxPVzAHisNHbe6FS0O0hpPY2Mahdy
         fdrDOGG8cimzMGhjO/sM3c08lCiYTBbFA4aZL9R/TiSrtJIosdGWlE6hbhCkOQUU/TaG
         FqmFBGWx8K2cus33+JbUinADhEt8mhX8e9cNl+6Pf8/2HVcctD7B/+1vZNujcT3jVfWL
         BwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317840; x=1690922640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWFtInZ1K1dOfuS7k8qAbtMBBIEMrxLy4VGVUtC5gnI=;
        b=L0PFDbCBpKBN3viHcU0s1+QilTgBW8K6qlK/N9V4DzIfqvC0Chd7TdckJtvfLwHO/J
         px2ndFoC+Y8eXFHww8abw92bvXD3YMjKPC+f+APp1953Y/3UE+53dFPN2o7bn6anS5Yl
         RqFn18xTZmNwdCZMYnZR4ooEuzgEQ8pfzMF0fQjuoS9jJjpQ9voQ1UBC7vp7SfRwgQzr
         mKJvZxd4WloqkAGLT+XBUqdTcJ/fJRkzY9PCBclkpplVuzexkzFjIqaA7IaJthJsxxYI
         XZY8umf6FDX82gsfTMXqfA4VTwTihBd2CM+MEf6aLHmiiSI+BLcoFBK3cXjIX7b3VN0R
         QDlg==
X-Gm-Message-State: ABy/qLZL2/97uP/XdnIAoVYupTwsIQT+XtGvhOBBCWC8Aa4JpElA4tWX
        YzoZViDdN/U15WJ2gcrgu1qe6tcmvV/CbUgkJ30B
X-Google-Smtp-Source: APBJJlFkTo4MqIRboyJijfvAESH41Sn7XZLb7Wq1Qb4xbUmcbmJhG5qWNqiv1iYXWOFUlllWKuTA5JqszvfgcdQJA1g=
X-Received: by 2002:a25:2f16:0:b0:c83:27d4:c0d6 with SMTP id
 v22-20020a252f16000000b00c8327d4c0d6mr98124ybv.37.1690317839194; Tue, 25 Jul
 2023 13:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <1687986571-16823-1-git-send-email-wufan@linux.microsoft.com>
 <1687986571-16823-12-git-send-email-wufan@linux.microsoft.com>
 <ZKgm+ffQbdDTxrg9@redhat.com> <20230712034319.GA17642@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230712034319.GA17642@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jul 2023 16:43:48 -0400
Message-ID: <CAHC9VhQFxqcfgR0acgdiXKP9LT1KLgGjZd-QHs6O1dEex31HEQ@mail.gmail.com>
Subject: Re: [RFC PATCH v10 11/17] dm-verity: consume root hash digest and
 signature data via LSM hook
To:     Fan Wu <wufan@linux.microsoft.com>
Cc:     Mike Snitzer <snitzer@kernel.org>, corbet@lwn.net,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk,
        agk@redhat.com, eparis@redhat.com, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, audit@vger.kernel.org,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 11, 2023 at 11:43=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com>=
 wrote:
> On Fri, Jul 07, 2023 at 10:53:45AM -0400, Mike Snitzer wrote:

...

> > Both of your calls to security_bdev_setsecurity() to set your blobs in
> > the bdev are suspect because you're doing so from the verity_ctr().
> > The mapped_device has 2 dm_table slots (active and inactive).  The
> > verity_ctr() becomes part of the inactive slot, there is an extra step
> > to bind the inactive table to the active table.
> >
> > This leads to you changing the blobs in the global bdev _before_ the
> > table is actually active.  It is possible that the inactive table will
> > simply be removed and the DM verity device put back in service;
> > leaving your blob(s) in the bdev inconsistent.
> >
> > This issue has parallels to how we need to defer changing the global
> > queue_limits associated with a request_queue until _after_ all table
> > loading is settled and then the update is done just before resuming
> > the DM device (mapped_device) -- see dm_table_set_restrictions().
> >
> > Unfortunately, this feels like it may require a new hook in the
> > target_type struct (e.g. ->finalize())
>
> Thanks for pointing out this issue. We were calling security_bdev_setsecu=
rity()
> because the roothash signature data is only available in verity_ctr()
> and it is discarded after verity_ctr() finishes.
> After digging deeper into the table_load, I realized that we were indeed
> wrong here.
>
> Based on my understanding of your suggestion, it seems that the correct
> approach would be to save the roothash signature into the struct dm_targe=
t

Would you be doing this with a LSM hook, or would this live in the
device mapper layer?

> and then invoke security_bdev_setsecurity() before activating
> the inactive table in the __bind function (where dm_table_set_restriction=
s is called).
>
> To facilitate this process, it seems appropriate to introduce a new hook
> called finalize() within the struct target_type. This hook would enable
> targets to define tasks that need to be completed before activating
> a new table.
>
> In our specific case, we would add a finalize hook to the dm-verity modul=
e,
> allowing us to call security_bdev_setsecurity() and associate the roothas=
h
> information in the struct dm_target with the struct block_device of
> the struct mapped_device. Is this correct?

Where would the finalize() hook be called?

--=20
paul-moore.com
