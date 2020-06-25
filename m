Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7620A7F1
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391314AbgFYWCY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 18:02:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:28028 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390431AbgFYWCY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 18:02:24 -0400
IronPort-SDR: DmC4P91v2JiNRWw03I36NYigDecAwVU4dtnYh2nHSkqTmK5NQM2ttxJ3lYPjG/a2X4TBVKMd6y
 Xb4R4lFsqqiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="125322478"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="125322478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 15:02:23 -0700
IronPort-SDR: gDHQaT1VFcIUjjilKxCrtBQl2lM/KCJFtD9n7mv4x1PGWxE08O4Kz+dw5JyNozokOjcRB+CLDS
 vCcbmsbPhBYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="299070067"
Received: from jproldan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.123])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2020 15:02:13 -0700
Date:   Fri, 26 Jun 2020 01:02:11 +0300
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
Subject: Re: [PATCH v12 4/9] tpm: tpm_tis: Add verify_data_integrity handle
 to tpm_tis_phy_ops
Message-ID: <20200625220211.GJ20341@linux.intel.com>
References: <20200625144650.269719-1-amirmizi6@gmail.com>
 <20200625144650.269719-5-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625144650.269719-5-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 05:46:44PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> When using I2C bus protocol, the TPM has the ability to report data
> integrity on incoming or outgoing command parameter bytes.
> According to the TCG specs, if this data validation functionality is
> enabled via the TPM_DATA_CSUM_ENABLE register, the TPM will update the
> TPM_DATA_CSUM register after reception of the last command byte and after
> the last response byte has been read.
> 
> Data integrity is checked if a "verify_data_integrity" handle is defined in
> "tpm_tis_phy_ops".
> 
> Co-developed-by: Christophe Ricard <christophe-h.ricard@st.com>
> Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
>  drivers/char/tpm/tpm_tis_core.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index e136467..347c020 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -347,6 +347,13 @@ static int __tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  		return size;
>  	}
>  
> +	if (priv->phy_ops->verify_data_integrity)
> +		if (!priv->phy_ops->verify_data_integrity(priv, buf,
> +							  size)) {
> +			size = -EIO;
> +			return size;
> +		}
> +
>  	return size;
>  }
>  
> @@ -419,6 +426,13 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  		return rc;
>  	}
>  
> +	if (priv->phy_ops->verify_data_integrity) {
> +		if (!priv->phy_ops->verify_data_integrity(priv, buf, len)) {
> +			rc = -EIO;
> +			return rc;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 6cc6b76..cd97c01 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -107,6 +107,8 @@ struct tpm_tis_phy_ops {
>  	int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
>  	int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
>  	int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
> +	bool (*verify_data_integrity)(struct tpm_tis_data *data, const u8 *buf,
> +				      size_t len);
>  };
>  
>  static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
> -- 
> 2.7.4
> 

As I've said before, I'm not too eager to add a new callback and nothing
in the commit message rationalizes adding one.

/Jarkko
