Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D8154D4DA
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 00:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbiFOWzQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 18:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350852AbiFOWxN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 18:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09DD81571E
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jun 2022 15:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655333562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z88q2VhPMjNoVCPELClIJn8f0h0b9HF5PJJ+8yGCMEU=;
        b=ELWEAtVxjAgAevquTzb7Fr1ejKhHQlW8EbCSY99+VX2PSdDf9nq64ZXzAbqhHrVzU+NPQ2
        cK1Gz3A/1uZMCe8rfIYV1phsTyr4w+jYW8VTjznCiHTqzUF2Hba5zSGCRcSm8BjyTGUcdy
        5Iy5xhzRFlcgyg5nVCbhbUrHZs1bGZs=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-b7lTBrflPhO4WVYgL1oLnA-1; Wed, 15 Jun 2022 18:52:41 -0400
X-MC-Unique: b7lTBrflPhO4WVYgL1oLnA-1
Received: by mail-vk1-f199.google.com with SMTP id s130-20020a1f9088000000b0035cd8369930so2355879vkd.9
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jun 2022 15:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z88q2VhPMjNoVCPELClIJn8f0h0b9HF5PJJ+8yGCMEU=;
        b=kelouc8Z+GNfj9yn4lkqohq74ys3NY/FFlvAZnLiwqb+SOJy/9NT0e2PLdi0tDpJ8U
         LgEoMqIsF8Lp5Vn57UWkIB1kKnRXJw3o25G/zqoVN178E/ClMDQGj16A/2z4Ubi3OTZO
         lNgKKCIxT1Q9HaqHQd8NaDBCioLoXUlQ7LdNp/Lase0dOZtEfB8aUlBnxEHQJE0GPohj
         miVqeCW04EYm27Ql9ffy2HWUUiGWHyAzB9AbyUFCfjaFIMQAu3i22aYS0+2uAoPTZWKl
         EfA8zcVj9lFYYKFnlry90jofo2p2wdq+z07MORFei2zF9cJzMXP37I93pg04cLkDBW9X
         4chQ==
X-Gm-Message-State: AJIora+757JOy8qBKaoXEnZ+ucT8sItcjhiglnePWSIvz713ZP1Zvhpz
        mQ+JQ/oPdHqGGYrlEvPyhXifopscvRALD4FzcLR0nmYPQXVo058RGV/DeY16QwgylCa3LJqjBG3
        Iuevi8S//qy3BLWjjF4y2kkXo6Tbs6KqjwdAqAUEla2QY
X-Received: by 2002:a05:6102:390f:b0:34b:fd08:765b with SMTP id e15-20020a056102390f00b0034bfd08765bmr1342338vsu.20.1655333560634;
        Wed, 15 Jun 2022 15:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tvhsvnDt9MEkOvCPaVAPnzO5qGYm4kkdQiCBp61tyWGRuyh3+lm4/eqhvAJwy/AnHqKgPQZiLZFA+mOnJfDeM=
X-Received: by 2002:a05:6102:390f:b0:34b:fd08:765b with SMTP id
 e15-20020a056102390f00b0034bfd08765bmr1342331vsu.20.1655333560422; Wed, 15
 Jun 2022 15:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <CALzcddv+khkc4vy4n0m6EAn=d2+9M5RRc92_TbxdCPMViJUC3w@mail.gmail.com>
 <Yqo4ot+mIW+LsrxB@iki.fi>
In-Reply-To: <Yqo4ot+mIW+LsrxB@iki.fi>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Wed, 15 Jun 2022 15:52:14 -0700
Message-ID: <CALzcdduSg92P7nU3kXEugxq-xysvCPV2SUPRNtrvGMUb0rq6dg@mail.gmail.com>
Subject: Re: CKI team seeing boot failures with 5.19 kernels on VMs with tpm device
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 15, 2022 at 12:55 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 07:47:40AM -0700, Jerry Snitselaar wrote:
> > This came to my attention this morning, and I was able to do a quick
> > test and reproduce in a vm locally, using both the crb and tis
> > emulation. 5.18 boots up fine.
> >
> > The only thing I see that could impact both crb and tis in the tpm
> > changes would be:
> >
> > af402ee3c045 tpm: Add field upgrade mode support for Infineon TPM2
> > modules | 2022-05-23 | (Stefan Mahnke-Hartmann)
> > e57b2523bd37 tpm: Fix buffer access in tpm2_get_tpm_pt() | 2022-05-23
> > | (Stefan Mahnke-Hartmann)
> >
> > I'm going to poke around some more and see if I can figure out what is
> > going on, but wanted to give you a heads up.
> >
> > Regards,
> > Jerry
> >
>
> OK, thanks for spotting this.
>
> BR, Jarkko
>

Whatever it was it wasn't the tpm code, and it looks like it has
disappeared with v5.19-rc2.

Regards,
Jerry

