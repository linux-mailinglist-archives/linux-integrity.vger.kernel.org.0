Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8FDC1021
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Sep 2019 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfI1H6X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 28 Sep 2019 03:58:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41657 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726263AbfI1H6W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 28 Sep 2019 03:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569657499;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txHZwneu/HCnUSPojtaxCh5g07ofpw5Ax1iOJvzSLww=;
        b=LlEpy15XI4S5QqHAdxgGS1ZyCAmqgLpXb7RBbqjKXUUwXTHft7H+dwUuRrlD/87QuMMnJj
        y4MiGlkZr1TTm97NSaPducAMDfHLUooEYw5AY3GAKtXvoUh8g9mKRgrYA5YLrVtkxtuw79
        cL81k7pZhE8Y/LSlzryR6cEoFItT/kk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-FGsyI2POO520XRUyhQalWA-1; Sat, 28 Sep 2019 03:58:18 -0400
Received: by mail-io1-f70.google.com with SMTP id e14so17524059iot.16
        for <linux-integrity@vger.kernel.org>; Sat, 28 Sep 2019 00:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sbpFloOAjpWpY8PjIDaRbEPe6kjPW3iQrN8aSBaJ75M=;
        b=gPl5SPWUz0UKJNmhopnFb9k2Jcimkzyd2kirJBDrgJ/rvINsP/Pn4f8Bvh5A+x6qIt
         0W5NN7itaA0bjV2lou8epHgP+WGyJQTx6rVOu4YlLw7Ekdq/dcASDtq53JQZdphNnytz
         6n+kmN6vRysuETUjFep2ATNOZLUm1q7oK5zkxQgcdomlOoXifwxrb4mLJ/lT/rSNouJ+
         xma6fEX7AlSrWZhL7Vz8cuK4N7AUm41No+SrZWjQqe04g/b99/H/Uq6gyBr++sdFQOz/
         PAYpFUSANB/ckWzlnYsApGxx86Vq0bBVHk3IoVvzk6sP9NhqY/R+yv5BvGemcbXG96iQ
         MCLA==
X-Gm-Message-State: APjAAAW9V5gr4c1kzL1i7MS1lGCyntIirJkAIY+YiiCnPV/ZgcPxL04y
        whnr/HvRHu0LTDbOEB/o9scZA8XdUU/7C3lHnRrtul8aD2ZY+H0hV/3mdrT65kkxZDhL86JHGpY
        Ii/T7EVwTUiKBuwRkjs2rZMxffFlc
X-Received: by 2002:a5e:cb49:: with SMTP id h9mr11577153iok.307.1569657496247;
        Sat, 28 Sep 2019 00:58:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwxyPkk4zRBzWDiSdctPhU1caklZtIxVsg71OjI8xA5+BKNmCLikf7e51b79BCeglFuKyXEQ==
X-Received: by 2002:a5e:cb49:: with SMTP id h9mr11577129iok.307.1569657495812;
        Sat, 28 Sep 2019 00:58:15 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id a13sm2065086ilh.65.2019.09.28.00.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 00:58:15 -0700 (PDT)
