Return-Path: <linux-integrity+bounces-4582-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD0CA15208
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 15:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CD1169759
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B11814B06C;
	Fri, 17 Jan 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEb4H/84"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987015B54A;
	Fri, 17 Jan 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124951; cv=none; b=enFSx8wgZl5ROZaEHLF2OS/7lgWKKp+FITjcsx8LD33FNr4aNI6VRpSujs2ULdYUxPOsZQqSZAW38CkeCp2PYxoA7qaAIc4NDZE8Y1EYF8VLAAZTGqRgfMWmoVN8wKtL5CUp3DmjaSCkai/b8KJ5zZ8IHXS0hcNrkO4oYvHbB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124951; c=relaxed/simple;
	bh=FFsSB34E0ao8K38FLpNRRuWEXihZouOMwO0eIPDcqLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiQZ7fuv6T1UNPdCWjWi0EwE3qrfpHz4amnDcv+8+EGY//arJ703jxF73jgWQJ3Q8u7qaweAV9P2+dWHZ1FKN/n4ueIlo2nVCUTQ8sC+VY4b1JOkKJYYuHDnGYsugOQF6vTgmfTWu8XN3o0fD6UNlfCH1EmvfElbR/LexiNE5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEb4H/84; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaec111762bso427378266b.2;
        Fri, 17 Jan 2025 06:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737124948; x=1737729748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nOD4pNV3mPT1I1Ya6badU5VbEXfW6f5YfORqdQrB6KU=;
        b=KEb4H/84eZLhjx0b99NpwrroPTTTnOVfs0Mf/mJqhUGK4nB5UxxTcz9lhLLchnqE/D
         GoCp8Y//8TBGH4NNw/gcaigWRhHOTI6bnyipd0G8REYo+pLcxY0+5SDMwKSIJMI7SHZq
         HhuwTxs7RGhWAQd8xUrPcJ1gDnr3nDCq6xs6I8mqyLoODfgGz2J+kA1NiUPl2rh+jLVw
         KeK1jCFUFsu0F7/wyWdBcm3R5ZRytLln0M37sOoZMBPMrs9ouDCmeNi7gPf9erimDfQj
         QpKO2tn/uBLB7gL+rtoDIiz+orb11TZC6LIVrqX3n6IPi6jbaVcMEdyDEZDir7yRMIbP
         0Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737124948; x=1737729748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOD4pNV3mPT1I1Ya6badU5VbEXfW6f5YfORqdQrB6KU=;
        b=KQksJWCbmvHKsk5gZYJxFOaxKxYdVjXI/YJP1mYb3O2xLqKt/3b4y3th48CXwytTd5
         l1E159AL8S0du5FLjP2LjX5s5I7xoFItJVhQzSF3jiAQtj+XKOkhVQP6quzRHpX3BASe
         +8OfaJQ6nSYZahxZ63EM8HjZyaFfxHRICdJ0040DI6iYaeMqNYWbSvRH6PltMfFZEq5T
         nWPP4AbIqIIqLk1yI2y+fvaOKD9eutfyll6ZNpMPIkSlRmOUXJXoQlcVjs4L5SlmfUhH
         uC3HXVOVnbJuRkyYB1IHutJ2rzy2wXBwric5Hov0aTgKJHYWEU+1WN5zL8aM9rtgiERZ
         r4UA==
X-Forwarded-Encrypted: i=1; AJvYcCVW76geyWqjM+ObjLZQkmlFw2jdV7dpOkX2KIYSt/+YLxzaNgYlWjNcOfvbEA86DuiNQkbWBMgAnS8KL/qNsCGQ/z0jGWC7@vger.kernel.org, AJvYcCVvieaAeHEqM+1mcWhBOb8Aot5XblMiIsCcYbrYGZumU5VikvQ1+o8uPUFIgBbK80J61QXsy9svsUm6I3fn@vger.kernel.org, AJvYcCWdH625ik0BVlBX48hckyj2XPGwmduCth9/QmnG91eK5qOZxsB4gJ+eutF4WAcrS+AHttxvXSr3I57tuL5AbTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyti1WlLRZBWDQhpz4OQm6VL1qlPeX3DqLy1hmL5xKh/FpqToFh
	5pG4Zdf3aIlyPnzPEb2sx3xRsj4yrYwUMz8LHzaR2Qp93tA9mZ9152PNlw==
X-Gm-Gg: ASbGnctLDyMPPFZEnsD/CohCVf7Pcv4dBMwIZHB0D/IfbblqO6uPxrCVUkxvd1iv/PZ
	LTRJZEyASxcAJhWbC+bYXG45e/EEAmV40p7u4A2tHV0/3efcmwcK/uEce8xWAC1WELG8RDnUmc0
	ykOaUA4GYJxv6jQYSxm/CqJByWZGPBl85AvQIY3Bgcz6jhDH4piDVWjAOFMSeGlZw71FC9gu6vo
	nxAncCxFKdnxdTv6aXDVnU4idPAmjvnmxRMUjKzkDtEt2IgkO2wKD0F1w==
X-Google-Smtp-Source: AGHT+IGBQ1aAJFrMiRvnQwh32HdjT5afCCpZlBxjV6nktWYkixeKaeSQfoiwlLenrF4Ok9ZEbakrCQ==
X-Received: by 2002:a17:907:6d1d:b0:aae:c9bf:41b3 with SMTP id a640c23a62f3a-ab38b36bd3amr307044366b.37.1737124947322;
        Fri, 17 Jan 2025 06:42:27 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:a201:48ff:95d2:7dab:ae81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f22c5fsm180915166b.93.2025.01.17.06.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:42:26 -0800 (PST)
