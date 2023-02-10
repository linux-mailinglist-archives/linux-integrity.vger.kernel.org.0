Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04E66915E1
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 01:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBJAtu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Feb 2023 19:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjBJAtt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Feb 2023 19:49:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989215AB13;
        Thu,  9 Feb 2023 16:49:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35F1F61BA3;
        Fri, 10 Feb 2023 00:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FB5C433EF;
        Fri, 10 Feb 2023 00:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675990187;
        bh=/9pZPjhGregYgyGBli1F509L9Us3OCm+IFyNl5iWJ8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XF9p3BMwvlGA4JxWHDAdXH9XcB0wCIaTV0lLdQFoSVJ+f4VAbCOajaBG26j/M61mb
         U6y2Meb48G9uqdtr7QDx0XACvBFMlWLyL0iBedHPPIGj3DQ4KN/PBo3LZqirMt+y7e
         PS1/poZTcWKhD/d5PsKgnJKYVasnpIxg6Jwp8z3mp3OU9MLhZKHP3wrDDZ14483H8U
         AvoD4QNfWWABXxR6L6kxowuW+QXb8yOP7hD5Ucaors6OQyTie+cWtoaRQ/QMcC8iVa
         QnSDsHk3Vg/BfoaVpf1NaM1f8L7UW38fccv+mhO9NSeYOhWqTkrs5YEPCk1Idr2lsb
         zp+Fx94WGJoYA==
Date:   Fri, 10 Feb 2023 02:49:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Julien Gomes <julien@arista.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jgg@ziepe.ca, peterhuewe@gmx.de
Subject: Re: [PATCH] tpm: add vendor flag to command code validation
Message-ID: <Y+WUqcNTc8t0KIyD@kernel.org>
References: <20230208195836.30175-1-julien@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208195836.30175-1-julien@arista.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 08, 2023 at 11:58:36AM -0800, Julien Gomes wrote:
> Some TPM 2.0 devices have support for additional commands which are not
> part of the TPM 2.0 specifications.
> These commands are identified with bit 29 of the 32 bits command codes.
> Contrarily to other fields of the TPMA_CC spec structure used to list
> available commands, the Vendor flag also has to be present in the
> command code itself (TPM_CC) when called.
> 
> Add this flag to tpm_find_cc() mask to prevent blocking vendor command
> codes that can actually be supported by the underlying TPM device.
> 
> Signed-off-by: Julien Gomes <julien@arista.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 4 +++-
>  include/linux/tpm.h         | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 65d03867e114..93545be190a5 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -777,10 +777,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  
>  int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
>  {
> +	u32 cc_mask;
>  	int i;
>  
> +	cc_mask = 1 << TPM2_CC_ATTR_VENDOR | GENMASK(15, 0);
>  	for (i = 0; i < chip->nr_commands; i++)
> -		if (cc == (chip->cc_attrs_tbl[i] & GENMASK(15, 0)))
> +		if (cc == (chip->cc_attrs_tbl[i] & cc_mask))
>  			return i;
>  
>  	return -1;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index dfeb25a0362d..4dc97b9f65fb 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -265,6 +265,7 @@ enum tpm2_startup_types {
>  enum tpm2_cc_attrs {
>  	TPM2_CC_ATTR_CHANDLES	= 25,
>  	TPM2_CC_ATTR_RHANDLE	= 28,
> +	TPM2_CC_ATTR_VENDOR	= 29,
>  };
>  
>  #define TPM_VID_INTEL    0x8086
> -- 
> 2.39.1
> 

Just checking: did you run testing/selftests/tpm2?

BR, Jarkko
