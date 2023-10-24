Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CF17D467F
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Oct 2023 05:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjJXDy0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Oct 2023 23:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjJXDxb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2023 23:53:31 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D6D1717
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2023 20:52:37 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-778ac9c898dso193823485a.0
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2023 20:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698119556; x=1698724356; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rmddIeGleB+CvcksXIlwUEw0FkwTQo8xqUcvDqbnLkY=;
        b=bwsnazR6ZZuMwadnjERsh/NRnerpmP1Ec6vOkf/ySCmP5i8DEO0UptP0I/LLzU5T3+
         x1kPSjZGsXyNwA061wBem1iZiloGh3A8niXMkTnRbfjozpezswvP5/PqxyBSHRj4o2WC
         36MqS1SlWG/XlkdbT7I4GThRkxp9q44TEO9myX3Vcl1NfejNWTlDVL/K0IMjqNrLM3X6
         8KWlcW5IN1C91m2ah5qji5G8Gca1EfRArip/Zey6w9gFGLm6ngIc+B+WKPZsRPLh2WWR
         c6bWEGq5AD2Xi/fRDYvM/HKx4CBFFk1wFEtfQkXy9p2z7Lm58jUklbQGDz8vjtJEYpEi
         j0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698119556; x=1698724356;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmddIeGleB+CvcksXIlwUEw0FkwTQo8xqUcvDqbnLkY=;
        b=ppSAlTV9u5THtz83+VlkfkykNBWL1d+RvFseda2nRRqPS5sM8iJdvx2gx+kCJkDvX2
         OSevHQMI1WHRXu40UhYSm86wZeOz/YvLOY6FRGcYsFgYN12GRjXOL+M9eqT+01TUAG6w
         cJYjd0oseJGZSXC0sCbadQ3JL/CesB1P0Ks0JZhJEgoggnhlJ9bl7vG+QgmgCMyNVIfS
         4fzSqEvZG3IQe6S/FPVhQp7cHnVy/FgxkJyecNFXTrFyyPXkYb8NjBMXFWaVwhtwVJ7I
         xHqO3ArdRc9SzrV+GckXYZqrwuUF6NdmiSdJFEwS5zRol+7s98mMOshOmykOoZFtWlFJ
         Qxmg==
X-Gm-Message-State: AOJu0YzSDYWdDW384/+oL1A5ApdPsF3+uJTCGx1enzQ62suujv5ePQ+S
        zfbeT9mdTG1KATg2drSVdhNF
X-Google-Smtp-Source: AGHT+IFa4kcq1x8534opliGWAomlb7YsXdOWGv2jKnIrbHP0ah0tMcnkxxPdDx5NrEcrjlcEEcKHZw==
X-Received: by 2002:a05:620a:172a:b0:775:9c22:e901 with SMTP id az42-20020a05620a172a00b007759c22e901mr12880926qkb.15.1698119556628;
        Mon, 23 Oct 2023 20:52:36 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id t14-20020a05620a0b0e00b007757fefea79sm3144655qkg.130.2023.10.23.20.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 20:52:36 -0700 (PDT)
