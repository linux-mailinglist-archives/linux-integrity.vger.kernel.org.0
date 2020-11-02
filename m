Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247582A2A7D
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Nov 2020 13:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgKBMQt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Nov 2020 07:16:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:28865 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbgKBMQt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Nov 2020 07:16:49 -0500
IronPort-SDR: o0aHOT3rPfclYcOXhsalnykM8+A1FQUIMiiE4ukVkYQXjUZiQ0iArDK3cGnC/FiM5MPHXavl/0
 bPx3Vh0JH8kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="168972646"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="168972646"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 04:16:48 -0800
IronPort-SDR: bM3ptaXzkv/iFqswyOPD70Rz4tqdTi+PMKIg5vi40sI67LQ4/qPXSa60A2xRHnj27/iaPcCfRE
 o0NPBu98S4NQ==
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="305420857"
Received: from jpanina-mobl2.ger.corp.intel.com (HELO linux.intel.com) ([10.252.49.91])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 04:16:42 -0800
Date:   Mon, 2 Nov 2020 14:16:37 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, ross.philipson@oracle.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [RFC PATCH 3/4] tpm: Conditionally use static buffer in TPM
 buffer management
Message-ID: <20201102121637.GB5242@linux.intel.com>
References: <20201031165122.21539-1-dpsmith@apertussolutions.com>
 <20201031165122.21539-4-dpsmith@apertussolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031165122.21539-4-dpsmith@apertussolutions.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Oct 31, 2020 at 12:51:21PM -0400, Daniel P. Smith wrote:
> Memory management calls cannot be made in the compressed kernel
> environment to dynamically allocate TPM buffer space. For the Secure
> Launch early PCR extend code, use a static buffer instead.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---

This patch is not necessary.

Just assign tb->data to the static buffer where you use the static
buffer and use tpm_buf_reset().

tpm_buf_init() and tpm_buf_destroy() are optional.

/Jarkko

>  include/linux/tpm_buffer.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/tpm_buffer.h b/include/linux/tpm_buffer.h
> index 8144a52fbc0a..c9482edf6618 100644
> --- a/include/linux/tpm_buffer.h
> +++ b/include/linux/tpm_buffer.h
> @@ -18,6 +18,10 @@
>  #ifndef __LINUX_TPM_BUFFER_H__
>  #define __LINUX_TPM_BUFFER_H__
>  
> +#ifdef COMPRESSED_KERNEL
> +static u8 _tpm_buffer[PAGE_SIZE] = {0};
> +#endif
> +
>  struct tpm_header {
>  	__be16 tag;
>  	__be32 length;
> @@ -52,7 +56,11 @@ static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  
>  static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  {
> +#ifdef COMPRESSED_KERNEL
> +	buf->data = _tpm_buffer;
> +#else
>  	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> +#endif
>  	if (!buf->data)
>  		return -ENOMEM;
>  
> @@ -63,7 +71,9 @@ static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  
>  static inline void tpm_buf_destroy(struct tpm_buf *buf)
>  {
> +#ifndef COMPRESSED_KERNEL
>  	free_page((unsigned long)buf->data);
> +#endif
>  }
>  
>  static inline u32 tpm_buf_length(struct tpm_buf *buf)
> @@ -92,7 +102,9 @@ static inline void tpm_buf_append(struct tpm_buf *buf,
>  		return;
>  
>  	if ((len + new_len) > PAGE_SIZE) {
> +#ifndef COMPRESSED_KERNEL
>  		WARN(1, "tpm_buf: overflow\n");
> +#endif
>  		buf->flags |= TPM_BUF_OVERFLOW;
>  		return;
>  	}
> -- 
> 2.11.0
> 

/Jarkko
