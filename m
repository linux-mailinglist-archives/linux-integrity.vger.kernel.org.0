Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 448B4148A63
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2020 15:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbgAXOrD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jan 2020 09:47:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43088 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389799AbgAXOq7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jan 2020 09:46:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so1654070qtj.10;
        Fri, 24 Jan 2020 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eNe/VRfZRRe1s6dr0rfoHWxEkBnp0wzYuINU8sqL1PI=;
        b=E/Q4y2LovUugsf2Ma+07CPRRKOFSYHWRN0VmY5mprnBsYI3+vBGRPI/g5i8Cx3+ar2
         XbDdacy817LqKVGBCD7OoqORVsUdfd0Z7gs/araLburDBARCzQlUav5fHQZFKJ8xd+wB
         DhAhDm+Wz5lrO3Cw6AzbM4WvzRJBCiD2wNcuNhCC9YmN67TYG0w7d2V79MwgM2722D6x
         FiIlhMXgjUnG6XYJ3kUr4uhFNrZHff4z058GQft6eRE1xmvU3hTlqsgErkGU8m8uIH1y
         YjTMYS+nXaAQ3YjAaaJpZu3q/OXGnKm9/YERoWHg+WpZT2aiXoUMraEdk8O6ICUkW+LZ
         7G8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eNe/VRfZRRe1s6dr0rfoHWxEkBnp0wzYuINU8sqL1PI=;
        b=kmZ27Zas1alJEVirFvBT43SefLg6AXxA2dvO4dhF41OEDJ43Tf1rQH1EfrxQ6iRDMv
         hNwDA0plzNehuibgo1qhiluJfEwyee9amEQfoFNxUG6mqHdDHL/u39NhTXVnPdxqMDe3
         7LntIAzv7tgmQcfLsEgHXgK/InLrnBMpFfgu9QFcPBgpB2wClp5WIrj1j0M5xFGhIOfB
         SLAzvuTyzuJvRf2zrnJ5ptGXgh3rVK/A6WjjixeKU6+j7+tWIaz4E/GFVZqyHUIA2m8q
         gdcQk1yrJgHEGVQNaP1XAkHv+q139LJmMJXYPgEkZsxw/iS6OLCNT5LbVrHfkSgrLbyg
         Erfw==
X-Gm-Message-State: APjAAAXUKpm+j0y9u0w6r6OgJi9R+X3eEWga9JHy5MFxfylHYP6jQdf+
        Fez+iCeC4gtn80wUGBf8fo4=
X-Google-Smtp-Source: APXvYqwslxvOG4K2X0fCQ211QwV61hwWmaFrOlBRhy0MgREzF52NiTUHL8l5NDL+wv/l4d0kRVr/LQ==
X-Received: by 2002:ac8:1e08:: with SMTP id n8mr2441082qtl.175.1579877218526;
        Fri, 24 Jan 2020 06:46:58 -0800 (PST)
Received: from localhost.localdomain (pool-74-108-111-89.nycmny.fios.verizon.net. [74.108.111.89])
        by smtp.gmail.com with ESMTPSA id q7sm3118255qkc.43.2020.01.24.06.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:46:58 -0800 (PST)
Message-ID: <1a8c2fb4698eaa72be219413e373c5829a7cd652.camel@gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   david.safford@gmail.com
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Cc:     kgold@linux.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Date:   Fri, 24 Jan 2020 09:46:57 -0500
In-Reply-To: <20200108111743.23393-1-janne.karhunen@gmail.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-01-08 at 13:17 +0200, Janne Karhunen wrote:
> Some systems can end up carrying lots of entries in the ima
> measurement list. Since every entry is using a bit of kernel
> memory, allow the sysadmin to export the measurement list to
> the filesystem to free up some memory.
> 
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>

I like this approach, as it will work easily for measurement lists in 
any format, and it will work for user or kernel triggering.

I'm getting an OOPS, though, whenever I write a filename to the 
securityfs file (e.g. echo /var/log/ima.log > list_name).
Here's the relevant from syslog:

  BUG: unable to handle page fault for address: 00005650a0e7fe30
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0001) - permissions violation

  Oops: 0001 [#1] SMP NOPTI

  RIP: 0010:ima_write_list_name+0x35/0x114

I haven't had time to debug this. Any suggestions?

Also, one embedded comment follows...

> ---
>  security/integrity/ima/ima.h       |   7 +-
>  security/integrity/ima/ima_fs.c    | 171 +++++++++++++++++++++++++++++
>  security/integrity/ima/ima_queue.c |   2 +-
>  3 files changed, 175 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 19769bf5f6ab..78f0b706848d 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -151,20 +151,19 @@ int template_desc_init_fields(const char *template_fmt,
>  struct ima_template_desc *ima_template_desc_current(void);
>  struct ima_template_desc *lookup_template_desc(const char *name);
>  bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
> +void ima_free_template_entry(struct ima_template_entry *entry);
>  int ima_restore_measurement_entry(struct ima_template_entry *entry);
>  int ima_restore_measurement_list(loff_t bufsize, void *buf);
>  int ima_measurements_show(struct seq_file *m, void *v);
>  unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
>  void ima_init_template_list(void);
> +int ima_export_list(const char *from);
>  int __init ima_init_digests(void);
>  int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>  			  void *lsm_data);
>  
> -/*
> - * used to protect h_table and sha_table
> - */
> -extern spinlock_t ima_queue_lock;
> +extern struct mutex ima_extend_list_mutex;
>  
>  struct ima_h_table {
>  	atomic_long_t len;	/* number of stored measurements in the list */
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 2000e8df0301..b60a241b0d8b 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -22,10 +22,17 @@
>  #include <linux/rcupdate.h>
>  #include <linux/parser.h>
>  #include <linux/vmalloc.h>
> +#include <linux/fs_struct.h>
> +#include <linux/syscalls.h>
>  
>  #include "ima.h"
>  
> +#define secfs_mnt	"/sys/kernel/security"
> +#define am_filename	"/integrity/ima/ascii_runtime_measurements"

You probably really want to export the binary data, as that's 
what's needed for attestation. (Or both, but that's trickier.)

dave

> +
>  static DEFINE_MUTEX(ima_write_mutex);
> +static DEFINE_MUTEX(ima_list_mutex);
> +static char *ima_msmt_list_name;
>  
> 