Date:   Sat, 28 Sep 2019 00:58:13 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Detach page allocation from tpm_buf
Message-ID: <20190928075813.nsmu3g7derj2fjmj@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190926172324.3405-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20190926172324.3405-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: FGsyI2POO520XRUyhQalWA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Sep 26 19, Jarkko Sakkinen wrote:
>As has been seen recently, binding the buffer allocation and tpm_buf
>together is sometimes far from optimal. The buffer might come from the
>caller namely when tpm_send() is used by another subsystem. In addition we
>can stability in call sites w/o rollback (e.g. power events)>
>
>Take allocation out of the tpm_buf framework and make it purely a wrapper
>for the data buffer.
>
>Link: https://patchwork.kernel.org/patch/11146585/
>Cc: Mimi Zohar <zohar@linux.ibm.com>
>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>Cc: Sumit Garg <sumit.garg@linaro.org>
>Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>---
>v2:
>* In tpm2_get_random(), TPM2_CC_GET_RANDOM was accidently switch to
>  TPM2_CC_PCR_EXTEND. Now it has been switched back.
> drivers/char/tpm/tpm-sysfs.c      |  19 ++-
> drivers/char/tpm/tpm.h            |  40 ++---
> drivers/char/tpm/tpm1-cmd.c       | 114 +++++++++----
> drivers/char/tpm/tpm2-cmd.c       | 265 +++++++++++++++++++-----------
> drivers/char/tpm/tpm2-space.c     |  64 +++++---
> drivers/char/tpm/tpm_vtpm_proxy.c |  24 +--
> 6 files changed, 333 insertions(+), 193 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
>index edfa89160010..eeb90c9225b9 100644
>--- a/drivers/char/tpm/tpm-sysfs.c
>+++ b/drivers/char/tpm/tpm-sysfs.c
>@@ -32,21 +32,26 @@ struct tpm_readpubek_out {
> static ssize_t pubek_show(struct device *dev, struct device_attribute *at=
tr,
> =09=09=09  char *buf)
> {
>-=09struct tpm_buf tpm_buf;
>-=09struct tpm_readpubek_out *out;
>-=09int i;
>-=09char *str =3D buf;
> =09struct tpm_chip *chip =3D to_tpm_chip(dev);
>+=09struct tpm_readpubek_out *out;
>+=09struct page *data_page;
>+=09struct tpm_buf tpm_buf;
> =09char anti_replay[20];
>+=09char *str =3D buf;
>+=09int i;
>
> =09memset(&anti_replay, 0, sizeof(anti_replay));
>
> =09if (tpm_try_get_ops(chip))
> =09=09return 0;
>
>-=09if (tpm_buf_init(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK))
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
> =09=09goto out_ops;
>
>+=09tpm_buf_reset(&tpm_buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAN=
D,
>+=09=09      TPM_ORD_READPUBEK);
>+
> =09tpm_buf_append(&tpm_buf, anti_replay, sizeof(anti_replay));
>
> =09if (tpm_transmit_cmd(chip, &tpm_buf, READ_PUBEK_RESULT_MIN_BODY_SIZE,
>@@ -83,7 +88,9 @@ static ssize_t pubek_show(struct device *dev, struct dev=
ice_attribute *attr,
> =09}
>
> out_buf:
>-=09tpm_buf_destroy(&tpm_buf);
>+=09kunmap(data_page);
>+=09__free_page(data_page);
>+
> out_ops:
> =09tpm_put_ops(chip);
> =09return str - buf;
>diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>index a7fea3e0ca86..45316e5d2d36 100644
>--- a/drivers/char/tpm/tpm.h
>+++ b/drivers/char/tpm/tpm.h
>@@ -284,36 +284,30 @@ enum tpm_buf_flags {
> };
>
> struct tpm_buf {
>-=09struct page *data_page;
>-=09unsigned int flags;
> =09u8 *data;
>+=09unsigned int size;
>+=09unsigned int flags;
> };
>
>-static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordina=
l)
>+static inline void tpm_buf_reset(struct tpm_buf *buf, u8 *data,
>+=09unsigned int size, u16 tag, u32 ordinal)
> {
>-=09struct tpm_header *head =3D (struct tpm_header *)buf->data;
>+=09struct tpm_header *head =3D (struct tpm_header *)data;
>
>-=09head->tag =3D cpu_to_be16(tag);
>-=09head->length =3D cpu_to_be32(sizeof(*head));
>-=09head->ordinal =3D cpu_to_be32(ordinal);
>-}
>-
>-static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>-{
>-=09buf->data_page =3D alloc_page(GFP_HIGHUSER);
>-=09if (!buf->data_page)
>-=09=09return -ENOMEM;
>+=09/* sanity check */
>+=09if (size < TPM_HEADER_SIZE) {
>+=09=09WARN(1, "tpm_buf: overflow\n");
>+=09=09buf->flags |=3D TPM_BUF_OVERFLOW;
>+=09=09return;
>+=09}
>
>+=09buf->data =3D data;
>+=09buf->size =3D size;
> =09buf->flags =3D 0;
>-=09buf->data =3D kmap(buf->data_page);
>-=09tpm_buf_reset(buf, tag, ordinal);
>-=09return 0;
>-}
>
>-static inline void tpm_buf_destroy(struct tpm_buf *buf)
>-{
>-=09kunmap(buf->data_page);
>-=09__free_page(buf->data_page);
>+=09head->tag =3D cpu_to_be16(tag);
>+=09head->length =3D cpu_to_be32(sizeof(*head));
>+=09head->ordinal =3D cpu_to_be32(ordinal);
> }
>
> static inline u32 tpm_buf_length(struct tpm_buf *buf)
>@@ -341,7 +335,7 @@ static inline void tpm_buf_append(struct tpm_buf *buf,
> =09if (buf->flags & TPM_BUF_OVERFLOW)
> =09=09return;
>
>-=09if ((len + new_len) > PAGE_SIZE) {
>+=09if ((len + new_len) > buf->size) {
> =09=09WARN(1, "tpm_buf: overflow\n");
> =09=09buf->flags |=3D TPM_BUF_OVERFLOW;
> =09=09return;
>diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
>index 149e953ca369..2753699454ab 100644
>--- a/drivers/char/tpm/tpm1-cmd.c
>+++ b/drivers/char/tpm/tpm1-cmd.c
>@@ -323,19 +323,25 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_=
chip *chip, u32 ordinal)
>  */
> static int tpm1_startup(struct tpm_chip *chip)
> {
>+=09struct page *data_page;
> =09struct tpm_buf buf;
> =09int rc;
>
> =09dev_info(&chip->dev, "starting up the TPM manually\n");
>
>-=09rc =3D tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
>-=09if (rc < 0)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAND,
>+=09=09      TPM_ORD_STARTUP);
>
> =09tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
>
> =09rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
>-=09tpm_buf_destroy(&buf);
>+
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
>@@ -448,18 +454,24 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
> int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
> =09=09    const char *log_msg)
> {
>+=09struct page *data_page;
> =09struct tpm_buf buf;
> =09int rc;
>
>-=09rc =3D tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAND,
>+=09=09      TPM_ORD_PCR_EXTEND);
>
> =09tpm_buf_append_u32(&buf, pcr_idx);
> =09tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
>
> =09rc =3D tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE, log_msg);
>-=09tpm_buf_destroy(&buf);
>+
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
>@@ -467,12 +479,16 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_i=
dx, const u8 *hash,
> ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
> =09=09    const char *desc, size_t min_cap_length)
> {
>+=09struct page *data_page;
> =09struct tpm_buf buf;
> =09int rc;
>
>-=09rc =3D tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_CAP);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAND,
>+=09=09      TPM_ORD_GET_CAP);
>
> =09if (subcap_id =3D=3D TPM_CAP_VERSION_1_1 ||
> =09    subcap_id =3D=3D TPM_CAP_VERSION_1_2) {
>@@ -491,7 +507,9 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_=
id, cap_t *cap,
> =09rc =3D tpm_transmit_cmd(chip, &buf, min_cap_length, desc);
> =09if (!rc)
> =09=09*cap =3D *(cap_t *)&buf.data[TPM_HEADER_SIZE + 4];
>-=09tpm_buf_destroy(&buf);
>+
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
> EXPORT_SYMBOL_GPL(tpm1_getcap);
>@@ -514,19 +532,26 @@ struct tpm1_get_random_out {
>  */
> int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
> {
>-=09struct tpm1_get_random_out *out;
> =09u32 num_bytes =3D  min_t(u32, max, TPM_MAX_RNG_DATA);
>+=09struct tpm1_get_random_out *out;
>+=09struct page *data_page;
> =09struct tpm_buf buf;
>-=09u32 total =3D 0;
> =09int retries =3D 5;
>+=09void *data_ptr;
>+=09u32 total =3D 0;
> =09u32 recd;
> =09int rc;
>
>-=09rc =3D tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09data_ptr =3D kmap(data_page);
>
> =09do {
>+=09=09tpm_buf_reset(&buf, data_ptr, PAGE_SIZE, TPM_TAG_RQU_COMMAND,
>+=09=09=09      TPM_ORD_GET_RANDOM);
>+
> =09=09tpm_buf_append_u32(&buf, num_bytes);
>
> =09=09rc =3D tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
>@@ -555,25 +580,29 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest,=
 size_t max)
> =09=09dest +=3D recd;
> =09=09total +=3D recd;
> =09=09num_bytes -=3D recd;
>-
>-=09=09tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
> =09} while (retries-- && total < max);
>
> =09rc =3D total ? (int)total : -EIO;
>+
> out:
>-=09tpm_buf_destroy(&buf);
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
> #define TPM_ORD_PCRREAD 21
> int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
> {
>+=09struct page *data_page;
> =09struct tpm_buf buf;
> =09int rc;
>
>-=09rc =3D tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAND,
>+=09=09      TPM_ORD_PCRREAD);
>
> =09tpm_buf_append_u32(&buf, pcr_idx);
>
>@@ -590,7 +619,8 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, =
u8 *res_buf)
> =09memcpy(res_buf, &buf.data[TPM_HEADER_SIZE], TPM_DIGEST_SIZE);
>
> out:
>-=09tpm_buf_destroy(&buf);
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
>@@ -604,15 +634,21 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx=
, u8 *res_buf)
>  */
> static int tpm1_continue_selftest(struct tpm_chip *chip)
> {
>+=09struct page *data_page;
> =09struct tpm_buf buf;
> =09int rc;
>
>-=09rc =3D tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_CONTINUE_SELFTE=
ST);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM_TAG_RQU_COMMAND,
>+=09=09      TPM_ORD_CONTINUE_SELFTEST);
>
> =09rc =3D tpm_transmit_cmd(chip, &buf, 0, "continue selftest");
>-=09tpm_buf_destroy(&buf);
>+
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
>@@ -722,21 +758,28 @@ int tpm1_auto_startup(struct tpm_chip *chip)
> int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
> {
> =09u8 dummy_hash[TPM_DIGEST_SIZE] =3D { 0 };
>+=09struct page *data_page;
> =09struct tpm_buf buf;
> =09unsigned int try;
>+=09void *data_ptr;
> =09int rc;
>
>-
> =09/* for buggy tpm, flush pcrs with extend to selected dummy */
> =09if (tpm_suspend_pcr)
> =09=09rc =3D tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
> =09=09=09=09     "extending dummy pcr before suspend");
>
>-=09rc =3D tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09data_ptr =3D kmap(data_page);
>+
> =09/* now do the actual savestate */
> =09for (try =3D 0; try < TPM_RETRY; try++) {
>+=09=09tpm_buf_reset(&buf, data_ptr, PAGE_SIZE,
>+=09=09=09      TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
>+
> =09=09rc =3D tpm_transmit_cmd(chip, &buf, 0, NULL);
> =09=09/*
> =09=09 * If the TPM indicates that it is too busy to respond to
>@@ -750,9 +793,8 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_sus=
pend_pcr)
> =09=09 */
> =09=09if (rc !=3D TPM_WARN_RETRY)
> =09=09=09break;
>-=09=09tpm_msleep(TPM_TIMEOUT_RETRY);
>
>-=09=09tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
>+=09=09tpm_msleep(TPM_TIMEOUT_RETRY);
> =09}
>
> =09if (rc)
>@@ -762,8 +804,8 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_sus=
pend_pcr)
> =09=09dev_warn(&chip->dev, "TPM savestate took %dms\n",
> =09=09=09 try * TPM_TIMEOUT_RETRY);
>
>-=09tpm_buf_destroy(&buf);
>-
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index ba9acae83bff..50674710aed0 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -175,13 +175,14 @@ struct tpm2_pcr_read_out {
> int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
> =09=09  struct tpm_digest *digest, u16 *digest_size_ptr)
> {
>-=09int i;
>-=09int rc;
>-=09struct tpm_buf buf;
>-=09struct tpm2_pcr_read_out *out;
> =09u8 pcr_select[TPM2_PCR_SELECT_MIN] =3D {0};
>-=09u16 digest_size;
>+=09struct tpm2_pcr_read_out *out;
> =09u16 expected_digest_size =3D 0;
>+=09struct page *data_page;
>+=09struct tpm_buf buf;
>+=09u16 digest_size;
>+=09int rc;
>+=09int i;
>
> =09if (pcr_idx >=3D TPM2_PLATFORM_PCR)
> =09=09return -EINVAL;
>@@ -197,9 +198,12 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
> =09=09expected_digest_size =3D chip->allocated_banks[i].digest_size;
> =09}
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
>+=09=09      TPM2_CC_PCR_READ);
>
> =09pcr_select[pcr_idx >> 3] =3D 1 << (pcr_idx & 0x7);
>
>@@ -225,8 +229,10 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
> =09=09*digest_size_ptr =3D digest_size;
>
> =09memcpy(digest->digest, out->digest, digest_size);
>+
> out:
>-=09tpm_buf_destroy(&buf);
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
>@@ -249,14 +255,18 @@ struct tpm2_null_auth_area {
> int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> =09=09    struct tpm_digest *digests)
> {
>-=09struct tpm_buf buf;
> =09struct tpm2_null_auth_area auth_area;
>+=09struct page *data_page;
>+=09struct tpm_buf buf;
> =09int rc;
> =09int i;
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_SESSIONS,
>+=09=09      TPM2_CC_PCR_EXTEND);
>
> =09tpm_buf_append_u32(&buf, pcr_idx);
>
>@@ -278,8 +288,8 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx=
,
>
> =09rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value"=
);
>
>-=09tpm_buf_destroy(&buf);
>-
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
>@@ -302,23 +312,29 @@ struct tpm2_get_random_out {
> int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
> {
> =09struct tpm2_get_random_out *out;
>+=09struct page *data_page;
>+=09u8 *dest_ptr =3D dest;
>+=09u32 num_bytes =3D max;
> =09struct tpm_buf buf;
>+=09void *data_ptr;
>+=09int retries =3D 5;
>+=09int total =3D 0;
> =09u32 recd;
>-=09u32 num_bytes =3D max;
> =09int err;
>-=09int total =3D 0;
>-=09int retries =3D 5;
>-=09u8 *dest_ptr =3D dest;
>
> =09if (!num_bytes || max > TPM_MAX_RNG_DATA)
> =09=09return -EINVAL;
>
>-=09err =3D tpm_buf_init(&buf, 0, 0);
>-=09if (err)
>-=09=09return err;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09data_ptr =3D kmap(data_page);
>
> =09do {
>-=09=09tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
>+=09=09tpm_buf_reset(&buf, data_ptr, PAGE_SIZE,
>+=09=09=09      TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_EXTEND);

TPM2_CC_GET_RANDOM

>+
> =09=09tpm_buf_append_u16(&buf, num_bytes);
> =09=09err =3D tpm_transmit_cmd(chip, &buf,
> =09=09=09=09       offsetof(struct tpm2_get_random_out,
>@@ -347,10 +363,13 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest,=
 size_t max)
> =09=09num_bytes -=3D recd;
> =09} while (retries-- && total < max);
>
>-=09tpm_buf_destroy(&buf);
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return total ? total : -EIO;
>+
> out:
>-=09tpm_buf_destroy(&buf);
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return err;
> }

Would this work here?

      =09err =3D total ? total : -EIO;
out:
=09kunmap(data_page);
=09__free_page(data_page);
=09return err;


>
>@@ -361,20 +380,24 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest,=
 size_t max)
>  */
> void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
> {
>+=09struct page *data_page;
> =09struct tpm_buf buf;
>-=09int rc;
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
>-=09if (rc) {
>-=09=09dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
>-=09=09=09 handle);
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page) {
>+=09=09WARN(1, "tpm: out of memory");
> =09=09return;
> =09}
>
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
>+=09=09      TPM2_CC_FLUSH_CONTEXT);
>+
> =09tpm_buf_append_u32(&buf, handle);
>
> =09tpm_transmit_cmd(chip, &buf, 0, "flushing context");
>-=09tpm_buf_destroy(&buf);
>+
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> }
>
> /**
>@@ -420,6 +443,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> =09=09      struct trusted_key_payload *payload,
> =09=09      struct trusted_key_options *options)
> {
>+=09struct page *data_page;
> =09unsigned int blob_len;
> =09struct tpm_buf buf;
> =09u32 hash;
>@@ -436,9 +460,12 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> =09if (i =3D=3D ARRAY_SIZE(tpm2_hash_map))
> =09=09return -EINVAL;
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_SESSIONS,
>+=09=09      TPM2_CC_CREATE);
>
> =09tpm_buf_append_u32(&buf, options->keyhandle);
> =09tpm2_buf_append_auth(&buf, TPM2_RS_PW,
>@@ -505,7 +532,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> =09payload->blob_len =3D blob_len;
>
> out:
>-=09tpm_buf_destroy(&buf);
>+=09kunmap(data_page);
>+=09__free_page(data_page);
>
> =09if (rc > 0) {
> =09=09if (tpm2_rc_value(rc) =3D=3D TPM2_RC_HASH)
>@@ -535,10 +563,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> =09=09=09 struct trusted_key_options *options,
> =09=09=09 u32 *blob_handle)
> {
>-=09struct tpm_buf buf;
> =09unsigned int private_len;
> =09unsigned int public_len;
>+=09struct page *data_page;
> =09unsigned int blob_len;
>+=09struct tpm_buf buf;
> =09int rc;
>
> =09private_len =3D be16_to_cpup((__be16 *) &payload->blob[0]);
>@@ -550,9 +579,12 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> =09if (blob_len > payload->blob_len)
> =09=09return -E2BIG;
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_SESSIONS,
>+=09=09      TPM2_CC_LOAD);
>
> =09tpm_buf_append_u32(&buf, options->keyhandle);
> =09tpm2_buf_append_auth(&buf, TPM2_RS_PW,
>@@ -574,7 +606,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> =09=09=09(__be32 *) &buf.data[TPM_HEADER_SIZE]);
>
> out:
>-=09tpm_buf_destroy(&buf);
>+=09kunmap(data_page);
>+=09__free_page(data_page);
>
> =09if (rc > 0)
> =09=09rc =3D -EPERM;
>@@ -599,14 +632,18 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> =09=09=09   struct trusted_key_options *options,
> =09=09=09   u32 blob_handle)
> {
>+=09struct page *data_page;
> =09struct tpm_buf buf;
> =09u16 data_len;
> =09u8 *data;
> =09int rc;
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_SESSIONS,
>+=09=09      TPM2_CC_UNSEAL);
>
> =09tpm_buf_append_u32(&buf, blob_handle);
> =09tpm2_buf_append_auth(&buf,
>@@ -641,7 +678,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> =09}
>
> out:
>-=09tpm_buf_destroy(&buf);
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
>@@ -693,12 +731,17 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 p=
roperty_id,  u32 *value,
> =09=09=09const char *desc)
> {
> =09struct tpm2_get_cap_out *out;
>+=09struct page *data_page;
> =09struct tpm_buf buf;
> =09int rc;
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY)=
;
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
>+=09=09      TPM2_CC_GET_CAPABILITY);
>+
> =09tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
> =09tpm_buf_append_u32(&buf, property_id);
> =09tpm_buf_append_u32(&buf, 1);
>@@ -708,7 +751,9 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 pro=
perty_id,  u32 *value,
> =09=09=09&buf.data[TPM_HEADER_SIZE];
> =09=09*value =3D be32_to_cpu(out->value);
> =09}
>-=09tpm_buf_destroy(&buf);
>+
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
> EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
>@@ -725,15 +770,23 @@ EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
>  */
> void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
> {
>+=09struct page *data_page;
> =09struct tpm_buf buf;
>-=09int rc;
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
>-=09if (rc)
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page) {
>+=09=09WARN(1, "tpm: out of memory");
> =09=09return;
>+=09}
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
>+=09=09      TPM2_CC_SHUTDOWN);
>+
> =09tpm_buf_append_u16(&buf, shutdown_type);
> =09tpm_transmit_cmd(chip, &buf, 0, "stopping the TPM");
>-=09tpm_buf_destroy(&buf);
>+
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> }
>
> /**
>@@ -751,26 +804,36 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdo=
wn_type)
>  */
> static int tpm2_do_selftest(struct tpm_chip *chip)
> {
>+=09struct page *data_page;
> =09struct tpm_buf buf;
>+=09void *data_ptr;
> =09int full;
> =09int rc;
>
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09data_ptr =3D kmap(data_page);
>+
> =09for (full =3D 0; full < 2; full++) {
>-=09=09rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
>-=09=09if (rc)
>-=09=09=09return rc;
>+=09=09tpm_buf_reset(&buf, data_ptr, PAGE_SIZE, TPM2_ST_NO_SESSIONS,
>+=09=09=09      TPM2_CC_SELF_TEST);
>
> =09=09tpm_buf_append_u8(&buf, full);
>+
> =09=09rc =3D tpm_transmit_cmd(chip, &buf, 0,
> =09=09=09=09      "attempting the self test");
>-=09=09tpm_buf_destroy(&buf);
>
> =09=09if (rc =3D=3D TPM2_RC_TESTING)
> =09=09=09rc =3D TPM2_RC_SUCCESS;
>+
> =09=09if (rc =3D=3D TPM2_RC_INITIALIZE || rc =3D=3D TPM2_RC_SUCCESS)
>-=09=09=09return rc;
>+=09=09=09break;
> =09}
>
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
>@@ -788,16 +851,22 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
>  */
> int tpm2_probe(struct tpm_chip *chip)
> {
>+=09struct page *data_page;
> =09struct tpm_header *out;
> =09struct tpm_buf buf;
> =09int rc;
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY)=
;
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
>+=09=09      TPM2_CC_GET_CAPABILITY);
>+
> =09tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
> =09tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
> =09tpm_buf_append_u32(&buf, 1);
>+
> =09rc =3D tpm_transmit_cmd(chip, &buf, 0, NULL);
> =09/* We ignore TPM return codes on purpose. */
> =09if (rc >=3D  0) {
>@@ -805,7 +874,9 @@ int tpm2_probe(struct tpm_chip *chip)
> =09=09if (be16_to_cpu(out->tag) =3D=3D TPM2_ST_NO_SESSIONS)
> =09=09=09chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> =09}
>-=09tpm_buf_destroy(&buf);
>+
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return 0;
> }
> EXPORT_SYMBOL_GPL(tpm2_probe);
>@@ -843,21 +914,25 @@ struct tpm2_pcr_selection {
> ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> {
> =09struct tpm2_pcr_selection pcr_selection;
>-=09struct tpm_buf buf;
>-=09void *marker;
>-=09void *end;
>-=09void *pcr_select_offset;
> =09u32 sizeof_pcr_selection;
>-=09u32 nr_possible_banks;
>+=09void *pcr_select_offset;
> =09u32 nr_alloc_banks =3D 0;
>+=09struct page *data_page;
>+=09u32 nr_possible_banks;
>+=09struct tpm_buf buf;
> =09u16 hash_alg;
>+=09void *marker;
> =09u32 rsp_len;
>-=09int rc;
> =09int i =3D 0;
>+=09void *end;
>+=09int rc;
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY)=
;
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
>+=09=09      TPM2_CC_GET_CAPABILITY);
>
> =09tpm_buf_append_u32(&buf, TPM2_CAP_PCRS);
> =09tpm_buf_append_u32(&buf, 0);
>@@ -913,14 +988,16 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chi=
p)
> =09}
>
> =09chip->nr_allocated_banks =3D nr_alloc_banks;
>-out:
>-=09tpm_buf_destroy(&buf);
>
>+out:
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
> static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
> {
>+=09struct page *data_page;
> =09struct tpm_buf buf;
> =09u32 nr_commands;
> =09__be32 *attrs;
>@@ -930,35 +1007,32 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *c=
hip)
>
> =09rc =3D tpm2_get_tpm_pt(chip, TPM_PT_TOTAL_COMMANDS, &nr_commands, NULL=
);
> =09if (rc)
>-=09=09goto out;
>+=09=09return rc;
>
>-=09if (nr_commands > 0xFFFFF) {
>-=09=09rc =3D -EFAULT;
>-=09=09goto out;
>-=09}
>+=09if (nr_commands > 0xFFFFF)
>+=09=09return -EFAULT;
>
> =09chip->cc_attrs_tbl =3D devm_kcalloc(&chip->dev, 4, nr_commands,
> =09=09=09=09=09  GFP_KERNEL);
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY)=
;
>-=09if (rc)
>-=09=09goto out;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
>+=09=09      TPM2_CC_GET_CAPABILITY);
>
> =09tpm_buf_append_u32(&buf, TPM2_CAP_COMMANDS);
> =09tpm_buf_append_u32(&buf, TPM2_CC_FIRST);
> =09tpm_buf_append_u32(&buf, nr_commands);
>
> =09rc =3D tpm_transmit_cmd(chip, &buf, 9 + 4 * nr_commands, NULL);
>-=09if (rc) {
>-=09=09tpm_buf_destroy(&buf);
>+=09if (rc)
> =09=09goto out;
>-=09}
>
> =09if (nr_commands !=3D
>-=09    be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE + 5])) {
>-=09=09tpm_buf_destroy(&buf);
>+=09    be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE + 5]))
> =09=09goto out;
>-=09}
>
> =09chip->nr_commands =3D nr_commands;
>
>@@ -974,11 +1048,13 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *c=
hip)
> =09=09}
> =09}
>
>-=09tpm_buf_destroy(&buf);
>-
> out:
>+=09kunmap(data_page);
>+=09__free_page(data_page);
>+
> =09if (rc > 0)
> =09=09rc =3D -ENODEV;
>+
> =09return rc;
> }
>
>@@ -995,19 +1071,24 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *c=
hip)
>
> static int tpm2_startup(struct tpm_chip *chip)
> {
>+=09struct page *data_page;
> =09struct tpm_buf buf;
> =09int rc;
>
> =09dev_info(&chip->dev, "starting up the TPM manually\n");
>
>-=09rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
>-=09if (rc < 0)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
>+=09=09      TPM2_CC_STARTUP);
>
> =09tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
> =09rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
>-=09tpm_buf_destroy(&buf);
>
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return rc;
> }
>
>diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
>index 982d341d8837..1d3e47392f23 100644
>--- a/drivers/char/tpm/tpm2-space.c
>+++ b/drivers/char/tpm/tpm2-space.c
>@@ -68,14 +68,18 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_=
space *space)
> static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> =09=09=09     unsigned int *offset, u32 *handle)
> {
>-=09struct tpm_buf tbuf;
> =09struct tpm2_context *ctx;
>+=09struct page *data_page;
> =09unsigned int body_size;
>+=09struct tpm_buf tbuf;
> =09int rc;
>
>-=09rc =3D tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_LOAD);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>+
>+=09tpm_buf_reset(&tbuf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
>+=09=09      TPM2_CC_CONTEXT_LOAD);
>
> =09ctx =3D (struct tpm2_context *)&buf[*offset];
> =09body_size =3D sizeof(*ctx) + be16_to_cpu(ctx->blob_size);
>@@ -85,8 +89,8 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *=
buf,
> =09if (rc < 0) {
> =09=09dev_warn(&chip->dev, "%s: failed with a system error %d\n",
> =09=09=09 __func__, rc);
>-=09=09tpm_buf_destroy(&tbuf);
>-=09=09return -EFAULT;
>+=09=09rc =3D -EFAULT;
>+=09=09goto out;
> =09} else if (tpm2_rc_value(rc) =3D=3D TPM2_RC_HANDLE ||
> =09=09   rc =3D=3D TPM2_RC_REFERENCE_H0) {
> =09=09/*
>@@ -100,62 +104,70 @@ static int tpm2_load_context(struct tpm_chip *chip, =
u8 *buf,
> =09=09 * flushed outside the space
> =09=09 */
> =09=09*handle =3D 0;
>-=09=09tpm_buf_destroy(&tbuf);
>-=09=09return -ENOENT;
>+=09=09rc =3D -ENOENT;
>+=09=09goto out;
> =09} else if (rc > 0) {
> =09=09dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
> =09=09=09 __func__, rc);
>-=09=09tpm_buf_destroy(&tbuf);
>-=09=09return -EFAULT;
>+=09=09rc =3D -EFAULT;
>+=09=09goto out;
> =09}
>
> =09*handle =3D be32_to_cpup((__be32 *)&tbuf.data[TPM_HEADER_SIZE]);
> =09*offset +=3D body_size;
>
>-=09tpm_buf_destroy(&tbuf);
>-=09return 0;
>+out:
>+=09kunmap(data_page);
>+=09__free_page(data_page);
>+=09return rc;
> }
>
> static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> =09=09=09     unsigned int buf_size, unsigned int *offset)
> {
>-=09struct tpm_buf tbuf;
> =09unsigned int body_size;
>+=09struct page *data_page;
>+=09struct tpm_buf tbuf;
> =09int rc;
>
>-=09rc =3D tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
>-=09if (rc)
>-=09=09return rc;
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>
>+=09tpm_buf_reset(&tbuf, kmap(data_page), PAGE_SIZE, TPM2_ST_NO_SESSIONS,
>+=09=09      TPM2_CC_CONTEXT_SAVE);
> =09tpm_buf_append_u32(&tbuf, handle);
>
> =09rc =3D tpm_transmit_cmd(chip, &tbuf, 0, NULL);
> =09if (rc < 0) {
> =09=09dev_warn(&chip->dev, "%s: failed with a system error %d\n",
> =09=09=09 __func__, rc);
>-=09=09tpm_buf_destroy(&tbuf);
>-=09=09return -EFAULT;
>+=09=09rc =3D -EFAULT;
>+=09=09goto out;
> =09} else if (tpm2_rc_value(rc) =3D=3D TPM2_RC_REFERENCE_H0) {
>-=09=09tpm_buf_destroy(&tbuf);
>-=09=09return -ENOENT;
>+=09=09rc =3D -ENOENT;
>+=09=09goto out;
> =09} else if (rc) {
> =09=09dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
> =09=09=09 __func__, rc);
>-=09=09tpm_buf_destroy(&tbuf);
>-=09=09return -EFAULT;
>+=09=09rc =3D -EFAULT;
>+=09=09goto out;
> =09}
>
> =09body_size =3D tpm_buf_length(&tbuf) - TPM_HEADER_SIZE;
> =09if ((*offset + body_size) > buf_size) {
> =09=09dev_warn(&chip->dev, "%s: out of backing storage\n", __func__);
>-=09=09tpm_buf_destroy(&tbuf);
>-=09=09return -ENOMEM;
>+=09=09rc =3D -ENOMEM;
>+=09=09goto out;
> =09}
>
> =09memcpy(&buf[*offset], &tbuf.data[TPM_HEADER_SIZE], body_size);
> =09*offset +=3D body_size;
>-=09tpm_buf_destroy(&tbuf);
>-=09return 0;
>+
>+out:
>+=09kunmap(data_page);
>+=09__free_page(data_page);
>+=09return rc;
> }
>
> void tpm2_flush_space(struct tpm_chip *chip)
>diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm=
_proxy.c
>index 2f6e087ec496..e6e89be0e149 100644
>--- a/drivers/char/tpm/tpm_vtpm_proxy.c
>+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
>@@ -394,19 +394,23 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_c=
hip  *chip, u8 status)
>
> static int vtpm_proxy_request_locality(struct tpm_chip *chip, int localit=
y)
> {
>+=09struct proxy_dev *proxy_dev =3D dev_get_drvdata(&chip->dev);
>+=09const struct tpm_header *header;
>+=09struct page *data_page;
> =09struct tpm_buf buf;
> =09int rc;
>-=09const struct tpm_header *header;
>-=09struct proxy_dev *proxy_dev =3D dev_get_drvdata(&chip->dev);
>+
>+=09data_page =3D alloc_page(GFP_HIGHUSER);
>+=09if (!data_page)
>+=09=09return -ENOMEM;
>
> =09if (chip->flags & TPM_CHIP_FLAG_TPM2)
>-=09=09rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS,
>-=09=09=09=09  TPM2_CC_SET_LOCALITY);
>+=09=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE,
>+=09=09=09      TPM2_ST_SESSIONS, TPM2_CC_SET_LOCALITY);
> =09else
>-=09=09rc =3D tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND,
>-=09=09=09=09  TPM_ORD_SET_LOCALITY);
>-=09if (rc)
>-=09=09return rc;
>+=09=09tpm_buf_reset(&buf, kmap(data_page), PAGE_SIZE,
>+=09=09=09      TPM_TAG_RQU_COMMAND, TPM_ORD_SET_LOCALITY);
>+
> =09tpm_buf_append_u8(&buf, locality);
>
> =09proxy_dev->state |=3D STATE_DRIVER_COMMAND;
>@@ -426,8 +430,8 @@ static int vtpm_proxy_request_locality(struct tpm_chip=
 *chip, int locality)
> =09=09locality =3D -1;
>
> out:
>-=09tpm_buf_destroy(&buf);
>-
>+=09kunmap(data_page);
>+=09__free_page(data_page);
> =09return locality;
> }
>
>--=20
>2.20.1
>

