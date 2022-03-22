Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1359E4E4782
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Mar 2022 21:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiCVUaW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Mar 2022 16:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbiCVUaS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Mar 2022 16:30:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD48D673EF
        for <linux-integrity@vger.kernel.org>; Tue, 22 Mar 2022 13:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2569B81D70
        for <linux-integrity@vger.kernel.org>; Tue, 22 Mar 2022 20:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639E6C340F2;
        Tue, 22 Mar 2022 20:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647980923;
        bh=2kdhs97ir49LXaSJ4AMi9yjD9O1D5v6XM5+6r75MjHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zg1QmP947aOsc+5h01upFJVU853MKDLA+8iQ1E1w79Z7IePvsqtTiI+KqFMODPTPd
         E2ei34/whKH/e8WWs2uE8L51Ibz+oUtj9qa3Vk5QfnLfOhtcOYfUmrNKla2cc8rSCt
         hZc15Eq9rL8XqGGUzXAxvVM2mtULdci+Rcsmm6V8vcdiUFVhaVUbkDD87AMjWlK4Za
         W3aBysli65mXliiYmFz4ke5BIGtBSr+WUQrgryedScfYtl7M7EBWujinnnvNyBy9iM
         TPQ8/o9Sd/yik7s+z5AXFModjdi1/OuB85we/PPQZ7crPlvQfV5kfOlqO5NXDJXZcd
         NLLYlN7Vz18hw==
Date:   Tue, 22 Mar 2022 22:27:44 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1] tpm: Fix regression in tpm_tis_synquacer.c
Message-ID: <YjoxQIU8AmPZtjQj@iki.fi>
References: <20220322105933.1242-1-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322105933.1242-1-johannes.holland@infineon.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 22, 2022 at 11:59:32AM +0100, Johannes Holland wrote:
> Remove unused variables and type mismatch (integer from pointer without
> a cast).
> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_synquacer.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
> index 2751be8e6065..679196c61401 100644
> --- a/drivers/char/tpm/tpm_tis_synquacer.c
> +++ b/drivers/char/tpm/tpm_tis_synquacer.c
> @@ -39,11 +39,6 @@ static int tpm_tis_synquacer_read_bytes(struct tpm_tis_data *data, u32 addr,
>  					enum tpm_tis_io_mode io_mode)
>  {
>  	struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> -	__le16 result_le16;
> -	__le32 result_le32;
> -	u16 result16;
> -	u32 result32;
> -
>  	switch (io_mode) {
>  	case TPM_TIS_PHYS_8:
>  		while (len--)
> @@ -69,11 +64,6 @@ static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 addr,
>  					 enum tpm_tis_io_mode io_mode)
>  {
>  	struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> -	__le16 result_le16;
> -	__le32 result_le32;
> -	u16 result16;
> -	u32 result32;
> -
>  	switch (io_mode) {
>  	case TPM_TIS_PHYS_8:
>  		while (len--)
> @@ -86,10 +76,10 @@ static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 addr,
>  		 * Due to the limitation of SPI controller on SynQuacer,
>  		 * 16/32 bits access must be done in byte-wise and descending order.
>  		 */
> -		iowrite8(&value[3], phy->iobase + addr + 3);
> -		iowrite8(&value[2], phy->iobase + addr + 2);
> -		iowrite8(&value[1], phy->iobase + addr + 1);
> -		iowrite8(&value[0], phy->iobase + addr);
> +		iowrite8(value[3], phy->iobase + addr + 3);
> +		iowrite8(value[2], phy->iobase + addr + 2);
> +		iowrite8(value[1], phy->iobase + addr + 1);
> +		iowrite8(value[0], phy->iobase + addr);
>  		break;
>  	}
>  
> -- 
> 2.31.1.windows.1
> 

Please make a fresh version of the patch:

Applying: tpm: Fix regression in tpm_tis_synquacer.c
Using index info to reconstruct a base tree...
M	drivers/char/tpm/tpm_tis_synquacer.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/char/tpm/tpm_tis_synquacer.c
CONFLICT (content): Merge conflict in drivers/char/tpm/tpm_tis_synquacer.c
error: Failed to merge in the changes.
Patch failed at 0001 tpm: Fix regression in tpm_tis_synquacer.c
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Also your CC list is lacking Jason and linux-kernel
(look into scripts/get_maintainer.pl).

BR, Jarkko
