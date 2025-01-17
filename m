Return-Path: <linux-integrity+bounces-4583-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51706A1531A
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 16:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBEB188A314
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE39F194A75;
	Fri, 17 Jan 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WRF3I0hI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C818A6A7
	for <linux-integrity@vger.kernel.org>; Fri, 17 Jan 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128842; cv=none; b=plKlJds1JZczKlIq2U+uWBj5bu1goePVMp/C7Cw82DSlSi5UzSc5YatP3OQ+KxNlL9rQdXhexySL+WVwkQOaUA0woSwN+kDBpyqjNtsdPTZ/ptij1pFsiID496lAbgqUxliTzGkQfgXwex4pdowbiwj/9sc8Krhu1T/zXZLs2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128842; c=relaxed/simple;
	bh=FXtv7W1tTZCZwvKzdYCQy615fK4f84nKg0ubPToRYrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlhGj1XILKw710FpJ/I7LAPjjfEcvJ5eWAaiokRfyA+I+48vOSLn0a3rOO1fsQhFvwWdqsJHzxHpBUKcRcWa5tS75M+oVhQ2DSh34KEHYFKz7iJV4T0bfl/Aj5HJtG5HRQkxLtssyg4YjpStfzZgAGV5qgr/FcCN+6EadmJi1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WRF3I0hI; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YZPHd169Bz14PS;
	Fri, 17 Jan 2025 16:47:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1737128829;
	bh=aCV8+joJ0WwwhpBHcz/sG6l6fT4xHQJOZ3/s67DE/1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRF3I0hI9hSvp3sVkvQtKce72h7ota3phhhEv0vDzZ0nf9lnYZH/M0Xl5UtyGIG0z
	 FtXVy7jQFT/v1LEHUS4zMbFachXwX1YK0KEDUOQNdZc3Zhc3f4yvVmxf+osvox/QfF
	 358v1GFRlNKEvwFS8suJPUx31gE2r8NTTzaczT2E=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YZPHZ4gw3z6Rm;
	Fri, 17 Jan 2025 16:47:06 +0100 (CET)
Date: Fri, 17 Jan 2025 16:47:05 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jeff Xu <jeffxu@chromium.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Paul Moore <paul@paul-moore.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Serge Hallyn <serge@hallyn.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] selftests: Handle old glibc without execveat(2)
Message-ID: <20250117.aiy2ooph6Lee@digikod.net>
References: <20250115144753.311152-1-mic@digikod.net>
 <20250117.062883f45a7d@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117.062883f45a7d@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Jan 17, 2025 at 03:42:22PM +0100, Günther Noack wrote:
