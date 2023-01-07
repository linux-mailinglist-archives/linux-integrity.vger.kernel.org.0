Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFD2660AF7
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Jan 2023 01:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjAGAjZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Jan 2023 19:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbjAGAjH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Jan 2023 19:39:07 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0998140C21
        for <linux-integrity@vger.kernel.org>; Fri,  6 Jan 2023 16:38:21 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id v81so1381534vkv.5
        for <linux-integrity@vger.kernel.org>; Fri, 06 Jan 2023 16:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=16DiRT24orN0zb1yErEFu4asPxKZ4t1JLEzl6HIfrYk=;
        b=ZedktWh1+arDwnqUb4n87IMLjyyhxPkDdRzFU+3XHrTMAG5N5kydOX9e+I63SW6tqv
         PS4IATp3avXvrs2ULpeG7Sp2ILb0vCUmcYb2pvJW+2GEf1zEm7wKh7/8SvcA/7VSyoqj
         YB+cGcTEaFNVE/+zgIMrO7VZGMzdStOlIX4cmBqrGQ2qpAVe5Rf32D7wYNWNlL8c7Wa4
         B2gPPRRLepz0XMZYYjHMu/Kr/bdxTTiLq6eq5CtBd6/MR3Lp6CKG32rDXg0A7AoQC1+i
         YDtAkao5iqky4zva5Bni5FzP1mQaBhzMBYZR8EyniSJQzb1xLla/M/VSM/AWgJvJEMWe
         tTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16DiRT24orN0zb1yErEFu4asPxKZ4t1JLEzl6HIfrYk=;
        b=QYnaNqvRFCMHvG5Wk78BBSdwQETmCR5pulKVvWK31dLJkS+zlrhc7BtZVDeaK5eg6S
         KGVcrmwComy5os/UHg0iQiqHVxFc54J+J1TpmwWApY17vMn+dw5yu9sFMfF6TxD6KXwW
         FK2o0sA0lKFA5T/MC6Lf7ToOsvdLCnhQBuk51tViP1tYNMo8Lrf/unVvYyo8CjoQMC74
         l1evoHJQTQ4ERHS9h7Ujr7VHAmqdhwJ55g6sUPsxFZU5yd7FEBSeB8k+TJBN+gG5O7YP
         WLYybWOgCaoegcd5xI+Ln5Qcag81drCeoWBa/grqTBfFoNurZgc0mJ+59+JNiVB8CZf+
         Dw1Q==
X-Gm-Message-State: AFqh2kpKP9XwlFLiIeCYvoaijmLaHtHT59fSQFQnuCpkfdgqcE8ztV/p
        sHIQVUXX0OxNHsqEqXg8OVZ6lZ9Aunla0CU2c8E=
X-Google-Smtp-Source: AMrXdXuRKVy/CFhdv2eWZAVDq/bK6E59sVtXj+IbLt4K5kSHkRJS0hpPTD/W95KlBzHWcbeR3PYWom/9s1iJrmgxNVU=
X-Received: by 2002:a1f:2714:0:b0:3cc:1019:57ef with SMTP id
 n20-20020a1f2714000000b003cc101957efmr6464072vkn.6.1673051900183; Fri, 06 Jan
 2023 16:38:20 -0800 (PST)
MIME-Version: 1.0
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
 <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
 <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
 <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
 <63a8c022-1407-d701-e756-070e299b5803@linux.ibm.com> <CAFftDdr6qs33HaaPK3MMmyi9-mMjUuLURt9PAum6hJ3N3m=_iw@mail.gmail.com>
 <25e8bd43-f73c-f3b0-bec7-32e9b3a5b876@linux.ibm.com>
In-Reply-To: <25e8bd43-f73c-f3b0-bec7-32e9b3a5b876@linux.ibm.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 6 Jan 2023 18:38:08 -0600
Message-ID: <CAFftDdqxtbvWHhdjCzyPqwcM=uiSC9GcRCS3uG8J++Uf47X_MQ@mail.gmail.com>
Subject: Re: Seal/Unseal trusted keys against PCR policy
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Sughosh Ganu <sughosh.ganu@linaro.org>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 6, 2023 at 5:17 PM Ken Goldman <kgold@linux.ibm.com> wrote:
>
> I discourage anyone from using scripted command line tools as production
> code.  IMHO, they're fine for learning and prototyping but that's all.

Well you can discourage it all you want but:
1. People do it
2. Shell languages exist for a reason
3. There is no semantic difference between a shell script and a program.

This is one of those pedantry vs pragmatism idioms.

>
> On 1/6/2023 5:23 PM, William Roberts wrote:
> > If you need to do this in production that tpmproxy allows anyone to
> > connect to it. So while it's open it
> > would circumvent the permissions on /dev/tpmrm0. You can just use
> > tpm2-tools, which uses
> > contexts and avoids this problem.
