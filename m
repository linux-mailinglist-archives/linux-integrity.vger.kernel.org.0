Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB66B3229
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 00:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCIXop (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Mar 2023 18:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCIXoo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Mar 2023 18:44:44 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23456FAEC6
        for <linux-integrity@vger.kernel.org>; Thu,  9 Mar 2023 15:44:42 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id n5so2580067pfv.11
        for <linux-integrity@vger.kernel.org>; Thu, 09 Mar 2023 15:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678405481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrNSaYamQnIMzMjL3om7b+i4Qx2zDlX6VDGkZ+puoGo=;
        b=JLMRPN8SMReI/aLN8kuDM3HcfCcm0p3UcCdfR79QSOXtTWGJOju99YadxuDMnF8iQH
         D4Ya3e5WDQM0DJrbJkjRMSDt/lke2/0SxEzg8sv29Wfeunpu+TnDsgE7tSwImPbCjbyx
         My319TZxJmvj6Vcbx37J28jOi5FsfRGn4aMknL4IAf3NaNc03H7pKNztF41dRXPwninq
         +qVllkPnkMugYflJbOiv8sssZLqEstamUFDbs1T9CKXeYA4EelsUzrud6AO+flYObslT
         EM0utm7f9ClVuKVUOe3g9NEtm+PBicTWhktKuCk4DF4N6wGzuG7uDQBcuWY5PtaUjdhd
         jrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678405481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrNSaYamQnIMzMjL3om7b+i4Qx2zDlX6VDGkZ+puoGo=;
        b=klnKZmL770FHC/AMDoAeHjIelt5JJlaCy1Ms++AOfWliB0XDHfXyg3HvyucnhzkH9e
         mAkaYjYlZD8CiRF3xEvM1UdCJOQ18nx5raa/3kd6vPZCBWi5LP7m7+mfmKbEFmATHncP
         RHp6o7Z3oqAd8c+lCSJQywbZObG8UcV9TxiNgmtqDWuwLj2sKHq6wwyhTP8lJDJ4pb/z
         vcd6khCqZVvczcGT6JWIPNcu4FtHbbw/Rk146fb6gAKgLjyjmpVtCiv9xg7WYVooOkTv
         +UJVUxxgxXbMixET1NWgJw7sgfTQsTgh8pfOh7V91vZdggBgJy66JYySgQewH9Q0QuxA
         0Mzw==
X-Gm-Message-State: AO0yUKVl4eZf3oXlSy+9Q4POi2k0VyKgwRDJk0AGS+LkIf2vypc2zHDk
        bW8/bEchEhNMwnXmarH01GqTofHWy5iHTuOju3C8
X-Google-Smtp-Source: AK7set+BMvFWwBxakNhkWQwRzL4c9oiBvrgSJisCe+ag6p1mDE7MrQ54FtmUTCgXSzR5PCdVV0/3CCTEiEwp6YOudjQ=
X-Received: by 2002:a62:834a:0:b0:596:78f:1532 with SMTP id
 h71-20020a62834a000000b00596078f1532mr9486868pfe.2.1678405481553; Thu, 09 Mar
 2023 15:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com> <20230309085433.1810314-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230309085433.1810314-2-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Mar 2023 18:44:30 -0500
Message-ID: <CAHC9VhRBxPnQeQ4SPHKXP_k1epoaZRGNUzCa+QJR9se_t+4+-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] security: Introduce LSM_ORDER_LAST and set it for
 the integrity LSM
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 9, 2023 at 3:55=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs needing to b=
e
> last, e.g. the 'integrity' LSM, without changing the kernel command line =
or
> configuration.
>
> Also, set this order for the 'integrity' LSM. While not enforced, this is
> the only LSM expected to use it.
>
> Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
> and put at the end of the LSM list.

Since you are respinning this patchset anyway, I might make it clear
that the LSM_ORDER_LAST LSMs are always enabled only when they are
enabled at kernel configure/build time.  Simply marking a LSM as
LSM_ORDER_LAST does not mean you don't have to explicitly select the
LSM in the rest of the Kconfig.

> Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if an
> LSM is found, regardless of its order. In this way, the kernel would not
> wrongly report that the LSM is not built-in in the kernel if its order is
> LSM_ORDER_LAST.
>
> Fixes: 79f7865d844c ("LSM: Introduce "lsm=3D" for boottime LSM selection"=
)
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h |  1 +
>  security/integrity/iint.c |  1 +
>  security/security.c       | 12 +++++++++---
>  3 files changed, 11 insertions(+), 3 deletions(-)

--=20
paul-moore.com
