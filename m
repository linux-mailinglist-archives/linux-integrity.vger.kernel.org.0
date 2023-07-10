Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF974DE10
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 21:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGJTUi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 15:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGJTUi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 15:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2891595;
        Mon, 10 Jul 2023 12:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B67496119A;
        Mon, 10 Jul 2023 19:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2881C433C7;
        Mon, 10 Jul 2023 19:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689016835;
        bh=EcUHuJp/TGc/f/VFsCbSWVn6xHI6mjyOOrU3G4PfPY0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aD5rQtuEleK3/eOrwnLq4nAqYlTqUNtyzdo2XUL9LLl3LS3d04CvlPlUDu8FvOtXo
         hxTmxbWQ6Pq0VrcQpLM08ZxZGK8g9iwoif133jCfCoSZKfE03c+WCN52elrf6hpGlE
         E7++XBt5nBZyKYoliDLlmvjzKd0juyQ/YpeWGoHoAI2CzDjYn3UF1hfJTwbG521CUg
         G6GwMUhNtwo5f4DwOJqu4YxBF2EXBs+8ul/7uAC/bNIFye32FXPhd+qJegwTcmlruU
         QqFRnhLjigU6dmcITtd0rQxzI6o4zhXm/neiXE3s/ObyEZQP1e4oRy1/ytyYS/qp6u
         5O8NXNAoY8NCw==
Message-ID: <63aff66215d816a899f0d567b64ae82f94ae77be.camel@kernel.org>
Subject: Re: [PATCH] security: keys: Modify mismatched function name
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Moore <paul@paul-moore.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date:   Mon, 10 Jul 2023 22:20:31 +0300
In-Reply-To: <CAHC9VhSUz1zXBTFjaCDMzFCuAY6t3zG4WyXyKWBjNTwjLxZS+Q@mail.gmail.com>
References: <20230614021825.64333-1-jiapeng.chong@linux.alibaba.com>
         <CAHC9VhSUz1zXBTFjaCDMzFCuAY6t3zG4WyXyKWBjNTwjLxZS+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-06-14 at 17:52 -0400, Paul Moore wrote:
> On Tue, Jun 13, 2023 at 10:18=E2=80=AFPM Jiapeng Chong
> <jiapeng.chong@linux.alibaba.com> wrote:
> >=20
> > No functional modification involved.
> >=20
> > security/keys/trusted-keys/trusted_tpm2.c:203: warning: expecting proto=
type for tpm_buf_append_auth(). Prototype was for tpm2_buf_append_auth() in=
stead.
> >=20
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5524
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >  security/keys/trusted-keys/trusted_tpm2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Reviewed-by: Paul Moore <paul@paul-moore.com>
>=20

Thanks, I'll pick this.

BR, Jarkko

