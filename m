Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D166471285
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jul 2019 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbfGWHPt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 03:15:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:33424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfGWHPs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 03:15:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F330AFA1;
        Tue, 23 Jul 2019 07:15:47 +0000 (UTC)
Date:   Tue, 23 Jul 2019 09:15:45 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v1] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Message-ID: <20190723071545.GA26973@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

others commented C code, thus I'll comment autotools checks.

> The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> application is required to read PCRs.
OT: anyone aware why TPM 2.0 does not expose PCR banks to userspace via sysfs?

> This patch adds tsspcrread support for reading the TPM 2.0 PCRs.
> tsspcrread is one application included in the ibmtss package.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> ---
> Changelog v1:
> - Based on Vitaly's review, test the popen "cmd"  return code.  Use
> pclose to determine if the result of the popen command succeeded or
> failed.  Removed the now unneeded checking for spaces.
> - Dynamically allocated the error msg and other changes based on
> Vitaly's review.
> - Based on Bruno's review, reverted the return code change.  At some
> point, we'll need to re-visit the return codes in general.

>  configure.ac    |  3 +++
>  src/Makefile.am |  3 +++
>  src/evmctl.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 50 insertions(+), 4 deletions(-)

> diff --git a/configure.ac b/configure.ac
> index 9beb4b6c2377..40fea93fef2f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -28,6 +28,8 @@ PKG_CHECK_MODULES(LIBCRYPTO, [libcrypto >= 0.9.8 ])
>  AC_SUBST(KERNEL_HEADERS)
>  AC_CHECK_HEADER(unistd.h)
>  AC_CHECK_HEADERS(openssl/conf.h)
> +AC_SEARCH_LIBS(TSS_Transmit, ibmtss, [have_ibmtss=yes], [have_ibmtss=no])
On some distros (at least openSUSE [1] and Debian [2], the library is called libtss.so
(which distro is calling it libibmtss.so?) therefore this should work for both:
AC_SEARCH_LIBS(TSS_Transmit, [ibmtss tss], [have_ibmtss=yes], [have_ibmtss=no])

> +AM_CONDITIONAL([CONFIG_IBMTSS], [test "x$have_ibmtss" = "xyes"])

>  AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found. You need the c-library development package.])])
>  AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not found. You need the libkeyutils development package.])])
> @@ -71,4 +73,5 @@ echo
>  echo	"Configuration:"
>  echo	"          debug: $pkg_cv_enable_debug"
>  echo	"   openssl-conf: $enable_openssl_conf"
> +echo	"         ibmtss: $have_ibmtss"
>  echo
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 9c037e21dc4f..f0990fb01210 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -21,6 +21,9 @@ evmctl_SOURCES = evmctl.c
>  evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
>  evmctl_LDFLAGS = $(LDFLAGS_READLINE)
>  evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
> +if CONFIG_IBMTSS
> +evmctl_CFLAGS = -DIBMTSS
> +endif
You can also use definition from config.h instead of passing it.

AC_SEARCH_LIBS(TSS_Transmit, [ibmtss tss],
	[have_ibmtss=yes
	AC_DEFINE(HAVE_IBMTSS, 1, [Define to 1 if you have libibmtss installed])],
	[have_ibmtss=no])

Then you don't need to pass -DIBMTSS, use HAVE_IBMTSS from config.h instead.

>  AM_CPPFLAGS = -I$(top_srcdir) -include config.h

> diff --git a/src/evmctl.c b/src/evmctl.c
> index 9e0926f10404..f726b2186678 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1383,10 +1383,8 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
>  	if (!fp)
>  		fp = fopen(misc_pcrs, "r");

> -	if (!fp) {
> -		log_err("Unable to open %s or %s\n", pcrs, misc_pcrs);
> +	if (!fp)
>  		return -1;
> -	}

>  	for (;;) {
>  		p = fgets(buf, sizeof(buf), fp);
> @@ -1402,6 +1400,32 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
>  	return result;
>  }

> +#ifdef IBMTSS
> +static int tpm_pcr_read2(int idx, uint8_t *hwpcr, int len, char **errmsg)
> +{
> +	FILE *fp;
> +	char pcr[100];	/* may contain an error */
> +	char cmd[36];
> +	int ret;
> +
> +	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns", idx);

Did I get it right, that in the end we don't use libibmtss, but tsspcrread.
So wouldn't be safer to detect it with AC_CHECK_PROGS macro?
See proposed diff.

> +	fp = popen(cmd, "r");
> +	if (!fp)
> +		return -1;
> +
> +	fgets(pcr, sizeof(pcr), fp);
> +
> +	/* get the popen "cmd" return code */
> +	ret = pclose(fp);
> +	if (!ret)
> +		hex2bin(hwpcr, pcr, SHA_DIGEST_LENGTH);
> +	else
> +		*errmsg = strdup(pcr);
> +
> +	return ret;
> +}
> +#endif
> +
>  #define TCG_EVENT_NAME_LEN_MAX	255

