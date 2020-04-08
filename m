Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C68E71A28BE
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2020 20:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgDHSdl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Apr 2020 14:33:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:30903 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgDHSdk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Apr 2020 14:33:40 -0400
IronPort-SDR: akVgsWG1LFQ6zb8rrQd0GDyfgvmVianSb6CQZYC6EZhm1zqAm/q6Z8oNJImWCoj0+ceidzHyQb
 U4Sx3dQuWc3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 11:33:36 -0700
IronPort-SDR: GTDr8ztoSNa5NKAu+XTZ1Qitnx8Qc03hoKgPRRtcFnB6vxfRWsQx/mEktUvCoyDtURFCRtxNrO
 mTA98yjLKiQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="244106653"
Received: from pratuszn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.202])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2020 11:33:26 -0700
Date:   Wed, 8 Apr 2020 21:33:24 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Christophe Ricard <christophe-h.ricard@st.com>
Subject: Re: [PATCH v6 2/7] tpm: tpm_tis: Add check_data handle to
 tpm_tis_phy_ops
Message-ID: <20200408183324.GB33486@linux.intel.com>
References: <20200407162044.168890-1-amirmizi6@gmail.com>
 <20200407162044.168890-3-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407162044.168890-3-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 07, 2020 at 07:20:39PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> In order to validate data integrity we need to compute the crc over the data
> sent in lower layer (I2C for instance).

s/crc/CRC/

> To do that tpm_tis_check_data() calls a "check_data" operation (if available).

"check_data" does not exist.

> If data integrity check fails, a retry to save the sent/received
> data is implemented in tpm_tis_send_main()/tpm_tis_recv() functions.
> 
> Considering this commit, the following steps are done when sending a command:
>    1. Host writes to TPM_STS.commandReady.
>    2. Host writes command.
>    3. Host checks that TPM received data is valid.
>    4. If data is currupted go to step 1.
> 
> When receiving data:
>    1. Host checks that TPM_STS.dataAvail is set.
>    2. Host saves received data.
>    3. Host checks that received data is correct.
>    4. If data is currupted Host writes to TPM_STS.responseRetry and go to
>       step 1.

These sequences in the commit message look somewhat uselss. Maybe
just remove them.

> 
> Co-developed-by: Christophe Ricard <christophe-h.ricard@st.com>
> Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 102 +++++++++++++++++++++++++---------------
>  drivers/char/tpm/tpm_tis_core.h |   3 ++
>  2 files changed, 67 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 27c6ca0..6c4f232 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -242,6 +242,15 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
>  	return status;
>  }
>  
> +static bool tpm_tis_check_data(struct tpm_chip *chip, const u8 *buf, size_t len)

Not sure if this is the best possible function name, "check" can
mean almost anything.

> +{
> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +
> +	if (priv->phy_ops->check_data)
> +		return priv->phy_ops->check_data(priv, buf, len);

New line here before the return statement.

> +	return true;
> +}
> +
>  static void tpm_tis_ready(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> @@ -308,47 +317,59 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	int size = 0;
> -	int status;
> +	int status, i;
>  	u32 expected;
> +	bool check_data = false;
>  
> -	if (count < TPM_HEADER_SIZE) {
> -		size = -EIO;
> -		goto out;
> -	}
> +	for (i = 0; i < TPM_RETRY; i++) {
> +		if (count < TPM_HEADER_SIZE) {
> +			size = -EIO;
> +			goto out;
> +		}
>  
> -	size = recv_data(chip, buf, TPM_HEADER_SIZE);
> -	/* read first 10 bytes, including tag, paramsize, and result */
> -	if (size < TPM_HEADER_SIZE) {
> -		dev_err(&chip->dev, "Unable to read header\n");
> -		goto out;
> -	}
> +		size = recv_data(chip, buf, TPM_HEADER_SIZE);
> +		/* read first 10 bytes, including tag, paramsize, and result */
> +		if (size < TPM_HEADER_SIZE) {
> +			dev_err(&chip->dev, "Unable to read header\n");
> +			goto out;
> +		}
>  
> -	expected = be32_to_cpu(*(__be32 *) (buf + 2));
> -	if (expected > count || expected < TPM_HEADER_SIZE) {
> -		size = -EIO;
> -		goto out;
> -	}
> +		expected = be32_to_cpu(*(__be32 *) (buf + 2));
> +		if (expected > count || expected < TPM_HEADER_SIZE) {
> +			size = -EIO;
> +			goto out;
> +		}
>  
> -	size += recv_data(chip, &buf[TPM_HEADER_SIZE],
> -			  expected - TPM_HEADER_SIZE);
> -	if (size < expected) {
> -		dev_err(&chip->dev, "Unable to read remainder of result\n");
> -		size = -ETIME;
> -		goto out;
> -	}
> +		size += recv_data(chip, &buf[TPM_HEADER_SIZE],
> +				  expected - TPM_HEADER_SIZE);
> +		if (size < expected) {
> +			dev_err(&chip->dev, "Unable to read remainder of result\n");
> +			size = -ETIME;
> +			goto out;
> +		}
>  
> -	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> -				&priv->int_queue, false) < 0) {
> -		size = -ETIME;
> -		goto out;
> +		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> +				      &priv->int_queue, false) < 0) {
> +			size = -ETIME;
> +			goto out;
> +		}
> +
> +		status = tpm_tis_status(chip);
> +		if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
> +			dev_err(&chip->dev, "Error left over data\n");
> +			size = -EIO;
> +			goto out;
> +		}
> +
> +		check_data = tpm_tis_check_data(chip, buf, size);
> +		if (!check_data)
> +			tpm_tis_write8(priv, TPM_STS(priv->locality),
> +				       TPM_STS_RESPONSE_RETRY);
> +		else
> +			break;
>  	}
> -	status = tpm_tis_status(chip);
> -	if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
> -		dev_err(&chip->dev, "Error left over data\n");
> +	if (!check_data)
>  		size = -EIO;
> -		goto out;
> -	}
> -
>  out:
>  	tpm_tis_ready(chip);
>  	return size;
> @@ -453,14 +474,19 @@ static void disable_interrupts(struct tpm_chip *chip)
>  static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	int rc;
> +	int rc, i;
>  	u32 ordinal;
>  	unsigned long dur;
> +	bool data_valid = false;
>  
> -	rc = tpm_tis_send_data(chip, buf, len);
> -	if (rc < 0)
> -		return rc;
> -
> +	for (i = 0; i < TPM_RETRY && !data_valid; i++) {
> +		rc = tpm_tis_send_data(chip, buf, len);
> +		if (rc < 0)
> +			return rc;
> +		data_valid = tpm_tis_check_data(chip, buf, len);
> +	}
> +	if (!data_valid)
> +		return -EIO;
>  	/* go and do it */
>  	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
>  	if (rc < 0)
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index d06c65b..486c2e9 100644
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
> @@ -106,6 +107,8 @@ struct tpm_tis_phy_ops {
>  	int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
>  	int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
>  	int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
> +	bool (*check_data)(struct tpm_tis_data *data, const u8 *buf,
> +			   size_t len);

Aren't you validating the contents of the buf?

/Jarkko