> On Wed, Jan 15, 2025 at 03:47:50PM +0100, Mickaël Salaün wrote:
> > Add an execveat(2) wrapper because glibc < 2.34 does not have one.  This
> > fixes the check-exec tests and samples.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Jeff Xu <jeffxu@chromium.org>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Cc: Stefan Berger <stefanb@linux.ibm.com>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://lore.kernel.org/r/20250114205645.GA2825031@ax162
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> > 
> > Based on Kees Cook's next/execve branch.
> > ---
> >  samples/check-exec/inc.c                   | 11 +++++++++--
> >  tools/testing/selftests/exec/check-exec.c  | 11 +++++++++--
> >  tools/testing/selftests/landlock/fs_test.c | 10 ++++++++--
> >  3 files changed, 26 insertions(+), 6 deletions(-)
> > 
> > diff --git a/samples/check-exec/inc.c b/samples/check-exec/inc.c
> > index 94b87569d2a2..7f6ef06a2f06 100644
> > --- a/samples/check-exec/inc.c
> > +++ b/samples/check-exec/inc.c
> > @@ -21,8 +21,15 @@
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <sys/prctl.h>
> > +#include <sys/syscall.h>
> >  #include <unistd.h>
> >  
> > +static int sys_execveat(int dirfd, const char *pathname, char *const argv[],
> > +			char *const envp[], int flags)
> > +{
> > +	return syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
> > +}
> > +
> >  /* Returns 1 on error, 0 otherwise. */
> >  static int interpret_buffer(char *buffer, size_t buffer_size)
> >  {
> > @@ -78,8 +85,8 @@ static int interpret_stream(FILE *script, char *const script_name,
> >  	 * script execution.  We must use the script file descriptor instead of
> >  	 * the script path name to avoid race conditions.
> >  	 */
> > -	err = execveat(fileno(script), "", script_argv, envp,
> > -		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
> > +	err = sys_execveat(fileno(script), "", script_argv, envp,
> > +			   AT_EMPTY_PATH | AT_EXECVE_CHECK);
> >  	if (err && restrict_stream) {
> >  		perror("ERROR: Script execution check");
> >  		return 1;
> > diff --git a/tools/testing/selftests/exec/check-exec.c b/tools/testing/selftests/exec/check-exec.c
> > index 4d3f4525e1e1..55bce47e56b7 100644
> > --- a/tools/testing/selftests/exec/check-exec.c
> > +++ b/tools/testing/selftests/exec/check-exec.c
> > @@ -22,6 +22,7 @@
> >  #include <sys/prctl.h>
> >  #include <sys/socket.h>
> >  #include <sys/stat.h>
> > +#include <sys/syscall.h>
> >  #include <sys/sysmacros.h>
> >  #include <unistd.h>
> >  
> > @@ -31,6 +32,12 @@
> >  
> >  #include "../kselftest_harness.h"
> >  
> > +static int sys_execveat(int dirfd, const char *pathname, char *const argv[],
> > +			char *const envp[], int flags)
> > +{
> > +	return syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
> > +}
> > +
> >  static void drop_privileges(struct __test_metadata *const _metadata)
> >  {
> >  	const unsigned int noroot = SECBIT_NOROOT | SECBIT_NOROOT_LOCKED;
> > @@ -219,8 +226,8 @@ static void test_exec_fd(struct __test_metadata *_metadata, const int fd,
> >  	 * test framework as an error.  With AT_EXECVE_CHECK, we only check a
> >  	 * potential successful execution.
> >  	 */
> > -	access_ret =
> > -		execveat(fd, "", argv, NULL, AT_EMPTY_PATH | AT_EXECVE_CHECK);
> > +	access_ret = sys_execveat(fd, "", argv, NULL,
> > +				  AT_EMPTY_PATH | AT_EXECVE_CHECK);
> >  	access_errno = errno;
> >  	if (err_code) {
> >  		EXPECT_EQ(-1, access_ret);
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index cd66901be612..ac9701c018e0 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -59,6 +59,12 @@ int open_tree(int dfd, const char *filename, unsigned int flags)
> >  }
> >  #endif
> >  
> > +static int sys_execveat(int dirfd, const char *pathname, char *const argv[],
> > +			char *const envp[], int flags)
> > +{
> > +	return syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
> > +}
> > +
> >  #ifndef RENAME_EXCHANGE
> >  #define RENAME_EXCHANGE (1 << 1)
> >  #endif
> > @@ -2018,8 +2024,8 @@ static void test_check_exec(struct __test_metadata *const _metadata,
> >  	int ret;
> >  	char *const argv[] = { (char *)path, NULL };
> >  
> > -	ret = execveat(AT_FDCWD, path, argv, NULL,
> > -		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
> > +	ret = sys_execveat(AT_FDCWD, path, argv, NULL,
> > +			   AT_EMPTY_PATH | AT_EXECVE_CHECK);
> >  	if (err) {
> >  		EXPECT_EQ(-1, ret);
> >  		EXPECT_EQ(errno, err);
> > 
> > base-commit: 95b3cdafd7cb74414070893445a9b731793f7b55
> > -- 
> > 2.48.1
> > 
> 
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> 
> Do you want to add a comment next to these, to remind ourselves do undo this?
> You are surely not planning to support old versions of glibc indefinitely?

I don't about glibc.  Minimal versions for other tools are documented
here though:
https://docs.kernel.org/process/changes.html

Nathan, Jon, any idea?

