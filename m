Return-Path: <linux-integrity+bounces-4485-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BCA9FD22A
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 09:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3FA161B5F
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DC154456;
	Fri, 27 Dec 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cyy3tC85"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC36E14B06E;
	Fri, 27 Dec 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735289046; cv=none; b=m/OGnx0rBwo+kyVuL2PtN9IuSoQNtdtpahnhEJKH+q6PZyanmv0dq/g1KPLOrGdY1a9lu2EpJxKd239Stz0sL23D1K8h0VAG8tGQtMLN6tgte0ty5u4gbxh4PQSLqN5smV92hOuXISFE59HAoZBGFk3L5kTlhRAGDF1UpxnAB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735289046; c=relaxed/simple;
	bh=gQ6l6mTGodEWIyiSpPWDDv1DdRKmI+lv+jBxEhn/ASk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDWtNPGzBbdgtzx0feGRDHNeKQI8p9U16f1rFEHMhzCanvl+bujl38kbS2qzKpIaGq16z7IEGK8XoZQRDIXMbRwOkIp/Rauhhdu6xG+KNEeTc4P8f7JETWv+MuaRWc+jBq4U7TWSbXGVc4qe8mUXJcHpsZiAddQsmTSGi0NEOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cyy3tC85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64852C4CED7;
	Fri, 27 Dec 2024 08:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735289046;
	bh=gQ6l6mTGodEWIyiSpPWDDv1DdRKmI+lv+jBxEhn/ASk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cyy3tC85LmNT6HvftZ0DkQK3PbVRPhhy5O/bSjkBzGAeJwUnLGC8ou8xLHfh+MLxA
	 vKfpRf69ISb8tpbyTXj9510LZ1QuxI3EWmg4bt4tTOCWF0lY2MumKbsuCbytWUYd5R
	 CvdBOuHbVIQNNvSfa4GTFr9nd8UxGUjJlXBbsFpcl9hYyA5HbFbS210QLy547mnrYd
	 C/q2atHcoB4SZlByInmFbXXtztczPCYQvGBWRyTGVx0+ba06RmTOun5s6kwntRhUG0
	 6hV9bdK28LzTKRlwhRtUtnPYz2s3RgCStLe/G59sud6NpXa5m78eJynUermEc+o3cY
	 bIsGSfXn/4GiA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e384e3481so6733692e87.2;
        Fri, 27 Dec 2024 00:44:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXhyVI0OJfDtIQMirLeciM0a6HkzXHzxJc6Jjn6O4ihHsRBvC8QrOrIQuJXaDc84f7f/4ZvB3KjAcUwCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1msZGmWAj+EUR3nqewqxcEP/YL+VQc2yBa3pfW9r9DnPdfJH
	6n8B6jKEA6bPM+GUofkv52ZBgWuQH75lI/815aKsBn+zHBVz13GNhkIzG55R+w4YbXKz/iv0wQy
	lJsBjq9MnLNjF2laYBsZQL014ASc=
X-Google-Smtp-Source: AGHT+IHpFVw/ignli3f+yG0OgnDZKCoHH4AamU6O3VpIBiswuJFZUksDJNEIqlEoArZfp+x96a26uWtvlbgNQ3DgQJQ=
X-Received: by 2002:a05:6512:304f:b0:540:5253:6af2 with SMTP id
 2adb3069b0e04-54229525548mr7343057e87.12.1735289044566; Fri, 27 Dec 2024
 00:44:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241227060053.174314-1-jarkko@kernel.org> <20241227060053.174314-2-jarkko@kernel.org>
