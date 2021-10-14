Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C642CF5F
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Oct 2021 02:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhJNAEG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 20:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhJNAEG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 20:04:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBE256113B;
        Thu, 14 Oct 2021 00:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634169722;
        bh=UvX3x6hjiRsSQn6rwJ50mSs3/4dWDRRlhxETFUNEHL0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QVsDkjOzbVrYNz2HNqXY9aR4kShNlTu2b/7kIWGD2Dft5BNuZX+DMcfh6VlYzvTVk
         BtdEH57x+DDG/HFZGrLTe/sphdd//C277WhJp8leDZRhlAUHwMPn0y6kW0TggUUnPW
         OZ8dqYalJ2ncQeeyd1IeEQXsfTBxFtamTE3z8cRBpgVRV3AJcqh2zCwISgX2WbJ381
         /GwE/RifFAfGPGOeWTEIyt6D/7d+iHzArnfCtqClfcMlcmSt58Zh0fQ5IXNgtMWpCv
         ZmNVPfUHnByA78uQO7EOSwI9KKCiB68b9TjU8KrTdztpT7FDADaFptF/5M9eolE+2F
         nKMxhiItkMFTg==
Message-ID: <25c85925b3aa3b7457c9d079d1cb171f72e69eac.camel@kernel.org>
Subject: Re: [PATCH] tpm/st33zp24: drop unneeded over-commenting
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Oct 2021 03:01:59 +0300
In-Reply-To: <20211013092151.11835-1-sohaib.amhmd@gmail.com>
References: <20211013092151.11835-1-sohaib.amhmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-10-13 at 11:21 +0200, Sohaib Mohamed wrote:
> Remove parameter descriptions from all static functions.
> Remove the comment altogether that does not tell what the function does.
>=20
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> ---
> =C2=A0drivers/char/tpm/st33zp24/st33zp24.c | 122 ++++--------------------=
---
> =C2=A01 file changed, 17 insertions(+), 105 deletions(-)
>=20
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33=
zp24/st33zp24.c
> index 4ec10ab5e576..ce9efb73c144 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -61,9 +61,7 @@ enum tis_defaults {
> =C2=A0};
> =C2=A0
> =C2=A0/*
> - * clear_interruption clear the pending interrupt.
> - * @param: tpm_dev, the tpm device device.
> - * @return: the interrupt status value.
> + * clear the pending interrupt.
> =C2=A0 */
> =C2=A0static u8 clear_interruption(struct st33zp24_dev *tpm_dev)
> =C2=A0{
> @@ -72,12 +70,10 @@ static u8 clear_interruption(struct st33zp24_dev *tpm=
_dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_dev->ops->recv(tpm_de=
v->phy_id, TPM_INT_STATUS, &interrupt, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_dev->ops->send(tpm_de=
v->phy_id, TPM_INT_STATUS, &interrupt, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return interrupt;
> -} /* clear_interruption() */
> +}
> =C2=A0
> =C2=A0/*
> - * st33zp24_cancel, cancel the current command execution or
> - * set STS to COMMAND READY.
> - * @param: chip, the tpm_chip description as specified in driver/char/tp=
m/tpm.h
> + * cancel the current command execution or set STS to COMMAND READY.
> =C2=A0 */
> =C2=A0static void st33zp24_cancel(struct tpm_chip *chip)
> =C2=A0{
> @@ -86,12 +82,10 @@ static void st33zp24_cancel(struct tpm_chip *chip)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data =3D TPM_STS_COMMAND_=
READY;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_dev->ops->send(tpm_de=
v->phy_id, TPM_STS, &data, 1);
> -} /* st33zp24_cancel() */
> +}
> =C2=A0
> =C2=A0/*
> - * st33zp24_status return the TPM_STS register
> - * @param: chip, the tpm chip description
> - * @return: the TPM_STS register value.
> + * return the TPM_STS register
> =C2=A0 */
> =C2=A0static u8 st33zp24_status(struct tpm_chip *chip)
> =C2=A0{
> @@ -100,12 +94,10 @@ static u8 st33zp24_status(struct tpm_chip *chip)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_dev->ops->recv(tpm_de=
v->phy_id, TPM_STS, &data, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return data;
> -} /* st33zp24_status() */
> +}
> =C2=A0
> =C2=A0/*
> - * check_locality if the locality is active
> - * @param: chip, the tpm chip description
> - * @return: true if LOCALITY0 is active, otherwise false
> + * if the locality is active
> =C2=A0 */
> =C2=A0static bool check_locality(struct tpm_chip *chip)
> =C2=A0{
> @@ -120,13 +112,8 @@ static bool check_locality(struct tpm_chip *chip)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return true;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> -} /* check_locality() */
> +}
> =C2=A0
> -/*
> - * request_locality request the TPM locality
> - * @param: chip, the chip description
> - * @return: the active locality or negative value.
> - */
> =C2=A0static int request_locality(struct tpm_chip *chip)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct st33zp24_dev *tpm_=
dev =3D dev_get_drvdata(&chip->dev);
> @@ -153,12 +140,8 @@ static int request_locality(struct tpm_chip *chip)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* could not get locality=
 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EACCES;
