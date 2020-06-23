Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E3F204691
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 03:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbgFWBQT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 21:16:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:26739 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbgFWBQT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 21:16:19 -0400
IronPort-SDR: oDdZZPk+Xhv0gyrLdD0HyQu5sPJFOOycrgOLdjvgpOIFWd9xZYy9k43V4209rk2Fouwh1P8pEp
 GhyCUHb6SnXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="162004049"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="162004049"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 18:15:55 -0700
IronPort-SDR: oLMGrb7kh7IRlSKdFJ1a5LSNwpkOogQn7mEoavq59npZu5vxdvdfq7Q+nYx05YaGeHbB0hftfo
 pMh+zjF1xHAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="283151657"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2020 18:15:53 -0700
Date:   Tue, 23 Jun 2020 04:15:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Stalled /dev/tpmr0 when context size increases to support RSA
 3072 bit keys
Message-ID: <20200623011551.GG28795@linux.intel.com>
References: <b404211d-f540-d2bd-eaf6-2b616bebb899@linux.ibm.com>
 <4cd7345d-78ac-c5fd-e50f-36cf0bed8489@linux.ibm.com>
 <178deb28-63aa-e1b5-2a87-29345affeb02@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178deb28-63aa-e1b5-2a87-29345affeb02@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 19, 2020 at 01:05:59PM -0400, Stefan Berger wrote:
