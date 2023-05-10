Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7726FDB98
	for <lists+linux-integrity@lfdr.de>; Wed, 10 May 2023 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjEJKYX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 May 2023 06:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjEJKYW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 May 2023 06:24:22 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5781FE6
        for <linux-integrity@vger.kernel.org>; Wed, 10 May 2023 03:24:21 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-77d456fa0dbso2366968241.3
        for <linux-integrity@vger.kernel.org>; Wed, 10 May 2023 03:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683714260; x=1686306260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x7fqRHvgnRvB5mh9CqhIQkHQtj78V1mjTrY+n0K4wyM=;
        b=H3ZAqCri6LjaN5x36ti1pRjQk5EnhBXVodTDpqXpjq9B9H3jJ1zIjjviz/Zt6KVvUx
         4ExsZwVU4QLl9VbqNJsOsKsKDW6N3AyCV/vynQDapHKL1XjD/ell+Vu9GBXgTNHK9/jv
         E/S2eZl6iPVL9ZRIgbg3DNorTArQ9Z5Noquq85dbehdqtjIyTifsKwaPeTiLdH0QsWSi
         ayxE2P9iu5AyeAfZLAffCW04bKauTbwG6UR5YPZZYQFQg4ANaVCZUxYzs6XLY9iyBmp5
         SIrRP6llIKdkNt0y8nxpYHgaoH/t5xS5ju3sHpVn94GV0nbhsdjWbaRzCkF/nHDOVKC1
         U06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683714260; x=1686306260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7fqRHvgnRvB5mh9CqhIQkHQtj78V1mjTrY+n0K4wyM=;
        b=Zoa6KoZRvrUsSH3yZPeZXl+kQAfyIgGTeWoeiWy27XN2wWPZG3qC2CVSORIoo6oF8O
         pM7wTBZ/+R1Yn3dY62c/EAXlTufzDKU4yDxVs/3mrIIYB+9KmgmBDMyYl1CLlUc1Be1p
         cOiEpjEyvwsVqLXzKj+mU5COsH3CIryz/oFzXoWuO6wxXPM7zQsP8eO27Xqq/wKskLww
         NGWCsjCQ6w7Cz4DQKbNKIKO97LYh4ZdL3CpnrSHXRe7f18/kXuN96uAt479M+p6gPIjQ
         kRfiZHd5JuLNqnYwzqYnoNe2pnNfpPF09YZQUwTG4EqmLeRkr5jiwz/kj6f0XyXfdHED
         TN2A==
X-Gm-Message-State: AC+VfDwLR9Q20lXvjkl7PwugUO7oLdC1rDjRetL+vIMOvY80jiQq1X17
        hEMZpu36NbgumooWcgm9GkQv3ZvWFnwX4vtY68NF4w==
X-Google-Smtp-Source: ACHHUZ5IaRFRz709QDQCQuGIQdmAmCBNQHnaBbFFxnKsy2JE8rNTtcqDWC0Y+zspWRYlHB2CiK3dgoG8Uc0s6adZb00=
X-Received: by 2002:a05:6102:a32:b0:430:7548:c049 with SMTP id
 18-20020a0561020a3200b004307548c049mr5502855vsb.7.1683714260420; Wed, 10 May
 2023 03:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230505184318.1355446-1-etienne.carriere@linaro.org>
In-Reply-To: <20230505184318.1355446-1-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 10 May 2023 15:54:09 +0530
Message-ID: <CAFA6WYOfFm9R2GynH0bN7hQ4t81T3hkJX5JurCUDG8oOU-RZ4w@mail.gmail.com>
Subject: Re: [PATCH] char: tpm: ftpm_tee: use kernel login identifier
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Etienne,

On Sat, 6 May 2023 at 00:14, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Changes fTPM TEE driver to open the TEE session with REE kernel login
> identifier rather than public login. This is needed in case fTPM service
> it denied to user land application and restricted to kernel operating
> system services only.

This is a valid restriction to avoid any unintended use of fTPM by
user-space. But has the corresponding patch landed in fTPM TA which
would enforce this restriction?

-Sumit

>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 528f35b14fb6..6d32e260af43 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -241,7 +241,7 @@ static int ftpm_tee_probe(struct device *dev)
>         /* Open a session with fTPM TA */
>         memset(&sess_arg, 0, sizeof(sess_arg));
>         export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
> -       sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> +       sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
>         sess_arg.num_params = 0;
>
>         rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
> --
> 2.25.1
>