> -} /* request_locality() */
> +}
> =C2=A0
> -/*
> - * release_locality release the active locality
> - * @param: chip, the tpm chip description.
> - */
> =C2=A0static void release_locality(struct tpm_chip *chip)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct st33zp24_dev *tpm_=
dev =3D dev_get_drvdata(&chip->dev);
> @@ -171,8 +154,6 @@ static void release_locality(struct tpm_chip *chip)
> =C2=A0
> =C2=A0/*
> =C2=A0 * get_burstcount return the burstcount value
> - * @param: chip, the chip description
> - * return: the burstcount or negative value.
> =C2=A0 */
> =C2=A0static int get_burstcount(struct tpm_chip *chip)
> =C2=A0{
> @@ -200,18 +181,8 @@ static int get_burstcount(struct tpm_chip *chip)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0msleep(TPM_TIMEOUT);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} while (time_before(jiff=
ies, stop));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EBUSY;
> -} /* get_burstcount() */
> -
> +}
> =C2=A0
> -/*
> - * wait_for_tpm_stat_cond
> - * @param: chip, chip description
> - * @param: mask, expected mask value
> - * @param: check_cancel, does the command expected to be canceled ?
> - * @param: canceled, did we received a cancel request ?
> - * @return: true if status =3D=3D mask or if the command is canceled.
> - * false in other cases.
> - */
> =C2=A0static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool check_cancel, bool *cance=
led)
> =C2=A0{
> @@ -228,13 +199,7 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *=
chip, u8 mask,
> =C2=A0}
> =C2=A0
> =C2=A0/*
> - * wait_for_stat wait for a TPM_STS value
> - * @param: chip, the tpm chip description
> - * @param: mask, the value mask to wait
> - * @param: timeout, the timeout
> - * @param: queue, the wait queue.
> - * @param: check_cancel, does the command can be cancelled ?
> - * @return: the tpm status, 0 if success, -ETIME if timeout is reached.
> + * wait for a TPM_STS value
> =C2=A0 */
> =C2=A0static int wait_for_stat(struct tpm_chip *chip, u8 mask, unsigned l=
ong timeout,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wai=
t_queue_head_t *queue, bool check_cancel)
> @@ -292,15 +257,8 @@ static int wait_for_stat(struct tpm_chip *chip, u8 m=
ask, unsigned long timeout,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ETIME;
> -} /* wait_for_stat() */
> +}
> =C2=A0
> -/*
> - * recv_data receive data
> - * @param: chip, the tpm chip description
> - * @param: buf, the buffer where the data are received
> - * @param: count, the number of data to receive
> - * @return: the number of bytes read from TPM FIFO.
> - */
> =C2=A0static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct st33zp24_dev *tpm_=
dev =3D dev_get_drvdata(&chip->dev);
> @@ -325,12 +283,6 @@ static int recv_data(struct tpm_chip *chip, u8 *buf,=
 size_t count)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return size;
> =C2=A0}
> =C2=A0
> -/*
> - * tpm_ioserirq_handler the serirq irq handler
> - * @param: irq, the tpm chip description
> - * @param: dev_id, the description of the chip
> - * @return: the status of the handler.
> - */
> =C2=A0static irqreturn_t tpm_ioserirq_handler(int irq, void *dev_id)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm_chip *chip =3D=
 dev_id;
