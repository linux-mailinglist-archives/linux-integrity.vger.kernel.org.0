Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09EA5956B
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2019 09:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfF1H4e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jun 2019 03:56:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36576 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF1H4d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jun 2019 03:56:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so5236161wrs.3
        for <linux-integrity@vger.kernel.org>; Fri, 28 Jun 2019 00:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=99D1Ffx7ulGv1+mS0gf0uwoTH1CY21lfb7DrhE6Anyw=;
        b=fGaqx+TxY2e/WSTUC74afbNS824jhkMiHIzaa62VKKli5j96PxgwjImtEa11BsrZDR
         qn6FGiXFRGmjZ/0kk9iCQXiwagmMsX2YN+Ph1P42SfS3FWabfRnUGMcKf7I0g7uMg6Gf
         p5xeosmTWAIwQy+n9ycKbcy1O4rYWU/Txi/3qhJsWChg1N4SwrsJCeX73yiO4d9Urj7S
         +7z25rEszSXGb7UhxXpjNnPNy6394m3ObpE3cEQA08eFplb5WB8lb6Qb5wwyTg9Imm+H
         03QwjBq5EbIKSWToYymcRd9SKhVJcxq5z0s6pP/k9Yat2KbnFr8/X3kFFPtMxS70/P9n
         5WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=99D1Ffx7ulGv1+mS0gf0uwoTH1CY21lfb7DrhE6Anyw=;
        b=c1edRi/nhLDiyDiq2Mi9NqJ80YNYTyYhe95JbyaHDuRuShi1NK3xwKoKkm0xAPRVvf
         aBKYK6wtvVt77NvWFDrUUOFIgnRqEdxNvo9SCC2dJllkltnSnEQeoPO4wreTSAsktKE5
         JT7XLvb4Rwyc4m9FGMO8Jdckewx9i5EpOSiL4nSC1z+z4F9cuIJcEYLTCsJghqyveaBc
         M3/fB7GKiXUsyRmlHaqehw9T5Ftwujn86jNmhTYsMc552ILrVkJpXHUi5XH0abvwkaa3
         ixcXcEOBtX9pJ1i1eeG67SHHKb0cIBZlZh2FUyPTeUpCQirTVF3Ib9sT2kbzsUl8kI1N
         +mug==
X-Gm-Message-State: APjAAAW4MabJCSN7vaK5GIn5id+lqzwpsXnnNz31V0qJ7/lczcaT2cz7
        Hl02qn3NeIAwsWm1jt85g+FWXYH/Nis=
X-Google-Smtp-Source: APXvYqw9M6qv06O0dTBpVMXGX0TUrWSKi9NJaV7lCFGIbnceTE4EXcEEdLHEbHMxFTn9nTP93ighMg==
X-Received: by 2002:adf:f581:: with SMTP id f1mr6867879wro.179.1561708591512;
        Fri, 28 Jun 2019 00:56:31 -0700 (PDT)
Received: from [192.168.8.100] (89-24-34-195.nat.epc.tmcz.cz. [89.24.34.195])
        by smtp.gmail.com with ESMTPSA id b5sm1325640wrq.61.2019.06.28.00.56.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 00:56:30 -0700 (PDT)
Subject: Re: [PATCH] tpm: Fix null pointer dereference on chip register error
 path
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        James Morris <jmorris@namei.org>
References: <20190612084210.13562-1-gmazyland@gmail.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <9df0a432-eb9c-914e-5ddc-2680a6fecebd@gmail.com>
Date:   Fri, 28 Jun 2019 09:56:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190612084210.13562-1-gmazyland@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

is there any problem in this with the trivial patch below?

I just get the same crash again with stable 5.1 kernel...

Milan


On 12/06/2019 10:42, Milan Broz wrote:
> If clk_enable is not defined and chip initialization
> is canceled code hits null dereference.
> 
> Easily reproducible with vTPM init fail:
>   swtpm chardev --tpmstate dir=nonexistent_dir --tpm2 --vtpm-proxy
> 
> BUG: kernel NULL pointer dereference, address: 00000000
> ...
> Call Trace:
>  tpm_chip_start+0x9d/0xa0 [tpm]
>  tpm_chip_register+0x10/0x1a0 [tpm]
>  vtpm_proxy_work+0x11/0x30 [tpm_vtpm_proxy]
>  process_one_work+0x214/0x5a0
>  worker_thread+0x134/0x3e0
>  ? process_one_work+0x5a0/0x5a0
>  kthread+0xd4/0x100
>  ? process_one_work+0x5a0/0x5a0
>  ? kthread_park+0x90/0x90
>  ret_from_fork+0x19/0x24
> 
> Signed-off-by: Milan Broz <gmazyland@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/char/tpm/tpm-chip.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 90325e1749fb..4c2af643d698 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -95,7 +95,8 @@ int tpm_chip_start(struct tpm_chip *chip)
>  	if (chip->locality == -1) {
>  		ret = tpm_request_locality(chip);
>  		if (ret) {
> -			chip->ops->clk_enable(chip, false);
> +			if (chip->ops->clk_enable)
> +				chip->ops->clk_enable(chip, false);
>  			return ret;
>  		}
>  	}
> 
