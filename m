Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3FB716FFC
	for <lists+linux-integrity@lfdr.de>; Tue, 30 May 2023 23:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjE3Vtn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 May 2023 17:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjE3Vtm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 May 2023 17:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF0106;
        Tue, 30 May 2023 14:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AECF63416;
        Tue, 30 May 2023 21:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5A8C433D2;
        Tue, 30 May 2023 21:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685483366;
        bh=5oIwCqCir5jB2Br6o61VvIC/4/icgjdiRujTDZBNqoo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RSzA4IrFeGxmoG5Db8At8SUEYV9Hdetx5lHT97oxvL4xbeCYYO5OVN48fGZEo6BPE
         vGyTaQwdhebSigVyULfEmgbtCa7gRi4CsSMDMZOP04Wgx3JkGljlFvzs5rXC516Q6k
         jBNkUpDsexb7ywaDh+LPIc/zwYbvnKtT94mwyg40sk3jz9jurQpEe15Z85TDK80P+R
         DuDX5hbaeKdk+TAZZnmmp7OR25enaqMyqd/1n/3qzD2vCCth9GzpcAFUXrG+NWQ1U1
         GOxaRsM4cjo/B1EiUX2nSq1UtU+GSOrT5+19SDVL035OO7G2qHP8+L7gUDDkpN3yd0
         OuBTas+KB8y4w==
Message-ID: <5d359d2b24670e37b9ff8cac7e922c46af30d3ba.camel@kernel.org>
Subject: Re: [PATCH] tpm: factor out the user space mm from
 tpm_vtpm_set_locality()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alejandro Cabrera <alejandro.cabreraaldaya@tuni.fi>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        stable@vger.kernel.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 May 2023 00:49:21 +0300
In-Reply-To: <20230530205001.1302975-1-jarkko@kernel.org>
References: <20230530205001.1302975-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-05-30 at 23:50 +0300, Jarkko Sakkinen wrote:
> -	if (!(proxy_dev->state & STATE_DRIVER_COMMAND) &&
> -	    vtpm_proxy_is_driver_command(chip, buf, count))
> +	if ((chip->flags & TPM_CHIP_FLAG_TPM2) && ord =3D=3D TPM2_CC_SET_LOCALI=
TY)
> +		return -EFAULT;
> +
> +	if (ord =3D=3D TPM_ORD_SET_LOCALITY)
>  		return -EFAULT;

Oops, should really be:

diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_=
proxy.c
index 83496742cc19..6da878952a0d 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -337,8 +337,7 @@ static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip=
, u8 *buf, size_t count)
=20
 	if ((chip->flags & TPM_CHIP_FLAG_TPM2) && ord =3D=3D TPM2_CC_SET_LOCALITY=
)
 		return -EFAULT;
-
-	if (ord =3D=3D TPM_ORD_SET_LOCALITY)
+	else if (ord =3D=3D TPM_ORD_SET_LOCALITY) /* TPM 1.2 */
 		return -EFAULT;
=20
 	mutex_lock(&proxy_dev->buf_lock);


BR, Jarkko
