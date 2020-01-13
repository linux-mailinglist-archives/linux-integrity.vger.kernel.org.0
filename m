Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8B2138E01
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2020 10:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgAMJmW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Jan 2020 04:42:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38630 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgAMJmV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Jan 2020 04:42:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so7800340wrh.5
        for <linux-integrity@vger.kernel.org>; Mon, 13 Jan 2020 01:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/AnYXrXWYvNhwGCXjTJAreL3RYx7ZKU0okhiknvPq1k=;
        b=LONkt8qUSVzgSpJ3vYRz5tdEdUTiIp7lBSpk8CgEbr+mU66cFuYcwYwY0Gt33ed63d
         Za4k2QokkwkSZrYzZ458SxLbyR6U5j4nYTd1ZGpkw/SI17H4TkFXcEXQ4D3KzgxNTSn+
         bxLdeS1EG1MKd28ac5FKeVtvQ/x1eACkxMXNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/AnYXrXWYvNhwGCXjTJAreL3RYx7ZKU0okhiknvPq1k=;
        b=d6Jukeoa/3WPmF1vMeOp7GHH48qj2VZrENjeJ3jIW1LLancdy/0c72Iqn+iFdEkleL
         tsvKr7rXbfn9Ey6FlDvXEUEY9Pzn0nB8Ttc/WtMPz4V8uEvXL4Or3ImPmEersrXOJYPq
         ruJC6fRpEBYaXUN2SdQVDEXSHhE45OcbAZsoisSjbLXKQocP9HnTTfBy9tptwitkj6oT
         qHynWMpYphHa3gooqfrMz97MrfAnDuEGjjaXPq8Fu1WIMarPxp4VywS5pcQe7mdIhuvu
         A612RAXcihNsWDdjKu3pZYPQYfT3rD0eC5jcAb2UFAltnOpe1bLTUN8tG6fkHrXVl9IG
         yCXw==
X-Gm-Message-State: APjAAAWE8/DtrAzWSj6iNHLTa1uCtqeLW4nx+1u/ffpvJ7AqOWEtXewj
        ADpAuYE4cbFSZVkL/qBNpKISxA==
X-Google-Smtp-Source: APXvYqxxI6qdgEBxTJuEUk3JhYcPPt1IsOdKJoSHupf9NxOVFJcQPh2xufJhPakK9fflGvmxnk0P3g==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr16362892wrt.136.1578908539527;
        Mon, 13 Jan 2020 01:42:19 -0800 (PST)
Received: from ?IPv6:2a00:79e0:42:204:51d1:d96e:f72e:c8c0? ([2a00:79e0:42:204:51d1:d96e:f72e:c8c0])
        by smtp.gmail.com with ESMTPSA id e18sm14474206wrr.95.2020.01.13.01.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 01:42:19 -0800 (PST)
Message-ID: <a8d344e7d9c4683ad87ec0aaf32eabcbfb0f48fb.camel@chromium.org>
Subject: Re: [PATCH v2] ima: add the ability to query the hash of a given
 file.
From:   Florent Revest <revest@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     kpsingh@chromium.org, mjg59@google.com, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Date:   Mon, 13 Jan 2020 10:42:18 +0100
In-Reply-To: <1578499556.5222.157.camel@linux.ibm.com>
References: <20200106162524.164650-1-revest@chromium.org>
         <1578499556.5222.157.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-01-08 at 11:05 -0500, Mimi Zohar wrote:
