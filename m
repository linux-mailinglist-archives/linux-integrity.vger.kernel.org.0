Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E675292F4F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 22:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgJSUXh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 16:23:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:40320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgJSUXh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 16:23:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23E96AC3F;
        Mon, 19 Oct 2020 20:23:36 +0000 (UTC)
Date:   Mon, 19 Oct 2020 22:23:34 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] file2bin: Pass the right values to size and count
 parameters for fread()
Message-ID: <20201019202334.GA13621@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201019200526.12678-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019200526.12678-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

> The 2nd parameter to fread() namely "size" specifies the size, in
> bytes of each element to be read, and the 3rd parameter namely "count"
> specifies the number of elements, each one with a size of "size" bytes.

>  size_t fread ( void * ptr, size_t size, size_t count, FILE * stream );

> But in the function file2bin() the values passed to "size" and "count"
> are reversed causing the function to return an error eventhough the file
> was sucdessfully read.

> Pass the right values to "size" and "count" parameters for fread() in
> the function file2bin().

> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM.


Kind regards,
Petr

> ---
>  src/evmctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/src/evmctl.c b/src/evmctl.c
> index 7ad1150..d49988e 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -221,7 +221,8 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
>  		fclose(fp);
>  		return NULL;
>  	}
> -	if (fread(data, len, 1, fp) != len) {
> +
> +	if (fread(data, 1, len, fp) != len) {
>  		log_err("Failed to fread %zu bytes: %s\n", len, name);
>  		fclose(fp);
>  		free(data);
