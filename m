Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1381470F9B6
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 17:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbjEXPDy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbjEXPDx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 11:03:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E54118D;
        Wed, 24 May 2023 08:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD65161113;
        Wed, 24 May 2023 15:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AA1C433EF;
        Wed, 24 May 2023 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684940624;
        bh=GQ39HFArqnpY9EgAaymRmiUVZPopbuR/kCwYSgwwPrQ=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Je5/6b0vYjbcwZOVNGDX08VSW8Y//bzP1iPGenJ+L7L5Kqd/Spslb6MxFkvOPdeLv
         l9WGidl8gTKDAfE1xwnQXRN9tLMUa1KU5SO1A61uBRwoaJjIq/F6sjqNgCmwpNHhvY
         KzE5jPuHfN7oiQQ68JtJRPI70ngd2oLyYO03UavcW+v9ZDp+J1ZpjgRjDq8Goll1gh
         5ugUp/OVESNiA7Vjm0fzm2tousrHRu1DrVPKGOoknb8Jg6YY7TFerlN1RlkwefZNHj
         6fRtlBPzR+0m1ln/nBRO3WhWvufJgfTWYSMabocma8/Jywr0HPQzYtUF0MvRtPTckx
         E9g3Y/Gno4Czw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 18:03:40 +0300
Message-Id: <CSULLN90KNGF.3O4NO1OTCWBIP@suppilovahvero>
Cc:     <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm: tpm_tis: Narrow the AAEON DMI quirk to UPX-i11
 only
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
        <peterhuewe@gmx.de>
X-Mailer: aerc 0.14.0
References: <20230524055815.10165-1-peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230524055815.10165-1-peter.ujfalusi@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed May 24, 2023 at 8:58 AM EEST, Peter Ujfalusi wrote:
> The original patch which added the quirk would apply to all AAEON machine=
s,
> which might or might not be valid.
>
> The issue was discovered on UPX-i11 (TigerLake), it is not known if the
> i12 (AlderLake) version is affected.
> UP2 (ApolloLake) does not even have TMP module (no TPM drivers probing
> and confirmed by dmidecode).
>
> Let's make the quirk to be applicable for UPX-i11 (UPX-TGL01) only.
>
> Fixes: 95a9359ee22f ("tpm: tpm_tis: Disable interrupts for AEON UPX-i11")
> Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
> Hi Jarkko,
>
> the patch is generated on top of your
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git : ir=
q-storm
>
> Regards,
> Peter
>
>  drivers/char/tpm/tpm_tis.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 7db3593941ea..4357d4ba8f9e 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -143,6 +143,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[]=
 =3D {
>  		.ident =3D "UPX-TGL",
>  		.matches =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01"),
>  		},
>  	},
>  	{}
> --=20
> 2.40.1

Thanks Peter. I will apply this.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
