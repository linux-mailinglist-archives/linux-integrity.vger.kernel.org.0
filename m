Return-Path: <linux-integrity+bounces-7745-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8DFC95A32
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Dec 2025 04:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2C884E031A
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Dec 2025 03:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4642F184524;
	Mon,  1 Dec 2025 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqFwKDJd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p9oOT/Er"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF346FC5
	for <linux-integrity@vger.kernel.org>; Mon,  1 Dec 2025 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764559229; cv=none; b=B6q2BzLtkRwwmzeNv8f3eN3NaczspvMoGY50Pe8cB8aqTm2HDwqoolwojDeWi8+lPpg134E6BIu3+9Pi53FtSya70MQP+wnm6y6g76O1Id9TWBfTzS4pnhBFN4/49w5PMxt2ctT3V2H5c8EocPbojAwoGcqbXfRSqN9X2VNPASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764559229; c=relaxed/simple;
	bh=Vb9WroDq0864t5M9Kfx9rMxovILlwh8aLsQ3w4hqx98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0nlM4dNlv3uaudNuKC1BlWRsPwUt779jRg4l+EVggrESTkE44hHRzLPCCSX0kLxMB2xJ/tP7WVu0KAYLBemBf0NzE+Y/XlrjJuN4AQW2ilxpTVhMaXvxg51nDLu3JDFwSE2yD14Rz2k70HUJtrrh3Ya6BblcXkD6BmlaJ6aG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqFwKDJd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p9oOT/Er; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764559226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXqJZcWcz9ZC2ozfLNEA1toKq3+LmZ/LDwDkCPxnFBE=;
	b=GqFwKDJdA2y0nPqVA0Q/YSY8KJi7h2a561RC7gTqiqZ94KWrXF8t4wVMebtLwGwcBBgJ4+
	ezYmTfYXAKuMj1r+o3GDqr6VzESBaRtK9XkLCE9eUCaYFqDVZnFsIQvoEYI4brUU9iWIxG
	A5rzM6X2HkpG00Wjfu1fc+zEA7F5opg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-rXYhJXyjNfmcDcy7AQU2Lg-1; Sun, 30 Nov 2025 22:20:24 -0500
X-MC-Unique: rXYhJXyjNfmcDcy7AQU2Lg-1
X-Mimecast-MFC-AGG-ID: rXYhJXyjNfmcDcy7AQU2Lg_1764559224
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b8a12f0cb4so3270758b3a.3
        for <linux-integrity@vger.kernel.org>; Sun, 30 Nov 2025 19:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764559224; x=1765164024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXqJZcWcz9ZC2ozfLNEA1toKq3+LmZ/LDwDkCPxnFBE=;
        b=p9oOT/ErA2+kIxM7mD63A4l+Rg1HsgvG0YTGX+vPWW4oJq64MK3frrD/RC0gRq4EPx
         W9ypyOyQcvRBWNmTRG7w9uzCKgBInyfVqVfk0r/foe+azpMJYNPY6wkM+8W1fosgiy4j
         8sijs8YKoEewvC9BNCxMg+WaEoQOEcrlr8R9U5XL60bBg94QOML739GbPdqHqokDerR3
         BA93LPqvwd+TpbQO/LPnHiCTOkwCE0LANRlAYvO6OQlzUsmL3DmVsI2DkBwefCPhEYpL
         iec5n974KAEK1FL6NptTfPBBYN4deyM5Fkvnb0Pj7N48jEl18K0nsutoaBcNqgRlOL3j
         NX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764559224; x=1765164024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXqJZcWcz9ZC2ozfLNEA1toKq3+LmZ/LDwDkCPxnFBE=;
        b=xOsH71QEoWztP1Js4sSsgwc+yrG4OlDoAWci8qfM2VE+il5xk7f/P/YMk3Unk+2nNI
         85pFj/n0hEjAD5k95LNt6NTiL5YhnFu9DgF3sH9rwwh28BNWD4sM3T5+nAGgSrxixndq
         UtRJGXg9XI8/MMkuVvEWC+v2WTzrBBM+XKS6yN88gMCOiXZscX0i5baqwRdWs6kGyTyH
         iisb28G295yvSDsuwFdP7czYZIHImfM2SABzI82Bdaz5iVtMBfHrzCo7jAxKonvy7ZYK
         1AVr6UxlEFpcYLyYvhMiS852gtwBRgTEC8ZxHVq5mm2XJFCp8J+ZIbLwm06Moj3xffPq
         Ic/Q==
X-Gm-Message-State: AOJu0YwCtDqd73b+6dMnblFJ7Yi5san5dtFYzNj1EuNrQtie3lYpfVVl
	1wyCYt2UUcn88lNRiovF9DwyeONQujen4TiIrH4YLJLn+aitu7JCw2dJBYHh5IDc0rbCo72u4RN
	058PUAjzjoi7KmnHHcNSvK7UoZo541SBqqtp7Ku9qTZmHwuIBPJb33DTO4zIU1wAp6cpqbNzuQS
	PtwwFAKQdsPyrK9+IRnCVjABkxVkEz/4E7g7TA7ZgywtV31gAcCSE=
