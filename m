Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3912A2A6A
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Nov 2020 13:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgKBMJk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Nov 2020 07:09:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:8190 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgKBMJk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Nov 2020 07:09:40 -0500
IronPort-SDR: kdy48+VeDpMevnTqFddDIRQh6KioxoSJP21fQGZ/9I9VDWIGuuGPBwUw2ECTmuV8F/pbOvV84e
 J6uXfPFQ2I5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="168089537"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="168089537"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 04:09:39 -0800
IronPort-SDR: W8nVvBwfhDOTemmDw8FzujY6PXTyTN4xyEcqdM7GL16fqYt7JvzNeGX8usylm3BmYrvRbwmqBV
 6kqLX1Zd2HZA==
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="537996359"
Received: from jpanina-mobl2.ger.corp.intel.com (HELO linux.intel.com) ([10.252.49.91])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 04:09:32 -0800
Date:   Mon, 2 Nov 2020 14:09:27 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, ross.philipson@oracle.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [RFC PATCH 2/4] tpm: Move core definitions and buffer management
 out of main TPM header
Message-ID: <20201102120927.GA5242@linux.intel.com>
References: <20201031165122.21539-1-dpsmith@apertussolutions.com>
 <20201031165122.21539-3-dpsmith@apertussolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031165122.21539-3-dpsmith@apertussolutions.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Oct 31, 2020 at 12:51:20PM -0400, Daniel P. Smith wrote:
> Move core definitions from include/linux/tpm.h to new file
> include/linux/tpm_core.h. Move buffer management code from
> include/linux/tpm.h to new file include/linux/tpm_buffer.h.
> 
> This allows tpm_tis_defs.h to be included in the Secure Launch early PCR
> extend module. The rest of tpm.h cannot be included in the compressed
> kernel environment.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Should be split into two patches. I would order them so that definitions
are moved in the first patch and tpm_buf in the second. Then it is
easier to review the changes as other tpm_buf changes follow in the
subsequent patch.

> ---
>  include/linux/tpm.h        | 269 +--------------------------------------------
>  include/linux/tpm_buffer.h | 123 +++++++++++++++++++++

The filename should be tpm_buf.h (aligns with the struct name).

>  include/linux/tpm_core.h   | 185 +++++++++++++++++++++++++++++++

Dump these into tpm_command.h, which already has constants for TPM 1.2
trusted keys, instead of adding a new file.

