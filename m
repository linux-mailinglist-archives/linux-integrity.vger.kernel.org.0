Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876826EBD31
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 07:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDWFc0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 01:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDWFcZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 01:32:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561CBE44;
        Sat, 22 Apr 2023 22:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A92616F5;
        Sun, 23 Apr 2023 05:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4469BC433D2;
        Sun, 23 Apr 2023 05:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682227943;
        bh=ySo8KV6Boj1X+um9nPNFjCKSdasvy2Wx/qvdzH0B34Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Oq65pUqYMDYFg/VLhFnoN/SlLmb1a0jH0686Ji17AZB/rjQP9WtrSzEnjbzGLlOen
         yFm2YhdDYWfC8ip/LljIq+76o7CmAZXU2BguAnYa7bFg/wtrWIFf9xj16RtCEmzn5m
         ygf+AhsZ2s1sfTl64Xg++6llGbzpXPU/tqARn2+H7URr9FMP1GbfUdOXJCZiyeEqaI
         62t5/lWp7DA4F2eKf39kdgmSYIKUs9MM8TQnhVXNzt1lBA5/yYJLtxlg9efXcLlvrs
         iURsyvoEewtFxnAvPpkxbNXzCy0kLxBTVY3z+GEwnxdcuIP/E1FVELHEEnwcwLU5sq
         p5DTtQ5crCtdA==
Message-ID: <3dd2e6924de435f28a20f0054f710ac83fb093b6.camel@kernel.org>
Subject: Re: [PATCH v4 09/13] tpm: add hmac checks to tpm2_pcr_extend()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 23 Apr 2023 08:32:20 +0300
In-Reply-To: <20230403214003.32093-10-James.Bottomley@HansenPartnership.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
         <20230403214003.32093-10-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-04-03 at 17:39 -0400, James Bottomley wrote:
> tpm2_pcr_extend() is used by trusted keys to extend a PCR to prevent a
> key from being re-loaded until the next reboot.  To use this
> functionality securely, that extend must be protected by a session
> hmac.  This patch adds HMAC protection so tampering with the
> tpm2_pcr_extend() command in flight is detected.
>=20
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

What the heck is "check"?

The code change adds hmac pipeline for the command.

I get the code change but the description is misleading as this
does more than just add a check.

> ---
>  drivers/char/tpm/tpm2-cmd.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index b0e72fb563d9..a53a843294ed 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -216,13 +216,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx=
,
>  	return rc;
>  }
> =20
> -struct tpm2_null_auth_area {
> -	__be32  handle;
> -	__be16  nonce_size;
> -	u8  attributes;
> -	__be16  auth_size;
> -} __packed;
> -
>  /**
>   * tpm2_pcr_extend() - extend a PCR value
>   *
> @@ -236,24 +229,22 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_=
idx,
>  		    struct tpm_digest *digests)
>  {
>  	struct tpm_buf buf;
> -	struct tpm2_null_auth_area auth_area;
>  	int rc;
>  	int i;
> =20
> -	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> +	rc =3D tpm2_start_auth_session(chip);
>  	if (rc)
>  		return rc;
> =20
> -	tpm_buf_append_u32(&buf, pcr_idx);
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> +	if (rc) {
> +		tpm2_end_auth_session(chip);
> +		return rc;
> +	}
> =20
> -	auth_area.handle =3D cpu_to_be32(TPM2_RS_PW);
> -	auth_area.nonce_size =3D 0;
> -	auth_area.attributes =3D 0;
> -	auth_area.auth_size =3D 0;
> +	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> +	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> =20
> -	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
> -	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
> -		       sizeof(auth_area));
>  	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> =20
>  	for (i =3D 0; i < chip->nr_allocated_banks; i++) {
> @@ -262,7 +253,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_id=
x,
>  			       chip->allocated_banks[i].digest_size);
>  	}
> =20
> +	tpm_buf_fill_hmac_session(chip, &buf);
>  	rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value")=
;
> +	rc =3D tpm_buf_check_hmac_response(chip, &buf, rc);
> =20
>  	tpm_buf_destroy(&buf);
> =20

BR, Jarkko