> On Mon, 2020-01-06 at 17:25 +0100, Florent Revest wrote:
> > From: Florent Revest <revest@google.com>
> > 
> > This allows other parts of the kernel (perhaps a stacked LSM
> > allowing
> > system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the
> > hash
> > of a given file from IMA if it's present in the iint cache.
> > 
> > It's true that the existence of the hash means that it's also in
> > the
> > audit logs or in
> > /sys/kernel/security/ima/ascii_runtime_measurements,
> > but it can be difficult to pull that information out for every
> > subsequent exec.  This is especially true if a given host has been
> > up
> > for a long time and the file was first measured a long time ago.
> > 
> > This is based on Peter Moody's patch:
> >  https://sourceforge.net/p/linux-ima/mailman/message/33036180/
> 
> FYI, but unlike the audit log/IMA measurement list, the iint cache
> entries can be removed.  Refer to security_inode_free().  Perhaps
> mention of this difference should be included, here, in the patch
> description.

Sure, I added a comment about this in a v3.

> > [1] https://lkml.org/lkml/2019/9/10/393
> > 
> > Signed-off-by: Florent Revest <revest@google.com>
> 
> Assuming, with the above difference, you're still interested in
> having this feature upstreamed and addressing the comments above and
> below:
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thank you. Yes we are still interested in this feature!

> > ---
> >  include/linux/ima.h               |  6 ++++
> >  security/integrity/ima/ima_main.c | 46
> > +++++++++++++++++++++++++++++++
> >  2 files changed, 52 insertions(+)
> > 
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 6d904754d858..d621c65ba9a5 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -23,6 +23,7 @@ extern int ima_read_file(struct file *file, enum
> > kernel_read_file_id id);
> >  extern int ima_post_read_file(struct file *file, void *buf, loff_t
> > size,
> >  			      enum kernel_read_file_id id);
> >  extern void ima_post_path_mknod(struct dentry *dentry);
> > +extern int ima_file_hash(struct file *file, char *buf, size_t
> > buf_size);
> >  extern void ima_kexec_cmdline(const void *buf, int size);
> >  
> >  #ifdef CONFIG_IMA_KEXEC
> > @@ -91,6 +92,11 @@ static inline void ima_post_path_mknod(struct
> > dentry *dentry)
> >  	return;
> >  }
> >  
> > +static inline int ima_file_hash(struct file *file, char *buf,
> > size_t buf_size)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> >  static inline void ima_kexec_cmdline(const void *buf, int size) {}
> >  #endif /* CONFIG_IMA */
> >  
> > diff --git a/security/integrity/ima/ima_main.c
> > b/security/integrity/ima/ima_main.c
> > index d7e987baf127..3799b6c6c3b8 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -445,6 +445,52 @@ int ima_file_check(struct file *file, int
> > mask)
> >  }
> >  EXPORT_SYMBOL_GPL(ima_file_check);
> >  
> > +/**
> > + * ima_file_hash - return the stored measurement if a file has
> > been hashed.
> > + * @file: pointer to the file
> > + * @buf: buffer in which to store the hash
> > + * @buf_size: length of the buffer
> > + *
> > + * On success, return the hash algorithm (as defined in the enum
> > hash_algo).
> > + * If buf is not NULL, this function also outputs the hash into
> > buf.
> 
> As of Linux 5.4.y, IMA support for appended file signatures was
> added. Should we indicate that the file hash returned is based on the
> entire file, including the appended signature?
> 
> Mimi

Of course it never hurts to add a comment. :) I'll send a v3 with this
added.

> 
> > + * If the hash is larger than buf_size, then only buf_size bytes
> > will be copied.
> > + * It generally just makes sense to pass a buffer capable of
> > holding the largest
> > + * possible hash: IMA_MAX_DIGEST_SIZE
> > + *
> > + * If IMA is disabled or if no measurement is available, return
> > -EOPNOTSUPP.
> > + * If the parameters are incorrect, return -EINVAL.
> > + */
> > +int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> > +{
> > +	struct inode *inode;
> > +	struct integrity_iint_cache *iint;
> > +	int hash_algo;
> > +
> > +	if (!file)
> > +		return -EINVAL;
> > +
> > +	if (!ima_policy_flag)
> > +		return -EOPNOTSUPP;
> > +
> > +	inode = file_inode(file);
> > +	iint = integrity_iint_find(inode);
> > +	if (!iint)
> > +		return -EOPNOTSUPP;
> > +
> > +	mutex_lock(&iint->mutex);
> > +	if (buf) {
> > +		size_t copied_size;
> > +
> > +		copied_size = min_t(size_t, iint->ima_hash->length,
> > buf_size);
> > +		memcpy(buf, iint->ima_hash->digest, copied_size);
> > +	}
> > +	hash_algo = iint->ima_hash->algo;
> > +	mutex_unlock(&iint->mutex);
> > +
> > +	return hash_algo;
> > +}
> > +EXPORT_SYMBOL_GPL(ima_file_hash);
> > +
> >  /**
> >   * ima_post_create_tmpfile - mark newly created tmpfile as new
> >   * @file : newly created tmpfile

