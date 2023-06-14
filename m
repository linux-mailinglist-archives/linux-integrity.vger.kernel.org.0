Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1F9730A06
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jun 2023 23:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbjFNVwh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jun 2023 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjFNVwg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jun 2023 17:52:36 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8631BC
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jun 2023 14:52:34 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-56ce61769b7so12973417b3.3
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jun 2023 14:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686779553; x=1689371553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZdhhM2WIyksS9SFgf4otvNoFB1EwxYBOF+gAHVPmG8=;
        b=PXcQGsEt07YObxGudBvyTcBccv2Fq4xmvl5I8Pwzb6hW5+XL6GHtreR0xSZeiFk95+
         1klsNd4sLvF6ujNQPsQJljmBXx8XNwsGmW/XLwPKhq3qlGWRQwZwNLlxQ5MmW33JF9Qj
         ur1nzu6EdzzCxGNuFB7WMxNOmcYad8GBFCOD7LJ6Q96GjWg6BTQfWRiRKYMWPy3Zul9k
         o15bIaLGmgcE+DqUAJ+zHsf8bnesjOZ8UoTwzmpzp16cH4jIO3xno6ET6xXlUkrce35G
         m3SObnctwwIBp5WEJ4Dpnqc+oE+6qiGUrUfbCB93Tgra9QrWl8S+dClrreqAnVQ7Y1Ly
         5xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686779553; x=1689371553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZdhhM2WIyksS9SFgf4otvNoFB1EwxYBOF+gAHVPmG8=;
        b=dGQUsvfX8K9ZbNWD3dAIiNXUGDsDVqXDdERkEM4tGh7WfI4fHhdGRyxTy9ls1cqdbp
         1jESKqsJ2K1XYp06CGPzyebCC0P/PfKWIgL8CgiMsLAMTfHsT04LEZDfeGhbR+Tzmv+z
         hUAIhsqJUZA8UIyyJlTH9O1YDA0746VJOeyXWJXiY1gywwNfBdXWgtxcEf/ZbV8boPNr
         YQCG/MHe0NX9wGRO84rapKOcyYJuEsV0GUf70D0zDR+W1N4CuxRKvl7Q+bdjy8L9IYWJ
         YbBoPxE5lzrdblTBVqH+5ie3epHM68XWvGarrtCp8cHdn2SBt27ivUKJOzB7OetLq+j7
         +yqA==
X-Gm-Message-State: AC+VfDz8FPXEVKdvFUH6ivrTgD9BongYTf71ih3afXHOBku6Cw+tYwzf
        q80pCkEqBDuvhUFuh9aM5m8hWeT33fps37EJ6+yc
X-Google-Smtp-Source: ACHHUZ4sqJvwja7uZm1iFvMQmSoLOgVR1pgw6VNNtcCP2rOQqydJR0z8aPP5tWbHLjsYAPK9c1Y1duM2yF8XSfnLyQ8=
X-Received: by 2002:a81:8205:0:b0:565:a081:a925 with SMTP id
 s5-20020a818205000000b00565a081a925mr3516080ywf.29.1686779553237; Wed, 14 Jun
 2023 14:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230614021825.64333-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230614021825.64333-1-jiapeng.chong@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Jun 2023 17:52:22 -0400
Message-ID: <CAHC9VhSUz1zXBTFjaCDMzFCuAY6t3zG4WyXyKWBjNTwjLxZS+Q@mail.gmail.com>
Subject: Re: [PATCH] security: keys: Modify mismatched function name
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
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

On Tue, Jun 13, 2023 at 10:18=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> security/keys/trusted-keys/trusted_tpm2.c:203: warning: expecting prototy=
pe for tpm_buf_append_auth(). Prototype was for tpm2_buf_append_auth() inst=
ead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5524
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
