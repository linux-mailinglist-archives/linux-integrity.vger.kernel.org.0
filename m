Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD615704C0
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2019 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfGVP6j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jul 2019 11:58:39 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:46796 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfGVP6j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jul 2019 11:58:39 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D395772CCDB;
        Mon, 22 Jul 2019 18:58:35 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 9A1794A4AE8;
        Mon, 22 Jul 2019 18:58:35 +0300 (MSK)
Date:   Mon, 22 Jul 2019 18:58:35 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Message-ID: <20190722155835.yaxtxlse4nufmbxq@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <1563802368-8460-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1563802368-8460-1-git-send-email-zohar@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Jul 22, 2019 at 09:32:48AM -0400, Mimi Zohar wrote:
> The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> application is required to read PCRs.
> 
> This patch adds tsspcrread support for reading the TPM 2.0 PCRs.
> tsspcrread is one application included in the ibmtss package.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  configure.ac    |  3 +++
>  src/Makefile.am |  3 +++
>  src/evmctl.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 9e0926f10404..cbb9397be138 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1402,6 +1400,38 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
>  	return result;
>  }
>  
> +#ifdef IBMTSS
> +static int tpm_pcr_read2(int idx, uint8_t *hwpcr, int len, char **errmsg)
> +{
> +	FILE *fp;
> +	char pcr[100];	/* may contain an error */
> +	char cmd[36];
> +	int ret = 0;
> +	int i;
> +
> +	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns", idx);
> +	fp = popen(cmd, "r");
> +	if (!fp)
> +		return -1;
> +
> +	fgets(pcr, 100, fp);

Should it be sizeof(pcr)?

I don't know convention of `tsspcrread' but maybe fgets() return value
should be checked too in case of error of executing `tsspcrread' or
error inside of `tsspcrread' (like pcr read error).

> +
> +	/* pcr might contain an error message */
> +	for (i = 0; i < strlen(pcr) - 1 && !ret; i++) {
> +		if (isspace(pcr[i]))
> +			ret = -1;

Probably `strlen(pcr)' should be without `- 1'.

> +	}
> +
> +	if (!ret)
> +		hex2bin(hwpcr, pcr, SHA_DIGEST_LENGTH);
> +	else
> +		*errmsg = pcr;

pcr isn't static nor malloc'ed.

> +
> +	pclose(fp);
> +	return ret;
> +}
> +#endif
> +
>  #define TCG_EVENT_NAME_LEN_MAX	255
>  
>  struct template_entry {
> @@ -1658,8 +1688,21 @@ static int ima_measurement(const char *file)
>  		log_info("PCRAgg %.2d: ", i);
>  		log_dump(pcr[i], SHA_DIGEST_LENGTH);
>  
> -		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr)))
> -			exit(1);
> +		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
> +#ifdef IBMTSS
> +			char *errmsg = NULL;
> +
> +			err = tpm_pcr_read2(i, hwpcr, sizeof(hwpcr), &errmsg);
> +			if (err) {
> +				log_info("Failed to read either TPM 1.2 or TPM 2.0 PCRs.\n\t %s", errmsg);
> +				exit(-1);
> +			}
> +#else
> +			log_info("Failed to read TPM 1.2 PCRs.\n");
> +			exit(-1);
> +#endif
> +		}
> +
>  		log_info("HW PCR-%d: ", i);
>  		log_dump(hwpcr, sizeof(hwpcr));
>  
> -- 
> 2.7.5