In-Reply-To: <20241227060053.174314-2-jarkko@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 27 Dec 2024 09:43:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFB6NL4EASV9_XeRM=iYaoVHQks0pXyVt2tGSQbD-St6g@mail.gmail.com>
Message-ID: <CAMj1kXFB6NL4EASV9_XeRM=iYaoVHQks0pXyVt2tGSQbD-St6g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] tpm: Map the ACPI provided event log
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Colin Ian King <colin.i.king@gmail.com>, 
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Stefan Berger <stefanb@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Andy Liang <andy.liang@hpe.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Dec 2024 at 07:01, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> The following failure was reported:
>
> [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id 0)
> [   10.848132][    T1] ------------[ cut here ]------------
> [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
> [   10.862827][    T1] Modules linked in:
> [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
> [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
> [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
> [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0000000000000000
> [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000040cc0
>
> Above shows that ACPI pointed a 16 MiB buffer for the log events because
> RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address the
> bug by mapping the region when needed instead of copying.
>
> Earlier fix does address the warning but wastes 16 MiB of memory. This
> finalizes the fix.
>
> Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
> Tested-by: Andy Liang <andy.liang@hpe.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Where are patch 1/2 and the cover letter?

> ---
> v7:
> * Fixed up tags.
> * I did consider traverse and thus get smaller buffer, and then using
>   devm_kmalloc() but looking at e.g. drivers/acpi/apei/einj-core.c
>   it is not necessary.
> v6:
> * Updated commit message.
> v5:
> * Spotted this right after sending: remove extra acpi_os_unmap_iomem()
>   call.
> v4:
> * Added tested-by from Andy Liang.
> v3:
> * Flag mapping code in tpm{1,2}.c with CONFIG_ACPI (nios2 compilation
>   fix).
> v2:
> * There was some extra cruft (irrelevant diff), which is now wiped away.
> * Added missing tags (fixes, stable).
> ---
>  drivers/char/tpm/eventlog/acpi.c   | 33 ++++++--------------------
>  drivers/char/tpm/eventlog/common.c | 25 +++++++++++++-------
>  drivers/char/tpm/eventlog/common.h | 28 ++++++++++++++++++++++
>  drivers/char/tpm/eventlog/tpm1.c   | 30 ++++++++++++++---------
>  drivers/char/tpm/eventlog/tpm2.c   | 38 +++++++++++++++++-------------
>  include/linux/tpm.h                |  1 +
>  6 files changed, 94 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 394c8302cefd..a11f78e41e1e 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -75,14 +75,11 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>         acpi_status status;
>         void __iomem *virt;
>         u64 len, start;
> -       struct tpm_bios_log *log;
>         struct acpi_table_tpm2 *tbl;
>         struct acpi_tpm2_phy *tpm2_phy;
>         int format;
>         int ret;
>
> -       log = &chip->log;
> -
>         /* Unfortuntely ACPI does not associate the event log with a specific
>          * TPM, like PPI. Thus all ACPI TPMs will read the same log.
>          */
> @@ -140,42 +137,26 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>                 return -EIO;
>         }
>
> -       /* malloc EventLog space */
> -       log->bios_event_log = kvmalloc(len, GFP_KERNEL);
> -       if (!log->bios_event_log)
> -               return -ENOMEM;
> -
> -       ret = devm_add_action_or_reset(&chip->dev, tpm_bios_log_free, log->bios_event_log);
> -       if (ret) {
> -               log->bios_event_log = NULL;
> -               return ret;
> -       }
> -
> -       log->bios_event_log_end = log->bios_event_log + len;
> -
>         virt = acpi_os_map_iomem(start, len);
>         if (!virt) {
>                 dev_warn(&chip->dev, "%s: Failed to map ACPI memory\n", __func__);
>                 /* try EFI log next */
> -               ret = -ENODEV;
> -               goto err;
> +               return -ENODEV;
>         }
>
> -       memcpy_fromio(log->bios_event_log, virt, len);
> -
> -       acpi_os_unmap_iomem(virt, len);
> -
> -       if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
> -           !tpm_is_tpm2_log(log->bios_event_log, len)) {
> +       if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_tpm2_log(virt, len)) {
>                 /* try EFI log next */
>                 ret = -ENODEV;
>                 goto err;
>         }
>
> +       acpi_os_unmap_iomem(virt, len);
> +       chip->flags |= TPM_CHIP_FLAG_ACPI_LOG;
> +       chip->log.bios_event_log = (void *)start;
> +       chip->log.bios_event_log_end = (void *)start + len;
>         return format;
>
>  err:
> -       devm_kfree(&chip->dev, log->bios_event_log);
> -       log->bios_event_log = NULL;
> +       acpi_os_unmap_iomem(virt, len);
>         return ret;
>  }
> diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
> index 4c0bbba64ee5..44340ca6e2ac 100644
> --- a/drivers/char/tpm/eventlog/common.c
> +++ b/drivers/char/tpm/eventlog/common.c
> @@ -27,6 +27,7 @@ static int tpm_bios_measurements_open(struct inode *inode,
>  {
>         int err;
>         struct seq_file *seq;
> +       struct tpm_measurements *priv;
>         struct tpm_chip_seqops *chip_seqops;
>         const struct seq_operations *seqops;
>         struct tpm_chip *chip;
> @@ -42,13 +43,18 @@ static int tpm_bios_measurements_open(struct inode *inode,
>         get_device(&chip->dev);
>         inode_unlock(inode);
>
> -       /* now register seq file */
> +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +       priv->chip = chip;
> +
>         err = seq_open(file, seqops);
> -       if (!err) {
> -               seq = file->private_data;
> -               seq->private = chip;
> -       } else {
> +       if (err) {
> +               kfree(priv);
>                 put_device(&chip->dev);
> +       } else {
> +               seq = file->private_data;
> +               seq->private = priv;
>         }
>
>         return err;
> @@ -58,11 +64,14 @@ static int tpm_bios_measurements_release(struct inode *inode,
>                                          struct file *file)
>  {
>         struct seq_file *seq = file->private_data;
> -       struct tpm_chip *chip = seq->private;
> +       struct tpm_measurements *priv = seq->private;
> +       int ret;
>
> -       put_device(&chip->dev);
> +       put_device(&priv->chip->dev);
> +       ret = seq_release(inode, file);
> +       kfree(priv);
>
> -       return seq_release(inode, file);
> +       return ret;
>  }
>
>  static const struct file_operations tpm_bios_measurements_ops = {
> diff --git a/drivers/char/tpm/eventlog/common.h b/drivers/char/tpm/eventlog/common.h
> index 47ff8136ceb5..b98fd6d9a6e9 100644
> --- a/drivers/char/tpm/eventlog/common.h
> +++ b/drivers/char/tpm/eventlog/common.h
> @@ -1,12 +1,40 @@
>  #ifndef __TPM_EVENTLOG_COMMON_H__
>  #define __TPM_EVENTLOG_COMMON_H__
>
> +#include <linux/acpi.h>
>  #include "../tpm.h"
>
>  extern const struct seq_operations tpm1_ascii_b_measurements_seqops;
>  extern const struct seq_operations tpm1_binary_b_measurements_seqops;
>  extern const struct seq_operations tpm2_binary_b_measurements_seqops;
>
> +struct tpm_measurements {
> +       struct tpm_chip *chip;
> +       void *start;
> +       void *end;
> +};
> +
> +static inline bool tpm_measurements_map(struct tpm_measurements *measurements)
> +{
> +       struct tpm_chip *chip = measurements->chip;
> +       struct tpm_bios_log *log = &chip->log;
> +       size_t size;
> +
> +       size = log->bios_event_log_end - log->bios_event_log;
> +       measurements->start = log->bios_event_log;
> +
> +#ifdef CONFIG_ACPI
> +       if (chip->flags & TPM_CHIP_FLAG_ACPI_LOG)
> +               measurements->start = acpi_os_map_iomem((unsigned long)log->bios_event_log, size);
> +#endif
> +
> +       if (!measurements->start)
> +               return false;
> +
> +       measurements->end = measurements->start + size;
> +       return true;
> +}
> +
>  #if defined(CONFIG_ACPI)
>  int tpm_read_log_acpi(struct tpm_chip *chip);
>  #else
> diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> index 12ee42a31c71..aef6ee39423a 100644
> --- a/drivers/char/tpm/eventlog/tpm1.c
> +++ b/drivers/char/tpm/eventlog/tpm1.c
> @@ -70,20 +70,23 @@ static const char* tcpa_pc_event_id_strings[] = {
>  static void *tpm1_bios_measurements_start(struct seq_file *m, loff_t *pos)
>  {
>         loff_t i = 0;
> -       struct tpm_chip *chip = m->private;
> -       struct tpm_bios_log *log = &chip->log;
> -       void *addr = log->bios_event_log;
> -       void *limit = log->bios_event_log_end;
> +       struct tpm_measurements *priv = m->private;
>         struct tcpa_event *event;
>         u32 converted_event_size;
>         u32 converted_event_type;
> +       void *addr;
> +
> +       if (!tpm_measurements_map(priv))
> +               return NULL;
> +
> +       addr = priv->start;
>
>         /* read over *pos measurements */
>         do {
>                 event = addr;
>
>                 /* check if current entry is valid */
> -               if (addr + sizeof(struct tcpa_event) > limit)
> +               if (addr + sizeof(struct tcpa_event) > priv->end)
>                         return NULL;
>
>                 converted_event_size =
> @@ -93,7 +96,7 @@ static void *tpm1_bios_measurements_start(struct seq_file *m, loff_t *pos)
>
>                 if (((converted_event_type == 0) && (converted_event_size == 0))
>                     || ((addr + sizeof(struct tcpa_event) + converted_event_size)
> -                       > limit))
> +                       > priv->end))
>                         return NULL;
>
>                 if (i++ == *pos)
> @@ -109,9 +112,7 @@ static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
>                                         loff_t *pos)
>  {
>         struct tcpa_event *event = v;
> -       struct tpm_chip *chip = m->private;
> -       struct tpm_bios_log *log = &chip->log;
> -       void *limit = log->bios_event_log_end;
> +       struct tpm_measurements *priv = m->private;
>         u32 converted_event_size;
>         u32 converted_event_type;
>
> @@ -121,7 +122,7 @@ static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
>         v += sizeof(struct tcpa_event) + converted_event_size;
>
>         /* now check if current entry is valid */
> -       if ((v + sizeof(struct tcpa_event)) > limit)
> +       if ((v + sizeof(struct tcpa_event)) > priv->end)
>                 return NULL;
>
>         event = v;
> @@ -130,7 +131,7 @@ static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
>         converted_event_type = do_endian_conversion(event->event_type);
>
>         if (((converted_event_type == 0) && (converted_event_size == 0)) ||
> -           ((v + sizeof(struct tcpa_event) + converted_event_size) > limit))
> +           ((v + sizeof(struct tcpa_event) + converted_event_size) > priv->end))
>                 return NULL;
>
>         return v;
> @@ -138,6 +139,13 @@ static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
>
>  static void tpm1_bios_measurements_stop(struct seq_file *m, void *v)
>  {
> +#ifdef CONFIG_ACPI
> +       struct tpm_measurements *priv = m->private;
> +       struct tpm_chip *chip = priv->chip;
> +
> +       if (chip->flags & TPM_CHIP_FLAG_ACPI_LOG)
> +               acpi_os_unmap_iomem(priv->start, priv->end - priv->start);
> +#endif
>  }
>
>  static int get_event_name(char *dest, struct tcpa_event *event,
> diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
> index 37a05800980c..6289d8893e46 100644
> --- a/drivers/char/tpm/eventlog/tpm2.c
> +++ b/drivers/char/tpm/eventlog/tpm2.c
> @@ -41,20 +41,22 @@ static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>
>  static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
>  {
> -       struct tpm_chip *chip = m->private;
> -       struct tpm_bios_log *log = &chip->log;
> -       void *addr = log->bios_event_log;
> -       void *limit = log->bios_event_log_end;
> +       struct tpm_measurements *priv = m->private;
>         struct tcg_pcr_event *event_header;
>         struct tcg_pcr_event2_head *event;
>         size_t size;
> +       void *addr;
>         int i;
>
> +       if (!tpm_measurements_map(priv))
> +               return NULL;
> +
> +       addr = priv->start;
>         event_header = addr;
>         size = struct_size(event_header, event, event_header->event_size);
>
>         if (*pos == 0) {
> -               if (addr + size < limit) {
> +               if (addr + size < priv->end) {
>                         if ((event_header->event_type == 0) &&
>                             (event_header->event_size == 0))
>                                 return NULL;
> @@ -66,7 +68,7 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
>                 addr += size;
>                 event = addr;
>                 size = calc_tpm2_event_size(event, event_header);
> -               if ((addr + size >=  limit) || (size == 0))
> +               if ((addr + size >= priv->end) || !size)
>                         return NULL;
>         }
>
> @@ -74,7 +76,7 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
>                 event = addr;
>                 size = calc_tpm2_event_size(event, event_header);
>
> -               if ((addr + size >= limit) || (size == 0))
> +               if ((addr + size >= priv->end) || !size)
>                         return NULL;
>                 addr += size;
>         }
> @@ -87,14 +89,12 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
>  {
>         struct tcg_pcr_event *event_header;
>         struct tcg_pcr_event2_head *event;
> -       struct tpm_chip *chip = m->private;
> -       struct tpm_bios_log *log = &chip->log;
> -       void *limit = log->bios_event_log_end;
> +       struct tpm_measurements *priv = m->private;
>         size_t event_size;
>         void *marker;
>
>         (*pos)++;
> -       event_header = log->bios_event_log;
> +       event_header = priv->start;
>
>         if (v == SEQ_START_TOKEN) {
>                 event_size = struct_size(event_header, event,
> @@ -109,13 +109,13 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
>         }
>
>         marker = marker + event_size;
> -       if (marker >= limit)
> +       if (marker >= priv->end)
>                 return NULL;
>         v = marker;
>         event = v;
>
>         event_size = calc_tpm2_event_size(event, event_header);
> -       if (((v + event_size) >= limit) || (event_size == 0))
> +       if (((v + event_size) >= priv->end) || !event_size)
>                 return NULL;
>
>         return v;
> @@ -123,13 +123,19 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
>
>  static void tpm2_bios_measurements_stop(struct seq_file *m, void *v)
>  {
> +#ifdef CONFIG_ACPI
> +       struct tpm_measurements *priv = m->private;
> +       struct tpm_chip *chip = priv->chip;
> +
> +       if (chip->flags & TPM_CHIP_FLAG_ACPI_LOG)
> +               acpi_os_unmap_iomem(priv->start, priv->end - priv->start);
> +#endif
>  }
>
>  static int tpm2_binary_bios_measurements_show(struct seq_file *m, void *v)
>  {
> -       struct tpm_chip *chip = m->private;
> -       struct tpm_bios_log *log = &chip->log;
> -       struct tcg_pcr_event *event_header = log->bios_event_log;
> +       struct tpm_measurements *priv = m->private;
> +       struct tcg_pcr_event *event_header = priv->start;
>         struct tcg_pcr_event2_head *event = v;
>         void *temp_ptr;
>         size_t size;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 20a40ade8030..f3d12738b93b 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -348,6 +348,7 @@ enum tpm_chip_flags {
>         TPM_CHIP_FLAG_SUSPENDED                 = BIT(8),
>         TPM_CHIP_FLAG_HWRNG_DISABLED            = BIT(9),
>         TPM_CHIP_FLAG_DISABLE                   = BIT(10),
> +       TPM_CHIP_FLAG_ACPI_LOG          = BIT(11),
>  };
>
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> --
> 2.47.1
>