Date:   Mon, 23 Oct 2023 23:52:35 -0400
Message-ID: <0c3ac562e5b8ea82d962478459bc7047.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, audit@vger.kernel.org,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH RFC v11 17/19] scripts: add boot policy generation program
References: <1696457386-3010-18-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1696457386-3010-18-git-send-email-wufan@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Oct  4, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> Enables an IPE policy to be enforced from kernel start, enabling access
> control based on trust from kernel startup. This is accomplished by
> transforming an IPE policy indicated by CONFIG_IPE_BOOT_POLICY into a
> c-string literal that is parsed at kernel startup as an unsigned policy.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v2:
>   + No Changes
> 
> v3:
>   + No Changes
> 
> v4:
>   + No Changes
> 
> v5:
>   + No Changes
> 
> v6:
>   + No Changes
> 
> v7:
>   + Move from 01/11 to 14/16
>   + Don't return errno directly.
>   + Make output of script more user-friendly
>   + Add escaping for tab and '?'
>   + Mark argv pointer const
>   + Invert return code check in the boot policy parsing code path.
> 
> v8:
>   + No significant changes.
> 
> v9:
>   + No changes
> 
> v10:
>   + Update the init part code for rcu changes in the eval loop patch
> 
> v11:
>   + Fix code style issues
> ---
>  MAINTAINERS                   |   1 +
>  scripts/Makefile              |   1 +
>  scripts/ipe/Makefile          |   2 +
>  scripts/ipe/polgen/.gitignore |   1 +
>  scripts/ipe/polgen/Makefile   |   6 ++
>  scripts/ipe/polgen/polgen.c   | 145 ++++++++++++++++++++++++++++++++++
>  security/ipe/.gitignore       |   1 +
>  security/ipe/Kconfig          |  10 +++
>  security/ipe/Makefile         |  11 +++
>  security/ipe/fs.c             |   8 ++
>  security/ipe/ipe.c            |  12 +++
>  11 files changed, 198 insertions(+)
>  create mode 100644 scripts/ipe/Makefile
>  create mode 100644 scripts/ipe/polgen/.gitignore
>  create mode 100644 scripts/ipe/polgen/Makefile
>  create mode 100644 scripts/ipe/polgen/polgen.c
>  create mode 100644 security/ipe/.gitignore

...

> diff --git a/scripts/ipe/polgen/polgen.c b/scripts/ipe/polgen/polgen.c
> new file mode 100644
> index 000000000000..40b6fe07f47b
> --- /dev/null
> +++ b/scripts/ipe/polgen/polgen.c
> @@ -0,0 +1,145 @@

...

> +static int write_boot_policy(const char *pathname, const char *buf, size_t size)
> +{
> +	int rc = 0;
> +	FILE *fd;
> +	size_t i;
> +
> +	fd = fopen(pathname, "w");
> +	if (!fd) {
> +		rc = errno;
> +		goto err;
> +	}
> +
> +	fprintf(fd, "/* This file is automatically generated.");
> +	fprintf(fd, " Do not edit. */\n");
> +	fprintf(fd, "#include <linux/stddef.h>\n");
> +	fprintf(fd, "\nextern const char *const ipe_boot_policy;\n\n");
> +	fprintf(fd, "const char *const ipe_boot_policy =\n");
> +
> +	if (!buf || size == 0) {
> +		fprintf(fd, "\tNULL;\n");
> +		fclose(fd);
> +		return 0;
> +	}
> +
> +	fprintf(fd, "\t\"");
> +
> +	for (i = 0; i < size; ++i) {
> +		switch (buf[i]) {
> +		case '"':
> +			fprintf(fd, "\\\"");
> +			break;
> +		case '\'':
> +			fprintf(fd, "'");
> +			break;

The revision of IPE proposed in this patchset doesn't support parsing
single or double quotes, yes?

> +		case '\n':
> +			fprintf(fd, "\\n\"\n\t\"");
> +			break;
> +		case '\\':
> +			fprintf(fd, "\\\\");
> +			break;
> +		case '\t':
> +			fprintf(fd, "\\t");
> +			break;
> +		case '\?':
> +			fprintf(fd, "\\?");
> +			break;

Similar, are question marks supported by the parser?

> +		default:
> +			fprintf(fd, "%c", buf[i]);
> +		}
> +	}
> +	fprintf(fd, "\";\n");
> +	fclose(fd);
> +
> +	return 0;
> +
> +err:
> +	if (fd)
> +		fclose(fd);
> +	return rc;
> +}

...

> diff --git a/security/ipe/.gitignore b/security/ipe/.gitignore
> new file mode 100644
> index 000000000000..eca22ad5ed22
> --- /dev/null
> +++ b/security/ipe/.gitignore
> @@ -0,0 +1 @@
> +boot-policy.c
> \ No newline at end of file

Add a newline please.

--
paul-moore.com
