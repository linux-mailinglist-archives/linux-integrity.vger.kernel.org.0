Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FE57280F2
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jun 2023 15:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjFHNPG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jun 2023 09:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFHNPE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jun 2023 09:15:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4713C26BA;
        Thu,  8 Jun 2023 06:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB04264D66;
        Thu,  8 Jun 2023 13:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F299C433D2;
        Thu,  8 Jun 2023 13:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686230101;
        bh=VZtE+VKW+h1XVbj7XPV90Ykm87bzkFCpoZemhzMDyWU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=aRGDROIVouRmiayC6Nknzppxq6tJrvGSc2gaxay2aW7MxkSL0B71zmfWVNXEJaTty
         +UaDZzgmzuXGhMvyr3+oW1ByxxBz+QGK11W4mkfSSUB6Fs90sVwDJdyRrHruadbBuv
         K0ojAJDtChTOHvwdqpy0JjWQZqrtKjf07eX7aBqlXjYxSH1ls/incQ2rRxyrwElyiq
         Vt3b4hbadxxO0ga1JAJW4vgWMeJBjpWNqFArgc3Mlf8ja12S9bO0mF3pKCtg5WO+8C
         HYDan+fkM5g8OBb+Puxwe2IqcD2uhF9zojS6owr5kbe0oaWKm6obC6TmI039EWdKWa
         Z6+b3anVTb9fw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 08 Jun 2023 16:14:56 +0300
Message-Id: <CT7AOKF4OGHA.2S5VUEAG76GYB@suppilovahvero>
Subject: Re: [PATCH] tpm: factor out the user space mm from
 tpm_vtpm_set_locality()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Stefan Berger" <stefanb@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
Cc:     "Jason Gunthorpe" <jgg@nvidia.com>,
        "Alejandro Cabrera" <alejandro.cabreraaldaya@tuni.fi>,
        "Jarkko Sakkinen" <jarkko.sakkinen@tuni.fi>,
        <stable@vger.kernel.org>,
        "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230530205001.1302975-1-jarkko@kernel.org>
 <8f15feb5-7c6e-5a16-d9b4-008b7b45b01a@linux.ibm.com>
 <324df0fa5ad1f0508c5f62c25dd1f8d297d78813.camel@kernel.org>
 <0438f5e3-ca42-343b-e79e-5f7976ec8a62@linux.ibm.com>
In-Reply-To: <0438f5e3-ca42-343b-e79e-5f7976ec8a62@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed May 31, 2023 at 8:01 PM EEST, Stefan Berger wrote:
>
>
> On 5/31/23 12:32, Jarkko Sakkinen wrote:
> > On Wed, 2023-05-31 at 11:20 -0400, Stefan Berger wrote:
> >>
> >> On 5/30/23 16:50, Jarkko Sakkinen wrote:
> >>> From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> >>>
> >>> vtpm_proxy_fops_set_locality() causes kernel buffers to be passed to
> >>> copy_from_user() and copy_to_user().
> >>
> >> And what is the problem with that? Is it not working?
> > It is API contract and also clearly documented in the kernel documentat=
ion.
>
> First, vtpm_proxy_fops_set_locality() does not exist
>
> This may  be the function that is simulating a client sending a SET_LOCAL=
ITY command:
>
> static int vtpm_proxy_request_locality(struct tpm_chip *chip, int localit=
y)
> {
> 	struct tpm_buf buf;
> 	int rc;
> 	const struct tpm_header *header;
> 	struct proxy_dev *proxy_dev =3D dev_get_drvdata(&chip->dev);
>
> 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> 		rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS,
> 				  TPM2_CC_SET_LOCALITY);
> 	else
> 		rc =3D tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND,
> 				  TPM_ORD_SET_LOCALITY);
> 	if (rc)
> 		return rc;
> 	tpm_buf_append_u8(&buf, locality);
>
> 	proxy_dev->state |=3D STATE_DRIVER_COMMAND;
>
> 	rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting to set locality");
>
> 	proxy_dev->state &=3D ~STATE_DRIVER_COMMAND;
>
> 	if (rc < 0) {
> 		locality =3D rc;
> 		goto out;
> 	}
>
> 	header =3D (const struct tpm_header *)buf.data;
> 	rc =3D be32_to_cpu(header->return_code);
> 	if (rc)
> 		locality =3D -1;
>
> out:
> 	tpm_buf_destroy(&buf);
>
> 	return locality;
> }
>
> There is nothing wrong with the buffer being passed into the tpm_transmit=
_cmd function, which then causes the 'server side' to pick up the command (=
=3D swtpm picks up the command):
>
> /**
>   * vtpm_proxy_fops_read - Read TPM commands on 'server side'
>   *
>   * @filp: file pointer
>   * @buf: read buffer
>   * @count: number of bytes to read
>   * @off: offset
>   *
>   * Return:
>   *	Number of bytes read or negative error code
>   */
> static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
> 				    size_t count, loff_t *off)
> {
> 	struct proxy_dev *proxy_dev =3D filp->private_data;
> 	size_t len;
> 	int sig, rc;
>
> 	sig =3D wait_event_interruptible(proxy_dev->wq,
> 		proxy_dev->req_len !=3D 0 ||
> 		!(proxy_dev->state & STATE_OPENED_FLAG));
> 	if (sig)
> 		return -EINTR;
>
> 	mutex_lock(&proxy_dev->buf_lock);
>
> 	if (!(proxy_dev->state & STATE_OPENED_FLAG)) {
> 		mutex_unlock(&proxy_dev->buf_lock);
> 		return -EPIPE;
> 	}
>
> 	len =3D proxy_dev->req_len;
>
> 	if (count < len || len > sizeof(proxy_dev->buffer)) {
> 		mutex_unlock(&proxy_dev->buf_lock);
> 		pr_debug("Invalid size in recv: count=3D%zd, req_len=3D%zd\n",
> 			 count, len);
> 		return -EIO;
> 	}
>
> 	rc =3D copy_to_user(buf, proxy_dev->buffer, len);
> 	memset(proxy_dev->buffer, 0, len);
> 	proxy_dev->req_len =3D 0;
>
> 	if (!rc)
> 		proxy_dev->state |=3D STATE_WAIT_RESPONSE_FLAG;
>
> 	mutex_unlock(&proxy_dev->buf_lock);
>
> 	if (rc)
> 		return -EFAULT;
>
> 	return len;
> }
>
> This is swtpm picking up this command with its user buffer.
>
>    So, I am not sure at this point what is wrong.
>
>     Stefan

The answer was below but in short it is that you have a function that
expects __user * and you don't pass user tagged memory.

Even tho it is a bug, I think cc to stable is not necessary given that
it is not known to blow up anything. The main problem is that we have
code that does not work according to the expectations.

BR, Jarkko


