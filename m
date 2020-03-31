Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4EF199633
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgCaMRw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 08:17:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:18052 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730711AbgCaMRw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 08:17:52 -0400
IronPort-SDR: WlQ0DVRRemDr7RWNLQw+o5ZfKFhJHzzw8MKgwVDeaIYAA3L2x//Zvk3XZSreekj/gl7xAURn9J
 w5MGyt1opuFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 05:17:51 -0700
IronPort-SDR: LYtlAFAPob+FXfTmrIW/lRXkqfZJhCTUbXaprhrp9D1xM9HkGzCy8aecbvk04+AGJKoC4PvigD
 H9XjHHp68jRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="249032770"
Received: from tking1-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.59.94])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2020 05:17:40 -0700
Date:   Tue, 31 Mar 2020 15:17:39 +0300
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
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v4 4/7] tpm: tpm_tis: Fix expected bit handling and send
 all bytes in one shot without last byte in exception
Message-ID: <20200331121720.GB9284@linux.intel.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-5-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331113207.107080-5-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 31, 2020 at 02:32:04PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Today, actual implementation for send massage is not correct. We check and
> loop only on TPM_STS.stsValid bit and next we single check TPM_STS.expect
> bit value.
> TPM_STS.expected bit shall be checked in the same time of
> TPM_STS.stsValid, and should be repeated until timeout_A.
> To aquire that, "wait_for_tpm_stat" function is modified to
> "wait_for_tpm_stat_result". this function read regulary status register
> and check bit defined by "mask" to reach value defined in "mask_result"
> (that way a bit in mask can be checked if reached 1 or 0).
> 
> Respectively, to send message as defined in
> TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf, all bytes should be
> sent in one shot instead of sending last byte in exception.
> 
> This improvment was suggested by Benoit Houyere.

Use suggested-by tag.

Also if something is not correct, please provide a fixes tag.

You are speaking now in theoretical level, which we don't really
care that much. Is this causing you real issues? If the answer is
yes, please report them. If the answer is no, we don't need this.

/Jarkko

> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 72 ++++++++++++++++-------------------------
>  1 file changed, 28 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 18b9dc4..c8f4cf8 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -44,9 +44,10 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>         return false;
>  }
> 
> -static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> -               unsigned long timeout, wait_queue_head_t *queue,
> -               bool check_cancel)
> +static int wait_for_tpm_stat_result(struct tpm_chip *chip, u8 mask,
> +                                   u8 mask_result, unsigned long timeout,
> +                                   wait_queue_head_t *queue,
> +                                   bool check_cancel)
>  {
>         unsigned long stop;
>         long rc;
> @@ -55,7 +56,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> 
>         /* check current status */
>         status = chip->ops->status(chip);
> -       if ((status & mask) == mask)
> +       if ((status & mask) == mask_result)
>                 return 0;
> 
>         stop = jiffies + timeout;
> @@ -83,7 +84,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>                         usleep_range(TPM_TIMEOUT_USECS_MIN,
>                                      TPM_TIMEOUT_USECS_MAX);
>                         status = chip->ops->status(chip);
> -                       if ((status & mask) == mask)
> +                       if ((status & mask) == mask_result)
>                                 return 0;
>                 } while (time_before(jiffies, stop));
>         }
> @@ -290,10 +291,11 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
>         int size = 0, burstcnt, rc;
> 
>         while (size < count) {
> -               rc = wait_for_tpm_stat(chip,
> -                                TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> -                                chip->timeout_c,
> -                                &priv->read_queue, true);
> +               rc = wait_for_tpm_stat_result(chip,
> +                                       TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> +                                       TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> +                                       chip->timeout_c,
> +                                       &priv->read_queue, true);
>                 if (rc < 0)
>                         return rc;
>                 burstcnt = get_burstcount(chip);
> @@ -348,8 +350,9 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>                         goto out;
>                 }
> 
> -               if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> -                                     &priv->int_queue, false) < 0) {
> +               if (wait_for_tpm_stat_result(chip, TPM_STS_VALID,
> +                                            TPM_STS_VALID, chip->timeout_c,
> +                                            &priv->int_queue, false) < 0) {
>                         size = -ETIME;
>                         goto out;
>                 }
> @@ -385,61 +388,40 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>         int rc, status, burstcnt;
>         size_t count = 0;
> -       bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
> 
>         status = tpm_tis_status(chip);
>         if ((status & TPM_STS_COMMAND_READY) == 0) {
>                 tpm_tis_ready(chip);
> -               if (wait_for_tpm_stat
> -                   (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
> -                    &priv->int_queue, false) < 0) {
> +               if (wait_for_tpm_stat_result(chip, TPM_STS_COMMAND_READY,
> +                                            TPM_STS_COMMAND_READY,
> +                                            chip->timeout_b,
> +                                            &priv->int_queue, false) < 0) {
>                         rc = -ETIME;
>                         goto out_err;
>                 }
>         }
> 
> -       while (count < len - 1) {
> +       while (count < len) {
>                 burstcnt = get_burstcount(chip);
>                 if (burstcnt < 0) {
>                         dev_err(&chip->dev, "Unable to read burstcount\n");
>                         rc = burstcnt;
>                         goto out_err;
>                 }
> -               burstcnt = min_t(int, burstcnt, len - count - 1);
> +               burstcnt = min_t(int, burstcnt, len - count);
>                 rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
>                                          burstcnt, buf + count);
>                 if (rc < 0)
>                         goto out_err;
> 
>                 count += burstcnt;
> -
> -               if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> -                                       &priv->int_queue, false) < 0) {
> -                       rc = -ETIME;
> -                       goto out_err;
> -               }
> -               status = tpm_tis_status(chip);
> -               if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
> -                       rc = -EIO;
> -                       goto out_err;
> -               }
>         }
> -
> -       /* write last byte */
> -       rc = tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality), buf[count]);
> -       if (rc < 0)
> -               goto out_err;
> -
> -       if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> -                               &priv->int_queue, false) < 0) {
> +       if (wait_for_tpm_stat_result(chip, TPM_STS_VALID | TPM_STS_DATA_EXPECT,
> +                                    TPM_STS_VALID, chip->timeout_c,
> +                                    &priv->int_queue, false) < 0) {
>                 rc = -ETIME;
>                 goto out_err;
>         }
> -       status = tpm_tis_status(chip);
> -       if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
> -               rc = -EIO;
> -               goto out_err;
> -       }
> 
>         return 0;
> 
> @@ -496,9 +478,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>                 ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
> 
>                 dur = tpm_calc_ordinal_duration(chip, ordinal);
> -               if (wait_for_tpm_stat
> -                   (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
> -                    &priv->read_queue, false) < 0) {
> +               if (wait_for_tpm_stat_result(chip,
> +                                            TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> +                                            TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> +                                            dur,
> +                                            &priv->read_queue, false) < 0) {
>                         rc = -ETIME;
>                         goto out_err;
>                 }
> --
> 2.7.4
> 
> 
> 
> ===========================================================================================
> The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