>  struct template_entry {
> @@ -1658,8 +1682,24 @@ static int ima_measurement(const char *file)
>  		log_info("PCRAgg %.2d: ", i);
>  		log_dump(pcr[i], SHA_DIGEST_LENGTH);

> -		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr)))
> +		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
> +#ifdef IBMTSS
> +			char *errmsg = NULL;
> +
> +			err = tpm_pcr_read2(i, hwpcr, sizeof(hwpcr), &errmsg);
> +			if (err) {
> +				errmsg[strlen(errmsg) - 1] = 0;
> +
> +				log_info("Failed to read either TPM 1.2 or TPM 2.0 PCRs.\n (%s)\n", errmsg);
> +				free(errmsg);
> +				exit(1);
> +			}
> +#else
> +			log_info("Failed to read TPM 1.2 PCRs.\n");
>  			exit(1);
> +#endif
> +		}
> +
>  		log_info("HW PCR-%d: ", i);
>  		log_dump(hwpcr, sizeof(hwpcr));

[1] https://packages.debian.org/sid/amd64/libtss0/filelist
[2] https://build.opensuse.org/package/view_file/security/tss2/tss2.spec?expand=1


Kind regards,
Petr

Proposed diff:

diff --git configure.ac configure.ac
index 40fea93..09b111c 100644
--- configure.ac
+++ configure.ac
@@ -28,8 +28,11 @@ PKG_CHECK_MODULES(LIBCRYPTO, [libcrypto >= 0.9.8 ])
 AC_SUBST(KERNEL_HEADERS)
 AC_CHECK_HEADER(unistd.h)
 AC_CHECK_HEADERS(openssl/conf.h)
-AC_SEARCH_LIBS(TSS_Transmit, ibmtss, [have_ibmtss=yes], [have_ibmtss=no])
-AM_CONDITIONAL([CONFIG_IBMTSS], [test "x$have_ibmtss" = "xyes"])
+
+AC_CHECK_PROG(TSSPCRREAD, [tsspcrread], yes, no)
+if test "x$TSSPCRREAD" = "xyes"; then
+	AC_DEFINE(HAVE_TSSPCRREAD, 1, [Define to 1 if you have tsspcrread binary installed])],
+fi
 
 AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found. You need the c-library development package.])])
 AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not found. You need the libkeyutils development package.])])
@@ -73,5 +76,5 @@ echo
 echo	"Configuration:"
 echo	"          debug: $pkg_cv_enable_debug"
 echo	"   openssl-conf: $enable_openssl_conf"
-echo	"         ibmtss: $have_ibmtss"
+echo	"     tsspcrread: $TSSPCRREAD"
 echo
diff --git src/Makefile.am src/Makefile.am
index f0990fb..9c037e2 100644
--- src/Makefile.am
+++ src/Makefile.am
@@ -21,9 +21,6 @@ evmctl_SOURCES = evmctl.c
 evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 evmctl_LDFLAGS = $(LDFLAGS_READLINE)
 evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
-if CONFIG_IBMTSS
-evmctl_CFLAGS = -DIBMTSS
-endif
 
 AM_CPPFLAGS = -I$(top_srcdir) -include config.h
 
diff --git src/evmctl.c src/evmctl.c
index f726b21..f5268ac 100644
--- src/evmctl.c
+++ src/evmctl.c
@@ -1400,7 +1400,7 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 	return result;
 }
 
-#ifdef IBMTSS
+#ifdef HAVE_TSSPCRREAD
 static int tpm_pcr_read2(int idx, uint8_t *hwpcr, int len, char **errmsg)
 {
 	FILE *fp;
@@ -1683,7 +1683,7 @@ static int ima_measurement(const char *file)
 		log_dump(pcr[i], SHA_DIGEST_LENGTH);
 
 		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
-#ifdef IBMTSS
+#ifdef HAVE_TSSPCRREAD
 			char *errmsg = NULL;
 
 			err = tpm_pcr_read2(i, hwpcr, sizeof(hwpcr), &errmsg);