X-Gm-Gg: ASbGncvI4hvJB5j+uizKSbaYzSGLia1hjN71WxeJgwADvLn5VXjFu2Q2LKmiWxY7bYi
	0ALWSXdjEZGvR2IYXacK1kBygm2gJLdi7y9Fdxxr0lR9/QGDBBm1WWrRxXt0UhMzo1MeprjXurL
	nc4LZZ7T+E0bS5jvjfoicfEE7JIIimzN8BlAmmitAvOM/Hjdr8JFjFRjRFWd0jukbHnjCWKp5XB
	kYxkrcMNSy9wzwTgP8q7z6tRXfVFzLkXTep/iw3EXokFBO9v2BH9FpttFrunhQcLS7M5tlm0PBK
	gB6FozhaUMRm10uDINnkg/jSQ4DEc55np4gHqIhZeAbZF/r7uyY93LnNpB03CZOacyzj6VPSBLd
	s
X-Received: by 2002:a05:6a20:9151:b0:35f:6e12:186f with SMTP id adf61e73a8af0-3637db4bbb2mr25840198637.23.1764559223517;
        Sun, 30 Nov 2025 19:20:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9CuPuZntzrNRAc04pPvyHRQQFm4CPQPSh2uI+CpI/gCSssPYukObheQILQqmBeE4dtx5swQ==
X-Received: by 2002:a05:6a20:9151:b0:35f:6e12:186f with SMTP id adf61e73a8af0-3637db4bbb2mr25840133637.23.1764559222769;
        Sun, 30 Nov 2025 19:20:22 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fc08bd1sm11621013b3a.63.2025.11.30.19.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 19:20:22 -0800 (PST)
Date: Mon, 1 Dec 2025 11:15:32 +0800
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] evm: fix security.evm for a file with IMA
 signature
Message-ID: <7jzx432acnp7mrma7om5ccvrc3ucvm5psscst62bcl5t5yklh7@yxhcvmrgbgli>
References: <20250930022658.4033410-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250930022658.4033410-1-coxu@redhat.com>


On Tue, Sep 30, 2025 at 10:26:56AM +0800, Coiby Xu wrote:
>When both IMA and EVM fix modes are enabled, accessing a file with IMA
>signature but missing EVM HMAC won't cause security.evm to be fixed.
>
>Add a function evm_fix_hmac which will be explicitly called to fix EVM
>HMAC for this case.
>
>Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
> include/linux/evm.h                   |  8 ++++++++
> security/integrity/evm/evm_main.c     | 28 +++++++++++++++++++++++++++
> security/integrity/ima/ima_appraise.c |  5 +++++
> 3 files changed, 41 insertions(+)
>
>diff --git a/include/linux/evm.h b/include/linux/evm.h
>index ddece4a6b25d..913f4573b203 100644
>--- a/include/linux/evm.h
>+++ b/include/linux/evm.h
>@@ -18,6 +18,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
> 					     const char *xattr_name,
> 					     void *xattr_value,
> 					     size_t xattr_value_len);
>+int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
>+		 const char *xattr_value, size_t xattr_value_len);
> int evm_inode_init_security(struct inode *inode, struct inode *dir,
> 			    const struct qstr *qstr, struct xattr *xattrs,
> 			    int *xattr_count);
>@@ -51,6 +53,12 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
> {
> 	return INTEGRITY_UNKNOWN;
> }
>+
>+static inline int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
>+			       const char *xattr_value, size_t xattr_value_len)
>+{
>+	return -EOPNOTSUPP;
>+}
> #endif
>
> static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
>diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
>index 0add782e73ba..1b3edc6d26e9 100644
>--- a/security/integrity/evm/evm_main.c
>+++ b/security/integrity/evm/evm_main.c
>@@ -787,6 +787,34 @@ bool evm_revalidate_status(const char *xattr_name)
> 	return true;
> }
>
>+/**
>+ * evm_fix_hmac - Calculate the HMAC and add it to security.evm for fix mode
>+ * @dentry: pointer to the affected dentry which doesn't yet have security.evm
>+ *          xattr
>+ * @xattr_name: pointer to the affected extended attribute name
>+ * @xattr_value: pointer to the new extended attribute value
>+ * @xattr_value_len: pointer to the new extended attribute value length
>+ *
>+ * Expects to be called with i_mutex locked.
>+ *
>+ * Return: 0 on success, -EPERM/-ENOMEM/-EOPNOTSUPP on failure
>+ */
>+int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
>+		 const char *xattr_value, size_t xattr_value_len)
>+
>+{
>+	if (!evm_fixmode || !evm_revalidate_status((xattr_name)))
>+		return -EPERM;
>+
>+	if (!(evm_initialized & EVM_INIT_HMAC))
>+		return -EPERM;
>+
>+	if (is_unsupported_hmac_fs(dentry))
>+		return -EOPNOTSUPP;
>+
>+	return evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
>+}
>+
> /**
>  * evm_inode_post_setxattr - update 'security.evm' to reflect the changes
>  * @dentry: pointer to the affected dentry
>diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>index f435eff4667f..f48ef5ec185e 100644
>--- a/security/integrity/ima/ima_appraise.c
>+++ b/security/integrity/ima/ima_appraise.c
>@@ -601,6 +601,11 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
> 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
> 			if (!ima_fix_xattr(dentry, iint))
> 				status = INTEGRITY_PASS;
>+		} else if (status == INTEGRITY_NOLABEL) {
>+			if (!evm_fix_hmac(dentry, XATTR_NAME_IMA,
>+					  (const char *)xattr_value,
>+					  xattr_len))
>+				status = INTEGRITY_PASS;
> 		}
>
> 		/*
>
>base-commit: e129e479f2e444eaccd822717d418119d39d3d5c
>-- 
>2.51.0
>

Hi Mimi,

I think this patch set just fell off the radar. Can you take a look at
it when time permits? Thanks! Btw, the patch set is still applicable to
current next-integrity tree Linus and main tree.


-- 
Best regards,
Coiby


