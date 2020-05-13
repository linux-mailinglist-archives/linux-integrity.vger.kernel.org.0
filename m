Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EBD1D22DC
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 01:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbgEMXRj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 19:17:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:59913 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732161AbgEMXRj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 19:17:39 -0400
IronPort-SDR: 5cFd2ESeM1t13rxrmZF/eEC+3XEj/3WS+NyuWAGuX3hLu2sIEGoFvpbFaUyi07Ymz+jQBBIbeM
 L/e6bEQ3+f0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 16:17:38 -0700
IronPort-SDR: 28JTCwJ+4DmAUcv9FPKxsgcJ4jJOUzkSUj3R3Kh76MHAUCrISs355T5EXCQmbvEtAjGDpMQ/q7
 lkfJJx4RUHDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="306922482"
Received: from rthurerx-mobl.ger.corp.intel.com ([10.249.36.107])
  by FMSMGA003.fm.intel.com with ESMTP; 13 May 2020 16:17:35 -0700
Message-ID: <6f7ad09530fa7491dd7a6b12f7723923544b53b4.camel@linux.intel.com>
Subject: Re: [PATCH v2] tpm: eventlog: Replace zero-length array with
 flexible-array member
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Date:   Thu, 14 May 2020 02:17:34 +0300
In-Reply-To: <20200508163826.GA768@embeddedor>
References: <20200508163826.GA768@embeddedor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-08 at 11:38 -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> Also, the following issue shows up due to the flexible-array member
> having incomplete type[4]:
> 
> drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_bios_measurements_start’:
> drivers/char/tpm/eventlog/tpm2.c:54:46: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
>    54 |  size = sizeof(struct tcg_pcr_event) - sizeof(event_header->event)
>       |                                              ^
> drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_bios_measurements_next’:
> drivers/char/tpm/eventlog/tpm2.c:102:10: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
>   102 |    sizeof(event_header->event) + event_header->event_size;
>       |          ^
> drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_binary_bios_measurements_show’:
> drivers/char/tpm/eventlog/tpm2.c:140:10: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
>   140 |    sizeof(event_header->event) + event_header->event_size;
>       |          ^
> scripts/Makefile.build:266: recipe for target 'drivers/char/tpm/eventlog/tpm2.o' failed
> make[3]: *** [drivers/char/tpm/eventlog/tpm2.o] Error 1
> 
> As mentioned above: "Flexible array members have incomplete type, and
> so the sizeof operator may not be applied. As a quirk of the original
> implementation of zero-length arrays, sizeof evaluates to zero."[1] As
> in "sizeof(event_header->event) always evaluated to 0, so removing it
> has no effect".
> 
> Lastly, make use of the struct_size() helper to deal with the
> flexible array member and its host structure.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> [4] https://github.com/KSPP/linux/issues/43
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>


Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

> ---
> Changes in v2:
>  - Update changelog text.
>  - Make use of the struct_size() helper.
> 
>  drivers/char/tpm/eventlog/tpm2.c | 12 +++++-------
>  include/linux/tpm_eventlog.h     |  2 +-
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
> index e741b1157525..37a05800980c 100644
> --- a/drivers/char/tpm/eventlog/tpm2.c
> +++ b/drivers/char/tpm/eventlog/tpm2.c
> @@ -51,8 +51,7 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
>  	int i;
>  
>  	event_header = addr;
> -	size = sizeof(struct tcg_pcr_event) - sizeof(event_header->event)
> -		+ event_header->event_size;
> +	size = struct_size(event_header, event, event_header->event_size);
>  
>  	if (*pos == 0) {
>  		if (addr + size < limit) {
> @@ -98,8 +97,8 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
>  	event_header = log->bios_event_log;
>  
>  	if (v == SEQ_START_TOKEN) {
> -		event_size = sizeof(struct tcg_pcr_event) -
> -			sizeof(event_header->event) + event_header->event_size;
> +		event_size = struct_size(event_header, event,
> +					 event_header->event_size);
>  		marker = event_header;
>  	} else {
>  		event = v;
> @@ -136,9 +135,8 @@ static int tpm2_binary_bios_measurements_show(struct seq_file *m, void *v)
>  	size_t size;
>  
>  	if (v == SEQ_START_TOKEN) {
> -		size = sizeof(struct tcg_pcr_event) -
> -			sizeof(event_header->event) + event_header->event_size;
> -
> +		size = struct_size(event_header, event,
> +				   event_header->event_size);
>  		temp_ptr = event_header;
>  
>  		if (size > 0)
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index c253461b1c4e..4f8c90c93c29 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -97,7 +97,7 @@ struct tcg_pcr_event {
>  	u32 event_type;
>  	u8 digest[20];
>  	u32 event_size;
> -	u8 event[0];
> +	u8 event[];
>  } __packed;
>  
>  struct tcg_event_field {

