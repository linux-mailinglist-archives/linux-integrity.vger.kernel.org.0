Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7C7D86D1
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Oct 2023 18:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjJZQgQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Oct 2023 12:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJZQgP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Oct 2023 12:36:15 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387551A2
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2023 09:36:13 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso697142a34.2
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2023 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698338172; x=1698942972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxwXYwMyt0FwHK5OUsvzf3Vr4fO6GxIghkhPLs2Amdc=;
        b=WRosmtEcLHBEWAWKLDmdhUvVsCvv9zDOU5tq+JF0npcqgd/7awDpVc4eiqgrP+U1II
         stGbJhLa/8/F3GtxC9rnoirdmjaCPnFTSginSZDP8l+h6TAyh82I93Ey0jaBm+0MxTU0
         M1DaWNU2+CXebhKajiJ+qy682z345RS4VRsn5HqewiMIhHETfnuuBOoOpbEidgdUP4Aj
         8T2YJpUmUe6jLwRgsA+8tcZTMFggzFfzH7kiptC1FOlEB+yIIJbXYSiKF7aobt1oTsOh
         7r/x83aNx+7WLRbN6X3343KlKJe9bHDNnkzD6fvBlZ9m+NohGSbgcir2lDXiBj6c+N3V
         VN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698338172; x=1698942972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxwXYwMyt0FwHK5OUsvzf3Vr4fO6GxIghkhPLs2Amdc=;
        b=NA3aPZxrWRP3FEQ5jQ/nzWKLkj8WtMHtpgEQ50whPVcWj91DLZqQXE2hC0xyC3Q4Rl
         lF0GQdcZzM1gki3zHIqgtDNbHDpYM2/2UtVEyxy2ZypF/fGQLiUAXicJh8eCGVq/Kt0C
         j0h1VolfdjmmB89PA3gNiC6J0nHgZkRPcqnXaFRy62ILbB+QMeJFFCIQW52s42ZwTrJx
         dY4bfQbUZG8dXRTYmDbXH2LAE4E1gmVt41NkqZ9gazc6U2FHKCnDd+q+WbmTBcz3MUyW
         NZlaSaIEd2VcwWqOXBZPQS+uqgbtIrqO1O5FER2EaaTo2Bh2YjxOLxRQgyDlFUcdEmLh
         4Sbw==
X-Gm-Message-State: AOJu0YzkY09jbRr/xfsOP3p61svH/G9gJglLDUhWGO8Xej/kXvENSxad
        5jlvNfqJlnnPtfktKzGthxpMqWtQ9mG1ASLh3c/6
X-Google-Smtp-Source: AGHT+IEY3fApkDMaJbueyLpDliFh0pY6UiBcW7rNvFIgWkKAVzTXB5oZvPhkWACAtTHooiKMKO1OlWhVfNclqgBazKw=
X-Received: by 2002:a05:6870:d3cb:b0:1e9:d8a4:5523 with SMTP id
 l11-20020a056870d3cb00b001e9d8a45523mr58414oag.41.1698338172444; Thu, 26 Oct
 2023 09:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
 <dd0f6611c7b46f3cecee2b84681c45b1.paul@paul-moore.com> <447298d65b497fb1a7f8d47c4f1a3137eba24511.camel@huaweicloud.com>
 <CAHC9VhSMVpEvLwWvBCgz0EMEb=DG_AZ7fenVUk5vPM=v5c6kYQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSMVpEvLwWvBCgz0EMEb=DG_AZ7fenVUk5vPM=v5c6kYQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 26 Oct 2023 12:36:01 -0400
Message-ID: <CAHC9VhQW1mi5Z72cia7sqC7jERcCxO93xZJnvER=e7U6RqNFxQ@mail.gmail.com>
Subject: Re: [PATCH] security: Don't yet account for IMA in LSM_CONFIG_COUNT calculation
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 26, 2023 at 11:59=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Thu, Oct 26, 2023 at 11:12=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Thu, 2023-10-26 at 10:48 -0400, Paul Moore wrote:
> > > On Oct 26, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > > >
> > > > Since IMA is not yet an LSM, don't account for it in the LSM_CONFIG=
_COUNT
> > > > calculation, used to limit how many LSMs can invoke security_add_ho=
oks().
> > > >
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >  security/security.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > >
> > > Merged into lsm/dev-staging, thanks!
> >
> > Welcome!
> >
> > Could you please also rebase lsm/dev-staging, to move ab3888c7198d
> > ("LSM: wireup Linux Security Module syscalls") after f7875966dc0c
> > ("tools headers UAPI: Sync files changed by new fchmodat2 and
> > map_shadow_stack syscalls with the kernel sources")?
>
> Let me look into that, as long as it doesn't blow up the stuff in
> lsm/dev (I don't think it would), I'll go ahead and rebase to v6.6-rc4
> which should resolve the syscall numbering conflict.
>
> FWIW, I also hit the same problem with my kernel-secnext builds, if
> you're using those RPMs you'll find it's already resolved there.

That wasn't very messy so I've rebased lsm/dev-staging to v6.6-rc4 and
regenerated lsm/next.  If you notice any problems please let me know.

--=20
paul-moore.com