Date: Fri, 17 Jan 2025 15:42:22 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jeff Xu <jeffxu@chromium.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Serge Hallyn <serge@hallyn.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1] selftests: Handle old glibc without execveat(2)
Message-ID: <20250117.062883f45a7d@gnoack.org>
References: <20250115144753.311152-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115144753.311152-1-mic@digikod.net>

On Wed, Jan 15, 2025 at 03:47:50PM +0100, Mickaël Salaün wrote:
> Add an execveat(2) wrapper because glibc < 2.34 does not have one.  This
> fixes the check-exec tests and samples.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jeff Xu <jeffxu@chromium.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/r/20250114205645.GA2825031@ax162
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Based on Kees Cook's next/execve branch.
> ---
>  samples/check-exec/inc.c                   | 11 +++++++++--
>  tools/testing/selftests/exec/check-exec.c  | 11 +++++++++--
>  tools/testing/selftests/landlock/fs_test.c | 10 ++++++++--
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/samples/check-exec/inc.c b/samples/check-exec/inc.c
> index 94b87569d2a2..7f6ef06a2f06 100644
> --- a/samples/check-exec/inc.c
> +++ b/samples/check-exec/inc.c
> @@ -21,8 +21,15 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/prctl.h>
> +#include <sys/syscall.h>
>  #include <unistd.h>
>  
> +static int sys_execveat(int dirfd, const char *pathname, char *const argv[],
> +			char *const envp[], int flags)
> +{
> +	return syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
> +}
> +
>  /* Returns 1 on error, 0 otherwise. */
>  static int interpret_buffer(char *buffer, size_t buffer_size)
>  {
> @@ -78,8 +85,8 @@ static int interpret_stream(FILE *script, char *const script_name,
>  	 * script execution.  We must use the script file descriptor instead of
>  	 * the script path name to avoid race conditions.
>  	 */
> -	err = execveat(fileno(script), "", script_argv, envp,
> -		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
> +	err = sys_execveat(fileno(script), "", script_argv, envp,
> +			   AT_EMPTY_PATH | AT_EXECVE_CHECK);
>  	if (err && restrict_stream) {
>  		perror("ERROR: Script execution check");
>  		return 1;
> diff --git a/tools/testing/selftests/exec/check-exec.c b/tools/testing/selftests/exec/check-exec.c
> index 4d3f4525e1e1..55bce47e56b7 100644
> --- a/tools/testing/selftests/exec/check-exec.c
> +++ b/tools/testing/selftests/exec/check-exec.c
> @@ -22,6 +22,7 @@
>  #include <sys/prctl.h>
>  #include <sys/socket.h>
>  #include <sys/stat.h>
> +#include <sys/syscall.h>
>  #include <sys/sysmacros.h>
>  #include <unistd.h>
>  
> @@ -31,6 +32,12 @@
>  
>  #include "../kselftest_harness.h"
>  
> +static int sys_execveat(int dirfd, const char *pathname, char *const argv[],
> +			char *const envp[], int flags)
> +{
> +	return syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
> +}
> +
>  static void drop_privileges(struct __test_metadata *const _metadata)
>  {
>  	const unsigned int noroot = SECBIT_NOROOT | SECBIT_NOROOT_LOCKED;
> @@ -219,8 +226,8 @@ static void test_exec_fd(struct __test_metadata *_metadata, const int fd,
>  	 * test framework as an error.  With AT_EXECVE_CHECK, we only check a
>  	 * potential successful execution.
>  	 */
> -	access_ret =
> -		execveat(fd, "", argv, NULL, AT_EMPTY_PATH | AT_EXECVE_CHECK);
> +	access_ret = sys_execveat(fd, "", argv, NULL,
> +				  AT_EMPTY_PATH | AT_EXECVE_CHECK);
>  	access_errno = errno;
>  	if (err_code) {
>  		EXPECT_EQ(-1, access_ret);
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index cd66901be612..ac9701c018e0 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -59,6 +59,12 @@ int open_tree(int dfd, const char *filename, unsigned int flags)
>  }
>  #endif
>  
> +static int sys_execveat(int dirfd, const char *pathname, char *const argv[],
> +			char *const envp[], int flags)
> +{
> +	return syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
> +}
> +
>  #ifndef RENAME_EXCHANGE
>  #define RENAME_EXCHANGE (1 << 1)
>  #endif
> @@ -2018,8 +2024,8 @@ static void test_check_exec(struct __test_metadata *const _metadata,
>  	int ret;
>  	char *const argv[] = { (char *)path, NULL };
>  
> -	ret = execveat(AT_FDCWD, path, argv, NULL,
> -		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
> +	ret = sys_execveat(AT_FDCWD, path, argv, NULL,
> +			   AT_EMPTY_PATH | AT_EXECVE_CHECK);
>  	if (err) {
>  		EXPECT_EQ(-1, ret);
>  		EXPECT_EQ(errno, err);
> 
> base-commit: 95b3cdafd7cb74414070893445a9b731793f7b55
> -- 
> 2.48.1
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Do you want to add a comment next to these, to remind ourselves do undo this?
You are surely not planning to support old versions of glibc indefinitely?

–Günther

