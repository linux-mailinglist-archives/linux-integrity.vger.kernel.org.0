Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1B172A284
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 20:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjFISpG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 14:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjFISor (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 14:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B793592;
        Fri,  9 Jun 2023 11:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A79E660EF4;
        Fri,  9 Jun 2023 18:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63854C433EF;
        Fri,  9 Jun 2023 18:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686336286;
        bh=pihIVeCO0gOfuNJlqGg3aq6GOveeaGOoSfBvsk/EtTM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=bw+lcmINupkhaJdXwiycSeSUulsjgJfjUbrksYuZ4LyvzrIjOEOWeXbcxSqTq/TTJ
         eb91T5WZ9EJTkDMaPIlmk1U1hJv2F5Kn4S/9gB0+j21MVewudriMJBxwll+buz/SSF
         gJ2irLcjXu9VMirq7qE+YC1ahyjCa7WBpxUepPph7aYHOZ6aiTTosv6/Lx4WrF2wVF
         Y5/fCRfvtjG3IhdwNDPWv/f0Pvp9nZaO8GJZEEDY6NPJf0etneHD9ty5jmvkhRE4v9
         rdeAV8EFcRsnCrpBaaZTYBg5o/f5u5GLivM7QjSQ8TkckR57DG5/B9kVz6xBrtTSZj
         txq5NIpOjVkUw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 21:44:40 +0300
Message-Id: <CT8CBKCY3UD2.C96MBPT0BHFD@suppilovahvero>
Cc:     <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <jsnitsel@redhat.com>, <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] tpm: tpm_tis: Narrow the AAEON DMI quirk to UPX-i11
 only
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
        <peterhuewe@gmx.de>
X-Mailer: aerc 0.14.0
References: <20230524085844.11580-1-peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230524085844.11580-1-peter.ujfalusi@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed May 24, 2023 at 11:58 AM EEST, Peter Ujfalusi wrote:
> The original patch which added the quirk would apply to all AAEON machine=
s,
> which might or might not be valid.
>
> The issue was discovered on UPX-i11 (Tiger Lake), it is not known if the
> i12 (Alder Lake) version is affected.
> UP2 (Apollo Lake) does not even have TPM module (no TPM drivers probing
> and confirmed by dmidecode).
>
> Let's make the quirk to be applicable for UPX-i11 (UPX-TGL01) only.
>
> Fixes: 95a9359ee22f ("tpm: tpm_tis: Disable interrupts for AEON UPX-i11")
> Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
> Hi Jarkko,
>
> Changes since v1:
> - Findings from Paul Menzel in the commit message has been addressed
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


I had this already applied:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/comm=
it/?id=3D20e0e7d7ec975897f40b4ee635266d36f9083856

BR, Jarkko
