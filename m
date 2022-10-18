Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3970D602450
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 08:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJRGZR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 02:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJRGZP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 02:25:15 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530305F7F;
        Mon, 17 Oct 2022 23:25:10 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8748530024DBD;
        Tue, 18 Oct 2022 08:25:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6AB8A61F9A; Tue, 18 Oct 2022 08:25:08 +0200 (CEST)
Date:   Tue, 18 Oct 2022 08:25:08 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v8 08/11] tpm, tpm: Implement usage counter for locality
Message-ID: <20221018062508.GB25237@wunner.de>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-9-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017235732.10145-9-LinoSanfilippo@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 18, 2022 at 01:57:29AM +0200, Lino Sanfilippo wrote:
> Implement a usage counter for the (default) locality used by the TPM TIS
> driver:
> Request the locality from the TPM if it has not been claimed yet, otherwise
> only increment the counter. Also release the locality if the counter is 0
> otherwise only decrement the counter. Ensure thread-safety by protecting
> the counter with a mutex.
> 
> This allows to request and release the locality from a thread and the
> interrupt handler at the same time without the danger to interfere with
> each other.
[...]
> +static int tpm_tis_release_locality(struct tpm_chip *chip, int l)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  
> -	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> +	mutex_lock(&priv->locality_count_mutex);
> +	priv->locality_count--;
> +	if (priv->locality_count == 0)
> +		tpm_tis_release_locality_locked(priv, l);
> +	mutex_unlock(&priv->locality_count_mutex);
>  
>  	return 0;
>  }

Hm, any reason not to use struct kref for the locality counter?
Provides correct memory ordering (no mutex needed) and allows for
calling a release function too upon reaching 0.

Thanks,

Lukas