>  3 files changed, 310 insertions(+), 267 deletions(-)
>  create mode 100644 include/linux/tpm_buffer.h
>  create mode 100644 include/linux/tpm_core.h
> 
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 8f4ff39f51e7..a8e3a19caa98 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -23,40 +23,13 @@
>  #include <linux/fs.h>
>  #include <linux/highmem.h>
>  #include <crypto/hash_info.h>
> -
> -#define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> -#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
> +#include <linux/tpm_buffer.h>
> +#include <linux/tpm_core.h>
>  
>  struct tpm_chip;
>  struct trusted_key_payload;
>  struct trusted_key_options;
>  
> -enum tpm_algorithms {
> -	TPM_ALG_ERROR		= 0x0000,
> -	TPM_ALG_SHA1		= 0x0004,
> -	TPM_ALG_KEYEDHASH	= 0x0008,
> -	TPM_ALG_SHA256		= 0x000B,
> -	TPM_ALG_SHA384		= 0x000C,
> -	TPM_ALG_SHA512		= 0x000D,
> -	TPM_ALG_NULL		= 0x0010,
> -	TPM_ALG_SM3_256		= 0x0012,
> -};
> -
> -struct tpm_digest {
> -	u16 alg_id;
> -	u8 digest[TPM_MAX_DIGEST_SIZE];
> -} __packed;
> -
> -struct tpm_bank_info {
> -	u16 alg_id;
> -	u16 digest_size;
> -	u16 crypto_id;
> -};
> -
> -enum TPM_OPS_FLAGS {
> -	TPM_OPS_AUTO_STARTUP = BIT(0),
> -};
> -
>  struct tpm_class_ops {
>  	unsigned int flags;
>  	const u8 req_complete_mask;
> @@ -79,26 +52,6 @@ struct tpm_class_ops {
>  
>  #define TPM_NUM_EVENT_LOG_FILES		3
>  
> -/* Indexes the duration array */
> -enum tpm_duration {
> -	TPM_SHORT = 0,
> -	TPM_MEDIUM = 1,
> -	TPM_LONG = 2,
> -	TPM_LONG_LONG = 3,
> -	TPM_UNDEFINED,
> -	TPM_NUM_DURATIONS = TPM_UNDEFINED,
> -};
> -
> -#define TPM_PPI_VERSION_LEN		3
> -
> -struct tpm_space {
> -	u32 context_tbl[3];
> -	u8 *context_buf;
> -	u32 session_tbl[3];
> -	u8 *session_buf;
> -	u32 buf_size;
> -};
> -
>  struct tpm_bios_log {
>  	void *bios_event_log;
>  	void *bios_event_log_end;
> @@ -165,104 +118,6 @@ struct tpm_chip {
>  	int locality;
>  };
>  
> -#define TPM_HEADER_SIZE		10
> -
> -enum tpm2_const {
> -	TPM2_PLATFORM_PCR       =     24,
> -	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
> -};
> -
> -enum tpm2_timeouts {
> -	TPM2_TIMEOUT_A          =    750,
> -	TPM2_TIMEOUT_B          =   2000,
> -	TPM2_TIMEOUT_C          =    200,
> -	TPM2_TIMEOUT_D          =     30,
> -	TPM2_DURATION_SHORT     =     20,
> -	TPM2_DURATION_MEDIUM    =    750,
> -	TPM2_DURATION_LONG      =   2000,
> -	TPM2_DURATION_LONG_LONG = 300000,
> -	TPM2_DURATION_DEFAULT   = 120000,
> -};
> -
> -enum tpm2_structures {
> -	TPM2_ST_NO_SESSIONS	= 0x8001,
> -	TPM2_ST_SESSIONS	= 0x8002,
> -};
> -
> -/* Indicates from what layer of the software stack the error comes from */
> -#define TSS2_RC_LAYER_SHIFT	 16
> -#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
> -
> -enum tpm2_return_codes {
> -	TPM2_RC_SUCCESS		= 0x0000,
> -	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
> -	TPM2_RC_HANDLE		= 0x008B,
> -	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
> -	TPM2_RC_FAILURE		= 0x0101,
> -	TPM2_RC_DISABLED	= 0x0120,
> -	TPM2_RC_COMMAND_CODE    = 0x0143,
> -	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
> -	TPM2_RC_REFERENCE_H0	= 0x0910,
> -	TPM2_RC_RETRY		= 0x0922,
> -};
> -
> -enum tpm2_command_codes {
> -	TPM2_CC_FIRST		        = 0x011F,
> -	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
> -	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
> -	TPM2_CC_CREATE_PRIMARY          = 0x0131,
> -	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
> -	TPM2_CC_SELF_TEST	        = 0x0143,
> -	TPM2_CC_STARTUP		        = 0x0144,
> -	TPM2_CC_SHUTDOWN	        = 0x0145,
> -	TPM2_CC_NV_READ                 = 0x014E,
> -	TPM2_CC_CREATE		        = 0x0153,
> -	TPM2_CC_LOAD		        = 0x0157,
> -	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
> -	TPM2_CC_UNSEAL		        = 0x015E,
> -	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
> -	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
> -	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
> -	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
> -	TPM2_CC_GET_CAPABILITY	        = 0x017A,
> -	TPM2_CC_GET_RANDOM	        = 0x017B,
> -	TPM2_CC_PCR_READ	        = 0x017E,
> -	TPM2_CC_PCR_EXTEND	        = 0x0182,
> -	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
> -	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
> -	TPM2_CC_CREATE_LOADED           = 0x0191,
> -	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
> -};
> -
> -enum tpm2_permanent_handles {
> -	TPM2_RS_PW		= 0x40000009,
> -};
> -
> -enum tpm2_capabilities {
> -	TPM2_CAP_HANDLES	= 1,
> -	TPM2_CAP_COMMANDS	= 2,
> -	TPM2_CAP_PCRS		= 5,
> -	TPM2_CAP_TPM_PROPERTIES = 6,
> -};
> -
> -enum tpm2_properties {
> -	TPM_PT_TOTAL_COMMANDS	= 0x0129,
> -};
> -
> -enum tpm2_startup_types {
> -	TPM2_SU_CLEAR	= 0x0000,
> -	TPM2_SU_STATE	= 0x0001,
> -};
> -
> -enum tpm2_cc_attrs {
> -	TPM2_CC_ATTR_CHANDLES	= 25,
> -	TPM2_CC_ATTR_RHANDLE	= 28,
> -};
> -
> -#define TPM_VID_INTEL    0x8086
> -#define TPM_VID_WINBOND  0x1050
> -#define TPM_VID_STM      0x104A
> -
>  enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_TPM2		= BIT(1),
>  	TPM_CHIP_FLAG_IRQ		= BIT(2),
> @@ -274,126 +129,6 @@ enum tpm_chip_flags {
>  
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
>  
> -struct tpm_header {
> -	__be16 tag;
> -	__be32 length;
> -	union {
> -		__be32 ordinal;
> -		__be32 return_code;
> -	};
> -} __packed;
> -
> -/* A string buffer type for constructing TPM commands. This is based on the
> - * ideas of string buffer code in security/keys/trusted.h but is heap based
> - * in order to keep the stack usage minimal.
> - */
> -
> -enum tpm_buf_flags {
> -	TPM_BUF_OVERFLOW	= BIT(0),
> -};
> -
> -struct tpm_buf {
> -	unsigned int flags;
> -	u8 *data;
> -};
> -
> -enum tpm2_object_attributes {
> -	TPM2_OA_USER_WITH_AUTH		= BIT(6),
> -};
> -
> -enum tpm2_session_attributes {
> -	TPM2_SA_CONTINUE_SESSION	= BIT(0),
> -};
> -
> -struct tpm2_hash {
> -	unsigned int crypto_id;
> -	unsigned int tpm_id;
> -};
> -
> -static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> -{
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -
> -	head->tag = cpu_to_be16(tag);
> -	head->length = cpu_to_be32(sizeof(*head));
> -	head->ordinal = cpu_to_be32(ordinal);
> -}
> -
> -static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> -{
> -	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> -	if (!buf->data)
> -		return -ENOMEM;
> -
> -	buf->flags = 0;
> -	tpm_buf_reset(buf, tag, ordinal);
> -	return 0;
> -}
> -
> -static inline void tpm_buf_destroy(struct tpm_buf *buf)
> -{
> -	free_page((unsigned long)buf->data);
> -}
> -
> -static inline u32 tpm_buf_length(struct tpm_buf *buf)
> -{
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -
> -	return be32_to_cpu(head->length);
> -}
> -
> -static inline u16 tpm_buf_tag(struct tpm_buf *buf)
> -{
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -
> -	return be16_to_cpu(head->tag);
> -}
> -
> -static inline void tpm_buf_append(struct tpm_buf *buf,
> -				  const unsigned char *new_data,
> -				  unsigned int new_len)
> -{
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> -	u32 len = tpm_buf_length(buf);
> -
> -	/* Return silently if overflow has already happened. */
> -	if (buf->flags & TPM_BUF_OVERFLOW)
> -		return;
> -
> -	if ((len + new_len) > PAGE_SIZE) {
> -		WARN(1, "tpm_buf: overflow\n");
> -		buf->flags |= TPM_BUF_OVERFLOW;
> -		return;
> -	}
> -
> -	memcpy(&buf->data[len], new_data, new_len);
> -	head->length = cpu_to_be32(len + new_len);
> -}
> -
> -static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
> -{
> -	tpm_buf_append(buf, &value, 1);
> -}
> -
> -static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
> -{
> -	__be16 value2 = cpu_to_be16(value);
> -
> -	tpm_buf_append(buf, (u8 *) &value2, 2);
> -}
> -
> -static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
> -{
> -	__be32 value2 = cpu_to_be32(value);
> -
> -	tpm_buf_append(buf, (u8 *) &value2, 4);
> -}
> -
> -static inline u32 tpm2_rc_value(u32 rc)
> -{
> -	return (rc & BIT(7)) ? rc & 0xff : rc;
> -}
> -
>  #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
>  
>  extern int tpm_is_tpm2(struct tpm_chip *chip);
> diff --git a/include/linux/tpm_buffer.h b/include/linux/tpm_buffer.h
> new file mode 100644
> index 000000000000..8144a52fbc0a
> --- /dev/null
> +++ b/include/linux/tpm_buffer.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2004,2007,2008 IBM Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + * Debora Velarde <dvelarde@us.ibm.com>
> + *
> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org
> + */
> +
> +#ifndef __LINUX_TPM_BUFFER_H__
> +#define __LINUX_TPM_BUFFER_H__
> +
> +struct tpm_header {
> +	__be16 tag;
> +	__be32 length;
> +	union {
> +		__be32 ordinal;
> +		__be32 return_code;
> +	};
> +} __packed;
> +
> +/* A string buffer type for constructing TPM commands. This is based on the
> + * ideas of string buffer code in security/keys/trusted.h but is heap based
> + * in order to keep the stack usage minimal.
> + */
> +
> +enum tpm_buf_flags {
> +	TPM_BUF_OVERFLOW	= BIT(0),
> +};
> +
> +struct tpm_buf {
> +	unsigned int flags;
> +	u8 *data;
> +};
> +
> +static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +
> +	head->tag = cpu_to_be16(tag);
> +	head->length = cpu_to_be32(sizeof(*head));
> +	head->ordinal = cpu_to_be32(ordinal);
> +}
> +
> +static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> +	if (!buf->data)
> +		return -ENOMEM;
> +
> +	buf->flags = 0;
> +	tpm_buf_reset(buf, tag, ordinal);
> +	return 0;
> +}
> +
> +static inline void tpm_buf_destroy(struct tpm_buf *buf)
> +{
> +	free_page((unsigned long)buf->data);
> +}
> +
> +static inline u32 tpm_buf_length(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +
> +	return be32_to_cpu(head->length);
> +}
> +
> +static inline u16 tpm_buf_tag(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +
> +	return be16_to_cpu(head->tag);
> +}
> +
> +static inline void tpm_buf_append(struct tpm_buf *buf,
> +				  const unsigned char *new_data,
> +				  unsigned int new_len)
> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +	u32 len = tpm_buf_length(buf);
> +
> +	/* Return silently if overflow has already happened. */
> +	if (buf->flags & TPM_BUF_OVERFLOW)
> +		return;
> +
> +	if ((len + new_len) > PAGE_SIZE) {
> +		WARN(1, "tpm_buf: overflow\n");
> +		buf->flags |= TPM_BUF_OVERFLOW;
> +		return;
> +	}
> +
> +	memcpy(&buf->data[len], new_data, new_len);
> +	head->length = cpu_to_be32(len + new_len);
> +}
> +
> +static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
> +{
> +	tpm_buf_append(buf, &value, 1);
> +}
> +
> +static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
> +{
> +	__be16 value2 = cpu_to_be16(value);
> +
> +	tpm_buf_append(buf, (u8 *) &value2, 2);
> +}
> +
> +static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
> +{
> +	__be32 value2 = cpu_to_be32(value);
> +
> +	tpm_buf_append(buf, (u8 *) &value2, 4);
> +}
> +
> +#endif
> diff --git a/include/linux/tpm_core.h b/include/linux/tpm_core.h
> new file mode 100644
> index 000000000000..292f96ae2ce4
> --- /dev/null
> +++ b/include/linux/tpm_core.h
> @@ -0,0 +1,185 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2004,2007,2008 IBM Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + * Debora Velarde <dvelarde@us.ibm.com>
> + *
> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org
> + */
> +#ifndef __LINUX_TPM_CORE_H__
> +#define __LINUX_TPM_CORE_H__
> +
> +#define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> +#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
> +
> +enum tpm_algorithms {
> +	TPM_ALG_ERROR		= 0x0000,
> +	TPM_ALG_SHA1		= 0x0004,
> +	TPM_ALG_KEYEDHASH	= 0x0008,
> +	TPM_ALG_SHA256		= 0x000B,
> +	TPM_ALG_SHA384		= 0x000C,
> +	TPM_ALG_SHA512		= 0x000D,
> +	TPM_ALG_NULL		= 0x0010,
> +	TPM_ALG_SM3_256		= 0x0012,
> +};
> +
> +struct tpm_digest {
> +	u16 alg_id;
> +	u8 digest[TPM_MAX_DIGEST_SIZE];
> +} __packed;
> +
> +struct tpm_bank_info {
> +	u16 alg_id;
> +	u16 digest_size;
> +	u16 crypto_id;
> +};
> +
> +enum TPM_OPS_FLAGS {
> +	TPM_OPS_AUTO_STARTUP = BIT(0),
> +};
> +
> +/* Indexes the duration array */
> +enum tpm_duration {
> +	TPM_SHORT = 0,
> +	TPM_MEDIUM = 1,
> +	TPM_LONG = 2,
> +	TPM_LONG_LONG = 3,
> +	TPM_UNDEFINED,
> +	TPM_NUM_DURATIONS = TPM_UNDEFINED,
> +};
> +
> +#define TPM_PPI_VERSION_LEN		3
> +
> +struct tpm_space {
> +	u32 context_tbl[3];
> +	u8 *context_buf;
> +	u32 session_tbl[3];
> +	u8 *session_buf;
> +	u32 buf_size;
> +};
> +
> +#define TPM_HEADER_SIZE		10
> +
> +enum tpm2_const {
> +	TPM2_PLATFORM_PCR       =     24,
> +	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
> +};
> +
> +enum tpm2_timeouts {
> +	TPM2_TIMEOUT_A          =    750,
> +	TPM2_TIMEOUT_B          =   2000,
> +	TPM2_TIMEOUT_C          =    200,
> +	TPM2_TIMEOUT_D          =     30,
> +	TPM2_DURATION_SHORT     =     20,
> +	TPM2_DURATION_MEDIUM    =    750,
> +	TPM2_DURATION_LONG      =   2000,
> +	TPM2_DURATION_LONG_LONG = 300000,
> +	TPM2_DURATION_DEFAULT   = 120000,
> +};
> +
> +enum tpm2_structures {
> +	TPM2_ST_NO_SESSIONS	= 0x8001,
> +	TPM2_ST_SESSIONS	= 0x8002,
> +};
> +
> +/* Indicates from what layer of the software stack the error comes from */
> +#define TSS2_RC_LAYER_SHIFT	 16
> +#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
> +
> +enum tpm2_return_codes {
> +	TPM2_RC_SUCCESS		= 0x0000,
> +	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
> +	TPM2_RC_HANDLE		= 0x008B,
> +	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
> +	TPM2_RC_FAILURE		= 0x0101,
> +	TPM2_RC_DISABLED	= 0x0120,
> +	TPM2_RC_COMMAND_CODE    = 0x0143,
> +	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
> +	TPM2_RC_REFERENCE_H0	= 0x0910,
> +	TPM2_RC_RETRY		= 0x0922,
> +};
> +
> +enum tpm2_command_codes {
> +	TPM2_CC_FIRST		        = 0x011F,
> +	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
> +	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
> +	TPM2_CC_CREATE_PRIMARY          = 0x0131,
> +	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
> +	TPM2_CC_SELF_TEST	        = 0x0143,
> +	TPM2_CC_STARTUP		        = 0x0144,
> +	TPM2_CC_SHUTDOWN	        = 0x0145,
> +	TPM2_CC_NV_READ                 = 0x014E,
> +	TPM2_CC_CREATE		        = 0x0153,
> +	TPM2_CC_LOAD		        = 0x0157,
> +	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
> +	TPM2_CC_UNSEAL		        = 0x015E,
> +	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
> +	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
> +	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
> +	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
> +	TPM2_CC_GET_CAPABILITY	        = 0x017A,
> +	TPM2_CC_GET_RANDOM	        = 0x017B,
> +	TPM2_CC_PCR_READ	        = 0x017E,
> +	TPM2_CC_PCR_EXTEND	        = 0x0182,
> +	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
> +	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
> +	TPM2_CC_CREATE_LOADED           = 0x0191,
> +	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
> +};
> +
> +enum tpm2_permanent_handles {
> +	TPM2_RS_PW		= 0x40000009,
> +};
> +
> +enum tpm2_capabilities {
> +	TPM2_CAP_HANDLES	= 1,
> +	TPM2_CAP_COMMANDS	= 2,
> +	TPM2_CAP_PCRS		= 5,
> +	TPM2_CAP_TPM_PROPERTIES = 6,
> +};
> +
> +enum tpm2_properties {
> +	TPM_PT_TOTAL_COMMANDS	= 0x0129,
> +};
> +
> +enum tpm2_startup_types {
> +	TPM2_SU_CLEAR	= 0x0000,
> +	TPM2_SU_STATE	= 0x0001,
> +};
> +
> +enum tpm2_cc_attrs {
> +	TPM2_CC_ATTR_CHANDLES	= 25,
> +	TPM2_CC_ATTR_RHANDLE	= 28,
> +};
> +
> +#define TPM_VID_INTEL    0x8086
> +#define TPM_VID_WINBOND  0x1050
> +#define TPM_VID_STM      0x104A
> +
> +enum tpm2_object_attributes {
> +	TPM2_OA_USER_WITH_AUTH		= BIT(6),
> +};
> +
> +enum tpm2_session_attributes {
> +	TPM2_SA_CONTINUE_SESSION	= BIT(0),
> +};
> +
> +struct tpm2_hash {
> +	unsigned int crypto_id;
> +	unsigned int tpm_id;
> +};
> +
> +static inline u32 tpm2_rc_value(u32 rc)
> +{
> +	return (rc & BIT(7)) ? rc & 0xff : rc;
> +}
> +
> +#endif
> -- 
> 2.11.0
> 

/Jarkko
