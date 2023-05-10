Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676A16FE711
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 00:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbjEJWNR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 May 2023 18:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbjEJWNM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 May 2023 18:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40D77DA2;
        Wed, 10 May 2023 15:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F557640CC;
        Wed, 10 May 2023 22:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3B0C433D2;
        Wed, 10 May 2023 22:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683756764;
        bh=S3ceb9z6EbsRcnJ62Na5gawRxRpsW2C5L0KZb5K+1pM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=SIHewGyAf4OkwymH2cqiUJ4gU1Y00b3cbIFSwdudnt2w2KpbStU1eWc3rIut42o+K
         HV3U7UJqF/gmcJ0xIBdXIQuHmG2/rU5BJZGdjdfFdKGHXYFWer/iuFb0iyw1aiIZ5F
         4d70on/sKYc8tEqlYxFeQYQE6KCqlY8PI6eOKqkj5pC+gxiJCj8VoKeZaEESTgFfcn
         lJqXmEt3HOHxD1GiJx+IL6bwfnETHuNe/Qun12+EIsXy4N9I9GM2aigLH/9kzGtAO8
         PS5lg0Sz4Y2fse8GyHnqyeOo9I5KHfboJ+sHaALDJU3mGHzJ5aZfO2qklCI3vD8r75
         cuQeiceuLu+ig==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 01:12:41 +0300
Message-Id: <CSIXYHYSW45R.O3II0HIIHZV4@suppilovahvero>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] char: tpm: ftpm_tee: use kernel login identifier
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Etienne Carriere" <etienne.carriere@linaro.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230505184318.1355446-1-etienne.carriere@linaro.org>
In-Reply-To: <20230505184318.1355446-1-etienne.carriere@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri May 5, 2023 at 9:43 PM EEST, Etienne Carriere wrote:
> Changes fTPM TEE driver to open the TEE session with REE kernel login
> identifier rather than public login. This is needed in case fTPM service
> it denied to user land application and restricted to kernel operating
> system services only.
>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>


Can you bring up a little context here?

What is REE login?
Does it break backwards compatibility to switch?
What kind of scenario we are talking about? What does it mean in plain
English when fTPM service is denied.
What is fTPM service?

> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_=
tee.c
> index 528f35b14fb6..6d32e260af43 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -241,7 +241,7 @@ static int ftpm_tee_probe(struct device *dev)
>  	/* Open a session with fTPM TA */
>  	memset(&sess_arg, 0, sizeof(sess_arg));
>  	export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
> -	sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_PUBLIC;
> +	sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
>  	sess_arg.num_params =3D 0;
> =20
>  	rc =3D tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
> --=20
> 2.25.1

BR, Jarkko