> On 6/17/20 12:04 PM, Stefan Berger wrote:
> > On 6/16/20 6:30 PM, Stefan Berger wrote:
> > > I am upgrading libtpms's TPM 2 to support RSA 3072 keys (increase
> > > context size to 2680 bytes) and wanted to test an upgrade from
> > > previous version (0.7.2) which only supports RSA 2048 keys to this
> > > newer version (git master). I tried to run this with clevis setting
> > > up automatic decryption via TPM 2, but it doesn't work and it seems
> > > the issue is due to a stall of /dev/tpmr0 that doesn't respond
> > > anymore.
> > > 
> > > 
> > > [...]
> > > 
> > > It's stuck polling on /dev/tpmrm0.
> > > 
> > >    Any ideas?
> > 
> > It has something to do with the offset parameter and the PAGE_SIZE as a
> > limit.
> > 
> > [  842.288597] *offset=0
> > [  842.295345] *offset=2692
> > [  842.301011] body_size=2692, *offset=2692, buf_size=4096
> > [  842.301584] tpm tpm0: tpm2_save_context: out of backing storage
> > [  842.305463] tpm tpm0: tpm2_commit_space: error -12
> > [  850.793691] tpm tpm0: A TPM error (459) occurred flushing context
> > 
> > This here fixes it. Any suggestion for a proper fix?
> > 
> > Does it concatenate contexts into this PAGE_SIZE'd buffer?
> 
> 
> This may be a better workable patch that needs to apply to many previous
> kernel versions:
> 
> 
>  drivers/char/tpm/tpm-chip.c   |  2 +-
>  drivers/char/tpm/tpm.h        |  2 ++
>  drivers/char/tpm/tpm2-space.c | 12 ++++++++----
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 8c77e88012e9..d32a173117b8 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -386,7 +386,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>      chip->cdev.owner = THIS_MODULE;
>      chip->cdevs.owner = THIS_MODULE;
> 
> -    chip->work_space.context_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +    chip->work_space.context_buf = kzalloc(TPM_SPACE_SIZE, GFP_KERNEL);
>      if (!chip->work_space.context_buf) {
>          rc = -ENOMEM;
>          goto out;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 0fbcede241ea..5f34187da858 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -36,6 +36,8 @@
>  #define TPM_NUM_DEVICES        65536
>  #define TPM_RETRY        50
> 
> +#define TPM_SPACE_SIZE          (3 * 4096)
> +
>  enum tpm_timeout {
>      TPM_TIMEOUT = 5,    /* msecs */
>      TPM_TIMEOUT_RETRY = 100, /* msecs */
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 982d341d8837..493900008fa2 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -40,7 +40,7 @@ static void tpm2_flush_sessions(struct tpm_chip *chip,
> struct tpm_space *space)
> 
>  int tpm2_init_space(struct tpm_space *space)
>  {
> -    space->context_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +    space->context_buf = kzalloc(TPM_SPACE_SIZE, GFP_KERNEL);
>      if (!space->context_buf)
>          return -ENOMEM;
> 
> @@ -123,6 +123,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32
> handle, u8 *buf,
>      unsigned int body_size;
>      int rc;
> 
> +printk(KERN_INFO "*offset=%u\n", *offset);
>      rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
>      if (rc)
>          return rc;
> @@ -147,6 +148,7 @@ static int tpm2_save_context(struct tpm_chip *chip, u32
> handle, u8 *buf,
> 
>      body_size = tpm_buf_length(&tbuf) - TPM_HEADER_SIZE;
>      if ((*offset + body_size) > buf_size) {
> +printk(KERN_INFO "body_size=%u, *offset=%u, buf_size=%u\n", body_size,
> *offset, buf_size);
>          dev_warn(&chip->dev, "%s: out of backing storage\n", __func__);
>          tpm_buf_destroy(&tbuf);
>          return -ENOMEM;
> @@ -311,7 +313,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct
> tpm_space *space, u8 *cmd,
>             sizeof(space->context_tbl));
>      memcpy(&chip->work_space.session_tbl, &space->session_tbl,
>             sizeof(space->session_tbl));
> -    memcpy(chip->work_space.context_buf, space->context_buf, PAGE_SIZE);
> +    memcpy(chip->work_space.context_buf, space->context_buf,
> TPM_SPACE_SIZE);
>      memcpy(chip->work_space.session_buf, space->session_buf, PAGE_SIZE);
> 
>      rc = tpm2_load_space(chip);
> @@ -487,12 +489,13 @@ static int tpm2_save_space(struct tpm_chip *chip)
>      int i;
>      int rc;
> 
> +    printk(KERN_INFO "ARRAY_SIZE(space->context_tbl) = %lu\n",
> ARRAY_SIZE(space->context_tbl));
>      for (i = 0, offset = 0; i < ARRAY_SIZE(space->context_tbl); i++) {
>          if (!(space->context_tbl[i] && ~space->context_tbl[i]))
>              continue;
> 
>          rc = tpm2_save_context(chip, space->context_tbl[i],
> -                       space->context_buf, PAGE_SIZE,
> +                       space->context_buf, TPM_SPACE_SIZE,
>                         &offset);
>          if (rc == -ENOENT) {
>              space->context_tbl[i] = 0;
> @@ -530,6 +533,7 @@ int tpm2_commit_space(struct tpm_chip *chip, struct
> tpm_space *space,
>      struct tpm_header *header = buf;
>      int rc;
> 
> +printk(KERN_INFO "%s:%d\n", __func__, __LINE__);
>      if (!space)
>          return 0;
> 
> @@ -557,7 +561,7 @@ int tpm2_commit_space(struct tpm_chip *chip, struct
> tpm_space *space,
>             sizeof(space->context_tbl));
>      memcpy(&space->session_tbl, &chip->work_space.session_tbl,
>             sizeof(space->session_tbl));
> -    memcpy(space->context_buf, chip->work_space.context_buf, PAGE_SIZE);
> +    memcpy(space->context_buf, chip->work_space.context_buf,
> TPM_SPACE_SIZE);
>      memcpy(space->session_buf, chip->work_space.session_buf, PAGE_SIZE);
> 
>      return 0;
> 
> 

The implementation works correctly, the buffer just doesn't have enough
space for the keys:

	body_size = tpm_buf_length(&tbuf) - TPM_HEADER_SIZE;
	if ((*offset + body_size) > buf_size) {
		dev_warn(&chip->dev, "%s: out of backing storage\n", __func__);
		tpm_buf_destroy(&tbuf);
		return -ENOMEM;
	}

I think that the right way to refine this would be to reallocate the
buffer when needed.

I'll send a patch that does this.

/Jarkko
