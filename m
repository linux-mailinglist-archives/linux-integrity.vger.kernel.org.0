Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5019372087A
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jun 2023 19:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbjFBRis (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jun 2023 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjFBRir (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jun 2023 13:38:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285C3133
        for <linux-integrity@vger.kernel.org>; Fri,  2 Jun 2023 10:38:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9768fd99c0cso47935666b.0
        for <linux-integrity@vger.kernel.org>; Fri, 02 Jun 2023 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685727524; x=1688319524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPpIUifsrj3WhrOLcjmDKG+n28eYiyTfgghRaS6XkRs=;
        b=UvCO7b36trGYA7jPwC4uUnaAo8v+TtUCL0eyfuINNpnEdHdEHS6eUmhhkP+WyhUdjn
         Oxqh3nfxL/QQ7wnOazvNrAp+kr6eSrklf6VqYQSws208yzwJXB3ATpZelSTTnkN0CJK7
         ILnk5hxIXlC3oknVRYnPQJqkz/MzEfFbg/l3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685727524; x=1688319524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPpIUifsrj3WhrOLcjmDKG+n28eYiyTfgghRaS6XkRs=;
        b=W4S+gR0FZPqZF9s5JBibv8HaV2YX/IvRz1Kkf17zcKVaDzQud8lOLwtwXc9DnzwNqB
         0gA7tijUZwdjw7VEHl8Xepy19Yt2oJEhGBhggcgeH+qxdYBexD0tRKT9rTLthD1d9Byz
         JTiUfxc8RYlU6ugAX/lA9vBdqKxI1YdZDCYS1H5qNnYYKsCSq/fVm4IKK0Nv1NRxQ4Wi
         2XyLDZL5SnWMCjouTdZoDIZfH75Aww/sYDfa+N2Mxv9pSbUNLkT2jqnS2j0I9EIcCCfW
         /1saBgrNT+jXCbz1FrMmk6oiVWevvhdXeeH3+xcvnfh5kTvYJTQTRmdU8+hs2CnzCh6f
         aZQQ==
X-Gm-Message-State: AC+VfDxs38wkGkktJBvfLGPTykiTf5cGUcsPZirZoSsOEdAD8LAQNLTH
        q4izvWwH8KtDxxNPgKP9MhkwOA74WfQr2iRopgIfPEim
X-Google-Smtp-Source: ACHHUZ4oTF/czI/m95MjdkJ7sH8dO8GtJ4Q2yu+mJu+oifPwywOXhblNCK8SLJGFMyyK1FbfZ81ZDA==
X-Received: by 2002:a17:907:9407:b0:973:e888:2225 with SMTP id dk7-20020a170907940700b00973e8882225mr4486626ejc.35.1685727524455;
        Fri, 02 Jun 2023 10:38:44 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906071600b0096f603dc8ddsm988098ejb.142.2023.06.02.10.38.43
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 10:38:44 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5148f299105so5027926a12.1
        for <linux-integrity@vger.kernel.org>; Fri, 02 Jun 2023 10:38:43 -0700 (PDT)
X-Received: by 2002:a05:6402:202e:b0:505:d16:9374 with SMTP id
 ay14-20020a056402202e00b005050d169374mr3588912edb.9.1685727523436; Fri, 02
 Jun 2023 10:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
In-Reply-To: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 13:38:26 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
Message-ID: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 2, 2023 at 10:41=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> sorry for this unusual procedure of me requesting a patch to be pulled.
> I asked for several months the maintainers (David: asymmetric keys,
> Jarkko: key subsystem) to pick my patch but without any luck.

Hmm.

The patch behind that tag looks sane to me, but this is not code I am
hugely familiar with.

Who is the caller that passes in the public_key_signature data on the
stack to public_key_verify_signature()? This may well be the right
point to move it away from the stack in order to have a valid sg-list,
but even if this patch is all good, it would be nice to have the call
chain documented as part of the commit message.

> I signed the tag, but probably it would not matter, since my key is not
> among your trusted keys.

It does matter - I do pull from people even without full chains, I
just end up being a lot more careful, and I still want to see the
signature for any future reference...

DavidH, Herbert, please comment:

>   https://github.com/robertosassu/linux.git tags/asym-keys-fix-for-linus-=
v6.4-rc5

basically public_key_verify_signature() is passed that

     const struct public_key_signature *sig

as an argument, and currently does

        sg_init_table(src_sg, 2);
        sg_set_buf(&src_sg[0], sig->s, sig->s_size);
        sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);


on it which is *not* ok if the s->s and s->digest points to stack data
that ends up not dma'able because of a virtually mapped stack.

The patch re-uses the allocation it already does for the key data, and
it seems sane.

But again, this is not code I look at normally, so...

               Linus
