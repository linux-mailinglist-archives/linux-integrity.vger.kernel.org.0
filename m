Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14656B322D
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 00:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCIXpZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Mar 2023 18:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjCIXpY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Mar 2023 18:45:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F8FAEDE
        for <linux-integrity@vger.kernel.org>; Thu,  9 Mar 2023 15:45:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so8031166pjh.0
        for <linux-integrity@vger.kernel.org>; Thu, 09 Mar 2023 15:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678405523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joK1iLs9YJ7HYS6kSzl2rZbt/PuSCafHcz/xrLe7jGo=;
        b=bJFC/lAxRaHk+mJqFSplHzH565OHscdq/bY/9CaWiQOg8ijsx/QWt+KjSnlFrcR+xR
         4I1MJqqwVstjWukbZY6XdRsy9bNQSN/vXnzu/GEMWzZTYVGIw135HxxyK2++JSB1jCwy
         bP7vzNceDo79Gggr+2xGhQQcleXlWrDTzDQUlFJMW8ZQE1RtzafjjlEqdvydZ4fz8OTD
         Y6VnRI+sJpkqAnzSvB0URvwz+nejVbgHzuJuAT+kACmJuxKTloH6ahZu62YHu56dSLtK
         pQvzd09T9tcOEZKDsBrx1zvXbF56C2jQ+8HzE0y00ywXkIa00ErlFPhBOm7+RwTIXAz6
         4XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678405523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joK1iLs9YJ7HYS6kSzl2rZbt/PuSCafHcz/xrLe7jGo=;
        b=EPtY7j0b5mO0iw3UsPHWmgdjpkv1Byl/ON3emzKvGMiJBl76knvMvKowVfCvOuCP68
         x87IEe4l766MbxPN9Nbm37wV6sRUz9p/YiivMK5zyxBkStAnuIdONBYRJXtDzzK+ApBe
         wo7Rub30Cxwk1Tk5lNGnhQWoukvo6faGv7EZjyGMuL4UHh0hCNuNwXhEXzs7ZLl/af8f
         jtAeOLKgqDXuHTaQ+CtCmV3scTgxWbXeErFOIRoyi0rrmcERvIlrnhAqrwp8Wa5aidNr
         Y3ii7F4X0UciJCKo9OGltUvH4OIvfXT0DpR3eI56FmSo1QvqxHu+Q3LRzEJtRGrwGWGQ
         gvRQ==
X-Gm-Message-State: AO0yUKW+RMcEA67T8nxs8x1v8GQGmrmjd3IXpc7kCx5pi+K5p1KyTqNU
        VCjvMjuXEiFwr/ug5mMOLldeyZFi8WmwmJ8jHx0v
X-Google-Smtp-Source: AK7set9RqqZSFE77wMatvCcE/t3Pq4nptu8SVgLeYYg9Y3Xs8cDwkREIi1LMWiYTY9uI7Ha62QlVV3bMgcEiTsZhy9c=
X-Received: by 2002:a17:903:485:b0:19a:f22b:31d4 with SMTP id
 jj5-20020a170903048500b0019af22b31d4mr9142241plb.7.1678405523115; Thu, 09 Mar
 2023 15:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com> <20230309085433.1810314-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230309085433.1810314-4-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Mar 2023 18:45:12 -0500
Message-ID: <CAHC9VhSuXxpS_eae0gi4zGFYWEXrxFZD7joaV-qhNmmvf_tcMg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] security: Remove integrity from the LSM list in Kconfig
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
> Remove 'integrity' from the list of LSMs in Kconfig, as it is no longer
> necessary. Since the recent change (set order to LSM_ORDER_LAST), the
> 'integrity' LSM is always enabled.

See my comment in 1/3 about "always enabled".

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

--=20
paul-moore.com
