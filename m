Return-Path: <linux-integrity+bounces-7019-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F594B444DC
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 19:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD92FA40222
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDEE32A81A;
	Thu,  4 Sep 2025 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="So/iaw8n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E953320CB6
	for <linux-integrity@vger.kernel.org>; Thu,  4 Sep 2025 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008362; cv=none; b=LD35uC6j6Ol/U4GXINHhlUwE7P6X1mrTpcYyTY3BlN2JwfhNd7o0R12NwXtsIz07Rx40w2Nq1skLWa5Re+BwJopohIxNvgSS+DMmnbxkoKC0n40uPWjmvNfEyQHXcL8vxyQsuBTu/DMjTCR16jOsgQ029fIUNo94u3ZQjAqxn9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008362; c=relaxed/simple;
	bh=zIUzBoqMCs+upPbaW+SMs3OzZCg0Ui90/iMoYugGpcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBM5nBNopWbuTuo99L8Ubuu8NcD28I+1HXoAAwOBaSZprp1vSx426cPWQwVQ2PcrT/PEtG+VnlbDm8IhTn3b79xoFbxWiK2pOsJrZBf8A1OS7yozfPuuHbr+8y5LI3bY3FCOpCteZfbWy3ea8gKWBogFMXq7gDNejSK2Rii1pys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=So/iaw8n; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32b7d165dc6so1164966a91.3
        for <linux-integrity@vger.kernel.org>; Thu, 04 Sep 2025 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757008360; x=1757613160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4wEovec4irSS2AhdcFcIsDZ/T4ifbTabakPGYBIh1g=;
        b=So/iaw8nesXY9P9+e0uQGrdh161TLgza4xvrjT5shKr9021QC6xTBGJpsOLweGWomi
         l1Z0+AYvsHc3dIWaNZRpFkzqBBodi46XwW1Mp7nTpJmqe/di5/aJl5/seC37hLIjsH6z
         4oC+KpkdnPULeR6LH8xeWEl5XVQON5BQ8GhyCGfF5SSXYj4zRF55UWFuDQ1rYgtI3uWs
         IKMBkXbwvlwBnnkr6xnJTICw0m51DI0bjV2t1n3Xhf0zG/VIxPreoBuJDD2QNIMp/AHo
         PLPae7rG3sqtJ+ZtCuv/xhjs+f29HyXCY4JW9hD8njWAlm73MUh5O3RvvZn0/PjdV7OE
         tHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008360; x=1757613160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4wEovec4irSS2AhdcFcIsDZ/T4ifbTabakPGYBIh1g=;
        b=gb80DlU0K/K9YMaI/FMxFRawXCPwvDtmlJMQdVGceF0r7oPFUZ1E6QaLyUcJlvvUNx
         sZDsuUzBG1vSz7loftJXkiNzR+AZesXzYD4fJzhhQ/7rNRcVm7RZdH1SIg5EluPN7m8p
         7kVr4CcMw/+KYc2vruDC018dGy0wEgsks8yotQIAiygYLoby2Z6LlsA+qYilxOkmjjgQ
         3jQa/IHDJOWFFWNQkXingZv9/lUVjIGialHf/myTSbdZn1fdLohS4f48NHvmMZafEYgr
         CGCS0ASEfv9ZkQM2pPpBrrQ2FG62vt8K7ndEZwvXpfPZPpg0PNlclltSSQEe9Vd43lq+
         kQGw==
X-Forwarded-Encrypted: i=1; AJvYcCX6VdGPIkFnBB5OngD0JYiXWVtU+ThQL56fuV/V2eZovRP2DwvOz+xDFDk6Kl2zWS088eFYkspTRI/iA2Zx5fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHhpdnTDD17dhurnXUDfOiZKiuO7BsZy8dsEtdY32i+XD2Ofzo
	TQSbhWLCKfOoyVtwQ/AotGmPztznRE6D4YzogMpWz/6NKHsmbip7vIuvAs0gnawZJ3UcRdBAetQ
	Dyl3qQemYLhQ7wtCLGQetelQK8ijQ3XFc8rhhb88Y
