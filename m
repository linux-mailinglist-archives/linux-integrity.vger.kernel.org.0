Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779A97A75C
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 13:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfG3L52 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 07:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfG3L51 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 07:57:27 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 878EF2089E;
        Tue, 30 Jul 2019 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564487846;
        bh=JpegaHvxgfMR7/2R1sPMIg//HlHVHOCwT5dw+hQXxTU=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=lOkCmvZrbzv4vQWBrGaRx26tnamjO1CcUoclckrDMonB2pl+sPFu4ppNMoM2VdniK
         oOrrQvYrtFvdR3jFNdKLJqBCh3qcEmASgQGjEwfbuPKeC9O61Ol/U5NcBrbPTt5E/5
         rWIZB7e76ETAHUYwUqSwWM4sRz7iEuJaDjz4OP0s=
Message-ID: <1564487830.4189.39.camel@kernel.org>
Subject: Re: [PATCH 2/2] ima-evm-utils: Never exit with -1 code
From:   Mimi Zohar <zohar@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 30 Jul 2019 07:57:10 -0400
In-Reply-To: <20190727031900.7140-2-vt@altlinux.org>
References: <20190727031900.7140-1-vt@altlinux.org>
         <20190727031900.7140-2-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-07-27 at 06:19 +0300, Vitaly Chikunov wrote:
> Change main() return code from -1 to 125 as -1 is not really valid exit
> code. 125 is choosen because exit codes for signals start from 126.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  src/evmctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index d33a91e..e0a835f 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2100,6 +2100,8 @@ int main(int argc, char *argv[])
>  				break;
>  			log_err("%s\n", ERR_error_string(error, NULL));
>  		}
> +		if (err < 0)
> +			err = 125;
>  	}
>  
>  	if (eng) {

Agreed we need to return better errors, but instead of always
returning 125, would it be better to return the first errno, if err is
-1?

Mimi
