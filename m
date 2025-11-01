Return-Path: <linux-integrity+bounces-7555-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9CEC2834B
	for <lists+linux-integrity@lfdr.de>; Sat, 01 Nov 2025 17:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFE25349791
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Nov 2025 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14B4274B56;
	Sat,  1 Nov 2025 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YRqeDycH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C41274B3A
	for <linux-integrity@vger.kernel.org>; Sat,  1 Nov 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762015831; cv=none; b=Xvw8Rpskab/JTQ9jkGs4q/R49TDxdMv2UozY/wSYuCpqxberfbWqllfKxlsipKzpAF/c4eQt93Q066fqkMlh5Q1TED98u1JrPsW4u7tK9BFl5pSMZb3lggYbIKsGy0qi4Z0j2s4d2559PEnz1cPMu18e9fTHwaGJkIhm3+3ISqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762015831; c=relaxed/simple;
	bh=FrZal8yYbhzhsqba5frY/Ttn5N1pNqoOnzgHhUFgsMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbJMULZGjMzPJPamZJxLmRC80xtclsL9wWLsex/mK94lyFVvGrtvsBWp7zDNjMPHrZY9wOKvY/G7tOTP7Yyz4E7jsIM162CrbMN5W8bQr1hTUgfow74KVn0gAX/vy5rLaLqcaU1k5OvXUyuKyYRjhYWhM7ovFoH03hAcv6fhl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YRqeDycH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2951a817541so27509035ad.2
        for <linux-integrity@vger.kernel.org>; Sat, 01 Nov 2025 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762015829; x=1762620629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp7Jl4nag3DStXHFmy5x4RJxSYwbRYZWfeoPk0Z1FdM=;
        b=YRqeDycHaZhIN5PFnK4dy7UP8uzbp+z9HIUt7ljqP36Cyrug+jdLLAW7SyOqqKqeXY
         rS7nhw9YtCXiEqvwxrGd70H1irWo1+ZN1evlgcTMPNi5B4tlu944C3qQSJNN61i6iKmG
         nXPwRUlpVYfEaaDBk57akMhV/ZArZGqy29gi4PNulfqXB6m6rEQEMxC0SrKJrNeLx/v6
         qugSgQpcphkxX9oltRD4s/oDDDdcUqi22KX6nfFlHGPz90D1Dwx4Ryy7mvP06kSCPZPi
         VztLTPQCEbCNdONUx6Vsq1RpCtIxpQJ1cJnuL9qgoC7j67GmVyQ7z3k7N0B1iDFnYP1b
         WNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762015829; x=1762620629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp7Jl4nag3DStXHFmy5x4RJxSYwbRYZWfeoPk0Z1FdM=;
        b=uO9CNyQ72SKJKiQPq2/BjevR2YNTXMq6vIb1kZKTmlSD0O6qWffUjhAeCDZ4I4gews
         /SVb3M4XBd+2JKQq/pfYOEtoj14brUH6W/3l3LOxkRmdCEtHm0XcgrDtKeMKEy6hi67r
         21K+qoM+RGOSXTyW5mAmMU9h7OAw6QIWyfUJP/bCNGgliFrsMcxuucWEjA59V03tAwwn
         g8eU/4pTTxYaRKN8ieH1hrNW7xomn5s21xB9+JpX9XBFkP8hUITBc50tlLuCDWlO98mk
         l6UPzUfgChNqg2SDhShCdhSl3KaLI0R9utIjBx5vR172k2tkZDdBDnFonoY6PKrdPjhi
         bbtA==
X-Gm-Message-State: AOJu0YzPv04drx4jR00rVFz507BbYIROZ1USHrrBb3gVVpJnXUzQmPEG
	9jAcicwVwCSYveBmlKrr1p/1JnsLGb1NNrjVMFe9I4Wwpa4oRyGxDcFNy2asU2aspoV7in+kQiA
	A+cDf8rte4qWzW4zAmwtD5pMhcEzkfHyx7Z6Ea7kC