X-Gm-Gg: ASbGncs5pszHvw7AwCsH0S3vRT4/MqMo8BdU0rez/MAcpk4C9B2TITDO+j+6CfFqttt
	NiZe9epgEKTKSegkD14T/7H7rMqVeoo5x6QumGFmVH2S4xG7K5QQ8psmhKUrhqMxaFrcoWUO3y1
	PNXjgZv8bbiBZjo+SB10Pu/mCsIa0Ve8+e4tN4dP+fEhRwoH6LesCGpBW+8lDDYjhRUVnfp4AwR
	wziTXBtPgPW696gzQ==
X-Google-Smtp-Source: AGHT+IHARERwIOrQzAiha36b5KLgb4mgjkt5iW0JpSJFow8LH+VqRSx10lHb02TqQRnwF0ghmxuhvBrs9ntvdzohquQ=
X-Received: by 2002:a17:90b:3d48:b0:32b:70a7:16da with SMTP id
 98e67ed59e1d1-32b70a71b2fmr8276282a91.20.1757008359843; Thu, 04 Sep 2025
 10:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com> <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
 <e92064a4-06c5-4913-917c-f9aca02378f3@canonical.com> <CAHC9VhQPmF-RCSUjZo-pe1+sWyw5ZGdnD7P0CWb7yXQQoo+92g@mail.gmail.com>
In-Reply-To: <CAHC9VhQPmF-RCSUjZo-pe1+sWyw5ZGdnD7P0CWb7yXQQoo+92g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 13:52:27 -0400
X-Gm-Features: Ac12FXzUqs3EGM9cpy-oy7cir66WjVMKoCa34Q4_quIWr1Hu03-7eQL_aCQUQYE
Message-ID: <CAHC9VhRjQrjvsn65A-TGKKGrVFjZdnPBu+1vp=7w86SOjoyiUw@mail.gmail.com>
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: John Johansen <john.johansen@canonical.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:18=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I'll rework this function, but I'll hold off on posting another
> revision until I hear back on some of the reviews that are still
> pending in case additional edits are needed.

For the curious, here is what it looks like now:

diff --git a/security/inode.c b/security/inode.c
index 43382ef8896e..4813d116fd7c 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,6 +22,8 @@
#include <linux/lsm_hooks.h>
#include <linux/magic.h>

+#include "lsm.h"
+
static struct vfsmount *mount;
static int mount_count;

@@ -315,12 +317,49 @@ void securityfs_remove(struct dentry *dentry)
EXPORT_SYMBOL_GPL(securityfs_remove);

#ifdef CONFIG_SECURITY
+#include <linux/spinlock.h>
+
static struct dentry *lsm_dentry;
+
static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
                       loff_t *ppos)
{
-       return simple_read_from_buffer(buf, count, ppos, lsm_names,
-               strlen(lsm_names));
+       int i;
+       static char *str;
+       static size_t len;
+       static DEFINE_SPINLOCK(lock);
+
+       /* NOTE: we never free or modify the string once it is set */
+
+       if (unlikely(!str)) {
+               char *str_tmp;
+               size_t len_tmp =3D 0;
+
+               for (i =3D 0; i < lsm_active_cnt; i++)
+                       /* the '+ 1' accounts for either a comma or a NUL *=
/
+                       len_tmp +=3D strlen(lsm_idlist[i]->name) + 1;
+
+               str_tmp =3D kmalloc(len_tmp, GFP_KERNEL);
+               if (!str_tmp)
+                       return -ENOMEM;
+               str_tmp[0] =3D '\0';
+
+               for (i =3D 0; i < lsm_active_cnt; i++) {
+                       if (i > 0)
+                               strcat(str_tmp, ",");
+                       strcat(str_tmp, lsm_idlist[i]->name);
+               }
+
+               spin_lock(&lock);
+               if (!str) {
+                       str =3D str_tmp;
+                       len =3D len_tmp - 1;
+               } else
+                       kfree(str_tmp);
+               spin_unlock(&lock);
+       }
+
+       return simple_read_from_buffer(buf, count, ppos, str, len);
}

--=20
paul-moore.com

