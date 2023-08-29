Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27678CD0C
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Aug 2023 21:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjH2Teu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Aug 2023 15:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbjH2Tes (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Aug 2023 15:34:48 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A4CE54
        for <linux-integrity@vger.kernel.org>; Tue, 29 Aug 2023 12:34:23 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58cd9d9dbf5so2059237b3.0
        for <linux-integrity@vger.kernel.org>; Tue, 29 Aug 2023 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693337662; x=1693942462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dku1evb9mZQ/UCmFfdo5JZbpZalq24cWTcGsSAzwTxo=;
        b=GUB7STxbWkUDF/NQn4wyEXkioEA8oNZKQtrONNhVa0DSjs2gac/DbSU+cmA34mWhJu
         S5Jfx0XYrmZ9UXoEZ+6Tz83IoUA1zQbHcft7aea2fFU2JLW0Y3b+mw1azRDMyidjeU1i
         /3x0xaCloJjPcZFYekmBIXsXCxUp2T+5IEn+vfT3inx9jWYzm492gnde76XSCC70EKXo
         6Yjx1eM25U1w1GVLLCXklc79qS+7qD039HZWOaMJPOdqs3Xneht97JkTc5iVmM0dztpw
         bybWHvA5pTXuVrxRrKtAFZA3VzC1h95pkWFSSWddhSwQDS1hF+uJXbsJEMGbQNaoOaVG
         Du5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693337662; x=1693942462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dku1evb9mZQ/UCmFfdo5JZbpZalq24cWTcGsSAzwTxo=;
        b=exRlq39RSfEPG3cPQjouC8FB4ZL0G49h1bSpUocbMAj7OcYcWslD4x+KuZiJYtOgbG
         4a1uRQJJgemUZU63/FZb7bPuQ3CZTWsO5vccep3Ry1Q2pym4k9t+cZnAyKKYhfDwwFCm
         6XMqwPq0z5AJZSsySDWA/VUzvVuzk2KWQaYmq3B6rQFLh9oWcr8nVFHBEFO7evlHsJ9V
         EeFp7Qb1ayd8XgCaqkWvxEpeMPcT9lqSI1oqVSJBLQ9l/FlX218HUm1RyEPSEobN1L43
         w04foRtzOSYI0aIvikWJKWyHQCpEqiRwB4kNydCAtnoiiRrZNWnJAvVK9W+9T2PcGANF
         JnLQ==
X-Gm-Message-State: AOJu0YyvEmTCb7cF/5KpOAV4BYINLf1R0FCtzrKUfI4pVl6N39LxVJkb
        GEVCCYFlep3PKgSZWAhJ62xuOi9dd2cI/5liPTX5
X-Google-Smtp-Source: AGHT+IFet3rs4lSa6SdyUYuNhduFXChT/c/u2XD2EuWbmN/GXJdqeDdKGD9HS33EBu3hJQ+LAmlIEUXeaAC+annspfI=
X-Received: by 2002:a81:4e10:0:b0:586:a680:250 with SMTP id
 c16-20020a814e10000000b00586a6800250mr179637ywb.5.1693337661845; Tue, 29 Aug
 2023 12:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com> <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
In-Reply-To: <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Aug 2023 15:34:10 -0400
Message-ID: <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 21, 2023 at 7:08=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Mon, 2023-08-21 at 15:05 -0700, Sush Shringarputale wrote:
> > On 8/14/2023 3:02 PM, Mimi Zohar wrote:
> > > On Mon, 2023-08-14 at 14:42 -0700, Sush Shringarputale wrote:
> > >>> This design seems overly complex and requires synchronization betwe=
en
> > >>> the "snapshot" record and exporting the records from the measuremen=
t
> > >>> list.  None of this would be necessary if the measurements were cop=
ied
> > >>> from kernel memory to a backing file (e.g. tmpfs), as described in =
[1].
> > Even if the Kernel maintains the link between a tmpfs exported and an
> > in-memory IMA log - it still has to copy the tmpfs portion to the
> > Kernel memory during kexec soft boot.  tmpfs is cleared during kexec,
> > so this copying of tmpfs back to kernel memory is necessary to preserve
> > the integrity of the log during kexec.  But the copying would add back
> > the memory pressure on the node during kexec (which may result in
> > out-of-memory), defeating the purpose of the overall effort/feature.
> > Copying to a regular *persistent* protected file seems a cleaner
> > approach, compared to tmpfs.
>
> From a kernel perspective, it doesn't make a difference if userspace
> provides a tmpfs or persistent file.  As per the discussion
> https://lore.kernel.org/linux-integrity/CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5dsZT3r=
vdDzKgAH1aEV_-r9Qg@mail.gmail.com/#t
> , userspace provides the kernel with the file descriptor of the opened
> file.
>
> > We prototyped this solution, however it
> > does not seem to be a common pattern within the Kernel to write state
> > directly to files on disk file systems.  We considered two potential
> > options:
>
> If no file descriptor is provided, then the measurements aren't copied
> and removed from the securityfs file.  If there are write errors, the
> measurements aren't removed from the securityfs file until the write
> errors are resolved.

It sounds like this approach would require the file/filesystem to be
continuously available for the life of the system once the log was
snapshotted/overflowed to persistent storage, yes?  Assuming that is
the case, what happens if the file/filesystem becomes inaccessible at
some point and an attestation client attempts to read the entire log?

--=20
paul-moore.com