X-Gm-Gg: ASbGncuq50bR21BBdQlqJh4jTWQyHkx7JvRhSzGD09/JhH2zcXRR+oXbMBUHtgj4yJk
	BDV4rehn0/G9P1L8LXTUpx3oNX8V8MY2doI6FOebHDwy274n5gWhv1k/8lmw/pCCao99XsMLFIH
	RUTDk/G0kDHXnMLCmVx3WBFGL3uIu9wuDhGKFPBODFkSmpI16jAiK2fN14/IKQhQR/Ux8cpHdlV
	RH2JJ4HFEQLUSCSk2VwS2oLoSXGgGXkhjk99ApFcvS+c72J4raaQT1On3jc
X-Google-Smtp-Source: AGHT+IHGijQbi+tomijPm2MPmULn9ARXU/qQz78D1sD7VMsvT34ubDiuy2yifmGOLfXxnQ5Nim7WUvnCt0/4MQKGGiQ=
X-Received: by 2002:a17:902:f549:b0:272:2bf1:6a21 with SMTP id
 d9443c01a7336-2951a3be7a3mr93762465ad.14.1762015829557; Sat, 01 Nov 2025
 09:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928030358.3873311-1-coxu@redhat.com> <20251031074016.1975356-1-coxu@redhat.com>
In-Reply-To: <20251031074016.1975356-1-coxu@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 1 Nov 2025 12:50:18 -0400
X-Gm-Features: AWmQ_bnZC2lmPA3q2pkaCD57BVH_NwJj88l6NgpYnQnpCwtni8T6GO_HiPsWKoo
Message-ID: <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook security_kernel_module_read_file
 to access decompressed kernel module
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 3:41=E2=80=AFAM Coiby Xu <coxu@redhat.com> wrote:
>
> Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
> is enabled, IMA has no way to verify the appended module signature as it
> can't decompress the module.
>
> Define a new LSM hook security_kernel_module_read_file which will be
> called after kernel module decompression is done so IMA can access the
> decompressed kernel module to verify the appended signature.
>
> Since IMA can access both xattr and appended kernel module signature
> with the new LSM hook, it no longer uses the security_kernel_post_read_fi=
le
> LSM hook for kernel module loading.
>
> Before enabling in-kernel module decompression, a kernel module in
> initramfs can still be loaded with ima_policy=3Dsecure_boot. So adjust th=
e
> kernel module rule in secure_boot policy to allow either an IMA
> signature OR an appended signature i.e. to use
> "appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig".
>
> Reported-by: Karel Srot <ksrot@redhat.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
> v1: https://lore.kernel.org/linux-integrity/20250928030358.3873311-1-coxu=
@redhat.com/
>
>  include/linux/lsm_hook_defs.h       |  2 ++
>  include/linux/security.h            |  7 +++++++
>  kernel/module/main.c                | 10 +++++++++-
>  security/integrity/ima/ima_main.c   | 26 ++++++++++++++++++++++++++
>  security/integrity/ima/ima_policy.c |  2 +-
>  security/security.c                 | 17 +++++++++++++++++
>  6 files changed, 62 insertions(+), 2 deletions(-)

We don't really need a new LSM hook for this do we?  Can't we just
define a new file read type, e.g.  READING_MODULE_DECOMPRESS, and do
another call to security_kernel_post_read_file() after the module is
unpacked?  Something like the snippet below ...

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..f127000d2e0a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3693,6 +3693,14 @@ static int init_module_from_file(struct file *f, con=
st ch
ar __user * uargs, int
                       mod_stat_add_long(len, &invalid_decompress_bytes);
                       return err;
               }
+
+               err =3D security_kernel_post_read_file(f,
+                                                    (char *)info.hdr, info=
.len,
+                                                    READING_MODULE_DECOMPR=
ESS);
+               if (err) {
+                       mod_stat_inc(&failed_kreads);
+                       return err;
+               }
       } else {
               info.hdr =3D buf;
               info.len =3D len;

--=20
paul-moore.com

