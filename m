Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136CC74E289
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 02:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGKA0d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 20:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGKA0c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 20:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32735FB;
        Mon, 10 Jul 2023 17:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A90F8612A4;
        Tue, 11 Jul 2023 00:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E615C433C9;
        Tue, 11 Jul 2023 00:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689035190;
        bh=lVrofRqiJZB0YCzZdm1yhUomL1wJDgSyd4Dqv2IN7uY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Zzk5WNDrd+OKZA4Oy4dFF3EaoRZ0C27ag8ozEM2+AH6eodYs1L5wJMZ22Bh6Yp2pc
         SFkDAv84AYDuu8JHXV56u28E54iTQhbS8gCAbHGVF0ayrPBrHaRl1ZVkC5qknoA4F/
         8fTkOJ8ZhtL7JCtf5vFzoNFvl7f+Nn86f7x2HPpIzOCCbjVpqz1I7G65SFg3QDNEkV
         9pyZNr1dulrvyyBzfWZ3rT+EMZaD543IvXLMUXIQglH0MxSObAbEBAyTtOQscapuS0
         5M0zEOz5yzgheP/kKYDq710jYhUgqNxWVtLx7AHthsyJpmFJckIGnxrVhCmqD7CWOQ
         CG6xnTANVba+Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 11 Jul 2023 03:26:26 +0300
Message-Id: <CTYX04LNR79S.H0RECMGHF1BM@suppilovahvero>
Cc:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] tpm: remove redundant variable len
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Colin Ian King" <colin.i.king@gmail.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230616170730.2343540-1-colin.i.king@gmail.com>
In-Reply-To: <20230616170730.2343540-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jun 16, 2023 at 8:07 PM EEST, Colin Ian King wrote:
> Variable len is being accumulated but the value is never read. It is
> redundant and can be removed. Cleans up clang scan build warning:
>
> drivers/char/tpm/eventlog/tpm1.c:276:2: warning: Value stored to 'len' is=
 never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/char/tpm/eventlog/tpm1.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog=
/tpm1.c
> index 8aa9057601d6..12ee42a31c71 100644
> --- a/drivers/char/tpm/eventlog/tpm1.c
> +++ b/drivers/char/tpm/eventlog/tpm1.c
> @@ -251,7 +251,6 @@ static int tpm1_binary_bios_measurements_show(struct =
seq_file *m, void *v)
> =20
>  static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v=
)
>  {
> -	int len =3D 0;
>  	char *eventname;
>  	struct tcpa_event *event =3D v;
>  	unsigned char *event_entry =3D
> @@ -273,7 +272,7 @@ static int tpm1_ascii_bios_measurements_show(struct s=
eq_file *m, void *v)
>  	/* 3rd: event type identifier */
>  	seq_printf(m, " %02x", do_endian_conversion(event->event_type));
> =20
> -	len +=3D get_event_name(eventname, event, event_entry);
> +	get_event_name(eventname, event, event_entry);
> =20
>  	/* 4th: eventname <=3D max + \'0' delimiter */
>  	seq_printf(m, " %s\n", eventname);
> --=20
> 2.39.2

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
