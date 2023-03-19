Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEFD6C0220
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Mar 2023 14:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCSNpm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Mar 2023 09:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCSNpl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Mar 2023 09:45:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031311E2AA;
        Sun, 19 Mar 2023 06:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FA63B80B93;
        Sun, 19 Mar 2023 13:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0795BC433D2;
        Sun, 19 Mar 2023 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679233537;
        bh=6cn3HNLfLYBgaBUQoVOOYAA+mt6uEPTvkYutYN40OOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJAcomoBILh4SU1eor8j/oJBNTmQ3+kTndeDQg3yE31rj0z0vodLU+qQeaJiYEKxx
         gYMpdRQSHxxVsumMqVI81jhCF67Q24d6ycPSYtTIMVOvpbXUXiYftm6jJAlomqxx0s
         ISpapmDaaE5NwpHwXBnvIt7l3CHb7EtkIbZgZx4WgweQNUaAfqGKf/YsiDfRF+KesA
         8SQ4S7RaeNavdSgKuzknEm1uGEny0jVeJRJca4u6UNwIgmGwL0qJ0GLgYr3MQoTjqG
         x6OdZj9CUAdawTz4YowaZJs1bbUTjyaGrMxVBxLjWGNWluGP+NH7lo32zJIU7J740t
         Lcq+RyNNGDYYw==
Date:   Sun, 19 Mar 2023 15:45:33 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
Subject: Re: [PATCH] tpm: remove unnecessary (void*) conversions
Message-ID: <20230319134533.f63ajqelx6eeadnh@kernel.org>
References: <20230316085037.21255-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316085037.21255-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 16, 2023 at 04:50:37PM +0800, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/char/tpm/eventlog/common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
> index 8512ec76d526..639c3f395a5a 100644
> --- a/drivers/char/tpm/eventlog/common.c
> +++ b/drivers/char/tpm/eventlog/common.c
> @@ -36,7 +36,7 @@ static int tpm_bios_measurements_open(struct inode *inode,
>  		inode_unlock(inode);
>  		return -ENODEV;
>  	}
> -	chip_seqops = (struct tpm_chip_seqops *)inode->i_private;
> +	chip_seqops = inode->i_private;
>  	seqops = chip_seqops->seqops;
>  	chip = chip_seqops->chip;
>  	get_device(&chip->dev);
> @@ -55,8 +55,8 @@ static int tpm_bios_measurements_open(struct inode *inode,
>  static int tpm_bios_measurements_release(struct inode *inode,
>  					 struct file *file)
>  {
> -	struct seq_file *seq = (struct seq_file *)file->private_data;
> -	struct tpm_chip *chip = (struct tpm_chip *)seq->private;
> +	struct seq_file *seq = file->private_data;
> +	struct tpm_chip *chip = seq->private;
>  
>  	put_device(&chip->dev);
>  
> -- 
> 2.11.0
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
