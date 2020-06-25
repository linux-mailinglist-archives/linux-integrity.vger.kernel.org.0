Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ADE20A7ED
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 00:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405083AbgFYWAk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 18:00:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:59727 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390621AbgFYWAj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 18:00:39 -0400
IronPort-SDR: AiVQ02Ei4UOsl6ECosMiHVydwCJnm8cnUlnx2ZSUlLsLasoN0mU8qdBR67SBljjAMY2rNcC132
 5jXVJ7RfaX6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="206618487"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="206618487"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 15:00:35 -0700
IronPort-SDR: yCzSdiiLKPj8zl4rdaFKRBUkeCfWTbaRJqt88Q2Y7mnE9nDCCD8VSkLl4xoagm1OzW3Znar/l6
 TMvZJbUWf19g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="299062276"
Received: from jproldan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.123])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2020 15:00:25 -0700
Date:   Fri, 26 Jun 2020 01:00:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Christophe Ricard <christophe-h.ricard@st.com>
Subject: Re: [PATCH v12 3/9] tpm: tpm_tis: Add retry in case of protocol
 failure.
Message-ID: <20200625220023.GI20341@linux.intel.com>
References: <20200625144650.269719-1-amirmizi6@gmail.com>
 <20200625144650.269719-4-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625144650.269719-4-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 05:46:43PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Added a retry mechanism on any protocol error when sending a command or
> receiving a response. This was changed to comply with
> the TCG PC Client Device Driver Design Principles for TPM 2.0.

We don't have to comply with this.

> When sending a command, a loop is added in "tpm_tis_send_main()" that calls
> "tpm_tis_send_data()" and then issues a retry attempt if any error occurs.
> When receiving a response, the following new function derived from
> "tpm_tis_recv()" is added: "__tpm_tis_recv()". "tpm_tis_recv()" is modified
> to call "__tpm_tis_recv()" in a loop. If any error occurs, a retry is
> initiated by setting TPM_STS.responseRetry and "__tpm_tis_recv()" is
> called again.
> In both cases a retry is attempted up to "TPM_RETRY" times.
> 
> Co-developed-by: Christophe Ricard <christophe-h.ricard@st.com>
> Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 62 ++++++++++++++++++++++++++---------------
>  drivers/char/tpm/tpm_tis_core.h |  1 +
>  2 files changed, 41 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 6b33620..e136467 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -305,29 +305,24 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
>  	return size;
>  }
>  
> -static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +static int __tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	int size = 0;
>  	int status;
>  	u32 expected;
>  
> -	if (count < TPM_HEADER_SIZE) {
> -		size = -EIO;
> -		goto out;
> -	}
> -
>  	size = recv_data(chip, buf, TPM_HEADER_SIZE);
>  	/* read first 10 bytes, including tag, paramsize, and result */
>  	if (size < TPM_HEADER_SIZE) {
>  		dev_err(&chip->dev, "Unable to read header\n");
> -		goto out;
> +		return size;
>  	}
>  
>  	expected = be32_to_cpu(*(__be32 *) (buf + 2));
>  	if (expected > count || expected < TPM_HEADER_SIZE) {
>  		size = -EIO;
> -		goto out;
> +		return size;
>  	}
>  
>  	size += recv_data(chip, &buf[TPM_HEADER_SIZE],
> @@ -335,22 +330,45 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  	if (size < expected) {
>  		dev_err(&chip->dev, "Unable to read remainder of result\n");
>  		size = -ETIME;
> -		goto out;
> +		return size;
>  	}
>  
>  	if (tpm_tis_wait_for_stat(chip, TPM_STS_VALID, TPM_STS_VALID,
>  				  chip->timeout_c, &priv->int_queue,
>  				  false) < 0) {
>  		size = -ETIME;
> -		goto out;
> +		return size;
>  	}
> +
>  	status = tpm_tis_status(chip);
>  	if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
>  		dev_err(&chip->dev, "Error left over data\n");
>  		size = -EIO;
> +		return size;
> +	}
> +
> +	return size;
> +}
> +
> +static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	int size;
> +	int i;
> +
> +	if (count < TPM_HEADER_SIZE) {
> +		size = -EIO;
>  		goto out;
>  	}
>  
> +	for (i = 0; i < TPM_RETRY; i++) {
> +		size = __tpm_tis_recv(chip, buf, count);
> +		if (size <= 0)
> +			tpm_tis_write8(priv, TPM_STS(priv->locality),
> +				       TPM_STS_RESPONSE_RETRY);
> +		else
> +			goto out;
> +	}
>  out:
>  	tpm_tis_ready(chip);
>  	return size;
> @@ -375,7 +393,7 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  					  chip->timeout_b, &priv->int_queue,
>  					  false) < 0) {
>  			rc = -ETIME;
> -			goto out_err;
> +			return rc;
>  		}
>  	}
>  
> @@ -384,13 +402,13 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  		if (burstcnt < 0) {
>  			dev_err(&chip->dev, "Unable to read burstcount\n");
>  			rc = burstcnt;
> -			goto out_err;
> +			return rc;
>  		}
>  		burstcnt = min_t(int, burstcnt, len - count);
>  		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
>  					 burstcnt, buf + count);
>  		if (rc < 0)
> -			goto out_err;
> +			return rc;
>  
>  		count += burstcnt;
>  	}
> @@ -398,14 +416,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  				  TPM_STS_VALID, chip->timeout_a,
>  				  &priv->int_queue, false) < 0) {
>  		rc = -ETIME;
> -		goto out_err;
> +		return rc;
>  	}
>  
>  	return 0;
> -
> -out_err:
> -	tpm_tis_ready(chip);
> -	return rc;
>  }
>  
>  static void disable_interrupts(struct tpm_chip *chip)
> @@ -434,13 +448,17 @@ static void disable_interrupts(struct tpm_chip *chip)
>  static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	int rc;
> +	int rc, i;
>  	u32 ordinal;
>  	unsigned long dur;
>  
> -	rc = tpm_tis_send_data(chip, buf, len);
> -	if (rc < 0)
> -		return rc;
> +	for (i = 0; i < TPM_RETRY; i++) {
> +		rc = tpm_tis_send_data(chip, buf, len);
> +		if (rc >= 0)
> +			break;
> +	}
> +	if (i == TPM_RETRY)
> +		goto out_err;
>  
>  	/* go and do it */
>  	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index d06c65b..6cc6b76 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -34,6 +34,7 @@ enum tis_status {
>  	TPM_STS_GO = 0x20,
>  	TPM_STS_DATA_AVAIL = 0x10,
>  	TPM_STS_DATA_EXPECT = 0x08,
> +	TPM_STS_RESPONSE_RETRY = 0x02,
>  };
>  
>  enum tis_int_flags {
> -- 
> 2.7.4
> 

Just based on the explanation this looks like a bunch of unconsidered
changes. You have explain yourself better.

/Jarkko