> @@ -341,16 +293,10 @@ static irqreturn_t tpm_ioserirq_handler(int irq, vo=
id *dev_id)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0disable_irq_nosync(tpm_de=
v->irq);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return IRQ_HANDLED;
> -} /* tpm_ioserirq_handler() */
> +}
> =C2=A0
> =C2=A0/*
> - * st33zp24_send send TPM commands through the I2C bus.
> - *
> - * @param: chip, the tpm_chip description as specified in driver/char/tp=
m/tpm.h
> - * @param: buf,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the buffe=
r to send.
> - * @param: count, the number of bytes to send.
> - * @return: In case of success the number of bytes sent.
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0In other case, a <=
 0 value describing the issue.
> + * send TPM commands through the I2C bus.
> =C2=A0 */
> =C2=A0static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
ze_t len)
> @@ -431,14 +377,6 @@ static int st33zp24_send(struct tpm_chip *chip, unsi=
gned char *buf,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> =C2=A0}
> =C2=A0
> -/*
> - * st33zp24_recv received TPM response through TPM phy.
> - * @param: chip, the tpm_chip description as specified in driver/char/tp=
m/tpm.h.
> - * @param: buf,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the buffe=
r to store datas.
> - * @param: count, the number of bytes to send.
> - * @return: In case of success the number of bytes received.
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In other case, a < 0 =
value describing the issue.
> - */
> =C2=A0static int st33zp24_recv(struct tpm_chip *chip, unsigned char *buf,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 size_t count)
> =C2=A0{
> @@ -478,12 +416,6 @@ static int st33zp24_recv(struct tpm_chip *chip, unsi=
gned char *buf,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return size;
> =C2=A0}
> =C2=A0
> -/*
> - * st33zp24_req_canceled
> - * @param: chip, the tpm_chip description as specified in driver/char/tp=
m/tpm.h.
> - * @param: status, the TPM status.
> - * @return: Does TPM ready to compute a new command ? true.
> - */
> =C2=A0static bool st33zp24_req_canceled(struct tpm_chip *chip, u8 status)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (status =3D=3D TPM=
_STS_COMMAND_READY);
> @@ -501,11 +433,7 @@ static const struct tpm_class_ops st33zp24_tpm =3D {
> =C2=A0};
> =C2=A0
> =C2=A0/*
> - * st33zp24_probe initialize the TPM device
> - * @param: client, the i2c_client description (TPM I2C description).
> - * @param: id, the i2c_device_id struct.
> - * @return: 0 in case of success.
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1 in other case.
> + * initialize the TPM device
> =C2=A0 */
> =C2=A0int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev, int irq, int io_lp=
cpd)
> @@ -583,11 +511,6 @@ int st33zp24_probe(void *phy_id, const struct st33zp=
24_phy_ops *ops,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(st33zp24_probe);
> =C2=A0
> -/*
> - * st33zp24_remove remove the TPM device
> - * @param: tpm_data, the tpm phy.
> - * @return: 0 in case of success.
> - */
> =C2=A0int st33zp24_remove(struct tpm_chip *chip)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_chip_unregister(chip)=
;
> @@ -596,12 +519,6 @@ int st33zp24_remove(struct tpm_chip *chip)
> =C2=A0EXPORT_SYMBOL(st33zp24_remove);
> =C2=A0
> =C2=A0#ifdef CONFIG_PM_SLEEP
> -/*
> - * st33zp24_pm_suspend suspend the TPM device
> - * @param: tpm_data, the tpm phy.
> - * @param: mesg, the power management message.
> - * @return: 0 in case of success.
> - */
> =C2=A0int st33zp24_pm_suspend(struct device *dev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm_chip *chip =3D=
 dev_get_drvdata(dev);
> @@ -615,14 +532,9 @@ int st33zp24_pm_suspend(struct device *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D tpm_pm_suspend(dev);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> -} /* st33zp24_pm_suspend() */
> +}
> =C2=A0EXPORT_SYMBOL(st33zp24_pm_suspend);
> =C2=A0
> -/*
> - * st33zp24_pm_resume resume the TPM device
> - * @param: tpm_data, the tpm phy.
> - * @return: 0 in case of success.
> - */
> =C2=A0int st33zp24_pm_resume(struct device *dev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm_chip *chip =3D=
 dev_get_drvdata(dev);
> @@ -640,7 +552,7 @@ int st33zp24_pm_resume(struct device *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm=
1_do_selftest(chip);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> -} /* st33zp24_pm_resume() */
> +}
> =C2=A0EXPORT_SYMBOL(st33zp24_pm_resume);
> =C2=A0#endif
> =C2=A0

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko


